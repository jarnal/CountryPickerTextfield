//
//  CountriesLoader.swift
//  CountryPickerTextfield
//
//  Created by Jonathan Arnal on 20/10/2018.
//

import Foundation

class CountriesHandler {
    
    //****************************************************
    // MARK: - Singleton Stack
    //****************************************************
    
    static let shared = CountriesHandler()
    private init(){}
    
    //****************************************************
    // MARK: - Public API
    //****************************************************
    
    // ⬆️ List of countries retrieved from JSON resource
    public lazy var countries: [CountryCode] = {
        
        guard
            let jsonURL = Tools.bundle.url(forResource: "countryCodes", withExtension: "json"),
            let data = try? Data(contentsOf: jsonURL)
        else { fatalError("No json available") }
        
        let countries = try! JSONDecoder().decode([CountryCode].self, from: data)
        
        return countries
    }()
    
    /// ⬆️ Returns a default country is no one has been defined
    public lazy var defaultCountry: CountryCode = {
        guard let userCountry = self.userCountry else { return countries.first! }
        return userCountry
    }()
    
    /// ⬆️ Returns the current user country
    public lazy var userCountry: CountryCode? = {
        
        guard
            let currentRegion = Locale.current.regionCode,
            let currentCountry = self.getCountry(withCode: currentRegion)
        else { return nil }
        
        return currentCountry
    }()
    
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
        return countries.filter { return $0.dial_code == code }.first
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
    /// - Parameter countries: countries to prioritize
    public func prioritize(countryCodes: [String]) {
        
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
