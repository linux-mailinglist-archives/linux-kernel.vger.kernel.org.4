Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557DB72C940
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjFLPDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbjFLPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:03:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056E191
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9786fc23505so656880166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582200; x=1689174200;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C6UuLqkfXOKHkrI1ad2tdmANY5TMlVXBKHyBVpKDDNs=;
        b=fQoS3tSGn8MnsOHfhsD6U5U64Fu3Nmsz50Zwg30oq03i6E9Ezn91hqw2g7JpPIfkYa
         eMxsDjRIBq9G0jJGBcWaDnePtVmfbNPUTYXkxtjP670BBPDpCwJOCK3L/KPB4zt36UjW
         kdt6PlviG3u9oMqOmGxqCLIMkk1SKvUtpzyC+hd9ztU8insHBNXyIOokRBp0ctanexIY
         NJp9NQSsohcxBpxh49DM4vi0azYuVugTJ838AKT94gn1TeK2cUx1267WJIPahLF1PDIo
         F5UQNY4dJJR83Egpjg+3rjY6RUlKmsbFha9n3Bejl45Oi6Vq1kE4K81JkzKG5nkdhNwm
         P2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582200; x=1689174200;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6UuLqkfXOKHkrI1ad2tdmANY5TMlVXBKHyBVpKDDNs=;
        b=i4m0hNFu+4eR/d1Dn7tY1IfAgb4t9fBpYt5n38krGaDZrSwxqL5Y+v8MQ67ecBgWzc
         zpaaPQDH6QJ40KTKV0I/+zSYaVodg+xb7mpVQAZhYNIJJkycSfemLGOLOlGFWeSBhc3N
         TcRj2BvMUwOpPm2qEz2KTZZP/ngUfzbhr+tr3N2cjS/rAqt3uZ6mGk1qEztzuKaoSIbl
         9BjsmEP3UlkxlVD1nf9Z4nqbtzv2R0ogTCtZFWXU8xZAkHhc2rzHOZ93WlefRNp42Rtb
         HDw4qVaFx89e9kbRrGciroiNPZjynd2r3UsFYZMcdMR1hxNAo1bnPl1rlpbdxZr+IyvV
         MXsA==
X-Gm-Message-State: AC+VfDxRsccjVyuCOv2FvIAu5UGbB8ViJswANctxVDoaJnN4Yz+y4sue
        fPRu6+BSjujjd0K07pWv3xY=
X-Google-Smtp-Source: ACHHUZ4K+07M7JwoUNnwyZygd7mJqgEw47AtVBH7IL8iAes/yi0KtHWRtUq/gJqHa6/nh/N6rjJouQ==
X-Received: by 2002:a17:907:3603:b0:96a:19d8:f082 with SMTP id bk3-20020a170907360300b0096a19d8f082mr9821093ejc.25.1686582199969;
        Mon, 12 Jun 2023 08:03:19 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709061c0e00b0096f6e2f4d9esm5264570ejg.83.2023.06.12.08.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:03:19 -0700 (PDT)
Message-ID: <f2cebf54-a16c-c849-a988-bfd98c502748@gmail.com>
Date:   Mon, 12 Jun 2023 17:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/5] mtd: nand: raw: rockchip-nand-controller: fix oobfree
 offset and description
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

The MTD framework reserves 1 or 2 bytes for the bad block marker
depending on the bus size. The rockchip-nand-controller driver
currently only supports a 8 bit bus, but reserves standard 2 bytes
for the BBM. The first free OOB byte is therefore OOB2 at offset 2.
Page address(PA) bytes are moved to the last 4 positions before
ECC. Update the description for Linux.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 31d8c7a87..fcda4c760 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -566,9 +566,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
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
@@ -945,12 +946,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
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

