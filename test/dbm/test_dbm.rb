require 'test/unit/testsuite'
require 'test/unit/testcase'

begin
  require 'dbm'
rescue LoadError
end

if defined? DBM
  require 'tmpdir'
  require 'fileutils'

  class TestDBM < Test::Unit::TestCase
    TMPROOT = "#{Dir.tmpdir}/ruby-gdbm.#{$$}"

    def setup
      Dir.mkdir TMPROOT
    end

    def teardown
      FileUtils.rm_rf TMPROOT if File.directory?(TMPROOT)
    end

    def test_freeze
      DBM.open("#{TMPROOT}/a.dbm") {|d|
        d.freeze
        assert_raises(TypeError) { d["k"] = "v" }
      }
    end
  end
end
