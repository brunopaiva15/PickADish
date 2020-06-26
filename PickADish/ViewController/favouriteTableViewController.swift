//
//  favoriteTableViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 20.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit

class favouriteTableViewController: UITableViewController {
    
    // Variable qui contient le tableau des favoris
    var favourites = UserDefaults.standard.object(forKey: "PAD_FAVOURITES") as? [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    // Fonction qui retourne le nombre de sections de la TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Fonction qui retourne le nombre de cellules dans la tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites?.count ?? 0
    }
    
    // Fonction qui crées les cellules dans la tableView avec le contenu du tableau des favoris
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        cell.textLabel?.text = favourites![indexPath.row]

        return cell
    }
    
    // Fonction qui permet de supprimer un favori
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SettingsBundleHelper.DeleteDishFromFavourites(index: indexPath.row)
            favourites!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Fonction qui désactive le style de sélection de toutes les cellules
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
    // Fonction qui détecte le changement du mode sombre au mode clair et inversement
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        changeColors()
    }
    
    // Fonction qui génère le changement de couleur lorsque celles-ci ne sont pas activées
    func changeColors() {
        var color1: UIColor
        var color2: UIColor
        
        // Si l'appareil iOS est sous iOS 13, obtenir la couleur du thème clair ou sombre, sinon mettre le fond en blanc
        if #available(iOS 13.0, *) {
            color1 = UIColor.systemBackground
        } else {
            color1 = UIColor.white
        }
    
        // Obtenir l'inverse de la couleur principale
        let ciColor = CIColor(color: color1)
    
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
        // Mettre la couleur inversée pour les titres de la navigation
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        
        navigationController?.navigationBar.barTintColor = color1
        self.view.backgroundColor = color1
    }
    
    // Pour tout le reste, mettre la couleur principale
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Plats favoris"
    }
}
