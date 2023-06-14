Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B17284F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjFHQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjFHQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:30:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0A2119
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:30:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-516af4a6d65so1551686a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241817; x=1688833817;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vsbB0vH5LsCtdiDXzwFJEcjnZ1bqcJw9xluET8hnyJA=;
        b=hkZlfrj08DAP1djftJGmo6uA8r5XJM3qG/0ifHmdMHjFMPJUiG7J4+Q2yw+TJjY5bw
         KwIxIe8huBGGJ6hrpnTKR/Q/elpqCWAhZAgWMWsbnYVO0Yh/dlQMKpzxinQRhM5Lt5SC
         16O9tGJ2z3Z8zL8PCKQSfFc5xh7xgjuOWEp7VWn9xNRc/v3jMWtMd/cwx3pdJpMFQ+G0
         VWmqCUpWgFkt19Y8W5FubQmpuT8X+/DlsTRUL4Kmg065yRmnI8Z1S8O+x+xJKIqJFyxM
         x6mkccOU7yqrG1K9P46lbK5raTGfY4CDv3r8uVnspCJY3SwHjxuqKuM4+VCMGdnmgRJY
         0bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241817; x=1688833817;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsbB0vH5LsCtdiDXzwFJEcjnZ1bqcJw9xluET8hnyJA=;
        b=MkPYSkQ6nCtssfshZAt2gQUSaWEcPtnJ5qKf09yqDyoNL4osvsUhHUbtE+m6RCt/aC
         nnD0eEwjG7xxDgR9iEqgOcdiVu14er1kez9zI7ZST5M+1570K2VeRwdnpomArOmy34Be
         FwbaL5/TtDIG0bCgC0n1PMxO2yzQtkt/OOOu30MX3bxqq7t8yQLhgcq7zN3ai+gxXqMo
         gar81lm7G8W7GTf8MIm2VTbvMyykMqjK6e/q+bB3WTRZLSo0pEjoSy3F4vkUSK7yoVGu
         HdW0G+XRHRrI/2S6rdAsQRlIusO01ssa/1fXN33zlMah7sY5hqaN/z8GjcNEwHFI0unD
         YpZw==
X-Gm-Message-State: AC+VfDyuIX+Cm/miM+XhdAclLdRdrHvWeDqVdgDVku+oZdowbLUuNWjT
        YZEnl9hBAisLjQSZjFSNG2Y=
X-Google-Smtp-Source: ACHHUZ6iMNVDTMeZdZzaR4cW1YP03V77zJAHgdi0d1rDcx262lUw2Jc2Wb32SEF9sMcsqRnfsVwf9A==
X-Received: by 2002:a17:906:7955:b0:977:cc28:d974 with SMTP id l21-20020a170906795500b00977cc28d974mr168921ejo.14.1686241816863;
        Thu, 08 Jun 2023 09:30:16 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b009746023de34sm32160ejd.150.2023.06.08.09.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:30:16 -0700 (PDT)
Message-ID: <b516a130-c948-0f33-d792-5ea56ca63b40@gmail.com>
Date:   Thu, 8 Jun 2023 18:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/5] mtd: nand: raw: rockchip-nand-controller: copy hwecc
 PA data to oob_poi buffer
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
Content-Language: en-US
In-Reply-To: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
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

