Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54184623623
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKIVw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiKIVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2831EFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k8so27919570wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWzTyDXe6WKEiZlJR/l3thqarFb+PbNri74dj26a3wQ=;
        b=VDJ1rNdFE9BJ/heAGm41xdjbaBiIKUdTJMHilrB3mCuuQaeU2eCj5UVCH6cvottRoU
         s9Ja1VvRSS7eGcHr6MQp0A800cb7Jm6/6K8z0fmNlhQzzjB34VfCOu8DvA7pUKsQIXmm
         DSXA3pRe8b7ZstTlvnXcwXq0XEdHKQfGJhtPXEl+EHYOkFMe7UfDE6wM8NVK5ZasOrpt
         LImJztUVAXgHLgSZqU6/JIz9cv1jeG6PTbM/qjAXK7NyA4TSnJw4NZadVTAnTXrkB+Rz
         t/fVhPz4YGu8vn2hVrMg1U2AG69yG+/4WvvSB0cGQJE4krHxxRll0te/wSZZyBPsMDKZ
         Vs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWzTyDXe6WKEiZlJR/l3thqarFb+PbNri74dj26a3wQ=;
        b=HXBdc4pgrsrBHWP/NMuYbCULbuCNxYuWMeR8YBd1HM0wIDx0Z8FbSUBrB/DzJbAylH
         BF9Wf6meY9ErdCE9VfE4MmxWE2oAhVRvb49f6vjR8MURj+wPTAMIEH5MWUCdHwF6AtYW
         leON27LmHMYISa5tGevhj8Ku4LBbM8OFi6XEogGG2xklE+C6jcxhoheJUoYZze2qcjiS
         gA/DBTdRizE/oEq337WwkKRqfH2P1B5YGvvRY5g+eU6YPHvc7hU1Qv/73G6VP/i6mTyC
         hPf/agOHMrmnqNv+1wtrAXutDMFjG1RhRhU/8zN2wh6fu6bSGP5uECyEyfkzeklrcrwP
         lrNQ==
X-Gm-Message-State: ACrzQf1BmrEoAFpk9X5zU0aA10gNvUt1qgEEy6dmqaTcu6ppkfdV2fb5
        F1QM+kWZICMYLQlHvCQlikc=
X-Google-Smtp-Source: AMsMyM5ubrqXzrDxfOzpLI6oxFu5+qu62eAlK6dAQS0Q1ojzSp5KoZiQvnvFC7x+6NLOcvfb7P4YeQ==
X-Received: by 2002:adf:b612:0:b0:236:5d1f:143a with SMTP id f18-20020adfb612000000b002365d1f143amr38595679wre.364.1668030732042;
        Wed, 09 Nov 2022 13:52:12 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:11 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 12/15] Accessiblity: speakup_spkout: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:05 +0500
Message-Id: <20221109215108.7933-13-osmtendev@gmail.com>
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

Adding default variables to the speakup_spkout module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_spkout.c    | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
index 5e3bb3aa98b6..d3f26095b0ee 100644
--- a/drivers/accessibility/speakup/speakup_spkout.c
+++ b/drivers/accessibility/speakup/speakup_spkout.c
@@ -18,15 +18,26 @@
 
 static void synth_flush(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05P+" } },
-	{ CAPS_STOP, .u.s = {"\x05P-" } },
-	{ RATE, .u.n = {"\x05R%d", 7, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05P%d", 3, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05V%d", 9, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05T%c", 8, 0, 25, 65, 0, NULL } },
-	{ PUNCT, .u.n = {"\x05M%c", 0, 0, 3, 0, 0, "nsma" } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05P+" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05P-" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05R%d", 7, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05P%d", 3, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05V%d", 9, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05T%c", 8, 0, 25, 65, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x05M%c", 0, 0, 3, 0, 0, "nsma" } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -124,10 +135,24 @@ static void synth_flush(struct spk_synth *synth)
 module_param_named(ser, synth_spkout.ser, int, 0444);
 module_param_named(dev, synth_spkout.dev_name, charp, 0444);
 module_param_named(start, synth_spkout.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_spkout);
 
-- 
2.25.1

