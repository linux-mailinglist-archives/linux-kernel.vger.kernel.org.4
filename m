Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2E7459B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGCKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGCKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:08:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FFE5E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C804260EA2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF5C433C7;
        Mon,  3 Jul 2023 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688378930;
        bh=nXo59ZNFhsh1l0nHcNR9c8BfeIGCKkydhcMdwrmLNWY=;
        h=Date:From:To:Cc:Subject:From;
        b=UVEFw0kUZzy3A5B6JPHudMToS5JCprOVV/opN6KHnL2yUgzcZmqQw5ZRCyygKYzXc
         2IJm882+hSKhY1K1lhFIBmm8P35OI7SU16YaywxTAIav88QI8ttFvyWYpwbKlBTbxt
         582KW+i51GjwY8MIhnUeLTHr1fKwou6xvomcBNRo=
Date:   Mon, 3 Jul 2023 12:08:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver update for 6.5-rc1
Message-ID: <ZKKeL16WHd83RU1k@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc1

for you to fetch changes up to adfdaf81f9d48d8618a4d8296567248170fe7bcc:

  bsr: fix build problem with bsr_class static cleanup (2023-06-26 11:05:16 +0200)

----------------------------------------------------------------
Char/Misc and other driver subsystem updates for 6.5-rc1

Here is the big set of char/misc and other driver subsystem updates for
6.5-rc1.

Lots of different, tiny, stuff in here, from a range of smaller driver
subsystems, including pulls from some substems directly:
  - IIO driver updates and additions
  - W1 driver updates and fixes (and a new maintainer!)
  - FPGA driver updates and fixes
  - Counter driver updates
  - Extcon driver updates
  - Interconnect driver updates
  - Coresight driver updates
  - mfd tree tag merge needed for other updates
on top of that, lots of small driver updates as patches, including:
  - static const updates for class structures
  - nvmem driver updates
  - pcmcia driver fix
  - lots of other small driver updates and fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhijit Gangurde (1):
      cdx: Replace custom mcdi logging with print_hex_dump_debug()

Alexander Stein (1):
      nvmem: imx-ocotp: Reverse MAC addresses on all i.MX derivates

Alexander Usyskin (2):
      mei: bus: drop useless cldev null check
      mei: bus-fixup: fix buffer type

Alfonso Rodriguez (1):
      fpga: zynq-fpga: Ensure proper xCAP interface switch

Alvin Šipraga (3):
      extcon: usbc-tusb320: Unregister typec port on driver removal
      extcon: usbc-tusb320: add accessory detection support
      extcon: usbc-tusb320: add usb_role_switch support

Andreas Klinger (3):
      dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor
      iio: pressure: Honeywell mprls0025pa pressure sensor
      MAINTAINERS: Add Honeywell mprls0025pa sensor

Andy Shevchenko (13):
      extcon: axp288: Replace open coded acpi_dev_put()
      extcon: palmas: Remove unused of_gpio.h
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      extcon: Use DECLARE_BITMAP() to declare bit arrays
      extcon: Use sysfs_emit() to instead of sprintf()
      extcon: Amend kernel documentation of struct extcon_dev
      extcon: Use device_match_of_node() helper
      extcon: Use dev_of_node(dev) instead of dev->of_node
      extcon: Remove dup device name in the message and unneeded error check
      extcon: Use unique number for the extcon device ID
      extcon: Use sizeof(*pointer) instead of sizeof(type)
      extcon: Drop unneeded assignments

Anup Sharma (2):
      dt-bindings: iio: temperature: Add support for tmp006
      iio: temperature: tmp006: Add OF device matching support

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Arnd Bergmann (2):
      extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
      samples: pfsm: add CC_CAN_LINK dependency

Bo Svangård (1):
      misc/xilinx_sdfec: remove redundant _{open, release} function

Bryan O'Donoghue (2):
      dt-bindings: pm8941-misc: Fix usb_id and usb_vbus definitions
      extcon: qcom-spmi: Switch to platform_get_irq_byname_optional

Bumwoo Lee (4):
      extcon: Remove redundant null checking for class
      extcon: Add extcon_alloc_cables to simplify extcon register function
      extcon: Add extcon_alloc_muex to simplify extcon register function
      extcon: Add extcon_alloc_groups to simplify extcon register function

Christophe JAILLET (4):
      iio: accel: bma400: Simplify an error message
      iio: adc: palmas: Remove the unneeded include <linux/i2c.h>
      misc: smpro-errmon: Remove the unneeded include <linux/i2c.h>
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Chuang Zhang (2):
      Binder: Add timestamp to transaction record
      Binder: Add async from to transaction record

Claudiu Beznea (1):
      misc: fastrpc: check return value of devm_kasprintf()

Colin Ian King (2):
      w1: remove redundant initialization to variable result
      w1: ds2438: remove redundant initialization of variable crc

Cristian Ciocaltea (7):
      dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
      dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
      nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
      nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
      nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
      nvmem: rockchip-otp: Improve probe error handling
      nvmem: rockchip-otp: Add support for RK3588

Dan Carpenter (2):
      w1: fix loop in w1_fini()
      interconnect: qcom: rpm: allocate enough data in probe()

Dmitry Baryshkov (4):
      dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
      interconnect: add clk-based icc provider support
      clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
      interconnect: icc-clk: fix modular build

Ekansh Gupta (1):
      misc: fastrpc: Create fastrpc scalar with correct buffer count

Fabrizio Lamarque (3):
      iio: adc: ad7192: Fix null ad7192_state pointer access
      iio: adc: ad7192: Fix internal/external clock selection
      dt-bindings: iio: ad7192: Add mandatory reference voltage source

Frank Wunderlich (2):
      dt-bindings: iio: adc: Add support for MT7986
      dt-bindings: nvmem: mediatek: efuse: add support for mt7986

Franziska Naepelt (1):
      iio: amplifiers: ad8366 Fix whitespace issue

Geert Uytterhoeven (1):
      dt-bindings: iio: afe: voltage-divider: Spelling s/curcuit/circuit/

George Stark (1):
      meson saradc: fix clock divider mask length

Georgi Djakov (2):
      Merge branch 'icc-cbf' into icc-next
      Merge branch 'icc-qos' into icc-next

Greg Kroah-Hartman (12):
      Merge v6.4-rc4 into char-misc-next
      Merge tag 'w1-drv-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
      Merge 6.4-rc5 into char-misc-next
      Merge tag 'iio-fixes-for-6.4b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'iio-for-6.5a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'fpga-for-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'counter-updates-for-6.5a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'ib-mfd-tps6594-core-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into char-misc-next
      Merge tag 'extcon-next-for-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'icc-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'coresight-next-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      bsr: fix build problem with bsr_class static cleanup

Hao Zhang (3):
      Coresight: Add coresight dummy driver
      dt-bindings: arm: Add support for Coresight dummy trace
      Documentation: trace: Add documentation for Coresight Dummy Trace

Haowen Bai (1):
      w1: w1_therm: Use max() instead of doing it manually

Hermes Zhang (2):
      dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
      iio: imu: mpu6050: Add support for the ICM 20600 IMU

Herve Codina (3):
      dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
      iio: potentiometer: Add support for the Renesas X9250 potentiometers
      MAINTAINERS: add the Renesas X9250 driver entry

Ivan Orlov (11):
      oradax: make 'cl' a static const structure
      bsr: make bsr_class a static const structure
      dsp56k: make dsp56k_class a static const structure
      char: lp: make lp_class a static const structure
      /dev/mem: make mem_class a static const structure
      char: misc: make misc_class a static const structure
      ppdev: make ppdev_class a static const structure
      virtio_console: make port class a static const structure
      xilinx_hwicap: make icap_class a static const structure
      char: xillybus: make xillybus_class a static const structure
      comedi: make all 'class' structures const

Ivan T. Ivanov (1):
      dt-bindings: nvmem: rmem: Add raspberrypi,bootloader-public-key

Jakob Koschel (1):
      w1: Replace usage of found with dedicated list iterator variable

James Clark (14):
      devres: Provide krealloc_array
      coresight: Fix loss of connection info when a module is unloaded
      coresight: Use enum type for cs_mode wherever possible
      coresight: Change name of pdata->conns
      coresight: Rename nr_outports to nr_outconns
      coresight: Rename connection members to make the direction explicit
      coresight: Dynamically add connections
      coresight: Store pointers to connections rather than an array of them
      coresight: Simplify connection fixup mechanism
      coresight: Store in-connections as well as out-connections
      coresight: Make refcount a property of the connection
      coresight: Refactor out buffer allocation function for ETR
      coresight: Enable and disable helper devices adjacent to the path
      coresight: Fix CTI module refcount leak by making it a helper device

Jason Wang (1):
      w1: no need to initialise statics to 0

Jean Delvare (1):
      mux: mmio: drop obsolete dependency on COMPILE_TEST

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: avoid frequent timestamp jitter

Jialu Xu (1):
      scripts/tags.sh: improve compiled sources generation

Johan Hovold (1):
      interconnect: drop unused icc_get() interface

Julia Lawall (1):
      w1: w1_therm: fix typo in comment

Julien Panis (5):
      mfd: tps6594: Add driver for TI TPS6594 PMIC
      misc: tps6594-esm: Add driver for TI TPS6594 ESM
      misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
      Documentation: Add TI TPS6594 PFSM
      samples: Add userspace example for TI TPS6594 PFSM

Konrad Dybcio (8):
      interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
      interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
      interconnect: qcom: rpm: Drop unused parameters
      interconnect: qcom: rpm: Set QoS registers only once
      interconnect: qcom: rpm: Handle interface clocks
      interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
      interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
      interconnect: qcom: msm8996: Promote to core_initcall

Krzysztof Kozlowski (12):
      w1: Fix Kconfig indentation
      w1: therm: constify pointers to hwmon_channel_info
      dt-bindings: iio: st,lsm6dsx: reference common schema for mount-matrix
      fpga: dfl-fme: constify pointers to hwmon_channel_info
      dt-bindings: interconnect: fsl,imx8m-noc: drop unneeded quotes
      dt-bindings: extcon: wlf,arizona: drop unneeded quotes
      dt-bindings: nvmem: mxs-ocotp: drop unneeded address/size-cells
      dt-bindings: nvmem: qcom,qfprom: drop unneeded address/size-cells
      dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/size-cells
      dt-bindings: nvmem: socionext,uniphier-efuse: drop unneeded address/size-cells
      dt-bindings: nvmem: sunplus,sp7021-ocotp: drop unneeded address/size-cells
      dt-bindings: nvmem: imx-ocotp: drop unneeded address/size-cells and children

Laurentiu Tudor (1):
      bus: fsl-mc: don't assume child devices are all fsl-mc devices

Liang He (1):
      w1: Add missing of_node_put() in w1.c

Linus Walleij (2):
      dt-bindings: sram: Add compatible for ST-Ericsson U8500 eSRAM
      misc: sram: Generate unique names for subpools

Lizhe (1):
      w1: Remove driver match function

Luca Weiss (2):
      dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling
      dt-bindings: pm8941-misc: rename misc node name

Marek Vasut (6):
      dt-bindings: iio: temperature: melexis,mlx90614: Document MLX90615 support
      iio: mlx90614: Sort headers
      iio: mlx90614: Drop unused register macros
      iio: mlx90614: Drop MLX90614_CONST_EMISSIVITY_RESOLUTION
      iio: mlx90614: Factor our register IO and constants into model specific descriptor
      iio: mlx90614: Add MLX90615 support

Marijn Suijten (6):
      dt-bindings: iio: adc: Require generic `channel` name for channel nodes
      iio: core: Point users of extend_name field to read_label callback
      iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT label
      iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwnode name
      iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
      iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace

Marius Hoch (7):
      iio: accel: st_accel: Add LSM303D
      iio: magnetometer: st_accel: Add LSM303D
      iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
      iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU driver
      iio: Comment that the LSM303D also has the Magnetometer DRDY
      dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
      iio: light: al3320a: Handle ACPI device CALS0001

Matt Ranostay (1):
      dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC

Matti Vaittinen (7):
      iio: bu27034: Probe asynchronously
      iio: kx022a: Probe asynchronously
      dt-bindings: iio: light: ROHM BU27008
      iio: trigger: Add simple trigger_validation helper
      iio: kx022a: Use new iio_validate_own_trigger()
      iio: light: ROHM BU27008 color sensor
      MAINTAINERS: Add ROHM BU27008

Michal Simek (2):
      firmware: xilinx: Switch Michal Simek's email to new one
      nvmem: zynqmp: Switch @xilinx.com emails to @amd.com

Mike Leach (1):
      coresight: etm4x: Fix missing trctraceidr file in sysfs

Mirsad Goran Todorovac (1):
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Nathan Chancellor (1):
      coresight: dummy: Update type of mode parameter in dummy_{sink,source}_enable()

Niklas Schnelle (10):
      iio: ad7606: Kconfig: add HAS_IOPORT dependencies
      misc: add HAS_IOPORT dependencies
      char: add HAS_IOPORT dependencies
      comedi: add HAS_IOPORT dependencies
      counter: add HAS_IOPORT_MAP dependency
      firmware: dmi-sysfs: handle HAS_IOPORT=n
      mISDN: add HAS_IOPORT dependencies
      parport: PC style parport depends on HAS_IOPORT
      pcmcia: add HAS_IOPORT dependencies
      speakup: add HAS_IOPORT dependency for SPEAKUP_SERIALIO

Nipun Gupta (1):
      cdx: fix driver managed dma support

Nuno Sá (1):
      iio: buffer: fix coding style warnings

Peng Fan (2):
      dt-bindings: nvmem: imx-ocotp: support i.MX93
      nvmem: imx: support i.MX93 OCOTP

Peter Colberg (1):
      uio: dfl: add vendor-specific feature id

Phil Elwell (1):
      nvmem: rmem: Use NVMEM_DEVID_AUTO

Prathu Baronia (1):
      amba: move to_amba_device() to use container_of_const

Rafał Miłecki (5):
      dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for MACs
      nvmem: brcm_nvram: add .read_post_process() for MACs
      dt-bindings: nvmem: layouts: add fixed-layout
      dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
      nvmem: core: add support for fixed cells *layout*

Randy Dunlap (1):
      accessibility: use C99 array init

Rasmus Villemoes (1):
      iio: addac: ad74413: don't set DIN_SINK for functions other than digital input

Rong Tao (2):
      tools/counter: Add .gitignore
      tools/counter: Makefile: Remove lingering 'include' directories on make clean

Sean Nyekjaer (3):
      iio: adc: stm32-adc: add debug info if dt uses legacy channel config
      iio: accel: fxls8962af: fixup buffer scan element type
      iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF

Shreeya Patel (6):
      iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
      iio: adc: rockchip_saradc: Use of_device_get_match_data
      iio: adc: rockchip_saradc: Match alignment with open parenthesis
      iio: adc: rockchip_saradc: Use dev_err_probe
      dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
      dt-bindings: iio: rockchip: Fix 'oneOf' condition failed warning

Simon Xue (2):
      iio: adc: rockchip_saradc: Add callback functions
      iio: adc: rockchip_saradc: Add support for RK3588

Stefan Wahren (1):
      w1: w1_therm: fix locking behavior in convert_t

Stefan Windfeldt-Prytz (2):
      dt-bindings: iio: light: Document TI OPT4001 light sensor
      iio: light: Add support for TI OPT4001 light sensor

Suzuki K Poulose (2):
      coresight: etm4x: Match all ETM4 instances based on DEVARCH and DEVTYPE
      MAINTAINERS: coresight: Add James Clark as Reviewer

Tom Rix (1):
      nvmem: imx-ocotp: set varaiable imx_ocotp_layout storage-class-specifier to static

Uwe Kleine-König (10):
      counter: stm32-timer-cnt: Reset TIM_TISEL to its default value in probe
      iio: Switch i2c drivers back to use .probe()
      staging: iio: Switch i2c drivers back to use .probe()
      misc: Switch i2c drivers back to use .probe()
      extcon: Switch i2c drivers back to use .probe()
      coresight: etm4x: Make etm4_remove_dev() return void
      mux: adg792a: Switch back to use i2c_driver's .probe()
      char: xilinx_hwicap: Fold hwicap_remove() into only caller
      char: xilinx_hwicap: Drop if block with always false condition
      char: xilinx_hwicap: Convert to platform remove callback returning void

William Breathitt Gray (6):
      counter: 104-quad-8: Remove reference in Kconfig to 25-bit counter value
      counter: 104-quad-8: Utilize bitfield access macros
      counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
      counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
      counter: 104-quad-8: Migrate to the regmap API
      counter: i8254: Introduce the Intel 8254 interface library module

Wolfram Sang (1):
      w1: sgi: move from strlcpy with unused retval to strscpy

Yi Yingao (1):
      nvmem: sunplus-ocotp: release otp->clk before return

Yicong Yang (5):
      hwtracing: hisi_ptt: Factor out filter allocation and release operation
      hwtracing: hisi_ptt: Add support for dynamically updating the filter list
      hwtracing: hisi_ptt: Export available filters through sysfs
      hwtracing: hisi_ptt: Advertise PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
      hwtracing: hisi_ptt: Fix potential sleep in atomic context

Yue Zhao (1):
      lkdtm: replace ll_rw_block with submit_bh

Zhangfei Gao (2):
      uacce: use q->mapping to replace inode->i_mapping
      uacce: vma_close clears q->qfrs when freeing qfrs

zuoqilin (1):
      w1: Simplify the atribute show

 Documentation/ABI/testing/sysfs-bus-counter        |   54 ++
 Documentation/ABI/testing/sysfs-devices-hisi_ptt   |   52 +
 .../bindings/arm/arm,coresight-dummy-sink.yaml     |   73 ++
 .../bindings/arm/arm,coresight-dummy-source.yaml   |   71 ++
 .../bindings/extcon/qcom,pm8941-misc.yaml          |   14 +-
 .../devicetree/bindings/extcon/wlf,arizona.yaml    |   14 +-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |    5 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |   28 +-
 .../bindings/iio/adc/rockchip-saradc.yaml          |    1 +
 .../bindings/iio/afe/voltage-divider.yaml          |    2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    3 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    1 +
 .../bindings/iio/light/rohm,bu27008.yaml           |   49 +
 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |   68 ++
 .../bindings/iio/potentiometer/renesas,x9250.yaml  |   78 ++
 .../iio/pressure/honeywell,mprls0025pa.yaml        |  104 ++
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    1 +
 .../bindings/iio/temperature/melexis,mlx90614.yaml |    6 +-
 .../bindings/iio/temperature/ti,tmp006.yaml        |   42 +
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |    2 +-
 .../devicetree/bindings/nvmem/brcm,nvram.yaml      |   15 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   26 +-
 .../bindings/nvmem/layouts/fixed-cell.yaml         |   31 +
 .../bindings/nvmem/layouts/fixed-layout.yaml       |   50 +
 .../bindings/nvmem/layouts/nvmem-layout.yaml       |    5 +-
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |    8 +-
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |   61 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    6 -
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |    6 -
 Documentation/devicetree/bindings/nvmem/rmem.yaml  |    1 +
 .../devicetree/bindings/nvmem/rockchip,otp.yaml    |  122 +++
 .../devicetree/bindings/nvmem/rockchip-otp.txt     |   25 -
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   |    3 -
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |    6 -
 Documentation/devicetree/bindings/sram/sram.yaml   |    1 +
 Documentation/driver-api/driver-model/devres.rst   |    1 +
 Documentation/fault-injection/provoke-crashes.rst  |    2 +-
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/tps6594-pfsm.rst        |   87 ++
 Documentation/trace/coresight/coresight-dummy.rst  |   32 +
 Documentation/trace/hisi-ptt.rst                   |   12 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |   25 +-
 drivers/accessibility/speakup/Kconfig              |    1 +
 drivers/accessibility/speakup/main.c               |    2 +-
 drivers/android/binder.c                           |   15 +-
 drivers/android/binder_internal.h                  |    3 +
 drivers/bus/fsl-mc/dprc-driver.c                   |    6 +
 drivers/cdx/cdx.c                                  |   18 +
 drivers/cdx/controller/Kconfig                     |   10 -
 drivers/cdx/controller/mcdi.c                      |   86 +-
 drivers/cdx/controller/mcdi.h                      |    6 -
 drivers/char/Kconfig                               |    3 +-
 drivers/char/bsr.c                                 |   21 +-
 drivers/char/dsp56k.c                              |   18 +-
 drivers/char/lp.c                                  |   18 +-
 drivers/char/mem.c                                 |   15 +-
 drivers/char/misc.c                                |   39 +-
 drivers/char/ppdev.c                               |   19 +-
 drivers/char/virtio_console.c                      |   24 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |   52 +-
 drivers/char/xillybus/xillybus_class.c             |   21 +-
 drivers/clk/qcom/Kconfig                           |    1 +
 drivers/clk/qcom/clk-cbf-8996.c                    |   60 +-
 drivers/comedi/Kconfig                             |  103 +-
 drivers/comedi/comedi_fops.c                       |   47 +-
 drivers/comedi/drivers/comedi_test.c               |   23 +-
 drivers/counter/104-quad-8.c                       |  802 ++++++++-------
 drivers/counter/Kconfig                            |   23 +-
 drivers/counter/Makefile                           |    1 +
 drivers/counter/counter-sysfs.c                    |    8 +-
 drivers/counter/i8254.c                            |  447 +++++++++
 drivers/counter/stm32-timer-cnt.c                  |    3 +
 drivers/extcon/Kconfig                             |    1 +
 drivers/extcon/extcon-axp288.c                     |    2 +-
 drivers/extcon/extcon-fsa9480.c                    |    2 +-
 drivers/extcon/extcon-palmas.c                     |    1 -
 drivers/extcon/extcon-ptn5150.c                    |    2 +-
 drivers/extcon/extcon-qcom-spmi-misc.c             |    4 +-
 drivers/extcon/extcon-rt8973a.c                    |    2 +-
 drivers/extcon/extcon-sm5502.c                     |    2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |  155 ++-
 drivers/extcon/extcon.c                            |  368 ++++---
 drivers/extcon/extcon.h                            |    8 +-
 drivers/firmware/dmi-sysfs.c                       |    4 +
 drivers/firmware/stratix10-svc.c                   |    2 +-
 drivers/firmware/xilinx/zynqmp-debug.c             |    2 +-
 drivers/firmware/xilinx/zynqmp-debug.h             |    2 +-
 drivers/firmware/xilinx/zynqmp.c                   |    2 +-
 drivers/fpga/dfl-fme-main.c                        |    4 +-
 drivers/fpga/zynq-fpga.c                           |    8 +-
 drivers/hwtracing/coresight/Kconfig                |   11 +
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-catu.c       |   21 +-
 drivers/hwtracing/coresight/coresight-core.c       |  605 ++++++------
 drivers/hwtracing/coresight/coresight-cti-core.c   |   52 +-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |    4 +-
 drivers/hwtracing/coresight/coresight-cti.h        |    4 +-
 drivers/hwtracing/coresight/coresight-dummy.c      |  163 ++++
 drivers/hwtracing/coresight/coresight-etb10.c      |   13 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    4 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    6 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   20 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   27 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   26 +-
 drivers/hwtracing/coresight/coresight-platform.c   |  269 ++---
 drivers/hwtracing/coresight/coresight-priv.h       |   36 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   23 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    6 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |   17 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   26 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  110 ++-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 +
 drivers/hwtracing/coresight/coresight-tpda.c       |   23 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       |    4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    7 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |    3 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c         |   11 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h         |    2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |  444 ++++++++-
 drivers/hwtracing/ptt/hisi_ptt.h                   |   56 ++
 drivers/iio/accel/adxl313_i2c.c                    |    2 +-
 drivers/iio/accel/adxl345_i2c.c                    |    2 +-
 drivers/iio/accel/adxl355_i2c.c                    |    2 +-
 drivers/iio/accel/adxl367_i2c.c                    |    2 +-
 drivers/iio/accel/adxl372_i2c.c                    |    2 +-
 drivers/iio/accel/bma180.c                         |    2 +-
 drivers/iio/accel/bma400_core.c                    |    3 +-
 drivers/iio/accel/bma400_i2c.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    2 +-
 drivers/iio/accel/da280.c                          |    2 +-
 drivers/iio/accel/da311.c                          |    2 +-
 drivers/iio/accel/dmard06.c                        |    2 +-
 drivers/iio/accel/dmard09.c                        |    2 +-
 drivers/iio/accel/dmard10.c                        |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |    8 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    2 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |    3 +-
 drivers/iio/accel/kionix-kx022a-spi.c              |    1 +
 drivers/iio/accel/kionix-kx022a.c                  |   13 +-
 drivers/iio/accel/kxcjk-1013.c                     |    2 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    2 +-
 drivers/iio/accel/mc3230.c                         |    2 +-
 drivers/iio/accel/mma7455_i2c.c                    |    2 +-
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/mma9551.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    2 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/mxc4005.c                        |    2 +-
 drivers/iio/accel/mxc6255.c                        |    2 +-
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    2 +-
 drivers/iio/accel/stk8312.c                        |    2 +-
 drivers/iio/accel/stk8ba50.c                       |    2 +-
 drivers/iio/adc/Kconfig                            |    2 +-
 drivers/iio/adc/ad7091r5.c                         |    2 +-
 drivers/iio/adc/ad7192.c                           |    8 +-
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/ad799x.c                           |    2 +-
 drivers/iio/adc/ina2xx-adc.c                       |    2 +-
 drivers/iio/adc/ltc2471.c                          |    2 +-
 drivers/iio/adc/ltc2485.c                          |    2 +-
 drivers/iio/adc/ltc2497.c                          |    2 +-
 drivers/iio/adc/max1363.c                          |    2 +-
 drivers/iio/adc/max9611.c                          |    2 +-
 drivers/iio/adc/mcp3422.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/iio/adc/nau7802.c                          |    2 +-
 drivers/iio/adc/palmas_gpadc.c                     |    1 -
 drivers/iio/adc/qcom-spmi-adc5.c                   |   15 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |   19 +-
 drivers/iio/adc/rockchip_saradc.c                  |  246 +++--
 drivers/iio/adc/rtq6056.c                          |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    2 +
 drivers/iio/adc/ti-adc081c.c                       |    2 +-
 drivers/iio/adc/ti-ads1015.c                       |    2 +-
 drivers/iio/adc/ti-ads1100.c                       |    2 +-
 drivers/iio/adc/ti-ads7924.c                       |    2 +-
 drivers/iio/addac/ad74413r.c                       |   11 +-
 drivers/iio/amplifiers/ad8366.c                    |    2 +-
 drivers/iio/cdc/ad7150.c                           |    2 +-
 drivers/iio/cdc/ad7746.c                           |    2 +-
 drivers/iio/chemical/ams-iaq-core.c                |    2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    2 +-
 drivers/iio/chemical/bme680_i2c.c                  |    2 +-
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/scd30_i2c.c                   |    2 +-
 drivers/iio/chemical/scd4x.c                       |    2 +-
 drivers/iio/chemical/sgp30.c                       |    2 +-
 drivers/iio/chemical/sgp40.c                       |    2 +-
 drivers/iio/chemical/sps30_i2c.c                   |    2 +-
 drivers/iio/chemical/sunrise_co2.c                 |    2 +-
 drivers/iio/chemical/vz89x.c                       |    2 +-
 drivers/iio/dac/ad5064.c                           |    2 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5593r.c                          |    2 +-
 drivers/iio/dac/ad5696-i2c.c                       |    2 +-
 drivers/iio/dac/ds4424.c                           |    2 +-
 drivers/iio/dac/m62332.c                           |    2 +-
 drivers/iio/dac/max517.c                           |    2 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    2 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    2 +-
 drivers/iio/gyro/itg3200_core.c                    |    2 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    2 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/health/max30100.c                      |    2 +-
 drivers/iio/health/max30102.c                      |    2 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/hdc100x.c                     |    2 +-
 drivers/iio/humidity/hdc2010.c                     |    2 +-
 drivers/iio/humidity/hts221_i2c.c                  |    2 +-
 drivers/iio/humidity/htu21.c                       |    2 +-
 drivers/iio/humidity/si7005.c                      |    2 +-
 drivers/iio/humidity/si7020.c                      |    2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    2 +-
 drivers/iio/imu/bno055/bno055_i2c.c                |    2 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  |   49 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   10 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +
 drivers/iio/imu/kmx61.c                            |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    2 +-
 drivers/iio/imu/st_lsm9ds0/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   14 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    5 +
 drivers/iio/industrialio-buffer.c                  |   98 +-
 drivers/iio/industrialio-trigger.c                 |   22 +-
 drivers/iio/light/Kconfig                          |   25 +
 drivers/iio/light/Makefile                         |    2 +
 drivers/iio/light/adjd_s311.c                      |    2 +-
 drivers/iio/light/adux1020.c                       |    2 +-
 drivers/iio/light/al3010.c                         |    2 +-
 drivers/iio/light/al3320a.c                        |   10 +-
 drivers/iio/light/apds9300.c                       |    2 +-
 drivers/iio/light/apds9960.c                       |    2 +-
 drivers/iio/light/as73211.c                        |    2 +-
 drivers/iio/light/bh1750.c                         |    2 +-
 drivers/iio/light/bh1780.c                         |    2 +-
 drivers/iio/light/cm32181.c                        |    2 +-
 drivers/iio/light/cm3232.c                         |    2 +-
 drivers/iio/light/cm3323.c                         |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    2 +-
 drivers/iio/light/isl29018.c                       |    2 +-
 drivers/iio/light/isl29028.c                       |    2 +-
 drivers/iio/light/isl29125.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    2 +-
 drivers/iio/light/ltr501.c                         |    2 +-
 drivers/iio/light/ltrf216a.c                       |    2 +-
 drivers/iio/light/lv0104cs.c                       |    2 +-
 drivers/iio/light/max44000.c                       |    2 +-
 drivers/iio/light/max44009.c                       |    2 +-
 drivers/iio/light/noa1305.c                        |    2 +-
 drivers/iio/light/opt3001.c                        |    2 +-
 drivers/iio/light/opt4001.c                        |  467 +++++++++
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rohm-bu27008.c                   | 1026 ++++++++++++++++++++
 drivers/iio/light/rohm-bu27034.c                   |    3 +-
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/si1133.c                         |    2 +-
 drivers/iio/light/si1145.c                         |    2 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    2 +-
 drivers/iio/light/stk3310.c                        |    2 +-
 drivers/iio/light/tcs3414.c                        |    2 +-
 drivers/iio/light/tcs3472.c                        |    2 +-
 drivers/iio/light/tsl2563.c                        |    2 +-
 drivers/iio/light/tsl2583.c                        |    2 +-
 drivers/iio/light/tsl2591.c                        |    2 +-
 drivers/iio/light/tsl2772.c                        |    2 +-
 drivers/iio/light/tsl4531.c                        |    2 +-
 drivers/iio/light/us5182d.c                        |    2 +-
 drivers/iio/light/vcnl4000.c                       |    2 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/light/veml6070.c                       |    2 +-
 drivers/iio/light/vl6180.c                         |    2 +-
 drivers/iio/light/zopt2201.c                       |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    2 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    2 +-
 drivers/iio/magnetometer/mag3110.c                 |    2 +-
 drivers/iio/magnetometer/mmc35240.c                |    2 +-
 drivers/iio/magnetometer/rm3100-i2c.c              |    2 +-
 drivers/iio/magnetometer/st_magn_core.c            |    1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
 drivers/iio/magnetometer/tmag5273.c                |    2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 +-
 drivers/iio/potentiometer/Kconfig                  |   10 +
 drivers/iio/potentiometer/Makefile                 |    1 +
 drivers/iio/potentiometer/ad5110.c                 |    2 +-
 drivers/iio/potentiometer/ad5272.c                 |    2 +-
 drivers/iio/potentiometer/ds1803.c                 |    2 +-
 drivers/iio/potentiometer/max5432.c                |    2 +-
 drivers/iio/potentiometer/mcp4018.c                |    2 +-
 drivers/iio/potentiometer/mcp4531.c                |    2 +-
 drivers/iio/potentiometer/tpl0102.c                |    2 +-
 drivers/iio/potentiometer/x9250.c                  |  220 +++++
 drivers/iio/potentiostat/lmp91000.c                |    2 +-
 drivers/iio/pressure/Kconfig                       |   13 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/abp060mg.c                    |    2 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    2 +-
 drivers/iio/pressure/dlhl60d.c                     |    2 +-
 drivers/iio/pressure/dps310.c                      |    2 +-
 drivers/iio/pressure/hp03.c                        |    2 +-
 drivers/iio/pressure/hp206c.c                      |    2 +-
 drivers/iio/pressure/icp10100.c                    |    2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    2 +-
 drivers/iio/pressure/mpl3115.c                     |    2 +-
 drivers/iio/pressure/mprls0025pa.c                 |  450 +++++++++
 drivers/iio/pressure/ms5611_i2c.c                  |    2 +-
 drivers/iio/pressure/ms5637.c                      |    2 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    2 +-
 drivers/iio/pressure/t5403.c                       |    2 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    2 +-
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/mb1232.c                     |    2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    2 +-
 drivers/iio/proximity/rfd77402.c                   |    2 +-
 drivers/iio/proximity/srf08.c                      |    2 +-
 drivers/iio/proximity/sx9310.c                     |    2 +-
 drivers/iio/proximity/sx9324.c                     |    2 +-
 drivers/iio/proximity/sx9360.c                     |    2 +-
 drivers/iio/proximity/sx9500.c                     |    2 +-
 drivers/iio/proximity/vcnl3020.c                   |    2 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
 drivers/iio/temperature/max30208.c                 |    2 +-
 drivers/iio/temperature/mlx90614.c                 |  239 +++--
 drivers/iio/temperature/mlx90632.c                 |    2 +-
 drivers/iio/temperature/tmp006.c                   |   10 +-
 drivers/iio/temperature/tmp007.c                   |    2 +-
 drivers/iio/temperature/tmp117.c                   |    2 +-
 drivers/iio/temperature/tsys01.c                   |    2 +-
 drivers/iio/temperature/tsys02d.c                  |    2 +-
 drivers/interconnect/Kconfig                       |    6 +
 drivers/interconnect/Makefile                      |    2 +
 drivers/interconnect/core.c                        |   52 +-
 drivers/interconnect/icc-clk.c                     |  174 ++++
 drivers/interconnect/qcom/icc-rpm.c                |  112 ++-
 drivers/interconnect/qcom/icc-rpm.h                |   22 +-
 drivers/interconnect/qcom/msm8996.c                |   35 +-
 drivers/interconnect/qcom/sdm660.c                 |   17 +-
 drivers/isdn/Kconfig                               |    1 -
 drivers/isdn/hardware/mISDN/Kconfig                |   12 +-
 drivers/mfd/Kconfig                                |   32 +
 drivers/mfd/Makefile                               |    3 +
 drivers/mfd/tps6594-core.c                         |  462 +++++++++
 drivers/mfd/tps6594-i2c.c                          |  244 +++++
 drivers/mfd/tps6594-spi.c                          |  129 +++
 drivers/misc/Kconfig                               |   23 +
 drivers/misc/Makefile                              |    2 +
 drivers/misc/ad525x_dpot-i2c.c                     |    2 +-
 drivers/misc/altera-stapl/Makefile                 |    3 +-
 drivers/misc/altera-stapl/altera.c                 |    6 +-
 drivers/misc/apds9802als.c                         |    2 +-
 drivers/misc/apds990x.c                            |    4 +-
 drivers/misc/bh1770glc.c                           |    4 +-
 drivers/misc/ds1682.c                              |    2 +-
 drivers/misc/eeprom/at24.c                         |    2 +-
 drivers/misc/eeprom/ee1004.c                       |    2 +-
 drivers/misc/eeprom/eeprom.c                       |    2 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |    2 +-
 drivers/misc/eeprom/max6875.c                      |    2 +-
 drivers/misc/fastrpc.c                             |    5 +-
 drivers/misc/hmc6352.c                             |    2 +-
 drivers/misc/ics932s401.c                          |    2 +-
 drivers/misc/isl29003.c                            |    2 +-
 drivers/misc/isl29020.c                            |    2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |    2 +-
 drivers/misc/lkdtm/core.c                          |    2 +-
 drivers/misc/mei/bus-fixup.c                       |    4 +-
 drivers/misc/mei/bus.c                             |    9 -
 drivers/misc/smpro-errmon.c                        |    1 -
 drivers/misc/sram.c                                |    9 +-
 drivers/misc/tps6594-esm.c                         |  132 +++
 drivers/misc/tps6594-pfsm.c                        |  306 ++++++
 drivers/misc/tsl2550.c                             |    2 +-
 drivers/misc/uacce/uacce.c                         |   25 +-
 drivers/misc/xilinx_sdfec.c                        |   12 -
 drivers/mux/Kconfig                                |    2 +-
 drivers/mux/adg792a.c                              |    2 +-
 drivers/mux/mmio.c                                 |    2 +-
 drivers/nvmem/Kconfig                              |   10 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/brcm_nvram.c                         |   28 +
 drivers/nvmem/core.c                               |   32 +-
 drivers/nvmem/imx-ocotp-ele.c                      |  175 ++++
 drivers/nvmem/imx-ocotp.c                          |   10 +-
 drivers/nvmem/rmem.c                               |    1 +
 drivers/nvmem/rockchip-otp.c                       |  191 +++-
 drivers/nvmem/sunplus-ocotp.c                      |    9 +-
 drivers/nvmem/zynqmp_nvmem.c                       |    2 +-
 drivers/parport/Kconfig                            |    3 +-
 drivers/pcmcia/Kconfig                             |    5 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |    2 +
 drivers/sbus/char/oradax.c                         |   21 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    2 +-
 drivers/uio/uio_dfl.c                              |    2 +
 drivers/w1/masters/sgi_w1.c                        |    2 +-
 drivers/w1/slaves/Kconfig                          |    4 +-
 drivers/w1/slaves/w1_ds2438.c                      |    2 -
 drivers/w1/slaves/w1_therm.c                       |   37 +-
 drivers/w1/w1.c                                    |   55 +-
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
 include/dt-bindings/mux/ti-serdes.h                |   62 ++
 include/linux/amba/bus.h                           |    2 +-
 include/linux/coresight.h                          |  127 ++-
 include/linux/device.h                             |   11 +
 include/linux/firmware/xlnx-zynqmp.h               |    2 +-
 include/linux/i8254.h                              |   21 +
 include/linux/iio/common/st_sensors.h              |    1 +
 include/linux/iio/iio.h                            |    3 +
 include/linux/iio/trigger.h                        |    1 +
 include/linux/interconnect-clk.h                   |   22 +
 include/linux/interconnect.h                       |    8 -
 include/linux/mfd/tps6594.h                        | 1020 +++++++++++++++++++
 include/linux/parport.h                            |    2 +-
 include/linux/platform_data/st_sensors_pdata.h     |    2 +-
 include/linux/uacce.h                              |    4 +-
 include/uapi/linux/counter.h                       |    6 +
 include/uapi/linux/tps6594_pfsm.h                  |   37 +
 lib/test_firmware.c                                |   12 +-
 samples/Kconfig                                    |    7 +
 samples/Makefile                                   |    1 +
 samples/pfsm/.gitignore                            |    2 +
 samples/pfsm/Makefile                              |    4 +
 samples/pfsm/pfsm-wakeup.c                         |  125 +++
 scripts/tags.sh                                    |    2 +-
 tools/counter/.gitignore                           |    2 +
 tools/counter/Makefile                             |    1 +
 446 files changed, 10479 insertions(+), 2563 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
 create mode 100644 Documentation/misc-devices/tps6594-pfsm.rst
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/counter/i8254.c
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
 create mode 100644 drivers/iio/light/opt4001.c
 create mode 100644 drivers/iio/light/rohm-bu27008.c
 create mode 100644 drivers/iio/potentiometer/x9250.c
 create mode 100644 drivers/iio/pressure/mprls0025pa.c
 create mode 100644 drivers/interconnect/icc-clk.c
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 drivers/misc/tps6594-esm.c
 create mode 100644 drivers/misc/tps6594-pfsm.c
 create mode 100644 drivers/nvmem/imx-ocotp-ele.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 create mode 100644 include/linux/i8254.h
 create mode 100644 include/linux/interconnect-clk.h
 create mode 100644 include/linux/mfd/tps6594.h
 create mode 100644 include/uapi/linux/tps6594_pfsm.h
 create mode 100644 samples/pfsm/.gitignore
 create mode 100644 samples/pfsm/Makefile
 create mode 100644 samples/pfsm/pfsm-wakeup.c
 create mode 100644 tools/counter/.gitignore
