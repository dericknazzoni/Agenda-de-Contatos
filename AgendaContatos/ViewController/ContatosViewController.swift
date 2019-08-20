//
//  ContatosViewController.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 31/07/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

protocol AddContactProtocol{
    func addNewContact(newContact: Contato)
}

class ContatosViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet weak var tabelaContatos: UITableView!
    @IBOutlet weak var buscaContato: UISearchBar!
    
    var contatosAtuais: [[Contato]] = []
    var contatos: [Contato]?
    
    var contatosFiltrados = [[Contato]]()
    var searching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        buscaContato.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector
            (addViewController))
        setBackground()
        ContactService.loadContacts(completionHandler: { contato, error in
            if error == nil{
                guard let contact = contato else { return }
                self.contatos = []
                for c in contact {
                    if let contato = c {
                        self.contatos?.append(contato)
                    }
                }
                guard let newList = self.contatos else { return }
                self.reloadData(c: newList)
            }
            DispatchQueue.main.async {
                self.tabelaContatos.reloadData()
            }
            
            
        })

    }
    
//    func loadContatos(){
//
//        var c1 = Contato()
//        c1.name = "Derick"
//        c1.phone = "947377325"
//        var c2 = Contato()
//        c2.name = "Breno"
//        c2.phone = "94737-7325"
//        var c3 = Contato()
//        c3.name = "Renato"
//        c3.phone = "967020576"
//        var c4 = Contato()
//        c4.name = "Lyra"
//        c4.phone = "99999999999"
//        var c5 = Contato()
//        c5.name = "Danilo"
//        c5.phone = "947377325"
//
//        contatos.append(c1)
//        contatos.append(c2)
//        contatos.append(c3)
//        contatos.append(c4)
//        contatos.append(c5)
//        var c6 = Contato()
//        c6.name = "Alberto"
//        c6.phone = "947377325"
//        var c7 = Contato()
//        c7.name = "Andrade"
//        c7.phone = "94737-7325"
//        var c8 = Contato()
//        c8.name = "Carlos"
//        c8.phone = "967020576"
//        var c9 = Contato()
//        c9.name = "Cintia"
//        c9.phone = "99999999999"
//        var c0 = Contato()
//        c0.name = "Barbaro"
//        c0.phone = "947377325"
//
//        contatos.append(c6)
//        contatos.append(c7)
//        contatos.append(c8)
//        contatos.append(c9)
//        contatos.append(c0)
//
//        reloadData(c: contatos)
//      }
    
    func reloadData(c: [Contato]) {
        contatosAtuais = []
        let groupedContacts = sortLists(contatos: c)
        self.contatosAtuais.append(contentsOf: groupedContacts)
        DispatchQueue.main.async {
            self.tabelaContatos.reloadData()
        }
        
    }
    
    func sortLists(contatos: [Contato]) -> [[Contato]]{
    
        let contato = contatos.filter({$0.name != nil})
        
        let sortedContacts = contato.sorted(by: { String(describing: $0.name?.lowercased()) < String(describing: $1.name?.lowercased()) })
        
        let groupedContacts = sortedContacts.reduce([[Contato]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first?.name?.lowercased().first == $1.name?.lowercased().first {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                collection += [[$1]]
            }
            return collection
        }
        return groupedContacts
        
    }
    
    @objc private func addViewController(){
        let viewController = AdicionarContatoViewController()
        viewController.delegateAdd = self
        navigationController?.pushViewController(viewController, animated: true)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80.0, height: 30.0))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        var contato: Contato?
        if searching{
            contato = contatosFiltrados[section][0]
        } else {
            contato = contatosAtuais[section][0]
        }
        guard let text = contato?.name?.first else { return nil }
        label.text = "\(text)"
        label.textColor = UIColor.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.backgroundColor = UIColor.secondaryColor
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searching{
            return contatosFiltrados.count
        }else{
            return contatosAtuais.count
        }
    }

}
extension ContatosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return contatosFiltrados[section].count
        }else{
            return contatosAtuais[section].count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        var contato = Contato()
        
        
        if searching{
            contato = contatosFiltrados[indexPath.section][indexPath.row]
        }else{
            contato = contatosAtuais[indexPath.section][indexPath.row]
        }
        cell.contatoNome.text = contato.name
        cell.contatoNome.font = UIFont.boldSystemFont(ofSize: 20)
        cell.contatoNome.textColor = UIColor.primaryColor
        cell.contatoTelefone.textColor = UIColor.secondaryColor
        cell.contatoTelefone.text = contato.phone
        tableView.tableFooterView = UIView()
        return cell
    }
}
extension ContatosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactSelected = contatosAtuais[indexPath.section][indexPath.row]
        let testeViewController = DetalheContatoViewController()
        testeViewController.contato = contactSelected
        
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
                self.contatosAtuais[indexPath.section].remove(at: indexPath.row)
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

        if searchText.count == 0 {
            searching = false
            tabelaContatos.reloadData()
        }

        let filteredContacts = contatos?.filter({String($0.name?.lowercased().prefix(searchText.count) ?? "") == String(searchText.lowercased())})
        contatosFiltrados = sortLists(contatos: filteredContacts ?? [])
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
        if contatosFiltrados.count == 0 {
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
extension ContatosViewController: AddContactProtocol{
    func addNewContact(newContact: Contato) {
        contatos?.append(newContact)
        reloadData(c: contatos ?? [])
    }
    
    
}
