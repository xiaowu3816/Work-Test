# Work-Test
work project

Sorry, The time is over. In demo can find some mistakes. I use a lot of time to crate a fascinating idea.

##- Inspiration
Use the time of day, I codeing a small game with CoreMotion framework. I want take advantage with learning and get funny.
This is a game make use of Accelerometer and Gyro.

##- What it does
This technology always ignored in the past, but we use the phone to calculate steps. 
We use CoreMotion framework get movements and angle change.

##- How I built it
You can use two methods to receive data: pull and push.
pull: No matter when and where get the latest data.
push: You can use NSOperationQueue to storage and update data.In the end you should stop method.

First, create NSOperationQueue to update.
Second, use accelerometerAvailable test availability.
Third, use accelerometerUpdateInterval set update time.
Fourth, choice "pull" or "push" method.
Finally, use stopAccelerometerUpdates to stop updata.

##- Challenges I ran into
The scores is fault, when we game the first time we get scores, but this scores not to do change. When we play game again, the scores show the fist score.
Too little time that I cannot be modified.

##- Achievements that I'm proud of
I can manage the game snake location and length in the app, to take into thinking beyond screen borders question, also the game end reason. With coding thinking.

##- What I learned
I feel the challenge when I see the test. I can do a mission, but I can't open test. No idea in my mind. I even thought about giving up this test, I want try my best to do my work. 
Every interview is a challenge, I will enjoy the processes.

Thank you!!!