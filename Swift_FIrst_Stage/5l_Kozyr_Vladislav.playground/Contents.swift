/*1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 
 6. Вывести сами объекты в консоль.*/
import Foundation




enum DoorState {                                                 // создал перечисления значений параметров автомобиля
    case open, close
}
enum StartEngine {
    case start, stop
}
enum Transmission {
    case manual, auto
}

protocol Car {                                                 // создан протокол автомобиля с описанием свойств с помощью методов, если я сам правильно понял
    
    func brand() -> String
    func year() -> Int
    func transmission() -> Transmission
    func engine() -> StartEngine
    func doorState() -> DoorState
    
}

extension Car {                                                  // создано расширение для протокола автомобиля с методом вывода параметров
    func CarPrint() {
        print("Характеристики автомобиля: \(self.brand)")
        print("1.Год выпуска: \(self.year)")
        print("2.Состояние двигателя: \(self.engine)")
        print("3.Коробка передач: \(self.transmission)")
        print("4.Положение дверей: \(self.doorState)")
        print("=========================================")
        print(CarPrint)
    }
}


class TrunkCar: Car {                                                // создал грузовой авто - класс имплементирующий протокол Car
    var attachTrailer: AttachTrailer                                // добавил возможность прикрепить/открепить прицеп
    init(brand: String, year: Int, transmission: Transmission, engine: StartEngine, doorState: DoorState, attachTrailer: AttachTrailer) {
        self.attachTrailer = attachTrailer
        super.init(brand: brand, year: year, transmission: transmission, engine: engine, doorState: doorState)
    }
    func attach() {
        attachTrailer = .attach
    }
    
    func detach() {
        attachTrailer = .detach
    }
}


extension TrunkCar: CustomStringConvertible {
    var trunkCarInfo : String {
        return "Brand: \(brand), Attach Trailer: \(attachTrailer)"
    }
}

//======================================== Класс Спорткар

class SportСar: Car {                           // создал спортивный авто - класс имплементирующий протокол Car
    var nitroStart: NitroStart                  // добавил возможность устанавливать на спорткары нитро
    init(brand: String, year: Int, transmission: Transmission, engine: StartEngine, doorState: DoorState, nitroStart: NitroStart) {
        self.nitroStart = nitroStart
        super.init(brand: brand, year: year, transmission: transmission, engine: engine, doorState: doorState)
    }
    func yesNOS(){
        nitroStart = .yes
    }
    
    func noNOS(){
        nitroStart = .no
    }
    
}

extension SportСar: CustomStringConvertible {
    var sportСarInfo : String {
        return "Brand: \(brand), Nitro Start: \(nitroStart)"
    }
}



var car1 = TrunkCar(brand: "MAN", year: 2014, transmission: .manual, engine: .start, doorState: .open, attachTrailer: .attach)
print(car1.brand)
print(car1.year)
car1.year = 2008
print(car1.year)

var car2 = TrunkCar(brand: "MAN", year: 2014, transmission: .manual, engine: .start, doorState: .open, attachTrailer: .attach)
print(car2.brand)
print(car2.year)
car2.year = 2008
print(car2.year)

var car3 = SportСar(brand: "Lamborgini", year: 2018, transmission: .auto, engine: .start, doorState: .close, nitroStart: .yes)
print(car3.brand)
print(car3.year)
car3.year = 2008
print(car3.year)

var car4 = SportСar(brand: "Ferrari", year: 2016, transmission: .auto, engine: .start, doorState: .close, nitroStart: .yes)
print(car4.brand)
print(car4.year)
car4.year = 2008
print(car4.year)


car1.CarPrint()
car2.CarPrint()
car3.CarPrint()
car4.CarPrint()

car4.yesNOS()
car3.noNOS()
car2.attach()
car2.detach()
car3.yesNOS()
car3.noNOS()
