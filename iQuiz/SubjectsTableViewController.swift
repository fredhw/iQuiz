//
//  SubjectsTableViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/3/17.
//  Copyright © 2017 fredhw. All rights reserved.
//

import UIKit
import Alamofire

class SubjectsTableViewController: UITableViewController {
    
    var url = "https://tednewardsandbox.site44.com/questions.json"
    let prefs = UserDefaults.standard

    var quizState = Quiz()
    
    func updateNow() {
        Alamofire.request(url).responseJSON{ response in
            // debugPrint(response)
            if let json = response.result.value as? [[String: Any]] {
                self.prefs.set(json, forKey: "json")
            }
        }
        self.tableView.reloadData()
    }

    
    @IBAction func settingsButton(_ sender: UIButton) {
        let checkAction = UIAlertController(title: "Settings", message: "Shall you update?", preferredStyle: .alert)
        checkAction.addTextField() { (textField) in
            textField.placeholder = "\(self.url)"
        }
        let checkNow = UIAlertAction(title: "Check Now", style: .default, handler: { (action) in
            self.updateNow()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        checkAction.addAction(checkNow)
        checkAction.addAction(cancel)
        self.present(checkAction, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNow()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.prefs.array(forKey: "json")?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectsCell", for: indexPath) as! SubjectsTableViewCell

        // Configure the cell...
        let quizArray = self.prefs.array(forKey: "json")!
        let subject = quizArray[indexPath.row] as! [String : Any]
        cell.subjectLabel.text = subject["title"] as? String
        cell.descLabel.text = subject["desc"] as? String
        cell.imageLabel.image = UIImage(named: (cell.subjectLabel.text!))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizArray = self.prefs.array(forKey: "json")!
        let subject = quizArray[indexPath.row] as! [String : Any]
        performSegue(withIdentifier: "QuestionViewController", sender: subject)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionViewController {
            if let subject = sender as? [String: Any] {
                self.prefs.set(subject, forKey: "chosen")
                destination.quizState = quizState
            }
        }
    }

}
