//
//  CheckoutView.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 30.06.2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    //переменные для алерта с подтверждением успешного оформления заказа
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    //перменные для алерта при неудачной попытке оформления заказа
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        //если мы получили от сервера reqres то, что отправили, то будем считать заказ принятым
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Ошибка обмена информацией с сервером", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return 
        }
        
        //отправим данные на сайт reqres, который отправляет то, что получает
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key") // Добавляем API ключ
        //request.httpMethod = "POST" //для отправки данных лучше использовать метод POST, чем GET
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Логируем полученный ответ
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
            }
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true  //покажем алерт с сообщением "Thank you!"
        } catch {
            errorMessage = "Ошибка при оформлении заказа: \(error.localizedDescription)"
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
