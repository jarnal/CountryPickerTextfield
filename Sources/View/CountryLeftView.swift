//
//  CountryLeftView.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 17/10/2018.
//

import UIKit
import SnapKit

@IBDesignable
open class CountryLeftView: UIView, CountriesDependent {
    
    //****************************************************
    // MARK: - Initialiaztion
    //****************************************************
    
    public required convenience init(forceRegionTo region: String?, buttonTitleMode: CountryButtonTitleMode = .none) {
        self.init(frame: CGRect.zero)
        self.countryButtonTitleModel = buttonTitleMode
        initialize(withRegion: region)
    }
    
    //****************************************************
    // MARK: - Public Variables
    //****************************************************
    
    @IBInspectable
    open var buttonTextColor: UIColor? = UIColor.black {
        didSet {
            updateCountryButton()
        }
    }
    
    weak var delegate: CountryLeftViewDelegate?
    
    open var selectedCountry: CountryCode?
    
    open var toolbarTintColor: UIColor? = UIColor.red
    
    lazy public var countries: [CountryCode] = {
        return _countries
    }()
    
    public var leftViewMinSize: CGSize {
        
        var minSize = countryButton.sizeThatFits( CGSize.init(width: Double.infinity , height: Double.infinity) )
        minSize.width = minSize.width.advanced(by: 15)
        return minSize
    }
    
    //****************************************************
    // MARK: - Private Variables
    //****************************************************
    
    private var countryButtonTitleModel: CountryButtonTitleMode!
    
    private lazy var userCountry: CountryCode? = {
        
        guard
            let currentRegion = Locale.current.regionCode,
            let currentCountry = self.getCountry(withCode: currentRegion)
        else { return nil }
        
        return currentCountry
    }()
    
    private var isPickingCountry = false {
        didSet {
            if isPickingCountry {
                delegate?.userDidChangeInputMode(inputView: pickerView, inputAccessoryView: toolbar)
            } else {
                delegate?.userDidChangeInputMode(inputView: nil, inputAccessoryView: nil)
            }
        }
    }
    
    //****************************************************
    // MARK: - Outlets
    //****************************************************
    
    /// Button set inside left view allowing to show picker view
    private lazy var countryButton: UIButton! = {
        
        let countryButton = UIButton()
        countryButton.setTitleColor(UIColor.black, for: .normal)
        countryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        countryButton.titleEdgeInsets = UIEdgeInsets(top: 1.25, left: 0, bottom: 1.25, right: 0)
        countryButton.addTarget(self, action: #selector( displayCountryPicker ), for: .touchUpInside)
        return countryButton
    }()
    
    /// TextField custom left view
    private lazy var countryLeftView: UIView! = {
        return UIView(frame: CGRect(x: 0, y: 0, width: leftViewMinSize.width, height: self.bounds.height) )
    }()
    
    /// Flag picker view
    private lazy var pickerView: UIPickerView! = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        return pickerView
    }()
    
    /// Toolbar set at the top of pickerview
    private lazy var toolbar: UIToolbar! = {
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = toolbarTintColor
        toolbar.sizeToFit()
        
        // Adding Button ToolBar
        
        var buttons = [UIBarButtonItem]()
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector( showSearchController ))
        searchButton.tintColor = toolbarTintColor
        buttons.append(searchButton)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        buttons.append(spaceButton)
        
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector( didFinishPickingCountry ))
        doneButton.tintColor = toolbarTintColor
        buttons.append(doneButton)
        
        toolbar.setItems(buttons, animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    //****************************************************
    // MARK: - Initialization
    //****************************************************
    
    /// 🔥 Initializes the textfield
    ///
    /// - Parameter region: specific region to use
    private func initialize(withRegion region: String?) {
        
        if let unwrappedRegion = region, let country = self.getCountry(withCode: unwrappedRegion) {
            updateCountry(country)
        } else {
            let country = userCountry ?? countries.first!
            updateCountry(country)
        }
        
        setupUI()
    }
    
    //****************************************************
    // MARK: - Business
    //****************************************************
    
    /// 🔄 Updates the current selected country
    ///
    /// - Parameter country: country
    open func updateCountry(_ country: CountryCode) {
        
        selectedCountry = country
        if superview != nil {
            updateCountryButton()
        }
    }
    
    /// ❓ Defines if the view passed in parameter is the toolbar
    ///
    /// - Parameter view: view to compare
    /// - Returns: if the view is the toolbar
    public func isCountryToolbar(thisAccessoryView view: UIView?) -> Bool {
        return view == self.toolbar
    }
    
    //****************************************************
    // MARK: - User Interface
    //****************************************************
    
    /// 🚧 Setup all user interface
    private func setupUI() {
        
        self.addSubview( countryButton )
        countryButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview().offset(-0.5)
        }
        
        updateCountryButton()
    }
    
    /// 🔄 Update the coutry button with the new selected country
    private func updateCountryButton() {
        
        guard
            let currentCountry = selectedCountry,
            let countryImage = currentCountry.flag
        else { fatalError("No country found") }
        
        countryButton.setImage(countryImage, for: .normal)
        
        if let title = countryButtonTitleModel.buildTitle(forCountry: currentCountry) {
            updateCountryButtonTitle(withString: title)
        }
        setNeedsLayout()
    }
    
    /// Update country button label with a specific string
    ///
    /// - Parameter string: title string
    private func updateCountryButtonTitle(withString string: String) {
        
        let myAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: buttonTextColor ?? UIColor.black
        ]
        let myAttrString = NSAttributedString(string: string, attributes: myAttribute)
        
        countryButton.setAttributedTitle(myAttrString, for: .normal)
    }
    
    //****************************************************
    // MARK: - User Interaction
    //****************************************************
    
    /// 👆 Displays the country picker
    @objc private func displayCountryPicker() {
        
        isPickingCountry = true
        if let index = countries.firstIndex(where: {$0.code == selectedCountry?.code}) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        delegate?.didStartPickingCountry()
    }
    
    /// 👆 Handles when the user has finished picking a country
    @objc private func didFinishPickingCountry() {
        isPickingCountry = false
        
        delegate?.didEndPickingCountry()
    }
    
    /// 👆 Show search controller
    @objc private func showSearchController() {
        
        let searchViewControler = CountrySearchViewController(nibName: nil, bundle: nil)
        searchViewControler.delegate = self
        searchViewControler.show()
    }
    
}

extension CountryLeftView: CountrySearchViewControllerDelegate {
    
    /// 👂 Handles when user has selected a new country
    ///
    /// - Parameter country: new selected country
    func didSelectCountry(_ country: CountryCode) {
        isPickingCountry = false
        updateCountry(country)
        
        delegate?.didEndPickingCountry()
    }
    
}

extension CountryLeftView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let country = countries[row]
        let view = CountryPickerView(withCountry: country)
        return view
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let country = countries[row]
        updateCountry(country)
        delegate?.didSelectCountry(country)
    }
    
}

extension CountryLeftView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
}
