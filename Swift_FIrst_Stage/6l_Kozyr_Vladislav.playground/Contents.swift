import Foundation

/*1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.*/


// создаем перечисление вариантов возможной зарплаты сотрудников
enum SalarySize: Double {
    case min = 15000
    case mid = 30000
    case max = 50000
}

// создаем зарплатный протокол с зарплатой!
protocol Salaryable{
    var salary:SalarySize {get set}
}

//создаем класс работников содержащий фамилию, имя, отчество и зарплату сотрудника
open class Workers: Salaryable {
    var name:String
    var salary:SalarySize
    init (name:String, salary: SalarySize) {
        self.name = name
        self.salary = salary
    }
}

// добавляем возможность к классу Workers выводить данные сотрудника на экран с помощью расширения с соответствующим протоколом
extension Workers : CustomStringConvertible {
    public var description : String {
        return "\n [\(self.name) получает \(self.salary.rawValue) рублей в месяц]"
    }
}

// создаем очередь из сотрудников
struct Queue<T: Salaryable> {
    
    public var elements: [T] = []
    
    // создаем проверку на пустую очередь
    fileprivate var isEmpty: Bool {
        return elements.isEmpty
    }
    
    // добавляем сотрудника в конец очереди на увольнение
    public mutating func invite (_ element: T) {
        elements.append(element)
    }
    
    // увольняем первого сотрудника из очереди на увольнение
    public mutating func kick () -> T? {
        
        // если очередь на увольнение пуста пишем ошибку
        if isEmpty {
            print("Error: Вы уволили всех сотрудников!")
            return nil
        }
            
            // если нет, увольняем первого в очереди сотрудника
        else {
            return elements.removeFirst()
        }
    }
    
    // создаем subscript, который будет возвращать ошибку в случае обращения к несуществующему индексу
    subscript (elements: UInt ...) -> Bool? {
        for index in elements where (index > self.elements.count) || (index < 1 && self.elements.count < 1) {
            print("Error: Такого сотрудника больше не существует...")
        }
        return nil
    }
    
}

// делаем разграничитель
fileprivate func PrintLine () {
    print("=========================================")
}

// выводим данные на экран
var queueWorkers = Queue<Workers>()

queueWorkers.invite(Workers (name: "Иванов Иван Иванович", salary: .min))
print(queueWorkers)
queueWorkers.invite(Workers (name: "Алексеев Алексей Алексеевич", salary: .mid))
print(queueWorkers)
queueWorkers.invite(Workers (name: "Дмитриев Дмитрий Дмитриевич", salary: .min))
print(queueWorkers)
queueWorkers.invite(Workers (name: "Сергеев Сергей Сергеевич", salary: .max))
print(queueWorkers)

PrintLine ()

queueWorkers.kick()
print(queueWorkers)
queueWorkers.kick()
print(queueWorkers)
queueWorkers.kick()
print(queueWorkers)
queueWorkers.kick()
print(queueWorkers)

PrintLine ()

// смотрим работу проверки на пустую очередь
queueWorkers.kick()
print(queueWorkers)

PrintLine ()

// проверяем работу сабскрипта
var i: UInt = 0
i = 0
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

queueWorkers.invite(Workers (name: "Пушкин Сергей Александрович", salary: .max))
queueWorkers.invite(Workers (name: "Шварцнегер Арнольд Петрович", salary: .max))
print(queueWorkers)
PrintLine ()

i = 2
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

i = 1
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

// при обращении к индексу 2 он почему-то не реагирует ошибкой, ведь индекса в данном случае всего два 0 и 1. Если оставить одного работника то будет то же самое только с индексом 1. Получается он не реагирует на обращение к следующему по индексу, но несуществующему элементу. ВОПРОС - Почему?
i = 2
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

i = 3
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

i = 0
print(queueWorkers[i] ?? ">>>>Было обращение к индексу \(i)\n")

PrintLine ()
//======================================== ВОПРОС. Как все-таки лучше описывать стек - структурой или классом?
//Класс QueueTwo не хочет наследовать параметры name и salary от Workers.
//class QueueTwo<T2: CustomStringConvertible> {
//    private var elements: [T2] = []
//     func invite (_ element: T2){
//        elements.append(element)
//    }
//     func kick () ->T2? {
//        return elements.removeFirst()
//    }
//}
//========================================

//=========================================== замыкания не получаются...ВОПРОС: Как его здесь применить? ниже мои жалкие попытки:

//let sorted = queueWorkers.elements.sorted (by: >)
//
//var array = queueWorkers
//var maxSalary = 20000
//var zp = salary.rawValue
//
//let exclude: (Double) -> Bool = {(salary.rawValue: Double) -> Bool in
//    return zp > maxSalary
//}
//
//func filter(array: [T], predicate: (T) -> Bool) -> [T] {
//
//    var tmpArray = [T]()
//
//    for element in array {
//        if predicate(element) {
//            tmpArray.append(element)
//        }
//    }
//
//    return tmpArray
//}
//
//let excludeArray = filter(array: array, predicate: exclude)
//print(excludeArray)


// ===========================================ниже примеры замыканий из урока 6 ============================================


//let closure: (Int, Int) -> Bool = {(itemOne: Int, itemTwo: Int) -> Bool in
//    return itemOne == itemTwo
//}
//
//let someClosure = closure(2, 2)
//print(someClosure)
//
//let odd: (Int) -> Bool = {(element: Int) -> Bool in
//    return element % 2 == 0
//}
//
//let queueClosure = odd(22)
//print(queueClosure)
//


//let odd: (Int) -> Bool = {(element: Int) -> Bool in
//    return element % 2 == 0
//}
//
//let even: (Int) -> Bool = {(element: Int) -> Bool in
//    return element % 2 != 0
//}
//
//let three: (Int) -> Bool = {(element: Int) -> Bool in
//    return element % 3 == 0
//}
//
//let onlyTwo: (Int) -> Bool = {(element: Int) -> Bool in
//    if element == 2 {
//        return true
//    }
//    return false
//}
//var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//
//func filter(array: [Int], predicate: (Int) -> Bool) -> [Int] {
//
//    var tmpArray = [Int]()
//
//    for element in array {
//        if predicate(element) {
//            tmpArray.append(element)
//        }
//    }
//
//    return tmpArray
//}
//
//let oddArray = filter(array: array, predicate: odd)
//print(oddArray)
//
//let evenArray = filter(array: array, predicate: even)
//print(evenArray)
//
//let threeArray = filter(array: array, predicate: three)
//print(threeArray)
//
//let onlyTwoArray = filter(array: array, predicate: onlyTwo)
//print(onlyTwoArray)
//
//print("=========================================")
//
//print(array.filter{ $0 % 2 == 0 })
//print(array.filter{ $0 % 2 != 0 })
//array.sort{ $0 > $1 }
//print(array)
//print(array.map{ $0 * $0 })
//print(array.reduce(0){ $0 + $1 })
//array.forEach() {
//    print($0)
//}





