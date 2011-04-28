#!/usr/bin/env ruby
# changes javascript.po on $stdin from Firefox to Thunderbird and writes output to $stdout
# cat ../../KITSUNE/LOCALE_CHECKOUT/trunk/locales/de/LC_MESSAGES/javascript.po | ./changeJS-po-to-tb.rb 2>convert.de.javascript.stderr.txt 1>thunderbird.de.javascript.po
js_po_Array = $stdin.readlines
re = Regexp.new('msgid \"Show content only for specific versions of Firefox or operating systems.\"')
index = js_po_Array.find_index{|v|v =~ re}
if index
  before = js_po_Array[index + 1]
  js_po_Array[index + 1] = js_po_Array[index + 1].gsub(/Firefox/,"Thunderbird")
  $stderr.printf "Changing:%s to:%s\n",before, js_po_Array[index + 1]
end  
js_po_Array.each {|v| puts "#{v}"} 
