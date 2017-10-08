//
//  ProductsViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/3/22.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categoryName:String!
    var titles:[String]!
    var details:[[String]]!
    
    var arrayOfProduct: [Product] = [Product]()
    
    override func viewDidLoad() {
        
        title = "\(categoryName!)";
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProductsViewController.cartScreen));
        self.navigationItem.rightBarButtonItem = cartButton;
        
        setUpCategoryName()
        
        setUpProducts()
        
        // Sort product names by ABC...
        //titles.sortInPlace({$0 < $1})
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Navigationbar swipe and hidden OFF
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    // Move to shopping cart screen - Cart Button
    @objc func cartScreen(){
        let shoppingCartScreen = storyboard?.instantiateViewController(withIdentifier: "shopping cart view") as! ShoppingCartVC;
        navigationController?.show(shoppingCartScreen, sender: self);
    }
    
    // Pulling the data according to the correct category name
    func setUpCategoryName(){
        switch categoryName {
        case "義式咖啡":
            titles = Array(data.cafe.keys);
            details = Array(data.cafe.values);
        case "鮮奶茶系列":
            titles = Array(data.milk.keys);
            details = Array(data.milk.values);
        case "鮮茶系列":
            titles = Array(data.tea.keys);
            details = Array(data.tea.values);
        case "水果茶系列":
            titles = Array(data.fruittea.keys);
            details = Array(data.fruittea.values);
        case "輕食系列":
            titles = Array(data.food.keys);
            details = Array(data.food.values);
        default:
            print("default case");
        }
    }
    
    // Filling the array with data products
    func setUpProducts() {
        for i in 0 ..< titles.count {
            var productData = details[i]
            let product = Product(name: titles[i], price: productData[1], image: productData[0])
            arrayOfProduct.append(product)
        }
    }
    
    // MARK: - TableView display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProduct.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product cell", for: indexPath) as! ProductsViewCell;
        
        let product = arrayOfProduct[indexPath.row]
        
        cell.setCell(product.name, productPrice: product.price, productImage: product.image)
        
        // Set redius and bounds
        cell.productImage.layer.cornerRadius = 10
        cell.productImage.clipsToBounds = true
        
        
        return cell;
    }
    
    // Item selected from table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productInfoScreen = storyboard?.instantiateViewController(withIdentifier: "product info view") as! ProductInfoViewController
        //print("Prodact Details \(details)");
        productInfoScreen.categoryName = categoryName
        productInfoScreen.setTitle = titles[indexPath.row]
        navigationController?.show(productInfoScreen, sender: self);
    }
    
}
