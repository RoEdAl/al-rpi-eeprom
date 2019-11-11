from setuptools import setup

setup(
    name='rpi-eeprom-config',
    version='1.0.0',
    packages=['rpi_eeprom_config'],
    entry_points={
        'console_scripts': [
		'rpi-eeprom-config=rpi_eeprom_config.__main__:main'
	]
    },
)
