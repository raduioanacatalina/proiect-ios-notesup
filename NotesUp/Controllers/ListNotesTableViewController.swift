//
//  ListNotesTableViewController.swift
//  NotesUp
//
//  Created by user196345 on 5/18/21.
//

import Foundation
import UIKit

class ListNotesTableViewController: UITableViewController {

    var notes = [Note]() {
        didSet{
        tableView.reloadData()
        }
    }
    // notif
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    let notifications = ["Local Notification",
                            "Local Notification with Action",
                            "Local Notification with Content",
                            "Push Notification with  APNs",
                            "Push Notification with Content"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notes = CoreDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // no. of notes
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)

            notes = CoreDataHelper.retrieveNotes()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell

        let note = notes[indexPath.row]
        cell.noteTitleLabel.text = note.title
        cell.noteLastModifiedLabel.text = note.modificationTime?.convertToString() ?? "unknown"

        return cell
    }
    
    // notif
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let notificationType = notifications[indexPath.row]
            
        let alert = UIAlertController(title: "",
                                        message: "After 5 seconds " + notificationType + " will appear",
                                        preferredStyle: .alert)
            
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            self.appDelegate?.scheduleNotification(notificationType: notificationType)
        }
            
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "displayNote":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }

            let note = notes[indexPath.row]
            
            let destination = segue.destination as! DisplayNoteViewController
        
            destination.note = note

        case "addNote":
            print("create note bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        notes = CoreDataHelper.retrieveNotes()
    }
}
