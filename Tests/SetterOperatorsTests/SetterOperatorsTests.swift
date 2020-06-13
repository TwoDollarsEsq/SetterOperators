import XCTest
import SetterOperators

final class SetterOperatorsTests: XCTestCase {
    func testStructUpdating() {
        // Given
        struct Person: Equatable {
            struct Name: Equatable {
                var first, last: String
            }
            
            var name: Name = .init(first: "Joe", last: "Andersen")
            var age: UInt = 21
        }
        let newName = Person.Name(first: "Hanna", last: "Andersen")
        let newAge  = 22 as UInt
        let result = Person(name: newName, age: newAge)
        
        // When
        let person = Person()
            .. \.name.first .= newName.first
            .. \.age .= newAge
        
        // Then
        XCTAssert(person == result)
    }
    
    func testClassUpdating() {
        // Given
        final class Person {
            init(
                name: Name = .init(first: "Joe", last: "Andersen"),
                age: UInt = 21
            ) {
                self.name = name
                self.age = age
            }
            
            struct Name: Equatable {
                var first, last: String
            }
            
            var name: Name
            var age: UInt
        }
        
        let newName = Person.Name(first: "Hanna", last: "Andersen")
        let newAge  = 22 as UInt
        let result = Person(name: newName, age: newAge)
        
        // When
        let person = Person()
            .. \.name.first .= newName.first
            .. \.age .= newAge
        
        // Then
        XCTAssert(person.name == person.name && result.age == result.age)
    }
    
    class Value {
        init() {}
        var a: Int = 0
        var b: Int = 0
        var c: Int = 0
        var d: Int = 0
        var e: Int = 0
        var f: Int = 0
        var g: Int = 0
        var h: Int = 0
    }
    
    let N = 100000
    
    func testRawPerformance() {
        self.measure {
            @discardableResult
            func getValue() -> Value {
                let value = Value()
                value.a = 42
                value.b = 42
                value.c = 42
                value.d = 42
                value.e = 42
                value.f = 42
                value.g = 42
                value.h = 42
                return value
            }
            
            for _ in 0...N {
                getValue()
            }
        }
    }
    
    func testOperatorPerformance() {
        self.measure {
            @discardableResult
            func getValue() -> Value {
                .init()
                    .. \.a .= 42
                    .. \.b .= 42
                    .. \.c .= 42
                    .. \.d .= 42
                    .. \.e .= 42
                    .. \.f .= 42
                    .. \.g .= 42
                    .. \.h .= 42
            }
            
            for _ in 0...N {
                getValue()
            }
        }
    }

    static var allTests = [
        ("testStructUpdating", testStructUpdating),
        ("testClassUpdating", testClassUpdating)
    ]
}
