//
//  GameKitManager.swift
//  Cleantify
//
//  Created by Muhammad Yusuf on 26/07/23.
//

import Foundation
import SwiftUI
import GameKit


class GameKitManager: NSObject, ObservableObject, GKGameCenterControllerDelegate {
    static let shared = GameKitManager()
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    var rootViewController: UIViewController? {
        let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowsScene?.windows.first?.rootViewController
    }
    
    func openLeaderboard() {
        let gameCenterVc = GKGameCenterViewController(leaderboardID: "cleantify.sabarjaya", playerScope: .global, timeScope: .today)
        gameCenterVc.gameCenterDelegate = self
        rootViewController?.present(gameCenterVc, animated: true)
    }
    
    func submitScore(score: Int) async {
        let player = GKLocalPlayer.local
        GKLeaderboard.submitScore(score, context: 0, player: player, leaderboardIDs: ["cleantify.sabarjaya"]) { [self] error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            print("Score Submited")
        }
    }
    
    func authenticatePlayer(completion: @escaping (Bool) -> Void) {
        if GKLocalPlayer.local.isAuthenticated {
            // Already authenticated, no need to reauthenticate
            completion(true)
        } else {
            GKLocalPlayer.local.authenticateHandler = { vc, error in
                if let error = error {
                    // Authentication failed
                    completion(false)
                } else if let viewController = vc {
                    print("Error while authenticating")
                    completion(false)
                } else {
                    // Authentication successful
                    completion(true)
                    print("Player is authenticated!")
                }
            }
        }
    }
    
    func convertToInt(_ stringValue: String) -> Int? {
        guard let intValue = Int(stringValue) else {
            return nil
        }
        return intValue
    }
    
    func fetchPlayerData(completion: @escaping ([Cleaner]) -> Void) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Error")
            completion([])
            return
        }
        
        let leaderboardID = "cleantify.sabarjaya"
        let leaderboard = GKLeaderboard()
        
        leaderboard.identifier = leaderboardID
        leaderboard.loadScores { (scores, error) in
            if let error = error {
                print("Error fetching leaderboard scores: \(error.localizedDescription)")
                completion([])
            } else if let scores = scores {
                var cleaners: [Cleaner] = []
                for score in scores {
                   let picName = score.player.loadPhoto(for: .small)
                
                    print("pic Name \(picName)")
                    
                    print(score)
                    let cleaner = Cleaner(name: score.player.alias, score: score.value, rank: score.rank)
                    cleaners.append(cleaner)
                }
                print("cleaner \(cleaners.count)")
                
                completion(cleaners)
            }
        }
    }
}
