//
//  RoomsView.swift
//  HomeKitLights
//
//  Created by Kraig Spear on 1/8/20.
//  Copyright © 2020 Kraig Spear. All rights reserved.
//

import SwiftUI

/// View showing all of the rooms
struct RoomsView: View {
    @ObservedObject var viewModel: RoomsViewModel

    init(viewModel: RoomsViewModel) {
        self.viewModel = viewModel
    }

    init() {
        self.init(viewModel: RoomsViewModel())
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if viewModel.isShowingSortFilter {
                        FilterSortButtons(viewModel: viewModel)
                            .padding(.top, 8)
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                    }

                    TitleView(title: "Rooms",
                              foregroundColor: .primary)
                        .padding(.bottom, 8)

                    ForEach(viewModel.rooms) {
                        RoomLightsView($0, viewModel: RoomLightsViewModel(room: $0,
                                                                          homeKitAccessible: self.viewModel.homeKitAccessible,
                                                                          roomDataAccessible: RoomAccessor.sharedAccessor,
                                                                          hapticFeedback: HapticFeedback.sharedHapticFeedback))
                            .roomStyle()
                    }

                    Spacer()
                }
            }
            .accentColor(Color("FilterLightsOn"))
            .onAppear { self.viewModel.onAppear() }
            .navigationBarTitle(Text("Lights"), displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    withAnimation {
                        self.viewModel.toggleShowingFilter()
                    }
                }, label: {
                    Image(self.viewModel.filterButtonImage)
                        .accentColor(Color("FilterLightsOn"))
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let homeKitAccess = HomeKitAccessMock()
        homeKitAccess.whenHasRooms()

        let roomData = RoomDataAccessibleMock()

        let refreshNotification = RefreshNotificationMock()

        let viewModel = RoomsViewModel(homeKitAccessible: homeKitAccess,
                                       roomDataAccessible: roomData,
                                       refreshNotification: refreshNotification)

        viewModel.onAppear()

        return Group {
            RoomsView(viewModel: viewModel)
                .environment(\.colorScheme, .light)

            RoomsView(viewModel: viewModel)
                .environment(\.colorScheme, .dark)
        }
    }
}
