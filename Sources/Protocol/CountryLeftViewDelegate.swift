//
//  CountryLeftViewDelegate.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 17/10/2018.
//

import UIKit

public protocol CountryLeftViewDelegate: class {
    
    func didStartPickingCountry()
    func didEndPickingCountry()
    func didSelectCountry(_ country: CountryCode)
    func userDidChangeInputMode(inputView: UIView?, inputAccessoryView: UIView?)
}
