#!/usr/bin/env ruby
# encoding: utf-8
require 'digest/sha1'


cache_aql = ""
cache_len = 0



loop do
  puts "Wake up at #{Time.now}"

  sql = Digest::SHA1.hexdigest(File.read("/var/www/although.com/master/db/production.sqlite3"))
  if sql != cache_aql
    `cp /var/www/although.com/master/db/production.sqlite3 ~/Dropbox/MyBlog_数据库备份/development#{Time.now.to_i}.sqlite3`
    cache_aql = sql
    puts "Backup database"
  end

  len = Dir.entries("/var/www/although.com/master/public/uploads/pictures/").length
  if len != cache_len
    `tar -zcvf ~/Dropbox/MyBlog_数据库备份/uploads#{Time.now.to_i}.tar.gz /var/www/although.com/master/public/uploads`
    cache_len = len
    puts "Backup pictures"
  end

  puts "Sleeping ..."
  
  sleep(240)

end

