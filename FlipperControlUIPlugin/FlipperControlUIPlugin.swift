//
//  FlipperControlUIPlugin.swift
//  FlipperControlUIPlugin
//
//  Created by p-x9 on 2023/05/14.
//
//

import UIKit
import FlipperKit
import HammerTests

public final class FlipperControlUIPlugin: NSObject, FlipperPlugin {
    private var eventGenerator: EventGenerator?

    private let jsonDecoder = JSONDecoder()

    private var connection: FlipperConnection?

    private weak var window: UIWindow?

    private var observations = [NSKeyValueObservation]()

    public init(for window: UIWindow) {
        self.window = window

        super.init()
    }

    public func identifier() -> String! {
        "control-ui"
    }

    public func didConnect(_ connection: FlipperConnection!) {
        self.connection = connection

        registerObservations()

        DispatchQueue.main.async {
            guard let window = self.window else { return }
            self.sendDeviceSize(window.frame.size)
        }

        connection.receive("sendTouchEvent") { [weak self] params, _ in
            guard let self,
                  let params,
                  let data = try? JSONSerialization.data(withJSONObject: params),
                  let event = try? self.jsonDecoder.decode(TouchEvent.self, from: data) else {
                return
            }

            print(event.x, event.y, event.phase)

            DispatchQueue.main.async {
                if self.eventGenerator == nil,
                   let window = self.window {
                    self.eventGenerator = try? EventGenerator(window: window)
                }
                guard let eventGenerator = self.eventGenerator else { return }
                switch event.phase {
                case .began:
                    try? eventGenerator.fingerDown(at: CGPoint(x: event.x, y: event.y))
                case .moved:
                    try? eventGenerator.fingerMove(to: CGPoint(x: event.x, y: event.y))
                case .ended:
                    try? eventGenerator.fingerUp()
                }
            }
        }
    }

    public func didDisconnect() {
        self.connection = nil
        removeObservations()
    }

    private func sendDeviceSize(_ size: CGSize) {
        guard let connection else { return }

        connection.send("deviceSize", withParams: [
            "width": size.width,
            "height": size.height
        ])
    }
}

extension FlipperControlUIPlugin {
    private func registerObservations() {
        guard let window else { return }

        let observation = window.observe(\.frame, options: [.new], changeHandler: { [weak self] object, change in
            guard let self, let size = change.newValue?.size else { return }
                self.sendDeviceSize(size)
        })
        observations.append(observation)
    }

    private func removeObservations() {
        observations.forEach({ $0.invalidate() })
        observations.removeAll()
    }
}

enum TouchPhase: String, Codable {
    case began, moved, ended
}

struct TouchEvent: Codable {
    let phase: TouchPhase
    let x: CGFloat
    let y: CGFloat
}

