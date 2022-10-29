Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462C612470
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJ2Q2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2Q2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:28:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451784D248
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:28:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y16so10253635wrt.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+6OniPFsQzB3zTWH2jv2l4fJgOp1Uq5eXBQBFuNQgE=;
        b=IEII3rwNqt8gNZ3yv0rfRJMszfPFA12+pUCRuGe1UecU/6kL3pCnGzcY3XvZ08yngU
         hPhiTwjgvuDN9OHofYTDFQf/UN7DIu0qLvnMl4UMbzHOstSk+tFmBmTXY7EnrhkMaMZO
         e85REN8j5udx5wFWNqReVFlqJ3iNrLADdb7qNKKEvwMBklLCfDZWCFwYObvL9Fmu0i7b
         rAk7hUEN28mOTxEmq/fI23ItgPpmfbMw98HEB7P5aFQ4yM7hu9uxmBCewinP2bPJjE1m
         NZ8klxVMp4LowqJ4AHUpzh9j27CY7xG0KC4W6aOPrKJXsLGUzU+dqc/bDd6jr6SFTTzG
         26ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+6OniPFsQzB3zTWH2jv2l4fJgOp1Uq5eXBQBFuNQgE=;
        b=lvkBUiGrTfTMHhW/POi3+0KQU/TktgSsie3EaTObGh3Pw4ZVjFjx8SfHPcbe3wH/Xl
         cEQfKkLzQeAObM4ozu0TBISUR4MOZJqr1eljuVXgD25C9Px/dc4GIt7EV3wCwuVsxwvr
         g6E5WU2EJzUXHfLoLkekvAtgQNcuzW/8oLgYKD/mZ7iXCRa8NLR0+T74xSH7As4szDdc
         bWMy7BWz2AbCJVKVvEgTlGS4bR1mIbSkjXOpiZ+7I5MjMeaRjXFkjnwzK3IuIE+KjTtx
         ZvzA7ObUxTCX7YFLq1Ppxr3FkruD9T/g3YbalRKWEOy6NT5H6WA6Qyqtgkl0+doXhhnK
         QtDw==
X-Gm-Message-State: ACrzQf2YWiV5l6Liw5j8fdjhHQJ1jDRud0gatAf/ztZ9WViy8qP37PUj
        fLWsxiw7WtF6rAzaeVpbgzo=
X-Google-Smtp-Source: AMsMyM41J32jdK6fVQALY/XcVFeSNblAPwmzZkkxwqwTOWJXtSWKITRVYoeb21hx8EB+yivX4HmAsw==
X-Received: by 2002:a5d:654d:0:b0:235:197d:72d1 with SMTP id z13-20020a5d654d000000b00235197d72d1mr2720537wrv.680.1667060897761;
        Sat, 29 Oct 2022 09:28:17 -0700 (PDT)
Received: from localhost.localdomain ([111.88.98.191])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d550d000000b002366b17ca8bsm2158212wrv.108.2022.10.29.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:28:17 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_dummy: specifying the default driver parameters among the module params
Date:   Sat, 29 Oct 2022 21:28:00 +0500
Message-Id: <20221029162800.17813-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_dummy module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/speakup_dummy.c | 53 +++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_dummy.c b/drivers/accessibility/speakup/speakup_dummy.c
index 56419dbb28d3..52b2c5d44576 100644
--- a/drivers/accessibility/speakup/speakup_dummy.c
+++ b/drivers/accessibility/speakup/speakup_dummy.c
@@ -18,17 +18,30 @@
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR '!'
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"CAPS_START\n" } },
-	{ CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
-	{ PAUSE, .u.s = {"PAUSE\n"} },
-	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
-	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	PAUSE_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"CAPS_START\n" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
+	[PAUSE_ID] = { PAUSE, .u.s = {"PAUSE\n"} },
+	[RATE_ID] = { RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -129,10 +142,28 @@ static struct spk_synth synth_dummy = {
 module_param_named(ser, synth_dummy.ser, int, 0444);
 module_param_named(dev, synth_dummy.dev_name, charp, 0444);
 module_param_named(start, synth_dummy.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_dummy);
 
-- 
2.25.1

