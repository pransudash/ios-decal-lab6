//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let titleSize: CGFloat = 36
        static let textSize: CGFloat = 16
    }

    // TODO: instantiate the views needed for your project
    var titleView: UILabel = {
        let label = UILabel()
        label.text = "Login View Controller"
        label.font = UIFont(name: "Avenir", size: Constants.titleSize)
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        return label;
    }()
    
    var loginBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        
        return view
    }()
    
    var usernameField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Avenir", size: Constants.textSize)
        field.textColor = UIColor.black
        field.placeholder = "berkeley.edu account"
        return field
    }()
    
    var passwordField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Avenir", size: Constants.textSize)
        field.textColor = UIColor.black
        field.placeholder = "password"
        field.isSecureTextEntry = true
        return field
    }()
    
    var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = Constants.backgroundColor
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        view.addSubview(titleView)
        view.addSubview(loginBox)
//        view.addSubview(usernameField)
//        view.addSubview(passwordField)
//        view.addSubview(loginBtn)
        loginBox.addSubview(loginBtn)
        loginBox.addSubview(usernameField)
        loginBox.addSubview(passwordField)
        
        // TODO: layout your views using frames or AutoLayout
        titleView.center = view.center
        titleView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: CGFloat(40))
        loginBox.center = view.center
        loginBox.frame = CGRect(x: 25, y: 150, width: view.frame.width - 50, height: CGFloat(200))
        usernameField.center = loginBox.center
        usernameField.frame = CGRect(x: 35, y: 20, width: loginBox.frame.width, height: CGFloat(40))
        passwordField.center = loginBox.center
        passwordField.frame = CGRect(x: 35, y: 60, width: loginBox.frame.width, height: CGFloat(40))
        loginBtn.center = loginBox.center
        loginBtn.frame = CGRect(x: 35, y: 120, width: loginBox.frame.width - 80, height: CGFloat(50))
        loginBtn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func loginPressed(sender: UIButton) {
        authenticateUser(username: usernameField.text, password: passwordField.text)
    }
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
