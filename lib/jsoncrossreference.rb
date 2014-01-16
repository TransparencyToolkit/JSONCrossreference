require 'datacalc'

class JSONCrossreference

  def initialize(input1, input2)
    @input1 = input1
    @input2 = input2
  end

  # What: Cross-references fields in two files
  # Input: Variable number of arrays with name of fields to compare
  # Output: JSON with matches 
  # Limitations: Only returns data from one file. Matching multiple fields functions as && not ||. Only takes 2 files input
  def compare(*fieldnames)
    if JSON.parse(@input2).length < JSON.parse(@input1).length
      file1 = JSON.parse(@input2)
      file1length = file1.length
      file2 = @input1

      tmparray = Array.new
      fieldnames.each do |field|
        tmparray.push([field[1], field[0]])
      end
      fieldnames = tmparray
    else 
      file1 = JSON.parse(@input1)
      file1length = file1.length
      file2 = @input2
    end
    
    tmpfile = Array.new
    (0..file1length-1).each do |l|
      fieldnames.each do |field|
        value = (file1[l])[field[0]]
        matchnames = [field[1], value]
        m = DataCalc.new(file2)
        tmpfile << m.match(matchnames)
      end
    end

    return tmpfile.to_json
  end
end
