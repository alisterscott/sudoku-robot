require 'watir-webdriver'

module Sudoku
  class WebGame

    URLS = {
        :easy => 'http://www.websudoku.com/?level=1',
        :medium => 'http://www.websudoku.com/?level=2',
        :hard => 'http://www.websudoku.com/?level=3',
        :evil => 'http://www.websudoku.com/?level=4'
    }
    ROW_LENGTH = 9

    attr_reader :url, :grid_string, :browser

    def initialize(browser, level, override_url=nil)
      @browser = browser
      @level = level.to_sym
      raise "Unknown level #{@level}" unless URLS.include? @level
      @url = override_url || URLS[@level]
      @browser.goto @url
      @grid_string = ''
      @browser.frame.table(:class => 't').text_fields.each_with_index do |text_field, index|
        if (index % ROW_LENGTH == 0)
          @grid_string << "\n" unless (index/ROW_LENGTH).to_i == 0
        else
          @grid_string << " "
        end
        @grid_string << (text_field.value == '' ? '_' : text_field.value )
      end
    end

    def set_cells cells
      cells.each do |cell|
        @browser.frame.table(:class => 't').text_field(:index => cell.grid_index).set cell.value
      end
    end

    def click_how_am_i_doing
      @browser.frame.button(:value => ' How am I doing? ').click
    end

  end
end