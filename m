Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6036153B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKAVA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKAVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:00:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F5186C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:00:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so109567wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9PFST2yxG7MzPenRjlodDfEZ+1vcVsKduoihZ1Ae1k=;
        b=EPqMqFTCkGzwH0UN9bN9BSuRw1ZbXG0ZfM4gbZ1I45qB3X/YSNnXhT0pSg3pIW19vU
         avP6KLlq9I0RUviwy0wFBy880KGbRgMSbI+iorrT3ilAaypzIGZAIF8vGYQ0ETGC6x10
         ldmAOqP9TCyxUUZdv8vkuv1JA/fMjee56xqU5QYymD6bdksz12YrhUd27/+PChWUGfSy
         Pmzh9RR2eXPX8nlBwTeLZjliiUmWRu1Bm/6YLINcgiLhhHRhf/GIm7lOyC+GoqF2Xfle
         gQxOGw5LVUPeZlxI91Phr/WDOV+bgsZfo4i0D63BSJy5PHfv/zM4qvq/sxTeD+OiHxJJ
         icPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9PFST2yxG7MzPenRjlodDfEZ+1vcVsKduoihZ1Ae1k=;
        b=6EGYTJh4hsPoOGTCl3cLUx/hRC7WZPj0tc8ng0K/g1WRgGcFSF4xnWusEaPN8OnnU/
         WUe2RSIkLm/u4apSEFC7Ogdage/x477X3ngBUG6Fx7b8IMyrNVW9+lOqBiXfdeQejN33
         1luTxOGto5To83VO+5Y5N6XO5F8p24FKPSuHfp0zT01AVX6eIXQQqRkSQEg0E042tz4g
         nlbxp5iqpCBM8rRmO4XW5VZMI8zJOMQLwIAkbnFAzqd9dJ0lp04cAxqnS7A8twWz8e4p
         7+BVSRvXdW/JOAEZ2PqYS527+79zBiCH1I819kMGdAL02/DuAt5X1KBBKlFNoJ3BI1ja
         eBNA==
X-Gm-Message-State: ACrzQf2PrKk9ljdpGrJ1R3beMD4WLqzzi4dRAVSeI8SN5ZfUmNqQz/Cm
        qT0Imy1sZ2THe7im6I9znYXHp2uEpZyG6Q==
X-Google-Smtp-Source: AMsMyM772PNlXZQMzTukCbbcnC8Hju+Wa3O2LtLbQTk/1/ti6pZ+3ata/gN14D8ikVzCNjq7ZcWV1w==
X-Received: by 2002:a05:600c:4f49:b0:3cf:82b9:2fb7 with SMTP id m9-20020a05600c4f4900b003cf82b92fb7mr1666708wmq.198.1667336453797;
        Tue, 01 Nov 2022 14:00:53 -0700 (PDT)
Received: from localhost.localdomain ([117.102.63.160])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4443000000b0023659925b2asm11003643wrr.51.2022.11.01.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:00:53 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_keypc: specifying the default driver parameters among the module params
Date:   Wed,  2 Nov 2022 02:00:46 +0500
Message-Id: <20221101210046.10357-1-osmtendev@gmail.com>
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

Adding default variables to the speakup_keypc module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>


---
 drivers/accessibility/speakup/speakup_keypc.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
index f61b62f1ea4d..9356f6379560 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -33,12 +33,21 @@ static int synth_port;
 static int port_forced;
 static unsigned int synth_portlist[] = { 0x2a8, 0 };
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"[f130]" } },
-	{ CAPS_STOP, .u.s = {"[f90]" } },
-	{ RATE, .u.n = {"\04%c ", 8, 0, 10, 81, -8, NULL } },
-	{ PITCH, .u.n = {"[f%d]", 5, 0, 9, 40, 10, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"[f130]" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"[f90]" } },
+	[RATE_ID] = { RATE, .u.n = {"\04%c ", 8, 0, 10, 81, -8, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"[f%d]", 5, 0, 9, 40, 10, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -305,9 +314,17 @@ static void keynote_release(struct spk_synth *synth)
 
 module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_keypc.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
+
 
 module_spk_synth(synth_keypc);
 
-- 
2.25.1

