//
//  ProfileViewController.swift
//  LoginApp
//
//  Created by Tardes on 22/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser!.uid
        
        let docRef = db.collection("Users").document(userID)

        Task {
            do {
                user = try await docRef.getDocument(as: User.self)
                DispatchQueue.main.async {
                    self.loadData()
                }
            } catch {
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func loadData() {
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        usernameLabel.text = user.username
        
        switch user.gender {
        case .male:
            genderLabel.text = "Hombre"
            genderImageView.image = UIImage(named: "genderIcon-male")
        case .female:
            genderLabel.text = "Mujer"
            genderImageView.image = UIImage(named: "genderIcon-female")
        case .other:
            genderLabel.text = "Otro"
            genderImageView.image = UIImage(named: "genderIcon-other")
        default:
            genderLabel.text = "Indefinido"
            genderImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if let date = user.birthday {
            dateOfBirthLabel.text = formatter.string(from: date)
        } else {
            dateOfBirthLabel.text = "--/--/----"
        }
        
        if let imageUrl = user.profileImageUrl {
            profileImageView.loadFrom(url: imageUrl)
        }
    }

    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    /*// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
