import UIKit
import Alamofire

enum Album { case wall, profile, saved }

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    
    func getFriendList(token: String) {
        let requestURL = vkURL + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "fields": "city,domain",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
                            print(response.value as? [String: Any] ?? "[Logging] JSON error")
                          })
    }
    
    func getPhotoInAlbum(token: String, user: String, album: Album) {
        let requestURL = vkURL + "photos.get"
        let params = ["owner_id": user,
                      "access_token": token,
                      "album_id": album,
                      "rev": "1",
                      "v": "5.103"] as [String : Any]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
                            print(response.value as? [String: Any] ?? "[Logging] JSON error")
                          })
    }
    
    func getGroupListForUser(token: String, user: String) {
        let requestURL = vkURL + "groups.get"
        let params = ["access_token": token,
                      "user_id": user,
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
                            print(response.value as? [String: Any] ?? "[Logging] JSON error")
                          })
    }
    
    func getFilteredGroupList(token: String, user: String, text: String) {
        let requestURL = vkURL + "groups.search"
        let params = ["access_token": token,
                      "user_id": user,
                      "q": text,
                      "is_member": "1", //в общем работает как то не так оно ... =)
                      "type": "group",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON(completionHandler: { (response) in
                            print(response.value as? [String: Any] ?? "[Logging] JSON error")
                          })
    }
    
}
