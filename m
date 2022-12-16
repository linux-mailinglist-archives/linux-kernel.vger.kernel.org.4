Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C464E847
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLPIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiLPIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A837FB5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC14261FEA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76584C433EF;
        Fri, 16 Dec 2022 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671180310;
        bh=83PvLUqOjJi2/X8eJYHxjB0TXmd6PgdD3+CBXCxv9FQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ZsIDpeotRAQ6Mwjd2/MlxQlRbBZJUP2FMjcJ5/VNya68xBG9CLYO6EyitKLAUKxDG
         lq2grDMvo1vS40qY2Yjcq7hGKy3Y1gwSH+dZ4hlRaIH29Kb+dLudNJv+F3IEJFmGuc
         XniXuVnIxCRpJgBgTaOuhBygW9C60OsSM6j6Mfgk=
Date:   Fri, 16 Dec 2022 09:45:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.2-rc1
Message-ID: <Y5wwE2YWlzzG6VkA@kroah.com>
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

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc1

for you to fetch changes up to f361c96c75184d0272572087c7d9874e0f64b870:

  Merge tag 'extcon-next-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2022-12-03 10:53:13 +0100)

----------------------------------------------------------------
Char/Misc driver changes for 6.2-rc1

Here is the large set of char/misc and other driver subsystem changes
for 6.2-rc1.  Nothing earth-shattering in here at all, just a lot of new
driver development and minor fixes.  Highlights include:
 - fastrpc driver updates
 - iio new drivers and updates
 - habanalabs driver updates for new hardware and features
 - slimbus driver updates
 - speakup module parameters added to aid in boot time configuration
 - i2c probe_new conversions for lots of different drivers
 - other small driver fixes and additions

One semi-interesting change in here is the increase of the number of
misc dynamic minors available to 1048448 to handle new huge-cpu systems.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (10):
      dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries
      misc: fastrpc: Rename audio protection domain to root
      misc: fastrpc: Add reserved mem support
      misc: fastrpc: Add fastrpc_remote_heap_alloc
      misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
      misc: fastrpc: Rework fastrpc_req_munmap
      misc: fastrpc: Add support for audiopd
      misc: fastrpc: Safekeep mmaps on interrupted invoke
      misc: fastrpc: Add mmap request assigning for static PD pool
      misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

Aidan MacDonald (1):
      extcon: max77843: Replace irqchip mask_invert with unmask_base

Alejandro Concepción Rodríguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Alexander Usyskin (2):
      mei: add timeout to send
      mei: bus-fixup: change pxp mode only if message was sent

Andra Paraschiv (1):
      MAINTAINERS: Update entries from the Nitro Enclaves section

Andy Shevchenko (1):
      virt: acrn: Mark the uuid field as unused

Angel Iglesias (2):
      i2c: core: Introduce i2c_client_get_device_id helper function
      iio: pressure: bmp280: convert to i2c's .probe_new()

Antoniu Miclaus (2):
      dt-bindings: iio: frequency: add adf4377 doc
      iio: frequency: adf4377: add support for ADF4377

Bagas Sanjaya (1):
      Documentation: ad4130: format list of in_voltage-voltage_filter_mode_available modes

Bharat Jauhari (1):
      habanalabs: use lower_32_bits()

Billy Tsai (2):
      iio: adc: aspeed: Remove the trim valid dts property.
      dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid"

Bjorn Andersson (6):
      interconnect: qcom: osm-l3: Use platform-independent node ids
      interconnect: qcom: osm-l3: Squash common descriptors
      interconnect: qcom: osm-l3: Add per-core EPSS L3 support
      interconnect: qcom: osm-l3: Simplify osm_l3_set()
      dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon instances

Bo Liu (1):
      misc: genwqe: card_base: Fix some kernel-doc warnings

Chen Zhongjin (1):
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() fails

ChiaEn Wu (1):
      iio: adc: mt6370: Add MediaTek MT6370 support

Christophe JAILLET (1):
      greybus: svc: Use kstrtobool() instead of strtobool()

Christophe Leroy (2):
      virt: fsl_hypervisor: Replace NO_IRQ by 0
      uio: uio_fsl_elbc_gpcm: Replace NO_IRQ by 0

Colin Ian King (3):
      test_firmware: Fix spelling mistake "EMTPY" -> "EMPTY"
      nvmem: Kconfig: Fix spelling mistake "controlls" -> "controls"
      iio: adc: ad4130: Fix spelling mistake "diffreential" -> "differential"

Cosmin Tanislav (22):
      dt-bindings: iio: adc: add AD4130
      iio: adc: ad4130: add AD4130 driver
      iio: temperature: ltc2983: make bulk write buffer DMA-safe
      dt-bindings: iio: temperature: ltc2983: add default values
      dt-bindings: iio: temperature: ltc2983: use hex for sensor address
      dt-bindings: iio: temperature: ltc2983: remove qutations from phandle ref
      dt-bindings: iio: temperature: ltc2983: describe matrix items
      dt-bindings: iio: temperature: ltc2983: require custom sensor tables
      dt-bindings: iio: temperature: ltc2983: require 4 wire rtd for current rotate
      dt-bindings: iio: temperature: ltc2983: change default excitation for custom thermistors
      dt-bindings: iio: temperature: ltc2983: refine descriptions
      dt-bindings: iio: temperature: ltc2983: describe broken mux delay property
      dt-bindings: iio: temperature: ltc2983: use generic node name in example
      dt-bindings: iio: temperature: ltc2983: support more parts
      iio: temperature: ltc2983: support more parts
      iio: adc: ad4130: depend on GPIOLIB
      dt-bindings: iio: addac: add AD74115
      iio: addac: add AD74115 driver
      dt-bindings: iio: temperature: ltc2983: drop $ref for -nanoamp properties
      dt-bindings: iio: adc: ad4130: use spi-peripheral-props.yaml
      iio: addac: ad74115: remove unused ad74115_dac_slew_rate_hz_tbl
      iio: addac: ad74413r: fix blank line after declaration warning

Crt Mori (4):
      iio: temperature: mlx90632 Add runtime powermanagement modes
      iio: temperature: mlx90632 Read sampling frequency
      iio: temperature: mlx90632 Change return value of sensor measurement channel
      iio: temperature: mlx90632 Style alignment for the driver

Cédric Le Goater (1):
      virtio_console: Introduce an ID allocator for virtual console numbers

D Scott Phillips (1):
      char: misc: Increase the maximum number of dynamic misc devices to 1048448

Dafna Hirschfeld (2):
      habanalabs: replace 'pf' to 'prefetch'
      habanalabs: add RMWREG32_SHIFTED to set a val within a mask

Dani Liberman (11):
      habanalabs: refactor razwi event notification
      habanalabs: add page fault info uapi
      habanalabs: handle HBM MMU when capturing page fault data
      habanalabs/gaudi2: capture RAZWI information
      habanalabs/gaudi2: capture page fault data
      habanalabs: fix user mappings calculation in case of page fault
      habanalabs/gaudi: add razwi notify event
      habanalabs: use single threaded WQ for event handling
      habanalabs/gaudi: add page fault notify event
      habanalabs/gaudi2: add razwi notify event
      habanalabs/gaudi2: add page fault notify event

David Collins (1):
      spmi: pmic-arb: Add support for PMIC v7

Deepak R Varma (2):
      staging: iio: frequency: ad9834: merge unnecessary split lines
      staging: iio: meter: replace ternary operator by if condition

Dilip Puri (1):
      habanalabs/gaudi2: unsecure CBU_EARLY_BRESP registers

Dong Chenchen (1):
      iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()

Edmund Berenson (1):
      dt-bindings: iio: adc: ad7923: adjust documentation

Eli Billauer (2):
      char: xillybus: Prevent use-after-free due to race condition
      char: xillybus: Fix trivial bug with mutex

Fabio Porcedda (1):
      bus: mhi: host: pci_generic: Add a secondary AT port to Telit FN990

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: fix the check on arr and cmp registers update

Georgi Djakov (1):
      Merge branch 'icc-sc8280xp-l3' into icc-next

Greg Kroah-Hartman (12):
      Revert "drivers: bus: simple-pm-bus: Use clocks"
      Merge 6.1-rc6 into char-misc-next
      Merge tag 'fpga-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'mhi-for-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'iio-for-6.2a-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'iio-for-6.2b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'iio-fixes-for-6.1d' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'counter-fixes-for-6.1b' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'misc-habanalabs-next-2022-11-23' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'coresight-next-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'icc-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'extcon-next-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next

Gwendal Grignou (1):
      iio: proximity: sx9360: Add a new ACPI hardware ID

Ibrahim Tilki (4):
      iio: adc: add max11410 adc driver
      dt-bindings: iio: adc: add adi,max11410.yaml
      Documentation: ABI: testing: add max11410 doc
      iio: adc: max11410: fix incomplete vref buffer mask

Ivan Bornyakov (2):
      fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
      dt-bindings: fpga: document Lattice sysCONFIG FPGA manager

Jack Rosenthal (1):
      firmware: google: Implement cbmem in sysfs driver

Jagan Teki (1):
      dt-bindings: iio: adc: rockchip-saradc: Add saradc for rv1126

Jay Greco (2):
      iio: imu: inv_icm42600: Add support for icm42631
      dt-bindings: iio: imu: Add inv_icm42600 documentation

Jiangshan Yi (1):
      nvmem: stm32: fix spelling typo in comment

Jilin Yuan (1):
      coresight: etm4x: fix repeated words in comments

Johan Hovold (1):
      bus: mhi: host: pci_generic: add support for sc8280xp-crd SDX55 variant

Jonathan Cameron (23):
      iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
      iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
      iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
      iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
      iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
      iio: accel: fxls8962af: Use devm_regulator_get_enable()
      iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
      iio: accel: msa311: Use devm_regulator_get_enable()
      iio: cdc: ad7150: Use devm_regulator_get_enable()
      iio: st_sensors: core and lsm9ds0 switch to devm_regulator_bulk_get_enable()
      iio: frequency: ad9523: Use devm_regulator_get_enable()
      iio: humidity: hts211: Use devm_regulator_get_enable()
      iio: light: ltr501: Use devm_regulator_bulk_get_enable()
      iio: light: noa1305: Use devm_regulator_get_enable()
      iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
      iio: adc: cc10001: Add local struct device *dev variable to avoid repitition
      iio: adc: cc10001: Add devm_add_action_or_reset() to disable regulator.
      iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
      iio: adc: cc10001: Use devm_ to call device power down.
      iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms.
      iio: temperature: mlx90632: Add error handling for devm_pm_runtime_enable()
      iio: temperature: mlx90632: Add missing static marking on devm_pm_ops
      Merge remote-tracking branch 'i2c/i2c/client_device_id_helper-immutable' into togreg

Koby Elbaz (1):
      habanalabs/gaudi2: remove privileged MME clock configuration

Krzysztof Kozlowski (26):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible
      interconnect: qcom: sc7180: fix dropped const of qcom_icc_bcm
      interconnect: qcom: sc7180: drop double space
      interconnect: qcom: sc8180x: constify pointer to qcom_icc_node
      slimbus: qcom-ngd-ctrl: check for device runtime PM status during ISR
      slimbus: qcom-ngd-ctrl: drop PM runtime counter on transfer error paths
      slimbus: stream: handle unsupported bitrates for presence rate
      slimbus: qcom-ngd-ctrl: add support for 44.1 Khz frequency
      slimbus: stream: add checks for invalid unprepare/disable usage
      slimbus: qcom-ctrl: drop unneeded qcom,apq8064-slim compatible
      slimbus: qcom-ctrl: use devm_platform_ioremap_resource_byname()
      slimbus: qcom-ngd-ctrl: use devm_platform_get_and_ioremap_resource()
      slimbus: qcom-ngd-ctrl: reinit the reconf completion flag
      dt-bindings: slimbus: convert bus description to DT schema
      dt-bindings: slimbus: qcom,slim: convert to DT schema
      dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema
      dt-bindings: iio: addac: adi,ad74413r: use spi-peripheral-props.yaml
      dt-bindings: iio: addac: adi,ad74413r: improve example
      dt-bindings: iio: frequency: use spi-peripheral-props.yaml
      dt-bindings: iio: gyroscope: use spi-peripheral-props.yaml
      dt-bindings: iio: imu: adi,adis16475: use spi-peripheral-props.yaml
      dt-bindings: iio: pressure: use spi-peripheral-props.yaml
      dt-bindings: iio: proximity: ams,as3935: use spi-peripheral-props.yaml
      dt-bindings: iio: resolver: adi,ad2s90: use spi-peripheral-props.yaml
      dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
      dt-bindings: iio: adc: qcom,spmi-vadc: extend example

Lad Prabhakar (1):
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/Five SoC

Liu Ying (2):
      drivers: bus: simple-pm-bus: Use clocks
      dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

Lorenzo Bianconi (11):
      iio: imu: st_lsm6dsx: introduce st_lsm6dsx_device_set_enable routine
      iio: imu: st_lsm6dsx: introduce sw trigger support
      iio: imu: st_lsm6dsx: add support to LSM6DSV
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv device bindings
      iio: imu: st_lsm6dsx: add support to LSM6DSV16X
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x
      iio: imu: st_lsm6dsx: fix LSM6DSV sensor description
      iio: imu: st_lsm6dsx: add support to LSM6DSO16IS
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is
      iio: imu: st_lsm6dsx: add support to ISM330IS
      dt-bindings: iio: imu: st_lsm6dsx: add ism330is

Luca Weiss (1):
      dt-bindings: iio/adc: qcom,spmi-iadc: use double compatibles

Manivannan Sadhasivam (1):
      MAINTAINERS: Remove Hemant from MHI bus

Marco Pagani (2):
      habanalabs: added return value check for hl_fw_dynamic_send_clear_cmd()
      habanalabs/gaudi2: added memset for the cq_size register

Marcus Folkesson (1):
      iio: adc: mcp3911: add support to set PGA

Matti Vaittinen (18):
      iio: adc: ad7192: Simplify using devm_regulator_get_enable()
      iio: dac: ltc2688: Simplify using devm_regulator_*get_enable()
      iio: gyro: bmg160_core: Simplify using devm_regulator_*get_enable()
      iio: imu: st_lsm6dsx: Simplify using devm_regulator_*get_enable()
      iio: adc: ad7476: simplify using devm_regulator_get_enable()
      iio: adc: ad7606: simplify using devm_regulator_get_enable()
      iio: adc: max1241: simplify using devm_regulator_get_enable()
      iio: adc: max1363: simplify using devm_regulator_get_enable()
      iio: amplifier: hmc425a: simplify using devm_regulator_get_enable()
      dt-bindings: iio: Add KX022A accelerometer
      iio: accel: Support Kionix/ROHM KX022A accelerometer
      MAINTAINERS: Add KX022A maintainer entry
      iio: Add IIO_STATIC_CONST_DEVICE_ATTR
      iio: adxl367: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: adxl372: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: bmc150-accel-core: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: at91-sama5d2_adc: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: Don't silently expect attribute types

Michael Walle (1):
      dt-bindings: nvmem: add YAML schema for the sl28 vpd layout

Mike Leach (1):
      coresight: cti: Fix null pointer error on CTI init before ETM

Minghao Chi (1):
      iio: use devm_platform_get_and_ioremap_resource()

Miquel Raynal (5):
      dt-bindings: nvmem: Fix example
      dt-bindings: nvmem: Introduce the nvmem-layout container
      dt-bindings: eeprom: Inherit from nvmem.yaml
      dt-bindings: vendor-prefixes: Add ONIE
      dt-bindings: nvmem: add YAML schema for the ONIE tlv layout

Mitja Spes (1):
      dt-bindings: iio: pressure: meas,ms5611: add max SPI frequency to the example

Mushahid Hussain (2):
      accessibility: speakup: Specify spk_vars among module parameters
      accessibility: speakup: phonetic spelling while arrowing letter by letter

Mårten Lindahl (2):
      iio: light: vcnl4000: Preserve conf bits when toggle power
      iio: light: vcnl4000: Add ps_it attributes for vcnl4040

Nuno Sá (19):
      iio: adc: ad_sigma_delta: do not use internal iio_dev lock
      iio: adc: ad799x: do not use internal iio_dev lock
      iio: adc: axp288_adc: do not use internal iio_dev lock
      iio: adc: imx7d_adc: do not use internal iio_dev lock
      iio: adc: lpc32xx_adc: do not use internal iio_dev lock
      iio: adc: ltc2947-core: do not use internal iio_dev lock
      iio: adc: meson_saradc: do not use internal iio_dev lock
      iio: adc: rockchip_saradc: do not use internal iio_dev lock
      iio: adc: sc27xx_adc: do not use internal iio_dev lock
      iio: adc: vf610_adc: add helper function to read samples
      iio: adc: vf610_adc: vf610_adc: do not use internal iio_dev lock
      iio: common: scmi_iio: do not use internal iio_dev lock
      iio: gyro: itg3200_core: do not use internal iio_dev lock
      dt-bindings: iio: dac: change ad5766 maintainer
      dt-bindings: iio: frequency: change admv4420 maintainer
      iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
      iio: health: max30100: do not use internal iio_dev lock
      iio: health: max30102: do not use internal iio_dev lock
      iio: core: move 'mlock' to 'struct iio_dev_opaque'

Oded Gabbay (3):
      habanalabs: Use simplified API for p2p dist calc
      habanalabs: check schedule_hard_reset correctly
      habanalabs: extend process wait timeout in device fine

Ofir Bitton (7):
      habanalabs: allow control device open during reset
      habanalabs: add warning print upon a PCI error
      habanalabs: remove redundant gaudi2_sec asic type
      habanalabs/gaudi2: add PCI revision 2 support
      habanalabs/gaudi2: implement fp32 not supported event
      habanalabs/gaudi2: classify power/thermal events as info
      habanalabs: fail driver load if EEPROM errors detected

Ohad Sharabi (5):
      habanalabs: fix using freed pointer
      habanalabs: allow setting HBM BAR to other regions
      habanalabs: avoid divide by zero in device utilization
      habanalabs: skip events info ioctl if not supported
      habanalabs: fix VA range calculation

Olivier Moysan (6):
      dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
      iio: adc: stm32-adc: add stm32mp13 support
      iio: adc: stm32: manage min sampling time on all internal channels
      iio: adc: stm32-adc: smart calibration support
      iio: adc: stm32-adc: improve calibration error log
      iio: adc: stm32-adc: add debugfs to read raw calibration result

Osama Muhammad (15):
      Accessiblity: speakup_soft: specifying the default driver parameters among the module params
      Accessiblity: speakup_apollo: specifying the default driver parameters among the module params
      Accessiblity: speakup_audptr: specifying the default driver parameters among the module params
      Accessiblity: speakup_bns: specifying the default driver parameters among the module params
      Accessiblity: speakup_decext: specifying the default driver parameters among the module params
      Accessiblity: speakup_decpc: specifying the default driver parameters among the module params
      Accessiblity: speakup_dectlk: specifying the default driver parameters among the module params
      Accessiblity: speakup_dtlk: specifying the default driver parameters among the module params
      Accessiblity: speakup_dummy: specifying the default driver parameters among the module params
      Accessiblity: speakup_keypc: specifying the default driver parameters among the module params
      Accessiblity: speakup_ltlk: specifying the default driver parameters among the module params
      Accessiblity: speakup_spkout: specifying the default driver parameters among the module params
      Accessiblity: speakup_txprt: specifying the default driver parameters among the module params
      Accessiblity: speakup_acntpc: specifying the default driver parameters among the module params
      Accessiblity: speakup_acntsa: specifying the default driver parameters among the module params

Patrick Delaunay (4):
      nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
      nvmem: stm32: add warning when upper OTPs are updated
      nvmem: stm32: add nvmem type attribute
      dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Peng Wu (1):
      firmware: google: fix a NULL vs IS_ERR() check in cbmem_entry_probe()

Qiang Yu (2):
      bus: mhi: host: Use mhi_soc_reset() API in place of register write
      bus: mhi: host: Fix race between channel preparation and M0 event

Quan Nguyen (2):
      misc: smpro-errmon: Add Ampere's SMpro error monitor driver
      misc: smpro-misc: Add Ampere's Altra SMpro misc driver

Rafael Mendonca (3):
      uio: uio_dmem_genirq: Fix missing unlock in irq configuration
      uio: uio_dmem_genirq: Fix deadlock between irq config and handling
      uio: uio_dmem_genirq: Use non-atomic bit operations in irq config and handling

Rafał Miłecki (1):
      nvmem: u-boot-env: add Broadcom format support

Rajat Khandelwal (2):
      iio: pressure: mpl115: Implementing low power mode by shutdown gpio
      iio: temperature: Add driver support for Maxim MAX30208

Ramona Bolboaca (12):
      drivers: iio: accel: Use warning if invalid device id is detected
      dt-bindings: iio: accel: Add docs for ADXL359
      drivers: iio: accel: Add support for ADXL359 device
      iio: adis: add '__adis_enable_irq()' implementation
      iio: accel: adis16201: Call '__adis_initial_startup()' in probe
      iio: accel: adis16209: Call '__adis_initial_startup()' in probe
      iio: gyro: adis16136: Call '__adis_initial_startup()' in probe
      iio: gyro: adis16260: Call '__adis_initial_startup()' in probe
      iio: imu: adis16400: Call '__adis_initial_startup()' in probe
      staging: iio: accel: adis16203: Call '__adis_initial_startup()'
      staging: iio: accel: adis16240: Call '__adis_initial_startup()'
      iio: imu: adis: Remove adis_initial_startup function

Rasmus Villemoes (5):
      iio: addac: ad74413r: fix integer promotion bug in ad74413_get_input_current_offset()
      iio: addac: ad74413r: add spi_device_id table
      dt-bindings: iio: ad74413r: add optional reset-gpios
      iio: addac: ad74413r: add support for reset-gpio
      iio: adc128s052: add proper .data members in adc128_of_match table

Rob Herring (1):
      dt-bindings: iio: dac: adi,ad5758: Drop 'contains' from 'adi,dc-dc-mode'

Samuel Thibault (1):
      speakup: Fix building as extmod

Shang XiaoJing (2):
      chardev: Fix potential memory leak when cdev_add() failed
      interconnect: qcom: icc-rpm: Remove redundant dev_err call

Slark Xiao (1):
      bus: mhi: host: pci_generic: Add definition for some VIDs

Song Fuchang (1):
      bus: mhi: host: pci_generic: Add HP variant of T99W175

Subhajit Ghosh (1):
      iio: light: apds9960: Fix iio_event_spec structures

Tal Cohen (3):
      habanalabs/gaudi2: add device unavailable notification
      habanalabs: verify no zero event is sent
      habanalabs: no consecutive err when user context is enabled

Tamas Zsoldos (1):
      coresight: etm4x: add CPU hotplug support for probing

Tomer Tayar (22):
      habanalabs/gaudi2: fix module ID for RAZWI handling
      habanalabs: skip idle status check if reset on device release
      habanalabs: allow unregistering eventfd when device non-operational
      habanalabs: move reset workqueue to be under hl_device
      habanalabs/gaudi2: remove configurations to access the MSI-X doorbell
      habanalabs: add support for graceful hard reset
      habanalabs: add an option to control watchdog timeout via debugfs
      habanalabs/gaudi: use graceful hard reset for F/W events
      habanalabs/gaudi2: use graceful hard reset for F/W events
      habanalabs: use graceful hard reset for CS timeouts
      habanalabs: fix PCIe access to SRAM via debugfs
      habanalabs: fix print for out-of-sync and pkt-failure events
      habanalabs/gaudi: fix print for firmware-alive event
      habanalabs/gaudi2: don't enable entries in the MSIX_GW table
      habanalabs/gaudi2: return to reset upon SM SEI BRESP error
      habanalabs: reset device if still in use when released
      habanalabs: increase the size of busy engines mask
      habanalabs: fix rc when new CPUCP opcodes are not supported
      habanalabs: print context refcount value if hard reset fails
      habanalabs: don't put context in hl_encaps_handle_do_release_sob()
      habanalabs: clear non-released encapsulated signals
      habanalabs: make print of engines idle mask more readable

Uwe Kleine-König (173):
      misc: lis3lv02d/lis3lv02d_i2c: Convert to i2c's .probe_new()
      misc: eeprom/eeprom: Convert to i2c's .probe_new()
      misc: tsl2550: Convert to i2c's .probe_new()
      misc: isl29020: Convert to i2c's .probe_new()
      misc: eeprom/max6875: Convert to i2c's .probe_new()
      misc: hmc6352: Convert to i2c's .probe_new()
      misc: ics932s401: Convert to i2c's .probe_new()
      misc: isl29003: Convert to i2c's .probe_new()
      misc: eeprom/idt_89hpesx: Convert to i2c's .probe_new()
      misc: apds990x: Convert to i2c's .probe_new()
      misc: apds9802als: Convert to i2c's .probe_new()
      misc: bh1770glc: Convert to i2c's .probe_new()
      misc: ds1682: Convert to i2c's .probe_new()
      iio: accel: adxl367: Convert to i2c's .probe_new()
      iio: accel: da311: Convert to i2c's .probe_new()
      iio: accel: dmard06: Convert to i2c's .probe_new()
      iio: accel: dmard09: Convert to i2c's .probe_new()
      iio: accel: dmard10: Convert to i2c's .probe_new()
      iio: accel: kxsd9: Convert to i2c's .probe_new()
      iio: accel: mc3230: Convert to i2c's .probe_new()
      iio: accel: mma7660: Convert to i2c's .probe_new()
      iio: accel: mxc4005: Convert to i2c's .probe_new()
      iio: accel: mxc6255: Convert to i2c's .probe_new()
      iio: accel: stk8312: Convert to i2c's .probe_new()
      iio: accel: stk8ba50: Convert to i2c's .probe_new()
      iio: accel: st_magn: Convert to i2c's .probe_new()
      iio: accel: vl6180: Convert to i2c's .probe_new()
      iio: accel: adxl372_i2c: Convert to i2c's .probe_new()
      iio: accel: bma180: Convert to i2c's .probe_new()
      iio: accel: bma400: Convert to i2c's .probe_new()
      iio: accel: bmc150: Convert to i2c's .probe_new()
      iio: accel: da280: Convert to i2c's .probe_new()
      iio: accel: kxcjk-1013: Convert to i2c's .probe_new()
      iio: accel: mma7455_i2c: Convert to i2c's .probe_new()
      iio: accel: mma8452: Convert to i2c's .probe_new()
      iio: accel: mma9551: Convert to i2c's .probe_new()
      iio: accel: mma9553: Convert to i2c's .probe_new()
      iio: adc: ad7091r5: Convert to i2c's .probe_new()
      iio: adc: ad7291: Convert to i2c's .probe_new()
      iio: adc: ad799x: Convert to i2c's .probe_new()
      iio: adc: ina2xx-adc: Convert to i2c's .probe_new()
      iio: adc: ltc2471: Convert to i2c's .probe_new()
      iio: adc: ltc2485: Convert to i2c's .probe_new()
      iio: adc: ltc2497: Convert to i2c's .probe_new()
      iio: adc: max1363: Convert to i2c's .probe_new()
      iio: adc: max9611: Convert to i2c's .probe_new()
      iio: adc: mcp3422: Convert to i2c's .probe_new()
      iio: adc: ti-adc081c: Convert to i2c's .probe_new()
      iio: adc: ti-ads1015: Convert to i2c's .probe_new()
      iio: cdc: ad7150: Convert to i2c's .probe_new()
      iio: cdc: ad7746: Convert to i2c's .probe_new()
      iio: chemical: ams-iaq-core: Convert to i2c's .probe_new()
      iio: chemical: atlas-ezo-sensor: Convert to i2c's .probe_new()
      iio: chemical: atlas-sensor: Convert to i2c's .probe_new()
      iio: chemical: bme680_i2c: Convert to i2c's .probe_new()
      iio: chemical: ccs811: Convert to i2c's .probe_new()
      iio: chemical: scd4x: Convert to i2c's .probe_new()
      iio: chemical: sgp30: Convert to i2c's .probe_new()
      iio: chemical: sgp40: Convert to i2c's .probe_new()
      iio: chemical: vz89x: Convert to i2c's .probe_new()
      iio: dac: ad5064: Convert to i2c's .probe_new()
      iio: dac: ad5380: Convert to i2c's .probe_new()
      iio: dac: ad5446: Convert to i2c's .probe_new()
      iio: dac: ad5593r: Convert to i2c's .probe_new()
      iio: dac: ad5696-i2c: Convert to i2c's .probe_new()
      iio: dac: ds4424: Convert to i2c's .probe_new()
      iio: dac: m62332: Convert to i2c's .probe_new()
      iio: dac: max517: Convert to i2c's .probe_new()
      iio: dac: max5821: Convert to i2c's .probe_new()
      iio: dac: mcp4725: Convert to i2c's .probe_new()
      iio: dac: ti-dac5571: Convert to i2c's .probe_new()
      iio: gyro: bmg160_i2c: Convert to i2c's .probe_new()
      iio: gyro: itg3200_core: Convert to i2c's .probe_new()
      iio: gyro: mpu3050-i2c: Convert to i2c's .probe_new()
      iio: gyro: st_gyro_i2c: Convert to i2c's .probe_new()
      iio: health: afe4404: Convert to i2c's .probe_new()
      iio: health: max30100: Convert to i2c's .probe_new()
      iio: health: max30102: Convert to i2c's .probe_new()
      iio: humidity: am2315: Convert to i2c's .probe_new()
      iio: humidity: hdc100x: Convert to i2c's .probe_new()
      iio: humidity: hdc2010: Convert to i2c's .probe_new()
      iio: humidity: hts221_i2c: Convert to i2c's .probe_new()
      iio: humidity: htu21: Convert to i2c's .probe_new()
      iio: humidity: si7005: Convert to i2c's .probe_new()
      iio: humidity: si7020: Convert to i2c's .probe_new()
      iio: imu: bmi160/bmi160_i2c: Convert to i2c's .probe_new()
      iio: imu: fxos8700_i2c: Convert to i2c's .probe_new()
      iio: imu: inv_mpu6050: Convert to i2c's .probe_new()
      iio: imu: kmx61: Convert to i2c's .probe_new()
      iio: imu: st_lsm6dsx: Convert to i2c's .probe_new()
      iio: light: adjd_s311: Convert to i2c's .probe_new()
      iio: light: adux1020: Convert to i2c's .probe_new()
      iio: light: al3010: Convert to i2c's .probe_new()
      iio: light: al3320a: Convert to i2c's .probe_new()
      iio: light: apds9300: Convert to i2c's .probe_new()
      iio: light: apds9960: Convert to i2c's .probe_new()
      iio: light: bh1750: Convert to i2c's .probe_new()
      iio: light: bh1780: Convert to i2c's .probe_new()
      iio: light: cm3232: Convert to i2c's .probe_new()
      iio: light: cm3323: Convert to i2c's .probe_new()
      iio: light: cm36651: Convert to i2c's .probe_new()
      iio: light: gp2ap002: Convert to i2c's .probe_new()
      iio: light: gp2ap020a00f: Convert to i2c's .probe_new()
      iio: light: isl29018: Convert to i2c's .probe_new()
      iio: light: isl29028: Convert to i2c's .probe_new()
      iio: light: isl29125: Convert to i2c's .probe_new()
      iio: light: jsa1212: Convert to i2c's .probe_new()
      iio: light: ltr501: Convert to i2c's .probe_new()
      iio: light: lv0104cs: Convert to i2c's .probe_new()
      iio: light: max44000: Convert to i2c's .probe_new()
      iio: light: noa1305: Convert to i2c's .probe_new()
      iio: light: opt3001: Convert to i2c's .probe_new()
      iio: light: pa12203001: Convert to i2c's .probe_new()
      iio: light: rpr0521: Convert to i2c's .probe_new()
      iio: light: si1133: Convert to i2c's .probe_new()
      iio: light: si1145: Convert to i2c's .probe_new()
      iio: light: st_uvis25_i2c: Convert to i2c's .probe_new()
      iio: light: stk3310: Convert to i2c's .probe_new()
      iio: light: tcs3414: Convert to i2c's .probe_new()
      iio: light: tcs3472: Convert to i2c's .probe_new()
      iio: light: tsl2563: Convert to i2c's .probe_new()
      iio: light: tsl2583: Convert to i2c's .probe_new()
      iio: light: tsl2772: Convert to i2c's .probe_new()
      iio: light: tsl4531: Convert to i2c's .probe_new()
      iio: light: us5182d: Convert to i2c's .probe_new()
      iio: light: vcnl4000: Convert to i2c's .probe_new()
      iio: light: vcnl4035: Convert to i2c's .probe_new()
      iio: light: veml6030: Convert to i2c's .probe_new()
      iio: light: veml6070: Convert to i2c's .probe_new()
      iio: light: zopt2201: Convert to i2c's .probe_new()
      iio: magnetometer: ak8974: Convert to i2c's .probe_new()
      iio: magnetometer: ak8975: Convert to i2c's .probe_new()
      iio: magnetometer: bmc150_magn_i2c: Convert to i2c's .probe_new()
      iio: magnetometer: hmc5843: Convert to i2c's .probe_new()
      iio: magnetometer: mag3110: Convert to i2c's .probe_new()
      iio: magnetometer: mmc35240: Convert to i2c's .probe_new()
      iio: magnetometer: yamaha-yas530: Convert to i2c's .probe_new()
      iio: potentiometer: ad5272: Convert to i2c's .probe_new()
      iio: potentiometer: ds1803: Convert to i2c's .probe_new()
      iio: potentiometer: max5432: Convert to i2c's .probe_new()
      iio: potentiometer: tpl0102: Convert to i2c's .probe_new()
      iio: potentiostat: lmp91000: Convert to i2c's .probe_new()
      iio: pressure: abp060mg: Convert to i2c's .probe_new()
      iio: pressure: dlhl60d: Convert to i2c's .probe_new()
      iio: pressure: dps310: Convert to i2c's .probe_new()
      iio: pressure: hp03: Convert to i2c's .probe_new()
      iio: pressure: hp206c: Convert to i2c's .probe_new()
      iio: pressure: icp10100: Convert to i2c's .probe_new()
      iio: pressure: mpl115_i2c: Convert to i2c's .probe_new()
      iio: pressure: mpl3115: Convert to i2c's .probe_new()
      iio: pressure: ms5611_i2c: Convert to i2c's .probe_new()
      iio: pressure: ms5637: Convert to i2c's .probe_new()
      iio: pressure: st_pressure_i2c: Convert to i2c's .probe_new()
      iio: pressure: t5403: Convert to i2c's .probe_new()
      iio: pressure: zpa2326_i2c: Convert to i2c's .probe_new()
      iio: proximity: isl29501: Convert to i2c's .probe_new()
      iio: proximity: mb1232: Convert to i2c's .probe_new()
      iio: proximity: pulsedlight-lidar-lite-v2: Convert to i2c's .probe_new()
      iio: proximity: rfd77402: Convert to i2c's .probe_new()
      iio: proximity: srf08: Convert to i2c's .probe_new()
      iio: proximity: sx9500: Convert to i2c's .probe_new()
      iio: temperature: mlx90614: Convert to i2c's .probe_new()
      iio: temperature: mlx90632: Convert to i2c's .probe_new()
      iio: temperature: tmp006: Convert to i2c's .probe_new()
      iio: temperature: tmp007: Convert to i2c's .probe_new()
      iio: temperature: tsys01: Convert to i2c's .probe_new()
      iio: temperature: tsys02d: Convert to i2c's .probe_new()
      staging: iio: adt7316: Convert to i2c's .probe_new()
      staging: iio: ad5933: Convert to i2c's .probe_new()
      staging: iio: ade7854: Convert to i2c's .probe_new()
      extcon: fsa9480: Convert to i2c's .probe_new()
      extcon: rt8973: Convert to i2c's .probe_new()
      extcon: usbc-tusb320: Convert to i2c's .probe_new()

Vinod Koul (1):
      dt-bindings: spmi: Add qcom,bus-id

Wei Yongjun (8):
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw
      iio: filter: admv8818: close potential out-of-bounds read in __admv8818_read_[h|l]pf_freq()
      iio: adc: ti-ads131e08: Silence no spi_device_id warnings
      iio: accel: sca3300: Silence no spi_device_id warning
      iio: adc: ad9467: Silence no spi_device_id warnings
      iio: adc: ad7192: Silence no spi_device_id warnings
      iio: adc: ad7124: Silence no spi_device_id warnings

Yang Shen (1):
      coresight: trbe: remove cpuhp instance node before remove cpuhp state

Yang Yingliang (12):
      fpga: zynq: Switch to use dev_err_probe() helper
      drivers: dio: fix possible memory leak in dio_init()
      habanalabs: fix return value check in hl_fw_get_sec_attest_data()
      misc: ocxl: fix possible name leak in ocxl_file_register_afu()
      ocxl: fix pci device refcount leak when calling get_function_0()
      firmware: raspberrypi: fix possible memory leak in rpi_firmware_probe()
      cxl: fix possible null-ptr-deref in cxl_guest_init_afu|adapter()
      cxl: fix possible null-ptr-deref in cxl_pci_init_afu|adapter()
      iio: multiplexer: Switch to use dev_err_probe() helper
      iio: trigger: sysfs: rename error label in iio_sysfs_trigger_probe()
      mcb: mcb-parse: fix error handing in chameleon_parse_gdd()
      chardev: fix error handling in cdev_device_add()

Yuan Can (1):
      iio: accel: bma400: Switch to use dev_err_probe() helper

Yuma Ueda (1):
      scripts/kallsyms.c Make the comment up-to-date with current implementation

Zeng Heng (1):
      iio: fix memory leak in iio_device_register_eventset()

Zheng Wang (1):
      misc: sgi-gru: fix use-after-free error in gru_set_context_option, gru_fault and gru_handle_user_call_os

Zhengchao Shao (2):
      test_firmware: fix memory leak in test_firmware_init()
      drivers: mcb: fix resource leak in mcb_probe()

farah kassabri (4):
      habanalabs: zero ts registration buff when allocated
      habanalabs: fix firmware descriptor copy operation
      habanalabs/gaudi2: remove redundant firmware version check
      habanalabs/gaudi2: change memory scrub mechanism

ruanjinjie (1):
      misc: tifm: fix possible memory leak in tifm_7xx1_switch_media()

 Documentation/ABI/stable/sysfs-driver-speakup      |    9 +
 .../ABI/testing/debugfs-driver-habanalabs          |    7 +
 Documentation/ABI/testing/sysfs-bus-coreboot       |   45 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |   46 +
 .../ABI/testing/sysfs-bus-iio-adc-max11410         |   13 +
 .../sysfs-bus-platform-devices-ampere-smpro        |  312 +++
 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml        |  232 +++
 Documentation/devicetree/bindings/eeprom/at24.yaml |    5 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml |    1 +
 .../bindings/eeprom/microchip,93lc46b.yaml         |    1 +
 .../bindings/fpga/lattice,sysconfig.yaml           |   81 +
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    8 +-
 .../bindings/iio/accel/kionix,kx022a.yaml          |   65 +
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |  262 +++
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |   26 +-
 .../devicetree/bindings/iio/adc/adi,max11410.yaml  |  177 ++
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       |    7 -
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |    7 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |  106 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |    2 +-
 .../bindings/iio/adc/rockchip-saradc.yaml          |    1 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   68 +-
 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  373 ++++
 .../bindings/iio/addac/adi,ad74413r.yaml           |   16 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |    3 +-
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |    2 +-
 .../bindings/iio/frequency/adi,adf4350.yaml        |    7 +-
 .../bindings/iio/frequency/adi,adf4377.yaml        |   92 +
 .../bindings/iio/frequency/adi,admv1013.yaml       |    5 +-
 .../bindings/iio/frequency/adi,admv1014.yaml       |    5 +-
 .../bindings/iio/frequency/adi,admv4420.yaml       |    8 +-
 .../bindings/iio/frequency/adi,adrf6780.yaml       |    5 +-
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |    5 +-
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |    5 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    3 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |    1 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    8 +
 .../bindings/iio/pressure/meas,ms5611.yaml         |    6 +-
 .../bindings/iio/pressure/murata,zpa2326.yaml      |    5 +-
 .../bindings/iio/proximity/ams,as3935.yaml         |    5 +-
 .../bindings/iio/resolver/adi,ad2s90.yaml          |    7 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  336 ++--
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    7 +-
 .../bindings/interconnect/qcom,osm-l3.yaml         |   24 +-
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |    2 +-
 .../bindings/nvmem/layouts/kontron,sl28-vpd.yaml   |   64 +
 .../bindings/nvmem/layouts/nvmem-layout.yaml       |   34 +
 .../bindings/nvmem/layouts/onie,tlv-layout.yaml    |  147 ++
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |    8 +
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    1 +
 Documentation/devicetree/bindings/slimbus/bus.txt  |   60 -
 .../devicetree/bindings/slimbus/qcom,slim-ngd.yaml |  120 ++
 .../devicetree/bindings/slimbus/qcom,slim.yaml     |   86 +
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 -
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |   39 -
 .../devicetree/bindings/slimbus/slimbus.yaml       |   95 +
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   10 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   41 +-
 drivers/accessibility/speakup/Makefile             |    4 +-
 drivers/accessibility/speakup/kobjects.c           |    3 +
 drivers/accessibility/speakup/main.c               |   72 +-
 drivers/accessibility/speakup/makemapdata.c        |    7 +-
 drivers/accessibility/speakup/speakup.h            |    1 +
 drivers/accessibility/speakup/speakup_acntpc.c     |   38 +-
 drivers/accessibility/speakup/speakup_acntsa.c     |   37 +-
 drivers/accessibility/speakup/speakup_apollo.c     |   46 +-
 drivers/accessibility/speakup/speakup_audptr.c     |   42 +-
 drivers/accessibility/speakup/speakup_bns.c        |   36 +-
 drivers/accessibility/speakup/speakup_decext.c     |   44 +-
 drivers/accessibility/speakup/speakup_decpc.c      |   48 +-
 drivers/accessibility/speakup/speakup_dectlk.c     |   45 +-
 drivers/accessibility/speakup/speakup_dtlk.c       |   50 +-
 drivers/accessibility/speakup/speakup_dummy.c      |   53 +-
 drivers/accessibility/speakup/speakup_keypc.c      |   29 +-
 drivers/accessibility/speakup/speakup_ltlk.c       |   53 +-
 drivers/accessibility/speakup/speakup_soft.c       |   59 +-
 drivers/accessibility/speakup/speakup_spkout.c     |   43 +-
 drivers/accessibility/speakup/speakup_txprt.c      |   45 +-
 drivers/accessibility/speakup/spk_types.h          |    2 +-
 drivers/accessibility/speakup/varhandlers.c        |    1 +
 drivers/bus/mhi/host/boot.c                        |    4 +-
 drivers/bus/mhi/host/pci_generic.c                 |   25 +-
 drivers/bus/mhi/host/pm.c                          |    3 +-
 drivers/char/misc.c                                |   41 +-
 drivers/char/virtio_console.c                      |   26 +-
 drivers/char/xillybus/xillybus_class.c             |    7 +-
 drivers/char/xillybus/xillyusb.c                   |   22 +-
 drivers/counter/stm32-lptimer-cnt.c                |    2 +-
 drivers/dio/dio.c                                  |    8 +
 drivers/extcon/extcon-fsa9480.c                    |    5 +-
 drivers/extcon/extcon-max77843.c                   |    3 +-
 drivers/extcon/extcon-rt8973a.c                    |    5 +-
 drivers/extcon/extcon-usbc-tusb320.c               |    5 +-
 drivers/firmware/google/Kconfig                    |   15 +
 drivers/firmware/google/Makefile                   |    3 +
 drivers/firmware/google/cbmem.c                    |  129 ++
 drivers/firmware/google/coreboot_table.c           |   11 +-
 drivers/firmware/google/coreboot_table.h           |   18 +
 drivers/firmware/raspberrypi.c                     |    1 +
 drivers/fpga/Kconfig                               |   11 +
 drivers/fpga/Makefile                              |    2 +
 drivers/fpga/lattice-sysconfig-spi.c               |  152 ++
 drivers/fpga/lattice-sysconfig.c                   |  397 ++++
 drivers/fpga/lattice-sysconfig.h                   |   39 +
 drivers/fpga/zynq-fpga.c                           |    8 +-
 drivers/greybus/svc.c                              |    3 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  155 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |    1 +
 drivers/i2c/i2c-core-base.c                        |   14 +
 drivers/iio/TODO                                   |    3 -
 drivers/iio/accel/Kconfig                          |   21 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adis16201.c                      |    2 +-
 drivers/iio/accel/adis16209.c                      |    2 +-
 drivers/iio/accel/adxl355.h                        |   20 +-
 drivers/iio/accel/adxl355_core.c                   |   93 +-
 drivers/iio/accel/adxl355_i2c.c                    |   22 +-
 drivers/iio/accel/adxl355_spi.c                    |   19 +-
 drivers/iio/accel/adxl367.c                        |   57 +-
 drivers/iio/accel/adxl367_i2c.c                    |    5 +-
 drivers/iio/accel/adxl372.c                        |   29 +-
 drivers/iio/accel/adxl372_i2c.c                    |    6 +-
 drivers/iio/accel/bma180.c                         |    6 +-
 drivers/iio/accel/bma400_core.c                    |   14 +-
 drivers/iio/accel/bma400_i2c.c                     |    6 +-
 drivers/iio/accel/bmc150-accel-core.c              |   31 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    6 +-
 drivers/iio/accel/da280.c                          |    6 +-
 drivers/iio/accel/da311.c                          |    5 +-
 drivers/iio/accel/dmard06.c                        |    5 +-
 drivers/iio/accel/dmard09.c                        |    5 +-
 drivers/iio/accel/dmard10.c                        |    5 +-
 drivers/iio/accel/fxls8962af-core.c                |   40 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    2 +-
 drivers/iio/accel/fxls8962af-spi.c                 |    2 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |   51 +
 drivers/iio/accel/kionix-kx022a-spi.c              |   58 +
 drivers/iio/accel/kionix-kx022a.c                  | 1142 +++++++++++
 drivers/iio/accel/kionix-kx022a.h                  |   82 +
 drivers/iio/accel/kxcjk-1013.c                     |   31 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    5 +-
 drivers/iio/accel/mc3230.c                         |    5 +-
 drivers/iio/accel/mma7455_i2c.c                    |    6 +-
 drivers/iio/accel/mma7660.c                        |    5 +-
 drivers/iio/accel/mma8452.c                        |    6 +-
 drivers/iio/accel/mma9551.c                        |    6 +-
 drivers/iio/accel/mma9553.c                        |    6 +-
 drivers/iio/accel/msa311.c                         |   21 +-
 drivers/iio/accel/mxc4005.c                        |    5 +-
 drivers/iio/accel/mxc6255.c                        |    5 +-
 drivers/iio/accel/sca3300.c                        |   12 +-
 drivers/iio/accel/stk8312.c                        |    5 +-
 drivers/iio/accel/stk8ba50.c                       |    5 +-
 drivers/iio/adc/Kconfig                            |   40 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad4130.c                           | 2100 ++++++++++++++++++++
 drivers/iio/adc/ad7091r5.c                         |    6 +-
 drivers/iio/adc/ad7124.c                           |   10 +
 drivers/iio/adc/ad7192.c                           |   27 +-
 drivers/iio/adc/ad7291.c                           |    6 +-
 drivers/iio/adc/ad7476.c                           |   11 +-
 drivers/iio/adc/ad7606.c                           |   22 +-
 drivers/iio/adc/ad7606.h                           |    2 -
 drivers/iio/adc/ad7606_par.c                       |    3 +-
 drivers/iio/adc/ad799x.c                           |   26 +-
 drivers/iio/adc/ad9467.c                           |   11 +
 drivers/iio/adc/ad_sigma_delta.c                   |    8 +-
 drivers/iio/adc/aspeed_adc.c                       |   11 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   33 +-
 drivers/iio/adc/axp288_adc.c                       |    9 +-
 drivers/iio/adc/cc10001_adc.c                      |   89 +-
 drivers/iio/adc/imx7d_adc.c                        |   14 +-
 drivers/iio/adc/ina2xx-adc.c                       |    6 +-
 drivers/iio/adc/lpc32xx_adc.c                      |   11 +-
 drivers/iio/adc/ltc2471.c                          |    6 +-
 drivers/iio/adc/ltc2485.c                          |    6 +-
 drivers/iio/adc/ltc2497-core.c                     |    7 +-
 drivers/iio/adc/ltc2497.c                          |    6 +-
 drivers/iio/adc/ltc2497.h                          |    2 +
 drivers/iio/adc/max11410.c                         | 1050 ++++++++++
 drivers/iio/adc/max1241.c                          |   28 +-
 drivers/iio/adc/max1363.c                          |   18 +-
 drivers/iio/adc/max9611.c                          |    5 +-
 drivers/iio/adc/mcp3422.c                          |    6 +-
 drivers/iio/adc/mcp3911.c                          |  104 +-
 drivers/iio/adc/meson_saradc.c                     |   11 +-
 drivers/iio/adc/mt6370-adc.c                       |  305 +++
 drivers/iio/adc/rockchip_saradc.c                  |   15 +-
 drivers/iio/adc/sc27xx_adc.c                       |   14 +-
 drivers/iio/adc/stm32-adc-core.c                   |   30 +-
 drivers/iio/adc/stm32-adc-core.h                   |   31 +
 drivers/iio/adc/stm32-adc.c                        |  307 ++-
 drivers/iio/adc/ti-adc081c.c                       |    6 +-
 drivers/iio/adc/ti-adc128s052.c                    |   14 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/adc/ti-ads131e08.c                     |   11 +
 drivers/iio/adc/vf610_adc.c                        |  104 +-
 drivers/iio/addac/Kconfig                          |   14 +
 drivers/iio/addac/Makefile                         |    1 +
 drivers/iio/addac/ad74115.c                        | 1943 ++++++++++++++++++
 drivers/iio/addac/ad74413r.c                       |   32 +-
 drivers/iio/amplifiers/hmc425a.c                   |   17 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |    4 +-
 drivers/iio/buffer/kfifo_buf.c                     |    2 +-
 drivers/iio/cdc/ad7150.c                           |   24 +-
 drivers/iio/cdc/ad7746.c                           |    6 +-
 drivers/iio/chemical/ams-iaq-core.c                |    5 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    6 +-
 drivers/iio/chemical/atlas-sensor.c                |    6 +-
 drivers/iio/chemical/bme680_i2c.c                  |    6 +-
 drivers/iio/chemical/ccs811.c                      |    6 +-
 drivers/iio/chemical/scd4x.c                       |    4 +-
 drivers/iio/chemical/sgp30.c                       |    6 +-
 drivers/iio/chemical/sgp40.c                       |    6 +-
 drivers/iio/chemical/vz89x.c                       |    6 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    6 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    8 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    9 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   39 +-
 drivers/iio/dac/ad5064.c                           |    6 +-
 drivers/iio/dac/ad5380.c                           |    6 +-
 drivers/iio/dac/ad5446.c                           |    6 +-
 drivers/iio/dac/ad5593r.c                          |    6 +-
 drivers/iio/dac/ad5696-i2c.c                       |    6 +-
 drivers/iio/dac/ds4424.c                           |    6 +-
 drivers/iio/dac/ltc2688.c                          |   23 +-
 drivers/iio/dac/m62332.c                           |    5 +-
 drivers/iio/dac/max517.c                           |    6 +-
 drivers/iio/dac/max5821.c                          |    6 +-
 drivers/iio/dac/mcp4725.c                          |    6 +-
 drivers/iio/dac/ti-dac5571.c                       |    6 +-
 drivers/iio/filter/admv8818.c                      |    4 +-
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/ad9523.c                     |   22 +-
 drivers/iio/frequency/adf4377.c                    |  994 +++++++++
 drivers/iio/gyro/adis16136.c                       |    2 +-
 drivers/iio/gyro/adis16260.c                       |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |   24 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   21 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    3 +-
 drivers/iio/gyro/fxas21002c_spi.c                  |    3 +-
 drivers/iio/gyro/itg3200_core.c                    |   15 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    6 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    5 +-
 drivers/iio/health/afe4403.c                       |    5 +-
 drivers/iio/health/afe4404.c                       |   17 +-
 drivers/iio/health/max30100.c                      |   20 +-
 drivers/iio/health/max30102.c                      |   25 +-
 drivers/iio/humidity/am2315.c                      |    5 +-
 drivers/iio/humidity/hdc100x.c                     |    5 +-
 drivers/iio/humidity/hdc2010.c                     |    5 +-
 drivers/iio/humidity/hts221.h                      |    2 -
 drivers/iio/humidity/hts221_core.c                 |   27 +-
 drivers/iio/humidity/hts221_i2c.c                  |    5 +-
 drivers/iio/humidity/htu21.c                       |    6 +-
 drivers/iio/humidity/si7005.c                      |    5 +-
 drivers/iio/humidity/si7020.c                      |    5 +-
 drivers/iio/imu/adis.c                             |   28 +-
 drivers/iio/imu/adis16400.c                        |    2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    6 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   26 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    3 +-
 drivers/iio/imu/kmx61.c                            |    6 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   24 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  465 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   26 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   20 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   65 +-
 drivers/iio/industrialio-buffer.c                  |   40 +-
 drivers/iio/industrialio-core.c                    |   58 +-
 drivers/iio/industrialio-event.c                   |    8 +-
 drivers/iio/industrialio-sw-trigger.c              |    6 +-
 drivers/iio/industrialio-trigger.c                 |   12 +-
 drivers/iio/light/Kconfig                          |    2 +
 drivers/iio/light/adjd_s311.c                      |    5 +-
 drivers/iio/light/adux1020.c                       |    5 +-
 drivers/iio/light/al3010.c                         |    5 +-
 drivers/iio/light/al3320a.c                        |    5 +-
 drivers/iio/light/apds9300.c                       |    5 +-
 drivers/iio/light/apds9960.c                       |   37 +-
 drivers/iio/light/bh1750.c                         |    6 +-
 drivers/iio/light/bh1780.c                         |    5 +-
 drivers/iio/light/cm3232.c                         |    6 +-
 drivers/iio/light/cm3323.c                         |    5 +-
 drivers/iio/light/cm36651.c                        |    6 +-
 drivers/iio/light/gp2ap002.c                       |    5 +-
 drivers/iio/light/gp2ap020a00f.c                   |    6 +-
 drivers/iio/light/isl29018.c                       |    6 +-
 drivers/iio/light/isl29028.c                       |    6 +-
 drivers/iio/light/isl29125.c                       |    5 +-
 drivers/iio/light/jsa1212.c                        |    5 +-
 drivers/iio/light/ltr501.c                         |   33 +-
 drivers/iio/light/lv0104cs.c                       |    5 +-
 drivers/iio/light/max44000.c                       |    5 +-
 drivers/iio/light/noa1305.c                        |   31 +-
 drivers/iio/light/opt3001.c                        |    5 +-
 drivers/iio/light/pa12203001.c                     |    5 +-
 drivers/iio/light/rpr0521.c                        |    5 +-
 drivers/iio/light/si1133.c                         |    6 +-
 drivers/iio/light/si1145.c                         |    6 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    5 +-
 drivers/iio/light/stk3310.c                        |    5 +-
 drivers/iio/light/tcs3414.c                        |    5 +-
 drivers/iio/light/tcs3472.c                        |    5 +-
 drivers/iio/light/tsl2563.c                        |    5 +-
 drivers/iio/light/tsl2583.c                        |    5 +-
 drivers/iio/light/tsl2772.c                        |    6 +-
 drivers/iio/light/tsl4531.c                        |    5 +-
 drivers/iio/light/us5182d.c                        |    5 +-
 drivers/iio/light/vcnl4000.c                       |  191 +-
 drivers/iio/light/vcnl4035.c                       |    5 +-
 drivers/iio/light/veml6030.c                       |    5 +-
 drivers/iio/light/veml6070.c                       |    5 +-
 drivers/iio/light/vl6180.c                         |    5 +-
 drivers/iio/light/zopt2201.c                       |    5 +-
 drivers/iio/magnetometer/ak8974.c                  |    5 +-
 drivers/iio/magnetometer/ak8975.c                  |    6 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    6 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    6 +-
 drivers/iio/magnetometer/mag3110.c                 |    6 +-
 drivers/iio/magnetometer/mmc35240.c                |    5 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    6 +-
 drivers/iio/multiplexer/iio-mux.c                  |    8 +-
 drivers/iio/potentiometer/ad5272.c                 |    6 +-
 drivers/iio/potentiometer/ds1803.c                 |    5 +-
 drivers/iio/potentiometer/max5432.c                |    5 +-
 drivers/iio/potentiometer/tpl0102.c                |    6 +-
 drivers/iio/potentiostat/lmp91000.c                |    5 +-
 drivers/iio/pressure/abp060mg.c                    |    6 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    6 +-
 drivers/iio/pressure/dlhl60d.c                     |    6 +-
 drivers/iio/pressure/dps310.c                      |    6 +-
 drivers/iio/pressure/hp03.c                        |    6 +-
 drivers/iio/pressure/hp206c.c                      |    6 +-
 drivers/iio/pressure/icp10100.c                    |    5 +-
 drivers/iio/pressure/mpl115.c                      |   62 +-
 drivers/iio/pressure/mpl115.h                      |    5 +
 drivers/iio/pressure/mpl115_i2c.c                  |    7 +-
 drivers/iio/pressure/mpl115_spi.c                  |    1 +
 drivers/iio/pressure/mpl3115.c                     |    6 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    6 +-
 drivers/iio/pressure/ms5637.c                      |    6 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +-
 drivers/iio/pressure/t5403.c                       |    6 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    6 +-
 drivers/iio/proximity/isl29501.c                   |    5 +-
 drivers/iio/proximity/mb1232.c                     |    6 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    5 +-
 drivers/iio/proximity/rfd77402.c                   |    5 +-
 drivers/iio/proximity/srf08.c                      |    6 +-
 drivers/iio/proximity/sx9360.c                     |    1 +
 drivers/iio/proximity/sx9500.c                     |    5 +-
 drivers/iio/proximity/sx_common.c                  |   23 +-
 drivers/iio/proximity/sx_common.h                  |    2 -
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/ltc2983.c                  |  193 +-
 drivers/iio/temperature/max30208.c                 |  252 +++
 drivers/iio/temperature/mlx90614.c                 |    6 +-
 drivers/iio/temperature/mlx90632.c                 |  480 ++++-
 drivers/iio/temperature/tmp006.c                   |    5 +-
 drivers/iio/temperature/tmp007.c                   |    6 +-
 drivers/iio/temperature/tsys01.c                   |    5 +-
 drivers/iio/temperature/tsys02d.c                  |    6 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   14 +-
 drivers/interconnect/qcom/icc-rpm.c                |    5 +-
 drivers/interconnect/qcom/osm-l3.c                 |  126 +-
 drivers/interconnect/qcom/sc7180.c                 |    4 +-
 drivers/interconnect/qcom/sc8180x.c                |    2 +-
 drivers/mcb/mcb-core.c                             |    4 +-
 drivers/mcb/mcb-parse.c                            |    2 +-
 drivers/misc/Kconfig                               |   22 +
 drivers/misc/Makefile                              |    2 +
 drivers/misc/apds9802als.c                         |    5 +-
 drivers/misc/apds990x.c                            |    5 +-
 drivers/misc/bh1770glc.c                           |    5 +-
 drivers/misc/cxl/guest.c                           |   24 +-
 drivers/misc/cxl/pci.c                             |   20 +-
 drivers/misc/ds1682.c                              |    5 +-
 drivers/misc/eeprom/eeprom.c                       |    5 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |    4 +-
 drivers/misc/eeprom/max6875.c                      |    5 +-
 drivers/misc/fastrpc.c                             |  260 ++-
 drivers/misc/genwqe/card_base.c                    |    2 +-
 .../misc/habanalabs/common/command_submission.c    |   62 +-
 drivers/misc/habanalabs/common/context.c           |   54 +-
 drivers/misc/habanalabs/common/debugfs.c           |    5 +
 drivers/misc/habanalabs/common/device.c            |  452 ++++-
 drivers/misc/habanalabs/common/firmware_if.c       |   54 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  127 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   42 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   70 +-
 drivers/misc/habanalabs/common/memory.c            |   16 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   24 +-
 drivers/misc/habanalabs/common/sysfs.c             |    4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  124 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c            |  643 ++++--
 drivers/misc/habanalabs/gaudi2/gaudi2P.h           |    2 -
 drivers/misc/habanalabs/gaudi2/gaudi2_security.c   |    1 +
 drivers/misc/habanalabs/goya/goya.c                |    4 +-
 .../include/gaudi2/gaudi2_async_events.h           |    1 +
 .../include/gaudi2/gaudi2_async_ids_map_extended.h |    4 +-
 .../habanalabs/include/hw_ip/pci/pci_general.h     |    7 +
 drivers/misc/hmc6352.c                             |    5 +-
 drivers/misc/ics932s401.c                          |    8 +-
 drivers/misc/isl29003.c                            |    5 +-
 drivers/misc/isl29020.c                            |    5 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |    5 +-
 drivers/misc/mei/bus-fixup.c                       |   14 +-
 drivers/misc/mei/bus.c                             |   22 +-
 drivers/misc/mei/client.c                          |   20 +-
 drivers/misc/mei/client.h                          |    2 +-
 drivers/misc/mei/main.c                            |    2 +-
 drivers/misc/mei/mei_dev.h                         |    2 +
 drivers/misc/ocxl/config.c                         |   20 +-
 drivers/misc/ocxl/file.c                           |    7 +-
 drivers/misc/sgi-gru/grufault.c                    |   13 +-
 drivers/misc/sgi-gru/grumain.c                     |   22 +-
 drivers/misc/sgi-gru/grutables.h                   |    2 +-
 drivers/misc/smpro-errmon.c                        |  529 +++++
 drivers/misc/smpro-misc.c                          |  145 ++
 drivers/misc/tifm_7xx1.c                           |    2 +-
 drivers/misc/tsl2550.c                             |    5 +-
 drivers/nvmem/Kconfig                              |    2 +-
 drivers/nvmem/stm32-romem.c                        |   27 +-
 drivers/nvmem/u-boot-env.c                         |   14 +
 drivers/slimbus/qcom-ctrl.c                        |    5 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   97 +-
 drivers/slimbus/stream.c                           |   17 +-
 drivers/spmi/spmi-pmic-arb.c                       |  242 ++-
 drivers/staging/iio/accel/adis16203.c              |    2 +-
 drivers/staging/iio/accel/adis16240.c              |    2 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |    6 +-
 drivers/staging/iio/frequency/ad9834.c             |    6 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |   10 +-
 drivers/uio/uio_dmem_genirq.c                      |   22 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    6 +-
 drivers/virt/fsl_hypervisor.c                      |    2 +-
 fs/char_dev.c                                      |   15 +-
 include/linux/i2c.h                                |    1 +
 include/linux/iio/buffer_impl.h                    |    2 +-
 include/linux/iio/common/st_sensors.h              |    4 -
 include/linux/iio/gyro/itg3200.h                   |    2 +
 include/linux/iio/iio-opaque.h                     |    2 +
 include/linux/iio/iio.h                            |    5 +-
 include/linux/iio/imu/adis.h                       |   11 +-
 include/linux/iio/kfifo_buf.h                      |    3 +-
 include/linux/iio/sysfs.h                          |   11 +
 include/linux/iio/triggered_buffer.h               |    6 +-
 include/uapi/linux/acrn.h                          |    5 +-
 include/uapi/misc/fastrpc.h                        |    7 +
 include/uapi/misc/habanalabs.h                     |   93 +-
 lib/test_firmware.c                                |    5 +-
 samples/acrn/vm-sample.c                           |    3 -
 scripts/kallsyms.c                                 |    3 +-
 471 files changed, 18163 insertions(+), 3125 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coreboot
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml
 create mode 100644 drivers/firmware/google/cbmem.c
 create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
 create mode 100644 drivers/fpga/lattice-sysconfig.c
 create mode 100644 drivers/fpga/lattice-sysconfig.h
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h
 create mode 100644 drivers/iio/adc/ad4130.c
 create mode 100644 drivers/iio/adc/max11410.c
 create mode 100644 drivers/iio/adc/mt6370-adc.c
 create mode 100644 drivers/iio/addac/ad74115.c
 create mode 100644 drivers/iio/frequency/adf4377.c
 create mode 100644 drivers/iio/temperature/max30208.c
 create mode 100644 drivers/misc/smpro-errmon.c
 create mode 100644 drivers/misc/smpro-misc.c
