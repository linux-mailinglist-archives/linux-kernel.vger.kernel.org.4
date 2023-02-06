Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB468B9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBFKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjBFKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:16:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F68A1;
        Mon,  6 Feb 2023 02:16:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so32853117ejb.0;
        Mon, 06 Feb 2023 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J7ZP1tAjzZR1au9SSxeWX9KZ/yZIvEyiSLMpncK6LM=;
        b=kZWJXfH14q+3wxQT+8AxR2F9bgvMv5yFLiF5eC9TtuR6VDECfBwGOMiLk8hh5hfKLo
         YNM/BDFGaPOjNb8s+ChgBmbOyEHeIZHCXP7tAmBbH765kqVVzBTRZ9vNazSrCUSNg0Zw
         sRMRq7zueJlkfXJVi2xpyNaha9ib0wMfT5YWH/uhh9zU09n/G/XADjXX2C2ndT+WUkIe
         yoC04xtue/tFsVmkMNIYoIVEtELLOtR+kdOCpiK9SZ87fWSayvNPYrcRHMFdZ8NPndpG
         RRl+rFctH1auGorq2SDjbDfyfU3flCxJjWD1Y2o8/sEJivfGpMloFKBG3tRVAwixHlhn
         s+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J7ZP1tAjzZR1au9SSxeWX9KZ/yZIvEyiSLMpncK6LM=;
        b=PRl+MBYTkLBNnQ1hnuTl4WybWOPtVAdxTaQ90eT44OoPIVwewwokI0CjDvF6TvZy7t
         5CiP8EL7IMZcZDaiBOfzLnmnLJYeTNkOAgrOfjFJabJCATbRmcGX/k6X7PZjVuipEkLC
         schUYAa3KMfHIwDZ7WDViya/SF3cVOLYIYahjNtdpLmG+50XYB68kE3ijmz+XfKu9QYU
         y/7BnFFhBNkrqx0poGTV+GIxXMNs488vnYQr9u0gcuvGCuBI/KdJnJQMHPjJrJGo/J/V
         1Wx7CraU08A6fJPVpTFOvTrKxFsQWauTYe13Ell2gKQm6mo8q6NualK+9g8f3nhsECYu
         Aqng==
X-Gm-Message-State: AO0yUKXuxBBa3RgSxodw5Z1hy53JcMBCkrdP08UHOGDC/7S41qasXytg
        KiUvk3ZnZhdnMc8LuJ+cZAdMkFc0v/t9fT46nY0=
X-Google-Smtp-Source: AK7set+5QLFKEekBI5FC/esyhHmblPhL//SxS7aAdjKXtwz1p6KryhbGgzBmHdmWQjP3cuNky44dhQ==
X-Received: by 2002:a17:907:cf48:b0:895:58be:94a with SMTP id uv8-20020a170907cf4800b0089558be094amr7304229ejc.14.1675678613598;
        Mon, 06 Feb 2023 02:16:53 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008847d7ed37bsm5285983ejc.100.2023.02.06.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:16:53 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: wdehoog@exalondelft.nl
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH v2 1/2] firmware: bcm47xx_nvram: allow to read from buffered nvram data
Date:   Mon,  6 Feb 2023 13:16:41 +0300
Message-Id: <20230206101642.22720-2-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206101642.22720-1-wdehoog@exalondelft.nl>
References: <20230206101642.22720-1-wdehoog@exalondelft.nl>
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

From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>

The bcm47xx code makes a copy of the NVRAM data in ram. Allow access to
this data so property values can be read using nvmem cell api.

[ arinc.unal@arinc9.com: Improved patch subject and log ]

Signed-off-by: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 14 ++++++++++++++
 include/linux/bcm47xx_nvram.h             |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 5f47dbf4889a..7e5c62dc702f 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -182,6 +182,20 @@ static int nvram_init(void)
 	return -ENXIO;
 }
 
+int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len)
+{
+	if (!nvram_len)
+		return -ENXIO;
+
+	if ((offset+val_len) > nvram_len)
+		return -EINVAL;
+
+	while (val_len--)
+		*val++ = nvram_buf[offset++];
+
+	return 0;
+}
+
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index 7615f8d7b1ed..b265b8ce6434 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -20,6 +20,7 @@ static inline void bcm47xx_nvram_release_contents(char *nvram)
 {
 	vfree(nvram);
 };
+int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len);
 #else
 static inline int bcm47xx_nvram_init_from_iomem(void __iomem *nvram_start,
 						size_t res_size)
@@ -48,6 +49,11 @@ static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
 static inline void bcm47xx_nvram_release_contents(char *nvram)
 {
 };
+
+static inline int bcm47xx_nvram_read(unsigned int offset, char *val, size_t val_len)
+{
+	return -ENOTSUPP;
+}:
 #endif
 
 #endif /* __BCM47XX_NVRAM_H */
-- 
2.37.2

