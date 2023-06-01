Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA471EE9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFAQTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:19:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A812C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:19:26 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685636365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=puKACfukReNN906YExsD3DbozgKlspwvf9R76iyybnU=;
        b=WtE0+wAjkkfGsv3GA0REmXerM72iY1+MyQssiLP0cy3foyuPkaETO4J0bWnwqw6HQn3Xv0
        sEhPAyXJNfwwWMZsJSXVKxJ8pgUFH28lltCwLObsNZ+WQT6CvWbwD8OyyOr2G/Fzv3wuJz
        A91cY5UMlzQ9sqQ29xeBZiPEih7cIuDeR1CT9fUYIOmHvQ3G+BC+Kcd4lM6UcSO/gjYOTe
        6ESU3q/ZngPbVLT4yhoawoN+HR8v/QvqUuOwt4ySBrbXr/BtLbzj4uzwKdPJ04jK9xsho5
        n3CHdhk/kj7DP8BJfyy4xgosKWAK+K02BAl58aDV2FG/c6aWcYffSGr8Lmb+CA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7740FF808;
        Thu,  1 Jun 2023 16:19:21 +0000 (UTC)
Date:   Thu, 1 Jun 2023 18:19:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.4-rc5
Message-ID: <20230601181916.515b516a@xps-13>
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

Here are a couple of mtd fixes we would like to get into 6.4. All the
fixes have been in -next for a week but I messed the authorship of the
MAINTAINERS patch when I manually applied it due to the reordering
of the file which slipped in, so I edited the commit and pushed -f
right before tagging.

Thanks,
Miqu=C3=A8l

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.4-rc5

for you to fetch changes up to c4d28e30a8d0b979e4029465ab8f312ab6ce2644:

  mtd: rawnand: marvell: don't set the NAND frequency select (2023-06-01 18=
:12:33 +0200)

----------------------------------------------------------------
MTD core:
* MAINTAINERS: Add Michal as reviewer instead of Naga
* mtdchar: Mark bits of ioctl handler noinline

NAND controller drivers:
* marvell:
  - Don't set the NAND frequency select
  - Ensure timing values are written
* ingenic: Fix empty stub helper definitions

SPI-NOR core:
* Fix divide by zero for spi-nor-generic flashes

SPI-NOR manufacturer driver:
* spansion: make sure local struct does not contain garbage

----------------------------------------------------------------
Arnd Bergmann (2):
      mtd: rawnand: ingenic: fix empty stub helper definitions
      mtdchar: mark bits of ioctl handler noinline

Chris Packham (2):
      mtd: rawnand: marvell: ensure timing values are written
      mtd: rawnand: marvell: don't set the NAND frequency select

Michal Simek (1):
      MAINTAINERS: Add myself as reviewer instead of Naga

Tudor Ambarus (2):
      mtd: spi-nor: spansion: make sure local struct does not contain garba=
ge
      mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes

 MAINTAINERS                                |  6 +++---
 drivers/mtd/mtdchar.c                      |  8 ++++----
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h |  8 ++++----
 drivers/mtd/nand/raw/marvell_nand.c        | 10 ++++++----
 drivers/mtd/spi-nor/core.c                 |  5 ++++-
 drivers/mtd/spi-nor/spansion.c             |  4 ++--
 6 files changed, 23 insertions(+), 18 deletions(-)
mraynal@xps-13: ~/linux-nand [mtd/fixes]$=20
