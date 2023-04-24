//
//  StorageManager.swift
//  ContactListUsingUserDefaults
//
//  Created by Светлана Сенаторова on 24.04.2023.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let storageKey = "contactKey"
    
    init() {}
    
    func save(contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        defaults.set(data, forKey: storageKey)
    }
    
    func fetchContacts() -> [Contact] {
        guard let data = defaults.data(forKey: storageKey) else { return [] }
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    
    func deleteContacts(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
