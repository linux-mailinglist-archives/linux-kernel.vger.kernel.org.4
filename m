Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8362361B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiKIVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiKIVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:51:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E631222
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:51:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j15so27885605wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMmKnPb8bt9RPUpP3Rhq8TeODQK24exw4CBcMlQiVXI=;
        b=NOF0QBqZzXe7QsCM/BHH3UTr2iNqFkh300w5qy7vlsZDVd6DT9cU/oZ0jth3K3ugHk
         jSf+6x223xwxz0KZ8tYA3RbVjjFyrlM7cmAUzxFsrAelkgM2g0feF+k4BpUhvyqQe2aG
         NPOzUPBA02X6r1KQ3n5IukbNAFz09/JuG7gtqit+PLYx3ynBLEu39EPnn6yKSMwYryhM
         +GTXNMTWJPEsWjKQU6aZ5HHT209A38tWbUW3uDQ/lRoKoBPAWDzWvvYNbGbmj8gmXg3O
         g5wI4Pq8Gj3gh1Tqf0BVI5vkQ6LsABS+AqznUqgRreDWfj9zAJ09aWMV2VoCwVaCCCF0
         j4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMmKnPb8bt9RPUpP3Rhq8TeODQK24exw4CBcMlQiVXI=;
        b=79NTbg8zRtzOO444+eg26V0hhp/raPzAeqh9S4X9JPAbOhv/TDX+T7Qu8o1yZrlM4n
         DKJjkbdd6nDkqgQKKDcima6jKA8fk/kZQTcWp8JY2tNAh2eg/UemY4Q+zlQQQ9qs8txg
         /ccv6YtaoxNaHh1qd9dSEqlqDYyi4zSFFMpKtVzWywEu2D1iCrnXV+/mT5doenCGCl0r
         O6bnrsMDcL4ZvQC1PND3PKGrhcG0OnjfvYViLPlK0crt1Eayd2ubQ2zMXoB5pRKOGKyW
         MVHta0WW6kZjHC6gzoljJhXL70OW8uUZcTl7yJzy3xjamKrUFFtkKWHy70errXGner36
         JimQ==
X-Gm-Message-State: ACrzQf1MhQlbvn1WJkcUqj+fpiAXVm4ApkraZ09ZqAHYv4GzhLT5pSly
        jhZtpE/NK/olFGWGYlaAqHI=
X-Google-Smtp-Source: AMsMyM4ZOYAb9KJCwjDxwf9UwjV84833Jf3uqAZUFht0/AruY5KIWyZxadaHfo1bBqQl/lL5DgWnIQ==
X-Received: by 2002:a5d:6112:0:b0:236:740e:5938 with SMTP id v18-20020a5d6112000000b00236740e5938mr38970214wrt.155.1668030712911;
        Wed, 09 Nov 2022 13:51:52 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:51:52 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 04/15] Accessiblity: speakup_bns: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:50:57 +0500
Message-Id: <20221109215108.7933-5-osmtendev@gmail.com>
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

Adding default variables to the speakup_bns module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_bns.c | 36 ++++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
index b8103eb117b8..60507756499c 100644
--- a/drivers/accessibility/speakup/speakup_bns.c
+++ b/drivers/accessibility/speakup/speakup_bns.c
@@ -16,14 +16,23 @@
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r'
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x05\x31\x32P" } },
-	{ CAPS_STOP, .u.s = {"\x05\x38P" } },
-	{ RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x05\x31\x32P" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x05\x38P" } },
+	[RATE_ID] = { RATE, .u.n = {"\x05%dE", 8, 1, 16, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x05%dP", 8, 0, 16, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x05%dV", 8, 0, 16, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x05%dT", 8, 0, 16, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -113,10 +122,21 @@ static struct spk_synth synth_bns = {
 module_param_named(ser, synth_bns.ser, int, 0444);
 module_param_named(dev, synth_bns.dev_name, charp, 0444);
 module_param_named(start, synth_bns.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(ser, "Set the serial port for the synthesizer (0-based).");
 MODULE_PARM_DESC(dev, "Set the device e.g. ttyUSB0, for the synthesizer.");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
 
 module_spk_synth(synth_bns);
 
-- 
2.25.1

