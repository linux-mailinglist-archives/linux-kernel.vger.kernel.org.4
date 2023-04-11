Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BAF6DE1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDKRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDKRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9A5B96;
        Tue, 11 Apr 2023 09:59:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud9so21890346ejc.7;
        Tue, 11 Apr 2023 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGiYwUojezuY+RxgL04VGSeCZx3NAMwWwAXac6CUEj4=;
        b=DOAGbpdR8fzZ9Gbbh7RUCSNW8UQIyEyKCkF2XEomSySEKliCZYU0I0ZXcq4Fe27va4
         ORMmfWHTLGSvcd14rBdrvYZUymX3QMl1nzwoIJNEoMdMrZwWIvWhl0/IYnxKerFm7oXE
         mL4cbApBYeVNCmycJghTPN4+Fc5oe0b+zqNNBEf3HW76LmEPGmY9rcm9g1AAcPD6TIA7
         Drl/+PS9CmF0Uoui4ZzE4+6g3G6Q1G8oNT9ULpSasBmZJYP0FbFMr2To7TWyzAax8FW8
         Ne/Pwu3o5nHngHK93n+tX8viY7vOK5+u6ziHAbJt+UH3EOxpFFkONo56THp75xj1Oy+K
         P91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGiYwUojezuY+RxgL04VGSeCZx3NAMwWwAXac6CUEj4=;
        b=HvvgNPS7kADUbatAxIF0CxeXwlsi6jJ0oezNwVMX/PCJBhd2k5nP16yqxfzjShRxuv
         KX3SKEC7Q0wF/WsCWWP87Q0guDOecqY7wJYGE6QLI85/3nXapyXGEVSJsr5Yu+85PO7x
         zJMqIPB7I/QaIbb3jiR8l6eJkQSL0vKBWCuavu6NOthjuQRSX7fPcoSDiAM4ybNVBIQM
         T135U3tUFPP9o7l3mo5n6W/4AzWG+hZhLATtpAo0VpeN44ovnMkuyGV8L+lQFHqRgfS4
         CTnc+U6zmq1LVjBrPlLuAtWnMRxvUpR3kusaYI/caf7fBWDSsQJINQZ1eefAi4Q9kuOJ
         Cg0g==
X-Gm-Message-State: AAQBX9dzWM4xESM7bxKLu6tG4vlipDGFEzcgij7B3w69GeJdr+vdrkPF
        ghfAtw9R3LV9uFp+8m5F8GmsdzkTReC7mA==
X-Google-Smtp-Source: AKy350a5SgWGjIHXpkAStyJFnVJ5KpXf1ETC00q63RutMcZw80dQpaUSiqlTZh8An7yLdQfENLRrfQ==
X-Received: by 2002:a17:906:d29a:b0:94a:826c:df57 with SMTP id ay26-20020a170906d29a00b0094a826cdf57mr8234940ejb.39.1681232395197;
        Tue, 11 Apr 2023 09:59:55 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id sg35-20020a170907a42300b0092b8c1f41ebsm6299061ejc.24.2023.04.11.09.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:59:54 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v3 2/2] ASoC: ep93xx: Add OF support
Date:   Tue, 11 Apr 2023 18:59:51 +0200
Message-Id: <20230411165951.2335899-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
References: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new cirrus,ep9301-ac97 and cirrus,ep9301-i2s compatibles.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v3:
- rebased onto
 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
v2:
 - Dropped AC97 (deleted from the tree)

 sound/soc/cirrus/ep93xx-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 2abd1bce2290..afc6b5b570ea 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
@@ -514,11 +515,18 @@ static void ep93xx_i2s_remove(struct platform_device *pdev)
 	clk_put(info->mclk);
 }
 
+static const struct of_device_id ep93xx_i2s_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-i2s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_i2s_of_ids);
+
 static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
 	.remove_new = ep93xx_i2s_remove,
 	.driver	= {
 		.name	= "ep93xx-i2s",
+		.of_match_table = ep93xx_i2s_of_ids,
 	},
 };
 
-- 
2.40.0

