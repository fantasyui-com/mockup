Name:    mockup
Version: 1
Release: 1%{?dist}
Summary: Perspective app screens.

License: GNU GENERAL PUBLIC LICENSE
Source0: mockup
BuildArch: noarch
Requires: getopt,ImageMagick,bc

%description
Perspective app screens and isometric mock-up tool. Automated high quality, high resolution, marketing art designer for mockups. Written in minimalist Bash using ImageMagick and Love!

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 755 %{SOURCE0} %{buildroot}%{_bindir}

%files
%{_bindir}/mockup

%changelog
