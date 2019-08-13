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
    
    func addContact(){
        
    }
    
    
    
}
