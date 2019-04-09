//
//  ViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/7/31.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var activityView:UIActivityIndicatorView!

    
    var cafes = [DrinkModel]()
    var milks = [DrinkModel]()
    var teas = [DrinkModel]()
    var fruits = [DrinkModel]()
    
    var filteredCafe = [DrinkModel]()
    var filteredTeas = [DrinkModel]()
    var filteredMilk = [DrinkModel]()
    var filteredFruits = [DrinkModel]()
    
    let searchController = UISearchBar()

//    var sections = ["1","2","3","4"]
    
    
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        ref = Database.database().reference()

        
        //self.navigationController?.navigationBar.titleTextAttributes = frame(
//        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 100, vertical: 30), for: UIBarMetrics.default)
        //self.navigationItem.titleView = UIView(frame: (CGRectMake(10, 1, 50, 10)))
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 21)!
            
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(GroupViewController.cartScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
        
        let mainButton = UIBarButtonItem(image: UIImage(named: "home30"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(GroupViewController.mainScreen))
        
        self.navigationItem.leftBarButtonItem = mainButton
        
        
        //UINavigationBar.appearance().tintColor = UIColor.white
        
        // Hide Back Button - to prevent showing two buttons with the same purpose
        self.navigationItem.backBarButtonItem?.isEnabled = false
        
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = self.view.center
        
        view.addSubview(activityView)
        
        fetchDrinks()
        
        configureSearchBar()

        
        
        
        
    }
    

    
    @objc func cartScreen(){
        let shoppingCartScreen = storyboard?.instantiateViewController(withIdentifier: "shopping cart view") as! ShoppingCartVC
        
        navigationController?.show(shoppingCartScreen, sender: self)
        activityView.startAnimating()
    }
    
    @objc func mainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "user" ) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // Mark configureSearchBar
    func configureSearchBar() {
        navigationItem.titleView = searchController
        
        
      
        searchController.sizeToFit()
        searchController.placeholder = ""
        searchController.delegate = self
        
        
        definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        guard !searchText.isEmpty else {
            filteredCafe = cafes
            filteredTeas = teas
            filteredMilk = milks
            filteredFruits = fruits
            tableView.reloadData()
            return
        }
        filteredCafe = cafes.filter({ drink -> Bool in
            drink.name!.contains(searchText)
        })
        filteredTeas = teas.filter({ drink -> Bool in
            drink.name!.contains(searchText)
        })
        filteredMilk = milks.filter({ drink -> Bool in
            drink.name!.contains(searchText)
        })
        filteredFruits = fruits.filter({ drink -> Bool in
            drink.name!.contains(searchText)
        })
        tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.showsCancelButton = true
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.showsCancelButton = false
        searchController.text = ""
        searchController.resignFirstResponder()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return filteredCafe.count
        }
        else if section == 1{
            return filteredMilk.count
        }
        else if section == 2{
            return filteredTeas.count
        }else {
            return filteredFruits.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "咖啡系列"
        case 1:
            return "鮮奶系列"
        case 2:
            return "茶系列"
        case 3:
            return "水果茶系列"
        default:
            return ""
        }
    }

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            let headerLabel = UILabel()
            headerLabel.text = "咖啡系列"
            headerLabel.frame = CGRect(x: 12, y: 8, width: 100, height: 35)
            headerLabel.font = UIFont.systemFont(ofSize: 18)
            headerLabel.textColor = UIColor.gray
            
            headerView.addSubview(headerLabel)
            return headerView
            
        case 1:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            let headerLabel = UILabel()
            headerLabel.text = "鮮奶系列"
            headerLabel.frame = CGRect(x: 12, y: 8, width: 100, height: 35)
            headerLabel.font = UIFont.systemFont(ofSize: 18)
            headerLabel.textColor = UIColor.gray
            
            headerView.addSubview(headerLabel)
            return headerView
        case 2:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            let headerLabel = UILabel()
            headerLabel.text = "茶系列"
            headerLabel.frame = CGRect(x: 12, y: 8, width: 100, height: 35)
            headerLabel.font = UIFont.systemFont(ofSize: 18)
            headerLabel.textColor = UIColor.gray
            
            headerView.addSubview(headerLabel)
            return headerView
        case 3:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            let headerLabel = UILabel()
            headerLabel.text = "水果茶系列"
            headerLabel.frame = CGRect(x: 12, y: 8, width: 100, height: 35)
            headerLabel.font = UIFont.systemFont(ofSize: 18)
            headerLabel.textColor = UIColor.gray
            
            headerView.addSubview(headerLabel)
            return headerView
        default:
            let headerView = UIView()
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
//        cell.textLabel?.text = sections[indexPath.section].catergories[indexPath.row]
        

        if indexPath.section == 0{
            let textlabelPrice = cell.viewWithTag(3) as! UILabel
            textlabelPrice.text = String(describing: filteredCafe[indexPath.row].price!)
            
            cell.textLabel?.text = filteredCafe[indexPath.row].name
            return cell
        }else if indexPath.section == 1 {
            let textlabelPrice = cell.viewWithTag(3) as! UILabel
            textlabelPrice.text = String(describing: filteredMilk[indexPath.row].price!)
            
            cell.textLabel?.text = filteredMilk[indexPath.row].name
            return cell
        }else if indexPath.section == 2 {
            let textlabelPrice = cell.viewWithTag(3) as! UILabel
            textlabelPrice.text = String(describing: filteredTeas[indexPath.row].price!)
            
            cell.textLabel?.text = filteredTeas[indexPath.row].name
            return cell
        }else {
            let textlabelPrice = cell.viewWithTag(3) as! UILabel
            textlabelPrice.text = String(describing: filteredFruits[indexPath.row].price!)
            
            cell.textLabel?.text = filteredFruits[indexPath.row].name
            return cell
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productInfoScreen = storyboard?.instantiateViewController(withIdentifier: "product info view") as! ProductInfoViewController

        
        if indexPath.section == 0 {
            productInfoScreen.categoryName = filteredCafe[indexPath.row].type!
            productInfoScreen.setTitle = filteredCafe[indexPath.row].name!
            productInfoScreen.price = filteredCafe[indexPath.row].price!
            productInfoScreen.scribe = filteredCafe[indexPath.row].scribe!
            productInfoScreen.calPrice = filteredCafe[indexPath.row].calPrice!
            productInfoScreen.picture = filteredCafe[indexPath.row].picture!
            navigationController?.show(productInfoScreen, sender: self);
        }else if indexPath.section == 1 {
            productInfoScreen.categoryName = filteredMilk[indexPath.row].type!
            productInfoScreen.setTitle = filteredMilk[indexPath.row].name!
            productInfoScreen.price = filteredMilk[indexPath.row].price!
            productInfoScreen.scribe = filteredMilk[indexPath.row].scribe!
            productInfoScreen.calPrice = filteredMilk[indexPath.row].calPrice!
            productInfoScreen.picture = filteredMilk[indexPath.row].picture!
            navigationController?.show(productInfoScreen, sender: self);
        }else if indexPath.section == 2 {
            productInfoScreen.categoryName = filteredTeas[indexPath.row].type!
            productInfoScreen.setTitle = filteredTeas[indexPath.row].name!
            productInfoScreen.price = filteredTeas[indexPath.row].price!
            productInfoScreen.scribe = filteredTeas[indexPath.row].scribe!
            productInfoScreen.calPrice = filteredTeas[indexPath.row].calPrice!
            productInfoScreen.picture = filteredTeas[indexPath.row].picture!
            navigationController?.show(productInfoScreen, sender: self);
        }else {
            productInfoScreen.categoryName = filteredFruits[indexPath.row].type!
            productInfoScreen.setTitle = filteredFruits[indexPath.row].name!
            productInfoScreen.price = filteredFruits[indexPath.row].price!
            productInfoScreen.scribe = filteredFruits[indexPath.row].scribe!
            productInfoScreen.calPrice = filteredFruits[indexPath.row].calPrice!
            productInfoScreen.picture = filteredFruits[indexPath.row].picture!
            navigationController?.show(productInfoScreen, sender: self);
        }
    }
    
    func fetchDrinks() {
        //cafe
        databaseHandle = ref.child("cafeData").observe(.value, with: { (snapshot) in
            var newdrink = [DrinkModel]()
            for drink in snapshot.children.allObjects {
                let drink = DrinkModel(snapshot: drink as! DataSnapshot)
                newdrink.append(drink)
                
            }
            
            self.cafes = newdrink
            self.filteredCafe = self.cafes
            self.tableView.reloadData()
            
            
        })
        databaseHandle = ref.child("teaData").observe(.value, with: { (snapshot) in
            var newtea = [DrinkModel]()
            for tea in snapshot.children.allObjects {
                let tea = DrinkModel(snapshot: tea as! DataSnapshot)
                newtea.append(tea)
                
            }
            
            self.teas = newtea
            self.filteredTeas = self.teas
            self.tableView.reloadData()
            
        })
        
        //fruittea
        
        databaseHandle = ref.child("fruitData").observe(.value, with: { (snapshot) in
            var newfruit = [DrinkModel]()
            for fruit in snapshot.children.allObjects {
                let fruit = DrinkModel(snapshot: fruit as! DataSnapshot)
                newfruit.append(fruit)
                
            }
            
            self.fruits = newfruit
            self.filteredFruits = self.fruits
            self.tableView.reloadData()
            
        })
        
        //milk
        databaseHandle = ref.child("milkData").observe(.value, with: { (snapshot) in
            var newmilk = [DrinkModel]()
            for milk in snapshot.children.allObjects {
                let milk = DrinkModel(snapshot: milk as! DataSnapshot)
                newmilk.append(milk)
                
            }
            
            self.milks = newmilk
            self.filteredMilk = self.milks
            self.tableView.reloadData()
            
        })

        
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        activityView.stopAnimating()
    }
}
