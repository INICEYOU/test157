//
//  HelpfulFunctions.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

struct HelpfulFunctions
{
    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    static func phoneNumber (from phone: String = "9876543210") -> String{
        //var phone = "9876543210" //"9876543210"
        let count = phone.characters.count
        let prefix = "+7"
        var prefix2 = ""
        var suffix1 = ""
        var suffix2 = ""
        var suffix3 = ""
        var phonePart1 = ""
        var phonePart2 = ""
        var phonePart3 = ""
        var phonePart4 = ""
        
        switch count {
        case 9,10,11:
            phonePart4 = phone.substring(with: phone.index(phone.startIndex,
                                                           offsetBy: 8 )
                ..<
                phone.index(phone.index(phone.startIndex, offsetBy: 8),
                            offsetBy: count < 10  ? count - 8 : 2 )
            )
            suffix3 = "-"
            fallthrough
        case 7,8:
            suffix2 = "-"
            phonePart3 = phone.substring(with: phone.index(phone.startIndex,
                                                           offsetBy: 6 )
                ..<
                phone.index(phone.index(phone.startIndex, offsetBy: 6),
                            offsetBy: count < 8  ? count - 6 : 2 )
            )
            fallthrough
        case 4,5,6,7,8:
            suffix1 = ") "
            phonePart2 = phone.substring(with: phone.index(phone.startIndex,
                                                           offsetBy: 3 )
                ..<
                phone.index(phone.index(phone.startIndex, offsetBy: 3),
                            offsetBy: count < 6  ? count - 3 : 3 )
            )
            fallthrough
        case 1,2,3:
            prefix2 = " ("
            phonePart1 = phone.substring(to:
                phone.index(phone.startIndex,
                            offsetBy: count < 3  ? count : 3 ))
            
        case 0:
            return ""
        default:
            break
        }
        
        return prefix + prefix2 + phonePart1 + suffix1 + phonePart2 + suffix2 + phonePart3 + suffix3 + phonePart4
    }
    
    static func cleanPhoneNumber (_ string: String) -> String
    {
        var result = ""
        result = string.replacingOccurrences(of: "-", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "+7", with: "")
        result = result.replacingOccurrences(of: "+", with: "")
        result = result.replacingOccurrences(of: " ", with: "")
        return result
    }
}
