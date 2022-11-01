//
//  FreeFinderApp.swift
//  Shared
//
//  Created by Jordan Labuda on 10/31/22.
//

import SwiftUI
import Firebase

func refresh(){
    
}

func item_to_annot(item_id: String){
    
}

class User {
    var id : String
    var email : String
    
    init(id: String, email: String){
        self.id = id
        self.email = email
    }
    
    func create_item(){
        
    }
    func comment(item_id: String, comment: String){
    
    }
    func delete_item(item_id: String){
        
    }
    
    
}

@main
struct FreeFinderApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            return true
    }
}
