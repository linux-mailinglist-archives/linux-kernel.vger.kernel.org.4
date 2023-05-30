Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D331716C61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjE3S0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjE3S0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:26:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0771E6E;
        Tue, 30 May 2023 11:26:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so172876a12.1;
        Tue, 30 May 2023 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685471164; x=1688063164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TX09eRyh2V+06r3hdUijrkXGuVotskNATb8x3BsCrEE=;
        b=IKndNRiDwsk+JGNXGyumbxCDA2GulAj+EENcOSPQ4kPsL46ECzdaQ2sGGHJQfLU26v
         hxGY1ZY82KKJ5yXP9ikkwiowF4E+9gtYyNvFoD+YmZjJCSXLLKTJA7sJ+xvUYdxaHrRe
         uL1vQHDMaciJYX3Sveuc0aGJ4UwYH5+/kjhOE2O9JnVddmOs3ta1SEWy3gt7XQlsYnJm
         oV4snD+SVNBidEP7ORI4k0468ZGjx5L7V4b7uFHkKE61I+cM+tV65b5La7sESW1KIN7S
         pfeOShULPeJ0lwEEvQdKCvS+YLZuePvgL0LKDXJ/G6zCj1Pp4IEhE6dqOG4woX+3w2X3
         pDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471164; x=1688063164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX09eRyh2V+06r3hdUijrkXGuVotskNATb8x3BsCrEE=;
        b=bmg06+tgKLBPgjDUg8meZDSgugQMlrF7iYkfrlHk95FQZfgJ2fAnxSMz6ucBHmrUVX
         AJZ7/oINzF//R+MYzsQxJ3tgjPZ3e3CpVBrTG6hYlbPKc61uipN2D1iCK7NzkAofj6LL
         jtIjlO6+5sbEp1G8Pv/vAecm56CHsfyuZwEhiNYWFt2VrCQO8M4tqZ5Wt4S7yMvP/0ji
         AgUsbvCK7+rCWVLYgFj0Wf/USd3uCbv/wmtIehdabEFQGkbyDVMoDwQQld+DaSn1XBKk
         57IgFBs0SgQhoTN1d/7bK0AuuEd0ISJ/ZwxBQdvRnn/mOYN1xNXgDS/KzXh8bIayLLUg
         okCw==
X-Gm-Message-State: AC+VfDxDKTMcsJgpGGLvdMKAlAHkcsPNcGuzmsWf0TG4+AqdB8V71NWg
        /bpyvtGXYNsqWFfS/PwRqgBXSvcjMV8Tog==
X-Google-Smtp-Source: ACHHUZ53500ev8GHZXPQuqo45ZHNBtwysiLuApCXe72ZTfTN7orNRiM9EmqwIPnKQFVWL+uAuWULuw==
X-Received: by 2002:a17:907:9448:b0:958:46aa:7f99 with SMTP id dl8-20020a170907944800b0095846aa7f99mr9517494ejc.7.1685471164030;
        Tue, 30 May 2023 11:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:d56e:8fdf:f926:4676])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709065e4d00b00965e9b435dfsm7623642eju.65.2023.05.30.11.26.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 May 2023 11:26:03 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] ARM: omap: Fix checkpatch issues
Date:   Tue, 30 May 2023 20:24:03 +0200
Message-Id: <20230530182403.35646-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the following checkpatch issues:
- ERROR: space required after that ',' (ctx:VxV)
- WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 arch/arm/mach-omap1/sram-init.c | 2 +-
 arch/arm/mach-omap2/sram.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/sram-init.c b/arch/arm/mach-omap1/sram-init.c
index 26427d6be896..4cd4b50130ba 100644
--- a/arch/arm/mach-omap1/sram-init.c
+++ b/arch/arm/mach-omap1/sram-init.c
@@ -23,7 +23,7 @@
 
 #define OMAP1_SRAM_PA		0x20000000
 #define SRAM_BOOTLOADER_SZ	0x80
-#define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
+#define ROUND_DOWN(value, boundary)	((value) & (~((boundary)-1)))
 
 static void __iomem *omap_sram_base;
 static unsigned long omap_sram_start;
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 815d390109d2..e4c012ac4d28 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -45,7 +45,7 @@
 
 #define GP_DEVICE		0x300
 
-#define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
+#define ROUND_DOWN(value, boundary)	((value) & (~((boundary)-1)))
 
 static unsigned long omap_sram_start;
 static unsigned long omap_sram_size;
@@ -118,7 +118,7 @@ static void omap_sram_reset(void)
  */
 static int is_sram_locked(void)
 {
-	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
 			writel_relaxed(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.39.2 (Apple Git-143)

