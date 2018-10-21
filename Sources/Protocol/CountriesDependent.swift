//
//  CountriesDependent.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 15/10/2018.
//

import UIKit

//****************************************************
// MARK: - CountriesDependent
//****************************************************
public protocol CountriesDependent: class {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    var countries: [CountryCode] { get }
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    func getCountry(withCode code: String) -> CountryCode?
    func getCountry(withDialCode code: String) -> CountryCode?
    func getCountry(withUIntDialCode code: UInt64) -> CountryCode?
}

public extension CountriesDependent {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    // List of countries
    public var countries: [CountryCode] {
        return CountriesHandler.shared.countries
    }
    
    //****************************************************
    // MARK: - Public API
    //****************************************************
    
    /// ⬆️ Return a country depending on an ISO formatted code
    ///
    /// - Parameter code: ISO code (FR, CH, ES...)
    /// - Returns: corresponding country model
    public func getCountry(withCode code: String) -> CountryCode? {
        return CountriesHandler.shared.getCountry(withCode: code)
    }
    
    /// ⬆️ Return a country depending on a dial code in UInt64 format
    ///
    /// - Parameter code: dial code (+33, +41)
    /// - Returns: corresponding country model
    public func getCountry(withUIntDialCode code: UInt64) -> CountryCode? {
        return CountriesHandler.shared.getCountry(withUIntDialCode: code)
    }
    
    /// ⬆️ Return a country depending on a dial code in String format
    ///
    /// - Parameter code: dial code (+33, +41)
    /// - Returns: corresponding country model
    public func getCountry(withDialCode code: String) -> CountryCode? {
        return CountriesHandler.shared.getCountry(withDialCode: code)
    }
    
}
