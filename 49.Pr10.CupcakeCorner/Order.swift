//
//  Order.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {  //включен специальный запрос
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false           //дополнительная глазурь
    var addSprinkles = false            //добавьте посыпку
    
    //данные получателя (в случае оформления доставки)
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""                        //индекс
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
}
