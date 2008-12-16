require 'test/unit'
 
def is_comment(line)
  puts line
  if (line =~ /^\/\//) or (line =~ /^\/\*/) or (line =~ /^\*/) or (line =~ /^\*\//) or (line =~ /^\s*$/)
    #~ puts "true"
    return true
  end
  #~ puts "false"
  return false
end
 
def count_line(code)
    count = 0
    code.each do | line |
      line.sub!(/^\s*/, '')
      if is_comment(line) == false
        count += 1
      end
    end
    count
end
 
class TestCountCodeLine < Test::Unit::TestCase
  def test_is_comment()
  code = "// This file contains 3 lines of code 
  public interface Dave { 
    /** 
     * count the number of lines in a file 
     */ 
    int countLines(File inFile); // not the real signature! 
  } "
  assert_equal 3, count_line(code)
  
  code = "  /***** 
  * This is a test program with 5 lines of code 
  *  \/* no nesting allowed! 
  //*****//***/// Slightly pathological comment ending... 
  public class Hello { 
      public static final void main(String [] args) { // gotta love Java 
          // Say hello 
        System./*wait*/out./*for*/println/*it*/(\"Hello/*\"); 
      } 
 
  } "
  assert_equal 5, count_line(code)
  
  code = "//4 lines of code 
public class StringLiteralTrick {public static final void main(String [] args) { 
String a=\"/*\"; 
String b=\"...\";/*...*/ 
}} "
  assert_equal 4, count_line(code)
  end
end