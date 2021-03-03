class PassesScan

  #atributos
  attr_reader :csv, :passes_arrey

  #construtor
  def initialize(csv)
    @csv = csv
    @passes_arrey = scan()
  end

  #metodos
  def highest_id()
    h_id = 0
    @passes_arrey.each do |hash|
      if hash[:ID].to_i > h_id 
        h_id = hash[:ID].to_i
      end       
    end
    return h_id
  end
  
  def lowest_id()
    l_id = highest_id()
    @passes_arrey.each do |hash|
      if hash[:ID].to_i < l_id 
        l_id = hash[:ID].to_i
      end       
    end
    return l_id
  end

  def missing_id
    sorted = id_sorter()
    i = 1
    sorted.each do |pass|
      if (pass[:ID] + 1 != sorted[i][:ID])
        return (pass[:ID] + 1)
      else
        i += 1
      end
    end
    
  end

  #metodos privados
  private

  def scan()
    passes_hash = []
    csv.each do |array|
      i = 0
      rows = (0..127).to_a
      new_rows = []
      while i < 7 do
        pass = array[0]
        letter = pass[i]
        if letter == 'B'
          new_rows = rows.each_slice(rows.size/2).to_a
          rows = new_rows[1]
        else
          new_rows = rows.each_slice(rows.size/2).to_a
          rows = new_rows[0]
        end
        new_rows = []
        i += 1
      end
      colum = colum_finder(array)
      id = (rows[0] * 8) + colum[0]
      passes_hash << {pass: array[0], row: rows[0], colum: colum[0] ,ID: id}
    end
    return passes_hash
  end

  def colum_finder(array)
      j = 7
    columns = (0..7).to_a
    new_columns = []
    
    while j < 10 do
      pass = array[0]
      letter = pass[j]
    if letter == 'R'
      new_columns = columns.each_slice(columns.size/2).to_a
      columns = new_columns[1]
    else
      new_columns = columns.each_slice(columns.size/2).to_a
      columns = new_columns[0]
    end
    pass = ''
      new_columns = []
      j += 1
    end
    colum = columns
    return colum
  end

  def id_sorter()
    sorted_ids = @passes_arrey.sort_by { |hash| hash[:ID] }
    return sorted_ids
  end
  
end
