//
//  SettingTableViewController.swift
//  ProductCatExample
//
//  Created by Hung on 17/4/20.
//  Copyright © 2020 ViSenze. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var countries : [String] = []
    var countriesDisplayArr : [String] = []
    
    static let countryString: String = "Country"
    static let resultPerPageString: String = "Results per Page"
    static let browserString: String = "Preferred Browser"
    
    let cellIdentifier = "SettingTableViewCell"
    
    let items : [String] = [ browserString, countryString, resultPerPageString]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Settings", comment: "")
        
        let locale = NSLocale.current
        self.countries = NSLocale.isoCountryCodes
        
        for i in 0 ..< self.countries.count {
            let countryCode = self.countries[i]
            let countryStr = "\(locale.localizedString(forRegionCode: countryCode)!) (\(countryCode))"
            countriesDisplayArr.append(countryStr)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let isCountryCell = (items[indexPath.row] == SettingTableViewController.countryString)
        
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)

        }
        
        cell?.textLabel?.text = items[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        
        if (isCountryCell) {
            let storedCountry = ExampleSettings.getCountry()
            cell?.detailTextLabel?.text = storedCountry ?? "SG"
        } else if (items[indexPath.row] == SettingTableViewController.resultPerPageString) {
            let storedResultPerPage = String(ExampleSettings.getResultPerPage())
            cell?.detailTextLabel?.text = storedResultPerPage
        } else if (items[indexPath.row] == SettingTableViewController.browserString) {
            let browserVal = ExampleSettings.getPrefBrowser()
            cell?.detailTextLabel?.text = browserVal
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row] == SettingTableViewController.countryString {
            let alert = UIAlertController(title: "Select Country", message: nil, preferredStyle: .actionSheet)
            
            let closure = { (action: UIAlertAction!) -> Void in
                let index = alert.actions.firstIndex(of: action)
                
                if let index = index {
                    ExampleSettings.setCountry(self.countries[index])
                    self.tableView.reloadData()
                }
            }
            
            for i in 0 ..< self.countriesDisplayArr.count {
                alert.addAction(UIAlertAction(title: self.countriesDisplayArr[i], style: .default, handler: closure))
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { (_) in
                self.tableView.reloadData()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if items[indexPath.row] == SettingTableViewController.resultPerPageString {
            
            let alert = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
            
            let closure = { (action: UIAlertAction!) -> Void in
                
                if let index = alert.actions.firstIndex(of: action) {
                    
                    ExampleSettings.setResultPerPage(ExampleSettings.RESULTS_PER_PAGE_LIST[index])
                    self.tableView.reloadData()
                }
            }
            
            for i in 0 ..< ExampleSettings.RESULTS_PER_PAGE_LIST.count {
                alert.addAction(UIAlertAction(title: String(ExampleSettings.RESULTS_PER_PAGE_LIST[i]), style: .default, handler: closure))
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { (_) in
                self.tableView.reloadData()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if items[indexPath.row] == SettingTableViewController.browserString {
            
            let alert = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
            
            let closure = { (action: UIAlertAction!) -> Void in
                
                if let index = alert.actions.firstIndex(of: action) {
                    ExampleSettings.setPreferBrowser(ExampleSettings.BROWSERS[index])
                    self.tableView.reloadData()
                }
            }
            
            for i in 0 ..< ExampleSettings.BROWSERS.count {
                alert.addAction(UIAlertAction(title: ExampleSettings.BROWSERS[i], style: .default, handler: closure))
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { (_) in
                self.tableView.reloadData()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
