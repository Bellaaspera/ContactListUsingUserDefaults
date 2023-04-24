//
//  MainViewController.swift
//  ContactListUsingUserDefaults
//
//  Created by Светлана Сенаторова on 24.04.2023.
//

import UIKit

protocol AddViewControllerDelegate {
    func save(contact: Contact)
}

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var contacts: [Contact] = StorageManager.shared.fetchContacts()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: - @IBAction
    
    @IBAction func addContactPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createContact", sender: nil)
    }
    
// MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addVC = segue.destination as? AddViewController else { return }
        addVC.delegate = self
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = contacts[indexPath.row].fullname
        content.secondaryText = contacts[indexPath.row].phone
        content.image = UIImage(systemName: "person")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteContacts(at: indexPath.row)
        }
    }
}

// MARK: - AddViewControllerDelegate

extension MainViewController: AddViewControllerDelegate {
    
    func save(contact: Contact) {
        contacts.append(contact)
        StorageManager.shared.save(contact: contact)
        tableView.reloadData()
    }
    
}
