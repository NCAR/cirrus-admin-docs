# Add New Users

Access Harbor via [hub.k8s.ucar.edu](https://hub.k8s.ucar.edu) is provided to all UCAR employees in Active Directory. It is limited to read-only access of public projects. Only administrators are allowed to create new projects. 

## User Request

A user who requires push access should open a Jira ticket for their request. The user documentation provides instructions on how to do this. If they have not provided a descriptive name to use for the project reach back out and ask for one.

## Add New Project

When logged in to the Harbor UI as an administrator the New Project button is available to add a project to the registry. Use the Project Name provided by the user, it must be all lower case and contain only `_` or `-`. By default we limit the project to 5 GB and the Public box should be left unchecked. A user can request to make the project Public or for more space if justified. 

## Configuration

Once created, the project name in the Projects tab links to a page with more specifics for that project. Inside the project, the last tab is for Configuration. Inside the Configuration tab select the box to `Prevent vulnerable images from running` and use a severity of `Medium` for the base. Ensure the `Automatically scan images on push` box is selected as well and use the Save button on the bottom when complete. The Project can be made Public from this tab as well.

## Policy

Select the Policy tab and use the `ADD RULE` button to add a retention rule to the project. Use the `By artifact count or number of days` dropdown to select `retain the most recently pulled # artifacts`. Underneath count input 3 to keep copies of the 3 most recently pulled artifacts. By default this is applied to all repositories and tags. This can be changed if there is a valid user justification. Once the retention rule is in place select the `ADD` box to add the policy. These run on a nightly basis. 

## Members

Select the Members tab and use the `+ USER` button to open the New Member window. Use the SSO of the user who requested the project via Jira in the Name field. By default we assign the Role Maintainer. This allows users the ability to push, pull, and delete images as well as running vulnerability scans. They are not allowed to add additional users to the project, change any of the policies, or change the configuration. Additional Jira tickets should be submitted with justifications to adjust these. 

## Labels

Select the Labels tab and use the `+ NEW LABEL` button to open a drop down. In the `Label Name` field entry Creation-Ticket, set the color to the brighter green (#48960C), and in the `Description` filed enter the ticket number for the user request that prompted the new project. Select OK when those have been filled out to add that Label for an audit trail.   

## Update User Request

Once all the above steps have been completed the project is ready to be turned over to the user. We can update the Jira ticket with the details. Below is an example response that provides the users with details about accessing the projects and some of the restrictions we've put in place:

```
I've created the <user-supplied-name> project and added you as a maintainer to that project. You can push/pull/delete the images and run image vulnerability scans.

Go ahead and log in to https://hub.k8s.ucar.edu/ with your CIT credentials, no @ucar.edu is required for the username. You should see the project listed in the UI. You'd use the same credentials and URL for a docker/podman login command. 

Notes on the current project setup:

To start the project is private. Only users that are project members will have access to pull images. We've limited your permissions inside the project to the maintainer role which is one step below admin. If you need to add additional users to the project, create a robot account, or do something else that you need more permissions to do please open another ticket for assistance. 

We limited the project to 5 GB for image storage and set up a retention policy to keep the 3 most recently pulled images. The image vulnerability scanner will automatically run when images are added and create a report for you on any known vulnerabilities found in the image. There is a policy to prevent images from running with fixable vulnerabilities over Medium criticality. These settings can be tweaked to meet requirements if they are preventing progress by opening a new ticket with the team and providing a justification.  

This ticket will now be place in Review and will be closed after a few days. If you have any issues, or want to confirm everything works, please let us know. 
``
