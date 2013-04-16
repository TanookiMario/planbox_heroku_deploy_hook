require 'spec_helper'
require_relative '../lib/finds_pivotal_ids'

describe FindsPivotalIds do

  let(:git_log) {
<<GITLOG
 * Keith Weightman: [#43143043] Requires a student to have an attempt before live help can be shown.
 * jnf: [#37341713] Add some basic name sanitization to Student, with a caveat for demo students.
 * Chris Winters: default should be ShardedImage, not Image
 * Doug DiFilippo: [#42648981] Adjusts the size of the PSP error window.
 * Chris Winters: try to avoid intermittent "Item number already taken" messages during tests
 * jnf: [#43514743] Provides basic placecholder support to browsers that don't have it.
 * jnf: Move ie placeholders js file to vendor/assets.
GITLOG
  }

  subject { FindsPivotalIds.new(git_log).find }

  it { should include(43143043) }
  it { should include(37341713) }
  it { should include(42648981) }
  it { should include(43514743) }

end
