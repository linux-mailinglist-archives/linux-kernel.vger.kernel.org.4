Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12A74D5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjGJMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGJMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:42:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23133103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so45787115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688992949; x=1691584949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3KmubX1E3kf+Z0JsXX9s3WNORY3qIwuBuczZRTUW+jU=;
        b=Krqub1hTt/iuxj040EXCNQNckp5a2XtiXqy8i8jBHwBJdllpNl/QucK4fUyPnzkiEX
         /j5sq9USFWZ5/jKLmr5SgQKd4IX4Rx5YKBRXkP1Fdsjz7EkXfwlFUkWu9tsva1kGD4Yj
         /unYxx/sHPEpuEDpq92Rre39bFtZi42a0yvqtvxDBziLwaERfWfRGCdflBDJfBPcQGZF
         P85SsueKUO99aOundaP4712ebz9BaegWIkxhiwWR5TIAUZZU/LpbWAW6jKKVWgHC1FHP
         M+lsIjGNaqkrvh0b0BkNyawH36MkpUYcmbSovMMQwY0WOfZZaCwRY+dm9HyrdkUnOv13
         P8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992949; x=1691584949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KmubX1E3kf+Z0JsXX9s3WNORY3qIwuBuczZRTUW+jU=;
        b=CwQjXjJdA1dGEkoh32YfYXC6ogeYSbe8SDB5kVLGPRl4QCrMXkjWIhFBN0SwnzGISn
         95fOXvmCM+nQtujlI9+pZLy/eTlP7tSkLfFbQ00Ze70CmE7oYZqXH9kU9QdNlMYv/xxH
         QIRAwD4YzlNhWFES1ZQUQQnjSurUP50yqRIr5pi5oTXa+hkOXax39UXlb55psOG0enza
         NpfxFCLNt6YpBmH1Im48RV/sUNgyCKbOlBlbR5dH1Dl74oL8dq38TWQn800cKSaNgArD
         QV+qXwrQ5wxHsfKwi4AsmAfP4ehrzphtmimhv629d9B96pr5qSooTulpnCvOamoeucVA
         X1zg==
X-Gm-Message-State: ABy/qLZ4MPrTvz0jt9e0ZmZPl8n4ml8NBBcy47SAWo+E05aAqjNiET+W
        3GHG1vaIzoz4Gw5r4rK73G0=
X-Google-Smtp-Source: APBJJlFF0t5fBxHHkDGpaeNGqnT0ItgSQi3wb/R+3SqxeyzOmTl403VCI4fNB1Bs2ZKS+wWGwR+5RA==
X-Received: by 2002:a05:600c:228d:b0:3f9:82f:bad1 with SMTP id 13-20020a05600c228d00b003f9082fbad1mr11514405wmf.40.1688992949326;
        Mon, 10 Jul 2023 05:42:29 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b003fbcdba1a52sm10293044wmr.3.2023.07.10.05.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:42:29 -0700 (PDT)
Message-ID: <04ed6472-13e4-d139-2ed0-ce2b1aa9e90c@gmail.com>
Date:   Mon, 10 Jul 2023 14:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/3] mtd: rawnand: rockchip: copy hwecc PA data to oob_poi
 buffer
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <08f694df-4c1d-f059-43fd-f1aee678062c@gmail.com>
Content-Language: en-US
In-Reply-To: <08f694df-4c1d-f059-43fd-f1aee678062c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip boot blocks are written per 4 x 512 byte sectors per page.
Each page with boot blocks must have a page address (PA) pointer in OOB
to the next page. Pages are written in a pattern depending on the NAND chip ID.
This logic used to build a page pattern table is not fully disclosed and
is not easy to fit in the MTD framework.
The formula in rk_nfc_write_page_hwecc() function is not correct.
read/write_page_hwecc and read/write_page_raw are not aligned.
Make hwecc and raw behavior identical.
Generate boot block page address and pattern for hwecc in user space
and copy PA data to/from the already reserved last 4 bytes before ECC
in the chip->oob_poi data layout.

This patch breaks all existing jffs2 users that have free OOB overlap
with the reserved space for PA data.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  Reduce subject size
  Add 'Fixes:' tag
  Fix abbreviation
  Reword

Changed V3:
  Change prefixes
  Reword
---
 .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 37fc07ba57aa..5a04680342c3 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -598,7 +598,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	int pages_per_blk = mtd->erasesize / mtd->writesize;
 	int ret = 0, i, boot_rom_mode = 0;
 	dma_addr_t dma_data, dma_oob;
-	u32 reg;
+	u32 tmp;
 	u8 *oob;

 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
@@ -625,6 +625,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	 *
 	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
 	 *
+	 * The code here just swaps the first 4 bytes with the last
+	 * 4 bytes without losing any data.
+	 *
+	 * The chip->oob_poi data layout:
+	 *
+	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
+	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
@@ -635,21 +642,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	}

 	for (i = 0; i < ecc->steps; i++) {
-		if (!i) {
-			reg = 0xFFFFFFFF;
-		} else {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
 			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
-			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
-			      oob[3] << 24;
-		}

-		if (!i && boot_rom_mode)
-			reg = (page & (pages_per_blk - 1)) * 4;
+		tmp = oob[0] | oob[1] << 8 | oob[2] << 16 | oob[3] << 24;

 		if (nfc->cfg->type == NFC_V9)
-			nfc->oob_buf[i] = reg;
+			nfc->oob_buf[i] = tmp;
 		else
-			nfc->oob_buf[i * (oob_step / 4)] = reg;
+			nfc->oob_buf[i * (oob_step / 4)] = tmp;
 	}

 	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
@@ -812,12 +815,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
 		goto timeout_err;
 	}

-	for (i = 1; i < ecc->steps; i++) {
-		oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+	for (i = 0; i < ecc->steps; i++) {
+		if (!i)
+			oob = chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
+		else
+			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
+
 		if (nfc->cfg->type == NFC_V9)
 			tmp = nfc->oob_buf[i];
 		else
 			tmp = nfc->oob_buf[i * (oob_step / 4)];
+
 		*oob++ = (u8)tmp;
 		*oob++ = (u8)(tmp >> 8);
 		*oob++ = (u8)(tmp >> 16);
--
2.30.2

