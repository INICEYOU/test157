//
//  User.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class User
{
    var gender: Int = Gender.Male.rawValue
    var firstName: String = ""
    var lastName: String = ""
    var middleName: String = ""
    var email: String = ""
    var phone: String = ""
    
    enum Gender: Int {
        case Male = 1
        case Female = 2
    }
    
    // validate user information
    
    func validate () -> (isValid : Bool, incorrectLabels: [String]) {
        var isValid = true
        var incorrectLabels = [String]()
        
        if firstName == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.User.firstName)
        }
        
        if lastName == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.User.lastName)
        }
        
        if middleName == "" {
            isValid = false
            incorrectLabels.append(Localization.Label.User.middleName)
        }

        if !HelpfulFunctions.isValidEmail(testStr: email)  {
            isValid = false
            incorrectLabels.append(Localization.Label.User.email)
        }
        
        if phone.characters.count != Constants.PhoneNumberLimit { // phone == "" || phone == "+7" ||
            isValid = false
            incorrectLabels.append(Localization.Label.User.phone)
        }
        
        return (isValid, incorrectLabels)
    }
}



