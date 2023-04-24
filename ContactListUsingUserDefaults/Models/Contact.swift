//
//  Contact.swift
//  ContactListUsingUserDefaults
//
//  Created by Светлана Сенаторова on 24.04.2023.
//

import Foundation

struct Contact: Codable {
    var name: String
    var surname: String
    var phone: String
    
    var fullname: String {
        name + " " + surname
    }
}
