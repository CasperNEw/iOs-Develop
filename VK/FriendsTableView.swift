import UIKit

class FriendsTableView: UITableViewController {
    //на всякий случай оставил штатный метод, хотя как я понял он у меня просто вписан в метод tableView
    //но пока оставим, вдруг придется переделать в дальнейшем
    //override func numberOfSections(in tableView: UITableView) -> Int {
    //    return 0
    //}
    
    var dataFriends: [String] = ["Amancio Ortega", "Bernard Arnault", "Bill Gates", "Carlos Slim", "Jeff Bezos", "Lawrence Ellison", "Lawrence Page", "Mark Zuckerberg", "Michael Bloomberg", "Warren Buffett"]
    
    //реализация количества строк (ячеек) равное количеству элементов массива dataFriens
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFriends.count
    }
    //реализация присвоения титулу ячеек значений элементов массива data, идентификатор CellFriends задается в Storyboard
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFriends", for: indexPath) as! FriendsTableViewCell
        //cell.textLabel?.text = dataFriends[indexPath.row]
        let friend = dataFriends[indexPath.row]
        cell.FriendsName.text = friend
        let image = UIImage(named: friend)
        cell.friendsImage.image = image
        return cell
    }
    //реализация функции при нажатии на Cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //плавная анимация исчезновения выделения
        tableView.deselectRow(at: indexPath, animated: true)
        //выведем в консоль имя нажатой ячейки
        print(dataFriends[indexPath.row])
        //сделаем переключение на Collection View, со всех ячеек переключаемся на один и тот же Collection View.
        let main = UIStoryboard( name: "Main", bundle: nil)
        let vc = main.instantiateViewController(identifier: "PhotoFreindsCollection") as! FriendsCollectionView
        vc.user = dataFriends[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet var friendsTView: UITableView!
    
    var username = ""
    var language = 0
    //реализация метода получения данных с предыдущего View, не реализована !
    
    override func viewDidLoad() {
//        print("[Logging] load Friends & Photo View  [username - \(username)]")
//        if language == 0 {
//            print("[Logging] connect with language option Ru")
//        } else if language == 1 {
//            print("[Logging] connect with language option En")
//        }
        print("[Logging] Test language - \(language) , user - \(username) ")
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
 