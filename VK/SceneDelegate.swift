//
//  SceneDelegate.swift
//  VK
//
//  Created by Дмитрий Константинов on 26.11.2019.
//  Copyright © 2019 Дмитрий Константинов. All rights reserved.
//

import UIKit
import KeychainAccess

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //Проверка, iOS 13 и выше
        if #available(iOS 13, *) {
            let keychain = Keychain(service: "UserSecrets")
            //Делаем проверку на валидность токена по времени
            if let expireIn = Int(keychain["expiresIn"] ?? "0") {
                //На всякий случай компенсируем час
                let realTime = Int(Date().timeIntervalSince1970) + 3600
                if expireIn > realTime {
                    if let token = keychain["token"], let userId = keychain["userId"] {
                        
                        window = UIWindow(windowScene: windowScene)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainView")
                        window?.rootViewController = UINavigationController(rootViewController: tabBarVC)
                        window?.makeKeyAndVisible()
                        
                        //присваиваем значения нашему singleton instance
                        Session.instance.token = token
                        Session.instance.userId = userId
                        Session.instance.version = "5.103"
                        
                        print("[Logging] [Keychain] Token exist")
                        print("[Logging] [Keychain] Expires through : " + String(((expireIn - realTime) % 86400) / 3600) + " hours," + String(((expireIn - realTime) % 3600) / 60) + " minutes," + String(((expireIn - realTime) % 3600) % 60) + " seconds")
                    } else {
                        print("[Logging] [Keychain] Token not exist")
                    }
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

