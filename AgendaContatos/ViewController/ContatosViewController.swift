//
//  ContatosViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 31/07/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

class ContatosViewController: UIViewController {

    @IBOutlet weak var tabelaContatos: UITableView!
    @IBOutlet weak var buscaContato: UISearchBar!
    
    var contatos: [String] = ["derick", "breno", "renato", "gato", "gabriel", "pedro", "xandin", "lyra"]
    var selectedContact: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelaContatos.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tabelaContatos.delegate = self
        tabelaContatos.dataSource = self
        self.tabelaContatos.reloadData()
        title = "Meus Contatos"
    

        // Do any additional setup after loading the view.
    }

}
extension ContatosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let contato = contatos[indexPath.row]
        cell.contatoNome.text = "\(contato)"
        cell.contatoNome.font = UIFont.boldSystemFont(ofSize: 20)
        cell.contatoNome.textColor = UIColor.primaryColor
        cell.contatoTelefone.textColor = UIColor.secondaryColor
        tableView.tableFooterView = UIView()
        return cell
    }
    
    
}
extension ContatosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactSelected = contatos[indexPath.row]
        self.selectedContact = contactSelected
        let testeViewController = DetalheContatoViewController()
        testeViewController.contactText = selectedContact
        self.navigationController?.pushViewController(testeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
}

