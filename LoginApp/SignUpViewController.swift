//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Tardes on 14/1/25.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authResult, error in
            if let error = error {
                // Hubo un error
                print(error)
                
                let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "OK", style: .default))

                self.present(alertController, animated: true, completion: nil)
            } else {
                // Todo correcto
                print("User signs up successfully")
                
                let alertController = UIAlertController(title: "Create user", message: "User created successfully", preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "OK", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
