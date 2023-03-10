Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F46B5251
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjCJUzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCJUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C85108691;
        Fri, 10 Mar 2023 12:54:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2Y9RxpuuR3/TuVvOB4UUTt1nORk/1F7aC4FkTe/JGk=;
        b=F2qicGXxwT2VdiAc1ToRnqy0PJWSdhYwQarGlX7ji3eoeG9WHJsKHSyDVxWW/u3ooXVGtm
        k5gG+7jevisgyZO/Jg1cBDZJTY8BVJePEipRLZOHibjZnib5oAwD15kiegpozJNbxtH+/K
        b3qJGs0gHVoFMRSMeseoe8sg/30z1D0nGRZ4IxbZfuB7f4Kls5oUmWTDDWpSgT/NGS4KMY
        2fRlNnStqLAMdSQ8Cw2BhXRGh0l7gH1/6OWhxQTTPU1UzXOf/Sob4AwOsC2KQhvlrGs4Oi
        LwK5r3i1hsO8UGBTBRe+xgV0qF8jPbnffu+y3JDj8E6f22kowXe2XmrYKEB0zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2Y9RxpuuR3/TuVvOB4UUTt1nORk/1F7aC4FkTe/JGk=;
        b=Lh/915aL3Gd+k1hjQVv+b6YehVEW+ZfgJjJytt/mRsNOdUMP6HmkeXbdDkaU9lyjJ2Cw7A
        qDN+Ga/UYncVK2Aw==
From:   tip-bot2 for Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/cpu: Expose arch_cpu_idle_dead()'s prototype
 definition
Cc:     philmd@linaro.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230214083857.50163-1-philmd@linaro.org>
References: <20230214083857.50163-1-philmd@linaro.org>
MIME-Version: 1.0
Message-ID: <167848168668.5837.7959819503933981151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b4c108d7daf1039cf19388baff30a94563de3f3e
Gitweb:        https://git.kernel.org/tip/b4c108d7daf1039cf19388baff30a94563d=
e3f3e
Author:        Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
AuthorDate:    Tue, 14 Feb 2023 09:38:57 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:30 -08:00

x86/cpu: Expose arch_cpu_idle_dead()'s prototype definition

Include <linux/cpu.h> to make sure arch_cpu_idle_dead() matches its
prototype going forward.

Inspired-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lore.kernel.org/r/20230214083857.50163-1-philmd@linaro.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3e30147..d9ecaa6 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/prctl.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
