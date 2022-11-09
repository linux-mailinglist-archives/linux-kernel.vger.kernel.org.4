Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79C623627
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKIVxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiKIVwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269832048
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v7so41786wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phMCunUzMzBIeOwh1nBHGGoR98Q0GIyBGyO5sBxaNIA=;
        b=AKxVP8KAs6BwhhVH3G+S7ARHO9+hYYs4x3O7zMhZvEFip1+/ncNQF4EzTrhRLyChbd
         luEqp9POqScQytEfHUTyQvmoYBn9oXFGMFDbaMvMsBmIBrQuBhdH0sFOfO9zHu26hR5n
         rM2NXoZj1t9il+XCm1945M/xm63RVftKXlj136GqqTnQ33qwADkuVogz+GGtAyXE6L4+
         CDuOjev7YxZEN213jsG96qqUQEIztWjP50y4Uy2rPHyEcTj9oEZasEvtOrPdT+39RRNg
         zjYWwRz8L7AfD+/y9zDldX0YIflE+cp5I+iAfSWztCekvJZcOLMBoe0sjnCQF1uIUGxb
         Ho7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phMCunUzMzBIeOwh1nBHGGoR98Q0GIyBGyO5sBxaNIA=;
        b=0ECuwVdG+EwEmyUYNwrWi58inrymuZoGJVo8Ot5IR4HZgQj5uVNJGpEDlvARPQkYHv
         Ehf6lOTloVjGwf7LXkSFC9hFzusbASe23IyrpUahtGd2yMIrMJAQ9KwBrWbvW0k6+F3w
         YK67NwA1S3LTVrVTkoxSWdy++DX29Q/ZgZPx553gwTZG1fYwg1JubaisbmCAsrcOwjfx
         R4osxkHG2i0WV9UAmnnLqAuU5RtYLUUT4pvOkINZ9iL7CJ9/2Y601oCJlIRxgzVwpr68
         seYnlBq5dWdE62Sy0515aPVHEgz/9I591I088XeWtuZBgthcfZPT1FtyZZGKODe6HIbl
         DOyQ==
X-Gm-Message-State: ACrzQf17OI0hGD5XB9GUfN0KxxiE0q0OwHiqczBAoKR1cZwwSEdbD6Pq
        NJuSUsLn2rSnh0+Q0MB6UlQ=
X-Google-Smtp-Source: AMsMyM6oq0Jl45EMpOH3LllWK9SSAMmpjuD39PM8U+UOcGHJnVHIHvStA6KZ/1SZUWapaWfnGmXB8g==
X-Received: by 2002:a05:600c:3ac5:b0:3cf:8897:3205 with SMTP id d5-20020a05600c3ac500b003cf88973205mr26881813wms.76.1668030738871;
        Wed, 09 Nov 2022 13:52:18 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:18 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 15/15] Accessiblity: speakup_acntsa: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:08 +0500
Message-Id: <20221109215108.7933-16-osmtendev@gmail.com>
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

Adding default variables to the speakup_acntsa module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_acntsa.c    | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
index 2697c51ed6b5..26bb9f9399d3 100644
--- a/drivers/accessibility/speakup/speakup_acntsa.c
+++ b/drivers/accessibility/speakup/speakup_acntsa.c
@@ -19,14 +19,24 @@
 
 static int synth_probe(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\033P8" } },
-	{ CAPS_STOP, .u.s = {"\033P5" } },
-	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
-	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\033P8" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\033P5" } },
+	[RATE_ID] = { RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
+	[PITCH_ID] = { PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\033A%d", 9, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -129,10 +139,21 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_acntsa.ser, int, 0444);
 module_param_named(dev, synth_acntsa.dev_name, charp, 0444);
 module_param_named(start, synth_acntsa.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_acntsa);
 
-- 
2.25.1

