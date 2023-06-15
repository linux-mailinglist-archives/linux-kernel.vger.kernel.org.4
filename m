Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03B731F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFORe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjFOReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:34:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBAB2962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98220bb31c6so327742666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850455; x=1689442455;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AATBn5YLXyzdI1LR5/a8tiR4gJT09RugCUbqiVh3Rxw=;
        b=LCxgZGYdHmRtIa1epcAMXaTawFX1hoAbqO+/VQyDMM0o2VWiFkxJyosGfgNV87DmX3
         LasbD4KBEzGP+RTVPhMr7jTuj7XzhaoWRougNeDjoTErIsNh0nlHC/nruRBiyOEWFc5a
         rCGs/Li5bAxAQOJ1YdhyzfbHuGGsLkuY0tNTs8Uy9rlek7Z2s55hqRHsXf7JNCSejTCV
         gVQPH8NCBqiuJP3w4JU/vtSWyhF+sOvQ14qztC1Nwnj0n8XJoUXsLgQsEI+cTbNwjtKN
         DdEJgRrc/t/UufumzQJTcW57oWjygDq25syEf7nmlEVKhSZf11jsWb5ZXtKpJ8CnqOxq
         a73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850455; x=1689442455;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AATBn5YLXyzdI1LR5/a8tiR4gJT09RugCUbqiVh3Rxw=;
        b=TLIgRz1+XxxiLoa8QIswUQf/M++7uiRYG2aQwjRCSwHHjVa0QLDtjgJFz060XBsYzT
         9dazxwUraxPp7INQyyZiEfnhlN8fAcQ9tTkSKaWRQ1z6xGEOqF692IzbZ1vWYUa/Xl+L
         y98+JESBpInLm5Ra+5E0SaD6kN7Z+m26kbEKZfxlcq5QlXOjv3DZrBTC3u9W3dQSf1+d
         vAuMEjsYcLNtAalLZS8ln1TjhKhdvJaWsD2BWxpKzUiAvZm8ZsmW9ORS3Yz6SmjvewoK
         6vmXeg37oBr3GAu+MjjKRIbDdBtadLNuOKSCs5emDTW/0HEBjLmY1wJNCTjAhZ42L7n4
         1o5A==
X-Gm-Message-State: AC+VfDxMYWE0ugwhr2+yRoAGuCZyM+Ga4+cKXFCrTqTkI8l14UTC9ZZn
        gCa7CZpjmdKDynsDRKy3QijFlwqyxFY=
X-Google-Smtp-Source: ACHHUZ4srb9y1tkxLxtkeekMy9MQR0COOl9U9xhSiBiCvaZcF5unIixCsXQAjAyHXsEhxk9JGUCH3Q==
X-Received: by 2002:a17:907:9342:b0:973:8198:bbfb with SMTP id bv2-20020a170907934200b009738198bbfbmr21130029ejc.31.1686850454927;
        Thu, 15 Jun 2023 10:34:14 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906140e00b009786ae9ed50sm9599908ejc.194.2023.06.15.10.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:34:14 -0700 (PDT)
Message-ID: <539cfba7-dd6f-015e-b990-a2335cb3aac9@gmail.com>
Date:   Thu, 15 Jun 2023 19:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 2/3] mtd: rawnand: rockchip-nand-controller: copy hwecc PA
 data to oob_poi buffer
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
Content-Language: en-US
In-Reply-To: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip boot blocks are written per 4 x 512 byte sectors per page.
Each page must have a page address (PA) pointer in OOB to the next page.
Pages are written in a pattern depending on the NAND chip ID.
This logic used to build a page pattern table is not fully disclosed and
is not easy to fit in the MTD framework.
The formula in rk_nfc_write_page_hwecc() function is not correct.
Make hwecc and raw behavior identical.
Generate boot block page address and pattern for hwecc in user space
and copy PA data to/from the already reserved last 4 bytes before EEC
in the chip->oob_poi data layout.

This patch breaks all existing jffs2 users that have free OOB overlap
with the reserved space for PA data.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
  Change prefixes
  Reword
---
 .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 37fc07ba5..5a0468034 100644
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

