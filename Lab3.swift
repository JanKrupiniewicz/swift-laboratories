import Foundation

enum Reaction {
    case like
    case dislike
    case smile
    case angry
    case sad
}

class UserProfile {
    let username: String
    
    init(username: String) {
        self.username = username
    }
}

class Content {
    let title: String
    let description: String
    let postDate: Date
    var reactions: [Reaction] = []
    
    init(title: String, description: String, postDate: Date, reactions: [Reaction]) {
        self.title = title
        self.description = description
        self.postDate = postDate
        self.reactions = reactions
    }
    
    func displayContent() {
        fatalError("Method should be overridden by subclasses")
    }
}

class Post: Content {
    let userProfile: UserProfile
    
    init(userProfile: UserProfile, postDate: Date, title: String, description: String, reactions: [Reaction]) {
        self.userProfile = userProfile
        super.init(title: title, description: description, postDate: postDate, reactions: reactions)
    }
    
    override func displayContent() {
        let formattedDate = DateFormatter.localizedString(from: postDate, dateStyle: .medium, timeStyle: .short)
        print("User: \(userProfile.username) | Title: \(title) | Description: \(description) | Date: \(formattedDate) | Reactions: \(reactions)")
    }
}

struct HelperFunctions {
    static func formatLikes(_ likes: Int) -> String {
        if likes >= 1000 && likes < 1000000 {
            return "\(likes / 1000)k"
        } else {
            return "\(likes)"
        }
    }
    
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

class PhotoApp {
    var users: [UserProfile] = []
    var posts: [Post] = []
    
    func addPost(userProfile: UserProfile, postDate: Date, title: String, description: String, reactions: [Reaction]) {
        let newPost = Post(userProfile: userProfile, postDate: postDate, title: title, description: description, reactions: reactions)
        posts.append(newPost)
    }
    
    func displayAllContent() {
        for post in posts {
            post.displayContent()
        }
    }
}

let user1 = UserProfile(username: "example_user1")
let user2 = UserProfile(username: "example_user2")

let postDate1 = Date()
let postDate2 = Calendar.current.date(byAdding: .day, value: -1, to: postDate1)!
let postDate3 = Calendar.current.date(byAdding: .day, value: -2, to: postDate1)!

let app = PhotoApp()

app.addPost(userProfile: user1, postDate: postDate1, title: "Title 1", description: "Description 1", reactions: [.like, .smile])
app.addPost(userProfile: user2, postDate: postDate2, title: "Title 2", description: "Description 2", reactions: [.like, .dislike])
app.addPost(userProfile: user1, postDate: postDate3, title: "Title 3", description: "Description 3", reactions: [.angry, .sad])

app.displayAllContent()
