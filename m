Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308E6EEF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbjDZHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjDZHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:41:28 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2573F3AA6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:41:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6073F5FD6F;
        Wed, 26 Apr 2023 10:41:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682494883;
        bh=2gMo3+6yJgM1RhFv5pwf0HhZ2CqqzaenJjvpSBYPU1U=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=cVdGqoNPv6iHUtqd8oaNXO4U5yhqS+mPEh7Oo/BPDBwzFUrp6ccrxFtVtXJSrycuL
         xrolozu6/KlN2+Gt01fzBhEfSaXtoHGu6dJl+zDOFxOxF687hYMpr8cJjI5MijHW9h
         c/BFMuNthBV98PYG84bkK1sZi9RsZS541Fer7W0bRMs9UfHr9ozmMfoR46hIdioOE5
         JipYeSaVdJ/orpgYV7kD96znwu0NmHhhKKjf6E45ileKOOF5QgbojKdtmOh59QbEO+
         FqhtXT1vvcLYBCcaVeP1lHQvBxYkFBy9uV9pGtGYk+UABWPOBf3u17ZTlHKThsh7Vy
         AvB5SAWlzIbPg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 10:41:23 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] mtd: rawnand: meson: rename node for chip select
Date:   Wed, 26 Apr 2023 10:36:31 +0300
Message-ID: <20230426073632.3905682-6-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
References: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames node with values for chip select from "reg" to "cs". It is
needed because when OTP access is enabled on the attached storage, MTD
subsystem registers this storage in the NVMEM subsystem. NVMEM in turn
tries to use "reg" node in its own manner, supposes that it has another
layout. All of this leads to device initialization failure.

Example:

[...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000/...
[...] mtd mtd0: Failed to register OTP NVMEM device
[...] meson-nand ffe07800.nfc: failed to register MTD device: -22
[...] meson-nand ffe07800.nfc: failed to init NAND chips
[...] meson-nand: probe of ffe07800.nfc failed with error -22

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 3737024c33d6..4ff3a3e50c4b 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1537,7 +1537,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	int ret, i;
 	u32 tmp, nsels;
 
-	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
+	nsels = of_property_count_elems_of_size(np, "cs", sizeof(u32));
 	if (!nsels || nsels > MAX_CE_NUM) {
 		dev_err(dev, "invalid register property size\n");
 		return -EINVAL;
@@ -1551,7 +1551,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	meson_chip->nsels = nsels;
 
 	for (i = 0; i < nsels; i++) {
-		ret = of_property_read_u32_index(np, "reg", i, &tmp);
+		ret = of_property_read_u32_index(np, "cs", i, &tmp);
 		if (ret) {
 			dev_err(dev, "could not retrieve register property: %d\n",
 				ret);
-- 
2.35.0

