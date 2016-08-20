# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="GUI frontend for encfs"
HOMEPAGE="https://github.com/variar/kencfs-kde5"
SRC_URI="https://github.com/variar/kencfs-kde5/archive/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtsingleapplication[qt5]
	kde-frameworks/knotifications
	kde-frameworks/kconfig
	kde-frameworks/kwallet
"

RDEPEND="${DEPEND}
	sys-fs/encfs
"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.0-encfs5.patch"
	"${FILESDIR}/${PN}-1.6.2-desktop.patch"
)

src_unpack() {
	unpack ${A}
	mv ${PN}-${P} ${S}
}

src_prepare() {
	default

	sed -i ${PN}.pro -e "/^doc.path =/s/${PN}/${PF}/" \
		|| die "sed docdir failed"
	sed -i ${PN}.pro -e "/^icon.path =/s/${PN}/${PF}/" \
		|| die "sed icondir failed"
	sed -i ${PN}.pro -e "/^data.path =/s/${PN}/${PN}\/${PF}/" \
		|| die "sed datadir failed"

	sed -i ${PN}.pro -e "/^desktop.files =/s/${PN}/${PF}/" \
		|| die "sed desktop file failed"
	
	mv ${PN}.desktop ${PF}.desktop
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
