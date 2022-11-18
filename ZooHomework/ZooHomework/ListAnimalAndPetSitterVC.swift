//
//  ListAnimalAndPetSitterVC.swift
//  ZooHomework
//
//  Created by ahmet gökdemir on 18.11.2022.
//

import UIKit

class ListAnimalAndPetSitterVC: UIViewController {
    var company = ZooManagementCompany(name: "Animal Planet", dailyWaterlimit: 5000, dailyLiceBudget: 5000, generalBudget: 10000, petSitters: [PetSitter(id: 1, name: "David", age: 25, yearsOfWorkExperience: 2, responsibleAnimalId: 1),PetSitter(id: 2, name: "Ella", age: 30, yearsOfWorkExperience: 5, responsibleAnimalId: 2)], animals: [Animal(id: 1, kind: .Bird, name: "Boncuk", dailyWaterConsumption: 100, sitterId: 1),Animal(id: 2, kind: .Cat, name: "Zeytin", dailyWaterConsumption: 200, sitterId: 2)])
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
    }

}
extension ListAnimalAndPetSitterVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        company.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = "Hayvan : \(company.animals[indexPath.row].name) Bakıcısı : \(company.getPetSitterNameForId(petsitterId: company.animals[indexPath.row].sitterId))"
        return cell
    }
    
}
