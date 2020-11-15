
import UIKit
import CoreData

class JournalTableViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    var entryTitle = ""
    var entryDate = Date()
    var entries: [Entry] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - View will appear lifecycle method is time point when all data currently stored in the container should be loaded onto the main thread (view will appear is called EVERY time the screen appears unlike viewDidLoad. ViewDidLoad only gets called once.
     
     
     override func viewWillAppear(_ animated: Bool) {
         do {
             let savedEntries = try context.fetch(Entry.fetchRequest()) as! [Entry]
             entries = savedEntries
            tableView.reloadData()
             
         } catch {
             print("Error loading data: \(error.localizedDescription)")
         }
     }
     
     
     

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        let cell = UITableViewCell()
        let entry = entries[indexPath.row]
        cell.textLabel?.text = entry.text
        cell.backgroundColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "journalEntrySegue", sender: entry)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryVC.entry = entryToBeSent
            }
        }
    }



}
