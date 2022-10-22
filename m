Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA6608F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJVSzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJVSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:55:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331526DFB9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:55:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pq16so5084427pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8r214wWE7zjjfRsL7EG52aewGItvBIYti1XHkN0YTg=;
        b=XAZHIjgp3srSUgWg4TL/rsOSq+KMV7pemBBKkJYg2J2bmFG/H9Rb05QI8Eb0ZqIKnt
         qNGNZ9WeNU5gpYpyglc5JP34ay6zgGcD2lXiReJUtH6e/vUfdxEBoBv9KX1Q5N3liYiB
         d10OXn06m6VdglEHuZ8ZYoEvw69NyExKWVf8PrHraFblDVxgL8qXo65GDTBGZR4XHhZF
         vCm6Oqfe0f2yRTMSlcKqVXrGXxv4LnmksLF9FaqjFsiPs49ayANq+ThQXf94utlFoa+w
         2eN2G7rYsFEb+5DoprH6e09ZCI/tzDzXzQDBlmR3o/7Rx9okKxmWGf+pDbQ2sEkxboS+
         9g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8r214wWE7zjjfRsL7EG52aewGItvBIYti1XHkN0YTg=;
        b=QWPdMjKQTsefygv3d70aX1B6+TSuP5fHoSDUN2Jkh2gQvqdrfPiGdpJlMXTSuWMXMq
         AI1quTJvs0pMRE5AFq5ROFr+8aFh454ykhOpo+XoH7J0p2dJuRAI0YshanrjdnaGgblT
         hFSmEgv99RdOMoXriSrP3j2BR6RK3JT9V1hxxn+Od9KmT3wA9qqVtVQszPw6Ciaaa1fM
         xD6NZfEABim4je/mt+ZfYbBjgWheQD8rPb11RvVl8uw4HFzEO3GgZV/NVWgG7WXK25Sj
         4Z5EM/L3Zq5ZEcpO+RoGHN9mvS6VZXOukaM3sWaeMMMM+pmO8Qlk6WI79Zuy6qaP7BL8
         kF/Q==
X-Gm-Message-State: ACrzQf0fI3ukGAbOfLqjnd7kySAejzphH77nqJBVhQLQEPosduUXVqTo
        v3+jYyZEJOnaYCgyz9a1JAc=
X-Google-Smtp-Source: AMsMyM52GmkZx9zvmh5zXxm8pN/Xj9HVhSKBellDrrO90rIOw78EQ91ZWCBoP2b8zlzvb4TYuiu+5Q==
X-Received: by 2002:a17:90b:3ec3:b0:20d:9da6:56c1 with SMTP id rm3-20020a17090b3ec300b0020d9da656c1mr30033198pjb.156.1666464912617;
        Sat, 22 Oct 2022 11:55:12 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00180cf894b67sm16969720plh.130.2022.10.22.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:55:12 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_audptr: specifying the default driver parameters among the module params
Date:   Sat, 22 Oct 2022 23:54:51 +0500
Message-Id: <20221022185451.3825-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_audptr module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 .../accessibility/speakup/speakup_audptr.c    | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index 4d16d60db9b2..55813f3e40ff 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -19,15 +19,24 @@
 static int synth_probe(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05[f99]" } },
-	{ CAPS_STOP, .u.s = {"\x05[f80]" } },
-	{ RATE, .u.n = {"\x05[r%d]", 10, 0, 20, 100, -10, NULL } },
-	{ PITCH, .u.n = {"\x05[f%d]", 80, 39, 4500, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05[g%d]", 21, 0, 40, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05[s%d]", 9, 0, 63, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x05[A%c]", 0, 0, 3, 0, 0, "nmsa" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05[f99]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05[f80]" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05[r%d]", 10, 0, 20, 100, -10, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05[f%d]", 80, 39, 4500, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05[g%d]", 21, 0, 40, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05[s%d]", 9, 0, 63, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x05[A%c]", 0, 0, 3, 0, 0, "nmsa" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -158,10 +167,25 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_audptr.ser, int, 0444);
 module_param_named(dev, synth_audptr.dev_name, charp, 0444);
 module_param_named(start, synth_audptr.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_audptr);
 
-- 
2.25.1

