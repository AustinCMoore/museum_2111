class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name     = name
    @exhibits = []
    @patrons  = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    #for each patron's interest (array)
    #check if interest matches with exhibit's name (array of hashes)
    #if true, hash needs to be added to new array
    #if false, next hash should be compared to the patron's interests
    #return array of exhibits
    @exhibits.select do |exhibit|
      patron.interests.any? do |interest|
        exhibit.name == interest
      end
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest #feels like im violating D.R.Y. here....
    hash = Hash.new { |hash,key| hash[key] = [] }
    @exhibits.each do |exhibit|
      interested_patrons = @patrons.select do |patron|#returns patron where interest is true
        patron.interests.any? { |interest| interest == exhibit.name }
      end
      hash[exhibit] = interested_patrons
      # require "pry" ; binding.pry
    end
    return hash
    #exhibit must be a unique key, value must be array of selected patrons
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].select do |patron|
      patron_cant_afford?(patron, exhibit)
    end
    #call helper method patrons_by_exhibit_interest by using exhibit instance as key
  end

  def patron_cant_afford?(patron, exhibit)
    if patron.spending_money < exhibit.cost
      true
    else
      false
    end
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).sample
    #call helper method patrons_by_exhibit_interest by using exhibit instance as key
    #if array == 0, return nil (?)
  end
end
