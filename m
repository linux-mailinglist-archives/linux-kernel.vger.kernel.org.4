Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55C7459C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGCKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGCKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA2CE7D;
        Mon,  3 Jul 2023 03:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8291860EA5;
        Mon,  3 Jul 2023 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6152AC433C7;
        Mon,  3 Jul 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688379024;
        bh=w7rgeBD31kqeFsFWqtIGRVR8gYpvR8ZPussei+tjmhQ=;
        h=Date:From:To:Cc:Subject:From;
        b=CkAWa7RC75W715RpjGJ9/KJgs2tZ40vX0flvxXAM9kIVrbCi7MQfjDVugQRAHIQ3d
         eVSRHJOy83pSyfbxfsLjkla95VvNUvpCrlhbVt93re52Y6UP5hXc9Yt3ydeNCbztsD
         lNcDH7PKy6/p2YCaxpQZy4VO4VLsMVT2JcpwGDOw=
Date:   Mon, 3 Jul 2023 12:10:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver updates for 6.5-rc1
Message-ID: <ZKKejqr0Db74u8TB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc1

for you to fetch changes up to 18af4b5c97915a6daef9de28a30ae1d3786bc2ac:

  usb: host: xhci-plat: Set XHCI_STATE_REMOVING before resuming XHCI HC (2023-06-23 09:55:09 +0200)

----------------------------------------------------------------
USB / Thunderbolt driver updates for 6.5-rc1

Here is the big set of USB and Thunderbolt driver updates for 6.5-rc1.

Included in here are:
  - Lots of USB4/Thunderbolt additions and updates for new hardware
    types and fixes as people are starting to get access to the hardware
    in the wild
  - new gadget controller driver, cdns2, added
  - new typec drivers added
  - xhci driver updates
  - typec driver updates
  - usbip driver fixes
  - usb-serial driver updates and fixes
  - lots of smaller USB driver updates

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Halaney (1):
      usb: dwc3: qcom: use dev_err_probe() where appropriate

Andy Shevchenko (1):
      usb: ulpi: Make container_of() no-op in to_ulpi_dev()

Arnd Bergmann (1):
      usb: hide unused usbfs_notify_suspend/resume functions

Avichal Rakesh (2):
      usb: gadget: uvc: queue empty isoc requests if no video buffer is available
      usb: gadget: uvc: clean up comments and styling in video_pump

Azeem Shaikh (2):
      usb: gadget: function: printer: Replace strlcpy with strscpy
      usbip: usbip_host: Replace strlcpy with strscpy

Basavaraj Natikar (2):
      USB: Extend pci resume function to handle PM events
      xhci: Improve the XHCI system resume time

Bhupesh Sharma (2):
      usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')
      usb: misc: eud: Fix indentation issues

Bryan O'Donoghue (5):
      dt-bindings: usb: Add Qualcomm PMIC Type-C
      usb: typec: qcom: Add Qualcomm PMIC Type-C driver
      dt-bindings: regulator: qcom,usb-vbus-regulator: Mark reg as required
      dt-bindings: regulator: qcom,usb-vbus-regulator: Mark regulator-*-microamp required
      dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy: Add orientation-switch as optional

Christophe JAILLET (6):
      usb: typec: mux: Remove some unneeded includes
      usb: dwc2: Fix some error handling paths
      usb: usb251xb: Use of_property_read_u16()
      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
      usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
      usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()

Colin Ian King (1):
      usb: cdns2: Fix spelling mistake in a trace message "Wakupe" -> "Wakeup"

David Disseldorp (1):
      usb: gadget: f_mass_storage: remove unnecessary open check

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Dmitry Baryshkov (1):
      usb: typec: add support for the nb7vpq904m Type-C Linear Redriver

Dmitry Rokosov (3):
      usb: dwc2: support dwc2 IP for Amlogic A1 SoC family
      dt-bindings: usb: dwc2: add support for Amlogic A1 SoC USB peripheral
      usb: dwc3-meson-g12a: support OTG switch for all IP versions

Frank Li (4):
      usb: cdns3: imx: simplify clock name usage
      dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
      usb: cdns3: improve handling of unaligned address case
      usb: cdns3: optimize OUT transfer by copying only actual received data

Frank Wang (2):
      usb: typec: tcpm: fix cc role at port reset
      usb: typec: tcpm: add get max power support

Galen Guyer (1):
      usbip: give a more helpful error message if vhdi_hcd isn't loaded

Gil Fine (10):
      thunderbolt: Introduce tb_switch_downstream_port()
      thunderbolt: Identify USB4 v2 routers
      thunderbolt: Add support for USB4 v2 80 Gb/s link
      thunderbolt: Announce USB4 v2 connection manager support
      thunderbolt: Enable USB4 v2 PCIe TLP/DLLP extended encapsulation
      thunderbolt: Add two additional double words for adapters TMU for USB4 v2 routers
      thunderbolt: Fix DisplayPort IN adapter capability length for USB4 v2 routers
      thunderbolt: Fix PCIe adapter capability length for USB4 v2 routers
      thunderbolt: Move constants related to NVM into nvm.c
      thunderbolt: Increase NVM_MAX_SIZE to support Intel Barlow Ridge controller

Greg Kroah-Hartman (6):
      Merge 6.4-rc4 into usb-next
      Merge 6.4-rc5 into usb-next
      Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
      MAINTAINERS: USB: add uapi header files to USB SUBSYSTEM entry
      Merge tag 'thunderbolt-for-v6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.5-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Heikki Krogerus (2):
      usb: typec: mux: Clean up mux_fwnode_match()
      usb: typec: mux: Remove alt mode parameters from the API

Henry Lin (1):
      usb: xhci: tegra: enable stream protocol support

Ivan Orlov (5):
      USB: roles: make role_class a static const structure
      USB: gadget: udc: core: make udc_class a static const structure
      USB: mon: make mon_bin_class a static const structure
      USB: gadget: f_printer: make usb_gadget_class a static const structure
      USB: gadget: f_hid: make hidg_class a static const structure

Jeff Layton (1):
      usb: update the ctime as well when updating mtime after an ioctl

Johan Hovold (3):
      USB: serial: return errors from break handling
      USB: serial: cp210x: disable break signalling on CP2105 SCI
      USB: serial: report unsupported break signalling

Kees Cook (1):
      usb: ch9: Replace 1-element array with flexible array

Krishna Kurapati (3):
      usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
      usb: gadget: udc: Handle gadget_connect failure during bind operation
      usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Krzysztof Kozlowski (1):
      dt-bindings: usb: usb251xb: correct swap-dx-lanes type to uint32

Kuen-Han Tsai (1):
      usb: gadget: u_serial: Add null pointer check in gs_start_io

Li Yang (1):
      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Lukas Bulwahn (1):
      MAINTAINERS: remove broken entries in QUALCOMM TYPEC PORT MANAGER DRIVER

Mario Limonciello (1):
      usb: typec: ucsi: Mark dGPUs as DEVICE scope

Mathias Nyman (6):
      xhci: Add usb cold attach (CAS) as a reason to resume root hub.
      xhci: Don't require a valid get_quirks() function pointer during xhci setup
      xhci: get rid of XHCI_PLAT quirk that used to prevent MSI setup
      xhci: split allocate interrupter into separate alloacte and add parts
      xhci: Fix transfer ring expansion size calculation
      xhci: Stop unnecessary tracking of free trbs in a ring

Michal Simek (1):
      dt-bindings: usb: Add support for Microchip usb5744 hub controller

Mika Westerberg (46):
      thunderbolt: dma_test: Use correct value for absent rings when creating paths
      thunderbolt: Check for ring 0 in tb_tunnel_alloc_dma()
      thunderbolt: Log function name of the called quirk
      thunderbolt: Add debug log for link controller power quirk
      thunderbolt: Allow specifying custom credits for DMA tunnels
      thunderbolt: Add MODULE_DESCRIPTION
      thunderbolt: dma_test: Update MODULE_DESCRIPTION
      thunderbolt: Drop retimer vendor check
      thunderbolt: Increase DisplayPort Connection Manager handshake timeout
      thunderbolt: Do not touch CL state configuration during discovery
      thunderbolt: Log DisplayPort adapter rate and lanes on discovery
      thunderbolt: Mask ring interrupt on Intel hardware as well
      Merge branch 'thunderbolt/fixes' into thunderbolt/next
      thunderbolt: Introduce tb_xdomain_downstream_port()
      thunderbolt: Fix a couple of style issues in TMU code
      thunderbolt: Drop useless 'unidirectional' parameter from tb_switch_tmu_is_enabled()
      thunderbolt: Rework Titan Ridge TMU objection disable function
      thunderbolt: Get rid of tb_switch_enable_tmu_1st_child()
      thunderbolt: Move TMU configuration to tb_enable_tmu()
      thunderbolt: Move tb_enable_tmu() close to other TMU functions
      thunderbolt: Check valid TMU configuration in tb_switch_tmu_configure()
      thunderbolt: Move CLx support functions into clx.c
      thunderbolt: Get rid of __tb_switch_[en|dis]able_clx()
      thunderbolt: Move CLx enabling into tb_enable_clx()
      thunderbolt: Switch CL states from enum to a bitmask
      thunderbolt: Check for first depth router in tb.c
      thunderbolt: Do not call CLx functions from TMU code
      thunderbolt: Prefix TMU post time log message with "TMU: "
      thunderbolt: Prefix CL state related log messages with "CLx: "
      thunderbolt: Initialize CL states from the hardware
      thunderbolt: Make tb_switch_clx_disable() return CL states that were enabled
      thunderbolt: Disable CL states when a DMA tunnel is established
      thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
      thunderbolt: Do not send UNSET_INBOUND_SBTX when retimer NVM authentication started
      thunderbolt: Enable/disable sideband depending on USB4 port offline mode
      thunderbolt: Ignore data CRC mismatch for USB4 routers
      thunderbolt: Do not touch lane 1 adapter path config space
      thunderbolt: Add the new USB4 v2 notification types
      thunderbolt: Reset USB4 v2 host router
      thunderbolt: Add Intel Barlow Ridge PCI ID
      thunderbolt: Limit Intel Barlow Ridge USB3 bandwidth
      thunderbolt: Add support for enhanced uni-directional TMU mode
      thunderbolt: Enable CL2 low power state
      thunderbolt: Make bandwidth allocation mode function names consistent
      thunderbolt: Add DisplayPort 2.x tunneling support
      thunderbolt: Add test case for 3 DisplayPort tunnels

Min-Hua Chen (1):
      usb: typec: ucsi: correctly access opcode

Minda Chen (2):
      usb: cdns3: Add StarFive JH7110 USB driver
      dt-bindings: usb: Add StarFive JH7110 USB controller

Neil Armstrong (5):
      dt-bindings: usb: add ON Semiconductor nb7vpq904m Type-C Linear Redriver bindings
      usb: typec: ucsi: call typec_set_mode on non-altmode partner change
      usb: typec: fsa4480: rework mux & switch setup to handle more states
      usb: typec: fsa4480: add support for Audio Accessory Mode
      usb: typec: nb7vpq904m: fix CONFIG_DRM dependency

Niklas Schnelle (2):
      usb: add HAS_IOPORT dependencies
      usb: uhci: handle HAS_IOPORT dependencies

Pawel Laszczak (4):
      usb: cdns2: Device side header file for CDNS2 driver
      usb: cdns2: Add main part of Cadence USBHS driver
      usb: cdns2: Add tracepoints for CDNS2 driver
      MAINTAINERS: add Cadence USBHS driver entry

Piyush Mehta (3):
      usb: gadget: udc: udc-xilinx: Add identifier to read_fn function arg
      dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml
      dt-bindings: usb: dwc3: Add interrupt-names property support for wakeup interrupt

Prashanth K (3):
      usb: gadget: u_serial: Add null pointer check in gserial_suspend
      usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
      usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Rajat Khandelwal (1):
      usb: typec: intel_pmc_mux: Expose IOM port status to debugfs

Randy Dunlap (1):
      usb: typec: mux: fix static inline syntax error

Roger Quadros (1):
      USB: fix up merge of 6.4-rc4 into usb-next

Roy Luo (2):
      usb: dwc3: Add error logs for unknown endpoint events
      usb: core: add sysfs entry for usb device state

Sebastian Reichel (3):
      dt-bindings: usb: Add RK3588 OHCI
      dt-bindings: usb: Add RK3588 EHCI
      usb: host: ohci-platform: increase max clock number to 4

Shenwei Wang (1):
      usb: cdns3: imx: Rework system PM to avoid duplicated operations

Stanley Chang (2):
      usb: dwc3: core: add support for realtek SoCs custom's global register start address
      usb: xhci: plat: remove error log for failure to get usb-phy

Tom Rix (1):
      usb: typec: qcom: set pm8150b_typec_res storage-class-specifier to static

Udipto Goswami (1):
      usb: xhci: Remove unused udev from xhci_log_ctx trace event

Uwe Kleine-König (101):
      usb: c67x00-drv: Convert to platform remove callback returning void
      usb: cdns3-imx: Convert to platform remove callback returning void
      usb: cdns3-plat: Convert to platform remove callback returning void
      usb: cdns3-ti: Convert to platform remove callback returning void
      usb: chipidea/ci_hdrc_imx: Convert to platform remove callback returning void
      usb: chipidea/ci_hdrc_msm: Convert to platform remove callback returning void
      usb: chipidea/ci_hdrc_tegra: Convert to platform remove callback returning void
      usb: chipidea/ci_hdrc_usb2: Convert to platform remove callback returning void
      usb: chipidea/core: Convert to platform remove callback returning void
      usb: common: usb-conn-gpio: Convert to platform remove callback returning void
      usb: core: Convert to platform remove callback returning void
      usb: dwc3-am62: Convert to platform remove callback returning void
      usb: dwc3-exynos: Convert to platform remove callback returning void
      usb: dwc3-imx8mp: Convert to platform remove callback returning void
      usb: dwc3-keystone: Convert to platform remove callback returning void
      usb: dwc3-meson-g12a: Convert to platform remove callback returning void
      usb: dwc3-of-simple: Convert to platform remove callback returning void
      usb: dwc3-omap: Convert to platform remove callback returning void
      usb: dwc3-qcom: Convert to platform remove callback returning void
      usb: dwc3-st: Convert to platform remove callback returning void
      usb: dwc3-xilinx: Convert to platform remove callback returning void
      usb: fotg210: Convert to platform remove callback returning void
      usb: gadget: hid: Convert to platform remove callback returning void
      usb: gadget: aspeed: Convert to platform remove callback returning void
      usb: gadget/atmel_usba_udc: Convert to platform remove callback returning void
      usb: gadget/bcm63xx_udc: Convert to platform remove callback returning void
      usb: bdc: Convert to platform remove callback returning void
      usb: gadget/dummy_hcd: Convert to platform remove callback returning void
      usb: gadget/fsl_qe_udc: Convert to platform remove callback returning void
      usb: gadget/fusb300_udc: Convert to platform remove callback returning void
      usb: gadget/m66592-udc: Convert to platform remove callback returning void
      usb: gadget/mv_u3d_core: Convert to platform remove callback returning void
      usb: gadget/mv_udc_core: Convert to platform remove callback returning void
      usb: gadget/net2272: Convert to platform remove callback returning void
      usb: gadget/omap_udc: Convert to platform remove callback returning void
      usb: gadget/pxa27x_udc: Convert to platform remove callback returning void
      usb: gadget/r8a66597-udc: Convert to platform remove callback returning void
      usb: gadget/renesas_usb3: Convert to platform remove callback returning void
      usb: gadget/renesas_usbf: Convert to platform remove callback returning void
      usb: gadget/rzv2m_usb3drd: Convert to platform remove callback returning void
      usb: gadget/snps_udc_plat: Convert to platform remove callback returning void
      usb: gadget/tegra-xudc: Convert to platform remove callback returning void
      usb: gadget/udc-xilinx: Convert to platform remove callback returning void
      usb: ehci-atmel: Convert to platform remove callback returning void
      usb: ehci-brcm: Convert to platform remove callback returning void
      usb: ehci-exynos: Convert to platform remove callback returning void
      usb: ehci-fsl: Convert to platform remove callback returning void
      usb: ehci-grlib: Convert to platform remove callback returning void
      usb: ehci-mv: Convert to platform remove callback returning void
      usb: ehci-npcm7xx: Convert to platform remove callback returning void
      usb: ehci-omap: Convert to platform remove callback returning void
      usb: ehci-orion: Convert to platform remove callback returning void
      usb: ehci-platform: Convert to platform remove callback returning void
      usb: ehci-ppc-of: Convert to platform remove callback returning void
      usb: ehci-sh: Convert to platform remove callback returning void
      usb: ehci-spear: Convert to platform remove callback returning void
      usb: ehci-st: Convert to platform remove callback returning void
      usb: ehci-xilinx-of: Convert to platform remove callback returning void
      usb: fsl-mph-dr-of: Convert to platform remove callback returning void
      usb: isp116x-hcd: Convert to platform remove callback returning void
      usb: isp1362-hcd: Convert to platform remove callback returning void
      usb: octeon-hcd: Convert to platform remove callback returning void
      usb: ohci-at91: Convert to platform remove callback returning void
      usb: ohci-da8xx: Convert to platform remove callback returning void
      usb: ohci-exynos: Convert to platform remove callback returning void
      usb: ohci-nxp: Convert to platform remove callback returning void
      usb: ohci-omap: Convert to platform remove callback returning void
      usb: ohci-platform: Convert to platform remove callback returning void
      usb: ohci-ppc-of: Convert to platform remove callback returning void
      usb: ohci-pxa27x: Convert to platform remove callback returning void
      usb: ohci-s3c2410: Convert to platform remove callback returning void
      usb: ohci-sm501: Convert to platform remove callback returning void
      usb: ohci-spear: Convert to platform remove callback returning void
      usb: ohci-st: Convert to platform remove callback returning void
      usb: oxu210hp-hcd: Convert to platform remove callback returning void
      usb: r8a66597-hcd: Convert to platform remove callback returning void
      usb: sl811-hcd: Convert to platform remove callback returning void
      usb: uhci-grlib: Convert to platform remove callback returning void
      usb: uhci-platform: Convert to platform remove callback returning void
      usb: isp1760: Convert to platform remove callback returning void
      usb: misc: eud: Convert to platform remove callback returning void
      usb: misc: usb3503: Convert to platform remove callback returning void
      usb: renesas_usbhs: Convert to platform remove callback returning void
      usb: roles: intel_xhci: Convert to platform remove callback returning void
      usb: typec: mux: gpio-sbu: Convert to platform remove callback returning void
      usb: typec: intel_pmc_mux: Convert to platform remove callback returning void
      usb: typec: tcpci_mt6360: Convert to platform remove callback returning void
      usb: typec: tcpci_mt6360: Convert to platform remove callback returning void
      usb: typec: wcove: Convert to platform remove callback returning void
      usb: typec: ucsi: acpi: Convert to platform remove callback returning void
      usbip: vhci_hcd: Convert to platform remove callback returning void
      usbip: Use _FORTIFY_SOURCE=2 instead of (implicitly) =1
      usb: Switch i2c drivers back to use .probe()
      usb: host: fhci-hcd: Convert to platform remove callback returning void
      usb: misc: onboard_hub: Don't warn twice about problems during remove
      usb: dwc2/platform: Convert to platform remove callback returning void
      usb: xhci-histb: Convert to platform remove callback returning void
      usb: xhci-mtk: Convert to platform remove callback returning void
      usb: xhci-plat: Convert to platform remove callback returning void
      usb: xhci-tegra: Convert to platform remove callback returning void
      usb: typec: qcom-pmic-typec: Convert to platform remove callback returning void

Varadarajan Narayanan (1):
      dt-bindings: usb: dwc3: Add IPQ9574 compatible

Vladislav Efanov (1):
      usb: dwc3: qcom: Fix potential memory leak

Wei Chen (1):
      usb: gadget: legacy: fix error return code in gfs_bind

Weitao Wang (4):
      xhci: Fix resume issue of some ZHAOXIN hosts
      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
      xhci: Show ZHAOXIN xHCI root hub speed correctly
      xhci: Add ZHAOXIN xHCI host U1/U2 feature support

Wesley Cheng (2):
      usb: host: xhci: Do not re-initialize the XHCI HC if being removed
      usb: host: xhci-plat: Set XHCI_STATE_REMOVING before resuming XHCI HC

Xu Yang (5):
      usb: chipidea: imx: remove one duplicated reg define
      dt-bindings: usb: ci-hdrc-usb2: add fsl,imx8ulp-usb compatible
      usb: chipidea: imx: don't request QoS for imx8ulp
      usb: chipidea: imx: turn off vbus comparator when suspend
      usb: chipidea: imx: add missing USB PHY DPDM wakeup setting

 Documentation/ABI/testing/sysfs-bus-usb            |   10 +
 Documentation/ABI/testing/sysfs-driver-eud         |    2 +-
 .../bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml  |    6 +
 .../regulator/qcom,usb-vbus-regulator.yaml         |   10 +-
 .../bindings/reset/xlnx,zynqmp-reset.txt           |   55 -
 .../bindings/reset/xlnx,zynqmp-reset.yaml          |   52 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |    4 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |    1 +
 .../devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml  |  103 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   17 +-
 .../devicetree/bindings/usb/microchip,usb5744.yaml |  107 +
 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   |  141 ++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    3 +-
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   |  190 ++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |    6 +-
 .../bindings/usb/starfive,jh7110-usb.yaml          |  115 +
 .../devicetree/bindings/usb/usb251xb.yaml          |    2 +-
 MAINTAINERS                                        |   21 +
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   13 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                |    3 +
 drivers/platform/chrome/cros_ec_typec.c            |    2 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |    5 +-
 drivers/thunderbolt/Makefile                       |    2 +-
 drivers/thunderbolt/acpi.c                         |    5 +-
 drivers/thunderbolt/clx.c                          |  423 ++++
 drivers/thunderbolt/ctl.c                          |   28 +
 drivers/thunderbolt/debugfs.c                      |   64 +-
 drivers/thunderbolt/dma_test.c                     |   20 +-
 drivers/thunderbolt/eeprom.c                       |    3 +-
 drivers/thunderbolt/icm.c                          |   30 +-
 drivers/thunderbolt/nhi.c                          |   53 +-
 drivers/thunderbolt/nhi.h                          |    4 +
 drivers/thunderbolt/nhi_regs.h                     |   19 +-
 drivers/thunderbolt/nvm.c                          |    4 +
 drivers/thunderbolt/quirks.c                       |   10 +
 drivers/thunderbolt/retimer.c                      |   64 +-
 drivers/thunderbolt/switch.c                       |  594 ++---
 drivers/thunderbolt/tb.c                           |  332 ++-
 drivers/thunderbolt/tb.h                           |  243 +-
 drivers/thunderbolt/tb_msgs.h                      |    7 +
 drivers/thunderbolt/tb_regs.h                      |   25 +-
 drivers/thunderbolt/test.c                         |   83 +
 drivers/thunderbolt/tmu.c                          |  713 ++++--
 drivers/thunderbolt/tunnel.c                       |  241 +-
 drivers/thunderbolt/usb4.c                         |  114 +-
 drivers/thunderbolt/xdomain.c                      |   98 +-
 drivers/usb/c67x00/c67x00-drv.c                    |    6 +-
 drivers/usb/cdns3/Kconfig                          |   11 +
 drivers/usb/cdns3/Makefile                         |    1 +
 drivers/usb/cdns3/cdns3-gadget.c                   |   15 +-
 drivers/usb/cdns3/cdns3-imx.c                      |   30 +-
 drivers/usb/cdns3/cdns3-plat.c                     |    5 +-
 drivers/usb/cdns3/cdns3-starfive.c                 |  246 ++
 drivers/usb/cdns3/cdns3-ti.c                       |    6 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   11 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 |    6 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |    6 +-
 drivers/usb/chipidea/ci_hdrc_usb2.c                |    6 +-
 drivers/usb/chipidea/core.c                        |    6 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |   38 +-
 drivers/usb/common/usb-conn-gpio.c                 |    6 +-
 drivers/usb/core/devio.c                           |   18 +-
 drivers/usb/core/hcd-pci.c                         |   24 +-
 drivers/usb/core/hub.c                             |   15 +
 drivers/usb/core/hub.h                             |    4 +
 drivers/usb/core/port.c                            |   32 +-
 drivers/usb/dwc2/params.c                          |   21 +
 drivers/usb/dwc2/platform.c                        |   22 +-
 drivers/usb/dwc3/core.c                            |   17 +-
 drivers/usb/dwc3/core.h                            |    2 +
 drivers/usb/dwc3/dwc3-am62.c                       |    5 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |    6 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |    6 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |    6 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   27 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    6 +-
 drivers/usb/dwc3/dwc3-omap.c                       |    6 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   43 +-
 drivers/usb/dwc3/dwc3-st.c                         |    6 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |    6 +-
 drivers/usb/dwc3/ep0.c                             |    3 +
 drivers/usb/dwc3/gadget.c                          |   13 +-
 drivers/usb/fotg210/fotg210-core.c                 |    6 +-
 drivers/usb/gadget/function/f_hid.c                |   21 +-
 drivers/usb/gadget/function/f_mass_storage.c       |    8 +-
 drivers/usb/gadget/function/f_printer.c            |   29 +-
 drivers/usb/gadget/function/u_serial.c             |   22 +-
 drivers/usb/gadget/function/uvc_video.c            |   50 +-
 drivers/usb/gadget/legacy/g_ffs.c                  |    4 +-
 drivers/usb/gadget/legacy/hid.c                    |    6 +-
 drivers/usb/gadget/udc/Kconfig                     |    2 +
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |    8 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    6 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    6 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    5 +-
 drivers/usb/gadget/udc/cdns2/Kconfig               |   11 +
 drivers/usb/gadget/udc/cdns2/Makefile              |    7 +
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h         |  203 ++
 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c           |  659 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c        | 2474 ++++++++++++++++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h        |  707 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c           |  138 ++
 drivers/usb/gadget/udc/cdns2/cdns2-trace.c         |   11 +
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h         |  605 +++++
 drivers/usb/gadget/udc/core.c                      |   24 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   11 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    6 +-
 drivers/usb/gadget/udc/fusb300_udc.c               |    6 +-
 drivers/usb/gadget/udc/m66592-udc.c                |    5 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |    6 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |    6 +-
 drivers/usb/gadget/udc/net2272.c                   |    6 +-
 drivers/usb/gadget/udc/omap_udc.c                  |    6 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |    6 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |    6 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |    6 +-
 drivers/usb/gadget/udc/renesas_usbf.c              |    6 +-
 drivers/usb/gadget/udc/rzv2m_usb3drd.c             |    6 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |    8 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    6 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |    8 +-
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/ehci-atmel.c                      |    6 +-
 drivers/usb/host/ehci-brcm.c                       |    5 +-
 drivers/usb/host/ehci-exynos.c                     |    6 +-
 drivers/usb/host/ehci-fsl.c                        |    6 +-
 drivers/usb/host/ehci-grlib.c                      |    6 +-
 drivers/usb/host/ehci-mv.c                         |    6 +-
 drivers/usb/host/ehci-npcm7xx.c                    |    6 +-
 drivers/usb/host/ehci-omap.c                       |    6 +-
 drivers/usb/host/ehci-orion.c                      |    6 +-
 drivers/usb/host/ehci-pci.c                        |    3 +-
 drivers/usb/host/ehci-platform.c                   |    6 +-
 drivers/usb/host/ehci-ppc-of.c                     |    6 +-
 drivers/usb/host/ehci-sh.c                         |    6 +-
 drivers/usb/host/ehci-spear.c                      |    6 +-
 drivers/usb/host/ehci-st.c                         |    6 +-
 drivers/usb/host/ehci-xilinx-of.c                  |    6 +-
 drivers/usb/host/fhci-hcd.c                        |    9 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |    5 +-
 drivers/usb/host/isp116x-hcd.c                     |    7 +-
 drivers/usb/host/isp1362-hcd.c                     |    6 +-
 drivers/usb/host/octeon-hcd.c                      |    6 +-
 drivers/usb/host/ohci-at91.c                       |    5 +-
 drivers/usb/host/ohci-da8xx.c                      |    6 +-
 drivers/usb/host/ohci-exynos.c                     |    6 +-
 drivers/usb/host/ohci-nxp.c                        |    6 +-
 drivers/usb/host/ohci-omap.c                       |    5 +-
 drivers/usb/host/ohci-pci.c                        |    8 +-
 drivers/usb/host/ohci-platform.c                   |    8 +-
 drivers/usb/host/ohci-ppc-of.c                     |    6 +-
 drivers/usb/host/ohci-pxa27x.c                     |    5 +-
 drivers/usb/host/ohci-s3c2410.c                    |    5 +-
 drivers/usb/host/ohci-sm501.c                      |    6 +-
 drivers/usb/host/ohci-spear.c                      |    5 +-
 drivers/usb/host/ohci-st.c                         |    6 +-
 drivers/usb/host/oxu210hp-hcd.c                    |    6 +-
 drivers/usb/host/r8a66597-hcd.c                    |    5 +-
 drivers/usb/host/sl811-hcd.c                       |    5 +-
 drivers/usb/host/uhci-grlib.c                      |    6 +-
 drivers/usb/host/uhci-hcd.c                        |    2 +-
 drivers/usb/host/uhci-hcd.h                        |   24 +-
 drivers/usb/host/uhci-pci.c                        |    7 +-
 drivers/usb/host/uhci-platform.c                   |    6 +-
 drivers/usb/host/xhci-histb.c                      |   20 +-
 drivers/usb/host/xhci-mem.c                        |  132 +-
 drivers/usb/host/xhci-mtk.c                        |   12 +-
 drivers/usb/host/xhci-pci.c                        |   24 +-
 drivers/usb/host/xhci-plat.c                       |   23 +-
 drivers/usb/host/xhci-plat.h                       |    2 +-
 drivers/usb/host/xhci-rcar.c                       |    6 +-
 drivers/usb/host/xhci-ring.c                       |  137 +-
 drivers/usb/host/xhci-tegra.c                      |   12 +-
 drivers/usb/host/xhci-trace.h                      |    9 +-
 drivers/usb/host/xhci.c                            |   56 +-
 drivers/usb/host/xhci.h                            |    9 +-
 drivers/usb/isp1760/isp1760-if.c                   |    6 +-
 drivers/usb/misc/onboard_usb_hub.c                 |    6 +-
 drivers/usb/misc/qcom_eud.c                        |   10 +-
 drivers/usb/misc/usb251xb.c                        |   11 +-
 drivers/usb/misc/usb3503.c                         |    8 +-
 drivers/usb/misc/usb4604.c                         |    2 +-
 drivers/usb/mon/mon_bin.c                          |   19 +-
 drivers/usb/phy/phy-isp1301.c                      |    2 +-
 drivers/usb/phy/phy-tahvo.c                        |    2 +-
 drivers/usb/renesas_usbhs/common.c                 |    6 +-
 drivers/usb/roles/class.c                          |   17 +-
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |    6 +-
 drivers/usb/serial/ark3116.c                       |    7 +-
 drivers/usb/serial/belkin_sa.c                     |   12 +-
 drivers/usb/serial/ch341.c                         |   37 +-
 drivers/usb/serial/cp210x.c                        |   14 +-
 drivers/usb/serial/digi_acceleport.c               |    7 +-
 drivers/usb/serial/f81232.c                        |    4 +-
 drivers/usb/serial/f81534.c                        |    4 +-
 drivers/usb/serial/ftdi_sio.c                      |   10 +-
 drivers/usb/serial/io_edgeport.c                   |    6 +-
 drivers/usb/serial/io_ti.c                         |    9 +-
 drivers/usb/serial/keyspan.c                       |    5 +-
 drivers/usb/serial/keyspan_pda.c                   |    8 +-
 drivers/usb/serial/mct_u232.c                      |    6 +-
 drivers/usb/serial/mos7720.c                       |    9 +-
 drivers/usb/serial/mos7840.c                       |    7 +-
 drivers/usb/serial/mxuport.c                       |    6 +-
 drivers/usb/serial/option.c                        |    4 +
 drivers/usb/serial/pl2303.c                        |   14 +-
 drivers/usb/serial/quatech2.c                      |    8 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   10 +-
 drivers/usb/serial/upd78f0730.c                    |    7 +-
 drivers/usb/serial/usb-serial.c                    |    4 +-
 drivers/usb/serial/usb_debug.c                     |   13 +-
 drivers/usb/serial/whiteheat.c                     |    7 +-
 drivers/usb/serial/xr_serial.c                     |    4 +-
 drivers/usb/typec/Kconfig                          |   13 -
 drivers/usb/typec/Makefile                         |    1 -
 drivers/usb/typec/anx7411.c                        |    2 +-
 drivers/usb/typec/class.c                          |    4 +-
 drivers/usb/typec/hd3ss3220.c                      |    4 +-
 drivers/usb/typec/mux.c                            |   61 +-
 drivers/usb/typec/mux/Kconfig                      |   10 +
 drivers/usb/typec/mux/Makefile                     |    1 +
 drivers/usb/typec/mux/fsa4480.c                    |  128 +-
 drivers/usb/typec/mux/gpio-sbu-mux.c               |   11 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   56 +-
 drivers/usb/typec/mux/nb7vpq904m.c                 |  529 +++++
 drivers/usb/typec/mux/pi3usb30532.c                |    2 +-
 drivers/usb/typec/qcom-pmic-typec.c                |  261 ---
 drivers/usb/typec/rt1719.c                         |    2 +-
 drivers/usb/typec/stusb160x.c                      |    2 +-
 drivers/usb/typec/tcpm/Kconfig                     |   11 +
 drivers/usb/typec/tcpm/Makefile                    |    1 +
 drivers/usb/typec/tcpm/fusb302.c                   |    2 +-
 drivers/usb/typec/tcpm/qcom/Makefile               |    6 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |  344 +++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |  528 +++++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h    |  119 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c |  556 +++++
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.h |  195 ++
 drivers/usb/typec/tcpm/tcpci.c                     |    2 +-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |    2 +-
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |    5 +-
 drivers/usb/typec/tcpm/tcpci_mt6370.c              |    6 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |    2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   27 +-
 drivers/usb/typec/tcpm/wcove.c                     |    6 +-
 drivers/usb/typec/tipd/core.c                      |    2 +-
 drivers/usb/typec/ucsi/psy.c                       |   14 +
 drivers/usb/typec/ucsi/ucsi.c                      |   17 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |    6 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |    2 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |    2 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |    2 +-
 drivers/usb/typec/wusb3801.c                       |    2 +-
 drivers/usb/usbip/stub_main.c                      |    4 +-
 drivers/usb/usbip/vhci_hcd.c                       |    6 +-
 include/linux/thunderbolt.h                        |   18 +-
 include/linux/ulpi/driver.h                        |    2 +-
 include/linux/usb/hcd.h                            |    2 +-
 include/linux/usb/serial.h                         |    2 +-
 include/linux/usb/typec_mux.h                      |   11 +-
 include/uapi/linux/usb/ch9.h                       |    5 +-
 tools/usb/usbip/configure.ac                       |    4 +-
 tools/usb/usbip/src/usbip_attach.c                 |    2 +-
 tools/usb/usbip/src/usbip_detach.c                 |    2 +-
 tools/usb/usbip/src/usbip_port.c                   |    2 +-
 267 files changed, 11549 insertions(+), 2335 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
 create mode 100644 drivers/thunderbolt/clx.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/Kconfig
 create mode 100644 drivers/usb/gadget/udc/cdns2/Makefile
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-debug.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-pci.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.h
 create mode 100644 drivers/usb/typec/mux/nb7vpq904m.c
 delete mode 100644 drivers/usb/typec/qcom-pmic-typec.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/Makefile
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.h
