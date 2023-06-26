Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22073DCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjFZLDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFZLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:03:04 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761F19A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:02:57 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687777375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fo2ATDB1zBJj190i21Ii3BavvfifjghjYzBuaaonUig=;
        b=pqQq/X6inCppJmNOWFE/H/tX+8VBfAyqsDE8oDYNip/iokUfTlmDeRS1LV90TUWtsjBU4t
        U48jYuFkaG33o1fOkkONR3iakXFR85PI6fYhKciBSjXv8Sz8S4eqzLXIAunnoYhazJDH25
        Ssa9jmVxIr2HxjpoltOpVVQSO/o4gJS4ilNTaDFpxzJVtExWn9mt2/mZnxwoWMZ+ElqkGL
        9o3Oo0XR2EnBXWNwFhQRg1KoNYMJvj2VtObNm1gcUunI3OtIS3G1MCZK3apYPupZQxCvdK
        ukcS7dtyjor8Fsz1FsirgVhJk5ofCxTDpggiNWxR7GlMYLfZeQlXDZ407RlOog==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B690140006;
        Mon, 26 Jun 2023 11:02:54 +0000 (UTC)
Date:   Mon, 26 Jun 2023 13:02:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.5-rc1
Message-ID: <20230626130252.7bc89a45@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 6.5-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.5

for you to fetch changes up to cf431a5998326a0468532a188a188ac2c8e9c55d:

  Merge branch 'nand/next' into mtd/next (2023-06-23 19:02:09 +0200)

----------------------------------------------------------------
Core MTD changes:
* otp:
  - Put factory OTP/NVRAM into the entropy pool
  - Clean up on error in mtd_otp_nvmem_add()

MTD devices changes:
* sm_ftl: Fix typos in comments
* Use SPDX license headers
* pismo: Switch back to use i2c_driver's .probe()
* mtdpart: Drop useless LIST_HEAD
* st_spi_fsm: Use the devm_clk_get_enabled() helper function

DT binding changes:
* partitions:
  - Include TP-Link SafeLoader in allowed list
  - Add missing type for "linux,rootfs"
* Extend the nand node names filter
* Create a file for raw NAND chip properties
* Mark nand-ecc-placement deprecated
* Describe nand-ecc-mode
* Prevent NAND chip unevaluated properties in all NAND bindings with a NAND=
 chip
  reference.
* Qcom: Fix a property position
* Marvell: Convert to YAML DT schema

Raw NAND chip drivers changes:
* Macronix: OTP access for MX30LFxG18AC
* Add basic Sandisk manufacturer ops
* Add support for Sandisk SDTNQGAMA

Raw NAND controller driver changes:
* Meson:
  - Replace integer consts with proper defines
  - Allow waiting w/o wired ready/busy pin
  - Check buffer length validity
  - Fix unaligned DMA buffers handling
  - dt-bindings: Fix 'nand-rb' property
* Arasan: Revert "mtd: rawnand: arasan: Prevent an unsupported configuratio=
n"
  as this limitation is no longer true thanks to the recent efforts in impr=
oving
  the clocks support in this driver

SPI-NAND changes:
* Gigadevice: add support for GD5F2GQ5xExxH
* Macronix: Add support for serial NAND flashes

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      Revert "mtd: rawnand: arasan: Prevent an unsupported configuration"

Arseniy Krasnov (6):
      mtd: rawnand: meson: replace integer consts with proper defines
      dt-bindings: nand: meson: Fix 'nand-rb' property
      mtd: rawnand: meson: waiting w/o wired ready/busy pin
      mtd: rawnand: meson: check buffer length
      mtd: rawnand: meson: fix unaligned DMA buffers handling
      mtd: rawnand: macronix: OTP access for MX30LFxG18AC

Bo Liu (1):
      mtd: sm_ftl: Fix typos in comments

Christophe JAILLET (2):
      mtd: st_spi_fsm: Use the devm_clk_get_enabled() helper function
      mtd: mtdpart: Drop useless LIST_HEAD

Dan Carpenter (1):
      mtd: otp: clean up on error in mtd_otp_nvmem_add()

JaimeLiao (1):
      mtd: spinand: macronix: Add support for serial NAND flash

Johan Jonker (2):
      mtd: rawnand: add basic sandisk manufacturer ops
      mtd: rawnand: add support for the Sandisk SDTNQGAMA chip

Linus Walleij (2):
      mtd: chips: Use SPDX license headers
      mtd: otp: Put factory OTP/NVRAM into the entropy pool

Md Sadre Alam (1):
      mtd: spinand: gigadevice: add support for GD5F2GQ5xExxH

Miquel Raynal (18):
      dt-bindings: mtd: Accept nand related node names
      dt-bindings: mtd: Create a file for raw NAND chip properties
      dt-bindings: mtd: Mark nand-ecc-placement deprecated
      dt-bindings: mtd: Describe nand-ecc-mode
      dt-bindings: mtd: qcom: Fix a property position
      dt-bindings: mtd: qcom: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: ingenic: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: sunxi: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: meson: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: brcmnand: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: denali: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: intel: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: rockchip: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: stm32: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: mediatek: Reference raw-nand-chip.yaml
      dt-bindings: mtd: mediatek: Prevent NAND chip unevaluated properties
      dt-bindings: mtd: ti,am654: Prevent unevaluated properties
      Merge branch 'nand/next' into mtd/next

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: mtd: partitions: Include TP-Link SafeLoader in allowed l=
ist

Rob Herring (1):
      dt-bindings: mtd: partition: Add missing type for "linux,rootfs"

Uwe Kleine-K=C3=B6nig (1):
      mtd: maps: pismo: Switch back to use i2c_driver's .probe()

Vadym Kochan (1):
      dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme

 Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml |   5 =
+--
 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml       |  10 =
+++++
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml            |   3 =
++
 Documentation/devicetree/bindings/mtd/denali,nand.yaml              |   9 =
++--
 Documentation/devicetree/bindings/mtd/ingenic,nand.yaml             |   4 =
++
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml        |   5 =
+--
 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml  | 226 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++
 Documentation/devicetree/bindings/mtd/marvell-nand.txt              | 126 =
--------------------------------------------------------
 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml         |   3 =
+-
 Documentation/devicetree/bindings/mtd/mtd.yaml                      |   2 =
+-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml          |  85 =
+-------------------------------------
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml     |   1 +
 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml    |   1 +
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml               |  45 =
++++++++++++--------
 Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml            | 111 =
+++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml |   3 =
++
 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml       |   3 =
++
 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml            |   2 +
 MAINTAINERS                                                         |   1 -
 drivers/mtd/chips/cfi_cmdset_0001.c                                 |   3 =
+-
 drivers/mtd/chips/cfi_cmdset_0002.c                                 |   3 =
+-
 drivers/mtd/chips/cfi_cmdset_0020.c                                 |   3 =
+-
 drivers/mtd/chips/cfi_probe.c                                       |   3 =
+-
 drivers/mtd/chips/cfi_util.c                                        |   3 =
+-
 drivers/mtd/chips/gen_probe.c                                       |   2 =
+-
 drivers/mtd/chips/jedec_probe.c                                     |   3 =
+-
 drivers/mtd/chips/map_ram.c                                         |   3 =
+-
 drivers/mtd/chips/map_rom.c                                         |   3 =
+-
 drivers/mtd/devices/st_spi_fsm.c                                    |  28 =
+++----------
 drivers/mtd/maps/pismo.c                                            |   2 =
+-
 drivers/mtd/mtdcore.c                                               |  21 =
++++++++++
 drivers/mtd/mtdpart.c                                               |   1 -
 drivers/mtd/nand/raw/Makefile                                       |   1 +
 drivers/mtd/nand/raw/arasan-nand-controller.c                       |  15 =
-------
 drivers/mtd/nand/raw/internals.h                                    |   1 +
 drivers/mtd/nand/raw/meson_nand.c                                   | 134 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mtd/nand/raw/nand_ids.c                                     |   5 =
++-
 drivers/mtd/nand/raw/nand_macronix.c                                | 167 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_sandisk.c                                 |  26 =
++++++++++++
 drivers/mtd/nand/spi/gigadevice.c                                   |  10 =
+++++
 drivers/mtd/nand/spi/macronix.c                                     |  20 =
+++++++++
 drivers/mtd/sm_ftl.c                                                |   2 =
+-
 42 files changed, 805 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-cont=
roller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
 create mode 100644 drivers/mtd/nand/raw/nand_sandisk.c
