# Project 5 - *Be Real Clone*

Submitted by: **Dev Patel**

**Be Real Clone** is an app that has one of the basic functionalities of most social media apps. Users can sign up or login to their account and post images from their photo library with captions. These images then show up on a feed visible to all users.

Time spent: **5** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can register a new account
- [x] User can log in with newly created account
- [x] App has a feed of posts when user logs in
- [x] User can upload a new post which takes in a picture from photo library and a caption	
 
The following **optional** features are implemented:

- [x] Users can pull to refresh their feed and see a loading indicator
- [ ] Users can infinite-scroll in their feed to see past the 10 most recent photos
- [ ] Users can see location and time of photo upload in the feed	
- [ ] User is able to logout
- [ ] User stays logged in when app is closed and open again	


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Signing up as a new user...
<img src='https://github.com/devrdpatel/codepath-Unit-5/blob/main/BeRealGIF1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Logging in as an existing user...
<img src='https://github.com/devrdpatel/codepath-Unit-5/blob/main/BeRealGIF2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with Kap for MacOS

## Notes

For the most part, everything in creating this app was pretty straightforward after doing the lab that was quite similar to this app. 

## License

    Copyright 2023 Dev Patel

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Project 6 - *Be Real Clone*

Submitted by: **Dev Patel**

**Be Real Clone** is an app that has one of the basic functionalities of most social media apps. Users can sign up or login to their account and post images from their photo library with captions. These images then show up on a feed visible to all users. Additionally, this version adds new features such as persisting login, option to logout, and preventing users from seeing other posts until they make their own post (similar to the BeReal app).


Time spent: **3** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can launch camera to take photo instead of photo library OR (Users can upload their own unique photo from photo album)
- [x] User session persists when application is closed and relaunched
- [x] Users are able to log out and return to sign in page
- [x] Users are NOT able to see other photos until they upload their own	
 
The following **optional** features are implemented:

- [ ] User receive notifcation when it is time to post
- [ ] Users can make comments and view comments in posts	

The following **additional** features are implemented:

- [x] I added the feature to blur photos instead of not showing them to the user, if the user didn't post in the last 24 hours.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/devrdpatel/codepath-Unit-5/blob/main/BeReal-pt2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with Kap for MacOS

## Notes

There were some issues with blurring the photo such as the Blur view being covered by the image view so that when the image should have been blurred, it was not actually being blurred but I was able to figure out the issue. Also, since I used the emulator rather than a physical device to showcase the app, I couldn't use the camera feature. Instead, I uploaded a unique photo to the emulator's photo library and used that in the post.

## License

    Copyright 2023 Dev Patel

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
