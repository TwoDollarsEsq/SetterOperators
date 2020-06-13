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

    static var allTests = [
        ("testStructUpdating", testStructUpdating),
        ("testClassUpdating", testClassUpdating)
    ]
}
