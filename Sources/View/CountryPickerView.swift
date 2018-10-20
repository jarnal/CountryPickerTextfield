//
//  CountryPickerView.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 16/10/2018.
//

import UIKit
import SnapKit

class CountryPickerView: UIView {
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    var country: CountryCode!
    
    //****************************************************
    // MARK: - Life Cycle
    //****************************************************
    
    /// Initialize view with a specific country
    ///
    /// - Parameter country: country
    convenience init(withCountry country: CountryCode) {
        self.init()
        self.country = country
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    //****************************************************
    // MARK: - Outlets
    //****************************************************
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = country.localizedName
        return label
    }()
    
    lazy var dialCodeLabel: UILabel = {
        let label = UILabel()
        label.text = country.dial_code
        return label
    }()
    
    lazy var flagImageView: UIImageView = {
        return UIImageView(image: country.flag)
    }()
    
    //****************************************************
    // MARK: - User Interface
    //****************************************************
    
    /// 🚧 Setup all UI elements
    private func setupUI() {
        
        self.addSubview(flagImageView)
        self.addSubview(nameLabel)
        self.addSubview(dialCodeLabel)
        
        flagImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo( CGSize(width: 21, height: 16) )
            make.left.equalToSuperview().offset(15)
        }
        
        dialCodeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(flagImageView.snp.right).offset(10)
            make.right.equalTo(dialCodeLabel).offset(10)
        }
    }
    
}
