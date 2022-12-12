Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16693649B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLLJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLLJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:32:30 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C725A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:32:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 466D510000B;
        Mon, 12 Dec 2022 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670837547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bYQ5J4t/p17mqDvlhyzsxzTLD89yLXwIRu5VnMMXcf0=;
        b=XnZ5te8FvBR6twq5GyYLp5rlcQDFPX9W7E9WER03E44Nj4jLQtZYBV5eZcMUAF9YkK5y/T
        AoaET+haTaLdlz3GH+5MERRDSJR9VMVIu0+yJ5HDuSCQNRvqNxugCFcDvK7LeU479fDwvv
        lTVU7Rf5aA9/2gocSqHmYnOi+seFp2TjzrdGSdthLZKLCSpe58WzbcZ6ulSCc+L/U6Y9af
        mR5ecFKiN19rjcwf4VgoUa5G2iCYot9xG6nxgNkFyBClSCs2nwsX2aO+PmwCG0ze82m8WO
        L5RyEFpzKMH9PtX6Upm1tFn6yFZp1D/GfvDY+IZKV/hdYkjBSiN1R1jnga1s5g==
Date:   Mon, 12 Dec 2022 10:32:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.2
Message-ID: <20221212103221.19de8d3d@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD PR for 6.2-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit
30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
  tags/mtd/for-6.2

for you to fetch changes up to a34506e08db7ccce160a259e4b00b1e307486c59:

  Merge tag 'spi-nor/for-6.2' into mtd/next (2022-12-05 15:40:59 +0100)

----------------------------------------------------------------
MTD core changes:
* Fix refcount error in del_mtd_device()
* Fix possible resource leak in init_mtd()
* Set ROOT_DEV for partitions marked as rootfs in DT
* Describe marking rootfs partitions in the bindings
* Fix device name leak when register device failed in add_mtd_device()
* Try to find OF node for every MTD partition
* simplify (a bit) code find partition-matching dynamic OF node

MTD driver changes:
* pxa2xx-flash maps: fix memory leak in probe
* BCM parser: refer to ARCH_BCMBCA instead of ARCH_BCM4908
* lpddr2_nvm: Fix possible null-ptr-deref
* inftlcore: fix repeated words in comments
* lart: remove driver
* tplink:
  - Add TP-Link SafeLoader partitions table parser and bindings
  - Describe TP-Link SafeLoader parser
  - Describe TP-Link SafeLoader dynamic subpartitions
* mtdoops:
  - Panic caused mtdoops to call mtdoops_erase function immediately
  - Add mtdoops_erase function and move mtdoops_inc_counter to after it
  - Change printk() to counterpart pr_ functions

MTD binding cleanup:
* Fixed-partitions: Fix 'sercomm,scpart-id' schema
* Standardize the style in the examples
* Drop object types when referencing other files
* Argue in favor of keeping additionalProperties set to true
* NVMEM-cells:
  - Inherit from MTD partitions
  - Drop range property from example
* Partitions:
  - Change qcom,smem-part partition type
  - Constrain the list of parsers
* Physmap: Reuse the generic definitions
* SPI-NOR: Drop common properties
* Sunxi-nand: Add an example to validate the bindings
* Onenand: Mention the expected node name
* Ingenic: Mark partitions in the controller node as deprecated
* NAND:
  - Standardize the child node name
  - Drop common properties already defined in generic files
  - nand-chip.yaml should reference mtd.yaml
* Remove useless file about partitions
* Clarify all partition subnodes

SPI NOR core changes:
* Add support for flash reset using the dt reset-gpios property.
* Update hwcaps.mask to include 8D-8D-8D read and page program ops
  when xSPI profile 1.0 table is defined.
* Bypass zero erase size in spi_nor_find_best_erase_type().
* Fix select_uniform_erase to skip 0 erase size
* Add generic flash driver. If a flash is not found in the flash_info
  array, fall back to the generic flash driver which is described solely
  by the flash's SFDP tables.
* Fix the number of bytes for the dummy cycles in
  spi_nor_spimem_check_readop().
* Introduce SPI_NOR_QUAD_PP flag, as PP_1_1_4 is not SFDP discoverable.

SPI NOR manufacturer drivers changes:
* Spansion:
  - use PARSE_SFDP for s28hs512t,
  - add support for s28hl512t, s28hl01gt, and s28hs01gt.
* Gigadevice: Replace default_init() with post_bfpt() for gd25q256.
* Micron - ST: Enable locking for mt25qu256a.
* Winbond: Add support for W25Q512NW-IQ.
* ISSI: Use PARSE_SFDP and SPI_NOR_QUAD_PP.

Raw NAND core changes:
* Drop obsolete dependencies on COMPILE_TEST
* MAINTAINERS: rectify entry for MESON NAND controller bindings
* Drop EXPORT_SYMBOL_GPL for nanddev_erase()

Raw NAND driver changes:
* marvell: Enable NFC/DEVBUS arbiter
* gpmi: Use pm_runtime_resume_and_get instead of pm_runtime_get_sync
* mpc5121: Replace NO_IRQ by 0
* lpc32xx_{slc,mlc}:
  - Switch to using pm_ptr()
  - Switch to using gpiod API
* lpc32xx_mlc: Switch to using pm_ptr()
* cadence: Support 64-bit slave dma interface
* rockchip: Describe rk3128-nfc in the bindings
* brcmnand: Update interrupts description in the bindings

SPI-NAND driver changes:
* winbond:
  - Add Winbond W25N02KV flash support
  - Fix flash identification

----------------------------------------------------------------
Alexander Sverdlin (1):
      mtd: spi-nor: Check for zero erase size in
spi_nor_find_best_erase_type()

Allen-KH Cheng (1):
      mtd: spi-nor: Fix the number of bytes for the dummy cycles

Arnd Bergmann (1):
      mtd: remove lart flash driver

Christophe Leroy (1):
      mtd: rawnand: mpc5121: Replace NO_IRQ by 0

Dan Carpenter (1):
      mtd: parsers: tplink_safeloader: fix uninitialized variable bug

Dario Binacchi (1):
      mtd: nand: drop EXPORT_SYMBOL_GPL for nanddev_erase()

Dmitry Torokhov (2):
      mtd: rawnand: lpc32xx_mlc: switch to using gpiod API
      mtd: rawnand: lpc32xx_slc: switch to using gpiod API

Eliav Farber (1):
      mtd: spi-nor: micron-st: Enable locking for mt25qu256a

Gaosheng Cui (1):
      mtd: core: fix possible resource leak in init_mtd()

Geert Uytterhoeven (2):
      mtd: rawnand: lpc32xx_mlc: Switch to using pm_ptr()
      mtd: rawnand: lpc32xx_slc: Switch to using pm_ptr()

Hamish Martin (1):
      mtd: rawnand: marvell: Enable NFC/DEVBUS arbiter

Hui Tang (1):
      mtd: lpddr2_nvm: Fix possible null-ptr-deref

Jae Hyun Yoo (1):
      mtd: spi-nor: winbond: add support for W25Q512NW-IQ

Jean Delvare (1):
      mtd: rawnand: Drop obsolete dependencies on COMPILE_TEST

Jilin Yuan (1):
      mtd: inftlcore: fix repeated words in comments

Johan Jonker (1):
      dt-bindings: mtd: rockchip: add rockchip,rk3128-nfc

Jonathan Neusch=C3=A4fer (1):
      mtd: spi-nor: Fix formatting in spi_nor_read_raw() kerneldoc
comment

Lukas Bulwahn (2):
      MAINTAINERS: rectify entry for MESON NAND controller bindings
      mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908

Michael Walle (7):
      mtd: spi-nor: hide jedec_id sysfs attribute if not present
      mtd: spi-nor: sysfs: hide manufacturer if it is not set
      mtd: spi-nor: remember full JEDEC flash ID
      mtd: spi-nor: move function declaration out of sfdp.h
      mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
      mtd: spi-nor: add generic flash driver
      mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver

Mikhail Kshevetskiy (2):
      mtd: spinand: winbond: fix flash identification
      mtd: spinand: winbond: add Winbond W25N02KV flash support

Miquel Raynal (19):
      dt-bindings: mtd: Clarify all partition subnodes
      dt-bindings: mtd: Remove useless file about partitions
      dt-bindings: mtd: nand-chip: Reference mtd.yaml
      dt-bindings: mtd: nand: Drop common properties already defined in
generic files dt-bindings: mtd: nand: Standardize the child node name
      dt-bindings: mtd: ingenic: Mark partitions in the controller node
as deprecated dt-bindings: mtd: onenand: Mention the expected node name
      dt-bindings: mtd: sunxi-nand: Add an example to validate the
bindings dt-bindings: mtd: spi-nor: Drop common properties
      dt-bindings: mtd: physmap: Reuse the generic definitions
      dt-bindings: mtd: partitions: Constrain the list of parsers
      dt-bindings: mtd: partitions: Change qcom,smem-part partition type
      dt-bindings: mtd: nvmem-cells: Drop range property from example
      dt-bindings: mtd: nvmem-cells: Inherit from MTD partitions
      dt-bindings: mtd: Argue in favor of keeping additionalProperties
set to true dt-bindings: mtd: Drop object types when referencing other
files dt-bindings: mtd: Standardize the style in the examples
      Merge tag 'nand/for-6.2' into mtd/next
      Merge tag 'spi-nor/for-6.2' into mtd/next

Rafa=C5=82 Mi=C5=82ecki (8):
      mtd: core: simplify (a bit) code find partition-matching dynamic
OF node mtd: core: try to find OF node for every MTD partition
      dt-bindings: mtd: partitions: add TP-Link SafeLoader layout
      mtd: parsers: add TP-Link SafeLoader partitions table parser
      dt-bindings: mtd: partitions: support marking rootfs partition
      mtd: core: set ROOT_DEV for partitions marked as rootfs in DT
      dt-bindings: mtd: brcm,brcmnand: update interrupts description
      dt-bindings: mtd: partitions: allow SafeLoader dynamic
subpartitions

Ray Zhang (3):
      mtd: mtdoops: change printk() to counterpart pr_ functions
      mtd: mtdoops: add mtdoops_erase function and move
mtdoops_inc_counter to after it mtd: mtdoops: panic caused mtdoops to
call mtdoops_erase function immediately

Rob Herring (1):
      dt-bindings: mtd: fixed-partitions: Fix 'sercomm,scpart-id' schema

Sai Krishna Potthuri (2):
      dt-bindings: mtd: spi-nor: Add reset-gpios property
      mtd: spi-nor: Add support for flash reset

Shang XiaoJing (1):
      mtd: core: Fix refcount error in del_mtd_device()

Sudip Mukherjee (2):
      mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
      mtd: spi-nor: add SFDP fixups for Quad Page Program

Takahiro Kuwano (4):
      mtd: spi-nor: sfdp: Update params->hwcaps.mask at xSPI profile
1.0 table parse mtd: spi-nor: spansion: Remove NO_SFDP_FLAGS from
s28hs512t info mtd: spi-nor: spansion: Rename s28hs512t prefix
      mtd: spi-nor: spansion: Add s28hl512t, s28hl01gt, and s28hs01gt
info

Tudor Ambarus (3):
      mtd: spi-nor: spansion: Replace hardcoded values for
addr_nbytes/addr_mode_nbytes mtd: spi-nor: micron-st.c: Replace
hardcoded values for addr_nbytes/addr_mode_nbytes mtd: spi-nor: core:
Add an error message when failing to exit the 4-byte address mode

Valentin Korenblit (1):
      mtd: rawnand: cadence: support 64-bit slave dma interface

Yaliang Wang (1):
      mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init
with gd25q256_post_bfpt

Zhang Qilong (1):
      mtd: rawnand: gpmi: using pm_runtime_resume_and_get instead of
pm_runtime_get_sync

Zhang Xiaoxu (1):
      mtd: Fix device name leak when register device failed in
add_mtd_device()

Zheng Yongjun (1):
      mtd: maps: pxa2xx-flash: fix memory leak in probe

 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor |   6 +
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml          |  34 +-
 .../devicetree/bindings/mtd/arasan,nand-controller.yaml |   5 +-
 .../devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml    |  30 +-
 Documentation/devicetree/bindings/mtd/atmel-nand.txt    |   6 +-
 .../devicetree/bindings/mtd/brcm,brcmnand.yaml          |  96 ++--
 Documentation/devicetree/bindings/mtd/denali,nand.yaml  |   2 +-
 Documentation/devicetree/bindings/mtd/ingenic,nand.yaml | 116 ++--
 .../devicetree/bindings/mtd/intel,lgm-ebunand.yaml      |  48 +-
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml          |  20 +-
 Documentation/devicetree/bindings/mtd/lpc32xx-mlc.txt   |   2 +-
 Documentation/devicetree/bindings/mtd/lpc32xx-slc.txt   |   2 +-
 .../devicetree/bindings/mtd/microchip,mchp48l640.yaml   |  14 +-
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml  |   7 +-
 Documentation/devicetree/bindings/mtd/mtd.yaml          |  24 +-
 Documentation/devicetree/bindings/mtd/mtk-nand.txt      |   2 +-
 Documentation/devicetree/bindings/mtd/nand-chip.yaml    |   4 +
 .../devicetree/bindings/mtd/nand-controller.yaml        |   2 +-
 Documentation/devicetree/bindings/mtd/partition.txt     |  33 --
 .../bindings/mtd/partitions/arm,arm-firmware-suite.yaml |   2 +
 .../mtd/partitions/brcm,bcm4908-partitions.yaml         |   2 +
 .../mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml    |   2 +
 .../bindings/mtd/partitions/fixed-partitions.yaml       |  30 +-
 .../bindings/mtd/partitions/linksys,ns-partitions.yaml  |   2 +
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml |   4 +-
 .../devicetree/bindings/mtd/partitions/partition.yaml   |   5 +
 .../devicetree/bindings/mtd/partitions/partitions.yaml  |  41 ++
 .../bindings/mtd/partitions/qcom,smem-part.yaml         |  32 +-
 .../devicetree/bindings/mtd/partitions/redboot-fis.yaml |   6 +
 .../mtd/partitions/tplink,safeloader-partitions.yaml    |  57 ++
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml   | 117 ++--
 .../bindings/mtd/rockchip,nand-controller.yaml          |   4 +-
 .../devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml     |  47 +-
 .../devicetree/bindings/mtd/ti,am654-hbmc.yaml          |  36 +-
 .../devicetree/bindings/mtd/ti,gpmc-onenand.yaml        |   3 +
 MAINTAINERS                                             |   2 +-
 drivers/mtd/devices/Kconfig                             |   8 -
 drivers/mtd/devices/Makefile                            |   1 -
 drivers/mtd/devices/lart.c                              | 682
 ----------------------- drivers/mtd/inftlcore.c
          |   2 +- drivers/mtd/lpddr/lpddr2_nvm.c
    |   2 + drivers/mtd/maps/pxa2xx-flash.c                         |
 2 + drivers/mtd/mtdcore.c                                   |  55 +-
 drivers/mtd/mtdoops.c                                   | 109 ++--
 drivers/mtd/nand/core.c                                 |   3 +-
 drivers/mtd/nand/raw/Kconfig                            |   6 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c          |  70 ++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c              |  12 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                      |  46 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                      |  43 +-
 drivers/mtd/nand/raw/marvell_nand.c                     |   4 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                      |   2 +-
 drivers/mtd/nand/spi/winbond.c                          |  79 ++-
 drivers/mtd/parsers/Kconfig                             |  19 +-
 drivers/mtd/parsers/Makefile                            |   1 +
 drivers/mtd/parsers/tplink_safeloader.c                 | 150 +++++
 drivers/mtd/spi-nor/core.c                              |  85 ++-
 drivers/mtd/spi-nor/core.h                              |   5 +
 drivers/mtd/spi-nor/debugfs.c                           |   2 +-
 drivers/mtd/spi-nor/gigadevice.c                        |  24 +-
 drivers/mtd/spi-nor/issi.c                              |   5 +-
 drivers/mtd/spi-nor/micron-st.c                         |  12 +-
 drivers/mtd/spi-nor/sfdp.c                              |  37 +-
 drivers/mtd/spi-nor/sfdp.h                              |   2 -
 drivers/mtd/spi-nor/spansion.c                          |  61 +-
 drivers/mtd/spi-nor/sysfs.c                             |  20 +-
 drivers/mtd/spi-nor/winbond.c                           |   3 +
 include/linux/mtd/nand.h                                |   1 -
 include/linux/mtd/spi-nor.h                             |   3 +
 69 files changed, 1149 insertions(+), 1252 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partition.txt
 create mode 100644
 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
 create mode 100644
 Documentation/devicetree/bindings/mtd/partitions/tplink,safeloader-partiti=
ons.yaml
 delete mode 100644 drivers/mtd/devices/lart.c create mode 100644
 drivers/mtd/parsers/tplink_safeloader.c
