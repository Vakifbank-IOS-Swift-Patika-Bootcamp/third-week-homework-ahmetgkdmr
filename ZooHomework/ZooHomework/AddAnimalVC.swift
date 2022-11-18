//
//  AddAnimalVC.swift
//  ZooHomework
//
//  Created by ahmet gökdemir on 18.11.2022.
//

import UIKit

class AddAnimalVC: UIViewController {

    var selectedAnimalType = "Cat"
    var company = ZooManagementCompany(name: "Animal Planet", dailyWaterlimit: 5000, dailyLiceBudget: 5000, generalBudget: 10000, petSitters: [PetSitter(id: 1, name: "David", age: 25, yearsOfWorkExperience: 2, responsibleAnimalId: 1),PetSitter(id: 2, name: "Ella", age: 30, yearsOfWorkExperience: 5, responsibleAnimalId: 2)], animals: [Animal(id: 1, kind: .Bird, name: "Boncuk", dailyWaterConsumption: 100, sitterId: 1),Animal(id: 2, kind: .Cat, name: "Zeytin", dailyWaterConsumption: 200, sitterId: 2)])
    
    let pickerViewSource = ["Cat","Dog","Bird","Chicken","Sheep"]
    
    @IBOutlet weak var idTextField: UITextField!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var petSitterId: UITextField!
    
    @IBOutlet weak var dailyWaterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
      
    }

    @IBAction func addAnimalButton(_ sender: Any) {
        if (nameTextField.text != "" && idTextField.text != "" && petSitterId.text != "" && dailyWaterTextField.text != ""){
            if let id = Int(idTextField.text!){
                if let petSitterId2 = Int(petSitterId.text!){
                    if let dailyWater = Int(dailyWaterTextField.text!) {
                        
                        if (!company.isAnimalId(animalId: id)){
                            company.addAnimal(animal: [Animal(id: id, kind: selectedAnimalType == "Cat" ? kindOfAnimal.Cat : (selectedAnimalType == "Dog" ? kindOfAnimal.Dog : (selectedAnimalType == "Bird" ? kindOfAnimal.Bird : (selectedAnimalType == "Chicken" ? kindOfAnimal.Chicken : kindOfAnimal.Sheep))), name: nameTextField.text!, dailyWaterConsumption: dailyWater, sitterId: petSitterId2)])
                            idTextField.text = ""
                            petSitterId.text = ""
                            nameTextField.text = ""
                            dailyWaterTextField.text = ""
                            infoLabel.text = "\(nameTextField.text!) isimli hayvan eklendi."}
                        else {
                                infoLabel.text = "Girilen animalId ile zaten hayvan var"
                        }
                    } else {
                        infoLabel.text = "Lütfen günlük su limitini sayısal değer giriniz."
                    }
                } else {
                    infoLabel.text = "Lütfen bakıcı id değerini sayısal değer giriniz."
                }
            } else {
                infoLabel.text = "Lütfen id değerini sayısal değer giriniz."
            }
        }
        else {
            infoLabel.text = "Eksik alanları doldurunuz."
        }
    }
}

extension AddAnimalVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedAnimalType = pickerViewSource[row]
        return pickerViewSource[row]
    }
    
    
}
