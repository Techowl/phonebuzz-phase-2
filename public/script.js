$(document).ready(function() {
  form.init();
});

form = {
  messageToUser: null,
  phoneInput: null,

  init: function() {
    this.messageToUser = $('.message-to-user');
    this.phoneInput = $('.phone-num-form input[type="tel"]');
    $('.phone-num-form input[type="submit"]').click(form.handleSubmit);
  },

  handleSubmit: function(e) {
    e.preventDefault();
    form.showActivelyValidating();
    var input = form.phoneInput.val();
    form.validate(input);
  },

  showActivelyValidating: function() {
    form.messageToUser.removeClass('invalid');
    form.messageToUser.removeClass('valid');
    form.messageToUser.addClass('validating');
    form.messageToUser.text('Validating...');
  },

  validate: function(input) {
    var numbers = this.getNumbersFromInput(input);
    var numString = numbers.join('');
    if (numString.length == 10) {
      form.isValid(numString);
    } else {
      form.isInvalid();
    }
  },

  getNumbersFromInput: function(input) {
    var numbers = $.map(input.split(''), function(n) {
      n = (parseInt(n, 10));
      if (isNaN(n)) {
        return '';
      } else {
        return n + ''; // convert back to string
      }
    });
    return numbers;
  },

  isValid: function(numString) {
    this.removeInputText();
    this.messageToUser.removeClass('validating');
    this.messageToUser.addClass('valid');
    this.messageToUser.text('Thanks! You\'ll receive a phone call shortly.');
    this.submitNumber(parseInt(numString, 10));
  },

  isInvalid: function() {
    this.removeInputText();
    this.messageToUser.removeClass('validating');
    this.messageToUser.addClass('invalid');
    this.messageToUser.text('Sorry, that wasn\'t valid. Please enter a ten-digit phone number.');
  },

  removeInputText: function() {
    this.phoneInput.val('');
  },

  submitNumber: function(number) {
    console.log(number)
    // make AJAX call
  }
};

      // <input type="tel" name="Called" placeholder="e.g. (337) 326-4355">
      // <input type="hidden" name="Caller" value="+13373264355">
      // <input type="hidden" name="Url" value="/hello">
      // <input type="timeout" name="Timeout" value="20">
      // action="/2008-08-01/Accounts/AC9493d6fa9f0617ca80fea8f92caac281/Calls" method="post"