//
//  UserStore.swift
//  IntroChat
//
//  Created by Mina on 1/31/24.
//

import Foundation

class UserStore {
    
    static let shared = UserStore()
    private let userStore = UserDefaults.standard
    private let introductionKey = Constants.UserStoreKeys.introductionKey.rawValue
    private init() {}
    
    
    func save(introduction: String) {
        if var introductionHistory = userStore.object(forKey: introductionKey) as? [String] {
            introductionHistory.append(introduction)
            userStore.setValue(introductionHistory, forKey: introductionKey)
        } else {
            userStore.setValue([introduction], forKey: introductionKey)
        }
    }
    
    func save(introductions: [String]) {
        if introductions.isEmpty {
            userStore.removeObject(forKey: introductionKey)
        } else {
            userStore.setValue(introductions, forKey: introductionKey)
        }
    }

    
    func loadIntroduction() -> [String] {
        if let introductionHistory = userStore.object(forKey: introductionKey) as? [String] {
            return introductionHistory
        } else {
            return ["No Introduction History Yet"]
        }
    }
}
