
import UIKit
import CoreData

class EntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var entryTextView: UITextView!
    
    @IBOutlet weak var bottomTextViewConstraint: NSLayoutConstraint!
    
    
    var entry: Entry?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: - Creating a notification center object that tells whether keyboard is on screen or not
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        entryTextView.becomeFirstResponder()

    //MARK: - A UITextView delegate is needed in order to listen for changes in data so that the content can be auto-updated in real-time and also immediately be stored in the container
        entryTextView.delegate = self
       
        if entry == nil {
            entry = Entry(context: context)
            entry?.text = "Today was..."
            entry?.date = datePicker.date
        }
           entryTextView.text = entry?.text
            if let safeDate = entry?.date {
            datePicker.date = safeDate
            
        }
        
    }
    
    //MARK: - Keyboard notification selector function that returns the height of the keyboard on a user's device model 
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomTextViewConstraint.constant = keyboardHeight
        }
    }

    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        try? context.save()
    }
    //MARK: - Text Field Delegate Method that listens to changes made in the text field and saves it
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextView.text
        try? context.save()
    }
    

    //MARK: - View will disappear lifecycle method : time point when data should be saved and any newly created data should get passed over to the root view controller when the user navigates back
    
    override func viewWillDisappear(_ animated: Bool) {

        // SAVE DATA
        do {
            try context.save()
        } catch {
            print("Error saving data : \(error.localizedDescription)")
        }
        }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        if entry != nil {
            context.delete(entry!)
            try? context.save()
            
        }
        
        navigationController?.popViewController(animated: true)
    }
}

