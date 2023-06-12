Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948D72C93B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjFLPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjFLPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:03:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23245186
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso5297192e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582181; x=1689174181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jdo+u3pfToMD+E2Ff5G6AtrFm+z8Xryt182/z7nGO8=;
        b=JyOlQBn4VhrhzWei2zg2S52R+Rlo+nZqzmYM/zIbhFBj6NeW/Yjxqg29rXgAVrJw0f
         /Muk0xDIqzCaxBJ7X/0WiZo92Oswu7wHpjWO/XuoQIN6CYq0adNIhywip16Em6W+K6oC
         bq2/pU186AY8+6GtYdMBeKT1qCB4yVOsG/1CQhAI39745AN8o2Ju03Ta+/oCGc906TVn
         qJZf77w+m21RO8JeJISvjRgBv/y0rl232sVwiBZJVboD4MM/VE7VaaSfHEinEBaUYzyl
         X/GcyxZgI7T1t1j9Xz/qzWVL/pQLOf99RJujvqWJrq3V2JZCZdhcJt3mYoWGNx+T6MAx
         mHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582181; x=1689174181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jdo+u3pfToMD+E2Ff5G6AtrFm+z8Xryt182/z7nGO8=;
        b=T/FqOSGA3r5plqT3cCfAUV6hEhOMUIymGUL7yQP4XCIujUcVxdXBcdIItBrJCmSksl
         Llo+G+SehhqDPXGpEX8LSypvmTBu1FuGVcwRfHktUVWTUly/88J4Nh3y30ttdrH1lm7l
         /GgepoYCxogqWpfPZkBRjfzLQ+Jnef3/JseEIy5HkCbE5TmrEXkBz379QoaDqpjn1XtC
         Remg0Jl+bt+ZaTpZwJ5XnhuNQn+GPAxvjTR977VRHRSIEAgyK0DwJnSsyGmddx25h+Ks
         SNp1qt7gXxztQneO1mWd/wEoAsuKzGeN5eiEdbcsxXCC0VkK9Cuptu8MGgBpgXeoMLTX
         XUNQ==
X-Gm-Message-State: AC+VfDw4cRdOfmosL9Y0usAn3o5ciKIVBX+wBqBpYuzuaD2z1F0dXxOR
        WGKRhpazWA+FrvkhnssFKdve2AL5zjI=
X-Google-Smtp-Source: ACHHUZ7pmGgzXBo31dNj2E6xdZJooe3qMUN1YeT87gDyJtu0kPG3ksApUsSATeC0JkKcFG8T5PGm/g==
X-Received: by 2002:ac2:5b5d:0:b0:4f4:c6ab:f119 with SMTP id i29-20020ac25b5d000000b004f4c6abf119mr4150322lfp.64.1686582180763;
        Mon, 12 Jun 2023 08:03:00 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b005158563be4asm5184499edu.33.2023.06.12.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:03:00 -0700 (PDT)
Message-ID: <b52bdd52-dffd-6398-2fad-cb33c0b7ad55@gmail.com>
Date:   Mon, 12 Jun 2023 17:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/5] mtd: nand: raw: rockchip-nand-controller: add skipbbt
 option
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

Changed V2:
  reword
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index cafccc324..31d8c7a87 100644
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
@@ -1156,6 +1160,9 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,

 	nand_set_controller_data(chip, nfc);

+	if (skipbbt)
+		chip->options |= NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
+
 	chip->options |= NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
 	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;

--
2.30.2

