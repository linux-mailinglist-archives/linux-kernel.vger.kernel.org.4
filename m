Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF686E4A48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDQNqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDQNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:46:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9C110D0;
        Mon, 17 Apr 2023 06:46:13 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:46:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681739171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8ksSHHJr580EyKLhckkWElbaDppnblT6LZzlS8hJk0=;
        b=pB1ARphOmmXWUR8s99SBbTqEJeUjk/ND/OIiebNt9emWyIV36Pfa6q9S/YGrCweOGRIHZR
        EqEqSCEUeiXfB/mcBpCRNUB0apGYgaznJ0cwc6BmI4WyOdRTQIJiKsMnyAaWb8/8CTgjT9
        zN7osw/hhVvINqG79ZZ+osG17AdsB9vzWfSmJu+tjDrMXkIdHjYIG5NTJqwlwkAOSKaeNX
        DefDSEm6XmlG1DeS6dp8KehqCVdjsH3Id2bxEfrudBn7GmRl2QfU+Oc7ThbfqHVf3m1E0D
        cyzX/zqr6X0Y2y5e9L6Z0UGXPUYs8mzeZGCp56JPKLKL6wkAh0gmtrga/nbBzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681739171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8ksSHHJr580EyKLhckkWElbaDppnblT6LZzlS8hJk0=;
        b=7xhhPr1kjKHVaUWa8rD3A8sMFnppbHhUiqyhxRU0EC7AMeahhmQZocqWVH0wNF49dOhgdS
        es5mIvo/tRQMy/AA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Document which patches are
 not released for late loading
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230415142821.24725-1-bp@alien8.de>
References: <20230415142821.24725-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168173917061.404.13737098412746620734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     07cc5639f14dcc3763a926dbe7cc38ac2694de0c
Gitweb:        https://git.kernel.org/tip/07cc5639f14dcc3763a926dbe7cc38ac2694de0c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 15 Apr 2023 16:23:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Apr 2023 15:38:33 +02:00

x86/microcode/AMD: Document which patches are not released for late loading

PeterZ wanted this spelled out explicitly. Add it to the documentation
so that everyone's on the same page wrt to which microcode patches are
not allowed to be late loaded.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230415142821.24725-1-bp@alien8.de
---
 Documentation/x86/microcode.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index 15b52e2..d5ef918 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -218,6 +218,10 @@ a fault happens, the whole core will see it either before the microcode
 patch has been applied or after. In either case, T0 and T1 will have the
 same microcode revision and nothing intermediate.
 
+In addition, microcode patches which modify software-visible features
+like CPUID bits, MSRs, chicken bits, etc are not released for late
+loading.
+
 Builtin microcode
 =================
 
