Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F9641B6E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiLDIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiLDIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:00:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75B17A84
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 00:00:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b21so8234546plc.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 00:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDpA1aUK9kbTnFQ/vn/18tjfvP/j6YXDuTY3DifM3hY=;
        b=gEEF5UGgGY4Nko5Y+OnMn0UGTewfNKRBZCIV6q5i0OTTXoOueE396Ddk0L0nAW2U6e
         c9Vj5lAc3tmKuRr2mmdzFZel6qg/xiVttjhCVIbAWu5BY9+7pPCrUoCcl0awjbuTyKXq
         vFzaOIoQuUhYFVYeqdssVvwXwWlmRzudxTz46ucxB/SP3kXCNdejspY/rShiVzd8HaNQ
         25eO4hOQYISd2TX0IsopOl1na0pvUo+5g2s3pAAjPKkQbgkhqA7n+OWucxbNobss0mUK
         U0bGYnKyIAnew7oRtvrc8amd7zzf8pjqBB1F0fR7HXpsJc/UPI/6rQJkQnXW9wzdgRXe
         2m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDpA1aUK9kbTnFQ/vn/18tjfvP/j6YXDuTY3DifM3hY=;
        b=xj9rzBHBOCghBxHUN6ZRXFIwRFANDBZZtvJO85lAb3Ys1nA42Ik3uDw7Z30Pv8YJP2
         GWDam+8c178O9DBufOW8Gzd2yNuNrszhqdZq317U9LVaTATQ24LkE8SS7jFON/dTf3HY
         7T9fxWKu9XmjMcYTQ+zFXC2bLG+T5aOuLl6qh9eD2cj4HtdifBj6Ho7YXJrbEW5vQTEa
         JLXwnP6XYKuG6sfDopu1KoE3+aUjD72onRm68gT5hBEl/VAHAgZ6G+WtOjkVSxiKesLv
         5RjOc61S2DuCb5ZdrjToAkJDgh6y/HkfmS9G5d9TyoMj8QH5+ENRySKJ+o2ofKWXDuph
         IxvA==
X-Gm-Message-State: ANoB5pmW4tO8AOWki0xmctiSX+/kv2DDEct8WoBMenUeGgu4kMo0U7NC
        7pyTBvJhNG9oECt0bkb23tk=
X-Google-Smtp-Source: AA0mqf61HVUWtek+HYPjD3D8kWucWKMejIDRUyHiYMx9w+jvvcimUqC/sBXmNFw0wySzG7rppRTwcg==
X-Received: by 2002:a17:90a:ea04:b0:219:9da1:6088 with SMTP id w4-20020a17090aea0400b002199da16088mr7919367pjy.64.1670140818597;
        Sun, 04 Dec 2022 00:00:18 -0800 (PST)
Received: from victor-17Z990-R-AAC9U1.attlocal.net ([172.58.27.227])
        by smtp.gmail.com with ESMTPSA id k9-20020a63ff09000000b0044046aec036sm6448189pgi.81.2022.12.04.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 00:00:18 -0800 (PST)
From:   Victor Lim <victorswlim@gmail.com>
X-Google-Original-From: Victor Lim <vlim@gigadevice.com>
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vikhyat.goyal@amd.com, amit.kumar-mahapatra@amd.com,
        alejandro.carmona@amd.com
Cc:     Victor Lim <vlim@gigadevice.com>
Subject: [PATCH] Linux: SPI: add Gigadevice part #
Date:   Sun,  4 Dec 2022 16:00:00 +0800
Message-Id: <20221204080000.4100-1-vlim@gigadevice.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edited gigadevice.c

Signed-off-by: Victor Lim <vlim@gigadevice.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 115 ++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 66c2e75023fc..9309e57407e6 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -154,38 +154,105 @@ static struct spi_nor_fixups gd25q256_fixups = {
 };
 
 static const struct flash_info gigadevice_parts[] = {
-	{ "gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,
-			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64,
-			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25lq32", INFO(0xc86016, 0, 64 * 1024, 64,
-			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128,
-			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128,
-			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256,
-			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
+/* GigaDevice - GD25Q or B series  */
+	{"gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)},
+	{"gd25q32", INFO(0xc84016, 0, 64 * 1024,  64,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)},
+	{"gd25q64", INFO(0xc84017, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)},
+	{"gd25q128", INFO(0xc84018, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ	|	SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)},
+		{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			   SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
 			   SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
-		.fixups = &gd25q256_fixups },
+	.fixups = &gd25q256_fixups },
+	{"gd25b series 512Mbit", INFO(0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55b series 1Gbit", INFO(0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55b series 2Gbit", INFO(0xc8471C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25F series */
+	{"gd25f series 64Mbit", INFO(0xc84317, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25f series 128Mbit", INFO(0xc84318, 0, 64 * 1024, 256,	SECT_4K	|
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25f series 256Mbit", INFO(0xc84319, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55f series 512Mbit", INFO(0xc8431A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25T series */
+	{"gd25t series 512Mbit", INFO(0xc8461A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55t series 1Gbit", INFO(0xc8461B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55t02ge", INFO(0xc8461C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25X series */
+	{"gd25x series 512Mbit", INFO(0xc8481A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55x series 1Gbit", INFO(0xc8481B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55x series 2Gbit", INFO(0xc8481C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25LB series */
+	{"gd25lb series 16Mbit", INFO(0xc86015, 0, 64 * 1024, 32,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lb series 32Mbit", INFO(0xc86016, 0, 64 * 1024, 64,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lb series 64Mbit", INFO(0xc86017, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lb series 128Mbit", INFO(0xc86018, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lb series 256Mbit", INFO(0xc86019, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lb series 256Mbit", INFO(0xc86719, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lb series 512Mbit", INFO(0xc8671A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lb series 1Gbit", INFO(0xc8671B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lb series 2Gbit", INFO(0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25LF series */
+	{"gd25lf series 8Mbit", INFO(0xc86314, 0, 64 * 1024, 16,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lf series 16Mbit", INFO(0xc86315, 0, 64 * 1024, 32,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
+	{"gd25lf series 32Mbit", INFO(0xc86316, 0, 64 * 1024, 64,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf series 64Mbit", INFO(0xc86317, 0, 64 * 1024, 128,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf series 128Mbit", INFO(0xc86318, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
+	{"gd25lf series 256Mbit", INFO(0xc86319, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lf series 512Mbit", INFO(0xc8631A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25LT series */
+	{"gd25lt256e", INFO(0xc86619, 0, 64 * 1024, 512,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd25lt512me", INFO(0xc8661A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lt01ge", INFO(0xc8661B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{"gd55lt02ge", INFO(0xc8661C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+/* GigaDevice - GD25LX series */
 	{ "gd25lx256e",  INFO(0xc86819, 0, 64 * 1024, 512,
 			      SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			      SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
 			      SPI_NOR_OCTAL_DTR_PP |
 			      SPI_NOR_IO_MODE_EN_VOLATILE)
-		.fixups = &gd25lx256e_fixups },
+			      .fixups = &gd25lx256e_fixups },
+	{"gd25lx series 512Mbit", INFO(0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55lx series 1Gbit", INFO(0xc8681B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
+	{"gd55lx series 2Gbit", INFO(0xc8681C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
 };
 
 const struct spi_nor_manufacturer spi_nor_gigadevice = {
-- 
2.25.1

