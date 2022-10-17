Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C676011DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJQOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiJQOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E469195;
        Mon, 17 Oct 2022 07:54:00 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoqosqZjO+xl23346bpYRdsj69+EyaQCFU3cT7aqMzI=;
        b=kQ1BEjza5Qj40dsNSlpysvup91h7jeyhUFyfdrD6R3kG4aMYyMKO8oX9ge5yIIhcmFOEQd
        9o+7qn4OvMsK22ArQNsPAVcmtBVxaz9GRnXUShb+nx/CqUS64SJy8Gw1NRR61joaG8isqg
        93X3TXESuUh9M8JKz03A/+gEncaISEfwIWv6a8JBeNkOgqUBChgd52LL5AU7ZZs7ebgYs1
        YtcghplUcBd0ksXauUoRSk05wSBu1l5nM4bTi1jP+TiPhXX9MyWElaaFIckDvPRCvbe/Tx
        pxqZrTEoranbS8wnwmpoywUwbb3NMwQOYv0yO8P0htpalinoHGuCxW88w3OrFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoqosqZjO+xl23346bpYRdsj69+EyaQCFU3cT7aqMzI=;
        b=XvZEbAvt1DWDagUXpayq6u5VxwpTbGndW2iWO6fyIqi8w+q0yO+YomUCDBDHxygD65VfGx
        cmT098uGZlwDbkDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/putuser: Provide room for padding
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.746429822@infradead.org>
References: <20220915111146.746429822@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843256.401.5392178087541775099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     cb855971d717a2dd752241f66fedad9dc178388c
Gitweb:        https://git.kernel.org/tip/cb855971d717a2dd752241f66fedad9dc178388c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:10 +02:00

x86/putuser: Provide room for padding

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.746429822@infradead.org
---
 arch/x86/lib/putuser.S | 62 ++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index b7dfd60..3212522 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -47,8 +47,6 @@ SYM_FUNC_START(__put_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -56,54 +54,87 @@ SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
 	RET
 SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
+
+SYM_FUNC_START(__put_user_nocheck_1)
+	ENDBR
+	ASM_STAC
+2:	movb %al,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-2:	movw %ax,(%_ASM_CX)
+3:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
+
+SYM_FUNC_START(__put_user_nocheck_2)
+	ENDBR
+	ASM_STAC
+4:	movw %ax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-3:	movl %eax,(%_ASM_CX)
+5:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
+
+SYM_FUNC_START(__put_user_nocheck_4)
+	ENDBR
+	ASM_STAC
+6:	movl %eax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-4:	mov %_ASM_AX,(%_ASM_CX)
+7:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
-5:	movl %edx,4(%_ASM_CX)
+8:	movl %edx,4(%_ASM_CX)
 #endif
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
+
+SYM_FUNC_START(__put_user_nocheck_8)
+	ENDBR
+	ASM_STAC
+9:	mov %_ASM_AX,(%_ASM_CX)
+#ifdef CONFIG_X86_32
+10:	movl %edx,4(%_ASM_CX)
+#endif
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
@@ -117,6 +148,11 @@ SYM_CODE_END(.Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
-#ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(6b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(7b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(9b, .Lbad_put_user_clac)
+#ifdef CONFIG_X86_32
+	_ASM_EXTABLE_UA(8b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(10b, .Lbad_put_user_clac)
 #endif
