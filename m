Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6097660C83
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjAGFPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 00:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAGFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 00:15:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712361322
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:15:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so3015407wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 21:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0akaezmMiUg9uY87rK2hSkPM/8hryZ13zAkpajBo1g=;
        b=Jsx96CNq8CWFQsfh1mk6L2VZrfLDChqOWew/XF9THQ47cIcO8aZGNiJ2LaALuNJ3pp
         PQbx4LbNHLtGeAbsjXDtYPXmLiZBLKbTugjm99XsrorC57HoV3GjqTTW4OKtiiVRGcnp
         nH4DbTN/Z8FgeTz+lFaVuL+LbG1a02NHXb1HDeuMjG9kg1biY7Q3DoZQ5ftqpeEAYcJE
         202Of0E/Hr+bKZjZZbohKT5iyrAr6tZjZ+r7GP1tsWDZC5l4sKqo3EllqSvVlZiQneqC
         OrgjY42TXPDI/B21RW4wKLqGSI6jugMo3bkZv57420GNOC0MCBo+lSuroGv2oV88VbPi
         XEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0akaezmMiUg9uY87rK2hSkPM/8hryZ13zAkpajBo1g=;
        b=VKMX76XoPTM0jLOIm/6Q9FvaVpn55FYakCelDlFf2eMHa6L+Zr8GPkW6gDNzfVM9pZ
         mxofrMTYL0YY0lInZy8kvo30eRUIA4KaxmNiLlwQwWaFB2Kr+U6C5F6xguvLN2G2xBB8
         6X6E8Hlt/aA7z8ZMIsfeJ/c4qu8XCSqLiWl7vpE1xSs4ugKb61oHjNYFvUX2DSK3kcqJ
         Qn8lFBepwIzjW0GlmKIo2xtex6fLh9QmRllxxoqAuCwow47fMesXhHouIUaVnyncY99Z
         JGL+Ncb4c0UUNw3ZkqWh6mWwInWEVaXI/JQ83ZJFfKZegOMV8RKdYHiAYHCcFEVjc0D7
         hqoA==
X-Gm-Message-State: AFqh2kpE5jgPOeImkjyQIl/ag6eLlHei9vKKR90SGGjJWjTSEHfF9zdp
        aIm6qlXl/srkrTeQCdUW7cU=
X-Google-Smtp-Source: AMrXdXs2hjyhaoHdEhqvCUsNIuglVdiiqEQ5QRWtMpKOWk7lS+qhv6ujLYPxx5Do9xrJvV7/ktzTQA==
X-Received: by 2002:a5d:4591:0:b0:2b4:790e:32f8 with SMTP id p17-20020a5d4591000000b002b4790e32f8mr3901075wrq.48.1673068499705;
        Fri, 06 Jan 2023 21:14:59 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm3354017wrs.0.2023.01.06.21.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 21:14:59 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Joan Bruguera" <joanbrugueram@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf, x86: Fix IP after emitting call depth accounting
Date:   Sat,  7 Jan 2023 05:14:56 +0000
Message-Id: <20230107051456.8800-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Adjust the IP passed to `emit_patch` so it calculates the correct offset
for the CALL instruction if `x86_call_depth_emit_accounting` emits code.
Otherwise we will skip some instructions and most likely crash.

Fixes: b2e9dfe54be4 ("x86/bpf: Emit call depth accounting if required")
Link: https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmail.com/
Signed-off-by: Joan Bruguera <joanbrugueram@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b808be77635e..6e696c6b7018 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -343,9 +343,10 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
+	void *adjusted_ip;
 	OPTIMIZER_HIDE_VAR(func);
-	x86_call_depth_emit_accounting(pprog, func);
-	return emit_patch(pprog, func, ip, 0xE8);
+	adjusted_ip = (u8 *)ip + x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, adjusted_ip, 0xE8);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
-- 
2.39.0

