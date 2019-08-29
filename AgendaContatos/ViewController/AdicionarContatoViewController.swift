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
    
    var edditngView: Bool = false
    var delegate: ContatosProtocol?
    var delegateAdd: AddContactProtocol?
    
    var contato: Contato?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Novo Contato"
        layoutSetup()
        loadContatoEditar()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @objc func closeKeyboard(){
        self.view.endEditing(true)
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
    
    @IBAction func addContact(_ sender: UIButton) {
        if edditngView {
            // cria um contato com id igual esse
            // atualiza o nome e telefone se foi alterado
            // salvar na api
            var c = contato ?? Contato()
            c.name = apelidoTextField.text
            c.phone = telefoneTextField.text
            ContactService.putContact(contato: c) { (error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }else{
                    let alert = UIAlertController(title: "Erro ao editar", message: "Problemas tecnicos", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))

                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                }
            }
            
        } else {
            var newContact = Contato()
            newContact.name = apelidoTextField.text ?? ""
            newContact.phone = telefoneTextField.text ?? ""
            ContactService.postContact(contato: newContact) { (error) in
                if error == nil{
//                    self.delegateAdd?.addNewContact(newContact: newContact)
                    DispatchQueue.main.async {
                         self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    let alert = UIAlertController(title: "Erro ao adicionar", message: "Problemas tecnicos", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                }
            }
                

        }
    }
        
        
        
}


