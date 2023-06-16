Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D18732B67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbjFPJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjFPJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE02721;
        Fri, 16 Jun 2023 02:24:43 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFSswFXiuu0vGfs6BkcKLUDC8xMz27HYjzqc9iSnG6U=;
        b=OcLJIX6f4lV5GbH6kAswqnI2Xy0yfaL3EVy2C2vufRKaHWvGb1EVxSOGW079v9JptAmwEu
        e8rAuCV7wFcdM4xznfeMN0dIhbyH9W4UkyGZNyLjXWVDMaC4BhZ1WsxE/qlYEr8xxUZUpj
        ivjYG1ci+e73BUrv7kjl1dpgSUg/vFrTAIT4F7qKs92VU6gibvr3Qz07iFZGax9+pMl9xP
        eQ4r3Ml6m9RUPx5izNA3VGCVrndvvfYKA9ZSgJOHeKfGGvMqxtff7dQ741SiynhOthdirv
        4ZnS1MlnN//+BwNIrIP+KCNiT6QfLkPZnRvsBvXGh5GgXSPdwZOLjj/0lk57fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFSswFXiuu0vGfs6BkcKLUDC8xMz27HYjzqc9iSnG6U=;
        b=jhN839nR80oGsiGUPUBM+8VLcaU4mDRG9FFjMH6qOY7gfjcBYkBAwyjaSVOjZeshcl3FeH
        enSO41i3mFX5IsCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/fpu: Mark init functions __init
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.841685728@linutronix.de>
References: <20230613224545.841685728@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748184.404.1323317801212302376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     1703db2b90c91b2eb2d699519fc505fe431dde0e
Gitweb:        https://git.kernel.org/tip/1703db2b90c91b2eb2d699519fc505fe431dde0e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:01 +02:00

x86/fpu: Mark init functions __init

No point in keeping them around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.841685728@linutronix.de

---
 arch/x86/kernel/fpu/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 5001df9..998a08f 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -53,7 +53,7 @@ void fpu__init_cpu(void)
 	fpu__init_cpu_xstate();
 }
 
-static bool fpu__probe_without_cpuid(void)
+static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
 	u16 fsw, fcw;
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(void)
+static void __init fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
