import Foundation

//---------------------- soal 1 : var dan let
print("SOAL PERTAMA")
var hargaBuku: Double = 200000
var jumlahEksemplar = 15

var totalHarga = hargaBuku * Double(jumlahEksemplar)

print("Total harga buku ini adalah: \(totalHarga)")

print("\n")


//---------------------- soal 2 : switch case
print("SOAL KEDUA")
var solvedDuration = 99

switch solvedDuration {
    case 0...24:
        print("you've finished the task in \(solvedDuration) hours")
        print("Pack your bags, you're going to Paris with your partner AND a bonus wage. Congratulations!")
    case 25...58:
        print("you've finished the task in \(solvedDuration) hours")
        print("You get a bonus wage and a trip to paris")
    case 59...100:
        print("you've finished the task in \(solvedDuration) hours")
        print("Well, thanks i guess (?)")
    default:
        print("you've finished the task in \(solvedDuration) hours")
        print("Thats enough, you better go home!")
}


print("\n")


//---------------------- soal 3 : function, constant
print("SOAL KETIGA")
func calculateMeanofThreeNums(firstNum: Double, secondNum: Double, thirdNum: Double) -> Double {
    let result = (firstNum + secondNum + thirdNum) / 3
    
    return result
}

let result = calculateMeanofThreeNums(firstNum: 92, secondNum: 92, thirdNum: 94)
print("Rata-rata skor: \(result)")


print("\n")

//---------------------- soal 4 : function, constant. Menghitung luas lingkaran
print("SOAL KEEMPAT")
func calculateArea(radius: Double) -> Double{
    let piVal = Double.pi
    return piVal * pow(radius, 2)
}
func calculateCircumference(radius: Double) -> Double{
    let piVal = Double.pi
    return 2 * piVal * radius
}

let radius = 6
let area = calculateArea(radius: 6)
let circumference = calculateCircumference(radius: 6)
print("Luas Lingkaran: \(area) \nKeliling lingkaran: \(circumference)")


print("\n")


//---------------------- soal 5 : clas dan struct
print("SOAL KELIMA")
class Olahraga {
    var nama: String
    var kategori: String
    var pemain: Int
    
    init(nama: String, kategori: String, pemain: Int){
        self.nama = nama
        self.kategori = kategori
        self.pemain = pemain
    }
    
    func cetakInfo() -> Void{
        print("\(nama) adalah olahraga kategori \(kategori) yang dimainkan oleh \(pemain) orang")
    }
}

let olahraga = Olahraga(nama: "Basket", kategori: "Tim", pemain: 5)
olahraga.cetakInfo()

