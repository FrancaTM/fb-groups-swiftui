//
//  ContentView.swift
//  FBGroupsSwiftUI
//
//  Created by Tulio Marcos Franca on 09/06/19.
//  Copyright © 2019 Tulio Marcos Franca. All rights reserved.
//

import SwiftUI

// MARK: Facebook complex layout

struct Post {
    let id: Int
    let username, text, profileImageName, imageName: String

    static let samplePosts: [Post] = [
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger"),
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger")
    ]
}

struct Group {
    let id: Int
    let name, imageName: String

    static let sampleGroups: [Group] = [
        .init(id: 1, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 2, name: "Other People's Puppies", imageName: "puppy"),
        .init(id: 3, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
        .init(id: 4, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 5, name: "Other People's Puppies", imageName: "puppy"),
        .init(id: 6, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
        .init(id: 7, name: "Co-Ed Hikes of Colorado", imageName: "burger"),
        .init(id: 8, name: "Other People's Puppies", imageName: "burger")
    ]
}

struct ContentView: View {
    let posts = Post.samplePosts

    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("Trending").font(.headline).padding(.leading, 16).padding(.bottom, 4)
                    ScrollView(showsHorizontalIndicator: false) {
                        HStack {
                            ForEach(Group.sampleGroups.identified(by: \.imageName)) { group in

                                NavigationButton(destination: GroupDetailView(group: group)) {
                                    GroupView(group: group).padding(.trailing, 8)
                                }
                            }
                        }.padding(.leading, 16).padding(.trailing, 8)
                    }.frame(height: 180)
                }.padding(.top, 8).padding(.leading, -20).padding(.trailing, -20)

                ForEach(posts.identified(by: \.id)) { post in
                    PostView(post: post).padding(.bottom)
                }
            }.navigationBarTitle(Text("Groups"), displayMode: .automatic)
        }
    }
}

struct GroupDetailView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName)
            Text(group.name)
        }.navigationBarTitle(Text(group.name))
    }
}

struct GroupView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName).renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(5).clipped()
            Text(group.name).color(.primary).lineLimit(2).frame(width: 100, height: 50, alignment: .leading).font(.headline)
        }
    }
}

struct PostView: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("burger").resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
                VStack(alignment: .leading) {
                    Text(post.username).font(.headline)
                    Text("Posted 8 hrs ago").font(.body)
                }.padding(.leading, 8)
            }.padding(.leading, 16)
            Text(post.text).padding(.leading, 16).padding(.trailing, 36).lineLimit(nil)

            Image(post.imageName, bundle: nil)
                .scaledToFill()
                .frame(height: 300)
                .clipped()
        }.padding(.leading, -20).padding(.trailing, -20).padding(.top, 12).padding(.bottom, -26)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

// MARK: Dynamic List

struct User: Identifiable {
    var id: Int
    let name, message, imageName: String
}

struct DynamicListView: View {
    let users: [User] = [
        .init(id: 0, name: "Tim Cook", message: "My stands cost $999", imageName: "tim_cook"),
        .init(id: 1, name: "Craig Federighi", message: "I have the sexiest hair in the land of Apple spokesmen", imageName: "craig_f"),
        .init(id: 2, name: "Jony Ive", message: "Somebody save me, I have no idea where I am anymore. Do I even work at Apple anymore? I bet you sure miss my sexy ass accent during the keynotes, amiright?", imageName: "jony_ive")
    ]

    var body: some View {
        NavigationView {
            List {
                Text("Users").font(.largeTitle)
                ForEach(users.identified(by: \.id)) { user in
                    UserRow(user: user)
                }
            }.navigationBarTitle(Text("Dynamic List"))
        }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        return HStack {
            Image(user.imageName)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .frame(width: 70, height: 70).shadow(radius: 4)
            VStack(alignment: .leading) {
                Text(user.name).font(.headline)
                Text(user.message).font(.subheadline).lineLimit(nil)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

#if DEBUG
struct DynamicListView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicListView()
    }
}
#endif
