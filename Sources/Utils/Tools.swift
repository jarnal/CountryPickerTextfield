//
//  Tools.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 15/10/2018.
//

import Foundation

public class Tools {
    
    static var bundle: Bundle {
        
        let bundle = Bundle(for: Tools.self)
        
        if let path = bundle.path(forResource: "UniversalPhoneNumberKit", ofType: "bundle") {
            return Bundle(path: path)!
        } else {
            return bundle
        }
    }
    
    static var userRegionCode: String? {
        return Locale.current.regionCode
    }
    
}
