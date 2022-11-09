Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2911F62361C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKIVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKIVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAED2F669
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t1so14275wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boS8HxlGzsxbChOlGkq0DtRPYDF6UJD8zMl47kQ+4w8=;
        b=q2m7GOjbfSAJCsCJFJph4h9NzEm5tzLu0ryTihhMhGPt8XNnd5btRZCn8nSBnozhWf
         pzDfJZF0pZamAZJF3P4zGcNYGdIi8vMVfOFenmAx4unShlzfb/H6cPm19uVQZF5iZ8Yz
         bgsSWFN+BJmheJJtcxw6sNEW+ZbpPW9Lp+MqwZY4axyMU6wy5STiVsNVJluSWFR0Zz6M
         QpboX8hM5Kt+h4s83aGzZoJxHhgH3fhTRzL0Uxb6K1JexxGi9ybCPb+filwmIFkrcx3J
         2WQNDCwe3xNeAv5NrU9Msl6yoTCoU3f8caPWQK21YtckvAWHQ1pDlzIvXyWHfRrZX3WH
         I4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boS8HxlGzsxbChOlGkq0DtRPYDF6UJD8zMl47kQ+4w8=;
        b=y3lxMX+ww3XgEOERv2UIE86tURmpFPA3PoikKcrGd6nheJne2KBTXZJDr6sq6UNQWz
         UNASRyg036HzQpoO3tQAucQ8YW6FTol/YZo1H1Od/9bkvcUnohQ8O7EQjjUMSx+mj2eu
         yxhc1+JmLi1xMkeGAFHWpRBpDIBCFUDrUQjq+m58f0JsWn2GLe7haagS4JcZ30pmH1+v
         Zfqfh5+BZpMWeiKxGqwb75IFWJz4AMhTietJxJ3h9xq/w7MXgoY8j7FSpQFTRAe84ARc
         3y4BCfrEq7xm9L/x8wvL0e55aCN8BnJL7YvRgUzMZC3eVEiXHbZzi2W2RUGoBljtZ5pW
         weyw==
X-Gm-Message-State: ACrzQf2rN9ur3Ks5EwZF1HfySJsBHqGwYi7c0QtDbF2MSzP0MI3SDOAU
        ooYbTiLwAz8ZAQQV9OBb3v4=
X-Google-Smtp-Source: AMsMyM7VK8ZDI0MYRWpu1W1DAadAaRPc+3qNqFxWq7aoNIVgrROiQ5TEYmdgEzvGoGaVsXtM/tNq1A==
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr36462888wmc.63.1668030715200;
        Wed, 09 Nov 2022 13:51:55 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:54 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 05/15] Accessiblity: speakup_decext: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:58 +0500
Message-Id: <20221109215108.7933-6-osmtendev@gmail.com>
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

Adding a default variables to the speakup_decext module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_decext.c    | 44 ++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
index eaebf62300a4..271bcf279bf9 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -38,16 +38,25 @@ static void synth_flush(struct spk_synth *synth);
 
 static int in_escape;
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 222]" } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
-	{ RATE, .u.n = {"[:ra %d]", 7, 0, 9, 150, 25, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d]", 100, 0, 100, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:dv gv %d]", 13, 0, 16, 0, 5, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_ID,
+	NB_ID,
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 222]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100]" } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d]", 7, 0, 9, 150, 25, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d]", 100, 0, 100, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:dv gv %d]", 13, 0, 16, 0, 5, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -225,10 +234,25 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_decext.ser, int, 0444);
 module_param_named(dev, synth_decext.dev_name, charp, 0444);
 module_param_named(start, synth_decext.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
 
 module_spk_synth(synth_decext);
 
-- 
2.25.1

