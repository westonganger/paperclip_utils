#!/usr/bin/env ruby -w
require 'yaml'
require 'active_record'
require 'minitest'
require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))


class TestPaperclipUtils < MiniTest::Test
  class Post < ActiveRecord::Base

  end

  test "test_spreadsheet_options" do
    assert_equal([:name, :title, :content, :votes, :ranking], Post.spreadsheet_columns)
    assert_equal([:name, :title, :content, :votes, :created_at, :updated_at], OtherPost.column_names)
    assert_equal([:name, :title, :content], PlainPost.spreadsheet_columns)
  end
end
