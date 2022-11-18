//
//  AddEmployeeVC.swift
//  CompanyHomeWork
//
//  Created by ahmet gökdemir on 16.11.2022.
//

import UIKit

class AddEmployeeVC: UIViewController {
    var selectedEmployeeStatu = "Junior"
    var age = 0
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var salaryTextView: UILabel!
    @IBOutlet weak var ageTextView: UITextView!
    @IBOutlet weak var infoAddEmployee: UILabel!
    
    public var company : Company = Company(name: "Ahmet", budget: 10000, yearOfFoundation: 1996, employee: [Employee(name: "Ahmet", age: 25, employeeStatus: "Junior", budget: 25000) ])
    
    let pickerViewSource = ["Junior","Middle","Senior"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        ageTextView.delegate = self
    }
    
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        if (nameTextView.text != ""){
            if let age = Int(ageTextView.text) {
                company.addEmployee(employee: [Employee(name: nameTextView.text, age: age, employeeStatus: selectedEmployeeStatu, budget: Int(salaryTextView.text ?? "0")!)])
                infoAddEmployee.text = "İşçi eklendi İsim : \(nameTextView.text!), Yaş: \(age), Maaş: \(Int(salaryTextView.text ?? "0")!) ₺"
            }
        }
    }
    

}
extension AddEmployeeVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedEmployeeStatu = pickerViewSource[row]
        salaryTextView.text = String(company.calculateSalaryForEmployee(age, selectedEmployeeStatu == "Junior" ? 1 : (selectedEmployeeStatu == "Middle" ? 2 : 3)))
        return pickerViewSource[row]
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let age = Int(ageTextView.text){
            salaryTextView.text = String(company.calculateSalaryForEmployee(age, selectedEmployeeStatu == "Junior" ? 1 : (selectedEmployeeStatu == "Middle" ? 2 : 3)))
            self.age = age
        } else {
            self.age = 0
            salaryTextView.text = "0"
            print("Lütfen yaşı sayı olarak giriniz.")
        }
    }
    
}
