Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F16610D43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJ1JbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJ1JbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:31:17 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E44DD3A1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:31:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 916DE24000E;
        Fri, 28 Oct 2022 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666949474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LqqeKR8+utpjuZxM0EHaE9N4OZLTd3lH1Adt1NpIXF8=;
        b=GAzA8O3h0KhXqF33H5+uc0+cxbB4hXn9Q0jnW6whhGEmVSeGytzqQaGChh5kyR1XZi7EJ+
        gygpk7DvnycYc7UdJgPtJEfubCn/4a114m5wJvmqpPNPmM7k+McI8/a4T97+pXRuBnQPYc
        lfmNjL9ZFuGtL7U+kg/eUGMXBVTQN/OkQqomzJ/N3DYCKbMRzoiioNf4DslQQmE8cWiOm7
        xwQwjuJvAJhadRjC6v6NcAX85nn2VWOE+BDoXIqE34L55sqYmYdP4j4JZcb3MBNaWH6JSA
        Hwucosdcs2yr8vev6SgzLzmGLVjq1GRIveWLESU8I3sDWItb5UE07OZAV0LoJQ==
Date:   Fri, 28 Oct 2022 11:31:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v6.1-rc3
Message-ID: <20221028113111.20508656@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is an MTD fixes PR for the next -rc.

Thanks,
Miqu=C3=A8l

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.1-rc3

for you to fetch changes up to 05e258c6ec669d6d18c494ea03d35962d6f5b545:

  mtd: parsers: bcm47xxpart: Fix halfblock reads (2022-10-18 11:20:12 +0200)

----------------------------------------------------------------
MTD core:
* partitions: Add missing of_node_get() in dynamic partitions code

Parser drivers:
* bcm47xxpart: Fix halfblock reads

Raw NAND controller drivers:
* marvell: Use correct logic for nand-keep-config
* tegra: Fix PM disable depth imbalance in probe
* intel: Add missing of_node_put() in ebu_nand_probe()

SPI-NOR core changes:
* Ignore -ENOTSUPP in spi_nor_init()

----------------------------------------------------------------
Linus Walleij (1):
      mtd: parsers: bcm47xxpart: Fix halfblock reads

Mika Westerberg (1):
      mtd: spi-nor: core: Ignore -ENOTSUPP in spi_nor_init()

Rafa=C5=82 Mi=C5=82ecki (1):
      mtd: core: add missing of_node_get() in dynamic partitions code

Tony O'Brien (1):
      mtd: rawnand: marvell: Use correct logic for nand-keep-config

Yang Yingliang (1):
      mtd: rawnand: intel: Add missing of_node_put() in ebu_nand_probe()

Zhang Qilong (1):
      mtd: rawnand: tegra: Fix PM disable depth imbalance in probe

 drivers/mtd/mtdcore.c                        |  2 +-
 drivers/mtd/nand/raw/intel-nand-controller.c | 23 +++++++++++++++--------
 drivers/mtd/nand/raw/marvell_nand.c          |  2 +-
 drivers/mtd/nand/raw/tegra_nand.c            |  4 +++-
 drivers/mtd/parsers/bcm47xxpart.c            |  4 ++--
 drivers/mtd/spi-nor/core.c                   |  4 +++-
 6 files changed, 25 insertions(+), 14 deletions(-)
