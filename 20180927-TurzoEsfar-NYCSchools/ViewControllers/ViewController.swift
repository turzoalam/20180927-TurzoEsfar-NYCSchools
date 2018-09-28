//
//  ViewController.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = MainTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        tableView.estimatedRowHeight = 135
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        if ReachabilityChecker.isConnectedToNetwork(){
            let sv = UIViewController.displaySpinner(onView: self.view)
            
            viewModel.getNYCSchoolData { [unowned self](isError) in
                
                if isError {
                    self.alert(message: "Unable to fetch data from server")
                } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIViewController.removeSpinner(spinner: sv)
                }
                }
            }
        }else{
             self.alert(message: "Internet Connectivity Problem")
        }
        
    }
   
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NYCSchoolsTableViewCell.self), for: indexPath) as! NYCSchoolsTableViewCell
        cell.colorView.backgroundColor = viewModel.decideColor(indexval: indexPath.row)
        cell.labelSchoolName.text = viewModel.dataSourceArray[indexPath.row].school_name
        cell.labelSchoolLocation.text = String((viewModel.dataSourceArray[indexPath.row].location.split(separator: "(").first) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as? DetailsViewController else{
            return
        }
        detailsViewController.nycSchool = viewModel.dataSourceArray[indexPath.row]
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var newarray:[NYcSchoolModel] = []
        if let text = searchBar.text {
            let schoolObjects = viewModel.dataSourceArray
            for eachSchool in schoolObjects {
                
                if(eachSchool.school_name.contains(find:text) || eachSchool.location.contains(find:text)){
                    newarray.append(eachSchool)
                }
            }
            viewModel.dataSourceArray.removeAll()
            viewModel.dataSourceArray = newarray
            self.searchBar.endEditing(true)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == ""){
            self.searchBar.endEditing(true)
            viewModel.dataSourceArray.removeAll()
            loadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if (searchBar.text == ""){
            viewModel.dataSourceArray.removeAll()
            loadData()
        }
    }
}
