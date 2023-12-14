//
//  SwiftUIView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 6/27/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: ProfileViewModel
    
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProfileHeaderView(viewModel: viewModel)
                
                NotCurrentUserPostListView(user: user)
            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: Post.self, destination: { post in
            PaymentSheetView( post: post, user: user)
            
            //PaymentSheetView( viewModel: //PostListViewModel(user: user), post: post)})
        })}
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
/*import SwiftUI

struct ProfileView: View {
    let user: User
    //let post: Post
    
   @State private var isShowingPaymentView = false
    
    @StateObject var viewModel : PostListViewModel
    
    
    
    var body: some View {
        
        ScrollView {
            
            ProfileHeaderView(user: user)
            
            Spacer()
            
            LazyVStack {
                /*ForEach(Post.MOCK_POST) { post in
                 /* Button(action:{
                  self.isShowingPaymentView = true
                  }) {
                  PostListView(user: user, posts: posts)
                  }*/
                 /*NavigationLink(destination: PaymentSheetView(post: post, user: user)) {
                  PostListView(user: user, posts: posts)
                  }*/
                 
                 //PostListView(user: user, posts: posts)
                 
                 
                 
                 }*/
                
                ForEach(viewModel.posts) { post in
                    NavigationLink(value: post) {
                        PostListView(user: user)
                    }
                    
                }
                
            }
            .ignoresSafeArea()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: Post.self, destination: { post in
            PaymentSheetView( viewModel: PostListViewModel(user: user), post: post)})
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0], viewModel: PostListViewModel(user: User.MOCK_USERS[0]))
    }
}*/
/*var body: some View {
 ScrollView{
     ZStack(alignment: .topLeading) {
         ListingImageCarouselView(listing: listing)
             .frame(height: 320)
         
         Button {
            dismiss()
         } label: {
             Image(systemName: "chevron.left")
                 .foregroundStyle(.black)
                 .background {
                     Circle()
                         .fill(.white)
                         .frame(width: 32, height: 32)
                 }
                 .padding(32)
         }
     }
     
     
     VStack(alignment: .leading, spacing: 8) {
         Text(listing.title)
             .font(.title)
             .fontWeight(.semibold)
         
         VStack(alignment: .leading) {
             HStack(spacing: 2) {
                 Image(systemName: "star.fill")
                 
                 Text("\(listing.rating)")
                 
                 Text(" - ")
                 
                 Text("28 reviews")
                     .underline()
                     .fontWeight(.semibold)
             }
             .foregroundStyle(.black)
             
             Text("\(listing.city), \(listing.state)")
         }
         .font(.caption)
     }
     .padding()
     .frame(maxWidth: .infinity, alignment: .leading)
     
     Divider()
     //host interview
     HStack {
         VStack(alignment: .leading, spacing: 4) {
             Text("Entire \(listing.type.description) hosted by \(listing.ownerName)")
                 .font(.headline)
                 .frame(width: 250, alignment: .leading)
             
             HStack {
                 Text("\(listing.numberOfGuests) guests")
                 Text("\(listing.numberOfBedrooms) bedrooms")
                 Text("\(listing.numberOfBeds) beds -")
                 Text("\(listing.numberOfBathroomsrooms) baths")
             }
             .font(.caption)
         }
         .frame(width: 300, alignment: .leading)
         Spacer()
         
         Image(listing.ownerImageUrl)
             .resizable()
             .scaledToFill()
             .frame(width: 64, height: 64)
             .clipShape(Circle())
     }
     .padding()
     
     Divider()
     //listing features
     VStack(alignment: .leading) {
         ForEach(listing.features) { feature in
             HStack(spacing: 12) {
                 Image(systemName: feature.imageName)
                 
                 VStack(alignment: .leading) {
                     Text(feature.title)
                         .font(.footnote)
                         .fontWeight(.semibold)
                     
                     Text(feature.subtitle)
                         .font(.caption)
                         .foregroundStyle(.gray)
                 }
                 Spacer()
             }
             
         }
         
     }
     .padding()
     
     Divider()
     // bedroom view
     VStack(alignment: .leading) {
         Text("Where you'll sleep")
             .font(.headline)
         
         ScrollView(.horizontal) {
             HStack(spacing: 16) {
                 ForEach(1  ... listing.numberOfBedrooms, id: \.self) { bedroom in
                     VStack {
                         Image(systemName: "bed.double")
                         
                         Text("Bedroom \(bedroom)")
                     }
                     .frame(width: 132, height: 100)
                     .overlay {
                         RoundedRectangle(cornerRadius: 12)
                             .stroke(lineWidth: 1)
                             .foregroundStyle(.gray)
                     }
                 }
             }
         }
         .scrollTargetBehavior(.paging)
     }
     .padding()
     
     Divider()
     // listing amenities
     VStack(alignment: .leading, spacing: 16) {
         Text("What this place offers")
             .font(.headline)
         
         ForEach(listing.amenities) { amenity in
             HStack {
                 Image(systemName: amenity.imageName)
                     .frame(width: 32)
                 
                 Text(amenity.title)
                     .font(.footnote)
                 
                 Spacer()
             }
         }
     }
     .padding()
     
     Divider()
     VStack(alignment: .leading, spacing: 16) {
         Text("Where you'll be")
             .font(.headline)
         
         Map(position: $cameraPosition)
             .frame(height: 200)
             .clipShape(RoundedRectangle(cornerRadius: 12))
         
     }
     .padding()
     
 }
 .toolbar(.hidden, for: .tabBar)
 .ignoresSafeArea()
 .padding(.bottom, 64)
 .overlay(alignment: .bottom) {
     VStack {
         Divider()
             .padding(.bottom)
         
         HStack {
             VStack(alignment: .leading) {
                 Text("$\(listing.pricePerNight)")
                     .font(.subheadline)
                     .fontWeight(.semibold)
                 
                 Text("Total before taxes")
                     .font(.footnote)
                 
                 Text("Oct 15 - 20")
                     .font(.footnote)
                     .fontWeight(.semibold)
                     .underline()
             }
             
             Spacer()
             
             Button {
                 
             }label: {
                 Text("Reserve")
                     .foregroundStyle(.white)
                     .font(.subheadline)
                     .fontWeight(.semibold)
                     .frame(width: 140, height: 40)
                     .background(.pink)
                     .clipShape(RoundedRectangle(cornerRadius: 8))
             }
         }
         .padding(.horizontal, 32)
     }
     .background(.white)
 }
 
}
}

#Preview {
ListingDetailView(listing: DeveloperPreview.shared.listings[0])
}
*/
