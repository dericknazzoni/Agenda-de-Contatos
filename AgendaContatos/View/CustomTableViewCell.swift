//
//  CustomTableViewCell.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 31/07/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var contatoNome: UILabel!
    @IBOutlet var contatoTelefone: UILabel!
    @IBOutlet var contatoImagem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contatoImagem.layer.cornerRadius = contatoImagem.frame.width/2
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
