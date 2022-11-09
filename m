Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74646623621
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKIVwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiKIVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:28 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6131EC9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o30so25755wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyPGedY3Et+99+MoSUVtsR7MJ8v6BaFKXsa07SnlUIM=;
        b=ZQZwLGL5pXO/AnK3wN8zrR9n89d5jFQgI4erStFmIDKfugQ/snADwEZDhFuA861bnR
         K89YVf9HcSRVhNBJH9zUK1m613gjTWSmSbNzP2dXGTaedCHVX8itHbH8+WsXDYNVB30F
         DiAsaC3aZXBeqJ8iefZPiXlffy5mDqCJUSwJbkusdseKCxyAiqBo86tDR4OSE/8r41Nv
         Q3MtMh2xq8xQabociae6Wgl9BI39w0pE8LZC52W6s4K0oupDrZqCGx1Ixdc8/mJt+q8D
         WIE2z5J0T45/NWgJoomjAnhtdGdeQ6VLbxNexV/+MQAtbaOLtHS4nAVFuhqUtJcENPM8
         4JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyPGedY3Et+99+MoSUVtsR7MJ8v6BaFKXsa07SnlUIM=;
        b=KizNQtDUMtsEbB3MygU4vW6ahbw6mrPEbgPk9YvNm9M/mVffhwUwasyxbxmWbArQjY
         OELMVJ+jR/A0xDH3RmS05C8fbmOJWSLh2VocZpiHGsQb9AVuhpbgy1LupQ4ZhN5YGslx
         /V82UFR1EAD3RyQIP4TfD6SfqsBHgWypwWUHdxYAFRx9LFSWSgWuWKLEcK84cmWlxe6l
         w7q709UvjJwHFoFcEe1O1AWV/kI6Z6a9lLpOXfrQfpgDoJDAolw5mY1MRtgrVyOG1lXy
         cUftd1IPAHLwwaHJZGuAQ0Brc4piqOd1NbcZI9smKNbtaABiPFU5/5X21ptsu4RDeGph
         R/yg==
X-Gm-Message-State: ACrzQf3mxhpxEAwdj20SpTA0YlsZpmrhH7mz4wT5mgirpjjq6I69KQgQ
        Rul+Jwm94869TMH7Ezxpeq0trCEohjY=
X-Google-Smtp-Source: AMsMyM7ZvXgbsqpLMIeMAKy6HVB4fcGqD2XtevYX2/4cLEOlYMMjj0iRpBT5C4cS3mloGhz2pGjYbw==
X-Received: by 2002:a05:600c:3587:b0:3cf:9aab:ab4a with SMTP id p7-20020a05600c358700b003cf9aabab4amr19724257wmq.155.1668030727767;
        Wed, 09 Nov 2022 13:52:07 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:07 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 10/15] Accessiblity: speakup_keypc: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:03 +0500
Message-Id: <20221109215108.7933-11-osmtendev@gmail.com>
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

