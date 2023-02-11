Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC31692FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBKKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBKKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:01:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E52469B;
        Sat, 11 Feb 2023 02:01:46 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:01:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676109705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR9ujm7zNKdJxea3s1Y/v1qrUaqWAPS44icY3xx8NFg=;
        b=UwIFssFNf4DGjuuLI+qdZy9VxH1D9WeWQuCWRvimuCewlLkAn1MYrvaX0zivUUKCZiSLnn
        If3fJXjEsNQkqJgwnPBbO3tVR56LC9xL+s74u0asgXeBg4J29UU0IPpZCDcBzdOVqKHEoY
        w4fnBtAdVAkRllEbW5kScl8vZCDVwglNdvTRz2uioE9Ei+3AFaHWbJbqAHsvToU0p2AzUZ
        obAlY3hGuIPGThAYKAcWe5pY59tiXe8bfAhyCpQ1CZqEtsxLcHKICg9UVxJ+g2/QENnGLv
        cZsOevKXCcJX065x89oB0oNpA9pG2CA++DiUD/igR9G9Tm8j6jvAR/yBsowzRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676109705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR9ujm7zNKdJxea3s1Y/v1qrUaqWAPS44icY3xx8NFg=;
        b=SkezBbYycLXhfvqUcZx/gLCoq59Q91Re1XhFqD+hMAfwpz7mYBIBBjz1nlXni0l6Q/162p
        an8o/jSm3nf55MAQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/tsc: Make recalibrate_cpu_khz() export GPL only
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y599miBzWRAuOwhg@zn.tnic>
References: <Y599miBzWRAuOwhg@zn.tnic>
MIME-Version: 1.0
Message-ID: <167610970464.4906.11378766589125986180.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8fe6d84947582e2c076abc6253b80709fb047935
Gitweb:        https://git.kernel.org/tip/8fe6d84947582e2c076abc6253b80709fb047935
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 18 Dec 2022 21:52:42 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 11 Feb 2023 10:44:07 +01:00

x86/tsc: Make recalibrate_cpu_khz() export GPL only

A quick search doesn't reveal any use outside of the kernel - which
would be questionable to begin with anyway - so make the export GPL
only.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/Y599miBzWRAuOwhg@zn.tnic
---
 arch/x86/kernel/tsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73d..eaeffef 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -912,8 +912,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-
-EXPORT_SYMBOL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
 
 static unsigned long long cyc2ns_suspend;
