//
//  CountryContextable.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 17/10/2018.
//

import UIKit
import SnapKit

public protocol CountryContextable: CountryLeftViewDelegate {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    var previousInputAccessoryView: UIView? { get set }
    var countryLeftView: CountryLeftView! { get }
    var selectedCountry: CountryCode? { get }
    
    //****************************************************
    // MARK: - Initialization
    //****************************************************
    
    init(forceRegionTo region: String?)
}

public extension CountryContextable where Self: UITextField {
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    /// Returns the minimum necessary width for left view
    var leftViewMinSize: CGSize {
        return countryLeftView.leftViewMinSize
    }
    
    /// Returns left view selected country
    var selectedCountry: CountryCode? {
        return countryLeftView.selectedCountry
    }
    
    //****************************************************
    // MARK: - User Interface
    //****************************************************
    
    /// 🚧 Setup all UI elements
    func setupUI() {
        self.inputAssistantItem.leadingBarButtonGroups.removeAll()
        self.inputAssistantItem.trailingBarButtonGroups.removeAll()
        self.font = UIFont.systemFont(ofSize: 14)
        
        setupCountryLeftView()
    }
    
    /// Defines left view as the textfield 'leftview'
    func setupCountryLeftView() {
        self.leftView = countryLeftView
        self.leftViewMode = .always
    }
    
    ///  🚧 Build left view
    ///
    /// - Returns: left view
    func buildCountryLeftView(forceRegionTo region: String?, needsDialCode: Bool = false) -> CountryLeftView! {
        let view = CountryLeftView(forceRegionTo: region, needsDialCode: needsDialCode)
        view.delegate = self
        return view
    }
    
    //****************************************************
    // MARK: - User Interaction
    //****************************************************
    
    /// 👂 Handles when the input mode has been changed in left view (the user started/ended picking country)
    ///
    /// - Parameters:
    ///   - inputView: textfield input view
    ///   - inputAccessoryView: textfield input accessory view
    func userDidChangeInputMode(inputView: UIView?, inputAccessoryView: UIView?) {
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
        
        self.inputView = inputView
        self.inputAccessoryView = inputAccessoryView ?? previousInputAccessoryView
    }
    
    /// 👆 Handles when user has started picking country
    func didStartPickingCountry(){
        becomeFirstResponder()
    }
    
    /// 👆 Handles when user has ended picking country
    func didEndPickingCountry(){
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
    }
    
    /// 👆 Handles when the user has selected a country
    ///
    /// - Parameter country: country selected by user
    func didSelectCountry(_ country: CountryCode) {
        self.text = self.text
        setNeedsLayout()
    }
}
