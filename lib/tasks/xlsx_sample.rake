namespace :xlsx_sample do
  desc "実行処理の説明"
  task :sample do
    require 'rubyXL/convenience_methods/cell'
    require 'rubyXL/convenience_methods/workbook'
    require 'rubyXL/convenience_methods/worksheet'
    puts "START"
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    worksheet.change_row_vertical_alignment(0, 'top')
    worksheet.change_row_vertical_alignment(1, 'top')
    worksheet.change_row_vertical_alignment(2, 'top')

    worksheet.change_column_width(1, 30)

    worksheet.add_cell(0, 0, 'A')
    worksheet.add_cell(0, 1, 'B')
    worksheet.add_cell(0, 2, 'C')


    worksheet.add_cell(1, 0, 'A1')
    worksheet
      .add_cell(1, 1, 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもも')
      .change_text_wrap(true)

    workbook.write("sample.xlsx")

    puts "END"
  end
end
