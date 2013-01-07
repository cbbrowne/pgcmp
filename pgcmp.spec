Summary:	A tool to compare differences between two Postgres database schemas
Name:		pgcmp
Version:        1.1
Release:        1%{?dist}
License:	TBD
Group:		Applications/Databases
URL:		http://afilias.info
Source0:	pgcmp-%{version}.tar.bz2
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires:	postgresql-client
BuildArch:      noarch
Vendor:         Afilias Limited
Packager:       Christopher Browne <cbbrowne@afilias.info>

%description 
pgcmp is intended to perform comparisons ("reconciliation") of schemas
between databases to determine if they are equivalent, and to list
differences, should they differ.

%prep
%setup -q

%build

%install
rm -rf %{buildroot}/usr/bin/pgcmp
mkdir -p %{buildroot}/usr/bin
install -D pgcmp %{buildroot}/usr/bin/pgcmp

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%attr(755,root,root) %{_bindir}/pgcmp
/usr/bin/pgcmp
%doc README.txt

%changelog
* Tue Aug 7 2012 Christopher B Browne <cbbrowne@afilias.info>
- Initial packaging
