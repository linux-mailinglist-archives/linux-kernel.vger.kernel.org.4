Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CA6FB22A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEHOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjEHOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:04:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9823657F;
        Mon,  8 May 2023 07:04:37 -0700 (PDT)
Date:   Mon, 08 May 2023 14:04:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683554675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+UvbKlCDotLpiK1Wavm759o5WLup9mjATyq9kKNMQQ=;
        b=L8Xv2qRcTdMfhHFXXXuBgnzs4cf7YSi+1Joc90GkXgrAXjtlZcOlH96rEXrD4MIMmNQZSY
        lqusLeaU2TgPqrvsu+f/TQjdFuY06kKeNYf9PUfn21zJvpI3/WtqwVCCrVXz47FKoqoVR+
        n11VMD7fmhRHwgvatP9P0g7hRdFznY3kXhqN+JallWQmLr1T8Yu3t6dMfhn7agbRG4cij2
        BpR1MreGzeDVd1vIIAvntHss8ZFa7HzSEQY1Na7qVBmaruK5G7iDtPeZhBe7jj5H2hrcyT
        jqG979F12Aq/46GIjDq5Aw5feJppt9A4yfc0I5hOMgnXq5n9CJcV5acyvQzELQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683554675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+UvbKlCDotLpiK1Wavm759o5WLup9mjATyq9kKNMQQ=;
        b=UzIPPPQPooKMBeXWgaliVnwOtUcHL5fKIseGqEf68wGkcPh4z6F5yePPLkYzvaSyTPdKMY
        h6SXAsD0Asm+9/Ag==
From:   "tip-bot2 for Rong Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Add .gitignore
Cc:     Rong Tao <rtoax@foxmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_F0318BF0724705EC156C341E11DE4040E805@qq.com>
References: <tencent_F0318BF0724705EC156C341E11DE4040E805@qq.com>
MIME-Version: 1.0
Message-ID: <168355467503.404.9147950102200023529.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b2ad431f6469b58914ee7254302c6dc97f688e54
Gitweb:        https://git.kernel.org/tip/b2ad431f6469b58914ee7254302c6dc97f688e54
Author:        Rong Tao <rtoax@foxmail.com>
AuthorDate:    Fri, 28 Apr 2023 15:55:49 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 15:53:50 +02:00

tools/x86/kcpuid: Add .gitignore

Ignore kcpuid ELF file.

  [ bp: Drop the '/' before the name. ]

Signed-off-by: Rong Tao <rtoax@foxmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/tencent_F0318BF0724705EC156C341E11DE4040E805@qq.com
---
 tools/arch/x86/kcpuid/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/arch/x86/kcpuid/.gitignore

diff --git a/tools/arch/x86/kcpuid/.gitignore b/tools/arch/x86/kcpuid/.gitignore
new file mode 100644
index 0000000..1b8541b
--- /dev/null
+++ b/tools/arch/x86/kcpuid/.gitignore
@@ -0,0 +1 @@
+kcpuid
