#!/usr/bin/env ruby
# changes messages.po and javascript.po from Firefox to Thunderbird
require 'fileutils'
locale_dirs = [
'ak',
'ar',
'as',
'ast',
'bg',
'bn_BD',
'bn_IN',
'bs',
'ca',
'cs',
'da',
'el',
'eo',
'et',
'eu',
'fa',
'fi',
'fr',
'fur',
'fy_NL',
'ga',
'ga_IE',
'gd',
'gl',
'gu_IN',
'he',
'hi_IN',
'hr',
'hu',
'hy_AM',
'id',
'is',
'kk',
'kn',
'ko',
'lt',
'mk',
'mn',
'mr',
'ms',
'my',
'nb_NO',
'no',
'oc',
'pa_IN',
'pt_BR',
'pt_PT',
'rm',
'ro',
'ru',
'rw',
'si',
'sk',
'sl',
'sq',
'sr_CYRL',
'sr_LATN',
'sv_SE',
'ta_LK',
'te',
'th',
'tr',
'uk',
'vi',
'zh_CN',
'zh_TW'
]
locale_dirs.each do |dir| 
  messages = dir + '/LC_MESSAGES/messages.po'
  messages_old =  messages +'.old'
  m_err = messages + '.STDERR.txt'
  javascript = dir + '/LC_MESSAGES/javascript.po'
  javascript_old = javascript + '.old'
  j_err = javascript + '.STDERR.txt'
  $stderr.printf("messages.po: renaming:%s to %s\n",messages,messages_old);
  File.rename(messages, messages_old)
  $stderr.printf("javascript.po: renaming:%s to %s\n",javascript, javascript_old)
  File.rename(javascript, javascript_old)
  javascript_command_line = sprintf("cat %s | /Users/rolandtanglao/Documents/MOZILLA_MESSAGING/KITSUNE_UTILS/kitsune-utils/changeJS-po-to-tb.rb 1>%s 2>%s", javascript_old, javascript, j_err)
  $stderr.printf("js command line is:%s\n", javascript_command_line)
  `#{javascript_command_line}`
  messages_command_line = sprintf("cat %s | /Users/rolandtanglao/Documents/MOZILLA_MESSAGING/KITSUNE_UTILS/kitsune-utils/changeMessages-po-to-tb.rb 1>%s 2>%s", messages_old, messages, m_err)
  $stderr.printf("messages command line is:%s\n", messages_command_line)
  `#{messages_command_line}`
  $stderr.puts("------------------------\n")
end

