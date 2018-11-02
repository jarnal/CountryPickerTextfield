//
//  CountryContextableDelegate.swift
//  CountryPickerTextfield
//
//  Created by Jonathan Arnal on 30/10/2018.
//  Copyright © 2018 nouveal. All rights reserved.
//

import Foundation

public protocol CountryContextableDelegate: class {
    func didSelectCountry(_ country: CountryCode)
}
