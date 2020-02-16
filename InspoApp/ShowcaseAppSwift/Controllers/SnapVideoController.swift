//
//  SnapVideoController.swift
//  ShowcaseApp
//
//  Created by Mahima Chander on 2/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SnapVideoController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
        //self.dismiss(animated: false)
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "snapvideo", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        player.actionAtItemEnd = .pause
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
       // playerController.dismiss(animated: false)
    }
}
