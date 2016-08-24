class ZombieMailer < ApplicationMailer

  def decomp_change
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def lost_brain
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
