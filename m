Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AA5F85B4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJHPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJHPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44F34720
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4046068C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87370C433D6;
        Sat,  8 Oct 2022 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665241241;
        bh=cVku6HT9SIfR8rcovjoXm7gxw41WGlrjFicSAjsZlyo=;
        h=Date:From:To:Cc:Subject:From;
        b=vDNphjr8hJFRXQ8uQWzZAjcChLmxSH3ajMTkphnNwgYSaRiSmzZd8P+FJaSuO9n+o
         HYqvMl7Lg3nYTZItM7Z/o7G4bVyN5kx4Zj27WSUTIHBZP5AnpTHDTNQWn4YGCvNR7Z
         CoNDjsqxyMsneFuPh+LKrKPvw2orQclT7oKUxINE=
Date:   Sat, 8 Oct 2022 17:01:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.1-rc1
Message-ID: <Y0GQwYdy+s8zfd2g@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc1

for you to fetch changes up to 7cd04013fbf3e6dcb67ca6b59aa813269a2ad9ce:

  w1: Split memcpy() of struct cn_msg flexible array (2022-09-30 14:37:10 +0200)

----------------------------------------------------------------
Char/Misc and other driver changes for 6.1-rc1

Here is the large set of char/misc and other small driver subsystem
changes for 6.1-rc1.  Loads of different things in here:
  - IIO driver updates, additions, and changes.  Probably the largest
    part of the diffstat
  - habanalabs driver update with support for new hardware and features,
    the second largest part of the diff.
  - fpga subsystem driver updates and additions
  - mhi subsystem updates
  - Coresight driver updates
  - gnss subsystem updates
  - extcon driver updates
  - icc subsystem updates
  - fsi subsystem updates
  - nvmem subsystem and driver updates
  - misc driver updates
  - speakup driver additions for new features
  - lots of tiny driver updates and cleanups

All of these have been in the linux-next tree for a while with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      misc: fastrpc: Use USER_PD define in fastrpc_get_info_from_dsp

Abhijeet Dharmapurikar (1):
      spmi: pmic-arb: add a print in cleanup_irq

Al Viro (1):
      binderfs: rework superblock destruction

Alexander Baehr (1):
      parport: add support for Netmos device 9900

Andrea Merello (14):
      iio: add modifiers for linear acceleration
      iio: document linear acceleration modifiers
      iio: event_monitor: add linear acceleration modifiers
      iio: add modifers for pitch, yaw, roll
      iio: document pitch, yaw, roll modifiers
      iio: event_monitor: add pitch, yaw and roll modifiers
      iio: add support for binary attributes
      iio: imu: add Bosch Sensortec BNO055 core driver
      iio: document bno055 private sysfs attributes
      iio: document "serialnumber" sysfs attribute
      dt-bindings: iio/imu: Add Bosch BNO055
      iio: imu: add BNO055 serdev driver
      iio: imu: add BNO055 I2C driver
      docs: iio: add documentation for BNO055 driver

Andy Shevchenko (5):
      iio: pressure: dlhl60d: Don't take garbage into consideration when reading data
      lib/string_helpers: Add str_read_write() helper
      iio: magnetometer: yamaha-yas530: Use pointers as driver data
      iio: magnetometer: yamaha-yas530: Make strings const in chip info
      iio: magnetometer: yamaha-yas530: Use dev_err_probe()

Angel Iglesias (10):
      iio: pressure: bmp280: fix datasheet links
      iio: pressure: bmp280: reorder local variables following reverse xmas tree
      iio: pressure: bmp280: use FIELD_GET, FIELD_PREP and GENMASK
      iio: pressure: bmp280: Simplify bmp280 calibration data reading
      iio: pressure: bmp280: simplify driver initialization logic
      iio: pressure: bmp280: Fix alignment for DMA safety
      iio: pressure: bmp280: reorder i2c device tables declarations
      iio: pressure: bmp280: Add support for BMP380 sensor family
      dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
      iio: pressure: bmp280: Add more tunable config parameters for BMP380

Antoniu Miclaus (2):
      iio: frequency: admv1014: return -EINVAL directly
      MAINTAINERS: fix Analog Devices forum links

Ashay Jaiswal (1):
      spmi: pmic-arb: add support to dispatch interrupt based on IRQ status

Bharat Jauhari (1):
      habanalabs: fix spelling mistakes

Bo Liu (2):
      gnss: replace ida_simple API
      ipack: Check dev_set_name() return value

Breno Leitao (2):
      misc: bcm-vk: Specify the minimum number of IRQ vecs
      misc: bcm_vk: Remove usage of deprecated functions

Carlos Llamas (6):
      binder: fix trivial kernel-doc typo
      binder: remove unused binder_alloc->buffer_free
      binderfs: remove unused INTSTRLEN macro
      binder: rename alloc->vma_vm_mm to alloc->mm
      binder: remove binder_alloc_set_vma()
      binder: fix binder_alloc kernel-doc warnings

ChiYuan Huang (3):
      dt-bindings: iio: adc: Add rtq6056 adc support
      iio: adc: Add rtq6056 support
      Documentation: ABI: testing: rtq6056: Update ABI docs

Christophe JAILLET (3):
      coresight: docs: Fix a broken reference
      misc: microchip: pci1xxxx: Do not disable the pci device twice in gp_aux_bus_remove()
      misc: microchip: pci1xxxx: Fix a memory leak in the error handling of gp_aux_bus_probe()

Ciprian Regus (5):
      MAINTAINERS: Remove duplicate matching entry
      dt-bindings: iio: adc: Add docs for LTC2499
      Add MAINTAINERS entries for LTC2497 and LTC2496
      drivers: iio: adc: ltc2497: LTC2499 support
      drivers: iio: adc: ltc2497: Rename the LTC2499 iio device

Claudiu Beznea (19):
      iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
      iio: adc: at91-sama5d2_adc: check return status for pressure and touch
      iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
      iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
      iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are enabled
      iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw versions
      iio: adc: at91-sama5d2_adc: move the check of oversampling in its function
      iio: adc: at91-sama5d2_adc: drop AT91_OSR_XSAMPLES defines
      iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
      iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
      iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
      iio: adc: at91-sama5d2_adc: move oversampling storage in its function
      iio: adc: at91-sama5d2_adc: update trackx on emr
      iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for at91_adc_setup_samp_freq()
      iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
      dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature channel
      iio: adc: at91-sama5d2_adc: add support for temperature sensor
      iio: adc: at91-sama5d2_adc: add empty line after functions
      iio: adc: at91-sama5d2_adc: add runtime pm support

Colin Ian King (1):
      habanalabs: Fix spelling mistake "Scrubing" -> "Scrubbing"

Conor Dooley (1):
      fpga: microchip-spi: add missing module author entry

Crt Mori (3):
      iio: temperature: mlx90632 Add supply regulator to sensor
      dt-bindings: iio: mlx90632 Add supply regulator documentation
      iio: temperature: mlx90614 Refactoring available filter attributes

Dafna Hirschfeld (3):
      habanalabs: fix bug when setting va block size
      habanalabs: if map page fails don't try to unmap it
      habanalabs: set command buffer host VA dynamically

Dan Carpenter (2):
      get_maintainer: Add Alan to .get_maintainer.ignore
      fpga: prevent integer overflow in dfl_feature_ioctl_set_irq()

Dani Liberman (6):
      habanalabs: removed seq_file parameter from is_idle asic functions
      habanalabs: add uapi to retrieve engines status
      habanalabs: unify hwmon resources clean up
      habanalabs: rename error info structure
      habanalabs/gaudi2: add handling to pmmu events in eqe handler
      habanalabs/gaudi2: add secured attestation info uapi

David Collins (4):
      spmi: pmic-arb: check apid against limits before calling irq handler
      spmi: pmic-arb: correct duplicate APID to PPID mapping logic
      spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
      spmi: pmic-arb: increase SPMI transaction timeout delay

Dmitry Rokosov (6):
      units: complement the set of Hz units
      iio: accel: adxl345: use HZ macro from units.h
      iio: common: scmi_sensors: use HZ macro from units.h
      dt-bindings: vendor-prefixes: add MEMSensing Microsystems Co., Ltd.
      iio: add MEMSensing MSA311 3-axis accelerometer driver
      dt-bindings: iio: accel: add dt-binding schema for msa311 accel driver

Eddie James (8):
      iio: pressure: dps310: Refactor startup procedure
      iio: pressure: dps310: Reset chip after timeout
      fsi: occ: Fix checksum failure mode
      hwmon (occ): Retry for checksum failure
      fsi: occ: Prevent use after free
      dt-bindings: hwmon: Add IBM OCC bindings
      fsi: occ: Support probing the hwmon child device from dts node
      hwmon: (occ) Check for device property for setting OCC active during probe

Fabio M. De Francesco (3):
      misc/vmw_vmci: Use kmap_local_page() in vmci_queue_pair.c
      misc/xilinx_sdfec: Call kunmap() on pages mapped with kmap()
      misc/xilinx_sdfec: Replace kmap() with kmap_local_page()

Fenglin Wu (1):
      spmi: pmic-arb: handle spurious interrupt

Francesco Dolcini (1):
      dt-bindings: iio: adc: stmpe: Remove node name requirement

Gaosheng Cui (3):
      nvmem: core: Fix memleak in nvmem_register()
      nvmem: core: add error handling for dev_set_name
      drivers/misc/sgi-xp: Remove orphan declarations from drivers/misc/sgi-xp/xp.h

George Mois (2):
      dt-bindings: iio: accel: adxl313: Add compatibles for adxl312 and adxl314
      drivers: iio: accel: adxl312 and adxl314 support

Georgi Djakov (1):
      Merge branch 'icc-ignore-return-val' into icc-next

German Gomez (2):
      coresight: etm4x: Expose default timestamp source in sysfs
      coresight: etm4x: docs: Add documentation for 'ts_source' sysfs interface

Greg Kroah-Hartman (11):
      Merge 6.0-rc4 into char-misc-next
      Merge tag 'fpga-for-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'mhi-for-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'iio-for-6.1a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'coresight-next-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'misc-habanalabs-next-2022-09-21' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'gnss-6.1-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss into char-misc-next
      Merge tag 'iio-for-6.1b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'extcon-next-for-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'icc-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'fsi-for-v6.1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi into char-misc-next

Guilherme G. Piccoli (1):
      firmware: google: Test spinlock on panic path to avoid lockups

Hangyu Hua (1):
      misc: ocxl: fix possible refcount leak in afu_ioctl()

Horatiu Vultur (2):
      dt-bindings: lan9662-otpc: document Lan9662 OTPC
      nvmem: lan9662-otp: add support

Huang Yiwei (1):
      interconnect: qcom: Kconfig: Make INTERCONNECT_QCOM tristate

Iskren Chernev (1):
      dt-bindings: nvmem: Add SoC compatible for sm6115

Jagath Jog J (2):
      iio: Add new event type gesture and use direction for single and double tap
      iio: accel: bma400: Add support for single and double tap events

Jakob Hauser (14):
      iio: magnetometer: yas530: Change data type of hard_offsets to signed
      iio: magnetometer: yas530: Change range of data in volatile register
      iio: magnetometer: yas530: Correct scaling of magnetic axes
      iio: magnetometer: yas530: Correct temperature handling
      iio: magnetometer: yas530: Change data type of calibration coefficients
      iio: magnetometer: yas530: Rename functions and registers
      iio: magnetometer: yas530: Move printk %*ph parameters out from stack
      iio: magnetometer: yas530: Apply documentation and style fixes
      iio: magnetometer: yas530: Introduce "chip_info" structure
      iio: magnetometer: yas530: Add volatile registers to "chip_info"
      iio: magnetometer: yas530: Add IIO scaling to "chip_info"
      iio: magnetometer: yas530: Add temperature calculation to "chip_info"
      iio: magnetometer: yas530: Add function pointers to "chip_info"
      iio: magnetometer: yas530: Add YAS537 variant

James Clark (5):
      coresight: Remove unused function parameter
      coresight: Simplify sysfs accessors by using csdev_access abstraction
      coresight: Re-use same function for similar sysfs register accessors
      coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors
      coresight: Make new csdev_access offsets unsigned

Jiasheng Jiang (3):
      virt: vbox: convert to use dev_groups
      virt: vbox: Remove unproper information
      fsi: core: Check error number after calling ida_simple_get

Jilin Yuan (1):
      mei: fix repeated words in comments

Joe Simmons-Talbott (4):
      iio: Add blank lines after declarations.
      iio: Fix indentation for multiline conditional.
      iio: Add names for function definition arguments.
      iio: Avoid multiple line dereference for mask

Joel Stanley (1):
      fsi: sbefifo: Add detailed debugging information

Johnson Wang (1):
      dt-bindings: nvmem: mediatek: efuse: Add support for MT8188

Jonathan Cameron (33):
      iio: ABI: Fix wrong format of differential capacitance channel ABI.
      staging: iio: cdc: ad7746: Use explicit be24 handling.
      staging: iio: cdc: ad7746: Push handling of supply voltage scale to userspace.
      staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
      staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
      staging: iio: cdc: ad7764: Push locking down into case statements in read/write_raw
      staging: iio: cdc: ad7746: Break up use of chan->address and use FIELD_PREP etc
      staging: iio: cdc: ad7746: Drop unused i2c_set_clientdata()
      staging: iio: cdc: ad7746: Use _raw and _scale for temperature channels.
      iio: core: Introduce _zeropoint for differential channels
      staging: iio: cdc: ad7746: Switch from _offset to _zeropoint for differential channels.
      staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
      staging: iio: ad7746: White space cleanup
      iio: cdc: ad7746: Add device specific ABI documentation.
      iio: cdc: ad7746: Move driver out of staging.
      iio: test: Mark file local structure arrays static.
      iio: light: cm32181: Mark the dev_pm_ops static.
      staging: iio: frequency: ad9834: Fix alignment for DMA safety
      staging: iio: meter: ade7854: Fix alignment for DMA safety
      staging: iio: resolver: ad2s1210: Fix alignment for DMA safety
      iio: adc: mt6360: Drop an incorrect __maybe_unused marking.
      iio: magn: hmc5843: Drop excessive indentation of assignments of hmc5843_driver
      iio: magn: hmc5843: Move struct dev_pm_ops out of header
      staging: iio: frequency: ad9832: Fix alignment for DMA safety
      iio: adc: max1363: Drop provision to provide an IIO channel map via platform data
      iio: pressure: icp10100: Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS().
      iio: proximity: sx9310: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: proximity: sx9324: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: proximity: sx9360: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: proximity: srf04: Use pm_ptr() to remove unused struct dev_pm_ops
      iio: accel: bmi088: Use EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and pm_ptr()
      iio: light: st_uvis25: Use EXPORT_NS_SIMPLE_DEV_PM_OPS()
      iio: accel: bma400: Fix smatch warning based on use of unintialized value.

Julien Panis (4):
      dt-bindings: counter: add ti,am62-ecap-capture.yaml
      Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows items
      counter: ti-ecap-capture: capture driver support for ECAP
      MAINTAINERS: add TI ECAP driver info

Kees Cook (1):
      w1: Split memcpy() of struct cn_msg flexible array

Kenneth Lee (1):
      nvmem: brcm_nvram: Use kzalloc for allocating only one element

Koen Vandeputte (1):
      bus: mhi: host: always print detected modem name

Krzysztof Kozlowski (20):
      dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use spi-peripheral-props.yaml
      dt-bindings: iio: adc: ti,am3359-adc: add ti,am654-adc
      dt-bindings: iio: Drop Tomislav Denis
      iio: MAINTAINERS: Drop Tomislav Denis
      dt-bindings: iio: adc: Drop Patrick Vasseur
      dt-bindings: iio: adc: use spi-peripheral-props.yaml
      dt-bindings: iio: accel: use spi-peripheral-props.yaml
      dt-bindings: iio: amplifiers: adi,ada4250: use spi-peripheral-props.yaml
      dt-bindings: iio: dac: use spi-peripheral-props.yaml
      dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
      dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
      dt-bindings: iio: imu: use spi-peripheral-props.yaml
      dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
      dt-bindings: iio: samsung,sensorhub-rinato: use spi-peripheral-props.yaml
      dt-bindings: iio: temperature: use spi-peripheral-props.yaml
      slimbus: qcom-ngd: use correct error in message of pdr_add_lookup() failure
      slimbus: qcom-ngd: cleanup in probe error path
      slimbus: qcom-ngd: simplify error paths with dev_err_probe
      slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON
      dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles

Kumaravel Thiagarajan (7):
      misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
      misc: microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary device enumerated by the auxiliary bus driver.
      misc: microchip: pci1xxxx: Add functions to configure gpio pins as input / output, get status, handle I/O for gpio pins.
      misc: microchip: pci1xxxx: Add gpio irq handler and irq helper functions irq_ack, irq_mask, irq_unmask and irq_set_type of irq_chip.
      misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.
      misc: microchip: pci1xxxx: fix dependency issues in building the pci1xxxx's aux bus driver.
      misc: microchip: pci1xxxx: use DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's gpio driver

Li zeming (1):
      habanalabs/gaudi2: Remove unnecessary (void*) conversions

Lin Yujun (1):
      slimbus: qcom-ngd: Add error handling in of_qcom_slim_ngd_register

Liu Shixin (1):
      bus: mvebu-mbus: use DEFINE_SHOW_ATTRIBUTE to simplify mvebu_{sdram/devs}_debug

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add support to LSM6DSTX
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dstx device bindings

Lukas Bulwahn (1):
      MAINTAINERS: add spdxexclude to LICENSES and SPDX stuff

Luo Xueqin (1):
      fsi: Fix typo in comment

Lv Ruyi (1):
      fsi: master-ast-cf: Fix missing of_node_put in fsi_master_acf_probe

Marcus Folkesson (6):
      MAINTAINERS: Update Microchip MCP3911 to Maintained
      iio: adc: mcp3911: use resource-managed version of iio_device_register
      iio: adc: mcp3911: add support for buffers
      iio: adc: mcp3911: add support for interrupts
      dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
      iio: adc: mcp3911: add support for oversampling ratio

Marek Vasut (2):
      extcon: usbc-tusb320: Factor out extcon into dedicated functions
      extcon: usbc-tusb320: Add USB TYPE-C support

Marijn Suijten (1):
      iio: adc: qcom-spmi-adc5: Add missing VCOIN/GPIO[134] channels

Martin Larsson (1):
      iio: adc: imx8qxp-adc: propagate regulator_get_voltage error

Martyn Welch (2):
      dt-bindings: iio: st,st-sensors add LPS22DF.
      iio: pressure: st_pressure: Add support for LPS22DF

Matthew Gerlach (1):
      fpga: dfl-pci: Add IDs for Intel N6000, N6001 and C6100 cards

Michael Hennerich (1):
      iio: dac: ad5593r: Fix i2c read protocol requirements

Nathan Chancellor (1):
      coresight: cti-sysfs: Mark coresight_cti_reg_store() as __maybe_unused

Nuno Sá (19):
      iio: inkern: only release the device node when done with it
      iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
      iio: inkern: only return error codes in iio_channel_get_*() APIs
      iio: inkern: split of_iio_channel_get_by_name()
      iio: inkern: move to fwnode properties
      thermal: qcom: qcom-spmi-adc-tm5: convert to IIO fwnode API
      iio: adc: ingenic-adc: convert to IIO fwnode interface
      iio: adc: ab8500-gpadc: convert to device properties
      iio: adc: at91-sama5d2_adc: convert to device properties
      iio: adc: qcom-pm8xxx-xoadc: convert to device properties
      iio: adc: qcom-spmi-vadc: convert to device properties
      iio: adc: qcom-spmi-adc5: convert to device properties
      iio: adc: stm32-adc: convert to device properties
      iio: inkern: remove OF dependencies
      iio: inkern: fix coding style warnings
      iio: dac: ad5593r: add check for i2c functionality
      iio: adc: ad7923: fix channel readings for some variants
      iio: adc: ad7923: support extended range
      dt-bindings: iio: adi,ad7923: add adi,range-double property

Oded Gabbay (11):
      habanalabs/gaudi: increase default cs timeout to 10 minutes
      habanalabs: remove all kdma locks
      habanalabs/uapi: move defines to better place inside file
      habanalabs: move common function out of debugfs.c
      habanalabs: remove left-over code from bring-up
      habanalabs: fix missing info in sysfs documentation
      habanalabs: select FW_LOADER in Kconfig
      habanalabs/gaudi2: free event irq if init fails
      habanalabs: MMU invalidation h/w is per device
      habanalabs: failure to open device due to reset is debug level
      habanalabs: eliminate aggregate use warning

Ofir Bitton (12):
      habanalabs: rename non_hard_reset to compute_reset
      habanalabs/gaudi2: remove old interrupt mappings
      habanalabs: remove secured PCI IDs
      habanalabs: expose device security status through sysfs
      habanalabs: expose device security status using info ioctl
      habanalabs: perform context switch flow only if needed
      habanalabs: ignore EEPROM errors during boot
      habanalabs/gaudi2: dump detailed information upon RAZWI
      habanalabs: send device activity in a proper context
      habanalabs/gaudi: rename mme cfg error response print
      habanalabs: add support for new cpucp return codes
      habanalabs/gaudi2: allow user to flush PCIE by read

Ohad Sharabi (9):
      habanalabs: add return code field to module iterator
      habanalabs: wrap macro arg with parentheses
      habanalabs/gaudi: fix print format for div_sel
      habanalabs/gaudi: read div_sel value from firmware
      habanalabs: define trace events
      habanalabs: trace MMU map/unmap page
      habanalabs: trace DMA allocations
      habanalabs: fix resetting the DRAM BAR
      habanalabs: build ASICs from new to old

Oleksij Rempel (3):
      dt-bindings: iio: adc: ti,tsc2046: add vref-supply property
      iio: adc: tsc2046: add vref support
      iio: adc: tsc2046: silent spi_device_id warning

Olivier Moysan (1):
      iio: adc: stm32-adc: add id registers support

Omer Shpigelman (1):
      habanalabs: add cdev index data member

Peter Colberg (1):
      uio: dfl: add IOPLL user-clock feature id

Rafał Miłecki (6):
      nvmem: add driver handling U-Boot environment variables
      mtd: allow getting MTD device associated with a specific DT node
      nvmem: prefix all symbols with NVMEM_
      nvmem: sort config symbols alphabetically
      nvmem: u-boot-env: find Device Tree nodes for NVMEM cells
      nvmem: u-boot-env: fix crc32 casting type

Rajarama Manjukody Bhat (1):
      habanalabs/gaudi2: assigning PQFs for ARC f/w in PDMA

Ramona Bolboaca (2):
      dt-bindings: iio: adc: Add max11205 documentation file
      iio: adc: add max11205 adc driver

Randy Dunlap (1):
      coresight: trbe: fix Kconfig "its" grammar

Rob Herring (3):
      dt-bindings: arm: coresight: Add 'power-domains' property
      dt-bindings: arm: coresight-tmc: Add 'iommu' property
      dt-bindings: iio: Add missing (unevaluated|additional)Properties on child nodes

Robert Marko (1):
      iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to rev2 ADC5

Rong Chen (1):
      extcon: usbc-tusb320: fix kernel-doc warning

Russ Weight (1):
      fpga: m10bmc-sec: d5005 bmc secure update driver

Samuel Thibault (3):
      speakup-dummy: Add support for PUNCT variable
      speakup: Notify synthesizers of the punctuation level change
      speakup_soft: Add direct module parameter

Shang XiaoJing (1):
      mei: gsc: Remove redundant dev_err call

Shreeya Patel (3):
      dt-bindings: Document ltrf216a light sensor bindings
      iio: light: Add support for ltrf216a sensor
      iio: light: ltrf216a: Add raw attribute

Shunsuke Mie (2):
      misc: pci_endpoint_test: Aggregate params checking for xfer
      misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}() panic

Stephen Rothwell (1):
      hwtracing: hisi_ptt: Fix up for "iommu/dma: Make header private"

Subbaraman Narayanamurthy (1):
      spmi: pmic-arb: do not ack and clear peripheral interrupts in cleanup_irq

Tal Cohen (4):
      habanalabs: fix command submission sanity check
      habanalabs/gaudi2: new API to control engine cores running mode
      habanalabs: new notifier events for device state
      habanalabs/gaudi: change TPC Assert to use TPC DEC instead of QMAN err

Tom Rix (1):
      fsi: cleanup extern usage in function definition

Tomer Tayar (11):
      habanalabs/gaudi2: enable all MMU SPI/SEI interrupts
      habanalabs/gaudi2: mark PCIE access error as fatal
      habanalabs: avoid returning a valid handle if map_block() fails
      habanalabs: fix vma fields assignments order in hl_hw_block_mmap()
      habanalabs: add a missing lock for in_reset indication
      habanalabs: fix H/W block handling for partial unmappings
      habanalabs: fix calculation of DRAM base address in PCIe BAR
      habanalabs/gaudi2: read F/W security indication after hard reset
      habanalabs/gaudi2: print RAZWI info upon PCIe access error
      habanalabs/gaudi2: increase hard-reset sleep time to 2 sec
      habanalabs/gaudi: use 8KB aligned address for TPC kernels

Uwe Kleine-König (20):
      iio: adc: ad7124: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ad7768-1: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ad9467: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ingenic-adc: Benefit from devm_clk_get_prepared() to simplify
      iio: adc: lpc18xx: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ti-ads131e08: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: xilinx-ams: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: xilinx-xadc: Benefit from devm_clk_get_enabled() to simplify
      iio: frequency: adf4371: Benefit from devm_clk_get_enabled() to simplify
      iio: frequency: adrf6780: Benefit from devm_clk_get_enabled() to simplify
      iio: imu: adis16475: Benefit from devm_clk_get_enabled() to simplify
      interconnect: imx: Ignore return value of icc_provider_del() in .remove()
      interconnect: icc-rpm: Ignore return value of icc_provider_del() in .remove()
      interconnect: icc-rpmh: Ignore return value of icc_provider_del() in .remove()
      interconnect: msm8974: Ignore return value of icc_provider_del() in .remove()
      interconnect: osm-l3: Ignore return value of icc_provider_del() in .remove()
      interconnect: sm8450: Ignore return value of icc_provider_del() in .remove()
      interconnect: Make icc_provider_del() return void
      interconnect: imx: Make imx_icc_unregister() return void
      iio: ltc2497: Fix reading conversion results

Vincent Whitchurch (1):
      iio: Use per-device lockdep class for mlock

Vishnu Dasa (5):
      VMCI: Update maintainers for VMCI
      MAINTAINERS: Change VMware PVSCSI driver entry to upper case
      MAINTAINERS: Change status of some VMware drivers
      MAINTAINERS: Add a new entry for VMWARE VSOCK VMCI TRANSPORT DRIVER
      MAINTAINERS: Add header files under VMWARE VMCI DRIVER

Wei Yongjun (5):
      misc: microchip: pci1xxxx: fix error handling in gp_aux_bus_probe()
      misc: microchip: pci1xxxx: Fix missing spin_lock_init()
      misc: microchip: pci1xxxx: Make symbol 'pci1xxxx_gpio_auxiliary_id_table' static
      misc: microchip: pci1xxxx: Add missing MODULE_DEVICE_TABLE
      misc: microchip: pci1xxxx: use module_auxiliary_driver

William Breathitt Gray (10):
      iio: stx104: Move to addac subdirectory
      counter: Realign counter_comp comment block to 80 characters
      MAINTAINERS: Update Counter subsystem git tree repo link
      counter: Move symbols into COUNTER namespace
      counter: interrupt-cnt: Implement watch_validate callback
      counter: Introduce the Signal polarity component
      counter: 104-quad-8: Add Signal polarity component
      counter: Introduce the Count capture component
      counter: Consolidate Counter extension sysfs attribute creation
      counter: Introduce the COUNTER_COMP_ARRAY component type

Wolfram Sang (4):
      iio: st_sensors: move from strlcpy with unused retval to strscpy
      iio: imu: inv_mpu6050: move from strlcpy with unused retval to strscpy
      misc: move from strlcpy with unused retval to strscpy
      virt: move from strlcpy with unused retval to strscpy

Xuezhi Zhang (1):
      comedi: convert sysfs snprintf to sysfs_emit

Yang Li (1):
      habanalabs: Simplify bool conversion

Yicong Yang (5):
      iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to identity
      hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device
      hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace device
      docs: trace: Add HiSilicon PTT device driver documentation
      MAINTAINERS: Add maintainer for HiSilicon PTT driver

Yihao Han (1):
      misc: microchip: pci1xxxx: Remove duplicate include

farah kassabri (6):
      habanalabs/gaudi2: change device f/w security check
      habanalabs/gaudi2: log critical events with no rate limit
      habanalabs: send device active message to f/w
      habanalabs: fix possible hole in device va
      habanalabs/gaudi2: get f/w reset status register dynamically
      habanalabs: remove some f/w descriptor validations

keliu (1):
      drivers: spmi: Directly use ida_alloc()/free()

wangjianli (1):
      iio/accel: fix repeated words in comments

 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |    8 +
 Documentation/ABI/testing/sysfs-bus-counter        |   35 +
 Documentation/ABI/testing/sysfs-bus-iio            |  126 +-
 Documentation/ABI/testing/sysfs-bus-iio-bno055     |   81 +
 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746 |   11 +
 Documentation/ABI/testing/sysfs-devices-hisi_ptt   |   61 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |   12 +-
 .../bindings/arm/arm,coresight-catu.yaml           |    3 +
 .../devicetree/bindings/arm/arm,coresight-cti.yaml |    3 +
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml |    3 +
 .../arm/arm,coresight-dynamic-replicator.yaml      |    3 +
 .../bindings/arm/arm,coresight-etb10.yaml          |    3 +
 .../devicetree/bindings/arm/arm,coresight-etm.yaml |    3 +
 .../bindings/arm/arm,coresight-static-funnel.yaml  |    3 +
 .../arm/arm,coresight-static-replicator.yaml       |    3 +
 .../devicetree/bindings/arm/arm,coresight-stm.yaml |    3 +
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml |    6 +
 .../bindings/arm/arm,coresight-tpiu.yaml           |    3 +
 .../bindings/arm/arm,embedded-trace-extension.yaml |    3 +
 .../bindings/counter/ti,am62-ecap-capture.yaml     |   61 +
 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml  |    7 +-
 .../devicetree/bindings/hwmon/ibm,occ-hwmon.yaml   |   39 +
 .../bindings/iio/accel/adi,adis16201.yaml          |    7 +-
 .../bindings/iio/accel/adi,adis16240.yaml          |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |   17 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |    7 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |    7 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |    5 +-
 .../bindings/iio/accel/bosch,bmi088.yaml           |    7 +-
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |    7 +-
 .../bindings/iio/accel/kionix,kxsd9.yaml           |    7 +-
 .../bindings/iio/accel/memsensing,msa311.yaml      |   53 +
 .../bindings/iio/accel/murata,sca3300.yaml         |    5 +-
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7280a.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7298.yaml    |    6 +-
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |   12 +-
 .../devicetree/bindings/iio/adc/adi,ad7949.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/holt,hi8435.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/maxim,max1027.yaml |    5 +-
 .../bindings/iio/adc/maxim,max11100.yaml           |    7 +-
 .../devicetree/bindings/iio/adc/maxim,max1118.yaml |   26 +-
 .../bindings/iio/adc/maxim,max11205.yaml           |   69 +
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    7 +-
 .../bindings/iio/adc/microchip,mcp3201.yaml        |    6 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |   12 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 +
 .../bindings/iio/adc/richtek,rtq6056.yaml          |   56 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |    2 +
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml  |    3 +-
 .../devicetree/bindings/iio/adc/ti,adc0832.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc084s021.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc108s102.yaml |    6 +-
 .../devicetree/bindings/iio/adc/ti,adc12138.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc161s626.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    1 +
 .../devicetree/bindings/iio/adc/ti,ads124s08.yaml  |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  |    9 +-
 .../devicetree/bindings/iio/adc/ti,ads8344.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads8688.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,am3359-adc.yaml |   11 +-
 .../devicetree/bindings/iio/adc/ti,tlc4541.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |    8 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    1 +
 .../bindings/iio/addac/adi,ad74413r.yaml           |    1 +
 .../bindings/iio/amplifiers/adi,ada4250.yaml       |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |    1 +
 .../devicetree/bindings/iio/dac/adi,ad5064.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5421.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5449.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5624r.yaml   |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |    4 +-
 .../devicetree/bindings/iio/dac/adi,ad5761.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5764.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |   11 +-
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad8801.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |    1 +
 .../bindings/iio/dac/microchip,mcp4922.yaml        |    9 +-
 .../devicetree/bindings/iio/dac/ti,dac082s085.yaml |    9 +-
 .../devicetree/bindings/iio/dac/ti,dac7311.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/ti,dac7612.yaml    |    7 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    7 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |    9 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    7 +-
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    9 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |    7 +-
 .../devicetree/bindings/iio/imu/bosch,bno055.yaml  |   59 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |    6 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    5 +-
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |    7 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   12 +-
 .../bindings/iio/light/liteon,ltrf216a.yaml        |   49 +
 .../iio/potentiometer/microchip,mcp41010.yaml      |    9 +-
 .../iio/potentiometer/microchip,mcp4131.yaml       |    9 +-
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |    2 +-
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    4 +-
 .../bindings/iio/samsung,sensorhub-rinato.yaml     |    9 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    2 +
 .../bindings/iio/temperature/maxim,max31855k.yaml  |    4 +-
 .../bindings/iio/temperature/maxim,max31856.yaml   |    6 +-
 .../bindings/iio/temperature/maxim,max31865.yaml   |    6 +-
 .../bindings/iio/temperature/melexis,mlx90632.yaml |    4 +
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    1 +
 .../bindings/nvmem/microchip,lan9662-otpc.yaml     |   45 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    3 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/bno055.rst                       |   51 +
 Documentation/iio/index.rst                        |    2 +
 .../trace/coresight/coresight-cpu-debug.rst        |    3 +-
 .../trace/coresight/coresight-etm4x-reference.rst  |   14 +
 Documentation/trace/hisi-ptt.rst                   |  298 ++++
 Documentation/trace/index.rst                      |    1 +
 MAINTAINERS                                        |   97 +-
 arch/arm/configs/multi_v7_defconfig                |    6 +-
 arch/arm/configs/qcom_defconfig                    |    2 +-
 arch/arm64/configs/defconfig                       |   10 +-
 arch/arm64/include/asm/sysreg.h                    |    1 +
 arch/mips/configs/ci20_defconfig                   |    2 +-
 drivers/Makefile                                   |    1 +
 drivers/accessibility/speakup/speakup_dummy.c      |    4 +
 drivers/accessibility/speakup/speakup_soft.c       |   32 +-
 drivers/accessibility/speakup/spk_types.h          |    2 +-
 drivers/accessibility/speakup/varhandlers.c        |   12 +-
 drivers/android/binder_alloc.c                     |   55 +-
 drivers/android/binder_alloc.h                     |   12 +-
 drivers/android/binderfs.c                         |   31 +-
 drivers/bus/mhi/host/pci_generic.c                 |    2 +-
 drivers/bus/mvebu-mbus.c                           |   26 +-
 drivers/comedi/comedi_fops.c                       |    8 +-
 drivers/counter/104-quad-8.c                       |   36 +
 drivers/counter/Kconfig                            |   15 +
 drivers/counter/Makefile                           |    1 +
 drivers/counter/counter-chrdev.c                   |  137 +-
 drivers/counter/counter-core.c                     |   14 +-
 drivers/counter/counter-sysfs.c                    |  304 +++-
 drivers/counter/ftm-quaddec.c                      |    1 +
 drivers/counter/intel-qep.c                        |    1 +
 drivers/counter/interrupt-cnt.c                    |   12 +
 drivers/counter/microchip-tcb-capture.c            |    1 +
 drivers/counter/stm32-lptimer-cnt.c                |    1 +
 drivers/counter/stm32-timer-cnt.c                  |    1 +
 drivers/counter/ti-ecap-capture.c                  |  614 +++++++
 drivers/counter/ti-eqep.c                          |    1 +
 drivers/cpufreq/Kconfig.arm                        |    2 +-
 drivers/extcon/Kconfig                             |    2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |  232 ++-
 drivers/firmware/google/gsmi.c                     |    9 +
 drivers/fpga/dfl-pci.c                             |   18 +
 drivers/fpga/dfl.c                                 |    2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |    3 +
 drivers/fpga/microchip-spi.c                       |    1 +
 drivers/fsi/fsi-core.c                             |   11 +-
 drivers/fsi/fsi-master-ast-cf.c                    |    2 +
 drivers/fsi/fsi-master.h                           |    2 +-
 drivers/fsi/fsi-occ.c                              |   66 +-
 drivers/fsi/fsi-sbefifo.c                          |   15 +-
 drivers/gnss/core.c                                |    4 +-
 drivers/hwmon/occ/common.c                         |   11 +-
 drivers/hwmon/occ/p9_sbe.c                         |   26 +-
 drivers/hwtracing/Kconfig                          |    2 +
 drivers/hwtracing/coresight/Kconfig                |    4 +-
 drivers/hwtracing/coresight/coresight-catu.c       |   27 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    8 +-
 drivers/hwtracing/coresight/coresight-core.c       |   28 +
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |  213 +--
 drivers/hwtracing/coresight/coresight-etb10.c      |   28 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   34 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   29 +
 drivers/hwtracing/coresight/coresight-priv.h       |   74 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   10 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   40 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   48 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    4 +-
 drivers/hwtracing/ptt/Kconfig                      |   12 +
 drivers/hwtracing/ptt/Makefile                     |    2 +
 drivers/hwtracing/ptt/hisi_ptt.c                   | 1046 ++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h                   |  200 +++
 drivers/iio/accel/Kconfig                          |   13 +
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/adxl313.h                        |   35 +-
 drivers/iio/accel/adxl313_core.c                   |  202 ++-
 drivers/iio/accel/adxl313_i2c.c                    |   74 +-
 drivers/iio/accel/adxl313_spi.c                    |   63 +-
 drivers/iio/accel/adxl345_core.c                   |    7 +-
 drivers/iio/accel/bma400.h                         |   14 +
 drivers/iio/accel/bma400_core.c                    |  346 +++-
 drivers/iio/accel/bmi088-accel-core.c              |   15 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    2 +-
 drivers/iio/accel/msa311.c                         | 1321 +++++++++++++++
 drivers/iio/adc/Kconfig                            |   47 +-
 drivers/iio/adc/Makefile                           |    3 +-
 drivers/iio/adc/ab8500-gpadc.c                     |   27 +-
 drivers/iio/adc/ad7124.c                           |   15 +-
 drivers/iio/adc/ad7768-1.c                         |   17 +-
 drivers/iio/adc/ad7923.c                           |   11 +-
 drivers/iio/adc/ad9467.c                           |   17 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  714 +++++++--
 drivers/iio/adc/imx8qxp-adc.c                      |    8 +-
 drivers/iio/adc/ingenic-adc.c                      |   23 +-
 drivers/iio/adc/lpc18xx_adc.c                      |   18 +-
 drivers/iio/adc/ltc2496.c                          |    9 +-
 drivers/iio/adc/ltc2497-core.c                     |   12 +-
 drivers/iio/adc/ltc2497.c                          |   77 +-
 drivers/iio/adc/ltc2497.h                          |    6 +
 drivers/iio/adc/max11205.c                         |  183 +++
 drivers/iio/adc/max1363.c                          |    6 -
 drivers/iio/adc/mcp3911.c                          |  257 ++-
 drivers/iio/adc/mt6360-adc.c                       |    2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   58 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   73 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |   44 +-
 drivers/iio/adc/rtq6056.c                          |  661 ++++++++
 drivers/iio/adc/stm32-adc-core.c                   |   59 +-
 drivers/iio/adc/stm32-adc-core.h                   |   31 +
 drivers/iio/adc/stm32-adc.c                        |  128 +-
 drivers/iio/adc/ti-ads131e08.c                     |   19 +-
 drivers/iio/adc/ti-tsc2046.c                       |   69 +-
 drivers/iio/adc/xilinx-ams.c                       |   15 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   18 +-
 drivers/iio/addac/Kconfig                          |   16 +
 drivers/iio/addac/Makefile                         |    1 +
 drivers/iio/{adc => addac}/stx104.c                |    0
 drivers/iio/cdc/Kconfig                            |   10 +
 drivers/iio/cdc/Makefile                           |    1 +
 drivers/{staging => }/iio/cdc/ad7746.c             |  441 ++---
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    8 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    2 +-
 drivers/iio/dac/ad5593r.c                          |   50 +-
 drivers/iio/frequency/adf4371.c                    |   17 +-
 drivers/iio/frequency/admv1014.c                   |    3 +-
 drivers/iio/frequency/adrf6780.c                   |   16 +-
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis16475.c                        |   15 +-
 drivers/iio/imu/bno055/Kconfig                     |   25 +
 drivers/iio/imu/bno055/Makefile                    |   10 +
 drivers/iio/imu/bno055/bno055.c                    | 1685 ++++++++++++++++++++
 drivers/iio/imu/bno055/bno055.h                    |   13 +
 drivers/iio/imu/bno055/bno055_i2c.c                |   57 +
 drivers/iio/imu/bno055/bno055_ser_core.c           |  560 +++++++
 drivers/iio/imu/bno055/bno055_ser_trace.c          |   14 +
 drivers/iio/imu/bno055/bno055_ser_trace.h          |  104 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    4 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/industrialio-buffer.c                  |    5 +-
 drivers/iio/industrialio-core.c                    |   29 +-
 drivers/iio/industrialio-event.c                   |   14 +-
 drivers/iio/industrialio-trigger.c                 |    1 +
 drivers/iio/inkern.c                               |  272 ++--
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/ltrf216a.c                       |  550 +++++++
 drivers/iio/light/st_uvis25_core.c                 |    9 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    2 +-
 drivers/iio/light/st_uvis25_spi.c                  |    2 +-
 drivers/iio/magnetometer/Kconfig                   |    4 +-
 drivers/iio/magnetometer/hmc5843.h                 |   13 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    8 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    2 +-
 drivers/iio/magnetometer/hmc5843_spi.c             |   14 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |  855 ++++++++--
 drivers/iio/pressure/Kconfig                       |    6 +-
 drivers/iio/pressure/bmp280-core.c                 |  974 +++++++++--
 drivers/iio/pressure/bmp280-i2c.c                  |   15 +-
 drivers/iio/pressure/bmp280-regmap.c               |   55 +
 drivers/iio/pressure/bmp280-spi.c                  |    5 +
 drivers/iio/pressure/bmp280.h                      |  164 +-
 drivers/iio/pressure/dlhl60d.c                     |    5 +-
 drivers/iio/pressure/dps310.c                      |  262 +--
 drivers/iio/pressure/icp10100.c                    |   10 +-
 drivers/iio/pressure/st_pressure.h                 |    2 +
 drivers/iio/pressure/st_pressure_core.c            |   70 +
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +
 drivers/iio/pressure/st_pressure_spi.c             |    5 +
 drivers/iio/proximity/srf04.c                      |   10 +-
 drivers/iio/proximity/sx9310.c                     |    8 +-
 drivers/iio/proximity/sx9324.c                     |    8 +-
 drivers/iio/proximity/sx9360.c                     |    8 +-
 drivers/iio/temperature/mlx90614.c                 |   41 +-
 drivers/iio/temperature/mlx90632.c                 |   61 +-
 drivers/iio/test/iio-test-rescale.c                |    4 +-
 drivers/interconnect/core.c                        |   10 +-
 drivers/interconnect/imx/imx.c                     |    4 +-
 drivers/interconnect/imx/imx.h                     |    2 +-
 drivers/interconnect/imx/imx8mm.c                  |    4 +-
 drivers/interconnect/imx/imx8mn.c                  |    4 +-
 drivers/interconnect/imx/imx8mp.c                  |    4 +-
 drivers/interconnect/imx/imx8mq.c                  |    4 +-
 drivers/interconnect/qcom/Kconfig                  |    2 +-
 drivers/interconnect/qcom/icc-common.c             |    3 +
 drivers/interconnect/qcom/icc-rpm.c                |    4 +-
 drivers/interconnect/qcom/icc-rpmh.c               |    4 +-
 drivers/interconnect/qcom/msm8974.c                |    4 +-
 drivers/interconnect/qcom/osm-l3.c                 |    4 +-
 drivers/interconnect/qcom/sm8450.c                 |    4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   21 +
 drivers/ipack/ipack.c                              |    5 +-
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    3 +-
 drivers/misc/altera-stapl/altera.c                 |    8 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c                   |    8 +-
 drivers/misc/eeprom/eeprom.c                       |    2 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |    2 +-
 drivers/misc/fastrpc.c                             |    2 +-
 drivers/misc/habanalabs/Kconfig                    |    1 +
 drivers/misc/habanalabs/Makefile                   |    8 +-
 drivers/misc/habanalabs/common/command_buffer.c    |  127 +-
 .../misc/habanalabs/common/command_submission.c    |   75 +-
 drivers/misc/habanalabs/common/debugfs.c           |   35 +-
 drivers/misc/habanalabs/common/device.c            |  147 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  184 ++-
 drivers/misc/habanalabs/common/habanalabs.h        |  171 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   44 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  123 +-
 drivers/misc/habanalabs/common/hw_queue.c          |    4 +-
 drivers/misc/habanalabs/common/hwmon.c             |   24 +-
 drivers/misc/habanalabs/common/memory.c            |   57 +-
 drivers/misc/habanalabs/common/memory_mgr.c        |   10 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   31 +-
 drivers/misc/habanalabs/common/sysfs.c             |   10 +
 drivers/misc/habanalabs/gaudi/gaudi.c              |  185 ++-
 drivers/misc/habanalabs/gaudi2/gaudi2.c            |  671 +++++---
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |   10 +-
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h      |   21 +-
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |   26 +-
 drivers/misc/habanalabs/goya/goya.c                |   62 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  103 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |   37 +-
 .../include/gaudi2/asic_reg/gaudi2_regs.h          |    2 +
 .../gaudi2/asic_reg/pcie_wrap_special_regs.h       |  185 +++
 .../include/gaudi2/gaudi2_async_virt_events.h      |   57 -
 drivers/misc/ics932s401.c                          |    2 +-
 drivers/misc/mchp_pci1xxxx/Kconfig                 |   13 +
 drivers/misc/mchp_pci1xxxx/Makefile                |    1 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c      |  165 ++
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h      |   28 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c    |  427 +++++
 drivers/misc/mei/bus-fixup.c                       |    2 +-
 drivers/misc/mei/gsc-me.c                          |    1 -
 drivers/misc/mei/hw-txe.c                          |    2 +-
 drivers/misc/ocxl/file.c                           |    2 +
 drivers/misc/pci_endpoint_test.c                   |   34 +-
 drivers/misc/sgi-xp/xp.h                           |    4 -
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   16 +-
 drivers/misc/xilinx_sdfec.c                        |    3 +-
 drivers/mtd/mtdcore.c                              |   28 +
 drivers/nvmem/Kconfig                              |  313 ++--
 drivers/nvmem/Makefile                             |  120 +-
 drivers/nvmem/brcm_nvram.c                         |    2 +-
 drivers/nvmem/core.c                               |   27 +-
 drivers/nvmem/lan9662-otpc.c                       |  222 +++
 drivers/nvmem/u-boot-env.c                         |  219 +++
 drivers/parport/parport_pc.c                       |    4 +
 drivers/slimbus/Kconfig                            |    3 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   31 +-
 drivers/soc/mediatek/Kconfig                       |    2 +-
 drivers/spmi/spmi-pmic-arb.c                       |   91 +-
 drivers/spmi/spmi.c                                |    4 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/cdc/Kconfig                    |   17 -
 drivers/staging/iio/cdc/Makefile                   |    6 -
 drivers/staging/iio/frequency/ad9832.c             |    4 +-
 drivers/staging/iio/frequency/ad9834.c             |    2 +-
 drivers/staging/iio/meter/ade7854.h                |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
 drivers/thermal/qcom/Kconfig                       |    2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |    3 +-
 drivers/uio/uio_dfl.c                              |    2 +
 drivers/virt/vboxguest/vboxguest_core.c            |    2 +-
 drivers/virt/vboxguest/vboxguest_linux.c           |   16 +-
 drivers/w1/w1_netlink.c                            |    3 +-
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |    3 +
 include/linux/coresight.h                          |   23 +
 include/linux/counter.h                            |  187 ++-
 include/linux/iio/consumer.h                       |   28 +-
 include/linux/iio/iio-opaque.h                     |    2 +
 include/linux/iio/iio.h                            |    8 +-
 include/linux/iio/types.h                          |    3 +
 include/linux/interconnect-provider.h              |    5 +-
 include/linux/mtd/mtd.h                            |    1 +
 include/linux/string_helpers.h                     |    5 +
 include/linux/units.h                              |    3 +
 include/trace/events/habanalabs.h                  |   93 ++
 include/uapi/linux/counter.h                       |    8 +
 include/uapi/linux/iio/types.h                     |   10 +-
 include/uapi/misc/habanalabs.h                     |  137 +-
 tools/iio/iio_event_monitor.c                      |   14 +-
 411 files changed, 18105 insertions(+), 3573 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
 create mode 100644 Documentation/ABI/testing/sysfs-devices-hisi_ptt
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/counter/ti-ecap-capture.c
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
 create mode 100644 drivers/iio/accel/msa311.c
 create mode 100644 drivers/iio/adc/max11205.c
 create mode 100644 drivers/iio/adc/rtq6056.c
 rename drivers/iio/{adc => addac}/stx104.c (100%)
 rename drivers/{staging => }/iio/cdc/ad7746.c (66%)
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h
 create mode 100644 drivers/iio/light/ltrf216a.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_special_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
 create mode 100644 drivers/misc/mchp_pci1xxxx/Kconfig
 create mode 100644 drivers/misc/mchp_pci1xxxx/Makefile
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
 create mode 100644 drivers/nvmem/lan9662-otpc.c
 create mode 100644 drivers/nvmem/u-boot-env.c
 delete mode 100644 drivers/staging/iio/cdc/Kconfig
 delete mode 100644 drivers/staging/iio/cdc/Makefile
 create mode 100644 include/trace/events/habanalabs.h
