Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF56093EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJWOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJWOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2D61D4B;
        Sun, 23 Oct 2022 07:33:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so11821505wrt.11;
        Sun, 23 Oct 2022 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPVuUDMde4iT9AFYS7nsIkkUonhoCr0Fb8M7bh3R14c=;
        b=axlbN88z42NeyE9gww1dFYP+qpXMECN3tXcq/dmWjoR7QBfnKv8sAf7zy6oqZpkGJK
         fS4+Fb50bYSBaJxYSKsFYgh6aOqJBl2eVfDlQxFg3nygMMN0zpLGY1NH6v+9ueEaObih
         GvRXstIvxK22ja+OuKvM1KszAOLGI+ffJD8Tn4X42APvrxRqo1ARkmLdNXpWFktwYbuy
         ivWm8xJFmcZB0aSorqYMakPU3QnEtZ3G4M8Pq7gdiLFMVGI/H2mEH6C5SFAuekUQ7sam
         we+cvj4ThPxB70kRh+LNxFGkWga0SHGP0txJVZIICeo648JL0fWxzgZ/6ZFBdLwRaqis
         licw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPVuUDMde4iT9AFYS7nsIkkUonhoCr0Fb8M7bh3R14c=;
        b=kRsqrprjDH6Q/W7y07UaYsd0SVBkwZS39J9XGFM0VxgCilMrt5W9S5IPNySG/tY+DS
         7/TEqpxNZL5ZmS7wq8o3j0XGm86sD4MmkQIJu4J24sIE6xq2tJSHHAY2BJEktPyDsop0
         z+KSy0fGFq1xKT2QpmzgcHi50fpVKu7riMwxT6MIPBjWxVksZyeX0Nznvu/PVyo8noAS
         mkMI1+2wjUke0C3diTdGy4iFZnZqZ6IcNzUv23utl5gcIcPYooSzfaMhMEEsWk+8qCIP
         mM1cJE2qY+MReRTKY571J06adCOh6LTxA1nvONwHXmMjGpehyXr6AN9e85ZdqsDO7uML
         S3Zg==
X-Gm-Message-State: ACrzQf27TuyJBLRdPC1mloGrLwyfOfMZvA5voWKyEL6dvB93aVrDSxPr
        oWzf/xXXlTLwF6Q1Lhw3410=
X-Google-Smtp-Source: AMsMyM6nByUQJewaeg4c+zis+6VAd98GbK2NlqxFod153k4DlVNEl6Kut045sy5mkB/eZajarZzoDQ==
X-Received: by 2002:a5d:42c5:0:b0:236:60ed:9abf with SMTP id t5-20020a5d42c5000000b0023660ed9abfmr4416189wrr.454.1666535617850;
        Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b003c6b70a4d69sm8300046wmb.42.2022.10.23.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] ASoC: jz4740-i2s: Align macro values and sort includes
Date:   Sun, 23 Oct 2022 15:33:24 +0100
Message-Id: <20221023143328.160866-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some purely cosmetic changes: line up all the macro values to
make things easier to read and sort the includes alphabetically.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 66 +++++++++++++++++------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 4767abea425f..c3235e993ffb 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -13,11 +16,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/clk.h>
-#include <linux/delay.h>
-
-#include <linux/dma-mapping.h>
-
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -35,37 +33,37 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
-#define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
-#define JZ_AIC_CONF_I2S BIT(4)
-#define JZ_AIC_CONF_RESET BIT(3)
-#define JZ_AIC_CONF_BIT_CLK_MASTER BIT(2)
-#define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
-#define JZ_AIC_CONF_ENABLE BIT(0)
-
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
-#define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
-#define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
-#define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
-#define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
-#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
+#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST	BIT(6)
+#define JZ_AIC_CONF_INTERNAL_CODEC	BIT(5)
+#define JZ_AIC_CONF_I2S			BIT(4)
+#define JZ_AIC_CONF_RESET		BIT(3)
+#define JZ_AIC_CONF_BIT_CLK_MASTER	BIT(2)
+#define JZ_AIC_CONF_SYNC_CLK_MASTER	BIT(1)
+#define JZ_AIC_CONF_ENABLE		BIT(0)
+
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE	GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE	GENMASK(18, 16)
+#define JZ_AIC_CTRL_ENABLE_RX_DMA	BIT(15)
+#define JZ_AIC_CTRL_ENABLE_TX_DMA	BIT(14)
+#define JZ_AIC_CTRL_MONO_TO_STEREO	BIT(11)
+#define JZ_AIC_CTRL_SWITCH_ENDIANNESS	BIT(10)
+#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED	BIT(9)
 #define JZ_AIC_CTRL_TFLUSH		BIT(8)
 #define JZ_AIC_CTRL_RFLUSH		BIT(7)
-#define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
-#define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
-#define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
-#define JZ_AIC_CTRL_ENABLE_TFS_INT BIT(3)
-#define JZ_AIC_CTRL_ENABLE_LOOPBACK BIT(2)
-#define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
-#define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
-
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
-#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
-#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
-#define JZ_AIC_I2S_FMT_MSB BIT(0)
-
-#define JZ_AIC_I2S_STATUS_BUSY BIT(2)
+#define JZ_AIC_CTRL_ENABLE_ROR_INT	BIT(6)
+#define JZ_AIC_CTRL_ENABLE_TUR_INT	BIT(5)
+#define JZ_AIC_CTRL_ENABLE_RFS_INT	BIT(4)
+#define JZ_AIC_CTRL_ENABLE_TFS_INT	BIT(3)
+#define JZ_AIC_CTRL_ENABLE_LOOPBACK	BIT(2)
+#define JZ_AIC_CTRL_ENABLE_PLAYBACK	BIT(1)
+#define JZ_AIC_CTRL_ENABLE_CAPTURE	BIT(0)
+
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK	BIT(12)
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK	BIT(13)
+#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK	BIT(4)
+#define JZ_AIC_I2S_FMT_MSB		BIT(0)
+
+#define JZ_AIC_I2S_STATUS_BUSY		BIT(2)
 
 struct i2s_soc_info {
 	struct snd_soc_dai_driver *dai;
-- 
2.38.1

