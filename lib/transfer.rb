require_relative "./bank_account.rb"

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  # reason this works because you are passing an instance from the bank account into the transfer instance
  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  # This one is about control flow and its important for methods like this one and reverse_transfer
  def execute_transaction
    if self.valid? && self.status == "pending" && self.sender.balance > self.amount
      self.status = "complete"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  # You see controll flow and all the data you need to operate was already inside
  def reverse_transfer
    if self.status == "complete"
      self.status = "reversed"
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
    end
  end
end

# When building your own apps think about controll flow and looping(continuation of the game or state of the thing you are building)