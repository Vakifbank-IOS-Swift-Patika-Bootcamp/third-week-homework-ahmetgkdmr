//
//  ListEmployeeVC.swift
//  CompanyHomeWork
//
//  Created by ahmet gökdemir on 17.11.2022.
//

import UIKit

class ListEmployeeVC: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    public var company : Company = Company(name: "Ahmet", budget: 10000, yearOfFoundation: 1996, employee: [Employee(name: "Ahmet", age: 25, employeeStatus: "Junior", budget: 25000) ])
    
    var filteredEmployeeList : [String] = []
    var employeeList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        company.employee.forEach{
            employeeList.append($0.name)
        }
        filteredEmployeeList.append(contentsOf: employeeList)
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        searchBar.delegate = self
    }
}

extension ListEmployeeVC : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredEmployeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = filteredEmployeeList[indexPath.row]
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEmployeeList = searchText.isEmpty ? employeeList : employeeList.filter({(str : String)->Bool in
            return str.range(of: searchText, options: .caseInsensitive) != nil
        })
        itemsTableView.reloadData()
    }
}
    

