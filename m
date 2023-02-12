Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B064693B13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBLXVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBLXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:21:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4126BE;
        Sun, 12 Feb 2023 15:21:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o15so7171748wrc.9;
        Sun, 12 Feb 2023 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/zdHwH2kmbWZySL0e/UmcJFCdqPH/8nI1Dh4bwAor4=;
        b=d2gSMSWKgND/nrlDKUGFXD0dubydZVkf3ZciHrhn1inExzjHq4ytLJ/jhLykgwq/nf
         xV+794A4YFe39C52lK/zWOMcAF0qh4mLg14ppqKQjl1f26zI5w9kkjQszSsJLwPxiGZ7
         peM4ihF2n3y1tJPuQq5ZGi/Piy4av/2vvvZZGjkPdUpT6F1c+23rsspc88Zk/PXgKp+5
         3JDQe23qsd16cQtKCoUlSqOxOKoGzWeax1qK0PXTMxgdZQQBRGvOG9sJVXaaX1cmemPg
         3E2dkoPAZE6OlDx4CbnEYMD6Ht92G+imln8ekpBKGYOIvo1yOUXx1sFVK93tCm5D3ytU
         f1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/zdHwH2kmbWZySL0e/UmcJFCdqPH/8nI1Dh4bwAor4=;
        b=mtPTfSWtS9JPn1hrLbEnoHl6JR74ui/vA7ywB7tt2vot+Av0dgiPfUM8H3La+zmnKj
         0VqvOaR6Z3SqzjGopAaiw33JKO1almw7EqEahO0SspbWUqd1uisoChDRpMVlj0mjJyBl
         z0Bh0BbGEqMcfvjlYqrRFZa9L0FsND5TiJSvRIfrrUYqxRbU7wf3tC+u0WN1d4EyVZlf
         /Fr3UTBAyPiw+4ZEo7+hRG9M5IGHwDx65NNEXD95od8XU3rBvz5/hwIUWtCw2+DImM29
         2mo/6GNHbzlvUKPqx3aLDqMUiPG33DXVjmBPfeY/MSV7XBfnChMISbCs9eY2vcxeTpr+
         EJhg==
X-Gm-Message-State: AO0yUKWagsOvt/lBRC+zuYobT9cv7mbh2JCZ4dNT3+sv6m9Hocy15NOf
        5UVYonQ9oezZx0MGQQe4iEGXDnfXHd4PqBGJ
X-Google-Smtp-Source: AK7set8OJKW9fiAW/UVEhR5z3lBBDIr+kE+QjnSfBHt2UipMTB4J6+ZDbyhynEQBj6z2qsLEAxvdVw==
X-Received: by 2002:a5d:4bc7:0:b0:2c3:ee83:5195 with SMTP id l7-20020a5d4bc7000000b002c3ee835195mr22327804wrt.29.1676244102139;
        Sun, 12 Feb 2023 15:21:42 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id m9-20020adfe0c9000000b002c3d29d83d2sm9210624wri.63.2023.02.12.15.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 15:21:41 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: ep93xx: Add OF support
Date:   Mon, 13 Feb 2023 00:21:37 +0100
Message-Id: <20230212232137.299005-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
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

Add the new cirrus,ep9301-ac97 and cirrus,ep9301-i2s compatibles.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-ac97.c | 8 ++++++++
 sound/soc/cirrus/ep93xx-i2s.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 37593abe6053..fd7f6b3a5317 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -430,11 +431,18 @@ static int ep93xx_ac97_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_ac97_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-ac97" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_ac97_of_ids);
+
 static struct platform_driver ep93xx_ac97_driver = {
 	.probe	= ep93xx_ac97_probe,
 	.remove	= ep93xx_ac97_remove,
 	.driver = {
 		.name = "ep93xx-ac97",
+		.of_match_table = ep93xx_ac97_of_ids,
 	},
 };
 
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index f41712df7994..3c6fa8e23c52 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
@@ -505,11 +506,18 @@ static int ep93xx_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_i2s_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-i2s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_i2s_of_ids);
+
 static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
 	.remove	= ep93xx_i2s_remove,
 	.driver	= {
 		.name	= "ep93xx-i2s",
+		.of_match_table = ep93xx_i2s_of_ids,
 	},
 };
 
-- 
2.39.1

