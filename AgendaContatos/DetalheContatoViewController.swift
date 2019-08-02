//
//  DetalheContatoViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 02/08/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

class DetalheContatoViewController: UIViewController {

    @IBOutlet var ligarButton: UIButton!
    @IBOutlet var contactTelefone: UILabel!
    @IBOutlet var contactName: UILabel!
    @IBOutlet var fotoPerfil: UIImageView!
    
    var contactText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = contactText
        title = "Detalhes"

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
