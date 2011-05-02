#!/usr/bin/env ruby
# changes messages.po on $stdin from Firefox to Thunderbird and writes output to $stdout
# cat ../../KITSUNE/LOCALE_CHECKOUT/trunk/locales/de/LC_MESSAGES/messages.po | ./changeMessages-po-to-tb.rb 2>convert.de.messages.stderr.txt 1>thunderbird.de.messages.po
re_str = [
  'msgid \"Love Firefox and have a few moments to help\?<br /> Help other Firefox users on Twitter. Good things will come to those who tweet!\"',
  'msgid \"Sign in with <mark>Twitter</mark>\"',
  'msgid \"Want to go beyond 140',
  'msgid \"Firefox Support Home Page\"',
  'msgid \"Need Help With <mark>Firefox\?</mark>\"',
  'msgid \"Firefox Sync Support Home Page\"',
  'msgid \"Firefox Help for Sync\"',
  'msgid \"Need Help With <mark>Firefox Sync\?</mark>\"',
  'msgid \"Firefox Help\"',
  'msgid \"Firefox version\"',
  'msgid \"Search the Firefox Support Knowledge Base and Support Forum.\"',
  'msgid \"Firefox version:\"',
  'msgid \"You\'ve come to the right place for Firefox help!\"',
  'msgid \"Firefox Help\"',
  'msgid \"Did you know that Firefox Help is powered by volunteer superheroes all around the world\?\"',
  'msgid \"Firefox\"',
  'msgid \"Firefox Add-ons\"',
  'msgid \"About Firefox\"',
  'msgid \"Search Firefox Help\"',
  'msgid \"Firefox Help Home\"',
  'msgid \"Return to Firefox Support homepage\"',
  '#~ msgid \"Fastest Firefox\"',
  '#~ msgid \"SpreadFirefox\"',
  '#~ msgid \"Other Firefox Support\"'
]

$messages_po_Array = []

def change_firefox_to_thunderbird(r_str, msgstr_offset, gsub_regex, gsub_replacement)
 re = Regexp.new(r_str)
 index = $messages_po_Array.find_index{|v|v =~ re}
 if index
   before = $messages_po_Array[index + msgstr_offset]
   $messages_po_Array[index + msgstr_offset] = $messages_po_Array[index + msgstr_offset].gsub(Regexp.new(gsub_regex),gsub_replacement)
   $stderr.printf "CHANGED msgid:%s FROM:%s TO:%s\n",r_str, before, $messages_po_Array[index + msgstr_offset]
 end  
end

$messages_po_Array = $stdin.readlines

re_str.each { |r_str | change_firefox_to_thunderbird(r_str, 1, 'Firefox', 'Thunderbird') }

# process the exceptions
# exception 1:   'msgid \"Firefox 4\"' becomes "Thunderbird" NOT Thunderbird 4
change_firefox_to_thunderbird('msgid \"Firefox 4\"', 1, 'Firefox 4', 'Thunderbird')

# exception 2: read 2 lines instead of 1 line and then replace Firefox with Thunderbird
# for: the "kadir topal" msgid
change_firefox_to_thunderbird('contact Kadir Topal for more info', 2, 'Firefox', 'Thunderbird')

# exception 3: msgstr 'Firefox Help' appears twice, the 2nd time with msgctxt "site_title" before the msgstr,
# 2nd argument is "2" because the order is 'msgctxt site_title'then msgid "Firefox Help" and then the msgstr
change_firefox_to_thunderbird('msgctxt \"site_title\"',2, 'Firefox', 'Thunderbird')

$messages_po_Array.each {|v| puts "#{v}"} 
