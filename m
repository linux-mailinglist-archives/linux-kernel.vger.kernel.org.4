Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469846C9D69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjC0IQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjC0IQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:16:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580749F6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:16:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 17172C0007;
        Mon, 27 Mar 2023 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679904968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AhGcTxV5p11uOzrMrZoPGhijjb2UBKpN1RgomDHQwK8=;
        b=RKdSJvsO6r8SSdawuu2X02LK6fBfTqZbPN+rhzLPNQ+pgZih4BMdYiF8aE5HAolXFeJKJG
        zcN9qSUAcnu65BlflxFhGRdvVBSAMPIW3nOyqqktcG2wvblKB387UWJJsUQZ99AyVy1Ys3
        FyX+aa7bA0QTpV7XklYQuCe+5c4Fjh9lrqoX+pZ3WFso7coUJ9+2augZBLKeIebbRBrJP0
        ydWX1y699tTCna4i7wWsZVPiUNgcp7y3uyiazBMXZA0lh9pDHFrSGl3FEd2f7uY2+vHZJY
        RYNPpykUY60uoJ/QG2yBStKCPUPaDB9jTlC7RDvX7jn6s0X147SvT2ASKXpo7w==
Date:   Mon, 27 Mar 2023 10:16:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.3-rc5
Message-ID: <20230327101605.5cfd4f66@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is an MTD fixes PR for the next -rc.

Thanks,
Miqu=C3=A8l

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.3-rc5

for you to fetch changes up to e732e39ed9929c05fd219035bc9653ba4100d4fa:

  mtd: rawnand: meson: invalidate cache on polling ECC bit (2023-03-22 16:5=
9:29 +0100)

----------------------------------------------------------------
Raw NAND controller driver fixes:
* meson:
  - Invalidate cache on polling ECC bit
  - Initialize struct with zeroes
* nandsim: Artificially prevent sequential page reads

ECC engine driver fixes:
* mxic-ecc: Fix mxic_ecc_data_xfer_wait_for_completion() when irq is used

Binging fixes:
* jedec,spi-nor: Document CPOL/CPHA support

----------------------------------------------------------------
Arseniy Krasnov (2):
      mtd: rawnand: meson: initialize struct with zeroes
      mtd: rawnand: meson: invalidate cache on polling ECC bit

Christophe JAILLET (1):
      mtd: nand: mxic-ecc: Fix mxic_ecc_data_xfer_wait_for_completion() whe=
n irq is used

Geert Uytterhoeven (1):
      dt-bindings: mtd: jedec,spi-nor: Document CPOL/CPHA support

Miquel Raynal (1):
      mtd: rawnand: nandsim: Artificially prevent sequential page reads

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml |  7 +++++++
 drivers/mtd/nand/ecc-mxic.c                              |  1 +
 drivers/mtd/nand/raw/meson_nand.c                        | 10 ++++++++--
 drivers/mtd/nand/raw/nandsim.c                           | 17 ++++++++++++=
++++-
 4 files changed, 32 insertions(+), 3 deletions(-)
