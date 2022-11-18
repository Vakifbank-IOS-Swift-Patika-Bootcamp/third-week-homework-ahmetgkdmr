
import Foundation

struct PetSitter {
    
    var id: Int
    var name: String
    var age: Int
    var yearsOfWorkExperience: Int
    var responsibleAnimalId: Int // bir bakıcı birden fazla hayvana bakabilir.
}

enum kindOfAnimal : String {
    
    case Cat = "miyavvvv"
    case Dog = "hav hav"
    case Bird = "cik cik"
    case Chicken = "gıt gıt gıdak"
    case Sheep = "meeee"
}

struct Animal {

    var id: Int
    var kind: kindOfAnimal
    var name: String
    var dailyWaterConsumption: Int
    var sitterId: Int // her hayvanın tek bakıcısı olabilir.
}

protocol ZooManagementCompanyProtocol {
    
    var name: String {get set}
    var dailyWaterLimit: Int {get set}
    var dailyLiceBudget: Int {get set}
    var generalBudget: Int {get set} // bit bütçesi dahil değil
    var petSitters: [PetSitter] {get set}
    var animals: [Animal] {get set}
    
    func increaseWaterLimit(kilogram: Int)
    func addRevenue(revenue: Int) // gelir ekleme
    func addExpense(expense: Int) // gider ekleme
    func makeSalaryPayment() -> (Bool) // Yeteri kadar bütçe varsa ödeme yapılır true döner yoksa false döner
    func getTotalSalaryPayment() -> (Int) // Ödenmesi gereken toplam maaşı getirir
    func addPetSitter(petSitter: [PetSitter])
    func addAnimal(animal: [Animal])
    func getAnimalSound(animalId: Int)
    func getDailyWaterLimit() -> (Bool) // Günlük su limiti hayvanların ihtiyacını karşılıyorsa true karşılamıyorsa false döner
}

class ZooManagementCompany : ZooManagementCompanyProtocol {
    
    var name: String
    var dailyWaterLimit: Int
    var dailyLiceBudget: Int
    var generalBudget: Int
    var petSitters: [PetSitter]
    var animals: [Animal]
    
    init(name: String, dailyWaterlimit: Int, dailyLiceBudget: Int, generalBudget: Int, petSitters: [PetSitter], animals: [Animal]){
        
        self.name = name
        self.dailyWaterLimit = dailyWaterlimit
        self.dailyLiceBudget = dailyLiceBudget
        self.generalBudget = generalBudget
        self.petSitters = petSitters
        self.animals = animals
        
        print("Hayvanat bahçesi yönetim sistemi başarıyla oluşturuldu.")
    }
    
    func increaseWaterLimit(kilogram: Int) {
        print("\(dailyWaterLimit) olan günlük su limiti \(kilogram) kilogram arttırılarak toplam \(dailyWaterLimit + kilogram) olmuştur.")
        dailyWaterLimit += kilogram
    }
    
    func addRevenue(revenue: Int) {
        print("\(generalBudget) olan genel bütçe \(revenue) ₺ arttırılarak toplam \(generalBudget + revenue) ₺ olmuştur.")
        generalBudget += revenue
    }
    
    func addExpense(expense: Int) {
        print("\(generalBudget) olan genel bütçe \(expense) ₺ gider eklenerek toplam \(generalBudget - expense) ₺ olmuştur.")
        generalBudget -= expense
    }
    
    func isAnimalId(animalId: Int)->(Bool){
        for i in 0..<animals.count {
            if (animals[i].id == animalId){
                return true
            }
        }
        return false
    }
    
    func isPetSitterId(petSitterId: Int)->(Bool){
        for i in 0..<petSitters.count {
            if (petSitters[i].id == petSitterId){
                return true
            }
        }
        return false
    }
    
    func getPetSitterNameForId(petsitterId: Int)->(String){
        for i in 0..<petSitters.count {
            if(petSitters[i].id == petsitterId){
                return petSitters[i].name
            }
        }
        return "İsim bulunamadı."
    }
    
    func makeSalaryPayment() -> (Bool) {
        
        let totalSalaryPayment = getTotalSalaryPayment()
        if (generalBudget > totalSalaryPayment){
            generalBudget -= totalSalaryPayment
            print("Çalışanların maaş ödemesi başarıyla yapılmıştır. Kalan bütçe \(generalBudget) ₺")
            return true
        } else {
            print("Çalışanların ödemesi yapılamamıştır. Gereken tutar: \(totalSalaryPayment - generalBudget) ₺")
            return false
        }
    }
    
    var calculateSalaryForEmployee : (Int, Int) -> (Int) = {  // Closure kullanımı (Her çalışan için maaşını hesaplar)
        return ($0 * $1 * 100)
    }
    
    func getTotalSalaryPayment() -> (Int) {
        
        var total: Int = 0
        
        for i in 0..<petSitters.count {
            total += calculateSalaryForEmployee(petSitters[i].age, petSitters[i].yearsOfWorkExperience)
        }
        print("Toplam maaş ödemesi : \(total) ₺ şirketin kasasındaki para : \(generalBudget) ₺")
        return total
        
    }
    
    func addPetSitter(petSitter: [PetSitter]) {
        self.petSitters += petSitter
    }
    
    func addAnimal(animal: [Animal]) {
        print("Hayvanlar")
        self.animals += animal
    }
    
    func getAnimalSound(animalId: Int) {
        for i in 0..<animals.count{
            if (animals[i].id == animalId){
                print(" \(animals[i].name) isimli hayvanın sesi : \(animals[i].kind.rawValue)")
                break
            }
        }
    }
    
    func getDailyWaterLimit() -> (Bool) {
        
        var total: Int = 0
        for i in 0..<animals.count {
            total += animals[i].dailyWaterConsumption
        }
        if (dailyWaterLimit > total){
            print("Toplam su limiti = \(dailyWaterLimit) Hayvanların günlük \(total) litre suyu verilmiştir. Kalan su : \(dailyWaterLimit - total)")
            dailyWaterLimit -= total
            return true
        } else {
           print("Hayvanların suyu verilememiştir. Gereken su miktarı : \(total - dailyWaterLimit)")
            return false
        }
    }
}
