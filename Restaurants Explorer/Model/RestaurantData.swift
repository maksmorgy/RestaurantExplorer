//
//  ViewController.swift
//  Restaurants Explorer
//
//  Created by Максим Моргун on 01.10.2021.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}
//
import Foundation

// MARK: - Welcome
struct RestaurantData: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
    let confident: Bool?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let referralID: String?
    let hasPerk: Bool?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon?
    let primary: Bool?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode, cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}
