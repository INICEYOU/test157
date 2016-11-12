//
//  Order.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class Order : NSObject, NSCoding
{
    var user = User()
    var car = Car()
    
    func validate () -> (isValid : Bool, incorrectLabels: [String]) {
        var isValid = true
        var incorrectLabels = [String]()
        
        let userValidation = user.validate()
        let carValidation = car.validate()
        
        isValid = userValidation.isValid && carValidation.isValid
        incorrectLabels = userValidation.incorrectLabels + carValidation.incorrectLabels
        
        return (isValid, incorrectLabels)
    }
    
    override init () {
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.user.firstName = decoder.decodeObject(forKey: "firstName") as! String
        self.user.lastName = decoder.decodeObject(forKey: "lastName") as! String
        self.user.middleName = decoder.decodeObject(forKey: "middleName") as! String
        self.user.phone = decoder.decodeObject(forKey: "phone") as! String
        self.user.email = decoder.decodeObject(forKey: "email") as! String
        self.user.gender = Int(decoder.decodeObject(forKey: "gender") as! String)!
        self.car.city.name = decoder.decodeObject(forKey: "cityName") as! String
        self.car.city.id = Int(decoder.decodeObject(forKey: "cityId") as! String)!
        self.car.clas.id = Int(decoder.decodeObject(forKey: "classId") as! String)!
        self.car.clas.name = decoder.decodeObject(forKey: "clasName") as! String
        self.car.showRoom.id = Int(decoder.decodeObject(forKey: "showRoomId") as! String)!
        self.car.showRoom.name = decoder.decodeObject(forKey: "showRoomName") as! String
        self.car.vin = decoder.decodeObject(forKey: "vin") as! String
        self.car.year = decoder.decodeObject(forKey: "year") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user.email, forKey: "email")
        aCoder.encode(user.firstName, forKey: "firstName")
        aCoder.encode("\(user.gender)", forKey: "gender")
        aCoder.encode(user.lastName, forKey: "lastName")
        aCoder.encode(user.middleName, forKey: "middleName")
        aCoder.encode(user.phone, forKey: "phone")
        aCoder.encode(car.city.name, forKey: "cityName")
        aCoder.encode("\(car.city.id)", forKey: "cityId")
        aCoder.encode("\(car.clas.id)", forKey: "classId")
        aCoder.encode(car.clas.name, forKey: "clasName")
        aCoder.encode("\(car.showRoom.id)", forKey: "showRoomId")
        aCoder.encode(car.showRoom.name, forKey: "showRoomName")
        aCoder.encode(car.vin, forKey: "vin")
        aCoder.encode(car.year, forKey: "year")
    }
    
    let userLabels = [ Localization.Label.User.gender,
                       Localization.Label.User.lastName,
                       Localization.Label.User.firstName,
                       Localization.Label.User.middleName,
                       Localization.Label.User.phone,
                       Localization.Label.User.email
    ]
    
    let carLabels = [ Localization.Label.Car.vin,
                      Localization.Label.Car.year,
                      Localization.Label.Car.classId,
                      Localization.Label.Car.city,
                      Localization.Label.Car.showRoomId
    ]
    
    let userPlaceHolders = [Localization.PlaceHolder.User.gender ,
                            Localization.PlaceHolder.User.lastName ,
                            Localization.PlaceHolder.User.firstName,
                            Localization.PlaceHolder.User.middleName,
                            Localization.PlaceHolder.User.phone,
                            Localization.PlaceHolder.User.email
    ]
    
    let carPlaceHolders = [Localization.PlaceHolder.Car.vin,
                           Localization.PlaceHolder.Car.year,
                           Localization.PlaceHolder.Car.classId,
                           Localization.PlaceHolder.Car.city,
                           Localization.PlaceHolder.Car.showRoomId
    ]
    
    var labels: [String] {
        return userLabels + carLabels
    }
    
    var placeHolders: [String] {
        return userPlaceHolders + carPlaceHolders
    }
    
    func labelsAndPlaceHolders() -> [String : String] {
        var result = [String : String]()
        result = Dictionary(keys: labels ,values: placeHolders)
        return result
    }
    
    // need add City too
//    var jsonObjectTest : Data? {
//        
//        var dict = [String : Any]()
//        dict["Gender"] = 1
//        dict["LastName"] = "Doe"
//        dict["FirstName"] = "John"
//        dict["MiddleName"] = "Ave"
//        dict["Email"] = "john.ave.doe@never.land"
//        dict["Phone"] = "+7 (800) 200-06-00"
//        dict["Vin"] = "WDB2105812X020118" // change everytime
//        dict["Year"] = "2007"
//        dict["ClassId"] = 8
//        dict["ShowRoomId"] = 31
//        dict["City"] = "Moscow"
//        
//        if JSONSerialization.isValidJSONObject(dict) {
//            return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        } else {
//            print( "JSONObject  is Invalid)" )
//        }
//        return nil
//    }
    
    var jsonObject : Data? {
        
        var dict = [String : Any]()
        dict["Gender"] = user.gender
        dict["LastName"] = user.lastName 
        dict["FirstName"] = user.firstName
        dict["MiddleName"] = user.middleName
        dict["Email"] = user.email
        dict["Phone"] = user.phone
        dict["Vin"] = car.vin
        dict["Year"] = car.year
        dict["ClassId"] = car.clas.id
        dict["ShowRoomId"] = car.showRoom.id
        dict["City"] = car.city.name
        
        if JSONSerialization.isValidJSONObject(dict) {
            return try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        } else {
            print( "JSONObject  is Invalid" )
        }
        return nil
    }
}
