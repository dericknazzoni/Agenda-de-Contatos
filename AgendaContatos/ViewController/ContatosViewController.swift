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
    
    var contatos: [String] = ["Derick", "Breno", "Renato", "Gato", "Gabriel", "Pedro", "Xandin", "Lyra"]
    var selectedContact: String?
    var searchFilter = [String]()
    var searching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelaContatos.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tabelaContatos.delegate = self
        tabelaContatos.dataSource = self
        buscaContato.delegate = self
        self.tabelaContatos.reloadData()
        title = "Meus Contatos"

    }

}
extension ContatosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchFilter.count
        }else{
            return contatos.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        if searching{
            cell.contatoNome.text = searchFilter[indexPath.row]
        }else{
            cell.contatoNome.text = contatos[indexPath.row]
        }
//        let contato = contatos[indexPath.row]
//        cell.contatoNome.text = "\(contato)"
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
extension ContatosViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFilter = contatos.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tabelaContatos.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        buscaContato.text = ""
        tabelaContatos.reloadData()
    }
}

