Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8A731F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbjFOReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjFOReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:34:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE62710
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a21185130so1631358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850443; x=1689442443;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onV5CTTksC2Qd78lIixG0/dIqB3m8E1M6AA6FD8Jbs0=;
        b=prWxaZ36pGTgPaazXWWLSZ/xe/uSXBNIHmD1xZ7n5pE3rJGVNhR0N9Zm23NkJFrUaX
         23X1HZj+C9gLiF3S2wI4MyAWgNOYENKQhq1kaOcWW9A3n5U8qc2s3L4U+OiTGCDSZ+dl
         Qwk4OmTavRtpKxzglgdJ3cCggklFJ/wLxLq5239yhVxe5zGikHCWEciVS+C1L/06GyVb
         rJwug9nP3s50XCidh0wzVYY6HrVRZPHorWCfYqoyabW9o9fauqFnoK33z0+lP1KceyNI
         HD4g9S/10dq66w1VFds9N1AyvSFP/qsDfpYJ2O37DLOOJ+xsvpIdME3n6vg7nx2kLdDd
         OmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850443; x=1689442443;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onV5CTTksC2Qd78lIixG0/dIqB3m8E1M6AA6FD8Jbs0=;
        b=iZd3tCFPWtinsch+mTwIwO+4BBjy/JZAy48OAteQXVLWXTuLgzMsXjIP9Xtuli2X3b
         A+iakV4OMDbU3GXkgmjwNLoc5RhscCcnct5ntK7rVSkzhVTYh72eZ2ES0n0K/8GM8JjT
         B0Q4UjDe6U0c8ZsI4nSttGdS+iWtZbIzabkjoNr0PIpdJGmk68McoJ6ftJWTBIEnfc9u
         oDojxfGNImoISPcBvZjxfzMQ97Q2kajgQf9yhGOmAOGTcMGDM7GLiMyycBjATpCnFT3G
         uEpsj2+thmH19nAImVlmIM2GFwV7Mqj4S8yBNf2ZbC2PC+kLF4ppIcJtt2lfkCgafqAY
         Jd6A==
X-Gm-Message-State: AC+VfDwPRVGbFQzG6oKK/y9d3JXfhKx7Nt2pn+JXf3n0VbNendEasutS
        K30RsHh0Jpcy/KlIdxJ54Ds=
X-Google-Smtp-Source: ACHHUZ7yVhTWxSx4Cm9ZHg7+/ypOKVReVuS22P2vQuoAqqVdJ5E27xkglGRuj9g2yRDFuFKhEgHSvg==
X-Received: by 2002:aa7:c994:0:b0:518:7954:d082 with SMTP id c20-20020aa7c994000000b005187954d082mr5824467edt.10.1686850443301;
        Thu, 15 Jun 2023 10:34:03 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7d494000000b00514a3c04646sm9172936edr.73.2023.06.15.10.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:34:02 -0700 (PDT)
Message-ID: <dfb76ad5-b62a-3f1d-494e-cd17d57945ae@gmail.com>
Date:   Thu, 15 Jun 2023 19:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/3] mtd: rawnand: rockchip-nand-controller: fix oobfree
 offset and description
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

The MTD framework reserves 1 or 2 bytes for the bad block marker
depending on the bus size. The rockchip-nand-controller driver
currently only supports a 8 bit bus, but reserves standard 2 bytes
for the BBM in the chip->oob_poi buffer. The first free OOB byte is
therefore OOB2 at offset 2. Page Address (PA) bytes are located at the
last 4 positions before ECC. The current advertised free OOB area has
an offset that starts at OOB6 and a length that overlaps with the space
reserved for the PA bytes. Writing unrelated data to a reserved space
with a specific task can corrupt our boot block page read order.
Fix by changing the free OOB offset to 2.

This change breaks existing jffs2 users.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

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
index 2312e2736..37fc07ba5 100644
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

