Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B2623618
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiKIVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKIVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4F30F4D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g12so27837017wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydGTLGal/xbxjBKCjE1wDszyUaLZwuor5HRFhrv26Vo=;
        b=VgvLajr7dXYR1Nk+621wPaHRjCVDQ2KFLzmxQL/dtzx2Lq8CO5tsDNsKRxw63R0inJ
         jCfGUjK2qNDu2b+XrA9WnfQXg2utryB15vnyPXe1uit8TkF0FLHkO1rY8345uJNnyy4w
         XmCglTRPjETlRUH8u3YX+cVR8IxXdvU7srIhGlO4zu/cTi3yalsbb3zk7LJefQ8R8P+i
         9F36YBUvWTqVZXWePNU4RSeSzhLKJpNPoyYq622w5HrTxK4uCchzdBhezTmi3dKATkqV
         o0ivqfnWjl5I6BEOqJI1X6BvFmanSYpeo8fdnF2lKyBok41FMMiI+wtiApqsjZDiCaOb
         LSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydGTLGal/xbxjBKCjE1wDszyUaLZwuor5HRFhrv26Vo=;
        b=1IkU4dTisAABecsuic+ytzB8+dzei9sR6lYxVidUZYJhhbiD0cBoIDU39i2cMUYA7f
         Kw4UUQlIhzYP6QRC1czkxvO70roukQ34JQf7qpPkbNFPUDpKeT+ed3hJ9lFz6E5GKqum
         CMMNMTYgdgGP8G89GYB2o76je4JLBskPq5ipzCJErkYrzWlsuqII3HgOjw92/ChtGmfo
         pDEpYqMZNn5z2vGIZUV1uL8wj3s+nSc0x0BqK3/XTFHKeLwbwJWsr5O6rQWY6yjraxJt
         zXHEsFMKOynFp+0+hSXj100TEL5/J5H+39nk9VbDp1LXiTt9akk0Fl1WvBkco454GPpe
         CaFQ==
X-Gm-Message-State: ACrzQf17pX36uXplgXXNiV8GLL2rmtfj0rwGGTguUcV8RcrEo0KrpqMM
        x76+6LymH8TSszTFRRxxmYM=
X-Google-Smtp-Source: AMsMyM532cA7c9SdALzJnm+9LtlGlHwGYvrQZdvr8flF5iPLrSEytOt4ZbYE8PYozV87M620cAHUYQ==
X-Received: by 2002:adf:f8c2:0:b0:236:9cd1:6748 with SMTP id f2-20020adff8c2000000b002369cd16748mr38233993wrq.283.1668030705883;
        Wed, 09 Nov 2022 13:51:45 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:45 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 01/15] Accessiblity: speakup_soft: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:54 +0500
Message-Id: <20221109215108.7933-2-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109215108.7933-1-osmtendev@gmail.com>
References: <20221109215108.7933-1-osmtendev@gmail.com>
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
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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

