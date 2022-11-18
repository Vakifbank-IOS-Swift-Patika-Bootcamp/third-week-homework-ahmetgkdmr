//
//  AddPetSitterVC.swift
//  ZooHomework
//
//  Created by ahmet gökdemir on 18.11.2022.
//

import UIKit

class AddPetSitterVC: UIViewController {
    
    var company = ZooManagementCompany(name: "Animal Planet", dailyWaterlimit: 5000, dailyLiceBudget: 5000, generalBudget: 10000, petSitters: [PetSitter(id: 1, name: "David", age: 25, yearsOfWorkExperience: 2, responsibleAnimalId: 1),PetSitter(id: 2, name: "Ella", age: 30, yearsOfWorkExperience: 5, responsibleAnimalId: 2)], animals: [Animal(id: 1, kind: .Bird, name: "Boncuk", dailyWaterConsumption: 100, sitterId: 1),Animal(id: 2, kind: .Cat, name: "Zeytin", dailyWaterConsumption: 200, sitterId: 2)])

    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var workExperienceTextField: UITextField!
    
    @IBOutlet weak var animalIdTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self
        workExperienceTextField.delegate = self

    }
    
    @IBAction func addPetSitterButton(_ sender: Any) {
        if (nameTextField.text != "" && idTextField.text != "" && ageTextField.text != "" && workExperienceTextField.text != "" && animalIdTextField.text != ""){
            if let id = Int(idTextField.text!){
                if let age = Int(ageTextField.text!){
                    if let workExperience = Int(workExperienceTextField.text!) {
                        if let animalId = Int(animalIdTextField.text!) {
                            
                            if(!company.isPetSitterId(petSitterId: id)){
                                company.addPetSitter(petSitter: [PetSitter(id: id, name: nameTextField.text!, age: age, yearsOfWorkExperience: workExperience, responsibleAnimalId: animalId)])
                                infoLabel.text = "\(idTextField.text!) id ile \(nameTextField.text!) isimli bakıcı eklendi."
                                nameTextField.text = ""
                                idTextField.text = ""
                                ageTextField.text = ""
                                workExperienceTextField.text = ""
                                animalIdTextField.text = "" }
                            else {
                                infoLabel.text = "Girdiğiniz petSitterId ile bakıcı var."
                            }
                            
                        } else {
                            infoLabel.text = "Lütfen hayvan id sayısal değer giriniz."}
                    } else {
                        infoLabel.text = "Lütfen iş deneyimini sayısal değer giriniz."}
                } else {
                    infoLabel.text = "Lütfen yaşı sayısal değer giriniz."}
            } else {
                infoLabel.text = "Lütfen id değerini sayısal değer giriniz."}
        } else{
            infoLabel.text = "Girilmeyen değerler var."}
    }

}

extension AddPetSitterVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(ageTextField.text != "" && workExperienceTextField.text != ""){
            if let age = Int(ageTextField.text!){
                if let workExperience = Int(workExperienceTextField.text!){
                    salaryLabel.text = "\(age * workExperience * 100) ₺"
                } else {salaryLabel.text = ""}
            } else {salaryLabel.text = ""}
        } else {salaryLabel.text = ""}
    }
}
