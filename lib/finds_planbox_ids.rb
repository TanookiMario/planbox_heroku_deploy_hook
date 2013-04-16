class FindsPlanboxIds
  def initialize(git_log)
    @git_log = git_log
  end

  def find
    @git_log
      .scan(/\[#(\d+)\]/)
      .map(&:first)
      .map(&:to_i)
  end
end