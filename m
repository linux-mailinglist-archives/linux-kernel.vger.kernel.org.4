Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1657562B1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiKPDNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiKPDNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:13:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C35558C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso999740pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Sgd0SU9M6CpUSRStE6vDvg0DHGGT+ouTzN5zX360k=;
        b=VTO9vgT1yrzsJADrFjmgJ4aWs7BsToOlX6QncvEKYLRiPbZhj8sofO7hmRAk0oUrRf
         2vqV5Mswfo4RuSSDJF0/BkDa8XQRSkJMC8FD8MDHCEYJ3ARtS80HGXCV/muWsOdhun4e
         MGsssEUchdtMGlBuXuqs2tehTCSTe1cUMAUlx8tc9/GogzDFnpg6Hb4FhV7hYgTWKhHo
         hPYxsmIEEkkAy9U5JpgIPqdvW99PACkslIpQRIGpLbiWYuIPbdSyXgCSP+y0/62tkLoM
         ZNAN8fqgb7+K66faIPouDFhakBmauX+nIErtYD1rInl5AYIt0oIITw3Ch98e1ddWM4Zn
         E97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3Sgd0SU9M6CpUSRStE6vDvg0DHGGT+ouTzN5zX360k=;
        b=FK7YSY8ZIKL6SLAXBZeozwXUXxs0xOIuBJyuvnw7I3L5f9qNosK5WF/85v4NfHKllL
         nbVNyotsVQRPnPyB7hOQSIYjzs1lBXZnvz48g2eGVXVQfsUOJ94FrThLPp0GX930Jb8C
         oD8ZuFTIT3hc+805NNIwDON5bUD6vHEBcaHM41J5AuJmLouecuU7DcIiFr1qFBurtD+0
         eS+J0FfofI/Lft1rcqCxBqA4lGJJgQQPMM8e/RJMbBlPureHBZZHVscY5ysP1UGCqRQW
         6W2cBtJUOHk6y6JRY5iaJdHSnlCIRvQMeFvINCyFoPguPaQY65DR7BE64m+harn8syaa
         H5xQ==
X-Gm-Message-State: ANoB5ploOdwEVRp/8+ngTMkPC67w5+9OShb4KtGzC08LYyj8EQU3YiX9
        eLyZwc/yUaj93m/q35992a0=
X-Google-Smtp-Source: AA0mqf7DAddMbl6lNwlouxjPbc9Yzv+yAJB85SvbuH0IfnUEMgYD0xRah8ylORRHkUq1BiJTmo06dg==
X-Received: by 2002:a17:90a:5990:b0:20a:68f5:a986 with SMTP id l16-20020a17090a599000b0020a68f5a986mr1525717pji.166.1668568414049;
        Tue, 15 Nov 2022 19:13:34 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b0020b2082e0acsm348295pjb.0.2022.11.15.19.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:13:33 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v2 2/3] riscv/ftrace: SAVE_ALL supports lightweight save
Date:   Wed, 16 Nov 2022 11:13:04 +0800
Message-Id: <20221116031305.286634-3-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116031305.286634-1-suagrfillet@gmail.com>
References: <20221116031305.286634-1-suagrfillet@gmail.com>
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

In order to make the function graph use ftrace directly, ftrace_caller
should be adjusted to save the necessary regs against the pt_regs layout
so it can call ftrace_graph_func reasonably.

SAVE_ALL now saves all the regs according to the pt_regs struct. Here
introduces a lightweight option for SAVE_ALL to save only the necessary
regs for ftrace_caller.

For convenience, the original argument setup for the tracing function in
ftrace_[regs]_caller is killed and appended to the tail of SAVE_ALL.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/mcount-dyn.S | 110 +++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index d171eca623b6..2f0a280bd7a0 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -56,7 +56,51 @@
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	.macro SAVE_ALL
+
+/**
+* SAVE_ALL - save regs against the pt_regs struct
+*
+* @all: tell if saving all the regs
+*
+* If all is set, all the regs will be saved, otherwise only ABI
+* related regs (a0-a7,epc,ra and optional s0) will be saved.
+*
+* For convenience the argument setup for tracing function is appended here.
+* Especially $sp is passed as the 4th argument of the tracing function.
+*
+* After the stack is established,
+*
+* 0(sp) stores the PC of the traced function which can be accessed
+* by &(fregs)->regs->epc in tracing function. Note that the real
+* function entry address should be computed with -FENTRY_RA_OFFSET.
+*
+* 8(sp) stores the function return address (i.e. parent IP) that
+* can be accessed by &(fregs)->regs->ra in tracing function.
+*
+* The other regs are saved at the respective localtion and accessed
+* by the respective pt_regs member.
+*
+* Here is the layout of stack for your reference.
+*
+*
+*			=========
+*			|  pip  |
+* PT_SIZE_ON_STACK  ->  =========
+*			+ ..... +
+*			+ t3-t6 +
+*			+ s2-s11+
+*			+ a0-a7 + --++++-> ftrace_caller saved
+*			+ s1    +   +
+*			+ s0    + --+
+*			+ t0-t2 +   +
+*			+ tp    +   +
+*			+ gp    +   +
+*			+ sp    +   +
+*			+ ra    + --+ // parent IP
+*		sp  ->  + epc   + --+ // PC of the traced function
+*			+++++++++
+**/
+	.macro SAVE_ALL, all=0
 	addi	sp, sp, -SZREG
 	addi	sp, sp, -PT_SIZE_ON_STACK
 
@@ -67,14 +111,8 @@
 	REG_S x1,  PT_RA(sp)
 	REG_L x1,  PT_EPC(sp)
 
-	REG_S x2,  PT_SP(sp)
-	REG_S x3,  PT_GP(sp)
-	REG_S x4,  PT_TP(sp)
-	REG_S x5,  PT_T0(sp)
-	REG_S x6,  PT_T1(sp)
-	REG_S x7,  PT_T2(sp)
-	REG_S x8,  PT_S0(sp)
-	REG_S x9,  PT_S1(sp)
+	/* always save the ABI regs */
+
 	REG_S x10, PT_A0(sp)
 	REG_S x11, PT_A1(sp)
 	REG_S x12, PT_A2(sp)
@@ -83,6 +121,18 @@
 	REG_S x15, PT_A5(sp)
 	REG_S x16, PT_A6(sp)
 	REG_S x17, PT_A7(sp)
+
+	/* save leftover regs for ftrace_regs_caller*/
+
+	.if \all == 1
+	REG_S x2,  PT_SP(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x4,  PT_TP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
 	REG_S x18, PT_S2(sp)
 	REG_S x19, PT_S3(sp)
 	REG_S x20, PT_S4(sp)
@@ -97,22 +147,31 @@
 	REG_S x29, PT_T4(sp)
 	REG_S x30, PT_T5(sp)
 	REG_S x31, PT_T6(sp)
+	.else
+
+	/* save s0 for ftrace_caller if FP_TEST defined */
+
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_S x8,  PT_S0(sp)
+#endif
+	.endif
+
+	/* setup 4 args for tracing functions  */
+
+	addi	a0, ra, -FENTRY_RA_OFFSET // ip
+	la	a1, function_trace_op
+	REG_L	a2, 0(a1)		// op
+	REG_L	a1, PT_SIZE_ON_STACK(sp) // parent_ip
+	mv	a3, sp			// fregs
 	.endm
 
-	.macro RESTORE_ALL
+	.macro RESTORE_ALL, all=0
 	REG_L x1,  PT_RA(sp)
 	addi	sp, sp, PT_SIZE_ON_STACK
 	REG_S x1,  (sp)
 	addi	sp, sp, -PT_SIZE_ON_STACK
 	REG_L x1,  PT_EPC(sp)
-	REG_L x2,  PT_SP(sp)
-	REG_L x3,  PT_GP(sp)
-	REG_L x4,  PT_TP(sp)
-	REG_L x5,  PT_T0(sp)
-	REG_L x6,  PT_T1(sp)
-	REG_L x7,  PT_T2(sp)
-	REG_L x8,  PT_S0(sp)
-	REG_L x9,  PT_S1(sp)
+
 	REG_L x10, PT_A0(sp)
 	REG_L x11, PT_A1(sp)
 	REG_L x12, PT_A2(sp)
@@ -121,6 +180,16 @@
 	REG_L x15, PT_A5(sp)
 	REG_L x16, PT_A6(sp)
 	REG_L x17, PT_A7(sp)
+
+	.if \all == 1
+	REG_L x2,  PT_SP(sp)
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
 	REG_L x18, PT_S2(sp)
 	REG_L x19, PT_S3(sp)
 	REG_L x20, PT_S4(sp)
@@ -136,6 +205,11 @@
 	REG_L x30, PT_T5(sp)
 	REG_L x31, PT_T6(sp)
 
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_L x8,  PT_S0(sp)
+#endif
+	.endif
 	addi	sp, sp, PT_SIZE_ON_STACK
 	addi	sp, sp, SZREG
 	.endm
-- 
2.20.1

