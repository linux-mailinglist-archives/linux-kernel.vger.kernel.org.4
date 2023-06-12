Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C372C931
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjFLPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjFLPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:02:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F519A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:02:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1afe57bdfso53232311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582163; x=1689174163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vsbB0vH5LsCtdiDXzwFJEcjnZ1bqcJw9xluET8hnyJA=;
        b=geaq3E+bmBkq6z7kvRXllGNe4ro8ZY2negeHlbij7OD8LDJcNauS8idOAlZ4cheng9
         Nx/Afo0cShXI1ObiRE8z3uOjEbhnkYViq+HeeGtERscjnvNGZehHS2ApxhZUoUvoKyu5
         IVQC1kTVZgqMsOmO3Lmw8dtkuefsuaERZHR+6wcxdD4Y1AZwxly13rrpRdZC9Lpnr22m
         MDz9jYciXhhFZ6c6+Gs7lX4JhlVegARLtYXSmBno604MRNBcBQGV0Vaux6WQ9Lr3/ayo
         09MT/NlHGenMBJ7KYPbYPpC6Vk+ZPkhNZYL7nlfHSbg6UrgIJ5sUYdoAjq7ep6mBvSzQ
         niiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582163; x=1689174163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsbB0vH5LsCtdiDXzwFJEcjnZ1bqcJw9xluET8hnyJA=;
        b=LKi1hidIafflNjAMy8fu68ON9lKArlpNbPGuaxIHCjZOSKQXHM6FrMY2WR8mGAFZYL
         Uh0GF5MRILPL9pZBf+w27UE6M5pG5GUdbyum0CLdulabZtI6400oNJkyvasvrZptXV23
         cD79ptrQGQy84itBqs3OPU7NyGHMDoWqYffobFyAgkWaXj9OQk/ea8NecUenZch3C07k
         4bnFXgA2lqvWP3hKi/TTmTQ9PFZ/7H1o/jynDhl2lSC4bQxC7bDiZUwr4WbUhCIZLRJ0
         InqagMEiwXrjNo7F6b/Jow6vvW53JeBQNCI7O1hZhptIi5SD9Bz1UTNjr+OLa8LApHdA
         KUuw==
X-Gm-Message-State: AC+VfDyYePQG6rIKIbVKxQCTU2eZ6n0w90YVgMwPdS2ORwepvvpE0AmQ
        yUJuq2ocMNlTSeOuMn/AlE4=
X-Google-Smtp-Source: ACHHUZ6oIv55dIdolZeg9heB91jDSC5+GqANWRfteW66ewwdwraqMlcH+Xy8nktWBYBWwxGOo2lRRw==
X-Received: by 2002:a2e:888f:0:b0:29c:921c:4eb0 with SMTP id k15-20020a2e888f000000b0029c921c4eb0mr3450738lji.22.1686582162597;
        Mon, 12 Jun 2023 08:02:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709063c0b00b0097883000525sm5477783ejg.15.2023.06.12.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:02:41 -0700 (PDT)
Message-ID: <b4e73d0f-d3de-b3e1-26a4-cce5337fe07e@gmail.com>
Date:   Mon, 12 Jun 2023 17:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/5] mtd: nand: raw: rockchip-nand-controller: copy hwecc
 PA data to oob_poi buffer
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
Content-Language: en-US
In-Reply-To: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
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
and copy PA data to/from the last 4 bytes in the
chip->oob_poi data layout.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 2312e2736..cafccc324 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -597,7 +597,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 	int pages_per_blk = mtd->erasesize / mtd->writesize;
 	int ret = 0, i, boot_rom_mode = 0;
 	dma_addr_t dma_data, dma_oob;
-	u32 reg;
+	u32 tmp;
 	u8 *oob;

 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
@@ -624,6 +624,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
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
@@ -634,21 +641,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
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
@@ -811,12 +814,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
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

