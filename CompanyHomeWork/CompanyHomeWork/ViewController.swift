//
//  ViewController.swift
//  CompanyHomeWork
//
//  Created by ahmet gökdemir on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var revenueTextField: UITextField!
    
    @IBOutlet weak var expenseTextField: UITextField!
    
    @IBOutlet weak var totalBudgetLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var paymentLabel: UILabel!
    
    public var company : Company = Company(name: "Ahmet", budget: 10000, yearOfFoundation: 1996, employee: [Employee(name: "Ahmet", age: 25, employeeStatus: "Junior", budget: 25000) ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func addRevenueButton(_ sender: Any) {
        if let revenue = Int(revenueTextField.text ?? "0") {
            company.addRevenue(revenue: revenue)
            errorLabel.text = ""
            revenueTextField.text = ""
            totalBudgetLabel.text = "Toplam Bütçe : \(company.budget) ₺"
        }
        else {
            errorLabel.text = "Geliri lütfen sayısal bir değer giriniz.."
        }
    }
    
    
    @IBAction func addExpenseButton(_ sender: Any) {
        if let expense = Int(expenseTextField.text ?? "0") {
            company.addExpense(expense: expense)
            errorLabel.text = ""
            expenseTextField.text = ""
            totalBudgetLabel.text = "Toplam Bütçe : \(company.budget) ₺"
        }
        else {
            errorLabel.text = "Gideri lütfen sayısal bir değer giriniz.."}
    }
    
    
    @IBAction func paySalaryButton(_ sender: Any) {
        
        let isPay = company.makeSalaryPayment()
        
        if (isPay) {
            totalBudgetLabel.text = "Ödeme başarıyla yapıldı. Kalan para : \(company.budget) ₺"
            errorLabel.text = ""
        } else {
            errorLabel.text = "Ödeme yapılamadı. Toplam Bütçe : \(company.budget) ₺"
        }
    }
    
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEmployee", sender: self)
    }
    
    @IBAction func listEmployeeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToListEmployee", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddEmployee" {
            guard let vc = segue.destination as? AddEmployeeVC else {return}
            vc.company = self.company
        }
        if segue.identifier == "goToListEmployee" {
            guard let vc = segue.destination as? ListEmployeeVC else {return}
            vc.company = self.company
        }
    }
    
}

