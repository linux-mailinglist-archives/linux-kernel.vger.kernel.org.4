Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF17284FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjFHQbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjFHQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:30:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF02715
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:30:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so1250473a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241854; x=1688833854;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+lWdxdyjn98DSIsUOubwz/2jxFFE94HkilpG/MpBg8=;
        b=lnFfQTWL93+gmaq67BRhQvuLlxlzloh39fybowrXPtD+Ttb2I6xa8z0AYOQ6AZQz7P
         3PdYvcE/9ePKM4Qbs1nLAfWrz6xuqYGMI5VjVysieAVPYWU0iu+7pki8NRQb/EzUOGQ9
         CpKARlQMgFXYbManoFWczAg4I8OYbCj3FEJyP9qCczB8rr8W6ZiJZM8z0LFsRjceTfOi
         DVI0l830g+qr9wmvqrtLx97Tw7lTOb6s/VAtHEKwewQBudGog5WE9V2hCPZ5qssX5UxF
         jittVF2oLYZ5OYvVJB1ygq/IKHFIizTZKpKxEu0kEDJ4JKGm+qK9JolleF3AygvlwaWe
         Q6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241854; x=1688833854;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+lWdxdyjn98DSIsUOubwz/2jxFFE94HkilpG/MpBg8=;
        b=fXh4TCaQWKg5nQdPeadnr9Q14ndxdAafTO75SFTbwFsDGk9pmgaBuOKS5GPiEXfhe9
         BSr+A8JaPkxFMKYK3/vWEJ8UcwLNo4SGoMYYdrd6dHqPqWcWmPIRDv+U00wG/b5qZ6t1
         awxj4vyYZNUY+NEZkmWa2QN1UkQ2R4l62gWLuWoCu+H0buRftwclNB5Cyyyhi2GbLkm0
         BR2QKA0dL4mWES1DXoqar9sAbSyqIZwSZZOcP4BM+rurHb22uqOuCHr1HX5DbskA9TRJ
         kWzOnGZDWPx3LadQwS9FzYHITPVR0k+gJwaQFU3gI+6Pilt3vNQRDNLwLEVgPB5vbqz3
         MzWQ==
X-Gm-Message-State: AC+VfDw1alDKv24viQ9SvIbNaZrnCjyUv7KV19U0Lzajd5WGQRPJdu01
        o7qnomHFfz1Vyz4JYI+6Py4=
X-Google-Smtp-Source: ACHHUZ4dAiHZdXniLxJTkgUTGxFZTA34BkWqXauEnC4CDgR/tTjfboJFNTivZhmLJ2Adyf7+kXoPbA==
X-Received: by 2002:a17:906:d550:b0:974:20bd:6e15 with SMTP id cr16-20020a170906d55000b0097420bd6e15mr413482ejc.4.1686241854107;
        Thu, 08 Jun 2023 09:30:54 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709065a8600b0097866bc5119sm24920ejq.200.2023.06.08.09.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:30:53 -0700 (PDT)
Message-ID: <9f606cfd-6823-3232-4f96-d0bd70b17211@gmail.com>
Date:   Thu, 8 Jun 2023 18:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/5] mtd: nand: raw: rockchip-nand-controller: fix oobfree
 offset and description
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
index e39431cfa..cf0fe502f 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -568,9 +568,10 @@ static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
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
@@ -947,12 +948,8 @@ static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
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

