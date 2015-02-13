# Michael Parker - github.com/mikkage
# 2/12/2015

# convert_texts.rb
# Converts iPhone text messages in HTML format to text messages for Windows Phone 8
# If you don't know how to use this, view the readme at https://github.com/mikkage/winphone8-sms-import

# Creates an SMS message in vmsg format
def make_vmsg(date, number, type, msg)
  if type == "SNT"
    type = "SENDBOX"
  end
  if type == "RCV"
    type = "INBOX"
  end

  vmsg_string = "BEGIN:VMSG\nVERSION: 1.1\nBEGIN:VCARD\n"
  vmsg_string += "TEL:#{number}\n"
  vmsg_string += "END:VCARD\nBEGIN:VBODY\n"
  vmsg_string += "X-BOX:#{type}\n"
  vmsg_string += "X-READ:READ\nX-SIMID:0\nX-LOCKED:UNLOCKED\nX-TYPE:SMS\n"
  vmsg_string += "Date:#{date}\n"
  vmsg_string += "Subject;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:#{msg}\n"
  vmsg_string += "END:VBODY\nEND:VMSG\n"
  return vmsg_string
end

# Open files to read from and write to
iphone_texts = File.open("iphone_sms.html", "r")
vmsg_file = File.open("sms.vmsg", "w")

iphone_texts.each_line do |text|
  if text.include?("<td>SNT</td>") || text.include?("<td>RCV</td>")
    # Extract date and fix format
    text_info = text.split("<td>")
    date = text_info[1]
    date.gsub!("-", "/")
    date.gsub!("@", " ")
    date.gsub!("</td>", "")

    # Get phone number sent to or received from
    number = text_info[2]
    number.gsub!("</td>", "")

    # Get whether the message was sent or received
    type = text_info[3]
    type.gsub!("</td>", "")

    # Get the message itself
    message = text_info[4]
    message.gsub!("</td></tr>", "")
    message[message.length - 1] = ""
    message.gsub!("&quot;", "\"")
    message.gsub!("&amp;", "&")
    message.gsub!("&nbsp;", "")

    # Don't export group SMS
    if !number.include?("Group")
      write_string = make_vmsg(date, number, type, message)
      vmsg_file.write write_string
    end
  end
end

iphone_texts.close
vmsg_file.close
