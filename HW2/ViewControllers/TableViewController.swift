import UIKit
import SnapKit

class TableViewController: UIViewController {

    private var tableView = UITableView()
    private var filteredContacts: [String] = []
    
    let contacts = [
        "Alice",
        "Bob",
        "Charlie",
        "David",
        "Eve",
        "Frank",
        "Grace",
        "Harry",
        "Isabelle",
        "Jack",
        "Karen",
        "Liam",
        "Mia",
        "Nancy",
        "Oliver",
        "Penny",
        "Quinn",
        "Ryan",
        "Samantha",
        "Tom",
        "Ursula",
        "Victoria",
        "William",
        "Xander",
        "Yvonne",
        "Zoe"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Set up search bar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count > 0 ? 26 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = Character(UnicodeScalar(section + 65)!)
        if isFiltering {
            return filteredContacts.filter { $0.hasPrefix(String(letter)) }.count
        }
        return contacts.filter { $0.hasPrefix(String(letter)) }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let letter = Character(UnicodeScalar(indexPath.section + 65)!)
        let contactName: String
        if isFiltering {
            let filtered = filteredContacts.filter { $0.hasPrefix(String(letter)) }
            contactName = filtered[indexPath.row]
        } else {
            let filtered = contacts.filter { $0.hasPrefix(String(letter)) }
            contactName = filtered[indexPath.row]
        }
        cell.textLabel?.text = contactName
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(Character(UnicodeScalar(section + 65)!))
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let alphabet = (0..<26).map { String(UnicodeScalar("A".unicodeScalars.first!.value + $0)!) }
        return alphabet
    }

    
}


extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let letter = Character(UnicodeScalar(indexPath.section + 65)!)
        let contactName: String
        if isFiltering {
            let filtered = filteredContacts.filter { $0.hasPrefix(String(letter)) }
            contactName = filtered[indexPath.row]
        } else {
            let filtered = contacts.filter { $0.hasPrefix(String(letter)) }
            contactName = filtered[indexPath.row]
        }
        print("Selected contact: \(contactName)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.7057395577, green: 0.7057395577, blue: 0.7057395577, alpha: 1)

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}

extension TableViewController: UISearchResultsUpdating {
    
    private var isFiltering: Bool {
        let searchBar = navigationItem.searchController?.searchBar
        return searchBar?.text?.isEmpty == false && searchBar?.isFirstResponder == true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            filteredContacts = contacts.filter { $0.lowercased().contains(searchText) }
        } else {
            filteredContacts = []
        }
        tableView.reloadData()
    }
    
}
