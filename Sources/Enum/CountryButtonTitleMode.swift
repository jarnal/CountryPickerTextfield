//
//  CountryButtonTitleMode.swift
//  CountryPickerTextfield
//
//  Created by Jonathan Arnal on 20/10/2018.
//

public enum CountryButtonTitleMode {
    
    case none
    case dial_code
    case iso_code
    case name
    
    /// Returns the correct title for a specific country
    ///
    /// - Parameter country: country for which a label is needed
    /// - Returns: label for the button
    func buildTitle(forCountry country: CountryCode) -> String? {
        switch self {
        case .none:
            return nil
        case .dial_code:
            return country.dial_code
        case .iso_code:
            return country.code
        case .name:
            return country.localizedName
        }
    }
}
