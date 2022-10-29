Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB6612472
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ2Q34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2Q3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:29:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F261903D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:29:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z14so10282863wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naPJ1M3MRESguYaKsY0dGxRKs4ndHregyKB6rOGXWB0=;
        b=iRIp0TqQ2a7nIzesUVtuCO+QYyAWZqwk0+jOL/UdMhoHEH9FDgsTtnIUqJ3pWoDUyi
         WujkEwlvw94XMT1h9xv2Vx+fIcY1PZ37/6knKsey062xGogSWWbMbKlGp4HkHCg9Uujw
         aGvZNbt8t9Ra7IyMKwWwVRsZ9UBb0GECv6zLWOQKELviTHF0FftwwKFn8QPL1Zp16N1M
         qraSVUSrGu6WlIHRRUidTVGJ/hN57+Fe8i7xJfraZT9Tb+JvwzZ1DuUsLtY98J7hLGvf
         gvslJEL2UrgHOx1OEXtACgK8UYLuWpSAoVFjtMvKv65DzfdOuSmbg3j+yKNOLFj8dc5T
         XwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naPJ1M3MRESguYaKsY0dGxRKs4ndHregyKB6rOGXWB0=;
        b=7RJwuFsduRxHAREQCGEvDXKz3E5qTv7nTzyY0Oo+TiBqgkzRIHR4gEUGDHryKibOGx
         aK4ANU3i9PqcgGeQyM5DuBSNImlATOvBc2rcNaIafUHEUkwPOhcnuaHNtqxWHLTR/M+F
         BpjMRv8/0O090KX8x9yWhZ77MfVeUMhahhKB0WLPkgV2eyZ9RaB4mEr6O11XvOD8710S
         msGzI9B/SdOt45K41Uj/6pVhye2nAmyOF0YZ3pIRcJm9++76ycMVdYjz6JAYoECcKKa/
         quWnMObyKiP3PjRMEcQN//XK/Z/hkhk05B7xSCqjczjmeuqh3ypIxJqQqZLsufZLDcKN
         TdKg==
X-Gm-Message-State: ACrzQf2Nd3N05i3x5j7/ssm1EIzh3fjj2JcpJZHIfHYMhfxUaGanh33k
        6Uy3epWKtnAtNHGALTJqcdk=
X-Google-Smtp-Source: AMsMyM6wppk46ICtVnZY+qSEnraGuDX71IJNPpcedcxfV96gDwEO8xOlqKh2GfYS3xF4XiBlzJaJdA==
X-Received: by 2002:adf:ab1d:0:b0:236:6301:c77 with SMTP id q29-20020adfab1d000000b0023663010c77mr2669890wrc.119.1667060989045;
        Sat, 29 Oct 2022 09:29:49 -0700 (PDT)
Received: from localhost.localdomain ([111.88.98.191])
        by smtp.gmail.com with ESMTPSA id m11-20020adfa3cb000000b002366e3f1497sm1906007wrb.6.2022.10.29.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 09:29:48 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_ltlk: specifying the default driver parameters among the module params
Date:   Sat, 29 Oct 2022 21:29:28 +0500
Message-Id: <20221029162928.18071-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_ltlk module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/speakup_ltlk.c | 53 ++++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
index f885cfaa27c8..1e279ae143bf 100644
--- a/drivers/accessibility/speakup/speakup_ltlk.c
+++ b/drivers/accessibility/speakup/speakup_ltlk.c
@@ -18,17 +18,28 @@
 
 static int synth_probe(struct spk_synth *synth);
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x01+35p" } },
-	{ CAPS_STOP, .u.s = {"\x01-35p" } },
-	{ RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
-	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
-	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	VOICE_ID, FREQUENCY_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x01+35p" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x01-35p" } },
+	[RATE_ID] = { RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
+	[VOICE_ID] = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
+	[FREQUENCY_ID] = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -160,10 +171,30 @@ static int synth_probe(struct spk_synth *synth)
 module_param_named(ser, synth_ltlk.ser, int, 0444);
 module_param_named(dev, synth_ltlk.dev_name, charp, 0444);
 module_param_named(start, synth_ltlk.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
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
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(frequency, "Set the frequency variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_ltlk);
 
-- 
2.25.1

