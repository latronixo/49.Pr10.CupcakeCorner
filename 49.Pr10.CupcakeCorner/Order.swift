//
//  Order.swift
//  49.Pr10.CupcakeCorner
//
//  Created by Валентин on 27.06.2025.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
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
    
    var cost: Decimal {
        // $2 за пирожное
        var cost = Decimal(quantity * 2)
        
        //каждый последующий тип пирожного (в массиве) стоит дороже
        cost += Decimal(type) / 2
        
        //за доп.глазурь $1
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        //за посыпку 50 центов
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
