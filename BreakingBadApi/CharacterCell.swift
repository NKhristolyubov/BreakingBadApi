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
        
        getImage(url) { result in
            switch result {
            case .success(let image):
                if url == self.imageURL {
                    self.photoView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    private func getImage(_ url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        
        if let cacheImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            completion(.success(cacheImage))
            print("image from cache: \(url.absoluteString)")
            return
        }
        
        Networking.shared.fetchImage(url: url) { image in
            guard let image = UIImage(data: image) else {return}
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
            completion(.success(image))
            print("image from network: \(url.hashValue)")
            return
        }
    }
}

