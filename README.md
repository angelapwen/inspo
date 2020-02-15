# inspo

## Steps to run
1. On your command line, go to the `InspoApp` directory, which should contain the Podfile. Run `pod install`
2. On Xcode, open the newly generated `ShowcaseApp.xcworkspace` file.
3. [Create a Firebase project in the Firebase console, add a new iOS app to your Firebase project with a new bundle ID](https://firebase.google.com/docs/ios/setup)
4. Download the GoogleService-Info.plist from the newly added app and add it to the ShowcaseApp project in Xcode. Remember to check Copy items if needed and select Create folder references.
5. Build and run the app on a physical device
