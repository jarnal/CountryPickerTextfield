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
public protocol CountriesDependent {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    var countries: [CountryCode] { get }
    var priorityCountries: [String] { get }
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    func getCountry(withCode code: String) -> CountryCode?
    func getCountry(withDialCode code: String) -> CountryCode?
}

public extension CountriesDependent {
    
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
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    // List of countries retrieved from JSON resource
    var _countries: [CountryCode] {
        
        guard
            let jsonURL = Tools.bundle.url(forResource: "countryCodes", withExtension: "json"),
            let data = try? Data(contentsOf: jsonURL)
        else { fatalError("No json available") }
        
        let countries = try! JSONDecoder().decode([CountryCode].self, from: data)
        
        if priorityCountries.isEmpty == false {
            return setPriorities(forCountriesWithCode: priorityCountries, intoCountries: countries)
        }
        return countries
    }
    
    /// Country that needs to be on top of the list
    var priorityCountries: [String] {
        return ["FR", "CH"]
    }
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    /// ⬆️ Return a country depending on a dial code in String format
    ///
    /// - Parameter code: dial code (+33, +41)
    /// - Returns: corresponding country model
    func getCountry(withDialCode code: String) -> CountryCode? {
        return _countries.filter { return $0.dial_code == code }.first
    }
    
    /// Set priorities for the list of ISO codes passed in parameters into a specific countries list
    ///
    /// - Parameters:
    ///   - codes: list of codes that needs to be on top of the countries list
    ///   - countries: countries that needs to be priorized
    /// - Returns: return the countries with priorities set
    private func setPriorities(forCountriesWithCode codes: [String], intoCountries countries: [CountryCode]) -> [CountryCode] {
        
        var priorities: [(Int, CountryCode)] = []
        priorities.reserveCapacity(3)
        for (_, country) in countries.enumerated() {
            if let index = codes.firstIndex(of: country.code) {
                priorities.append( (index, country) )
            }
        }
        
        let cleanArray = countries.filter { !codes.contains($0.code) }
        let prioritiesArray = priorities.sorted(by: { (left, right) in return left.0 > right.0 }).map({ return $0.1 }).reversed()
        let finalArray = prioritiesArray + cleanArray
        
        return finalArray
    }
}
