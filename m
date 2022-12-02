Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58B2640643
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiLBL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:59:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834BA4310
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:59:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so4940573pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Vw5Bai2lwFyw6B4xoF/V+GvBFjAzY/Iy4Z1uJpuc+E=;
        b=alW/rx1JVaKZik3faPtE6RfzG8yOqEP5n3b8v7ojYOBGrsD6DFZtb2fmWKrtCw0nSP
         ClE1upRlGoOIP1AoVBJe65k5qgQwL5mf+5erzl2JKy/sM8/3eQ2Aalbv33QIrnkBKRHI
         pwGqqatanQNUyPmxGH0+X0C5WKBKw5Ez6wqBeanXUw4chjjKg3KwudLHByGTQUE2xDwr
         QTAJ0Xfu7j2nRPvsgPSA7aYISB1EWTAeRZuNgG1SMSz9Pj2KxJSSpiMzNStSL/IPcFyH
         FEs115pCVbKMfXsQ8uZdcFV6GN2jBe+kz2obyh5UxD2Hl7/6YkqNBNtZkpSeAOhrP0Pv
         yx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Vw5Bai2lwFyw6B4xoF/V+GvBFjAzY/Iy4Z1uJpuc+E=;
        b=6mv7JsK+3JO5R3wBQd6bK6hEWDq469h6uPK+we83rAUb2v2q+ilpLyWckJlq2KeLsA
         I4XjP4rp6tKJ1DtHq6ebaZJH3dfo+4YJamSVIb+ZmxeWnyNq1QUcqnV0mK7XfT662WEP
         9mYtLFqp6aLR7O9dvXvvS7IBeikrJ500n92C9jN/n69QPcbIhFm71yiHkp5nwHBiOrT6
         +I6o57BCdAeZDriRVHsmCunZyoerWC2+zlUEQqa6eK9jaFgqtaI6L8ncitztAUMGPVze
         XHJzIeEXkSrSjFP9uSG2Mb2MdDI7XyLfitIJX1LhARii+088R4MSwaBXYZZWBFO58j/S
         IjAA==
X-Gm-Message-State: ANoB5pmBMTDOurEmNOqA7ns435iD3WAtSUzj+U/KJNh4zPbEZOX3bvyz
        Hsz87/AboKFsfa2umtTEfykLOvpfA04ilA==
X-Google-Smtp-Source: AA0mqf58fkrFihlcZqHRWTwWzPp/52PAzAQT9uRM4vCm25R8z7fuLCeAzYI9lWVe++6EPJh7saJHXg==
X-Received: by 2002:a17:90a:ce05:b0:219:23ea:b314 with SMTP id f5-20020a17090ace0500b0021923eab314mr31478641pju.230.1669982378216;
        Fri, 02 Dec 2022 03:59:38 -0800 (PST)
Received: from localhost.localdomain (2403-580a-80ed--90b3-8553.ip6.aussiebb.net. [2403:580a:80ed::90b3:8553])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090a414500b00213d28a6dedsm6479849pjg.13.2022.12.02.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:59:37 -0800 (PST)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, povik+lin@cutebit.org,
        linux-kernel@vger.kernel.org,
        James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH] ASoC: tas27{64,70}: fix PM ops ordering
Date:   Fri,  2 Dec 2022 21:58:55 +1000
Message-Id: <20221202115855.16483-1-jcalligeros99@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On both tas2764 and tas2770, a write to PWR_CTRL is attempted
on resume before syncing the regcache to the chip, potentially leaving
it in an undefined state that causes resume to fail. The codec
is then unavailable until the next system reset.

On tas2770 specifically, both suspend and resume ops attempt useless
register writes on unrestored registers. This causes its state to be
desynchronised from what ASoC expects it to be in.

These two codecs are almost identical, so unify their behaviour
and reorder the ops so that the codec is always suspended and
resumed in a known/expected state.

Suggested-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 11 +++++++----
 sound/soc/codecs/tas2770.c | 40 ++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 2e0ed3e68fa5..51c6b3a940c4 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -32,7 +32,7 @@ struct tas2764_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
-	
+
 	int v_sense_slot;
 	int i_sense_slot;
 
@@ -157,14 +157,17 @@ static int tas2764_codec_resume(struct snd_soc_component *component)
 		usleep_range(1000, 2000);
 	}
 
-	ret = tas2764_update_pwr_ctrl(tas2764);
+	regcache_cache_only(tas2764->regmap, false);
 
+	ret = regcache_sync(tas2764->regmap);
 	if (ret < 0)
 		return ret;
 
-	regcache_cache_only(tas2764->regmap, false);
+	ret = tas2764_update_pwr_ctrl(tas2764);
+	if (ret < 0)
+		return ret;
 
-	return regcache_sync(tas2764->regmap);
+	return 0;
 }
 #else
 #define tas2764_codec_suspend NULL
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 8557759acb1f..5c9e8419b387 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -72,25 +72,21 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
+	ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						TAS2770_PWR_CTRL_MASK,
+						TAS2770_PWR_CTRL_SHUTDOWN);
+
+	if (ret < 0)
+		return ret;
+
 	regcache_cache_only(tas2770->regmap, true);
-	regcache_mark_dirty(tas2770->regmap);
+	regcache_sync(tas2770->regmap);
 
-	if (tas2770->sdz_gpio) {
+	if (tas2770->sdz_gpio)
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 0);
-	} else {
-		ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
-						    TAS2770_PWR_CTRL_MASK,
-						    TAS2770_PWR_CTRL_SHUTDOWN);
-		if (ret < 0) {
-			regcache_cache_only(tas2770->regmap, false);
-			regcache_sync(tas2770->regmap);
-			return ret;
-		}
 
-		ret = 0;
-	}
 
-	return ret;
+	return 0;
 }
 
 static int tas2770_codec_resume(struct snd_soc_component *component)
@@ -98,18 +94,24 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
 	int ret;
 
+
 	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
 		usleep_range(1000, 2000);
-	} else {
-		ret = tas2770_update_pwr_ctrl(tas2770);
-		if (ret < 0)
-			return ret;
 	}
 
 	regcache_cache_only(tas2770->regmap, false);
 
-	return regcache_sync(tas2770->regmap);
+	ret = regcache_sync(tas2770->regmap);
+	if (ret < 0)
+		return ret;
+
+	ret = tas2770_update_pwr_ctrl(tas2770);
+	if (ret < 0)
+		return ret;
+
+
+	return 0;
 }
 #else
 #define tas2770_codec_suspend NULL
-- 
2.38.1

