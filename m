Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147A65F7A75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJGPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJGPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:23:44 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952310B7A5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:23:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9B695C0006;
        Fri,  7 Oct 2022 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665156220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPTQ4yqoGO4pCgLI+Paq/nsAZsdmLnJqVM1pawvOiww=;
        b=VEOeqFoLbdt6ce4kTTVsAYQHK3qhupgdz02DHTHNldoU4NFWPPIOVyiztVhsXGjpfSwgAK
        HSZ+Uqtvk568NOR819wauh/wlhV0lUgTFy497oNMnjw8JvhY6Cg6zCLWKGrocJ28HzYndz
        0HELkpVYrZSAVghjwlU8R8JnGcpDvHLISmcZhw5nsxlJErXPvknXA5oTC1HkEaQ47ggk8r
        RoUxMfP9m7vsG10Xel/IsUnVmKDF5+OFWu2icCYKLhAZxyRuTgJljTKuLSO6tW7oQuJyFX
        KXddmqgcPZIIujIEXNHHIwRlaF2OWGA9q+yaNXPyCrSqIHIrLsWDOF+f48XGcw==
Date:   Fri, 7 Oct 2022 17:23:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.1
Message-ID: <20221007172337.32e05296@xps-13>
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

This is the MTD PR for v6.1-rc1

Thanks,
Miqu=C3=A8l

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.1

for you to fetch changes up to 63c30d70443064d71340e02024b4a463db5c77d9:

  Merge tag 'nand/for-6.1' into mtd/next (2022-10-07 16:56:14 +0200)

----------------------------------------------------------------
Core MTD changes:
* mtdchar: add MEMREAD ioctl
* Add ECC error accounting for each read request
* always initialize 'stats' in struct mtd_oob_ops
* Track maximum number of bitflips for each read request
* Fix repeated word in comment
* Move from strlcpy with unused retval to strscpy
* Fix a typo in a comment
* Add binding for U-Boot bootloader partitions

MTD device drivers changes:
* FTL: use container_of() rather than cast
* docg3:
  - Use correct function names in comment blocks
  - Check the return value of devm_ioremap() in the probe
* physmap-core: Fix NULL pointer dereferencing in of_select_probe_type()
* parsers: add Broadcom's U-Boot parser

Raw NAND core changes:
* Replace of_gpio_named_count() by gpiod_count()
  - Remove misguided comment of nand_get_device()
  - bbt: Use the bitmap API to allocate bitmaps

Raw NAND controller drivers changes:
* Meson:
  - Stop supporting legacy clocks
  - Refine resource getting in probe
  - Convert bindings to yaml
  - Fix clock handling and update the bindings accordingly
  - Fix bit map use in meson_nfc_ecc_correct()
* bcm47xx:
  - Fix spelling typo in comment
* STM32 FMC2:
  - Switch to using devm_fwnode_gpiod_get()
  - Fix dma_map_sg error check
* Cadence:
  - Remove an unneeded result variable
* Marvell:
  - Fix error handle regarding dma_map_sg
* Orion:
  - Use devm_clk_get_optional()
* Cafe:
  - Use correct function name in comment block
* Atmel:
  - Unmap streaming DMA mappings
* Arasan:
  - Stop using 0 as NULL pointer
* GPMI:
  - Fix typo 'the the' in comment
* BRCM:
  - Add individual glue driver selection
  - Move Kconfig to driver folder
* FSL: Fix none ECC mode
* Intel:
  - Use devm_platform_ioremap_resource_byname()
  - Remove unused clk_rate member from struct ebu_nand
  - Remove unused nand_pa member from ebu_nand_cs
  - Don't re-define NAND_DATA_IFACE_CHECK_ONLY
  - Remove undocumented compatible string
  - Fix compatible string in the bindings
  - Read the chip-select line from the correct OF node
  - Fix maximum chip select value in the bindings

----------------------------------------------------------------
Andy Shevchenko (1):
      mtd: rawnand: Replace of_gpio_named_count() by gpiod_count()

ChenXiaoSong (1):
      mtd: rawnand: remove misguided comment of nand_get_device()

Christophe JAILLET (3):
      mtd: Fix a typo in a comment
      mtd: nand: bbt: Use the bitmap API to allocate bitmaps
      mtd: rawnand: orion: Use devm_clk_get_optional()

Colin Ian King (2):
      mtd: devices: docg3: Use correct function names in comment blocks
      mtd: rawnand: cafe: Use correct function name in comment block

Dan Carpenter (1):
      mtd: rawnand: meson: fix bit map use in meson_nfc_ecc_correct()

Dmitry Torokhov (1):
      mtd: rawnand: stm32_fmc2: switch to using devm_fwnode_gpiod_get()

Florian Fainelli (2):
      mtd: rawnand: brcmnand: Move Kconfig to driver folder
      mtd: rawnand: brcmnand: Add individual glue driver selection

GONG, Ruiqi (1):
      mtd: rawnand: arasan: stop using 0 as NULL pointer

Gaosheng Cui (1):
      mtd: ftl: use container_of() rather than cast

Jack Wang (2):
      mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
      mtd: rawnand: marvell: Fix error handle regarding dma_map_sg

Jiangshan Yi (1):
      mtd: rawnand: bcm47xx: fix spelling typo in comment

Liang Yang (5):
      dt-bindings: nand: meson: fix meson nfc clock
      mtd: rawnand: meson: fix the clock
      mtd: rawnand: meson: refine resource getting in probe
      dt-bindings: nand: meson: convert txt to yaml
      mtd: rawnand: meson: stop supporting legacy clocks

Martin Blumenstingl (8):
      dt-bindings: mtd: intel: lgm-nand: Fix compatible string
      dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
      mtd: rawnand: intel: Read the chip-select line from the correct OF no=
de
      mtd: rawnand: intel: Remove undocumented compatible string
      mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
      mtd: rawnand: intel: Remove unused nand_pa member from ebu_nand_cs
      mtd: rawnand: intel: Remove unused clk_rate member from struct ebu_na=
nd
      mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()

Micha=C5=82 K=C4=99pie=C5=84 (4):
      mtd: track maximum number of bitflips for each read request
      mtd: always initialize 'stats' in struct mtd_oob_ops
      mtd: add ECC error accounting for each read request
      mtdchar: add MEMREAD ioctl

Miquel Raynal (1):
      Merge tag 'nand/for-6.1' into mtd/next

Pali Roh=C3=A1r (1):
      mtd: rawnand: fsl_elbc: Fix none ECC mode

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: mtd: partitions: add binding for U-Boot bootloader
      mtd: parsers: add Broadcom's U-Boot parser

Slark Xiao (1):
      mtd: rawnand: gpmi: Fix typo 'the the' in comment

Tudor Ambarus (1):
      mtd: rawnand: atmel: Unmap streaming DMA mappings

William Dean (1):
      mtd: devices: docg3: check the return value of devm_ioremap() in the =
probe

Wolfram Sang (1):
      mtd: move from strlcpy with unused retval to strscpy

Zeng Jingxiang (1):
      mtd: physmap-core: Fix NULL pointer dereferencing in of_select_probe_=
type()

wangjianli (1):
      mtd: fix repeated word in comment

ye xingchen (1):
      mtd: rawnand: cadence: Remove an unneeded result variable

 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt              =
            |  60 -----------------------------------------
 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml             =
            |  93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 Documentation/devicetree/bindings/mtd/{intel,lgm-nand.yaml =3D> intel,lgm-=
ebunand.yaml} |   8 +++---
 Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml              =
            |  49 ++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/block2mtd.c                                           =
            |   2 +-
 drivers/mtd/devices/docg3.c                                               =
            |  21 ++++++++++++---
 drivers/mtd/ftl.c                                                         =
            |   4 +--
 drivers/mtd/inftlcore.c                                                   =
            |   6 ++---
 drivers/mtd/maps/physmap-core.c                                           =
            |   3 +++
 drivers/mtd/mtdchar.c                                                     =
            | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdconcat.c                                                   =
            |   2 +-
 drivers/mtd/mtdcore.c                                                     =
            |   5 ++++
 drivers/mtd/mtdpstore.c                                                   =
            |   2 +-
 drivers/mtd/mtdswap.c                                                     =
            |   6 ++---
 drivers/mtd/nand/bbt.c                                                    =
            |   7 ++---
 drivers/mtd/nand/onenand/onenand_base.c                                   =
            |  16 +++++++++--
 drivers/mtd/nand/onenand/onenand_bbt.c                                    =
            |   2 +-
 drivers/mtd/nand/raw/Kconfig                                              =
            |  24 ++---------------
 drivers/mtd/nand/raw/arasan-nand-controller.c                             =
            |   2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c                              =
            |   1 +
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c                          =
            |   2 +-
 drivers/mtd/nand/raw/brcmnand/Kconfig                                     =
            |  49 ++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/Makefile                                    =
            |   8 +++---
 drivers/mtd/nand/raw/cadence-nand-controller.c                            =
            |   5 +---
 drivers/mtd/nand/raw/cafe_nand.c                                          =
            |   2 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                                      =
            |  28 ++++++++++---------
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                                =
            |   2 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                              =
            |  28 +++++++++----------
 drivers/mtd/nand/raw/marvell_nand.c                                       =
            |   8 +++++-
 drivers/mtd/nand/raw/meson_nand.c                                         =
            |  88 ++++++++++++++++++++++++++++++---------------------------=
---
 drivers/mtd/nand/raw/nand_base.c                                          =
            |  15 ++++++++---
 drivers/mtd/nand/raw/nand_bbt.c                                           =
            |   8 +++---
 drivers/mtd/nand/raw/orion_nand.c                                         =
            |  17 ++++--------
 drivers/mtd/nand/raw/sm_common.c                                          =
            |   2 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                    =
            |  13 ++++-----
 drivers/mtd/nand/spi/core.c                                               =
            |  10 +++++++
 drivers/mtd/nftlcore.c                                                    =
            |   6 ++---
 drivers/mtd/parsers/Kconfig                                               =
            |  10 +++++++
 drivers/mtd/parsers/Makefile                                              =
            |   1 +
 drivers/mtd/parsers/brcm_u-boot.c                                         =
            |  84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/parsers/cmdlinepart.c                                         =
            |   4 +--
 drivers/mtd/sm_ftl.c                                                      =
            |   4 +--
 drivers/mtd/ssfdc.c                                                       =
            |   2 +-
 drivers/mtd/tests/nandbiterrs.c                                           =
            |   2 +-
 drivers/mtd/tests/oobtest.c                                               =
            |   8 +++---
 drivers/mtd/tests/readtest.c                                              =
            |   2 +-
 fs/jffs2/wbuf.c                                                           =
            |   6 ++---
 include/linux/mtd/mtd.h                                                   =
            |   7 +++++
 include/uapi/mtd/mtd-abi.h                                                =
            |  64 ++++++++++++++++++++++++++++++++++++++++----
 49 files changed, 694 insertions(+), 243 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nan=
d.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nan=
d.yaml
 rename Documentation/devicetree/bindings/mtd/{intel,lgm-nand.yaml =3D> int=
el,lgm-ebunand.yaml} (91%)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/u-boot=
.yaml
 create mode 100644 drivers/mtd/nand/raw/brcmnand/Kconfig
 create mode 100644 drivers/mtd/parsers/brcm_u-boot.c
