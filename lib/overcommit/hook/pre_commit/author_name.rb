module Overcommit::Hook::PreCommit
  # Ensures that a commit author has a name with at least first and last names.
  class AuthorName < Base
    def run
      result = execute(%w[git config --get user.name])
      name = result.stdout.chomp

      unless name.split(' ').count >= 2
        return :fail,
               "Author must have at least first and last name, but was: #{name}.\n" \
               'Set your name with `git config --global user.name "Your Name"`'
      end

      :pass
    end
  end
end
