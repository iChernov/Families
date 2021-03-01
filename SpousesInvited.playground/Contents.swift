import UIKit


class Person: NSObject {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    override var description: String {
        return name
    }
}

typealias Family = (Person, Person)

let a = Person(name: "Ash")
let b = Person(name: "Billie")
let c = Person(name: "Chris")
let d = Person(name: "Dee")
let e = Person(name: "Emily")
let f = Person(name: "Frank")
let g = Person(name: "George")
let h = Person(name: "Harry")

var invitedPersons: Array<Person> = [a, b, c, d, e, f, g, h]
var couples: Array<Family> = [Family(a, h), Family(c, d), Family(g,b)]

func findFamily(of person: Person, in families: Array<Family>) -> Family? {
    return families.first(where: { $0.1 == person || $0.0 == person })
}

func findInvitedFamilies(invitedPersons: Array<Person>, existingFamilies: Array<Family>) -> Array<Family> {
    var invitedFamilies = Array<Family>()
    var checkedFamilyMembers = Array<Person>()
    for person in invitedPersons {
        if let family = findFamily(of: person, in: existingFamilies),
           invitedPersons.contains(family.0),
           invitedPersons.contains(family.1),
           !checkedFamilyMembers.contains(family.0),
           !checkedFamilyMembers.contains(family.1) {
            checkedFamilyMembers.append(family.0)
            checkedFamilyMembers.append(family.1)
            invitedFamilies.append(family)
        }
    }
    print(invitedFamilies)
    return invitedFamilies
}

func findFirstInvitedFamily(invitedPersons: Array<Person>, existingFamilies: Array<Family>) -> Family? {
    var checkedFamilyMembers = Array<Person>()
    for person in invitedPersons {
        checkedFamilyMembers.append(person)
        if let family = findFamily(of: person, in: existingFamilies) {
            if checkedFamilyMembers.contains(family.0),
               checkedFamilyMembers.contains(family.1) {
                return family
            }
        }
    }
    
    return nil
}

findInvitedFamilies(invitedPersons: invitedPersons, existingFamilies: couples)
findFirstInvitedFamily(invitedPersons: invitedPersons, existingFamilies: couples)
