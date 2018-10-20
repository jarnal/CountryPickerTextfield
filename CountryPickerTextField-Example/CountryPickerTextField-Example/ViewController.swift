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
        return CountryPickerTextField(forceRegionTo: "FR")
    }()
    
    lazy var button: UIButton = {

        let button = UIButton()
        button.setTitle("Test4", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector( didUpdate ), for: .touchUpInside)

        return button
    }()
    
    @objc func didUpdate() {
        print("")
        textField.resignFirstResponder()
        textField.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        let textField = CountryPickerTextField(forceRegionTo: "FR")
        textField.borderStyle = .roundedRect
        
        self.view.addSubview(textField)
        self.view.addSubview(button)
        
        
        
        textField.backgroundColor = UIColor.white
        //        textField.buttonTextColor = UIColor.black
        textField.borderStyle = .roundedRect
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.textField.text = "+41 333333333"
    }
}

