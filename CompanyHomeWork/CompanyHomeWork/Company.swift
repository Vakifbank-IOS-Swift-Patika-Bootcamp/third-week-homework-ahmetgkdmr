
import Foundation


struct Employee {
    
    var name: String
    var age: Int
    var employeeStatus: String
    var budget: Int
}

protocol CompanyProtocol {
    
    var name: String {get set}
    var budget: Int {get set}
    var yearOfFoundation: Int {get set}
    var employee: [Employee] {get set} // Şirket oluştururken minimum bir çalışan olmalı
    
    func addRevenue(revenue: Int) // Şirkete gelir ekleme
    func addExpense(expense: Int) // Şirkete gider ekleme
    func addEmployee(employee: [Employee]) // Şirkete çalışan ekleme
    func makeSalaryPayment() -> (Bool) // Yeteri kadar bütçe varsa ödeme yapılır true döner yoksa false döner
    func getTotalSalaryPayment() -> (Int) // Ödenmesi gereken toplam maaşı getirir
}

class Company : CompanyProtocol {
    
    var name: String
    var budget: Int
    var yearOfFoundation: Int
    var employee: [Employee]
    
    init(name: String, budget: Int, yearOfFoundation: Int, employee: [Employee]){
    
        self.name = name
        self.budget = budget
        self.yearOfFoundation = yearOfFoundation
        self.employee = employee
        print("Şirket başarıyla oluşturuldu.")
    }
    
    func addRevenue(revenue: Int) {
        print("Bütçe \(budget) idi. \(revenue) ₺ gelir olarak eklendi. Yeni bütçe : \(budget + revenue)")
        budget += revenue
    }
    
    func addExpense(expense: Int) {
        print("Bütçe \(budget) idi. \(expense) ₺ gider olarak eklendi. Yeni bütçe : \(budget - expense)")
        budget -= expense
    }
    
    func addEmployee(employee: [Employee]) {
        self.employee += employee
        print("Çalışan(lar) başarıyla eklendi.")
    }
    
    var calculateSalaryForEmployee : (Int,Int) -> Int = { // Closure Kullanımı (Her çalışana göre maaşını hesaplar.)
        return $0 * $1 * 1000
    }
    
    func getTotalSalaryPayment() -> (Int) {
        
        var total : Int = 0
        
        for i in 0..<employee.count {
            total += calculateSalaryForEmployee(employee[i].age, employee[i].employeeStatus == "Junior" ? 1 : (employee[i].employeeStatus == "Middle" ? 2 : 3))
        }
        print("Toplam maaş ödemesi : \(total) ₺ şirketin kasasındaki para : \(budget) ₺")
        return total
    }
    
    func makeSalaryPayment() -> (Bool) {
        
        let totalSalaryPayment = getTotalSalaryPayment()
        
        if (budget >= totalSalaryPayment){
            budget -= totalSalaryPayment
            print("Ödeme başarıyla yapıldı. Kalan para : \(budget) ₺")
            return true
        } else {
            print("Kasada yeterli para yok. Ödeme yapılamadı.")
            return false
        }
    }
}
