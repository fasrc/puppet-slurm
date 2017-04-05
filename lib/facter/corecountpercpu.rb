# Fact: corecountpercpu
#
# Purpose: Return the number of cores per physical processor
#
# Caveats: It assumes homogeneous physical CPUs
#
# Rants: Nacho Barrientos <nacho.barrientos@cern.ch>
#

#doesn't exist in facter 3+
#require 'facter/util/file_read'

default_corecount = 1
source = '/proc/cpuinfo'

Facter.add('corecountpercpu') do
  confine :kernel => :linux

  if File.exists?(source)

    #output = Facter::Util::FileRead.read(source)
    output = File.read(source)
    result = output[/^cpu cores.*(\d+)/, 1]

    setcode do
      if result.nil?
        default_corecount
      else
        result.to_i
      end
    end
  end
end
