//
//  PokedexViewController.swift
//  PokeFinder
//
//  Created by Jelmar Van Aert on 21/02/2017.
//  Copyright © 2017 Jelmar Van Aert. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredPokemon = [String]()
    var inSearchMode = false
    var location: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    func getPokeId(pokeName: String) -> Int? {
        
        return pokemon.index(of: pokeName)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier, for: indexPath) as? PokeCollectionViewCell {
            
            var pokeName: String!
            
            if inSearchMode {
                pokeName = filteredPokemon[indexPath.row]
            }else {
                pokeName = pokemon[indexPath.row]
            }
            
            cell.configureCell(name: pokeName)
            
            return cell
            
        }else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //segue
        var pokeName: String!
        
        if inSearchMode {
           pokeName = filteredPokemon[indexPath.row]
        }else {
            pokeName = pokemon[indexPath.row]
        }
        
        if let pokeId = getPokeId(pokeName: pokeName) {
            if let vc = navigationController?.viewControllers[0] as? ViewController {
                vc.createSighting(forLocation: location!, withPokemon: pokeId + 1)
            } else {
                print("SOMTHING WENT WRON WITH CASTING THE VC")
            }
        }else {
            print("SOMTHING WENT WRONG WITH THE POKEID")
        }
        
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({ $0.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
