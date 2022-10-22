Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C81A608DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJVO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJVO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:56:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC818E1B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:56:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o4so840638wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tXvrHCsrelCqwHQuBkqjhcR6QAT/KqaZfHhYAbPR28=;
        b=faAyIpeB74juxp0oI0CEdLXKe789kz5oYbZyPN3v+rV0UzHJlNcAqgGN/8CMehGZZP
         J6jyDmLHjYuo5wpu+OckOop70PaC6RPM8c7438G2ugEC/Pb9c5SmVf5fdLoMVSKn4mCk
         y3kPscaIRSPLHXExm6YZU5UBGeWcs/uJcg/mxYHcHteJWB15pl2TaUVZwYIAlv2MyP7l
         muMB+Y/05JoS74PvnXz3sGAVOH4HexKsHpuGfeeNfF2FOTMKh2mBFb1JG+nmkCwtlLyV
         kcywv4qB/3H/Zm7gWHvj4FDesJcjTfAY8oM3+vYMI2c/+O3wjOVSfpCgOxTzXFh9qMXw
         fO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tXvrHCsrelCqwHQuBkqjhcR6QAT/KqaZfHhYAbPR28=;
        b=A1e4EZ4ptiPjwuQaFnLprBeDg2i+XNml/GjumdTs/VBO9B0gPiseh+fgnaQW9O1KoK
         XMgEOMOjCPMPGEDiN0CePri6pQMdudyh0gugqt0IsGGWpJWJLQGYjEBykeKrPo8z6uHu
         d8SKr4JhXC9P9p4jcRUq1n036yc6lN/1pgiLTlkjwxEOjK8DyABuSX+BBiTZAI+9Ih8T
         9bocfGcdqDg/H5FM5MVuDjNT0sZdiB/7B0XaL2pl6VH8cCbO+4WpIoo6IImtbwGJGrCT
         SmjbdR19HCJYyAC7F4FAsEkRD7VDAmQKqrpixhUwbIaH5bQHLnOrCd2aTseICvSM+cnR
         NVUQ==
X-Gm-Message-State: ACrzQf0uN7XsikO7AMINEYNgxBWW/uoWQ9u4+bBRCWTSYDKzu6O8likI
        fU+DJS/ROnDj2T+XMnYCm5M=
X-Google-Smtp-Source: AMsMyM7lw3r7i526KBmAk73UWpUtks688vXES7ZIp+RG8FvUccbsyfTSCqVsFw4igjST24KzkKFqZw==
X-Received: by 2002:a05:6000:713:b0:232:bd2e:8620 with SMTP id bs19-20020a056000071300b00232bd2e8620mr15894482wrb.139.1666450607491;
        Sat, 22 Oct 2022 07:56:47 -0700 (PDT)
Received: from localhost.localdomain ([117.102.55.205])
        by smtp.gmail.com with ESMTPSA id s2-20020adfea82000000b002364835caacsm6213512wrm.112.2022.10.22.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 07:56:47 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v4] Accessiblity: speakup_soft: specifying the default driver parameters among the module params
Date:   Sat, 22 Oct 2022 19:49:49 +0500
Message-Id: <20221022144949.24473-1-osmtendev@gmail.com>
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

Adding a default variables to the speakup_soft module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Changes since v3:
	- Patch reviewed by maintainer.
	
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

