# Maintainer: Edmunt Pienkowsky <roed@onet.eu>

pkgname=rpi-eeprom
pkgver=20191108
pkgrel=1
pkgdesc='Raspberry Pi4 boot EEPROM updater'
arch=('any')
url='http://github.com/raspberrypi/rpi-eeprom'
license=('custom')
depends=('python' 'raspberrypi-firmware')
optdepends=('flashrom')
makedepends=('python-setuptools')
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
            '17750343aec11614bddac07ce853b6dd5bdc9627e6676cf298e3e75ae3be069f'
            '27e516d95507324c3b49d55f2b1d30b2a186965a058d6fe767245d7335de6366')

pkgver() {
	cd ${srcdir}/${pkgname}
	git log -1 --format=%cd --date=short|tr -d -  
}

prepare() {
	mkdir ${srcdir}/rpi_eeprom_py
	cd ${srcdir}/rpi_eeprom_py
	mkdir rpi_eeprom_config
	touch rpi_eeprom_config/__init__.py
	cp ${srcdir}/${pkgname}/rpi-eeprom-config rpi_eeprom_config/__main__.py
	sed -i '2d' rpi_eeprom_config/__main__.py
	cp ${srcdir}/setup.py .
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
}
