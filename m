Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853D74D5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGJMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGJMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:42:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A0F1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3159d5e409dso440933f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688992935; x=1691584935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBd1Lu1Lca2z3up8dzZ0bUwRcOK91MQPeC1b10XMPe4=;
        b=jMayj+6FlyzWisJa44u1vRVzWTqzkkr+hAgEqmGIvhditBR6u9AfV21PT8niYQk2WU
         9UL48NjJw19HLqdX83VpGrvCYR8rcxLqauGy0ioZpWd9BVq7GV99DrfYCGBVjLoEj5X7
         v+l1Z3m0B4PK/tTI80IYslI/+sWfb1hyVraBfwnwtBErzZyh1+WYjxSwIKKFLj8oHR2R
         e6+tmLxj6YBn1G0B24s1RiNZEn3XrG0AMpAgxxOhBZKW6hJo0YHsW5SMwiP1ZKXcLNC7
         ZLjqoI3KjmYJOBdQxlevWgF8QzeU37YSmnoch4wmSbV7jmuFK+atJdJ6ziy8HJtC1SiT
         KNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992935; x=1691584935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBd1Lu1Lca2z3up8dzZ0bUwRcOK91MQPeC1b10XMPe4=;
        b=R/gn2Hn1kBzkZaJCeLl01/SggHM3YExyzoLDt60FHppQA1GRNQobbPUubusW6apHQj
         FWRQyF8/rQdaEM2u3W3AViGiwRGMy5qX087ZgycHTxUld9/Uj2eX9Hhc6b2mwajwmVcJ
         +MRjtnK128rKsPEkMs+LajyZ3iZfDvQqheQwK7aygdGfUJsgt2yWmn5MDri9cvVluWit
         fUMTEaEizXWgK6RkuUjqErWWl5NlTG7X8BOW1lfSOr5JAx7vq6aoIAKE7/GL6eTLlhgB
         BASY1zd/3y2cRNHPUUdPjrdq6jWhXP0+WsiGWffHEyUyX8ZjfSIxNRAzyCgUIH3hnCHI
         GogQ==
X-Gm-Message-State: ABy/qLYdYvoZsZLo+1r3+Gh+18TPWrlAbHmMCLxoVyJLCg/uO6k4sWvy
        kLBBxONHN7gGQFQoiX5nEUgJD0NctiM=
X-Google-Smtp-Source: APBJJlHsd3OjEmoDoMtV1lj2Xvfy9YGaqMv5Pv0DobeXvA2Ss7TEnthuzrVy/NImHSoytpm3lJI96g==
X-Received: by 2002:a5d:6e11:0:b0:315:a155:5294 with SMTP id h17-20020a5d6e11000000b00315a1555294mr851620wrz.34.1688992934466;
        Mon, 10 Jul 2023 05:42:14 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdd4c000000b0030ab5ebefa8sm11582335wrm.46.2023.07.10.05.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:42:14 -0700 (PDT)
Message-ID: <876e58f3-e3c2-6295-9137-312e686026bb@gmail.com>
Date:   Mon, 10 Jul 2023 14:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/3] mtd: rawnand: rockchip: fix oobfree offset and
 description
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
to the next page.

The currently advertised free OOB area starts at offset 6, like
if 4 PA bytes were located right after the BBM. This is wrong as the
PA bytes are located right before the ECC bytes.

Fix the layout by allowing access to all bytes between the BBM and the
PA bytes instead of reserving 4 bytes right after the BBM.

This change breaks existing jffs2 users.

Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  Reduce subject size
  Add 'Fixes:' tag
  Reword

Changed V3:
  Change prefixes
  Reword
  State break existing users.

---

Example:

Wrong free OOB offset starts at OOB6:
oob_region->offset = NFC_SYS_DATA_SIZE + 2;
                   = 4 + 2
                   = 6

oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
                   = 32 - 4 - 2
                   = 26

Together with this length above it overlaps a reserved space for the
boot blocks Page Address(PA)

chip->oob_poi buffer layout for 8 steps:

BBM0   BBM1  OOB2  OOB3  | OOB4  OOB5  OOB6  OOB7

OOB8   OOB9  OOB10 OOB11 | OOB12 OOB13 OOB15 OOB15
OOB16  OOB17 OOB18 OOB19 | OOB20 OOB21 OOB22 OOB23

OOB24  OOB25 OOB26 OOB27 | PA0   PA1   PA2   PA3

ECC0   ECC1  ECC2  ECC3  | ...   ...   ...   ...

Fix by new offset at OOB2:
oob_region->offset = 2;

The full range of free OOB with 8 steps runs from OOB2
till/including OOB27.
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 2312e27362cb..37fc07ba57aa 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -562,9 +562,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
 		 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
 		 *
 		 * The rk_nfc_ooblayout_free() function already has reserved
-		 * these 4 bytes with:
+		 * these 4 bytes together with 2 bytes for BBM
+		 * by reducing it's length:
 		 *
-		 * oob_region->offset = NFC_SYS_DATA_SIZE + 2;
+		 * oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
 		 */
 		if (!i)
 			memcpy(rk_nfc_oob_ptr(chip, i),
@@ -933,12 +934,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section)
 		return -ERANGE;

-	/*
-	 * The beginning of the OOB area stores the reserved data for the NFC,
-	 * the size of the reserved data is NFC_SYS_DATA_SIZE bytes.
-	 */
 	oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
-	oob_region->offset = NFC_SYS_DATA_SIZE + 2;
+	oob_region->offset = 2;

 	return 0;
 }
--
2.30.2

