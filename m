Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F215D68B965
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBFKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBFKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:05:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E4EF9E;
        Mon,  6 Feb 2023 02:05:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m2so32588531ejb.8;
        Mon, 06 Feb 2023 02:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdavTuFd5AwgKTjsKFAoVHcxbRzSLlR1vkVVIhc1i+o=;
        b=Z2XpNek6T0AAlQCiIBmQrR6dbMJKGGwZ3HtzOvrrOy7uFUA13MgzAoatrw0Tp0CoHP
         zA4nStYfmBprLOAlobHxFwprnulsOa5fI0wh08DHe1aQJpaaV7nzn6dYxO0icbUp3RPL
         r7sQw3FhPPxV+V3aFMQCSqetzVV/svcA/S1wmTPD4w2DHpPMO8TclLaPDEXPYWfqvH51
         +nkCWRhGzEGrMs12xqK3yabGNOxmWygJJiEm40754N+tY+0NdLv8m9ThyWmEzK2DL2Ws
         QVmeCK/xfTpIRXrHPrOaesfMEzzWHb0KpEn/Io6SLbEnBWjhZkPVierQDqvtolwpHbYP
         1JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdavTuFd5AwgKTjsKFAoVHcxbRzSLlR1vkVVIhc1i+o=;
        b=p5skGuMEfgGtVoSydHhPYhFkrUBIhOrHZyQT7uV/PkWd3VBoD7sIntL1rjnWQnN08F
         ICh6G23S9OktlDqm9wsFVHG82vK4GOgBT33UORiU3H91SY5KavUx47WRxWk2niEfiw0w
         67yGOZ/5O1HD1mA+MfiuSa9ATiNsoMerW1CZMsjkECdJx2Rd6XGXHq4VQLsIUtQ1PquZ
         gPlgA5fWRqOmqNF1idSLcWkU1sr87g2aQQzc/9AdpK+6vR6H3a47/FN2FxEYXjOsTyCA
         9DA2T+AAztWX1eTXtJQa3zrq2EyJSN302A360eScpphYw4Om0AJ8U5jYbf1IT8ooGGNo
         Xu8Q==
X-Gm-Message-State: AO0yUKWjPDPLDymcjDsDnq4g5LJWJVu9eqrFoqkwDSjZmLV7SCIws6+x
        kZbvHAhLycmqdHW6weijbNo=
X-Google-Smtp-Source: AK7set97+m7/pbYVZc5ri1mu7vQ583KJV+OuDLG/4UCVkd1WhW9CT5U9r6aa7wgq9qyiV8sl0+533g==
X-Received: by 2002:a17:906:3192:b0:889:58bd:88a3 with SMTP id 18-20020a170906319200b0088958bd88a3mr20136037ejy.68.1675677915928;
        Mon, 06 Feb 2023 02:05:15 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709067b9300b008878909859bsm5240746ejo.152.2023.02.06.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:05:15 -0800 (PST)
From:   Willem-Jan de Hoog <arinc9.unal@gmail.com>
X-Google-Original-From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
Date:   Mon,  6 Feb 2023 13:05:02 +0300
Message-Id: <20230206100502.20243-3-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206100502.20243-1-wdehoog@exalondelft.nl>
References: <20230206100502.20243-1-wdehoog@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bcm47xx module has a copy of the NVRAM data in ram. When available, use
this one instead of reading from io memory since it causes mtd/ubi to fail.

[ arinc.unal: Improved patch subject and log ]

Signed-off-by: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/nvmem/brcm_nvram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 34130449f2d2..f74bcb1c948e 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -33,6 +33,12 @@ struct brcm_nvram_header {
 static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
+#ifdef CONFIG_BCM47XX_NVRAM
+
+	return bcm47xx_nvram_read(offset, val, bytes);
+
+#else
+
 	struct brcm_nvram *priv = context;
 	u8 *dst = val;
 
@@ -40,6 +46,8 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 		*dst++ = readb(priv->base + offset++);
 
 	return 0;
+
+#endif
 }
 
 static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
-- 
2.37.2

