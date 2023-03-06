Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E022A6AB709
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCFH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCFH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:28:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC6BDF8;
        Sun,  5 Mar 2023 23:28:07 -0800 (PST)
Date:   Mon, 06 Mar 2023 07:28:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678087685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIS5YhNZWvwmMB0K9cAZxKVYGrkIcL90O1qJhpJRwD4=;
        b=RXhBC7hlhlW/KyxbXX+5Fvn5cokGhczmVrw/ph+ptZGrlxC9sWs2HK9r8bqTzMnBWSdPpi
        88e0PDSH36JW7yrHiHSRCa7NTsYM4/W00QZ0AhOALgG1RU0U0WNQTN/UDx/rB7OPjA6+HX
        x8Vf8B9hK9uKQYiNfh0YtAdjCkR3svLKbSee48/9e8hyYwDFwBfyM5/sMYap92tdJv089a
        j2pEjrSR0V7wOi9+bl9ahIW7pQzProtvX8y8Gy8G95dwCLGE0gMhGwOe2wXkpRAkaa38Bz
        RGRe9glqUuXhTF+jAr4RKhePoGmehptfQ6wzpin6Tx5dfphu4+lV4c6W66hyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678087685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIS5YhNZWvwmMB0K9cAZxKVYGrkIcL90O1qJhpJRwD4=;
        b=HmM0uU3bwYqRtLOzSAAIYTaJRzdVJJMgFXbQibsbSQtGlXf+Tw9uSvP2eNlYhoaOA304/w
        PMvIvnmjgMoDbEBg==
From:   "tip-bot2 for Jingyu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry: Change stale function name in comment
 to error_return()
Cc:     Jingyu Wang <jingyuwang_vip@163.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220618154238.27749-1-jingyuwang_vip@163.com>
References: <20220618154238.27749-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Message-ID: <167808768497.5837.15205006512384554928.tip-bot2@tip-bot2>
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

Commit-ID:     8c3223a50faf1d173e0159eff10a9de902407135
Gitweb:        https://git.kernel.org/tip/8c3223a50faf1d173e0159eff10a9de902407135
Author:        Jingyu Wang <jingyuwang_vip@163.com>
AuthorDate:    Sat, 18 Jun 2022 23:42:38 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Mar 2023 08:04:03 +01:00

x86/entry: Change stale function name in comment to error_return()

Correct old function name error_exit() in the comment to what it is now
called: error_return().

  [ bp: Provide a commit message and massage. ]

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20220618154238.27749-1-jingyuwang_vip@163.com
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index eccc343..048866c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1027,7 +1027,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
+	 * exceptions go through error_return instead.
 	 */
 	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
