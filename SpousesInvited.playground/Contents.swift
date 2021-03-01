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

struct Family: Equatable, CustomStringConvertible {
    let firstSpouse: Person
    let secondSpouse: Person
    
    var description: String {
        return firstSpouse.name + " and " + secondSpouse.name
    }
}

let a = Person(name: "Ash")
let b = Person(name: "Billie")
let c = Person(name: "Chris")
let d = Person(name: "Dee")
let e = Person(name: "Emily")
let f = Person(name: "Frank")
let g = Person(name: "George")
let h = Person(name: "Harry")

var invitedPersons: Array<Person> = [a, b, c, d, e, f, g, h]
var couples: Array<Family> = [Family(firstSpouse: a, secondSpouse: h),
                              Family(firstSpouse: c, secondSpouse: d),
                              Family(firstSpouse: g, secondSpouse: b)]

func buildFamiliesIndex(families: Array<Family>) -> Dictionary<Person, Family> {
    var dict = Dictionary<Person, Family>()
    for family in families {
        dict[family.firstSpouse] = family
        dict[family.secondSpouse] = family
    }
    return dict
}

func findInvitedFamilies(invitedPersons: Array<Person>, existingFamilies: Array<Family>) -> Array<Family> {
    var invitedFamilies = Array<Family>()
    let familyIndex = buildFamiliesIndex(families: existingFamilies)
    for person in invitedPersons {
        if let family = familyIndex[person],
           invitedPersons.contains(family.firstSpouse),
           invitedPersons.contains(family.secondSpouse),
           !invitedFamilies.contains(family) {
            invitedFamilies.append(family)
        }
    }
    print(invitedFamilies)
    return invitedFamilies
}

func findFirstInvitedFamily(invitedPersons: Array<Person>, existingFamilies: Array<Family>) -> Family? {
    var checkedFamilyMembers = Array<Person>()
    let familyIndex = buildFamiliesIndex(families: existingFamilies)
    for person in invitedPersons {
        checkedFamilyMembers.append(person)
        if let family = familyIndex[person] {
            if checkedFamilyMembers.contains(family.firstSpouse),
               checkedFamilyMembers.contains(family.secondSpouse) {
                return family
            }
        }
    }
    return nil
}

findInvitedFamilies(invitedPersons: invitedPersons, existingFamilies: couples)
findFirstInvitedFamily(invitedPersons: invitedPersons, existingFamilies: couples)
