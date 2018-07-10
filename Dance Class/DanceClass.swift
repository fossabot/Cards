import Foundation

class DanceClass: Decodable {
    
    enum ClassType: String {
        case open = "Open"
        case squad = "Squad"
        case fitness = "Fitness"
        case musical = "Musical"
    }
    
    let name: String
    let type: ClassType
    let address1: String
    let address2: String
    let town: String
    let postcode: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case address1 = "address1"
        case address2 = "address2"
        case town = "town"
        case postcode = "postcode"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = ClassType(rawValue: try values.decode(String.self, forKey: .type))!
        address1 = try values.decode(String.self, forKey: .address1)
        address2 = try values.decode(String.self, forKey: .address2)
        town = try values.decode(String.self, forKey: .town)
        postcode = try values.decode(String.self, forKey: .postcode)
    }
}
