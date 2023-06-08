Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B17284F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjFHQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjFHQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:30:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B9419B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:30:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so975552e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241829; x=1688833829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JEi90Ldlhgb1TX3KGxyOhRscyzL8bDaJwIjdpZwAHM=;
        b=oiNID0CUe1AWbiikTsKX2eDTJ0S9WSJOOdI2miZOoBfeO5yy93DYpwIqMc192Y3JFQ
         vK5U1z2x7zv6jn0X7WqLjBW5Co7px5er5ntKxr3Hvcee/IVS4/XBk7h6XkGh/gAQNM9r
         BrApdp1SdAquHLYanvievnjMvG/N0gj63BNWmPusVw2PFP4DwprMzwfrz7nJPvIylV85
         RaGQwFqelBeoorNKYr+zdQG5jDevAGbh2PTGejNT3MHLBt8J3Ag0DuPIdzKEehoCnP5n
         T2Lf65eyjyEcAVTRdH08gGjOFSIpdgOxuNpPAxkZGpCvWf0JzFq4xUYkOFqJaRNNDsp6
         sqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241829; x=1688833829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JEi90Ldlhgb1TX3KGxyOhRscyzL8bDaJwIjdpZwAHM=;
        b=hJoY6oFbPnMHfFz+mQSX0JhsE7vfoUgYzbQQntQrFQDemYGEzCHjTK90PrJFdxarFM
         e1JCHspN6oO/RMwollQ9uUTdVV3lfr61NNvOJum5Wbft6y7XGJerBX40uKtqL1akaCb6
         lkT9VT6mhhy3U3JWPu40trKm9eDwTPjf1OAxM9ZN+p3P2ANuMgFEHhmTFgqg5rAp0+p2
         IE9pDDmdSFQuyn45SQP/Sz2gUHFmUO75UhwKjAOrnpJWX1qdbvK6RvWOQz24gBrdsG9v
         oDqhegGybOSvqGAwnoS4BrT6pnns1P5Yl/X/8BDSWJkaE/0I7ngtchP45Gl/oU3liidQ
         xQcQ==
X-Gm-Message-State: AC+VfDxYqN7ZEFJl1AIXP9E9sRjth83F0bow5CZ2mJ3s23wN2CYLruRX
        PXdnPmNsjGAt8zQREJQL04k=
X-Google-Smtp-Source: ACHHUZ6klAVFi77hcHpFJEJ4Ipf8Zzlq9+RqBHfp6OUAfEq7a2ufitVsxLKZ+8168eWyQSz2KBEiqg==
X-Received: by 2002:a05:6512:14b:b0:4f4:4cd4:2586 with SMTP id m11-20020a056512014b00b004f44cd42586mr3699557lfo.20.1686241829063;
        Thu, 08 Jun 2023 09:30:29 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b00977fb2fb44asm52422ejz.28.2023.06.08.09.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:30:28 -0700 (PDT)
Message-ID: <4d9473ce-c167-47d7-e37a-7b39915a724c@gmail.com>
Date:   Thu, 8 Jun 2023 18:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/5] mtd: nand: raw: rockchip-nand-controller: add skipbbt
 option
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

On Rockchip SoCs the first boot stages are written on NAND
with help of manufacturer software that uses a different format
then the MTD framework. Skip the automatic BBT scan with the
NAND_SKIP_BBTSCAN option so we can run it manually.
The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
the nand_erase_nand() function and the flash_erase command.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index cafccc324..f56430f6c 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -188,6 +188,10 @@ struct rk_nfc {
 	unsigned long assigned_cs;
 };

+static int skipbbt;
+module_param(skipbbt, int, 0644);
+MODULE_PARM_DESC(skipbbt, "Skip BBT scan if the NAND chip contains data not in MTD format.");
+
 static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
 {
 	return container_of(chip, struct rk_nfc_nand_chip, chip);
@@ -1156,6 +1160,10 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,

 	nand_set_controller_data(chip, nfc);

+	/* Skip the automatic BBT scan so we can run it manually. */
+	if (skipbbt)
+		chip->options |= NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
+
 	chip->options |= NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
 	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;

--
2.30.2

