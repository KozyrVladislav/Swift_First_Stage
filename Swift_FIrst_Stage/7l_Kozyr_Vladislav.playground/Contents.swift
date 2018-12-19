import Foundation
/*1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.

2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.*/

enum WorkersTeamError: Error {
    case notFound
}

struct Person {
    var name: String
    var surname: String
    var experience: Int
    var salary: Int
}

class WorkersTeam {
    var workers = [
        "001": Person(name: "Иван", surname: "Иванович", experience: 3, salary: 30000),
        "002": Person(name: "Дмитрий", surname: "Петрович", experience: 12, salary: 65000),
        "003": Person(name: "Михаил", surname: "Сергеевич", experience: 7, salary: 50000),
        "004": Person(name: "Максим", surname: "Семёнович", experience: 1, salary: 20000)
    ]
    
    func getInfo(number worker: String) throws -> Person {
        guard let man = workers[worker] else {
            throw WorkersTeamError.notFound
        }
        return man
    }
}

extension Person {
    var ageConvert: String {
        if (experience == 0) || (experience >= 5) {
            return "лет"
        } else if experience == 1 {
            return "год"
        } else {
            return "года"
        }
    }
}

extension Person: CustomStringConvertible {
    public var description: String {
        return "Работник \(name) \(surname) с опытом работы \(experience) \(ageConvert) имеет зарплату \(salary) рублей."
    }
}

let workers = WorkersTeam()
do {
    let worker = try workers.getInfo(number: "0030")
    print(worker.description)
} catch WorkersTeamError.notFound {
    print("Ошибка! Работник не найден.")
        
    }


