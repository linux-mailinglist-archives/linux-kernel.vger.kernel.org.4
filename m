Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313A600353
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJPUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 16:41:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECB31DFE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 13:41:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so11198415wmr.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymjkPYRb1jiffzs0fKEUP23KqmJSlsFFFCh+eYBy8O4=;
        b=nXCxuO9X4ibizj9Vey8FjbPLHMP6+YYXUBmed0clMQXFi/NBjm3gzuPDgcZXtxAyX+
         C65CmZXnH09e3IMd2q1vJrJ0iKPDsNqKiX9vBFw+rSqd/A6EnfwSLrWO5AL6J16OASYr
         A91tyPAWMJBg5buqFleCQs8QSTO32+Z0c3bW0yS42w29CXNlih5xflFzQ8hQQuf+ChmH
         n9l8lxCqYGzjuGeVJmT7cmo3VlCkcYV13GkRG8kJLcjmRfYSbpvHedxXhlbuStIVxx+S
         q9oFhllucNdKZZF8OQGp/DZEoB7RNwjgVZP2rGmhpbHOLolhl7Hc/GMzQPl3E/WanKYB
         gQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymjkPYRb1jiffzs0fKEUP23KqmJSlsFFFCh+eYBy8O4=;
        b=nAw24pf8FKbSFz2WB0ryQ6ci9WqbTQYXVla8wAREUNdrbUTHghplL1B1DPeuvOGqcu
         7174KXsk50llgG8mNakp8/DYJjeFDHws5w+c+9rWsjXNNGrO4KAtuC464QTrkN52GbR3
         qrUOHm6Pd40qbjXrqUfYYmPUhj14+B9Vp8yM2mZfDYol4lDR1dsELjmbqfV+Nk8yr0tV
         J7v16L5zq1cyc3gxdnWHm8LOpcL5zM2vLDsalbvrOWTGB/y24w+xHdoj+gsuEkBWp2yK
         dJUXd6Zqi8B8Z1h4TXBZoPhYaDbl1CkKys3qerUdXSA5/tyeRYFL8wVKrfNpuKgvckoP
         rfmg==
X-Gm-Message-State: ACrzQf0vBwo9E24cS4VPjoAPhbnZ1rE1/d51eWjovUJcM9n2aEP2iYL1
        LbioWkeKpkjnN21+Ne3frE8=
X-Google-Smtp-Source: AMsMyM7iQJcp75/uyz3dxudBcfRcfLnc7W15SBQT3erH3pNo/RF/Xf88YrAIRNT1t/ZYdk2req+WZw==
X-Received: by 2002:a05:600c:1c8f:b0:3c6:d732:9d6 with SMTP id k15-20020a05600c1c8f00b003c6d73209d6mr15553306wms.23.1665952859969;
        Sun, 16 Oct 2022 13:40:59 -0700 (PDT)
Received: from localhost.localdomain ([117.102.52.73])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003a541d893desm8648704wmq.38.2022.10.16.13.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 13:40:59 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v3] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Mon, 17 Oct 2022 01:39:36 +0500
Message-Id: <20221016203936.5264-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This is an enhancement which allows to specify the default driver
parameters among the module parameters.

Adding default variables to the speakup_soft module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---
Changes since v2:
	- Removed an unnecessary comment.

Changes since v1:
	- Added NB_ID as the last member of enum default_vars_id.
	- Added NB_ID as the size of array vars.
	- Made sure that that the enteries in vars are in correct order.
---
 drivers/accessibility/speakup/speakup_soft.c | 59 ++++++++++++++------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 28c8f60370cf..6d446824677b 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -33,21 +33,30 @@ static struct miscdevice synth_device, synthu_device;
 static int init_pos;
 static int misc_registered;
 
-static struct var_t vars[] = {
-	/* DIRECT is put first so that module_param_named can access it easily */
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
-
-	{ CAPS_START, .u.s = {"\x01+3p" } },
-	{ CAPS_STOP, .u.s = {"\x01-3p" } },
-	{ PAUSE, .u.n = {"\x01P" } },
-	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x01%db", 0, 0, 3, 0, 0, NULL } },
-	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
-	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
+
+enum default_vars_id {
+	DIRECT_ID = 0, CAPS_START_ID, CAPS_STOP_ID,
+	PAUSE_ID, RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, TONE_ID, PUNCT_ID, VOICE_ID,
+	FREQUENCY_ID, V_LAST_VAR_ID,
+	 NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+
+	[DIRECT_ID]  = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x01+3p" } },
+	[CAPS_STOP_ID]  = { CAPS_STOP, .u.s = {"\x01-3p" } },
+	[PAUSE_ID]  = { PAUSE, .u.n = {"\x01P" } },
+	[RATE_ID]  = { RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
+	[PITCH_ID]  = { PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
+	[INFLECTION_ID]  = { INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID]  = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID]  = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
+	[PUNCT_ID]  = { PUNCT, .u.n = {"\x01%db", 0, 0, 3, 0, 0, NULL } },
+	[VOICE_ID]  = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
+	[FREQUENCY_ID]  = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -451,10 +460,28 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
 }
 
 module_param_named(start, synth_soft.startup, short, 0444);
-module_param_named(direct, vars[0].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
 MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+MODULE_PARM_DESC(rate, "Sets the rate of the synthesizer.");
+MODULE_PARM_DESC(pitch, "Sets the pitch of the synthesizer.");
+MODULE_PARM_DESC(inflection, "Sets the inflection of the synthesizer.");
+MODULE_PARM_DESC(vol, "Sets the volume of the speech synthesizer.");
+MODULE_PARM_DESC(tone, "Sets the tone of the speech synthesizer.");
+MODULE_PARM_DESC(punct, "Sets the amount of punctuation spoken by the synthesizer.");
+MODULE_PARM_DESC(voice, "Sets the voice used by the synthesizer.");
+MODULE_PARM_DESC(frequency, "Sets the frequency of speech synthesizer.");
 
 module_spk_synth(synth_soft);
 
-- 
2.25.1

