//
//  ViewController.swift
//  CountryPickerTextField-Example
//
//  Created by Jonathan Arnal on 17/10/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import CountryPickerTextfield

class ViewController: UIViewController {

    lazy var textField: CountryPickerTextField = {
        return CountryPickerTextField(forceRegionTo: nil)
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        
        textField.borderStyle = .roundedRect
        
        self.view.addSubview(textField)
        
//        textField.include(countryCodes: ["ES", "FR", "DE"])
//        textField.exclude(countryCodes: ["AF"])
        textField.prioritize(countryCodes: ["ES", "DE"])
        
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}

