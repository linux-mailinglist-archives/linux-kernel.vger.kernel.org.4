Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1A666EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjALJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjALJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:52:55 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57B50167
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:49:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 580D31BF205;
        Thu, 12 Jan 2023 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673516984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1yJ3dM1kuE3+hpM9qPqGozVgFuQrdfJMlJUzQ8ON5N8=;
        b=QTkoS2EUDM8i/6FDn5CcEFD5VSCGjCMf0bFt4WcUtN4CbRX1144+TOhhJFjv2MZ/vkSCzN
        z/u0tBgHn1lHij+LNTxGTp0o/8XycWvGwI5Qx6QcvKgXJsRJ70BaYdkxHSLrhmBH9wG7lI
        LE6iCMlY5WeCz7Nf1wfyvIj9UKniQALMsUK/UPznFcUfgcVX88NAajspGu1iTa9PZSUouO
        tprLJSHksM/FBZVMTQ3a6NrTszvF7yfGRjglDd2hLQBpnMMWSokleFJscsJoDVttgYht8B
        l0JsKvgdkqKJBtvI+zHYjvHjXSU8x0eFyS+WWWB+z2Gn0lAE172IDgKEKJlJ4Q==
Date:   Thu, 12 Jan 2023 10:49:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v6.2-rc4
Message-ID: <20230112104941.27840eb4@xps-13>
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

This is an MTD fixes PR for the next -rc. I was told that MAINTAINERS
changes were welcome ASAP to avoid bouncing e-mails and communication
disruptions, so here is a change to update Tudor's e-mail address
included in this PR aside with 3 core MTD changes.

Thanks,
Miqu=C3=A8l

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.2-rc4

for you to fetch changes up to c0f7ae27539fbac267384a7bfc58296ea7550d52:

  MAINTAINERS: Update email of Tudor Ambarus (2023-01-07 15:18:44 +0100)

----------------------------------------------------------------
MTD changes:
* cfi: Allow building spi-intel standalone to avoid build issues
* parsers: scpart: Fix __udivdi3 undefined on mips
* parsers: tplink_safeloader: Fix potential memory leak during parsing

MAINTAINERS change:
* Update email of Tudor Ambarus

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: cfi: allow building spi-intel standalone

Mikhail Zhilkin (1):
      mtd: parsers: scpart: fix __udivdi3 undefined on mips

Tudor Ambarus (1):
      MAINTAINERS: Update email of Tudor Ambarus

Yuan Can (1):
      mtd: parsers: Fix potential memory leak in mtd_parser_tplink_safeload=
er_parse()

 .mailmap                                                             |  1 +
 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml  |  2 =
+-
 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml  |  2 =
+-
 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml |  2 =
+-
 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml      |  2 =
+-
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml             |  2 =
+-
 MAINTAINERS                                                          | 10 =
+++++-----
 drivers/crypto/atmel-ecc.c                                           |  4 =
++--
 drivers/crypto/atmel-i2c.c                                           |  4 =
++--
 drivers/crypto/atmel-i2c.h                                           |  2 =
+-
 drivers/mtd/parsers/scpart.c                                         |  2 =
+-
 drivers/mtd/parsers/tplink_safeloader.c                              |  4 =
+++-
 drivers/mtd/spi-nor/core.c                                           |  1 +
 include/linux/mtd/spi-nor.h                                          |  1 -
 14 files changed, 21 insertions(+), 18 deletions(-)
