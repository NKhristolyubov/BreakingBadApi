//
//  CharactersTableViewController.swift
//  BreakingBadApi
//
//  Created by Николай Христолюбов on 08.11.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    private var characters: [Character] = []
    private var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterCell
        
        let character = characters[indexPath.row]
       
        cell.configure(with: character)

        return cell
    }
    
    private func fetchData() {
        Networking.shared.fetchData(url: Link.characters.rawValue) { character in
            self.characters = character
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
