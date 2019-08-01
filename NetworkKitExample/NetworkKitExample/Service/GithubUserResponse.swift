//
//  GithubUserResponse.swift
//  NetworkKitExample
//
//  Created by Ridho Pratama on 01/08/19.
//  Copyright © 2019 Ridho Pratama. All rights reserved.
//

import Foundation

struct GithubUserResponse : Codable {
    let avatarUrl : String?
    let bio : String?
    let blog : String?
    let company : String?
    let createdAt : String?
    let email : String?
    let eventsUrl : String?
    let followers : Int?
    let followersUrl : String?
    let following : Int?
    let followingUrl : String?
    let gistsUrl : String?
    let gravatarId : String?
    let hireable : Bool?
    let htmlUrl : String?
    let id : Int?
    let location : String?
    let login : String?
    let name : String?
    let nodeId : String?
    let organizationsUrl : String?
    let publicGists : Int?
    let publicRepos : Int?
    let receivedEventsUrl : String?
    let reposUrl : String?
    let siteAdmin : Bool?
    let starredUrl : String?
    let subscriptionsUrl : String?
    let type : String?
    let updatedAt : String?
    let url : String?
}
