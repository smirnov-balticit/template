class FeedbackMailer < ActionMailer::Base
  default from: "from@example.com"

  def feedback_email(recepient, feedback)
    mail(to: recepient, subject: 'You have new feedback message', from: feedback.email) do |format|
      format.html { render text: feedback.message }
    end
  end
end
