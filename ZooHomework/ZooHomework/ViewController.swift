//
//  ViewController.swift
//  ZooHomework
//
//  Created by ahmet gökdemir on 18.11.2022.
//

import UIKit

class ViewController: UIViewController {

    var company = ZooManagementCompany(name: "Animal Planet", dailyWaterlimit: 5000, dailyLiceBudget: 5000, generalBudget: 10000, petSitters: [PetSitter(id: 1, name: "David", age: 25, yearsOfWorkExperience: 2, responsibleAnimalId: 1),PetSitter(id: 2, name: "Ella", age: 30, yearsOfWorkExperience: 5, responsibleAnimalId: 2)], animals: [Animal(id: 1, kind: .Bird, name: "Boncuk", dailyWaterConsumption: 100, sitterId: 1),Animal(id: 2, kind: .Cat, name: "Zeytin", dailyWaterConsumption: 200, sitterId: 2)])
    
    
    @IBOutlet weak var addRevenueTextField: UITextField!
    
    @IBOutlet weak var addExpenseTextField: UITextField!
    
    
    @IBOutlet weak var addWaterTextField: UITextField!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func addRevenueButton(_ sender: Any) {
        if let revenue = Int(addRevenueTextField.text ?? "0") {
            company.addRevenue(revenue: revenue)
            addRevenueTextField.text = ""
            infoLabel.text = "Toplam Bütçe : \(company.generalBudget) ₺"
        }
        else {
            addRevenueTextField.text = ""
            infoLabel.text = "Geliri lütfen sayısal bir değer giriniz.."
        }
    }
    
    
    @IBAction func addExpenseButton(_ sender: Any) {
        if let expense = Int(addExpenseTextField.text ?? "0") {
            company.addExpense(expense: expense)
            addExpenseTextField.text = ""
            infoLabel.text = "Toplam Bütçe : \(company.generalBudget) ₺"
        }
        else {
            addExpenseTextField.text = ""
            infoLabel.text = "Gideri lütfen sayısal bir değer giriniz.."
        }
    }
    
    @IBAction func addWaterButton(_ sender: Any) {
        if let kilogram = Int(addWaterTextField.text ?? "0") {
            company.increaseWaterLimit(kilogram: kilogram)
            addWaterTextField.text = ""
            infoLabel.text = "Toplam Su Limiti : \(company.dailyWaterLimit) ₺"
        }
        else {
            addWaterTextField.text = ""
            infoLabel.text = "Su limitini lütfen sayısal bir değer giriniz.."
        }
    }
    

    @IBAction func paySalaryButton(_ sender: Any) {
        
        let isPay = company.makeSalaryPayment()
        
        if (isPay) {
            infoLabel.text = "Ödeme başarıyla yapıldı. Kalan para : \(company.generalBudget) ₺"
        } else {
            infoLabel.text = "Ödeme yapılamadı. Toplam Bütçe : \(company.generalBudget) ₺"
        }
        
    }
    
    @IBAction func addPetSitterButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddPetSitterVC", sender: self)
    }
    
    @IBAction func addAnimalButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddAnimalVC", sender: self)
    }
    
    @IBAction func listAnimalAndPetSitterButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAnimalAndPetSitterVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddPetSitterVC" {
            guard let vc = segue.destination as? AddPetSitterVC else {return}
            vc.company = self.company
        }
        if segue.identifier == "goToAddAnimalVC" {
            guard let vc = segue.destination as? AddAnimalVC else {return}
            vc.company = self.company
        }
        if segue.identifier == "goToAnimalAndPetSitterVC" {
            guard let vc = segue.destination as? ListAnimalAndPetSitterVC else {return}
            vc.company = self.company
        }
    }
    
    
}

