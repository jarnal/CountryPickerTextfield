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
    
    var countries: [CountryCode]! { get set }
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    func getCountry(withCode code: String) -> CountryCode?
    func getCountry(withDialCode code: String) -> CountryCode?
}

public extension CountriesDependent {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    // List of countries retrieved from JSON resource
    var _countries: [CountryCode] {
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
        return countries.filter { return $0.code == code }.first
    }
    
    /// ⬆️ Return a country depending on a dial code in UInt64 format
    ///
    /// - Parameter code: dial code (+33, +41)
    /// - Returns: corresponding country model
    public func getCountry(withUIntDialCode code: UInt64) -> CountryCode? {
        let stringCode = "+\(code)"
        return self.getCountry(withDialCode: stringCode)
    }
    
    /// ⬆️ Return a country depending on a dial code in String format
    ///
    /// - Parameter code: dial code (+33, +41)
    /// - Returns: corresponding country model
    public func getCountry(withDialCode code: String) -> CountryCode? {
        return _countries.filter { return $0.dial_code == code }.first
    }
    
    /// Exclude countries from country list
    ///
    /// - Parameter countries: coutries to exclude
    public func exclude(countryCodes: [String]) {
        self.countries = self.countries.filter { !countryCodes.contains($0.code) }
    }
    
    /// Include countries into country list
    ///
    /// - Parameter countries: countries to include
    public func include(countryCodes: [String]) {
        self.countries = self.countries.filter { countryCodes.contains($0.code) }
    }
    
    /// Set a list of countries on top of the list
    ///
    /// - Parameter countries: countries to priorize
    public func priorize(countryCodes: [String]) {
        
        var priorities: [(Int, CountryCode)] = []
        priorities.reserveCapacity(countryCodes.count)
        for (_, country) in countries.enumerated() {
            if let index = countryCodes.firstIndex(of: country.code) {
                priorities.append( (index, country) )
            }
        }
        
        let cleanArray = countries.filter { !countryCodes.contains($0.code) }
        let prioritiesArray = priorities.sorted(by: { (left, right) in return left.0 > right.0 }).map({ return $0.1 }).reversed()
        let finalArray = prioritiesArray + cleanArray
        
        self.countries = finalArray
    }
    
}
