import UIKit


/*1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 
 6. Вывести значения свойств экземпляров в консоль.*/


//!!НЕ ПОЛУЧАЕТСЯ ИНИЦИАЛИЗИРОВАТЬ ФУНКЦИИ В ЧЕМ МОЖЕТ БЫТЬ ПРОБЛЕМА?

enum WindowState {              // создал перечисления значений параметров автомобиля
    case open, close
}
enum StartEngine {
    case start, stop
}
enum Transmission {
    case manual, auto
}
enum FillingVolume {
    case load0, unload0
    case load, unload
}
enum AttachTrailer {
    case attach, detach
}

enum NitroStart {
    case yes, no
}

class Car {              // создал "родительский" класс автомобиля
    static var carCount = 0
    var brand: String
    var year: Int
    var volume: Double
    var fillingVolume: FillingVolume
    let transmission: Transmission
    let engine: StartEngine
    var windowState: WindowState {
        willSet {
            if newValue == .open {
                print("Windows is opening")
            } else {
                print("Windows is closing")
            }
        }
    }
    init(brand: String, year: Int, volume: Double, fillingVolume: FillingVolume, transmission: Transmission, engine: StartEngine, windowState: WindowState) {
        self.brand = brand
        self.year = year
        self.volume = volume
        self.fillingVolume = fillingVolume
        self.transmission = transmission
        self.engine = engine
        self.windowState = windowState
        Car.carCount += 1                   //счетчик количества автомобилей
    }

    deinit {
        Car.carCount -= 1
    }

    static func countInfo() {                //функция вывода количества автомобилей
        print("Выпущено \(self.carCount) автомобилей")
    }

    func windowOpen() {                       // функция ручного открытия окон
        if self.windowState == .close {
            windowState = .open
            print("Окно открыто вручную")

        } else {
            print("Окно уже открыто")
        }
    }
    func windowClose() {                      // функция ручного закрытия окон
        if windowState == .open {
            windowState = .close
            print("Окно закрыто вручную")

        } else {
            print("Окно уже закрыто")
        }
    }
}
//======================================== Класс Грузовик

class TrunkCar: Car {                           // создал грузовой авто - наследника Car
    var attachTrailer: AttachTrailer            // добавил возможность прикрепить/открепить прицеп
    init(brand: String, year: Int, volume: Double, fillingVolume: FillingVolume, transmission: Transmission, engine: StartEngine, windowState: WindowState, attachTrailer: AttachTrailer) {
        self.attachTrailer = attachTrailer
        super.init(brand: brand, year: year, volume: volume, fillingVolume: fillingVolume, transmission: transmission, engine: engine, windowState: windowState)
    }
    func attach() {
        attachTrailer = .attach
    }

    func detach() {
        attachTrailer = .detach
    }
}

//======================================== Класс Спорткар

class SportСar: Car {                           // создал спортивный авто - наследника Car
    var nitroStart: NitroStart                  // добавил возможность устанавливать на спорткары нитро
    init(brand: String, year: Int, volume: Double, fillingVolume: FillingVolume, transmission: Transmission, engine: StartEngine, windowState: WindowState, nitroStart: NitroStart) {
        self.nitroStart = nitroStart
        super.init(brand: brand, year: year, volume: volume, fillingVolume: fillingVolume, transmission: transmission, engine: engine, windowState: windowState)
    }
    func yesNOS(){
        nitroStart = .yes
    }

    func noNOS(){
        nitroStart = .no
    }
    override func windowOpen(){
        print("Мама запретила открывать окна, продует!")
    }
    override func windowClose() {
        print("Окна закрыты, молодец!")
    }
}

final class DecorativeCar: SportСar {
    
    override func yesNOS(){
        super.yesNOS()
        print("Нельзя заправлять баллоны на выстовочном авто!")
    }
    
    override func noNOS(){
       print("На выстовочном авто баллоны не заправлены, расслабься!")
    }

}

var car1 = Car(brand: "BMW", year: 2018, volume: 500, fillingVolume: .load0, transmission: .auto, engine: .start, windowState: .open)
print(car1.brand)
print(car1.year)
car1.year = 2008
print(car1.year)

var car2 = TrunkCar(brand: "MAN", year: 2014, volume: 60000, fillingVolume: .load, transmission: .manual, engine: .start, windowState: .open, attachTrailer: .attach)
print(car2.brand)
print(car2.year)
car2.year = 2008
print(car2.year)

var car3 = SportСar(brand: "Lamborgini", year: 2018, volume: 100, fillingVolume: .load0, transmission: .auto, engine: .start, windowState: .close, nitroStart: .yes)
print(car3.brand)
print(car3.year)
car3.year = 2008
print(car3.year)

var car4 = SportСar(brand: "Ferrari", year: 2016, volume: 0, fillingVolume: .load0, transmission: .auto, engine: .start, windowState: .close, nitroStart: .yes)
print(car4.brand)
print(car4.year)
car4.year = 2008
print(car4.year)

var car5 = SportСar(brand: "Nissan 350Z", year: 1999, volume: 0, fillingVolume: .load0, transmission: .manual, engine: .stop, windowState: .close, nitroStart: .no)
print(car5.brand)
print(car5.year)
car5.year = 2008
print(car5.year)

print(Car.carCount)

func PrintCar () {                             // функция принтует заданные параметры структур - Вопрос как сделать так что бы можно было менять пармаетр car1 в этой функции на car2/car3 и тд, что бы выводить данные по нужному авто?
    print("Характеристики автомобиля \(car1.brand):")
    print("1.Год выпуска: \(car1.year)")
    print("2.Состояние двигателя: \(car1.engine)")
    print("3.Коробка передач: \(car1.transmission)")
    print("4.Положение окон: \(car1.windowState)")
    print("5.Полный объем багажника: \(car1.volume)")
    car1.volume = 1540
    car1.windowState = .close
    print("=========================================")
}
PrintCar ()
//!!НЕ ПОЛУЧАЕТСЯ ИНИЦИАЛИЗИРОВАТЬ ЭТИ ФУНКЦИИ. В ЧЕМ МОЖЕТ БЫТЬ ПРОБЛЕМА?
//yesNOS()
//noNOS()
//attach()
//detach()
//windowOpen()
//windowClose()
//countInfo()
//================================================
print("Всего автомобилей в нашем автопарке: \(Car.carCount)")
