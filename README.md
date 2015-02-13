iPhone Text Message to Windows Phone 8 Text Message Converter
--
This is the repository for a tool I created to export text messages from iPhone and convert them into a format that can imported into Windows Phone 8.

While newer versions of the iPhone can connect via BlueTooth to transfer text messages to your Windows Phone,
older iPhones(anything before iPhone 6) are out of luck as it's not supported on those devices. With this tool, you should be able to transfer over most of your messages to your
new Windows Phone, no matter how old of an iPhone you have.

This tool was put together quickly to just get the job done, so while it works, it is a bit rough around the edges.

Requirements
--
* Ruby
* A microSD card for your Windows Phone

Usage
--
* Follow the instructions on http://www.iphone-sms.com/ to get the text messages off of your iPhone
* Use the service on the above site to convert the text messages to HTML format
* Move the downloaded HTML file to the same directory as convert_texts.rb
* Run the script with ```ruby convert_texts.rb```
* sms.vmsg should have been created in the same directory as the HTML file and ruby script
* Load sms.vmsg onto your microSD card
* On your Windows Phone, start the  Transfer My Data app
* Click on ```...``` in the bottom right corner
* Select 'import from sd card'
* Select the text messages you want to import and start the transfer
* Once it's complete, all* of the text messages you had on your iPhone will now be on your Windows Phone!

Limitations
--
* This tool does NOT import group texts.
* When importing messages sent via iMessage, messages to/from any iMessage account that isn't a phone number will remain the same.
For example, any messages to/from iMessage account `foo@bar.com` will retain the same name after being imported, and will not be useful for anything
but archival purposes since you won't be able to send to or receive from that account on your Windows Phone.
* Some special characters are not accounted for. While `&amp;` is correctly converted to `&`, other special characters are not caught.
If you need to overwrite some other special characters, feel free to modify the source code.

Contributing
--
If you have any ideas on how to improve the tool or fix some of its shortcomings, feel free to fork the repo, make your changes, and create a merge request.
