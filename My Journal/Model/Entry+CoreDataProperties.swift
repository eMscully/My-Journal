
import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Entry : Identifiable {
//MARK: - Custom function to update the cell's month label based on the journal entry date picker date
    
    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateAsString = date {
           let month = formatter.string(from: dateAsString)
            return month.uppercased()
        } else {
            return "Oops!"
        }
     
    }
    
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let dateAsString = date {
            let day = formatter.string(from: dateAsString)
            return day
        }
        else {
            return "Oops!"
        }
    }
}
