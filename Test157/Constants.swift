//
//  Constants.swift
//  Test157
//
//  Created by Andrey on 07.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import UIKit

struct Storyboard {
    struct CellId {
        static let TextInput = "TextInputId"
        static let Segment = "SegmentId"
        static let Detail = "DetailId"
        static let Detail2 = "Detail2Id"
    }
    
    struct Segue {
        static let Detail = "DetailSegue"
        static let UnwindToRoot = "unwindToRootSegue"
    }
}

struct Constants {
    static let VINNumberLimit = 17
    static let PhoneNumberLimit = 18
    
    struct ActivityColor
    {
        static let Active = UIColor.white
        static let Inactive = UIColor.gray
        static let Empty = UIColor.red
    }
}
