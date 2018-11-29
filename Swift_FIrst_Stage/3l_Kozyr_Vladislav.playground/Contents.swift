import UIKit


//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//
//2. Структуры должны содержать марку авто, год выпуска, -объем багажника/кузова-, запущен ли двигатель, открыты ли окна, *заполненный объем багажника*.
//
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, **погрузить/выгрузить из кузова/багажника груз определенного объема**.
//
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.


enum WindowState {
    case open, close
}
enum StartEngine {
    case start, stop
}
enum Transmission {
    case manual, auto       // создал перечисления значений параметров автомобиля
}
enum FillingVolume {
    case load0, unload0
    case load, unload
}



struct Sedan {              // создал структуру легкового автомобиля с нужными по условиям параметрами
    var brand: String
    var year: Int
    var volume: Double      // код ниже рабочий, загружает багаж вот таким образом "car1.volume = 1540", оставил на всякий случай, вдруг я не так понял задание, но закоментил, что бы не мешал реализации кода fillingVolume. Оставил этот код в структуре грузовика.
    
//    {
//    didSet {
//    let mesto = oldValue
//            print("Full Volume: \(mesto)") //пишем сколько полный объем
//    }
//    willSet {
//    let mesto = newValue
//        if (mesto < 0) || (mesto > volume) { //если заполненное место получилось больше фактического или отрицательным то выводим ошибку
//            print("ERROR")
//        } else {
//            print("Filled Volume: \(mesto)") //пишем сколько заполнили места
//        }
//    }
//}
    
    //=========================================================
    var fillingVolume: FillingVolume {
        willSet {
            let stuff: Double = 10
            if newValue == .load {            // загрузка груза
                
                if (volume >= stuff) && (stuff > 0) {
                    volume = volume - stuff
                    print("Груз объемом \(stuff) загружен")
                    print("Осталось свободного места: \(volume)")
                } else {print("Груз не влезает!")}
                
            } else if newValue == .unload {           // выгрузка груза
                
                if (stuff > 0) && (volume < 1540) {     //!!!ВОПРОС!!! долго разбирался, но так и не понял как вместо вручную вбитых "1540" подставить изначальное значение volume? пробовал вводить переменные вроде "var a = volume", что бы загрузить в "а" изначальное значение "volume" до всех манипуляций, но так оно не работает...
                    volume = volume + stuff
                    print("Груз объемом \(stuff) выгружен")
                    print("Осталось свободного места: \(volume)")
                } else {print("Выгружать нечего, автомобиль пуст!")}
            }
        }
    }
    
    //=========================================================
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
    //============================================//функции добавлены только в структуру седан, просто что бы поиграться значениями
    mutating func closeWindow() {
        self.windowState = .close
    }
    
    mutating func openWindow() {
        self.windowState = .open
    }
    
    func printVolume() {
        print("Максимальный объем багажника: \(volume)")
    }
    //=============================================
}



struct Truck {              // грузовой авто, здесь все то же самое
    var brand: String
    var year: Int
    var volume: Double
    {      //===========================в этой структуре код отключать не стал, потому что не перенес fillingVolume из структуры SEDAN, чтобы посмотреть разницу
        didSet {
            let mesto = oldValue
                print("Full Volume: \(mesto)")
        }
        willSet {
            let mesto = newValue
            if (mesto < 0) || (mesto > volume)  {
                print("ERROR")
            } else {
                print("Filled Volume: \(mesto)")
            }
        }
    } //==========================================до сих пор
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
}
// ниже создаем 4 разных автомобиля
var car1 = Sedan(brand: "BMW", year: 2018, volume: 500, fillingVolume: .load0, transmission: .auto, engine: .start, windowState: .open)
var car2 = Sedan(brand: "AUDI", year: 2015, volume: 600, fillingVolume: .load0, transmission: .auto, engine: .stop, windowState: .close)
var car3 = Truck(brand: "MAN", year: 2012, volume: 50000, transmission: .manual, engine: .stop, windowState: .close)
var car4 = Truck(brand: "VOLVO", year: 2016, volume: 52000, transmission: .auto, engine: .start, windowState: .open)


func PrintCars () {                             // функция принтует заданные параметры структур
    print("Характеристики автомобиля \(car1.brand):")
    print("1.Год выпуска: \(car1.year)")
    print("2.Состояние двигателя: \(car1.engine)")
    print("3.Коробка передач: \(car1.transmission)")
    print("4.Положение окон: \(car1.windowState)")
    print("5.Полный объем багажника: \(car1.volume)")
    car1.volume = 1540
    car1.windowState = .close
    print("=========================================")

    print("Характеристики автомобиля \(car2.brand):")
    print("1.Год выпуска: \(car2.year)")
    print("2.Состояние двигателя: \(car2.engine)")
    print("3.Коробка передач: \(car2.transmission)")
    print("4.Положение окон: \(car2.windowState)")
    print("5.Полный объем багажника: \(car2.volume)")
    car2.volume = 333
    car2.windowState = .open
    print("=========================================")

    print("Характеристики автомобиля \(car3.brand):")
    print("1.Год выпуска: \(car3.year)")
    print("2.Состояние двигателя: \(car3.engine)")
    print("3.Коробка передач: \(car3.transmission)")
    print("4.Положение окон: \(car3.windowState)")
    print("5.Полный объем багажника: \(car3.volume)")
    car3.volume = 2540-pow(12, 3)
    car3.windowState = .open
    print("=========================================")

    print("Характеристики автомобиля \(car4.brand):")
    print("1.Год выпуска: \(car4.year)")
    print("2.Состояние двигателя: \(car4.engine)")
    print("3.Коробка передач: \(car4.transmission)")
    print("4.Положение окон: \(car4.windowState)")
    print("5.Полный объем багажника: \(car4.volume)")
    car4.volume = 6000 * 20
    car4.windowState = .close
    print("=========================================")
}
PrintCars()

car2.openWindow()
car1.printVolume()
let car1Trancmission = Transmission.auto
print(car1Trancmission)
print("=========================================")
car1.fillingVolume = .unload
car1.fillingVolume = .unload
car1.fillingVolume = .unload
print("=========================================")
car1.fillingVolume = .load
car1.fillingVolume = .load
car1.fillingVolume = .load
car1.fillingVolume = .load
print("=========================================")
car1.fillingVolume = .unload
car1.fillingVolume = .unload
print("=========================================")
car4.volume = 2000 * 20
