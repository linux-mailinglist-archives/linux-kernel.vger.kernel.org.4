Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A4623626
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKIVxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiKIVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1831FBE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so27883783wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVa9D+c6P7uTx0fhUi+7ocLfNmZ9LwakhMxKgE7GifE=;
        b=LP3LYSpzGRzPcye/zt3E50sgEvGfSLYUzG+wYp5b7VaC6EypVoFbtn/GCMJ1ZDKBlC
         i9R1QEFtNY6q4koNMQTk8gtDjFzsfEmMOtZyy7s0bxa08kiiU67gG1ytxLrh+qBHDXwy
         EkIqOJuxuARGQKiqqVC0GzcFSdWkuFK2YggIlAyFBmfWB5dVPddvsoozJNm4tAhfq6Bm
         BUgyWy3cMMpt5mUwpCBxeR3Oq/Y47JvzUT/gCvWEQoD5sinTMcpd0oDi7g+GEH6nVKci
         /riTJfgsQ40yUKZJLMw+UrZiXigTJyD8dJm9x6SyDf4YD7H9DDD0euip75dgURHmLu88
         auTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVa9D+c6P7uTx0fhUi+7ocLfNmZ9LwakhMxKgE7GifE=;
        b=rD4EoCiciLE+Hqi+fRMNDrv1RqMeHrAZ4pUEjJ/4OmlwcHqRz/zJcHP7hMIATF8LKX
         MhjVgTtPi6etUu5b6BlJCwKptq+nctLAbnc7Kml6dE+i2o+iB2i3t1wRfcFW+daD/Z1d
         sJGrfIFXILgrp5gFALS9qfkPewk+sIzOIz40ySCqxY3U2Sp+sBxsDE9Q7qkU/tr9cZtP
         rmOG/rE/VzneOPF9ay26+1VQc1YKlH89eTPOfECOjMCpAGBL3bN0R/nltnpMPmgpvtx4
         vJ4cE14He3obtOim7wcFDSaPgCpWm2spPwE6k7aSzISdXQsWFFf+y5Q7Lf9ON8Ik9J6i
         S3Iw==
X-Gm-Message-State: ACrzQf2RdrSHuZoJHE0DpmIBLQSAHxvdkncgVD/6MkRTWvb01wRVgIeJ
        Npkcyt/u7GlKRXO2IigIEis=
X-Google-Smtp-Source: AMsMyM4cAlRcwoJbrsbpAMPJaL9bkonqfaH+AbZ+q2eknWxvSgXWC/IPsb5VJ0o8yKzoJr8OgT3/GQ==
X-Received: by 2002:a5d:4143:0:b0:236:4b40:bbd1 with SMTP id c3-20020a5d4143000000b002364b40bbd1mr39221317wrq.26.1668030736528;
        Wed, 09 Nov 2022 13:52:16 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:16 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 14/15] Accessiblity: speakup_acntpc: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:07 +0500
Message-Id: <20221109215108.7933-15-osmtendev@gmail.com>
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

Adding default variables to the speakup_acntpc module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../accessibility/speakup/speakup_acntpc.c    | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index a55b60754eb1..a27e6bbf05da 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -34,14 +34,23 @@ static int synth_port_control;
 static int port_forced;
 static unsigned int synth_portlist[] = { 0x2a8, 0 };
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\033P8" } },
-	{ CAPS_STOP, .u.s = {"\033P5" } },
-	{ RATE, .u.n = {"\033R%c", 9, 0, 17, 0, 0, "0123456789abcdefgh" } },
-	{ PITCH, .u.n = {"\033P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
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
+	[VOL_ID] = { VOL, .u.n = {"\033A%d", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\033V%d", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -305,9 +314,22 @@ static void accent_release(struct spk_synth *synth)
 
 module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_acntpc.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
+
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_acntpc);
 
-- 
2.25.1

