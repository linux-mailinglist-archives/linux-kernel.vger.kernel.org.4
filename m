Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4476E9982
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjDTQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:29:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84BA3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:29:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EBA1D1BF203;
        Thu, 20 Apr 2023 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682008168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JXAuXwmTmUEGzanVS5Yw0zVfIcTDRxcYQCqCNS1Z1qc=;
        b=JeLhC7ar3qSrSU3d9TzHJksGqXs16VQv1FO3/L6fmG+9fDA0NtAVlASp9sSZ7+vV0lP/sl
        hHV7akW8sisv3ozYK+QbCCJBv6BZDfC6ysftz4taePgqcN5WX1fHXBCmgGOvlnPofLCK80
        hnWqR6tOW2Y19d2mFQPNLksjjTix9tU/HaeNk7HFygx6TjPnzjXknURJzMW1m6rwcPpfia
        yjhBq4cAxlICk3eGf1VORNjd4Yc+kzOdvnhWq/0+2C5ZlzmeOT88QGXdauHiue1wHM5+sU
        dq2/tFIOk4xPajLUFWTJxAdGO2k40K9Ezp3VQEe1eHoG01y16/UuMzY8GQoA5g==
Date:   Thu, 20 Apr 2023 18:29:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.4-rc1
Message-ID: <20230420182923.0dabff59@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for the next merge window, I will not be available
at that time so I prefer to send it early, hope you don't mind.

Thanks,
Miqu=C3=A8l

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.4

for you to fetch changes up to 7227aacb62aeb59b007a6d3489b11f78fa332696:

  Merge tag 'nand/for-6.4' into mtd/next (2023-04-19 20:39:03 +0200)

----------------------------------------------------------------
Core MTD changes:
* dt-bindings: Drop unneeded quotes
* mtdblock: Tolerate corrected bit-flips
* Use of_property_read_bool() for boolean properties
* Avoid magic values
* Avoid printing error messages on probe deferrals
* Prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER
* Fix error path for nvmem provider
* Fix nvmem error reporting
* Provide unique name for nvmem device

MTD device changes:
* lpddr_cmds: Remove unused words variable
* bcm63xxpart: Remove MODULE_LICENSE in non-modules

SPI NOR core changes:
* Introduce Read While Write support for flashes featuring several banks
* Set the 4-Byte Address Mode method based on SFDP data
* Allow post_sfdp hook to return errors
* Parse SCCR MC table and introduce support for multi-chip devices

SPI NOR manufacturer drivers changes:
* macronix: Add support for mx25uw51245g with RWW
* spansion:
  - Determine current address mode at runtime as it can be changed in a
    non-volatile way and differ from factory defaults or from what SFDP
    advertises.
  - Enable JFFS2 write buffer mode for few ECC'd NOR flashes: S25FS256T,
    s25hx and s28hx
  - Add support for s25hl02gt and s25hs02gt

Raw NAND core changes:
* Convert to platform remove callback returning void
* Fix spelling mistake waifunc() -> waitfunc()

Raw NAND controller driver changes:
* imx: Remove unused is_imx51_nfc and imx53_nfc functions
* omap2: Drop obsolete dependency on COMPILE_TEST
* orion: Use devm_platform_ioremap_resource()
* qcom:
  - Use of_property_present() for testing DT property presence
  - Use devm_platform_get_and_ioremap_resource()
* stm32_fmc2: Depends on ARCH_STM32 instead of MACH_STM32MP157
* tmio: Remove reference to config MTD_NAND_TMIO in the parsers

Raw NAND manufacturer driver changes:
* hynix: Fix up bit 0 of sdr_timing_mode

SPI-NAND changes:
* Add support for ESMT F50x1G41LB

----------------------------------------------------------------
Bang Li (1):
      mtdblock: tolerate corrected bit-flips

Christophe Kerello (1):
      mtd: rawnand: stm32_fmc2: depends on ARCH_STM32 instead of MACH_STM32=
MP157

Chuanhong Guo (1):
      mtd: spinand: add support for ESMT F50x1G41LB

Hector Palacios (1):
      mtd: rawnand: hynix: fix up bit 0 of sdr_timing_mode

Jean Delvare (1):
      mtd: onenand: omap2: Drop obsolete dependency on COMPILE_TEST

Lukas Bulwahn (1):
      mtd: parsers: remove reference to config MTD_NAND_TMIO

Md Sadre Alam (2):
      mtd: nand: raw: qcom_nandc: Use devm_platform_get_and_ioremap_resourc=
e()
      mtd: rawnand: Fix spelling mistake waifunc() -> waitfunc()

Michael Walle (4):
      mtd: core: provide unique name for nvmem device, take two
      mtd: core: fix nvmem error reporting
      mtd: core: fix error path for nvmem provider
      mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER

Miquel Raynal (15):
      Merge tag 'mtd/core-fixes-before-nvmem-layouts-for-6.4' into mtd/next
      mtd: Avoid printing error messages on probe deferrals
      mtd: Avoid magic values
      mtd: spi-nor: Introduce the concept of bank
      mtd: spi-nor: Add a macro to define more banks
      mtd: spi-nor: Reorder the preparation vs. locking steps
      mtd: spi-nor: Separate preparation and locking
      mtd: spi-nor: Prepare the introduction of a new locking mechanism
      mtd: spi-nor: Add a RWW flag
      mtd: spi-nor: Enhance locking to support reads while writes
      mtd: spi-nor: Fix a trivial typo
      mtd: spi-nor: Delay the initialization of bank_size
      mtd: spi-nor: macronix: Add support for mx25uw51245g with RWW
      Merge tag 'spi-nor/for-6.4' into mtd/next
      Merge tag 'nand/for-6.4' into mtd/next

Nick Alcock (1):
      mtd: bcm63xxpart: remove MODULE_LICENSE in non-modules

Rob Herring (3):
      mtd: Use of_property_read_bool() for boolean properties
      mtd: nand: qcom: Use of_property_present() for testing DT property pr=
esence
      dt-bindings: mtd: Drop unneeded quotes

Takahiro Kuwano (12):
      mtd: spi-nor: spansion: Make RD_ANY_REG_OP macro take number of dummy=
 bytes
      mtd: spi-nor: spansion: Add support for Infineon S25FS256T
      mtd: spi-nor: spansion: Determine current address mode
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx =
SEMPER flash
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx =
SEMPER flash
      mtd: spi-nor: spansion: Enable JFFS2 write buffer for S25FS256T
      mtd: spi-nor: Extract volatile register offset from SCCR map
      mtd: spi-nor: sfdp: Add support for SCCR map for multi-chip device
      mtd: spi-nor: spansion: Rework cypress_nor_get_page_size() for multi-=
chip device support
      mtd: spi-nor: spansion: Rework cypress_nor_quad_enable_volatile() for=
 multi-chip device support
      mtd: spi-nor: spansion: Add a new ->ready() hook for multi-chip device
      mtd: spi-nor: spansion: Add support for s25hl02gt and s25hs02gt

Tom Rix (2):
      mtd: rawnand: remove unused is_imx51_nfc and imx53_nfc functions
      mtd: lpddr_cmds: remove unused words variable

Tudor Ambarus (11):
      mtd: spi-nor: core: Move generic method to core - micron_st_nor_set_4=
byte_addr_mode
      mtd: spi-nor: core: Update name and description of micron_st_nor_set_=
4byte_addr_mode
      mtd: spi-nor: core: Update name and description of spansion_set_4byte=
_addr_mode
      mtd: spi-nor: core: Update name and description of spi_nor_set_4byte_=
addr_mode
      mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
      mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data
      mtd: spi-nor: Stop exporting spi_nor_restore()
      mtd: spi-nor: core: Update flash's current address mode when changing=
 address mode
      mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()
      mtd: spi-nor: spansion: Rename method to cypress_nor_get_page_size
      mtd: spi-nor: Allow post_sfdp hook to return errors

Uwe Kleine-K=C3=B6nig (1):
      mtd: nand: Convert to platform remove callback returning void

Ye Xingchen (1):
      mtd: rawnand: orion: use devm_platform_ioremap_resource()

 Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml       =
    |   2 +-
 Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml         =
    |   2 +-
 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml            =
    |   2 +-
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml                      =
    |   2 +-
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml              =
    |   2 +-
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml                  =
    |   2 +-
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml                    =
    |   2 +-
 Documentation/devicetree/bindings/mtd/mxc-nand.yaml                       =
    |   2 +-
 Documentation/devicetree/bindings/mtd/nand-chip.yaml                      =
    |   2 +-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml                =
    |   2 +-
 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.y=
aml |   2 +-
 Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yam=
l   |   2 +-
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml                     =
    |   2 +-
 Documentation/devicetree/bindings/mtd/renesas-nandc.yaml                  =
    |   2 +-
 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml       =
    |   2 +-
 Documentation/devicetree/bindings/mtd/spi-nand.yaml                       =
    |   2 +-
 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml             =
    |   2 +-
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml                   =
    |   4 +-
 Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml                =
    |   4 +-
 Documentation/driver-api/mtd/spi-nor.rst                                  =
    |   3 -
 drivers/mtd/devices/spear_smi.c                                           =
    |   4 +-
 drivers/mtd/lpddr/lpddr_cmds.c                                            =
    |   7 +-
 drivers/mtd/maps/sun_uflash.c                                             =
    |   2 +-
 drivers/mtd/mtdblock_ro.c                                                 =
    |   4 +-
 drivers/mtd/mtdcore.c                                                     =
    |  39 +++----
 drivers/mtd/nand/ecc-mxic.c                                               =
    |   6 +-
 drivers/mtd/nand/onenand/Kconfig                                          =
    |   2 +-
 drivers/mtd/nand/onenand/generic.c                                        =
    |   6 +-
 drivers/mtd/nand/onenand/onenand_omap2.c                                  =
    |   6 +-
 drivers/mtd/nand/onenand/onenand_samsung.c                                =
    |   6 +-
 drivers/mtd/nand/raw/Kconfig                                              =
    |   2 +-
 drivers/mtd/nand/raw/ams-delta.c                                          =
    |   6 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c                             =
    |   6 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c                              =
    |   6 +-
 drivers/mtd/nand/raw/au1550nd.c                                           =
    |   5 +-
 drivers/mtd/nand/raw/bcm47xxnflash/main.c                                 =
    |   6 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c                            =
    |   6 +-
 drivers/mtd/nand/raw/davinci_nand.c                                       =
    |   6 +-
 drivers/mtd/nand/raw/denali_dt.c                                          =
    |   6 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                                      =
    |   6 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                       =
    |   6 +-
 drivers/mtd/nand/raw/fsl_upm.c                                            =
    |   6 +-
 drivers/mtd/nand/raw/fsmc_nand.c                                          =
    |   8 +-
 drivers/mtd/nand/raw/gpio.c                                               =
    |   6 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                                =
    |   5 +-
 drivers/mtd/nand/raw/hisi504_nand.c                                       =
    |   6 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                           =
    |   6 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                              =
    |   6 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                        =
    |   6 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                                        =
    |   6 +-
 drivers/mtd/nand/raw/marvell_nand.c                                       =
    |   6 +-
 drivers/mtd/nand/raw/meson_nand.c                                         =
    |   6 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                                        =
    |   6 +-
 drivers/mtd/nand/raw/mtk_nand.c                                           =
    |   6 +-
 drivers/mtd/nand/raw/mxc_nand.c                                           =
    |  16 +--
 drivers/mtd/nand/raw/mxic_nand.c                                          =
    |   5 +-
 drivers/mtd/nand/raw/nand_hynix.c                                         =
    |  13 +++
 drivers/mtd/nand/raw/nand_macronix.c                                      =
    |   5 +-
 drivers/mtd/nand/raw/ndfc.c                                               =
    |   6 +-
 drivers/mtd/nand/raw/omap2.c                                              =
    |   5 +-
 drivers/mtd/nand/raw/omap_elm.c                                           =
    |   5 +-
 drivers/mtd/nand/raw/orion_nand.c                                         =
    |  10 +-
 drivers/mtd/nand/raw/oxnas_nand.c                                         =
    |   6 +-
 drivers/mtd/nand/raw/pasemi_nand.c                                        =
    |   6 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c                              =
    |   6 +-
 drivers/mtd/nand/raw/plat_nand.c                                          =
    |   6 +-
 drivers/mtd/nand/raw/qcom_nandc.c                                         =
    |  11 +-
 drivers/mtd/nand/raw/renesas-nand-controller.c                            =
    |   6 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                           =
    |   6 +-
 drivers/mtd/nand/raw/s3c2410.c                                            =
    |   8 +-
 drivers/mtd/nand/raw/sh_flctl.c                                           =
    |   6 +-
 drivers/mtd/nand/raw/sharpsl.c                                            =
    |   6 +-
 drivers/mtd/nand/raw/socrates_nand.c                                      =
    |   6 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                    =
    |   6 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                         =
    |   6 +-
 drivers/mtd/nand/raw/tegra_nand.c                                         =
    |   6 +-
 drivers/mtd/nand/raw/vf610_nfc.c                                          =
    |   5 +-
 drivers/mtd/nand/raw/xway_nand.c                                          =
    |   6 +-
 drivers/mtd/nand/spi/Makefile                                             =
    |   3 +-
 drivers/mtd/nand/spi/core.c                                               =
    |   1 +
 drivers/mtd/nand/spi/esmt.c                                               =
    | 135 ++++++++++++++++++++++++
 drivers/mtd/parsers/Kconfig                                               =
    |   2 +-
 drivers/mtd/parsers/bcm63xxpart.c                                         =
    |   1 -
 drivers/mtd/spi-nor/controllers/nxp-spifi.c                               =
    |   4 +-
 drivers/mtd/spi-nor/core.c                                                =
    | 504 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h                                                =
    |  36 +++++--
 drivers/mtd/spi-nor/debugfs.c                                             =
    |   2 +
 drivers/mtd/spi-nor/macronix.c                                            =
    |  11 +-
 drivers/mtd/spi-nor/micron-st.c                                           =
    |  36 ++-----
 drivers/mtd/spi-nor/otp.c                                                 =
    |   8 +-
 drivers/mtd/spi-nor/sfdp.c                                                =
    | 107 ++++++++++++++++++-
 drivers/mtd/spi-nor/sfdp.h                                                =
    |  27 +++++
 drivers/mtd/spi-nor/spansion.c                                            =
    | 460 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++------------
 drivers/mtd/spi-nor/sst.c                                                 =
    |   2 +-
 drivers/mtd/spi-nor/swp.c                                                 =
    |   6 +-
 drivers/mtd/spi-nor/winbond.c                                             =
    |  24 +++--
 drivers/mtd/spi-nor/xilinx.c                                              =
    |   1 +
 include/linux/mtd/rawnand.h                                               =
    |   2 +-
 include/linux/mtd/spi-nor.h                                               =
    |  19 ++--
 include/linux/mtd/spinand.h                                               =
    |   1 +
 100 files changed, 1396 insertions(+), 430 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c
