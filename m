Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C138E623625
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKIVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKIVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFED31F86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v1so27842052wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsVCjMUiSVthlr+vgQCdnAlc6L3uC1kVAH/ssI7/ACQ=;
        b=AmHNjmKEDQ7GtSBT6QCvL4l2GRuwkGZNe57eloXOq7GX+c9qSw5izDhGlsPKuYQvpg
         7vxP0SsgHJnRA3GxOqgZWZ3qr6XtEzPJKsQgjvfC5QCDySid0UpTAsWenxBeXALoNwRX
         //iN4KBuxG3Vvr1XTKJLU/eePr/tEKuV5GiVz4xXSAiwwbVocH1Hnn68b2spYNdJDerD
         mgm5bLcLjc0tEUxEB88c8c5BC6Bvto5VCg2K2O8ZOpeUEWaK1loRfgxYTo0Y8yHLwgf4
         0rG6mH5sqaSf2kOr0mxE6zAsXF+fYD+ovNxI16+m8Um9tlFB65A9ZrJl+kJFmQJsYI93
         OQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsVCjMUiSVthlr+vgQCdnAlc6L3uC1kVAH/ssI7/ACQ=;
        b=WJKGlBrJF0o3pz1z+21xgUfbd1k+cffASvDub+JHAfYxfkhYoCBmtLRNuvYJulUUrk
         e+V9YoG9lf/D2Jw3qUr1ZcX46Dg4NXDYGq5ai+GQycpSo1YA2lgfEy4aW0bW4rXnZNRR
         FVY4B4zHpcZ4aLnO83vXUlz5lRFJ2H6xRswToVcM+nDa7GmS8lZjkIFnfzrLx2/wzZeB
         NQYq+8ec/rjQhBBP2rV3/jFfvygSrPHW30aJZtxOphGF5WVMh4X9GhSFoKeR6NpY1c13
         hb7tXaUcqNdfgVsTf3SxHs0KTM/7z8K8y1iqIg+VW0vMfs3gTKQY5Qj2I4cPsEFIpwAV
         lWQA==
X-Gm-Message-State: ACrzQf3F0bEEuCAeIpHKZcLnroEJRc4aftTlH7vqm0L93SrmtX/WlLD4
        /84xbCfujWDIa/ulsb7UdMQ=
X-Google-Smtp-Source: AMsMyM5xJADA0SVmHM+M47JT6o1JcpOwivZ/HE/83VTIDSGzlf1ZnBJ31GY9t2u2PL8bfZiUldm4Jw==
X-Received: by 2002:adf:fc8d:0:b0:236:7433:2b2c with SMTP id g13-20020adffc8d000000b0023674332b2cmr38336860wrr.527.1668030734288;
        Wed, 09 Nov 2022 13:52:14 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:13 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH 13/15] Accessiblity: speakup_txprt: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:06 +0500
Message-Id: <20221109215108.7933-14-osmtendev@gmail.com>
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

Adding a default variables to the speakup_txprt module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---
 drivers/accessibility/speakup/speakup_txprt.c | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_txprt.c b/drivers/accessibility/speakup/speakup_txprt.c
index 9e781347f7eb..4d0a0d4c41f0 100644
--- a/drivers/accessibility/speakup/speakup_txprt.c
+++ b/drivers/accessibility/speakup/speakup_txprt.c
@@ -16,14 +16,29 @@
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r' /* process speech char */
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05P8" } },
-	{ CAPS_STOP, .u.s = {"\x05P5" } },
-	{ RATE, .u.n = {"\x05R%d", 5, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05P%d", 5, 0, 9, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05V%d", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05T%c", 12, 0, 25, 61, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+
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
+
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05P8" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05P5" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05R%d", 5, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05P%d", 5, 0, 9, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05V%d", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05T%c", 12, 0, 25, 61, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 	 };
 
@@ -112,10 +127,24 @@ static struct spk_synth synth_txprt = {
 module_param_named(ser, synth_txprt.ser, int, 0444);
 module_param_named(dev, synth_txprt.dev_name, charp, 0444);
 module_param_named(start, synth_txprt.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
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
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_txprt);
 
-- 
2.25.1

