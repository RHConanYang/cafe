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

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    var cafes = [DrinkModel]()
    var milks = [DrinkModel]()
    var teas = [DrinkModel]()
    var fruits = [DrinkModel]()
    
    var section = ["1","2","3","4"]
    
    
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
//    var sections = [
//        Section(type: "🦁 義式咖啡",
//                catergories: []
//                )
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        tableView.dataSource = self
        tableView.delegate = self
        
        ref = Database.database().reference()

        
        //self.navigationController?.navigationBar.titleTextAttributes = frame(
        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 100, vertical: 30), for: UIBarMetrics.default)
        //self.navigationItem.titleView = UIView(frame: (CGRectMake(10, 1, 50, 10)))
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 21)!
            
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(GroupViewController.cartScreen))
        
        self.navigationItem.rightBarButtonItem = cartButton
        
        let mainButton = UIBarButtonItem(image: UIImage(named: "home30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(GroupViewController.mainScreen))
        
        self.navigationItem.leftBarButtonItem = mainButton
        
        
        //UINavigationBar.appearance().tintColor = UIColor.white
        
        // Hide Back Button - to prevent showing two buttons with the same purpose
        self.navigationItem.backBarButtonItem?.isEnabled = false
        
        fetchDrinks()
//        fetchMilk()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cartScreen(){
        let shoppingCartScreen = storyboard?.instantiateViewController(withIdentifier: "shopping cart view") as! ShoppingCartVC
        
        navigationController?.show(shoppingCartScreen, sender: self)
    }
    
    @objc func mainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "user" ) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cafes.count
        }
        else if section == 1{
            return milks.count
        }
        else if section == 2{
            return teas.count
        }else {
            return fruits.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
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
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (sections[indexPath.section].expanded) {
//            return 44
//        } else {
//            return 0
//        }
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 2
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = ExpandableHeaderView()
//        header.customInit(title: sections[section].genre, section: section, delegate: self)
//        return header
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
//        cell.textLabel?.text = sections[indexPath.section].catergories[indexPath.row]
        

        if indexPath.section == 0{
            cell.textLabel?.text = cafes[indexPath.row].name
            return cell
        }else if indexPath.section == 1 {
            cell.textLabel?.text = milks[indexPath.row].name
            return cell
        }else if indexPath.section == 2 {
            cell.textLabel?.text = teas[indexPath.row].name
            return cell
        }else {
            cell.textLabel?.text = fruits[indexPath.row].name
            return cell
        }

        
    }
    
//    func toggleSection(header: ExpandableHeaderView, section: Int) {
//        sections[section].expanded = !sections[section].expanded
//
//
//        tableView.beginUpdates()
//        for i in 0 ..< sections[section].catergories.count {
//            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
//        }
//        tableView.endUpdates()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let productInfoScreen = storyboard?.instantiateViewController(withIdentifier: "product info view") as! ProductInfoViewController
//        //print("Prodact Details \(details)");
//        productInfoScreen.categoryName = cafes[indexPath.row].type!
//        productInfoScreen.setTitle = cafes[indexPath.row].name!
//        productInfoScreen.price = cafes[indexPath.row].price!
//        productInfoScreen.scribe = cafes[indexPath.row].scribe!
//        productInfoScreen.calPrice = cafes[indexPath.row].calPrice!
//        productInfoScreen.picture = cafes[indexPath.row].picture!
//        navigationController?.show(productInfoScreen, sender: self);
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
            self.tableView.reloadData()
            
            
        })
        databaseHandle = ref.child("teaData").observe(.value, with: { (snapshot) in
            var newtea = [DrinkModel]()
            for tea in snapshot.children.allObjects {
                let tea = DrinkModel(snapshot: tea as! DataSnapshot)
                newtea.append(tea)
                
            }
            
            self.teas = newtea
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
            self.tableView.reloadData()
            
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
