Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC96B5266
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjCJU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCJUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4B13F199;
        Fri, 10 Mar 2023 12:54:58 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1VvxZpwtBZTa1o68luqRRgfyBFKOiBq5iMCKfCS8xI=;
        b=So253icaWI9n2ajbxAD69ZDwsgL4OPwGqGiINM1pOIb368BCkRYqtJh3ISxGjIMzLbvvij
        XvDhng30Z1bfDSZ69aZGmuHZaPQOyYJPwbJMF/t6O8lVDWRB23TR+tJgrT9szp16XbJI7O
        3zRcxLLxPKFasE/SUZC59K08CTJHQ/JBJRweMC6gOFEupo8ESB3Cz9wuO2AqKSysmk9CQt
        3owd1nie9aKf8TKWPZO0OUjvprGPmBhgBgf1eGuoLwV8d/DIoFPczeaZlMn4a6CCSSkX/J
        YmjqDPj1nLDCpa/iZGMrmjHlGqF3q1F6UxC7A2C0rfEMLYC2n0g4ksSELCNuHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1VvxZpwtBZTa1o68luqRRgfyBFKOiBq5iMCKfCS8xI=;
        b=1DXUQ2al7lSV0Xo8vJnXnn+KStESF7dAcFDK3/lT+JBgo7fNtwVGXMJxcjADJhJjuo58Xy
        OsFj2h/HvOi7vPAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] alpha/cpu: Expose arch_cpu_idle_dead()'s
 prototype declaration
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b0405c2ac5686303b6026e1ac27cfd769b21a7d0.1676358308.git.jpoimboe@kernel.org>
References: <b0405c2ac5686303b6026e1ac27cfd769b21a7d0.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169629.5837.7114279498237210381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1e8a0be5ed3aaa26dd77927df32bbd0df3449a1e
Gitweb:        https://git.kernel.org/tip/1e8a0be5ed3aaa26dd77927df32bbd0df3449a1e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:35 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:03 -08:00

alpha/cpu: Expose arch_cpu_idle_dead()'s prototype declaration

Include <linux/cpu.h> to make sure arch_cpu_idle_dead() matches its
prototype going forward.

Link: https://lore.kernel.org/r/b0405c2ac5686303b6026e1ac27cfd769b21a7d0.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/alpha/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index e9cf719..3251102 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -9,6 +9,7 @@
  * This file handles the architecture-dependent parts of process handling.
  */
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/sched.h>
