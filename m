Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5625FE542
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJMWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJMWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:30:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85866B4896
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:30:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a10so4916285wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5ZR8B8hCF/pTH1ojliEiamiosQgM2tbHPaSGX3EZv0=;
        b=FlEUzUFlAqkR/iyG2/VoHfkkEplVk3NsxdUKDl0ufOhGZyzzb73/pFsPmdvkOGypap
         SoBVWe9V3t9c/mebH/fII9yIJjj6DDxpQq4caeYtsHyIPy6Onwbj7JHxEkOxrT0+wABb
         3+ytlMJmWBCWDLP3A6VMLdhFYX9rzmdPoCw0UNgM8cFaQ/ogkP0OoytXn4iXq983VTC5
         tg+59D96Y7k4/wEtSVQxvkJsO6X/dXB1dM/GjAzHTQTI3J6d1GmBGmE6WVIATkIT7H38
         vZICipvyoAZZKoD68pV6zlqdEcDzv2pypJlUgOBva0vFN0GhVzHTluRwPdL5Gikt3fip
         hqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5ZR8B8hCF/pTH1ojliEiamiosQgM2tbHPaSGX3EZv0=;
        b=GecgUm18WRd5MS0XocU+2A7SUqv4BeKr+3NLSz13/0acUEDaYqLqDgUkfAusL7cQdO
         YvbAn4JQFPh4ygdEZ7E1b/arVr8vKkovybyKXPLxiRBHsqIwI6d6K+hdb++q3vsKuuV1
         0ItMkfizlOJU9yJrV9WbPg9ACkF2BCma5oZ2J781jDk20ZZoGcCTpurvmyMPBNVwwEVA
         L2mi5z26T09Z3gEgRK/Wu/GtnjoSTBvaPrryuFo4PLLDhHNtFPyDqvlEdyRjd4LbkFAd
         qqAPUsKRNGfR1ghDdhxfqRbIiwQ6UDNwDatUuCYshCaUnrIfN67vB/iwloWaGiD/u55g
         sEUQ==
X-Gm-Message-State: ACrzQf20umLIcZVSJDM+YJ/w3g/g24KqkSVM9dAgDEIeREwYrbNzGlM8
        KD3LmZf8DTDtliM6qdhqpNa9Add/ZESLAA==
X-Google-Smtp-Source: AMsMyM6dlgFRBi+eOqpajjdJMUlQgCoXZai+U/H3ctIOeQOImFNcq/b2Lmdy61s+RP34Wue1V03U0g==
X-Received: by 2002:a5d:64a3:0:b0:231:f82e:9a57 with SMTP id m3-20020a5d64a3000000b00231f82e9a57mr1364226wrp.492.1665700230758;
        Thu, 13 Oct 2022 15:30:30 -0700 (PDT)
Received: from localhost.localdomain ([111.88.122.94])
        by smtp.gmail.com with ESMTPSA id i3-20020adfaac3000000b0022e62529888sm564281wrc.67.2022.10.13.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:30:29 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v2] Accessiblity: speakup: specifying the default driver parameters among the module params
Date:   Fri, 14 Oct 2022 03:30:24 +0500
Message-Id: <20221013223024.22708-1-osmtendev@gmail.com>
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

Adding  default variables to the speakup_soft module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---

Changes since v1:
	- Added NB_ID as the last member of enum default_vars_id.
	- Added NB_ID as the size of array vars.
	- Made sure that that the enteries in vars are in correct order.
---
 drivers/accessibility/speakup/speakup_soft.c | 57 ++++++++++++++------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 28c8f60370cf..5d8e2c1e7f4c 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -33,21 +33,30 @@ static struct miscdevice synth_device, synthu_device;
 static int init_pos;
 static int misc_registered;
 
-static struct var_t vars[] = {
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
 	/* DIRECT is put first so that module_param_named can access it easily */
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

