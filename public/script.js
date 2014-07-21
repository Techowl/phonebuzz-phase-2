$(document).ready(function() {
  $('.phone-num-form input[type="submit"]').click(form.handleSubmit);
});

form = {
  handleSubmit: function(e) {
    e.preventDefault();
    $('.message-to-user').addClass('validating');
    $('.message-to-user').text('Validating...');
    form.validateInput(e);
  },

  validateInput: function(e) {
    // validate
    // if valid, submit and change text/class to 'submitted'
    // else clear field and tell user to try again, changing text/class
  }
};

      // <input type="tel" name="Called" placeholder="e.g. (337) 326-4355">
      // <input type="hidden" name="Caller" value="+13373264355">
      // <input type="hidden" name="Url" value="/hello">
      // <input type="timeout" name="Timeout" value="20">
      // action="/2008-08-01/Accounts/AC9493d6fa9f0617ca80fea8f92caac281/Calls" method="post"