//
//  Model.swift
//  InAppTutorial
//
//  Created by futurino on 17.02.2021.
//

import Foundation


struct Product {
    var id : String
    var title : String
    var description : String
    var price : String
    var img: String
}

class Serkan : NSObject {
    
    static func serkan() -> String{
        
        return "serkan"
    }
}
