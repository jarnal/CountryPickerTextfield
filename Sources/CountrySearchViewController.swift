//
//  CountrySearchViewController.swift
//  CountryPickerTextfield-iOS
//
//  Created by Jonathan Arnal on 16/10/2018.
//

import UIKit
import SnapKit

//****************************************************
// MARK: - CountrySearchViewControllerDelegate
//****************************************************
protocol CountrySearchViewControllerDelegate: class {
    func didSelectCountry(_ country: CountryCode)
}

//****************************************************
// MARK: - CountrySearchViewController
//****************************************************
class CountrySearchViewController: UIViewController, CountriesDependent {
    
    //****************************************************
    // MARK: - Outlets
    //****************************************************
    
    private var tableView: UITableView!
    
    private var searchController: UISearchController!
    
    private var searchWindow: UIWindow?
    
    //****************************************************
    // MARK: - Variables
    //****************************************************
    
    weak var delegate: CountrySearchViewControllerDelegate?
    
    var showDialCode: Bool = false
    
    var searchString: String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filteredCoutries: [CountryCode] {
        guard let stringSearched = searchString, stringSearched.isEmpty == false else { return self.countries }
        return countries.filter { $0.localizedName!.lowercased().starts( with: stringSearched.lowercased() ) }.sorted(by: { (left,right) in return left.name > right.name } )
    }
    
    //****************************************************
    // MARK: - Life Cycle
    //****************************************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    //****************************************************
    // MARK: - User Interface
    //****************************************************
    
    /// 🚧 Build all UI elements
    private func setupUI() {
        
        buildTableView()
        buildSearchController()
    }
    
    /// 🚧 Build search controller
    private func buildSearchController() {
        
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.showsCancelButton = true
        if #available(iOS 9.1, *) {
            controller.obscuresBackgroundDuringPresentation = false
        }
        tableView.tableHeaderView = controller.searchBar
        
        definesPresentationContext = false
        
        searchController = controller
    }
    
    /// 🚧 Build table view
    private func buildTableView() {
        
        let tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.tableView = tableView
    }
    
    //****************************************************
    // MARK: - Window business
    //****************************************************
    
    /// 📲 Show the current controller in a new window
    func show() {
        
        view.alpha = 0
        if searchWindow == nil {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            window.isOpaque = true
            window.backgroundColor = UIColor.white
            window.rootViewController = self
            searchWindow = window
        }
        
        searchWindow?.makeKeyAndVisible()
        
        animateIn(duration: 0.4, then: nil)
    }
    
    /// 📲 Hides the current controller
    private func dismiss(then completion: (() -> Void)?) {
        animateOut(duration: 0.4, then: {
            self.searchWindow?.isHidden = true
            self.searchWindow?.removeFromSuperview()
            self.searchWindow = nil
            completion?()
        })
    }
    
    //****************************************************
    // MARK: - Animations
    //****************************************************
    
    /// 💫 Animates the current controller when it's added to window
    ///
    /// - Parameters:
    ///   - duration: duration of the animation
    ///   - completion: completion block called after animation is finished
    private func animateIn(duration: Double, then completion: (() -> Void)?) {
        
        view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        UIView.animate(withDuration: duration, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.alpha = 1
        }, completion: { (finished) in
            completion?()
        })
    }
    
    /// 💫 Animates the current controller when it's removed from window
    ///
    /// - Parameters:
    ///   - duration: duration of the animation
    ///   - completion: completion block called after animation is finished
    private func animateOut(duration: Double, then completion: (() -> Void)?) {
        
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            self.view.alpha = 0
        }) { (finished) -> Void in
            completion?()
        }
    }
    
}

extension CountrySearchViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCoutries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let country = filteredCoutries[indexPath.row]
        
        let cell = UITableViewCell()
        let countryView = CountryPickerView(withCountry: country)
        countryView.backgroundColor = UIColor.white
        countryView.showDialCode = self.showDialCode
        cell.addSubview( countryView )
        
        countryView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
}

extension CountrySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = filteredCoutries[indexPath.row]
        delegate?.didSelectCountry(selectedCountry)
        
        dismiss(then: nil)
    }
    
}

extension CountrySearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(then: nil)
    }
    
}

extension CountrySearchViewController: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text
    }
}

