module Kiq
  module CLI
    # Hosts logic for the backer object
    class Backer
      @@instance_collector = []
      # Allows access to name, credit_card, and amount
      attr_accessor :name, :credit_card, :amount

      # @param name [String]
      # @param amount [String]
      # @credit_card [String]
      # Initalizes a new Backer object
      def initialize(name, credit_card, amount)
        @name = name
        @amount = amount
        @credit_card = credit_card
      end

      # @param project [Project]
      # Check if project exists
      # @return [Boolean] warning if false
      def self.validate_project_exists(project)
        if !project.nil?
          return true
        else
          puts "ERROR: Project doesn't exist."
          return false
        end
      end

      # @param project [Project]
      # Checks all validation methods for a credit card
      # @return [Boolean] warning if false
      def self.validate_card(project, credit_card)
        return self.check_card_uniqueness(project, credit_card) && self.check_card_luhn_10(credit_card) && self.check_card_length(credit_card) && self.check_card_numeric(credit_card) && self.check_name_length(name)
      end

      # @param backer_name [String]
      # Checks all validation methods for a Backer's name
      # @return [Boolean] warning if false
      def self.validate_backer_name(backer_name)
        return self.check_name_characters(backer_name) && self.check_name_length(backer_name)
      end

      # @param amount [String]
      # Checks if the amount includes dollar signs
      # @return [Boolean] warning if false
      def self.check_amount_dollar_sign(amount)
        if !amount.include?('$')
          return true
        else
          puts "ERROR: Backing amount must not contain the '$' character or any other alphanumeric characters. Numbers only."
          return false
        end
      end

      # @param name [String]
      # Checks if the name has non-alphanumeric characters besides underscores and dashes
      # @return [Boolean] warning if false
      def self.check_name_characters(name)
        if name.scan(/[^\w-]/).empty?
          return true
        else
          puts "ERROR: Backer name may only use alphanumeric characters, underscores, and dashes."
          return false
        end
      end

      # @param name [String]
      # Checks if the string is between 4 and 20 characters
      # @return [Boolean] warning if false
      def self.check_name_length(name)
        if name.length >= 4 && name.length <= 20
          return true
        else
          puts "ERROR: Backer name must be between 4 and 20 characters."
          return false
        end
      end

      # @param project [Project]
      # @param credit_card [String]
      # Checks if the credit card is unique, no other Backer exists with that card
      # @return [Boolean] warning if false
      def self.check_card_uniqueness(project, credit_card)
        if project.backers[credit_card].nil?
          return true
        else
          puts "ERROR: That card has already been added by another user!"
          return false
        end
      end

      # @param credit_card [String]
      # Checks if the credit card passes the Luhn-10 algorithm
      # @return [Boolean] warning if false
      def self.check_card_luhn_10(credit_card)
        if self.luhn_valid?(credit_card)
          return true
        else
          puts "ERROR: That card fails Luhn-10!"
          return false
        end
      end

      # @param credit_card [String]
      # Checks if the credit card is under 19 numbers long
      # @return [Boolean] warning if false
      def self.check_card_length(credit_card)
        if credit_card.length <= 19
          return true
        else
          puts "ERROR: That card isn't less than or equal to 19 numbers!"
          return false
        end
      end

      # @param credit_card [String]
      # Checks if the credit card only contains numbers
      # @return [Boolean] warning if false
      def self.check_card_numeric(credit_card)
        if credit_card.match(/^\d+$/)
          return true
        else
          puts "ERROR: That card isn't purely numeric!"
          return false
        end
      end

      # @param credit_card [String]
      # Computes Luhn-10 algorithm
      # @return [Boolean]
      def self.luhn_valid?(credit_card)
        number = credit_card.reverse
        sum = 0
        count = 0

        number.each_char do |char|
          n = char.to_i
          if count.odd?
            n *= 2
          end

          if n >= 10
            n = 1 + (n - 10)
          end

          sum += n
          count += 1
        end

        (sum % 10) == 0
      end

    end
  end
end
