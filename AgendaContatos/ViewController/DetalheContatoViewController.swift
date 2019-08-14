//
//  DetalheContatoViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 02/08/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

protocol ContatosProtocol {
    func updateContact(newContact: Contato)
}


class DetalheContatoViewController: UIViewController {

    @IBOutlet var ligarButton: UIButton!
    @IBOutlet var contactTelefone: UILabel!
    @IBOutlet var contactName: UILabel!
    @IBOutlet var fotoPerfil: UIImageView!
    
    var contato: Contato?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes"
        loadContato()
        layoutLabels()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addViewController))

    }
    
    func loadContato(){
        if let c = self.contato{
            contactName.text = c.name
            contactTelefone.text = c.phone
        }
        
    }
    func layoutLabels(){
        fotoPerfil.layer.cornerRadius = fotoPerfil.frame.width/2
        ligarButton.layer.cornerRadius = 10
        ligarButton.backgroundColor = UIColor.buttonColor
        
    }

    @objc private func addViewController(){
        let viewController = AdicionarContatoViewController()
        viewController.contato = self.contato
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    
    }

}
extension DetalheContatoViewController: ContatosProtocol{
    func updateContact(newContact: Contato) {
        self.contato = newContact
        loadContato()
    }
}
