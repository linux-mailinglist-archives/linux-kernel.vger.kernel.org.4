Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3EF6B3BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCJKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCJKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:23:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7781A4A6;
        Fri, 10 Mar 2023 02:23:39 -0800 (PST)
Date:   Fri, 10 Mar 2023 10:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678443816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmW1fMIiJseHqCgSBPyNA5oyhw2rY1T8DauIS/wwJKQ=;
        b=GwcXFc/T8oNcEKfdCJ7CVXYHcBL8cb9yow5bNV2WDGHKIor9Xt1Nm9/OcTqRqJYu53rSeH
        wcQmKqZJL1uO6vk1/GyEItVOYABmdCw7NfaX9ZWkEDA2uKr4N6YJCBQ//fsyLs5CKlU7QW
        LkWkcexOHtbE9PJ9iPoqk2q1I6cTEiytOOpeqRlWYd8Kg7J8MaL99ibWCyBV76dpVdlrP9
        I9PlC5U7KL1BWPCELcS6XvyvePcbVflx716UjHgbYP00s6V31sFjKQUVKVXNaG9dkKc4D5
        k/okaEKIidDjQpnWSKMIaURREuJ9l0fUdUB1Gp4j/GwUsJsVB6NwpzEr4J9rcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678443816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmW1fMIiJseHqCgSBPyNA5oyhw2rY1T8DauIS/wwJKQ=;
        b=1gMG8WrAo+2Rs1M8s5fkZgyOSLlzaCiIXKFjvy17AzsLJUWdj0KkioVMbeM6pxdKTGEXl8
        hbZL9Z1xwKIoPaCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Add x86 hardware vulnerabilities section
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230224213522.nofavod2jzhn22wp@treble>
References: <20230224213522.nofavod2jzhn22wp@treble>
MIME-Version: 1.0
Message-ID: <167844381609.5837.4907138475785579088.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5910f06503aae3cc4890e562683abc3e38857ff9
Gitweb:        https://git.kernel.org/tip/5910f06503aae3cc4890e562683abc3e38857ff9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 24 Feb 2023 13:35:22 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 10 Mar 2023 11:13:30 +01:00

MAINTAINERS: Add x86 hardware vulnerabilities section

Add the bunch of losers who have to deal with this to MAINTAINERS so
that they can get explicitly CCed on more hw nightmares.

  [ bp: Add commit message. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230224213522.nofavod2jzhn22wp@treble
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc22..d95c6cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22660,6 +22660,17 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
 F:	arch/x86/entry/
 
+X86 HARDWARE VULNERABILITIES
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Borislav Petkov <bp@alien8.de>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
+R:	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
+S:	Maintained
+F:	Documentation/admin-guide/hw-vuln/
+F:	arch/x86/include/asm/nospec-branch.h
+F:	arch/x86/kernel/cpu/bugs.c
+
 X86 MCE INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
