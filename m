Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3763B74D5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGJMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGJMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:42:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F00103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so45481375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688992962; x=1691584962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TdvM16o5h23jwD1okqOHQiuKkM8L7IpEOiBotY2IGmY=;
        b=b376hUBVwU5cG0vV849R90AbgHClWR5m0B0ip65d7lLM9lEjoEwc5JayOE5aBw1QWX
         b5bc3XGTXrLab8Vol+LypXiM7YozU6vCehy1UgWdXKnRUbzAxcuf3jD3mHKCLihQnTbt
         2ECT/v7hdYss29tOsNN/+7uQmX9S/toJpC2ipJ0kEYWK7rOYfnP51klWTWVEWZM3inYG
         wvCQZoqU3Ac9v7ROA07LO0/1ACRT258GaaUcxrTdGiCAzpPRx8VNORi88g7HuqMlN/CI
         SbKQahle6Va+QU6n+8MeOKUcO5358RHYMp+fKK3/50Zmoow6bjq6YzhwNI9BeTM73JQp
         4ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992962; x=1691584962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdvM16o5h23jwD1okqOHQiuKkM8L7IpEOiBotY2IGmY=;
        b=X9B4844hF2F4nM3gPmIOiB3HE0xJX3SUEvuF10irkwe0t2VU+Sb2QNQTnwW07C0l0Y
         r0/NfjBTEnTvn1f8z5golJSoatRxX6ev5X8KDPfYzOi0oCCx8mGU95CA3cRpHPe0sEIT
         WfLCLNDNkhhWBKnJVEd0rv3W64Z8AdJ0HnGepwacrpStBPIMJGopHWSdUvR9QgjK1LV/
         LHk8ZJtbsmGnHWpGMxNPavijp84N91sqPXCVd5kVJrYROuObJkCoOHe8/xsTI8sd8BSt
         T6XSAvCtnDsWChC+IiiWtqiRRrRQMAu4BpLhX8s3NSrtFKxs66jQaMMwn7pwb06o/cEI
         h8Qw==
X-Gm-Message-State: ABy/qLb67baUs0rucGPT5sIwlA7J0vyfv/tIFFvCoEUWAP8OFv1fa5Cp
        uzcrKxMuuVNITRQYKaiRtcw=
X-Google-Smtp-Source: APBJJlHd019CoyCypGiulVzj6NCOiOfzkSWrETKAuTfVD3XhhcYEgNfYy/2loWPSYkCuLickws37OA==
X-Received: by 2002:a1c:ed14:0:b0:3fb:4149:b816 with SMTP id l20-20020a1ced14000000b003fb4149b816mr10732743wmh.8.1688992962064;
        Mon, 10 Jul 2023 05:42:42 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b0031432f1528csm11637235wri.45.2023.07.10.05.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:42:41 -0700 (PDT)
Message-ID: <0d6d0c57-c1e3-6761-9ecd-48176b4b6d4c@gmail.com>
Date:   Mon, 10 Jul 2023 14:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 3/3] mtd: rawnand: rockchip: add skipbbt option
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

Changed V4:
  Reduce subject size

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
index 5a04680342c3..fcda4c760ffa 100644
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

