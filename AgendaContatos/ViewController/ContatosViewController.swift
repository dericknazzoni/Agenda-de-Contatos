//
//  ContatosViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 31/07/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

class ContatosViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet weak var tabelaContatos: UITableView!
    @IBOutlet weak var buscaContato: UISearchBar!
    
    var contatos: [String] = ["Derick", "Breno", "Renato", "Gato", "Gabriel", "Pedro", "Xandin", "Lyra", "Maurao",
                              "Bruno", "Renan"]
    
    var selectedContact: String?
    var searchFilter = [String]()
    var searching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        buscaContato.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector
            (addViewController))
        setBackground()

    }
    @objc private func addViewController(){
        navigationController?.pushViewController(AdicionarContatoViewController(), animated: true)
    }
    
    private func setUpNavigation(){
         title = "Meus Contatos"
        tabelaContatos.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier:
            "customCell")
        tabelaContatos.delegate = self
        tabelaContatos.dataSource = self
        self.tabelaContatos.reloadData()
    }
    
    func setBackground() {
        view.addSubview(tabelaContatos)
        tabelaContatos.translatesAutoresizingMaskIntoConstraints = false
        tabelaContatos.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabelaContatos.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabelaContatos.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
    
    func alert(title: String, message: String, yesAction: @escaping ()-> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            yesAction()
        }))
        
        present(alert, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
       
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:@escaping (Bool) -> Void) in
            
            self.alert(title: "Apagar", message: "Deseja realmente apagar este contato de sua lista?", yesAction: {
                self.contatos.remove(at: indexPath.row)
                self.tabelaContatos.reloadData()
                success(true)
            })

 
        })
        deleteAction.backgroundColor = UIColor.buttonColor
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
extension ContatosViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFilter = contatos.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tabelaContatos.reloadData()
        setupView()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        buscaContato.text = ""
        tabelaContatos.reloadData()
        setupView()
    }
    
    func setupView() {
        if searchFilter.count == 0 {
            self.tabelaContatos.isHidden = true
            self.resultLabel.isHidden = false
            self.resultLabel.text = "Nenhum resultado encontrado"
            self.resultLabel.textColor = UIColor.secondaryColor
            self.resultLabel.adjustsFontSizeToFitWidth = true
            
        } else {
            self.tabelaContatos.isHidden = false
        }
    }
}

