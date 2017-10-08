//
//  ViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/7/31.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let test = data.cafe.keys
    
    var sections = [
        Section(genre: "🦁 義式咖啡",
                catergories: Array(data.cafe.keys).sorted(by: <),
                expanded: false),
        Section(genre: "💥 鮮奶茶系列",
                catergories: Array(data.milk.keys).sorted(by: <),
                expanded: false),
        Section(genre: "👻 鮮茶系列",
                catergories: Array(data.tea.keys).sorted(by: <),
                expanded: false),
        Section(genre: "😂 水果茶系列",
                catergories: Array(data.fruittea.keys).sorted(by: <),
                expanded: false),
        Section(genre: "😍 花草與養生系列",
                catergories: Array(data.flowertea.keys).sorted(by: <),
                expanded: false),
        Section(genre: "😎 輕食系列",
                catergories: Array(data.food.keys).sorted(by: <),
                expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].catergories.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].catergories[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].catergories.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productInfoScreen = storyboard?.instantiateViewController(withIdentifier: "product info view") as! ProductInfoViewController
        //print("Prodact Details \(details)");
        productInfoScreen.categoryName = sections[indexPath.section].genre
        productInfoScreen.setTitle = sections[indexPath.section].catergories[indexPath.row]
        navigationController?.show(productInfoScreen, sender: self);
    }
}
