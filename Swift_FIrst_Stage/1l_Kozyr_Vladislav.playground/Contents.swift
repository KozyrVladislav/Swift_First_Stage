import UIKit

let a: Double = 4
let b: Double = 8
let c: Double = 3

var D: Double = 0
var x1: Double = 0
var x2: Double = 0

print("Решаем квадратное уравнение \(a)xˆ2 + \(b)x + \(c) = 0")
//a*xˆ2+b*x+c=0
D = b * b - 4 * a * c

if D > 0 {
    print("Дискриминант больше нуля. Два корня.")
    x1 = (-b + sqrt(D)) / (2 * a)
    x2 = (-b - sqrt(D)) / (2 * a)
    print("X1 = \(x1) , X2 = \(x2)")
} else if D == 0 {
    print("Дискриминант равен нулю. Один корень.")
    x1 = (-b + sqrt(D)) / (2 * a)
    print("X1 = X2 = \(x2)")
} else {
    print("Дискриминант меньше нуля. Нет корней.")
}




print("")
print("Отлично, а теперь найдем площадь, периметр и гипотенузу прямоугольного треугольника.")
print("")

let k1: Double = 4
let k2: Double = 8

var S: Double = 0
var P: Double = 0
var G: Double = 0

print("Катеты нашего прамоугольного треугольника равны: \(k1); \(k2)")

G = sqrt(k1 * k1 + k2 * k2)
print("Гипотенуза равна: \(G)")
S = (k1*k2) / 2
print("Площадь равна: \(S)")
P = k1 + k2 + G
print("Периметр равен: \(P)")
print("А сюда можно поставить оценку за задание: ")
