Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3867B1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjAYLjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjAYLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:39:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE66A4B;
        Wed, 25 Jan 2023 03:39:12 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:39:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674646749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fofvn1ee1G4NNgw9bxVzFaQH030mEGN5Kw1WXXUCOQg=;
        b=0GcR8lz2jteTZaWg+Y6y2K1tOnj7IjeRD0LMYxXvoDY0UdaBbcM0FOE9EHs1mHjA5P81tQ
        pOcLg+Jo6SK/Hm3D8gdeu5Uu3G2NdMYXY6YzapAd4U8R+tTylHLY8oqhRGXpfjhxLh6SUV
        QceJQOywJ+2lKHCsmrGOn42qEU1+DdvVVaDAjV7Q5sZhA+eQfUM+3GVoi33Yu4cXVgAhc+
        3Q/hj+YhKkSWvuc7U+PwSXrVMk0RXtf71ibUzsf8E9i01Q89sv5WNmuZWdFNIhX3XXp8Df
        8rYM3YOL7PrMXeCXflRCPy3NNJDQpXQ6f6YHytULb4R+mjjsySDhjdbOB4In+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674646749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fofvn1ee1G4NNgw9bxVzFaQH030mEGN5Kw1WXXUCOQg=;
        b=um1bwEiL/7cxpFd1RUHQKh4BP2Ak9uYFr9mXjZ6jUsdokdkm1QhmTURbFRYCiDL9sK/jSb
        5xWZ+cOxjCWKwqBg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Fix spellos & punctuation
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124181753.19309-1-rdunlap@infradead.org>
References: <20230124181753.19309-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <167464674857.4906.11845808884729998732.tip-bot2@tip-bot2>
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

Commit-ID:     54628de6792bfa86a8d73520b6fa0029971f9fc6
Gitweb:        https://git.kernel.org/tip/54628de6792bfa86a8d73520b6fa0029971f9fc6
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 24 Jan 2023 10:17:53 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Jan 2023 12:21:04 +01:00

x86/Kconfig: Fix spellos & punctuation

Fix spelling (reported by codespell) & punctuation in arch/x86/ Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230124181753.19309-1-rdunlap@infradead.org
---
 arch/x86/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074..a825bf0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1502,7 +1502,7 @@ config X86_5LEVEL
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
-	  upto 128 PiB of virtual address space and 4 PiB of
+	  up to 128 PiB of virtual address space and 4 PiB of
 	  physical address space.
 
 	  It will be supported by future Intel CPUs.
@@ -2609,8 +2609,8 @@ config CALL_THUNKS_DEBUG
 	  a noisy dmesg about callthunks generation and call patching for
 	  trouble shooting. The debug prints need to be enabled on the
 	  kernel command line with 'debug-callthunks'.
-	  Only enable this, when you are debugging call thunks as this
-	  creates a noticable runtime overhead. If unsure say N.
+	  Only enable this when you are debugging call thunks as this
+	  creates a noticeable runtime overhead. If unsure say N.
 
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
