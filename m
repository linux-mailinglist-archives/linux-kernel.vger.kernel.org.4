Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41C6A1C74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBXMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBXMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:53:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78979682A6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C60D4B81C82
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18870C433D2;
        Fri, 24 Feb 2023 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677243164;
        bh=IRe9VZwWRT1unnObymkFN3cf9tsygsxlnEnJqEj+Vpc=;
        h=Date:From:To:Cc:Subject:From;
        b=X0jFztMvxWnDR2/CaZcBV2r1USj09HqxGHyUEmpL5Xzo7hVYaQi7mQWWK9Sk7p2ZN
         hmf1uESS9Zcs89DS3/vdhjd5IqdTAj48CA2PmbbW3egXVk1rj/GbTLzX35z5fk2m3T
         SxRN9j+5z+x0ksAsN2GMiZcIyoHC+jRqQ4HUtuo8=
Date:   Fri, 24 Feb 2023 13:52:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.3-rc1
Message-ID: <Y/izGr/4KrHkbHx+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.3-rc1

for you to fetch changes up to 6ec363fc6142226b9ab5a6528f65333d729d2b6b:

  scripts/tags.sh: fix incompatibility with PCRE2 (2023-02-16 13:52:29 +0100)

----------------------------------------------------------------
Char/Misc and other driver subsystem changes for 6.3-rc1

Here is the large set of driver changes for char/misc drivers and other
smaller driver subsystems that flow through this git tree.

Included in here are:
  - New IIO drivers and features and improvments in that subsystem
  - New hwtracing drivers and additions to that subsystem
  - lots of interconnect changes and new drivers as that subsystem seems
    under very active development recently.  This required also merging
    in the icc subsystem changes through this tree.
  - FPGA driver updates
  - counter subsystem and driver updates
  - MHI driver updates
  - nvmem driver updates
  - documentation updates
  - Other smaller driver updates and fixes, full details in the shortlog

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: interconnect: Add Qualcomm SM8550
      interconnect: qcom: Add SM8550 interconnect provider driver

Alexander Sverdlin (2):
      dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc description
      iio: adc: ep93xx: Add OF support

Alexander Usyskin (2):
      mei: bus-fixup:upon error print return values of send and receive
      mei: bus: disallow driver match while dismantling device

Alexander Vorwerk (1):
      drivers: iio: cdc: Drop redundant if check

Alper Nebi Yasak (1):
      firmware: coreboot: framebuffer: Ignore reserved pixel color bits

Andy Shevchenko (24):
      iio: light: tsl2563: Use i2c_smbus_write_word_data() in tsl2563_configure()
      iio: light: tsl2563: Configure INT in one place
      iio: light: tsl2563: Make use of the macros from bits.h
      iio: light: tsl2563: Drop unused defintion(s)
      iio: light: tsl2563: Simplify with dev_err_probe
      iio: light: tsl2563: Drop legacy platform data code
      iio: light: tsl2563: Utilise temporary variable for struct device
      iio: light: tsl2563: Use dev_get_drvdata() directly in PM callbacks
      iio: light: tsl2563: sort header inclusion alphabetically
      iio: light: tsl2563: Keep Makefile sorted by module name
      iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
      iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
      iio: adc: ti-adc128s052: Sort headers
      iio: adc: max11410: Use asm intead of asm-generic
      iio: chemical: scd30_core: use sysfs_emit() to instead of scnprintf()
      iio: chemical: scd30_core: Switch to use dev_err_probe()
      eeprom: at25: Convert to use fwnode_device_is_compatible()
      mei: pxp: Use correct macros to initialize uuid_le
      misc/mei/hdcp: Use correct macros to initialize uuid_le
      iio: adc: xilinx-ams: Convert to use fwnode_device_is_compatible()
      iio: core: Replace iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
      iio: core: Sort headers
      uuid: Decouple guid_t and uuid_le types and respective macros
      mei: Move uuid_le_cmp() to its only user

Angelo Dureghello (1):
      iio: dac: add support for max5522

AngeloGioacchino Del Regno (1):
      dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering

Anup Sharma (1):
      iio: adc: ad7291: Fix indentation error by adding extra spaces

Appana Durga Kedareswara rao (4):
      dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
      drivers: misc: Add Support for TMR Manager
      dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
      drivers: misc: Add Support for TMR Inject IP

Arnd Bergmann (2):
      Coresight: tpda/tpdm: remove incorrect __exit annotation
      nvmem: stm32: fix OPTEE dependency

Bagas Sanjaya (2):
      Documentation: coresight: Extend title heading syntax in TPDM and TPDA documentation
      Documentation: coresight: tpdm: Add dummy comment after sysfs list

Bartosz Golaszewski (2):
      dt-bindings: interconnect: qcom: document the interconnects for sa8775p
      dt-bindings: interconnect: qcom,sa8775p-rpmh: fix a typo

Bo Liu (2):
      virtio_console: Use strscpy() to instead of strncpy()
      misc: isl29003: Use sysfs_emit() to instead of sprintf()

Bryan O'Donoghue (1):
      dt-bindings: interconnect: Exclude all non msm8939 from snoc-mm

Carl Vanderlip (1):
      bus: mhi: Update Makefile to used Kconfig flags

Carlos Llamas (1):
      scripts/tags.sh: fix incompatibility with PCRE2

Chen Zhongjin (1):
      firmware: dmi-sysfs: Fix null-ptr-deref in dmi_sysfs_register_handle

Christophe JAILLET (1):
      misc: fastrpc: Fix an error handling path in fastrpc_rpmsg_probe()

Colin Ian King (4):
      iio: imu: kmx61: Fix spelling mistake "Errow" -> "Error"
      accessibility: speakup: Fix spelling mistake "thw" -> "the"
      firmware: dmi-sysfs: make pr_info messages rate limited
      iio: adc: imx93: Fix spelling mistake "geting" -> "getting"

Dan Carpenter (1):
      bus: mhi: ep: Fix off by one in mhi_ep_process_cmd_ring()

Dmitry Baryshkov (9):
      interconnect: qcom: sdx55: drop IP0 remnants
      interconnect: qcom: sc7180: drop IP0 remnants
      interconnect: move ignore_list out of of_count_icc_providers()
      interconnect: qcom: sm8150: Drop IP0 interconnects
      interconnect: qcom: sm8250: Drop IP0 interconnects
      interconnect: qcom: sc8180x: Drop IP0 interconnects
      interconnect: qcom: sc8280xp: Drop IP0 interconnects
      dt-bindings: interconnect: qcom: Remove ipa-virt compatibles
      dt-bindings: interconnect: qcom: drop IPA_CORE related defines

Douglas Anderson (1):
      firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF Kconfig entries

Duoming Zhou (1):
      Revert "char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol"

Fabio Estevam (3):
      dt-bindings: iio: dac: ad5686: Add an entry for AD5337
      iio: dac: ad5686: Add support for AD5337
      dt-bindings: iio: adc: max1238: Fix a typo in the description

Ferry Toth (1):
      iio: light: tsl2563: Do not hardcode interrupt trigger type

George Kennedy (1):
      VMCI: check context->notify_page after call to get_user_pages_fast() to avoid GPF

Georgi Djakov (6):
      Merge branch 'icc-sm8550-immutable' into icc-next
      Merge branch 'icc-qdu1000' into icc-next
      Merge branch 'icc-ip0-migration' into icc-next
      Merge branch 'icc-sdm670' into icc-next
      Merge branch 'icc-sa8775p' into icc-next
      Merge branch 'icc-dt' into icc-next

Gerald Loacker (3):
      iio: add struct declaration for iio types
      dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
      iio: magnetometer: add ti tmag5273 driver

Greg Kroah-Hartman (9):
      Merge 6.2-rc5 into char-misc-next
      Merge tag 'fpga-for-v6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'counter-updates-for-6.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'coresight-next-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'mhi-for-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'iio-for-6.3a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge 6.2-rc7 into char-misc-next
      Merge tag 'icc-6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      misc: vmw_balloon: fix memory leak with using debugfs_lookup()

Haibo Chen (2):
      iio: adc: add imx93 adc support
      dt-bindings: iio: adc: Add NXP IMX93 ADC

Harshit Mogalapalli (2):
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_read_status_word()
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_read_config_word()

Hugo Villeneuve (2):
      iio: adc: ti-ads7924: add Texas Instruments ADS7924 driver
      dt-bindings: iio: adc: add Texas Instruments ADS7924

Ian Abbott (1):
      comedi: check data length for INSN_CONFIG_GET_PWM_OUTPUT

Ilpo Järvinen (10):
      mfd: intel-m10-bmc: Add missing includes to header
      mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
      mfd: intel-m10-bmc: Rename the local variables
      mfd: intel-m10-bmc: Split into core and spi specific parts
      mfd: intel-m10-bmc: Support multiple CSR register layouts
      fpga: intel-m10-bmc: Rework flash read/write
      mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
      fpga: m10bmc-sec: Create helpers for rsu status/progress checks
      fpga: m10bmc-sec: Make rsu status type specific
      mfd: intel-m10-bmc: Add PMCI driver

Ivan Bornyakov (3):
      fpga: microchip-spi: move SPI I/O buffers out of stack
      fpga: microchip-spi: rewrite status polling in a time measurable way
      fpga: microchip-spi: separate data frame write routine

James Clark (2):
      coresight: cti: Prevent negative values of enable count
      coresight: cti: Remove atomic type from enable_req_count

Jiazi.Li (1):
      binder: remove unneeded size check code

Johan Hovold (1):
      nvmem: qcom-spmi-sdam: register at device init time

Jonathan Cameron (5):
      iio: accel: bma400: Use devm_regulator_bulk_get_enable()
      iio: pressure: ms5611: Use devm_regulator_get_enable()
      iio: pressure: ms5611: Switch to fully devm_ managed registration.
      iio: adc: ep93xx: Enable wider build testing with COMPILE_TEST
      dt-bindings: iio: dac: Maxim max5522 DAC

Jonathan Neuschäfer (1):
      drivers: misc: ti-st: Fix a typo ("unknow")

Junhao He (1):
      coresight: etm4x: Fix accesses to TRCSEQRSTEVR and TRCSEQSTR

Kai Ye (3):
      uacce: supports device isolation feature
      Documentation: add the device isolation feature sysfs nodes for uacce
      crypto: hisilicon/qm - define the device isolation strategy

Konrad Dybcio (3):
      dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible
      dt-bindings: nvmem: Add compatible for SM8150
      dt-bindings: nvmem: Add compatible for SM8250

Krzysztof Kozlowski (10):
      dt-bindings: iio: adc: maxim,max1363: fix interface typo
      dt-bindings: interconnect: split SC7280 to own schema
      dt-bindings: interconnect: split SC8280XP to own schema
      dt-bindings: interconnect: split SM8450 to own schema
      dt-bindings: iio: drop unneeded quotes
      dt-bindings: iio: minor whitespace cleanups
      dt-bindings: iio: correct node names in examples
      dt-bindings: iio: use lowercase hex in examples
      dt-bindings: iio: cleanup examples - indentation
      dt-bindings: interconnect: samsung,exynos-bus: allow opp-table

Leonard Göhrs (2):
      dt-bindings: iio: adc: add TI LMP92064 controller
      iio: adc: add ADC driver for the TI LMP92064 controller

Li Li (1):
      binder: return pending info for frozen async txns

Li kunyu (1):
      sgi-gru: grukservices: remove unnecessary (void*) conversions

Liu Ying (1):
      drivers: bus: simple-pm-bus: Use clocks

Luca Weiss (1):
      iio: adc: qcom-spmi-adc5: define ADC5_BAT_ID_100K_PU channel

Lukas Bulwahn (1):
      counter: fix dependency references for config MICROCHIP_TCB_CAPTURE

Maciej W. Rozycki (7):
      parport_pc: Remove stale `parport_pc_ecp_read_block_pio' reference
      parport_pc: Let chipset drivers mask unsupported modes
      parport_pc: Let chipset drivers mask ECR bits on writes
      parport_pc: Add a mode mask field for PCI devices
      parport_pc: Add an ECR mask field for PCI devices
      parport_pc: Set up mode and ECR masks for Oxford Semiconductor devices
      parport_pc: Limit the number of PCI BAR pairs to 2

Manivannan Sadhasivam (7):
      bus: mhi: ep: Power up/down MHI stack during MHI RESET
      bus: mhi: ep: Check if the channel is supported by the controller
      bus: mhi: ep: Only send -ENOTCONN status if client driver is available
      bus: mhi: ep: Fix the debug message for MHI_PKT_TYPE_RESET_CHAN_CMD cmd
      bus: mhi: ep: Move chan->lock to the start of processing queued ch ring
      bus: mhi: ep: Save channel state locally during suspend and resume
      bus: mhi: ep: Change state_lock to mutex

Mao Jinlong (9):
      coresight: cti: Add PM runtime call in enable_store
      coresight: core: Use IDR for non-cpu bound sources' paths.
      Coresight: Add coresight TPDM source driver
      dt-bindings: arm: Add CoreSight TPDM hardware
      coresight-tpdm: Add DSB dataset support
      coresight-tpdm: Add integration test support
      Coresight: Add TPDA link driver
      dt-bindings: arm: Adds CoreSight TPDA hardware definitions
      Documentation: trace: Add documentation for TPDM and TPDA

Marco Pagani (1):
      fpga: bridge: return errors in the show() method of the "state" attribute

Marijn Suijten (2):
      iio: adc: qcom-spmi-adc5: Suppress probe-deferral error message
      dt-bindings: nvmem: Add compatible for MSM8976

Melody Olvera (2):
      dt-bindings: interconnect: Add QDU1000/QRU1000 devices
      interconnect: qcom: Add QDU1000/QRU1000 interconnect driver

Miaoqian Lin (1):
      misc: enclosure: Fix doc for enclosure_find()

Michael Walle (9):
      net: add helper eth_addr_add()
      of: base: add of_parse_phandle_with_optional_args()
      of: property: make #.*-cells optional for simple props
      of: property: add #nvmem-cell-cells property
      nvmem: core: add an index parameter to the cell
      nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
      nvmem: core: drop the removal of the cells in nvmem_add_cells()
      nvmem: core: add nvmem_add_one_cell()
      nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()

Mike Leach (11):
      coresight: trace-id: Add API to dynamically assign Trace ID values
      coresight: Remove obsolete Trace ID unniqueness checks
      coresight: perf: traceid: Add perf ID allocation and notifiers
      coresight: stm: Update STM driver to use Trace ID API
      coresight: etm4x: Update ETM4 driver to use Trace ID API
      coresight: etm3x: Update ETM3 driver to use Trace ID API
      coresight: etmX.X: stm: Remove trace_id() callback
      coresight: trace id: Remove legacy get trace ID function.
      kernel: events: Export perf_report_aux_output_id()
      coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
      coresight: trace-id: Add debug & test macros to Trace ID allocation

Mårten Lindahl (3):
      iio: light: vcnl4000: Prepare for more generic setup
      iio: light: vcnl4000: Make irq handling more generic
      iio: light: vcnl4000: Add interrupt support for vcnl4040

Neil Armstrong (1):
      dt-bindings: interconnect: qcom-bwmon: document SM8550 compatibles

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: add id registers support

Patrick Delaunay (2):
      nvmem: stm32: add OP-TEE support for STM32MP13x
      nvmem: stm32: detect bsec pta presence for STM32MP15x

Paulo Miguel Almeida (1):
      scripts/tags.sh: choose which directories to exclude from being indexed

Peter Robinson (4):
      counter: Sort the Kconfig entries alphabetically
      counter: intel-qep: Depend on X86
      counter: ftm-quaddec: Depend on the Layerscape SoC
      counter: microchip-tcp-capture: Add appropriate arch deps for TCP driver

Philippe De Muyter (2):
      iio: imu: st_lsm6dsx: fix naming of 'struct iio_info' in st_lsm6dsx_shub.c.
      iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.

Qi Liu (2):
      drivers/coresight: Add UltraSoc System Memory Buffer driver
      Documentation: Add document for UltraSoc SMB driver

Randy Dunlap (8):
      android: fix W=1 kernel-doc warnings
      most: fix kernel-doc warnings
      most: tell what the MOST acronym means
      pcmcia: synclink_cs: remove kernel-doc notation
      misc: genwqe: move intervening macros away from kernel-doc
      comedi: use menuconfig for main Comedi menu
      fpga: dfl: kernel-doc corrections
      nvmem: rave-sp-eeprm: fix kernel-doc bad line warning

Rayyan Ansari (1):
      dt-bindings: iio/adc: qcom,spmi-iadc: document PM8226 compatible

Richard Acayan (3):
      dt-bindings: interconnect: add sdm670 interconnects
      interconnect: qcom: add sdm670 interconnects
      dt-bindings: nvmem: qfprom: add sdm670 compatible

Rob Herring (1):
      dt-bindings: iio/proximity: semtech,sx9360: Fix 'semtech,resolution' type

Robert Marko (1):
      dt-bindings: nvmem: qfprom: add IPQ8074 compatible

Russell King (Oracle) (1):
      nvmem: core: remove spurious white space

Samuel Holland (2):
      dt-bindings: iio: adc: ti,adc081c: Document the binding
      nvmem: sunxi_sid: Drop the workaround on A64

Shazad Hussain (1):
      interconnect: qcom: add a driver for sa8775p

Slark Xiao (1):
      bus: mhi: host: Update mhi driver description

Stephan Gerhold (3):
      dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
      iio: accel: st_accel: Add LSM303C
      iio: magnetometer: st_magn: Add LSM303C

Suzuki K Poulose (2):
      coresight: Fix uninitialised variable use in coresight_disable
      coresight: perf: Output trace id only once

Tom Rix (1):
      iio: imu: fix spdx format

Uwe Kleine-König (1):
      iio: light: max44009: Convert to i2c's .probe_new()

Vitaly Lubart (1):
      mei: lower the log level for non-fatal failed messages

XU pengfei (1):
      ipack: ipoctal: remove unnecessary (void*) conversions

Xiongfeng Wang (1):
      applicom: Fix PCI device refcount leak in applicom_init()

Xu Yilun (2):
      fpga: dfl: more kernel-doc corrections
      Merge tag 'ib-mfd-fpga-hwmon-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into for-fpga-v6.3-rc1

Yabin Cui (1):
      coresight: tmc: Don't enable TMC when it's not ready.

Yang Yingliang (4):
      coresight: ultrasoc-smb: fix return value check in smb_init_data_buffer()
      firmware: stratix10-svc: add missing gen_pool_destroy() in stratix10_svc_drv_probe()
      firmware: stratix10-svc: fix error handle while alloc/add device failed
      coresight: tpda: fix return value check in tpda_probe()

Yicong Yang (2):
      hwtracing: hisi_ptt: Only add the supported devices to the filters list
      MAINTAINERS: Update the entries for HiSilicon PTT device driver

Yuan Can (1):
      eeprom: idt_89hpesx: Fix error handling in idt_init()

Yulong Zhang (1):
      tools/iio/iio_utils:fix memory leak

ye xingchen (2):
      iio: adc: at91-sama5d2_adc: use sysfs_emit() to instead of scnprintf()
      iio: common: scmi_iio: use sysfs_emit() to instead of scnprintf()

 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |    2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |   13 +
 .../testing/sysfs-bus-coresight-devices-ultra_smb  |   31 +
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |    8 +-
 Documentation/ABI/testing/sysfs-driver-uacce       |   18 +
 .../ABI/testing/sysfs-driver-xilinx-tmr-manager    |   16 +
 .../bindings/arm/qcom,coresight-tpda.yaml          |  129 +
 .../bindings/arm/qcom,coresight-tpdm.yaml          |   93 +
 .../bindings/iio/accel/adi,adis16201.yaml          |    2 +-
 .../bindings/iio/accel/adi,adis16240.yaml          |    2 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |    2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    4 +-
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |   52 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |   48 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |    2 +-
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    2 +-
 .../bindings/iio/accel/memsensing,msa311.yaml      |    5 +-
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |    4 +-
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |    2 +-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   42 +-
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |    2 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   40 +-
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |    2 +-
 .../devicetree/bindings/iio/adc/adi,ad799x.yaml    |   18 +-
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   10 +-
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |    2 +-
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |    4 +-
 .../bindings/iio/adc/cirrus,ep9301-adc.yaml        |   47 +
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |   18 +-
 .../devicetree/bindings/iio/adc/maxim,max1027.yaml |    4 +-
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |    2 +-
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    4 +-
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml |    2 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |    4 +-
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml |   81 +
 .../bindings/iio/adc/qcom,pm8018-adc.yaml          |    2 +-
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |    3 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |   16 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |    2 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |    6 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/ti,adc081c.yaml    |   55 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  |    2 +-
 .../devicetree/bindings/iio/adc/ti,ads7924.yaml    |  110 +
 .../devicetree/bindings/iio/adc/ti,lmp92064.yaml   |   70 +
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |   34 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   40 +-
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |    1 +
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |    1 +
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |   22 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |   88 +-
 .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |   52 +-
 .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |    4 +-
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |   20 +-
 .../devicetree/bindings/iio/dac/maxim,max5522.yaml |   49 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |    4 +-
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |    2 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |   12 +-
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |   14 +-
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |   30 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |    2 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |    2 +-
 .../devicetree/bindings/iio/humidity/dht11.yaml    |    2 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |   16 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    2 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |   24 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |   32 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |   34 +-
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |   26 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    2 +-
 .../bindings/iio/magnetometer/ti,tmag5273.yaml     |   75 +
 .../bindings/iio/magnetometer/yamaha,yas530.yaml   |   18 +-
 .../bindings/iio/potentiometer/adi,ad5272.yaml     |    2 +-
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |    2 +-
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   24 +-
 .../bindings/iio/proximity/ams,as3935.yaml         |    2 +-
 .../proximity/google,cros-ec-mkbp-proximity.yaml   |    1 -
 .../bindings/iio/proximity/semtech,sx9360.yaml     |    2 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    2 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  137 +-
 .../bindings/iio/temperature/maxim,max31865.yaml   |   12 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |    6 +-
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    2 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 .../bindings/interconnect/qcom,qdu1000-rpmh.yaml   |   70 +
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |   73 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |   46 +-
 .../bindings/interconnect/qcom,sa8775p-rpmh.yaml   |   50 +
 .../bindings/interconnect/qcom,sc7280-rpmh.yaml    |   71 +
 .../bindings/interconnect/qcom,sc8280xp-rpmh.yaml  |   49 +
 .../bindings/interconnect/qcom,sm8450-rpmh.yaml    |  124 +
 .../bindings/interconnect/qcom,sm8550-rpmh.yaml    |  139 ++
 .../bindings/interconnect/samsung,exynos-bus.yaml  |   27 +
 .../devicetree/bindings/misc/xlnx,tmr-inject.yaml  |   47 +
 .../devicetree/bindings/misc/xlnx,tmr-manager.yaml |   47 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    7 +-
 Documentation/kbuild/kbuild.rst                    |    7 +
 Documentation/trace/coresight/coresight-tpda.rst   |   52 +
 Documentation/trace/coresight/coresight-tpdm.rst   |   45 +
 Documentation/trace/coresight/ultrasoc-smb.rst     |   83 +
 MAINTAINERS                                        |   50 +-
 drivers/accessibility/speakup/main.c               |    2 +-
 drivers/android/binder.c                           |   65 +-
 drivers/android/binder_internal.h                  |    3 +-
 drivers/android/binderfs.c                         |    4 +-
 drivers/bus/mhi/Makefile                           |    4 +-
 drivers/bus/mhi/ep/main.c                          |   85 +-
 drivers/bus/mhi/ep/sm.c                            |   42 +-
 drivers/bus/mhi/host/init.c                        |    2 +-
 drivers/bus/simple-pm-bus.c                        |   46 +
 drivers/char/applicom.c                            |    5 +-
 drivers/char/pcmcia/cm4000_cs.c                    |    6 +-
 drivers/char/pcmcia/synclink_cs.c                  |   22 +-
 drivers/char/virtio_console.c                      |    5 +-
 drivers/comedi/Kconfig                             |    2 +-
 drivers/comedi/comedi_fops.c                       |    1 +
 drivers/counter/Kconfig                            |   91 +-
 drivers/crypto/hisilicon/qm.c                      |  169 +-
 drivers/firmware/dmi-sysfs.c                       |   14 +-
 drivers/firmware/google/Kconfig                    |    8 -
 drivers/firmware/google/framebuffer-coreboot.c     |    4 +-
 drivers/firmware/stratix10-svc.c                   |   25 +-
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/dfl-afu-region.c                      |    1 +
 drivers/fpga/dfl-afu.h                             |    2 +-
 drivers/fpga/dfl-fme-perf.c                        |    2 +-
 drivers/fpga/dfl-fme-pr.c                          |    4 +-
 drivers/fpga/dfl-fme-pr.h                          |    2 +-
 drivers/fpga/dfl.c                                 |    5 +-
 drivers/fpga/dfl.h                                 |    1 +
 drivers/fpga/fpga-bridge.c                         |   11 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |  364 +--
 drivers/fpga/microchip-spi.c                       |  145 +-
 drivers/hwmon/Kconfig                              |    2 +-
 drivers/hwtracing/coresight/Kconfig                |   35 +
 drivers/hwtracing/coresight/Makefile               |    5 +-
 drivers/hwtracing/coresight/coresight-core.c       |   87 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |   23 +-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |   15 +-
 drivers/hwtracing/coresight/coresight-cti.h        |    2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   31 +
 drivers/hwtracing/coresight/coresight-etm-perf.h   |    2 +
 drivers/hwtracing/coresight/coresight-etm.h        |    3 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   93 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   27 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   91 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   27 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    3 +
 drivers/hwtracing/coresight/coresight-stm.c        |   49 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   45 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   19 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 +-
 drivers/hwtracing/coresight/coresight-tpda.c       |  211 ++
 drivers/hwtracing/coresight/coresight-tpda.h       |   35 +
 drivers/hwtracing/coresight/coresight-tpdm.c       |  259 ++
 drivers/hwtracing/coresight/coresight-tpdm.h       |   62 +
 drivers/hwtracing/coresight/coresight-trace-id.c   |  297 +++
 drivers/hwtracing/coresight/coresight-trace-id.h   |  156 ++
 drivers/hwtracing/coresight/ultrasoc-smb.c         |  648 +++++
 drivers/hwtracing/coresight/ultrasoc-smb.h         |  125 +
 drivers/hwtracing/ptt/hisi_ptt.c                   |   10 +
 drivers/iio/accel/Kconfig                          |    2 +-
 drivers/iio/accel/bma400.h                         |    4 -
 drivers/iio/accel/bma400_core.c                    |   29 +-
 drivers/iio/accel/mma9551_core.c                   |   10 +-
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   34 +-
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    4 +-
 drivers/iio/adc/ep93xx_adc.c                       |    8 +
 drivers/iio/adc/imx93_adc.c                        |  484 ++++
 drivers/iio/adc/max11410.c                         |    3 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |    8 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   99 +-
 drivers/iio/adc/stm32-dfsdm.h                      |   60 +-
 drivers/iio/adc/ti-adc128s052.c                    |   54 +-
 drivers/iio/adc/ti-ads7924.c                       |  474 ++++
 drivers/iio/adc/ti-lmp92064.c                      |  332 +++
 drivers/iio/adc/xilinx-ams.c                       |    9 +-
 drivers/iio/cdc/ad7746.c                           |    3 +-
 drivers/iio/chemical/scd30_core.c                  |   46 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    4 +-
 drivers/iio/dac/Kconfig                            |   21 +-
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5686.c                           |    7 +
 drivers/iio/dac/ad5686.h                           |    1 +
 drivers/iio/dac/ad5696-i2c.c                       |    2 +
 drivers/iio/dac/max5522.c                          |  207 ++
 drivers/iio/imu/bno055/bno055_ser_trace.c          |    2 +-
 drivers/iio/imu/kmx61.c                            |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   12 +-
 drivers/iio/industrialio-core.c                    |   64 +-
 drivers/iio/light/Makefile                         |    2 +-
 drivers/iio/light/max44009.c                       |    5 +-
 drivers/iio/light/tsl2563.c                        |  189 +-
 drivers/iio/light/vcnl4000.c                       |  449 ++--
 drivers/iio/magnetometer/Kconfig                   |   14 +-
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/st_magn.h                 |    1 +
 drivers/iio/magnetometer/st_magn_core.c            |    1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +
 drivers/iio/magnetometer/st_magn_spi.c             |    5 +
 drivers/iio/magnetometer/tmag5273.c                |  743 ++++++
 drivers/iio/pressure/ms5611.h                      |    4 -
 drivers/iio/pressure/ms5611_core.c                 |   49 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    6 -
 drivers/iio/pressure/ms5611_spi.c                  |    6 -
 drivers/interconnect/core.c                        |   14 +-
 drivers/interconnect/qcom/Kconfig                  |   36 +
 drivers/interconnect/qcom/Makefile                 |    8 +
 drivers/interconnect/qcom/qdu1000.c                | 1067 ++++++++
 drivers/interconnect/qcom/qdu1000.h                |   95 +
 drivers/interconnect/qcom/sa8775p.c                | 2541 ++++++++++++++++++++
 drivers/interconnect/qcom/sc7180.h                 |    4 +-
 drivers/interconnect/qcom/sc8180x.c                |   38 -
 drivers/interconnect/qcom/sc8180x.h                |    4 +-
 drivers/interconnect/qcom/sc8280xp.c               |   25 -
 drivers/interconnect/qcom/sc8280xp.h               |    4 +-
 drivers/interconnect/qcom/sdm670.c                 |  440 ++++
 drivers/interconnect/qcom/sdm670.h                 |  128 +
 drivers/interconnect/qcom/sdx55.h                  |    4 +-
 drivers/interconnect/qcom/sm8150.c                 |   21 -
 drivers/interconnect/qcom/sm8150.h                 |    4 +-
 drivers/interconnect/qcom/sm8250.c                 |   21 -
 drivers/interconnect/qcom/sm8250.h                 |    4 +-
 drivers/interconnect/qcom/sm8550.c                 | 2318 ++++++++++++++++++
 drivers/interconnect/qcom/sm8550.h                 |  178 ++
 drivers/ipack/devices/ipoctal.c                    |    2 +-
 drivers/mfd/Kconfig                                |   32 +-
 drivers/mfd/Makefile                               |    5 +-
 drivers/mfd/intel-m10-bmc-core.c                   |  122 +
 drivers/mfd/intel-m10-bmc-pmci.c                   |  219 ++
 drivers/mfd/intel-m10-bmc-spi.c                    |  168 ++
 drivers/mfd/intel-m10-bmc.c                        |  238 --
 drivers/misc/Kconfig                               |   20 +
 drivers/misc/Makefile                              |    2 +
 drivers/misc/eeprom/at25.c                         |    8 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |   10 +-
 drivers/misc/enclosure.c                           |    2 +-
 drivers/misc/fastrpc.c                             |   13 +-
 drivers/misc/genwqe/card_utils.c                   |    6 +-
 drivers/misc/isl29003.c                            |   10 +-
 drivers/misc/mei/bus-fixup.c                       |   26 +-
 drivers/misc/mei/bus.c                             |    3 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |    4 +-
 drivers/misc/mei/mei_dev.h                         |    5 +
 drivers/misc/mei/pxp/mei_pxp.c                     |    4 +-
 drivers/misc/sgi-gru/grukservices.c                |    8 +-
 drivers/misc/ti-st/st_core.c                       |    2 +-
 drivers/misc/uacce/uacce.c                         |   50 +
 drivers/misc/vmw_balloon.c                         |    2 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |    2 +
 drivers/misc/xilinx_tmr_inject.c                   |  171 ++
 drivers/misc/xilinx_tmr_manager.c                  |  220 ++
 drivers/most/Kconfig                               |    2 +-
 drivers/most/most_cdev.c                           |    5 +-
 drivers/most/most_snd.c                            |   10 +-
 drivers/most/most_usb.c                            |    6 +-
 drivers/nvmem/Kconfig                              |   10 +
 drivers/nvmem/Makefile                             |    1 +
 drivers/nvmem/core.c                               |  145 +-
 drivers/nvmem/imx-ocotp.c                          |    4 +-
 drivers/nvmem/qcom-spmi-sdam.c                     |   13 +-
 drivers/nvmem/rave-sp-eeprom.c                     |    2 +-
 drivers/nvmem/stm32-bsec-optee-ta.c                |  298 +++
 drivers/nvmem/stm32-bsec-optee-ta.h                |   80 +
 drivers/nvmem/stm32-romem.c                        |   84 +-
 drivers/nvmem/sunxi_sid.c                          |    8 +-
 drivers/of/property.c                              |    6 +-
 drivers/parport/parport_pc.c                       |  125 +-
 .../dt-bindings/interconnect/qcom,qdu1000-rpmh.h   |   98 +
 .../dt-bindings/interconnect/qcom,sa8775p-rpmh.h   |  231 ++
 include/dt-bindings/interconnect/qcom,sc7180.h     |    3 -
 include/dt-bindings/interconnect/qcom,sc8180x.h    |    3 -
 include/dt-bindings/interconnect/qcom,sc8280xp.h   |    4 +-
 .../dt-bindings/interconnect/qcom,sdm670-rpmh.h    |  136 ++
 include/dt-bindings/interconnect/qcom,sdx55.h      |    2 -
 include/dt-bindings/interconnect/qcom,sm8150.h     |    3 -
 include/dt-bindings/interconnect/qcom,sm8250.h     |    3 -
 .../dt-bindings/interconnect/qcom,sm8550-rpmh.h    |  189 ++
 include/linux/coresight-pmu.h                      |   34 +-
 include/linux/coresight.h                          |    4 +-
 include/linux/etherdevice.h                        |   14 +
 include/linux/hisi_acc_qm.h                        |   15 +
 include/linux/iio/iio.h                            |    5 +
 include/linux/mfd/intel-m10-bmc.h                  |  154 +-
 include/linux/mhi_ep.h                             |    4 +-
 include/linux/nvmem-consumer.h                     |   10 +-
 include/linux/nvmem-provider.h                     |   31 +-
 include/linux/of.h                                 |   25 +
 include/linux/parport_pc.h                         |    3 +
 include/linux/platform_data/tsl2563.h              |    9 -
 include/linux/uacce.h                              |   12 +
 include/linux/uuid.h                               |   19 +-
 include/uapi/linux/android/binder.h                |    7 +-
 include/uapi/linux/uuid.h                          |   12 +-
 kernel/events/core.c                               |    1 +
 scripts/tags.sh                                    |    9 +-
 tools/iio/iio_utils.c                              |   23 +-
 309 files changed, 17596 insertions(+), 2386 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 Documentation/trace/coresight/coresight-tpda.rst
 create mode 100644 Documentation/trace/coresight/coresight-tpdm.rst
 create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
 create mode 100644 drivers/iio/adc/imx93_adc.c
 create mode 100644 drivers/iio/adc/ti-ads7924.c
 create mode 100644 drivers/iio/adc/ti-lmp92064.c
 create mode 100644 drivers/iio/dac/max5522.c
 create mode 100644 drivers/iio/magnetometer/tmag5273.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.h
 create mode 100644 drivers/interconnect/qcom/sa8775p.c
 create mode 100644 drivers/interconnect/qcom/sdm670.c
 create mode 100644 drivers/interconnect/qcom/sdm670.h
 create mode 100644 drivers/interconnect/qcom/sm8550.c
 create mode 100644 drivers/interconnect/qcom/sm8550.h
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sa8775p-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
 delete mode 100644 include/linux/platform_data/tsl2563.h
