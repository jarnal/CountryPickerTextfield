//
//  CountryPickerTextfield.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 15/10/2018.
//

import UIKit

@IBDesignable
open class CountryPickerTextField: UITextField, CountryContextable {
    
    //****************************************************
    // MARK: - Country Contextable Variables Conformance
    //****************************************************
    
    // If the textfield has a previous input accessory view, it will here
    public var previousInputAccessoryView: UIView?
    
    // TextField custom left view
    public var countryLeftView: CountryLeftView?
    
    // Delegate
    public weak var countryEventDelegate: CountryContextableDelegate?
    
    //****************************************************
    // MARK: - Country Contextable Initialization Conformance
    //****************************************************
    
    public required convenience init(forceRegionTo region: String?, buttonTitleMode: CountryButtonTitleMode = .none) {
        self.init(frame: CGRect.zero)
        self.countryLeftView = buildCountryLeftView(forceRegionTo: region, buttonTitleMode: buttonTitleMode)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.countryLeftView = buildCountryLeftView(forceRegionTo: nil, buttonTitleMode: .none)
        setupUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.countryLeftView = buildCountryLeftView(forceRegionTo: nil, buttonTitleMode: .none)
        setupUI()
    }
    
    //****************************************************
    // MARK: - Country Contextable Boilerplate
    //****************************************************
    
    @IBInspectable
    open var buttonTextColor: UIColor? = UIColor.black {
        didSet {
            countryLeftView?.buttonTextColor = buttonTextColor
        }
    }
    
    @IBInspectable
    open var toolbarTintColor: UIColor? = UIColor.red {
        didSet {
            countryLeftView?.toolbarTintColor = toolbarTintColor
        }
    }
    
    open override var inputAccessoryView: UIView? {
        didSet {
            if countryLeftView?.isCountryToolbar(thisAccessoryView: inputAccessoryView) == false {
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
        guard let unwrappedCountryLeftView = countryLeftView else {return}
        unwrappedCountryLeftView.frame = CGRect(x: 0, y: 0, width: leftViewMinSize.width, height: self.bounds.height)
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: leftViewMinSize.width, height: self.bounds.height)
    }
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        return countryLeftView?.isCountryToolbar(thisAccessoryView: inputAccessoryView) == false ? super.caretRect(for: position) : CGRect.zero
    }
    
}
