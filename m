Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B548731F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjFORem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjFOReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:34:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484D295D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-982af24987fso109562166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686850468; x=1689442468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YhjaIcOgdSC4loqdzWjGFqfQ0Mx8Oy4umDdDUkZduk=;
        b=jwM1Pqg8HWVT/EJnvWaYVy3KEBqmdy1Y++omiie2N9IE8Qyoh0Lf08ez8cpR2OBQQW
         vfLYhT7fAUSZoBuz1+20EBDtxawgNkuuLBo2tzxhU+7xFy31ABGx3LRZShTVNxUSukSe
         MN+INi2UbtRiCuaNZ/WnSV2WJ3szOiGLECvIlxDJ9IBqCbtlw6C4Xpdrn91bXXv1P73l
         9he9MsGsfpyL5ljmD2lphS5vamDzmtLGF6yVL7DCW8jzkEbyoRi5pZnZGqG5YQW06KFT
         gJlaSoNEZZd3VqHgdsstWA/OD26H98tGrow2pKaPU7h+5QPKDmrc1jHSYJeTu62/z8bX
         D/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850468; x=1689442468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YhjaIcOgdSC4loqdzWjGFqfQ0Mx8Oy4umDdDUkZduk=;
        b=MiSntZol9Fg8MKnrRIicTqFjqSlXeo5H9XPYgKms0I/yTz9yGBrcZGCzhIQ9KHB+xN
         DycK6NMXvlmWnqCiDJpyAZDVF6bfnorakNikkmCvf5W5dQYE605QV3XzNruDvELZJlGh
         tBDHUEEqnb2OsTJ0u8uM4u11YRXQPn2gw6AZ0sVbq0w7ujf+3IEpwUDSoM0EJD/dlraI
         X8l+iAw/QfSSr0pjY1z8S02YLEHdOVb1tPLHnrNI75jmFRqJ4D9S5PSeSP5lzpuCO/w4
         Pl41xp0qfHfOF+vXZq5EbLS0djst3SwCxwOxeQul7PbCi+uvTmU1ZZHkokqdD7Wfnfic
         ej4g==
X-Gm-Message-State: AC+VfDzaFmRJ15tgyk7NbO/l+q5SNEkssaZXBne0yplaTcwtSD5K507e
        DtHiDJpgkIwgoxWpOgK9uAQ=
X-Google-Smtp-Source: ACHHUZ40xIFgNsRe5nLaezAyQzKIlM3VHTZlanc8Pt4LyFMBoL1eEAL5r0pljbN+89GgE/wdXqvFYQ==
X-Received: by 2002:a17:907:1613:b0:96f:b58e:7e21 with SMTP id hb19-20020a170907161300b0096fb58e7e21mr23568267ejc.52.1686850467735;
        Thu, 15 Jun 2023 10:34:27 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id lf29-20020a170907175d00b009787062d21csm9647072ejc.77.2023.06.15.10.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 10:34:27 -0700 (PDT)
Message-ID: <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com>
Date:   Thu, 15 Jun 2023 19:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt
 option
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

On Rockchip SoCs the first boot stages are written on NAND
with help of manufacturer software that uses a different format
then the MTD framework. Skip the automatic BBT scan with the
NAND_SKIP_BBTSCAN option so that the original content is unchanged
during the driver probe.
The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
the nand_erase_nand() function and the flash_erase command.
With these options the user has the "freedom of choice" by neutral
access mode to read and write in whatever format is needed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changes V3:
  Change prefixes

Changed V2:
  reword

---

I'm aware that the maintainer finds it "awful",
but it's absolute necessary to:
1: read/write boot blocks in user space without touching original content
2: format a NAND for MTD either with built in or external driver module

So we keep it include in this serie.
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 5a0468034..fcda4c760 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -188,6 +188,10 @@ struct rk_nfc {
 	unsigned long assigned_cs;
 };

+static int skipbbt;
+module_param(skipbbt, int, 0644);
+MODULE_PARM_DESC(skipbbt, "Skip BBT scan if data on the NAND chip is not in MTD format.");
+
 static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
 {
 	return container_of(chip, struct rk_nfc_nand_chip, chip);
@@ -1153,6 +1157,9 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,

 	nand_set_controller_data(chip, nfc);

+	if (skipbbt)
+		chip->options |= NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
+
 	chip->options |= NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
 	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;

--
2.30.2

