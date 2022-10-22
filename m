Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99811608F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJVSyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJVSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:53:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222011CB77
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:53:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f140so5622048pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5iBspbpKePGC61ymgcrPFuwEnduBRetU5FJxoOev4Y=;
        b=Srm67PqnTf2hUbY33yQk29CRLD/lhkri3ZEan/03ksrUJzvG/rOydZfCpmsuJ4rRW9
         6DPUkmNUmFR2CtYdTkuhMs9puysy4h7b4rrnlzgb7bdaxxyk9fDRlT1GbuCPQAdK2rCR
         C3hYizZZ9FTaG5xPElZIJq/vlhFRFJIZ3kpNOPsqxNTBmWDodPIeFdhSH0EIV8v5KXX2
         BbCCjP7HWWRp2b+4cvNCTuHwhz3UFBPCQMxW+I9DLemgo8XJ075BeuJlSbg/xMJkmnr7
         A/JUTyQl/9C9eic97kOz95N7Tyd9roVy48Iwq4Qgov7M+5s8LsBmvi9i3BMNIUIo5ids
         T1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5iBspbpKePGC61ymgcrPFuwEnduBRetU5FJxoOev4Y=;
        b=H7iLUC1l6xJMOZrl1VL7jw7tDnHu/62K5iaFn/3qQy9P0EO85fyWVWeHUUyPpYAlc8
         59TuB+7A6+LDxoptXGnELU5n78tu9gjrpSq/CUSepEubu8+nftIQWlEoB87UA1Fz/JK/
         KgYmU7nqsEG436bXadcH2T8r2gEM4bU90x5CDRaG9UeO5Lvi3/28dZDvVjYuvzM2lAzs
         FrhpvNnzu0WKvRhaDjJk23cUUKrLWhro2rEJFJuQqDUHlVmfXauGv7wrHY7g4s3Q1Sth
         u5bzhYOgRmbNvKOnXgE6tzexLW7wtlsXshrTjxyO/acCt9LoMjniQ6P6wa9aUPosKUEU
         Rk0g==
X-Gm-Message-State: ACrzQf0zIYJ9I0U+XoXY/lN3ARElNY2sR/ULrFYAd/X1Q3+YxonBpLq7
        FoXQ8hvssrmYARMxCZIVg2A=
X-Google-Smtp-Source: AMsMyM7uku6oe82BZDyTmSLJkBnhZoVmTuiqbsKJHAES6knA1m8NVtOOMP+ZH6m3vRWrYCsQQl9R8Q==
X-Received: by 2002:a05:6a00:849:b0:56b:a2d5:8019 with SMTP id q9-20020a056a00084900b0056ba2d58019mr1568336pfk.47.1666464835013;
        Sat, 22 Oct 2022 11:53:55 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00562e9f636e0sm17891542pfb.10.2022.10.22.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:53:54 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_apollo: specifying the default driver parameters among the module params
Date:   Sat, 22 Oct 2022 23:53:41 +0500
Message-Id: <20221022185341.3636-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_apollo module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 .../accessibility/speakup/speakup_apollo.c    | 46 +++++++++++++++----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
index c84a7e0864b7..d2fbb3f57221 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -24,15 +24,28 @@
 
 static void do_catch_up(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"cap, " } },
-	{ CAPS_STOP, .u.s = {"" } },
-	{ RATE, .u.n = {"@W%d", 6, 1, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"@F%x", 10, 0, 15, 0, 0, NULL } },
-	{ VOL, .u.n = {"@A%x", 10, 0, 15, 0, 0, NULL } },
-	{ VOICE, .u.n = {"@V%d", 1, 1, 6, 0, 0, NULL } },
-	{ LANG, .u.n = {"@=%d,", 1, 1, 4, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, VOICE_ID, LANG_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"cap, " } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"" } },
+	[RATE_ID] = { RATE, .u.n = {"@W%d", 6, 1, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"@F%x", 10, 0, 15, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"@A%x", 10, 0, 15, 0, 0, NULL } },
+	[VOICE_ID] = { VOICE, .u.n = {"@V%d", 1, 1, 6, 0, 0, NULL } },
+	[LANG_ID] = { LANG, .u.n = {"@=%d,", 1, 1, 4, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -193,10 +206,25 @@ static void do_catch_up(struct spk_synth *synth)
 module_param_named(ser, synth_apollo.ser, int, 0444);
 module_param_named(dev, synth_apollo.dev_name, charp, 0444);
 module_param_named(start, synth_apollo.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(lang, vars[LANG_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(lang, "Set the lang variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_apollo);
 
-- 
2.25.1

