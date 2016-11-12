//
//  Car.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class Car
{
    var vin: String = ""
    var year: String = ""
    var city = ListObject()
    var showRoom = ListObject()
    var clas = ListObject()
    
    func validate () -> (isValid : Bool, incorrectLabels: [String]) {
        var isValid = true
        var incorrectLabels = [String]()
        
        if city.name == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.city)
        }
        
        if vin.characters.count != Constants.VINNumberLimit {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.vin)
        }
        
        if year == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.year)
        }
        
        if clas.id == 0 {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.classId)
        }
        
        if showRoom.id == 0 {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.showRoomId)
        }
        
        if city.name == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.Car.city)
        }
        
        return (isValid, incorrectLabels)
    }
}
