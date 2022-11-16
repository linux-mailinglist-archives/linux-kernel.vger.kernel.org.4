Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457AF62B1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiKPDNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiKPDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:13:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B915FD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so15426341pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpY9sowzoB4bTfPMOQKq0rrOfNHmYsG5EEqVDAlGCR8=;
        b=Fkp7RqRXzLca9GRGFqbpy0Ixb78LnV5vSgMDr9Nx1mkvb3FkxSH54azGidRQ9j39Ci
         m1vgt9Y4jUAf5h5HKEYTpNcNgnE+RJ/KOYkY3a+Qe8UKzyjB4ACCDOAHULHz4KD26uFJ
         x4jqjovF5KgqyLe2gE8G7PeB2QByNgMtevktMBqHz7G63ktcpXABfLYc+fbKdTYw4xi+
         XVGRdnAFXBeU39ClDL2wu5dkPvN/DqcbfAs6k9Z1cjJhKVsVczgY+nTCwbJ6GqNr/ctp
         w/Q6Yiyjta2nCU8gYeYP9GAW7IS5ScwGPYgRIQCFkDwPaaGm6ZaaE2W5f/cEgJlp5DhO
         c3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpY9sowzoB4bTfPMOQKq0rrOfNHmYsG5EEqVDAlGCR8=;
        b=P+8Yp+W1oV9ml+IozONsbGyT97fDXdouE2VPduc6HFjCAUbMVhdLpKO7zYgdr19ksM
         KRReHBwNYFS50SLqePsHZye5HDXufvXyGBPVpxRx03je6nDdth/e0DbJ53SyQ9HYH0DK
         Mxr3DhreTpwzSj28W/qS6viBgiZpJBFmxPP+yP2ScdKsvf5PeFsv7Q8SXGuyuFDCbp6N
         3vUOReHD7LvMDnIlhKQzc7vBEWVWof6YXb8XTJwiYqUolBJSrQx3JkmhRT53YnbLsMBA
         xFhna/BY9hHNFKAF3POutwaT/11LPqVg+YpijGVB9mH2Z0wT2SUgbvGW/nJfWK+oODRv
         OPWw==
X-Gm-Message-State: ANoB5pkqac2pK7qk5R17SG8En8IsUpCK0tHudjmxT32lxv2Y2aPfxX86
        LDpf7LREoM1tWYy40XM4g1U=
X-Google-Smtp-Source: AA0mqf6u+hR/uvV6gQ5bgFGDZl4J+cU6RpPb2zAzKAt/7REEHZZRR9j6Eqpp6zyI3vI+flRPpxwN5A==
X-Received: by 2002:a63:5465:0:b0:470:8e8d:44ae with SMTP id e37-20020a635465000000b004708e8d44aemr18164459pgm.382.1668568417139;
        Tue, 15 Nov 2022 19:13:37 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b0020b2082e0acsm348295pjb.0.2022.11.15.19.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:13:36 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v2 3/3] riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller
Date:   Wed, 16 Nov 2022 11:13:05 +0800
Message-Id: <20221116031305.286634-4-suagrfillet@gmail.com>
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

ftrace_caller and ftrace_regs_caller save their regs with the respective
option of SAVE_ALL, then call the tracing function, especially graph_ops's
ftrace_graph_func. So the ftrace_graph_[regs]_call labels aren't needed
anymore if FTRACE_WITH_REGS is defined.

If FTRACE_WITH_REGS isn't defined, the !FTRACE_WITH_REGS version
ftrace_caller remains with the ftrace_graph_call. So the enable/disable
helpers are revised for serving only this ftrace_graph_call.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/ftrace.c     | 19 ++----------------
 arch/riscv/kernel/mcount-dyn.S | 35 +++++++++++++++-------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 148a5480076b..2f0bcedc6a2d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -211,30 +211,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 extern void ftrace_graph_call(void);
-extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false);
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 2f0a280bd7a0..9e4097c6793d 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -215,6 +215,7 @@
 	.endm
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 ENTRY(ftrace_caller)
 	SAVE_ABI
 
@@ -243,33 +244,27 @@ ftrace_graph_call:
 	ret
 ENDPROC(ftrace_caller)
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 ENTRY(ftrace_regs_caller)
-	SAVE_ALL
-
-	addi	a0, ra, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	REG_L	a1, PT_SIZE_ON_STACK(sp)
-	mv	a3, sp
+	SAVE_ALL 1
 
 ftrace_regs_call:
 	.global ftrace_regs_call
 	call	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, PT_RA
-	REG_L	a1, PT_EPC(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-ftrace_graph_regs_call:
-	.global ftrace_graph_regs_call
-	call	ftrace_stub
-#endif
 
-	RESTORE_ALL
+	RESTORE_ALL 1
 	ret
 ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	SAVE_ALL 0
+
+ftrace_call:
+	.global ftrace_call
+	call	ftrace_stub
+
+	RESTORE_ALL 0
+	ret
+ENDPROC(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.20.1

