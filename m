Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3E6FDC67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjEJLOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjEJLOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:14:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BC2106
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:13:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 121B25FD27;
        Wed, 10 May 2023 14:13:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683717234;
        bh=wpnQqYLiMeJcmuuKybbquqxEgUyT5kRAw1QOCUfaxQQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=DeN/8RDVdwKnRQM6hFMX9b456raaqf05mrqn7EAbZJuZ5ZEjutNZSOn4Zsjh1qYNE
         jlK1ZGFVg1dMDcBPbo1Y33YF+NgCYEb51gnGFFsUDRjZs9jedT+75tJOY1gjPP5aEo
         DAHNp45k+TYuCBkikcyqRJ+heJZxmGgLy+y2V62SqRtc7bzyxJ2FmIHSodxMq2rfaP
         yVJiJxbwEgVqb9n7BmPFBDgUmveJTWHylZYJTpL+fBnTAF5+yEG5wytGyAVtzcDCSV
         rc3OF9ijrJHyqnOGcxhxqI/nWeQwEHXsXyBE9jmqBz2Hxhmim0LkH4r941b1lPBphK
         qFrbsBVRBEerA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 10 May 2023 14:13:54 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
Date:   Wed, 10 May 2023 14:08:34 +0300
Message-ID: <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/10 09:03:00 #21252424
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
index bc99a098f3ca..28371919a6c5 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1419,7 +1419,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	int ret, i;
 	u32 tmp, nsels;
 
-	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
+	nsels = of_property_count_elems_of_size(np, "cs", sizeof(u32));
 	if (!nsels || nsels > MAX_CE_NUM) {
 		dev_err(dev, "invalid register property size\n");
 		return -EINVAL;
@@ -1433,7 +1433,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	meson_chip->nsels = nsels;
 
 	for (i = 0; i < nsels; i++) {
-		ret = of_property_read_u32_index(np, "reg", i, &tmp);
+		ret = of_property_read_u32_index(np, "cs", i, &tmp);
 		if (ret) {
 			dev_err(dev, "could not retrieve register property: %d\n",
 				ret);
-- 
2.35.0

