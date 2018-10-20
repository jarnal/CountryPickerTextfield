//
//  CountryCode.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 15/10/2018.
//

import UIKit

//****************************************************
// MARK: - CountryCode
//****************************************************
public class CountryCode: Codable {
    
    public var name: String!
    public var dial_code: String!
    public var code: String!
    
    /// Returns country corresponding flag
    var flag: UIImage? {
        guard let unwrappedCode = self.code else { return nil }
        
        return UIImage(named: unwrappedCode, in: Tools.bundle, compatibleWith: nil)
    }
    
    /// Returns the country translated in user locale language
    var localizedName: String? {
        return Locale.current.localizedString(forRegionCode: self.code) ?? nil
    }
}

extension CountryCode: CustomStringConvertible {
    
    public var description: String {
        return self.code
    }
    
}
