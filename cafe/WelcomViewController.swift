//
//  WelcomViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/4/1.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WelcomViewController: UIViewController {
    
    @IBOutlet weak var signSelector: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInBut: UIButton!
    
    @IBOutlet weak var backGround: UIImageView!
    var isSignIn: Bool = true
    
    var ref: DatabaseReference!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        ref = Database.database().reference()
        
        
        emailTF.text = UserDefaults.standard.string(forKey: "email")
        passwordTF.text = UserDefaults.standard.string(forKey: "pass")
        
        signInBut.backgroundColor = UIColor.darkGray
        signInBut.layer.cornerRadius = signInBut.frame.height / 2
        signInBut.setTitleColor(UIColor.white, for: .normal)
        signInBut.layer.shadowColor = UIColor.darkGray.cgColor
        signInBut.layer.shadowRadius = 4
        signInBut.layer.shadowOpacity = 0.5
        signInBut.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        //signSelector.backgroundColor = UIColor.darkGray
        //signSelector.layer.cornerRadius = signSelector.frame.height / 2
        //signSelector.setTitleColor(UIColor.white, for: .normal)
        signSelector.layer.shadowColor = UIColor.darkGray.cgColor
        signSelector.layer.shadowRadius = 4
        signSelector.layer.shadowOpacity = 0.5
        signSelector.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Blureffect.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backGround.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backGround.addSubview(blurEffectView)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // User defaults check
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
            return
        }
        
        // Pageview for walkthroughController
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalktroughPageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
        
        
        
        
        signInLabel.sizeToFit()
        
    }
    
    // dismiss keyBoard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        loginUser()
    }
    
    func loginUser() {
        if let email = emailTF.text, let pass = passwordTF.text{
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check user isn't nil
                    if let u = user {
                        // user found!
                        // save password and email
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(pass, forKey: "pass")
                        UserDefaults.standard.synchronize()
                        let userID: String = (user?.uid)!
                        Database.database().reference().child("Users").child(userID).child("Type").observeSingleEvent(of: .value, with: { (snap) in
                            
                            let val = snap.value
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: val as! String) as UIViewController
                            self.present(vc, animated: true, completion: nil)
                        })
                    }else {
                        // error
                        
                    }
                    
                })
            }else{
                // registor user.
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    if let u = user{
                        
                        let userID: String = (user?.uid)!
                        let userEmail: String = self.emailTF.text!
                        let userPassword: String = self.passwordTF.text!
                        let userType: String = "user"
                        
                        self.ref.child("Users").child(userID).setValue(["Email" : userEmail,
                                                                        "Password" : userPassword,
                                                                        "Type": userType])
                        
                        
                        // loggin in.
                        Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!, completion: { (usrt, error) in
                            if (error != nil) {
                                print("error")
                            }else {
                                print("success")
                                
                                UserDefaults.standard.set(email, forKey: "email")
                                UserDefaults.standard.set(pass, forKey: "pass")
                                UserDefaults.standard.synchronize()
                                
                                let userID: String = (user?.uid)!
                                Database.database().reference().child("Users").child(userID).child("Type").observeSingleEvent(of: .value, with: { (snap) in
                                    
                                    let val = snap.value
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: val as! String) as UIViewController
                                    self.present(vc, animated: true, completion: nil)
                                })
                                
                                
                            }
                        })
                    
                        
                        
                        
                    }else{
                        // check error
                    }
                    
                    
                })
            }
            
        }
    }
    @IBAction func signSelectorChange(_ sender: UISegmentedControl) {
        // flip boolean
        isSignIn = !isSignIn
        
        //Check boollean
        if isSignIn {
            signInLabel.text = "登入"
            signInBut.setTitle("登入", for: .normal)
        }else{
            signInLabel.text = "註冊"
            signInBut.setTitle("註冊", for: .normal)
        }
        
        
        
    }
    
}
