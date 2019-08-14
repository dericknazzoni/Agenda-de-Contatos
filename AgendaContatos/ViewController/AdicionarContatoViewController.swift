//
//  AdicionarContatoViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 02/08/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

class AdicionarContatoViewController: UIViewController {
    
    @IBOutlet var perfilView: UIImageView!
    @IBOutlet var apelidoTextField: UITextField!
    @IBOutlet var telefoneTextField: UITextField!
    @IBOutlet var salvarButton: UIButton!
    
    var delegate: ContatosProtocol?
    var delegateAdd: AddContactProtocol?
    
    var contato: Contato?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Novo Contato"
        layoutSetup()
        loadContatoEditar()

    }
    
    func layoutSetup(){
        salvarButton.layer.cornerRadius = 10
        perfilView.layer.cornerRadius = perfilView.frame.width/2
        salvarButton.backgroundColor = UIColor.buttonColor
    }
    
    func loadContatoEditar(){
        if let c = self.contato{
            apelidoTextField.text = c.name
            telefoneTextField.text = c.phone
        }
    }
    
    @IBAction func addContact(_ sender: Any) {
        if var c = self.contato{
            c.name = apelidoTextField.text ?? ""
            c.phone = telefoneTextField.text ?? ""
            delegate?.updateContact(newContact: c)
            self.navigationController?.popViewController(animated: true)
        
        }else {
            var newContact = Contato()
            newContact.name = apelidoTextField.text ?? ""
            newContact.phone = telefoneTextField.text ?? ""
            delegateAdd?.addNewContact(newContact: newContact)
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }

}
