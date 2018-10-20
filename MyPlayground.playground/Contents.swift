//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SnapKit
import CountryPickerTextFieldFramework

class ContainerView: UIViewController {
    
    lazy var textField: CountryPickerTextField = {
        return CountryPickerTextField(forceRegionTo: "ES", buttonTitleMode: .name)
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.view.addSubview(textField)
        
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        textField.text = " "
    }
}

let containerView = ContainerView()
containerView.preferredContentSize = CGSize(width: 300, height: 500)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = containerView
