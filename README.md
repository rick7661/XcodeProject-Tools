# XcodeProject-Tools

A cache of tools and scripts to help setting up Xcode projects, 
for easier git co-contribution and minimise merge conflicts.

## Basic Steps

1. Create project
2. Add `.gitignore` to project root directory
3. Add customised text macros `IDETemplateMacros.plist` to one of the following directories:
	
	- Project user data: `<ProjectName>.xcodeproj/xcuserdata/[username].xcuserdatad/IDETemplateMacros.plist`
	- Project shared data: `<ProjectName>.xcodeproj/xcshareddata/IDETemplateMacros.plist`
	- Workspace user data: `<WorkspaceName>.xcworkspace/xcuserdata/[username].xcuserdatad/IDETemplateMacros.plist`
	- Workspace shared data: `<WorkspaceName>.xcworkspace/xcshareddata/IDETemplateMacros.plist`
	- User Xcode data: `~/Library/Developer/Xcode/UserData/IDETemplateMacros.plist`

4. Configure git commit hook to to use [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
5. Add [SOCK](https://github.com/Polidea/SOCK) sort project file script to build scheme post-build action