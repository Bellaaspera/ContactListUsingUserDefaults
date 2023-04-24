//
//  AddViewController.swift
//  ContactListUsingUserDefaults
//
//  Created by Светлана Сенаторова on 24.04.2023.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var doneButton: UIButton!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var surnameTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    
    var contact: Contact?
    var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton.isEnabled = false
        nameTF.addTarget(
            self,
            action: #selector(nameTFDidChanged),
            for: .editingChanged
        )
    }
    
    @IBAction func canselPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func donePressed() {
        save()
        dismiss(animated: true)
    }
    
    @objc func nameTFDidChanged() {
        guard let name = nameTF.text else { return }
        doneButton.isEnabled = !name.isEmpty
    }
    
    private func save() {
        let contact = Contact(
            name: nameTF.text ?? "",
            surname: surnameTF.text ?? "",
            phone: phoneTF.text ?? ""
        )
        delegate?.save(contact: contact)
    }
}
