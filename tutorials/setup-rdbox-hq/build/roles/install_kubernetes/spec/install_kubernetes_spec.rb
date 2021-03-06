require 'spec_helper'

#
describe package("kubeadm") do
  it { should be_installed.with_version(ENV["KUBEADM_VERSION"]) }
end      

#
describe package("kubelet") do
  it { should be_installed.with_version(ENV["KUBELET_VERSION"]) }
end      

#
describe package("kubectl") do
  it { should be_installed.with_version(ENV["KUBECTL_VERSION"]) }
end      

#
describe package("kubernetes-cni") do
  it { should be_installed.with_version(ENV["KUBECNI_VERSION"]) }
end      

#
lst_cmd = [ "kubeadm",
            "kubelet",
            "kubectl",
            "kubernetes-cni",
]
lst_cmd.each do |cmd|
  describe command("apt-mark showhold #{cmd}") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match '^' + "#{cmd}" + '$' }
  end
end

#
