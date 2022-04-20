//
//  DisplayNoteViewController.swift
//  NotesUp
//
//  Created by user196345 on 5/18/21.
//

import Foundation
import UIKit

class DisplayNoteViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  /*   for previous "back button"
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard let identifier = segue.identifier else { return }
    if identifier == "displayNote" {
        print("Navigating to the Display Note View Controller")
    }
  }*/
    var note: Note?
    
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else { return }

    switch identifier {
    case "save" where note != nil:
        note?.title = titleTextField.text ?? ""
        note?.content = contentTextView.text ?? ""
        note?.modificationTime = Date()

        CoreDataHelper.saveNote()

    case "save" where note == nil:
        let note = CoreDataHelper.newNote()
        note.title = titleTextField.text ?? ""
        note.content = contentTextView.text ?? ""
        note.modificationTime = Date()

        CoreDataHelper.saveNote()

    case "cancel":
        print("cancel bar button item tapped")

    default:
        print("unexpected segue identifier")
    }
}
    
    // note's title and content
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
}
