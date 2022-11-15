//
//  CharacterCell.swift
//  BreakingBadApi
//
//  Created by Николай Христолюбов on 08.11.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    var imageURL: URL? {
        didSet {
            photoView.image = nil
            setImage()
        }
    }
    
    func configure(with character: Character) {
        
        nameLabel.text = character.name
        nickNameLabel.text = character.nickname
        statusLabel.text = character.status
        imageURL = URL(string: character.img)
    }
    
    private func setImage() {
        
        guard let url = imageURL else { return }
        Networking.shared.fetchImage(url: url) { image in
            if url == self.imageURL {
                self.photoView.image = UIImage(data: image)
            }
        }
        
    }
    
}
