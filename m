Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82806153B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKAVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:02:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F22186C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:02:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so10149958wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfiCDfUEZKKo+h0F4RKYm7I0mJZMn3mgYwtkAwyb1dU=;
        b=fhzTolg7K3qLn0xUPxwZ6qjJPwRP9WqmyyVIPs36zIQ9G/ZBmvnpt3FXdOal86J69N
         ttVcGw6uDqsd8WRjGmK8YAbM9CFhA3DMnbtNzolbKD7n70A0VTIJfJUKLD8h04MYCU+E
         tuqTeoLU4PYpNzGkWHeOFMMrhOIdWhdrTPTj60Hfj2GCi2t8tMKjyKS8zQCiMlhQCvYb
         8MzqwAJYWV9TdRpSTneCjOcr5r0eeXF7unwtCCfMezRnhOoNPc7yl5omeinX04aQG0nr
         c1BbuVlpPAxj80QmjxJMybNAAbjujlK4YAVqArpqs+Y39VhUquFlES8D+eC1UAgXADTJ
         mpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfiCDfUEZKKo+h0F4RKYm7I0mJZMn3mgYwtkAwyb1dU=;
        b=UgIjqRhO8jSxrP+asHHe9jrYyJduB6Ub8BD/tZ3Fem2Ae2Hrlnu2is2pk8+z0y0np0
         r1vmeWmySbK8moz2JeWck+dpgAUIF3dWdFh9LxJwwFESz/UooiacQwINf85MeU4cxr/D
         BpbUchmnY7PUCvw1sjGQ33P6XfNDPMHcqHLtGJXFWeL5D7WQ4h3qpYKdHCl6hzcZTHb7
         yB4Quxsvt9S7IMxHl3GL6h26wiQRrnsku3+yaDUofemagvCLQzdSRn11+aW2QJqARqRM
         q2rwQSY02Y26SKkBQsDEwAsCUF2rjbbu/s5/+kTY4sQVksQ9mSf5qLCeQAT5ovZBPZiB
         LKGw==
X-Gm-Message-State: ACrzQf1q5H2PLm06W/d5tx0N91W0wsnQb50RShjnDWTMB5O96XpZUvWp
        q0VFxCQYZFWylZXWG+gSrbs=
X-Google-Smtp-Source: AMsMyM4gskXfLNR7Dw5s078cVKo6sEM8/Voq3kq3BOvabmmMAQWLB7aYJ1HkQytik9FhFLTc7E6JXw==
X-Received: by 2002:adf:aa8c:0:b0:236:6e59:99ff with SMTP id h12-20020adfaa8c000000b002366e5999ffmr12387702wrc.688.1667336520567;
        Tue, 01 Nov 2022 14:02:00 -0700 (PDT)
Received: from localhost.localdomain ([117.102.63.160])
        by smtp.gmail.com with ESMTPSA id p10-20020a1c544a000000b003c71358a42dsm12051886wmi.18.2022.11.01.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:02:00 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_decpc: specifying the default driver parameters among the module params
Date:   Wed,  2 Nov 2022 02:01:53 +0500
Message-Id: <20221101210153.10519-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_decpc module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>


---
 drivers/accessibility/speakup/speakup_decpc.c | 48 +++++++++++++++----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
index dec314dee214..083ca9265805 100644
--- a/drivers/accessibility/speakup/speakup_decpc.c
+++ b/drivers/accessibility/speakup/speakup_decpc.c
@@ -134,16 +134,27 @@ static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
 static int in_escape, is_flushing;
 static int dt_stat, dma_state;
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[:dv ap 200]" } },
-	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
-	{ RATE, .u.n = {"[:ra %d]", 9, 0, 18, 150, 25, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d]", 80, 0, 100, 20, 0, NULL } },
-	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
-	{ VOL, .u.n = {"[:vo se %d]", 5, 0, 9, 5, 10, NULL } },
-	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
-	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID, INFLECTION_ID,
+	VOL_ID, PUNCT_ID, VOICE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID,
+};
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[:dv ap 200]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[:dv ap 100]" } },
+	[RATE_ID] = { RATE, .u.n = {"[:ra %d]", 9, 0, 18, 150, 25, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[:dv ap %d]", 80, 0, 100, 20, 0, NULL } },
+	[INFLECTION_ID] = { INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"[:vo se %d]", 5, 0, 9, 5, 10, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
+	[VOICE_ID] = { VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -483,8 +494,25 @@ static void dtpc_release(struct spk_synth *synth)
 }
 
 module_param_named(start, synth_dec_pc.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(inflection, vars[INFLECTION_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
+
 
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(inflection, "Set the inflection variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
 
 module_spk_synth(synth_dec_pc);
 
-- 
2.25.1

