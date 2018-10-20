//
//  CountryPickerTextfield.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 15/10/2018.
//

import UIKit

open class CountryPickerTextField: UITextField, CountryContextable {
    
    //****************************************************
    // MARK: - Country Contextable Variables Conformance
    //****************************************************
    
    // If the textfield has a previous input accessory view, it will here
    public var previousInputAccessoryView: UIView?
    
    // TextField custom left view
    public var countryLeftView: CountryLeftView!
    
    //****************************************************
    // MARK: - Country Contextable Initialization Conformance
    //****************************************************
    
    public required convenience init(forceRegionTo region: String?, buttonTitleMode: CountryButtonTitleMode) {
        self.init(frame: CGRect.zero)
        self.countryLeftView = buildCountryLeftView(forceRegionTo: region, buttonTitleMode: buttonTitleMode)
        setupUI()
    }
    
    //****************************************************
    // MARK: - Country Contextable Boilerplate
    //****************************************************
    
    open override var inputAccessoryView: UIView? {
        didSet {
            if countryLeftView.isCountryToolbar(thisAccessoryView: inputAccessoryView) == false {
                previousInputAccessoryView = inputAccessoryView
            }
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
        self.userDidChangeInputMode(inputView: nil, inputAccessoryView: nil)
        self.becomeFirstResponder()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        countryLeftView.frame = CGRect(x: 0, y: 0, width: leftViewMinSize.width, height: self.bounds.height)
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: leftViewMinSize.width, height: self.bounds.height)
    }
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        return inputAccessoryView == nil ? super.caretRect(for: position) : CGRect.zero
    }
    
}
