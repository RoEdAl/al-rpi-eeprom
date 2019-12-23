# Maintainer: Edmunt Pienkowsky <roed@onet.eu>

pkgname=rpi-eeprom
pkgver=20191217
pkgrel=1
pkgdesc='Raspberry Pi4 boot EEPROM updater'
arch=('any')
url='http://github.com/raspberrypi/rpi-eeprom'
license=('custom')
depends=('python' 'python-setuptools' 'raspberrypi-firmware' 'binutils' 'sed' 'grep')
optdepends=('flashrom')
options=(!strip)
source=(
	'rpi-eeprom::git+https://github.com/raspberrypi/rpi-eeprom.git'
	'setup.py'
	'rpi-eeprom-update.sh'
)
backup=(
	etc/default/rpi-eeprom-update
)
sha256sums=('SKIP'
            'e799c62d76e10c380679a8c84659c5203b5fc59f72ea5ed1c9122f36ef5a41c5'
            '3270dcbf7c097030bf3f3c350e0c1c53e2c3be8215a5fdee2b72451a676fafe1')

prepare() {
	mkdir ${srcdir}/rpi_eeprom_py
	cd ${srcdir}/rpi_eeprom_py
	mkdir rpi_eeprom_config
	touch rpi_eeprom_config/__init__.py
	cp ${srcdir}/${pkgname}/rpi-eeprom-config rpi_eeprom_config/__main__.py
	sed -i '2d' rpi_eeprom_config/__main__.py
	cp ${srcdir}/setup.py .
}

pkgver() {
	cd ${srcdir}/${pkgname}
	git log -1 --format=%cd --date=short|tr -d -
}

build() {
	cd ${srcdir}/rpi_eeprom_py
	python setup.py build
}

package() {
	cd ${srcdir}/rpi_eeprom_py
	python setup.py install --root=${pkgdir} --optimize=2 --install-scripts=/usr/lib/${pkgname}

	cd ..

	mkdir -p ${pkgdir}/usr/lib/firmware/raspberrypi/bootloader
	cp -rfv rpi-eeprom/firmware/* ${pkgdir}/usr/lib/firmware/raspberrypi/bootloader

	mkdir -p ${pkgdir}/usr/lib/${pkgname}
	cp -fv rpi-eeprom/rpi-eeprom-update ${pkgdir}/usr/lib/${pkgname}
	
	mkdir -p ${pkgdir}/etc/default
	cp -fv rpi-eeprom/rpi-eeprom-update-default ${pkgdir}/etc/default/rpi-eeprom-update

	mkdir -p ${pkgdir}/usr/bin
	cp -fv rpi-eeprom-update.sh ${pkgdir}/usr/bin/rpi-eeprom-update
	ln -s  /usr/lib/firmware/raspberrypi/bootloader/vl805 ${pkgdir}/usr/bin/vl805
	ln -s /usr/lib/${pkgname}/rpi-eeprom-config ${pkgdir}/usr/bin/rpi-eeprom-config
}
