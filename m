Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1086A1A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBXKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBXKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:40:56 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161ED1689E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:39:23 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6C6D224000F;
        Fri, 24 Feb 2023 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677235161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKdNXwdXDUM3kBJPxDnN39XMk2hvZBuRVfrmcyhLUVw=;
        b=eufzqW1/rnfmTp59q6F8+LEXuWocU/kZQS9nuxJbIj2g7qq7r6NKEDAS/fi03rM5cpBQmN
        QPxMR3N12OMgjBautdO+3nf/G8hd6XuAU07rg3OYaeAgJfltCmXnXUOIE3WtrvKxXTArPI
        biz1HLfS8rIicxPygpJal2EutlXI4jdfd5vbpgMERxiKTkHOuV6nfPtgLbtOJzUlL5xUB8
        TgIbaoOFUPPT1gPu3wiepzXtycggoBFE28TB1B6HwUIsxY8/52SSptUHI7dkFf7c8p+6+X
        Op4lWoUfvINWDXbOSiNB+2Vfx7Wd3y8dmLId9DW/rgQJyBV/MAZSqYcwt6Qufw==
Date:   Fri, 24 Feb 2023 11:39:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v6.3-rc1
Message-ID: <20230224113919.31bd95b3@xps-13>
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

This is the MTD PR for v6.3-rc1. Please mind the merge of the
mtd/fixes-for-6.2-rc4 tag by Tudor to save you from a conflict
resolution.

The merge of the different branches is recent, but all the commits
there have been laying in -next for several weeks.

Thanks, Miqu=C3=A8l

The following changes since commit c0f7ae27539fbac267384a7bfc58296ea7550d52:

  MAINTAINERS: Update email of Tudor Ambarus (2023-01-07 15:18:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.3

for you to fetch changes up to f4440abc08917d9a7032abb8a6a5d4b36ca979b6:

  Merge tag 'nand/for-6.3' into mtd/next (2023-02-23 10:28:29 +0100)

----------------------------------------------------------------
MTD changes:
* parsers: ofpart: add workaround for #size-cells 0
* dt-bindings: partitions: Fix partition node name pattern
* dataflash: remove duplicate SPI ID table

Raw NAND core changes:
* Check the data only read pattern only once
* Prepare the late addition of supported operation checks
* Support for sequential cache reads
* Fix nand_chip kdoc

Raw NAND driver changes:
* Fsl_elbc: Propagate HW ECC settings to HW
* Marvell: Add missing layouts
* Pasemi: Don't use static data to track per-device state
* Sunxi:
  - Fix the size of the last OOB region
  - Remove an unnecessary check
  - Remove an unnecessary check
  - Clean up chips after failed init
  - Precompute the ECC_CTL register value
  - Embed sunxi_nand_hw_ecc by value
  - Update OOB layout to match hardware
* tmio_nand: Remove driver
* vf610_nfc: Use regular comments for functions

SPI-NAND driver changes:
* Add support for AllianceMemory AS5F34G04SND
* Macronix: use scratch buffer for DMA operation

NAND ECC changes:
* Mediatek:
  - Add ECC support fot MT7986 IC
  - Add compatible for MT7986
  - dt-bindings: Split ECC engine with rawnand controller

SPI NOR changes:
* Misc core fixes

SPI NOR driver changes:
* Spansion: Minor fixes

----------------------------------------------------------------
Arnd Bergmann (2):
      mtd: dataflash: remove duplicate SPI ID table
      mtd: remove tmio_nand driver

Aviram Dali (1):
      mtd: rawnand: marvell: add missing layouts

Daniel Golle (1):
      mtd: spinand: macronix: use scratch buffer for DMA operation

Francesco Dolcini (1):
      mtd: parsers: ofpart: add workaround for #size-cells 0

JaimeLiao (1):
      mtd: rawnand: Support for sequential cache reads

Louis Rannou (1):
      mtd: spi-nor: Fix shift-out-of-bounds in spi_nor_set_erase_type

Mario Kicherer (1):
      mtd: spinand: Add support for AllianceMemory AS5F34G04SND

Miquel Raynal (6):
      mtd: rawnand: Check the data only read pattern only once
      mtd: rawnand: Prepare the late addition of supported operation checks
      mtd: rawnand: Fix nand_chip kdoc
      mtd: spi-nor: Create macros to define chip IDs and geometries
      Merge tag 'spi-nor/for-6.3' into mtd/next
      Merge tag 'nand/for-6.3' into mtd/next

Pali Roh=C3=A1r (1):
      mtd: rawnand: fsl_elbc: Propagate HW ECC settings to HW

Randy Dunlap (1):
      mtd: rawnand: vf610_nfc: use regular comments for functions

Rob Herring (1):
      dt-bindings: mtd: partitions: Fix partition node name pattern

Samuel Holland (7):
      mtd: rawnand: sunxi: Clean up chips after failed init
      mtd: rawnand: sunxi: Remove an unnecessary check
      mtd: rawnand: sunxi: Remove an unnecessary check
      mtd: rawnand: sunxi: Fix the size of the last OOB region
      mtd: rawnand: sunxi: Update OOB layout to match hardware
      mtd: rawnand: sunxi: Embed sunxi_nand_hw_ecc by value
      mtd: rawnand: sunxi: Precompute the ECC_CTL register value

Takahiro Kuwano (3):
      mtd: spi-nor: sfdp: Fix index value for SCCR dwords
      mtd: spi-nor: sfdp: Rename BFPT_DWORD() macro to SFDP_DWORD()
      mtd: spi-nor: sfdp: Use SFDP_DWORD() macro for optional parameter tab=
les

Tudor Ambarus (4):
      mtd: spi-nor: spansion: Consider reserved bits in CFR5 register
      mtd: spi-nor: spansion: Make CFRx reg fields generic
      mtd: spi-nor: Sort headers alphabetically
      Merge tag 'mtd/fixes-for-6.2-rc4' into spi-nor/next

Uwe Kleine-K=C3=B6nig (1):
      mtd: rawnand: pasemi: Don't use static data to track per-device state

Xiangsheng Hou (3):
      dt-bindings: mtd: Split ECC engine with rawnand controller
      dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986
      mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC

Zeng Heng (1):
      mtd: spi-nor: core: fix implicit declaration warning

 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml        | 155 +=
++++++++
 .../devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml          |  63 +=
+++
 Documentation/devicetree/bindings/mtd/mtk-nand.txt                 | 176 -=
---------
 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml   |   2 +-
 MAINTAINERS                                                        |   2 +-
 drivers/mtd/devices/mtd_dataflash.c                                |   9 -
 drivers/mtd/nand/ecc-mtk.c                                         |  28 +-
 drivers/mtd/nand/raw/Kconfig                                       |   7 -
 drivers/mtd/nand/raw/Makefile                                      |   1 -
 drivers/mtd/nand/raw/fsl_elbc_nand.c                               |   8 +
 drivers/mtd/nand/raw/marvell_nand.c                                |   7 +
 drivers/mtd/nand/raw/nand_base.c                                   | 149 +=
+++++++-
 drivers/mtd/nand/raw/nand_jedec.c                                  |   3 +-
 drivers/mtd/nand/raw/nand_onfi.c                                   |   3 +-
 drivers/mtd/nand/raw/pasemi_nand.c                                 |  63 +=
+--
 drivers/mtd/nand/raw/sunxi_nand.c                                  | 122 +=
++----
 drivers/mtd/nand/raw/tmio_nand.c                                   | 533 -=
-----------------------------
 drivers/mtd/nand/raw/vf610_nfc.c                                   |   4 +-
 drivers/mtd/nand/spi/Makefile                                      |   2 +-
 drivers/mtd/nand/spi/alliancememory.c                              | 153 +=
++++++++
 drivers/mtd/nand/spi/core.c                                        |   1 +
 drivers/mtd/nand/spi/macronix.c                                    |   3 +-
 drivers/mtd/parsers/ofpart_core.c                                  |  19 ++
 drivers/mtd/spi-nor/core.c                                         |  20 +-
 drivers/mtd/spi-nor/core.h                                         |  44 +=
+-
 drivers/mtd/spi-nor/debugfs.c                                      |   2 +-
 drivers/mtd/spi-nor/issi.c                                         |   2 +-
 drivers/mtd/spi-nor/macronix.c                                     |   2 +-
 drivers/mtd/spi-nor/sfdp.c                                         |  78 +=
+---
 drivers/mtd/spi-nor/sfdp.h                                         |   9 +-
 drivers/mtd/spi-nor/spansion.c                                     |  27 +-
 include/linux/mtd/rawnand.h                                        |  21 ++
 include/linux/mtd/spinand.h                                        |   1 +
 33 files changed, 783 insertions(+), 936 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.=
yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc=
-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
 delete mode 100644 drivers/mtd/nand/raw/tmio_nand.c
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
