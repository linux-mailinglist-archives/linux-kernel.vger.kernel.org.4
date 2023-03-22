Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9F6C577E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjCVU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjCVU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:26:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3C8C971;
        Wed, 22 Mar 2023 13:16:36 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5u8tyN+IU56rA9DJvsFKN9/HGFOyV3KihMrCzYE7Tig=;
        b=dOeThJs2aeTXzpx6JcZq+XQffdxkbkYU4iW/Ck0hMkCJIPg3UmvUxrsu1WLMWjRL5+YNOY
        W5Ku3K+I4i74ynHAbw6YXVLFzc2DR2f7AihHdBOjuN025dJEUoRjmvn1KBe2TXz3M468iM
        mPWQ30KN+AMFzRqGhzI2abc/Wj/X/6avhZxL2kpuZ1/YON0fJyoi+Lt3yTuD3HRArlUsam
        e00tSQHakKVKCz6UCzmEm/3kH98lnvaQ2dn9EfkNEuxksZivaaFvhQ05tEelhKwoREuqQV
        aPleWxSu5Kyg4PLTvE5Gic7tQAXi6YKni7x2gI6Ck5I/VySG82dQGVrDdy6Uqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5u8tyN+IU56rA9DJvsFKN9/HGFOyV3KihMrCzYE7Tig=;
        b=ukjSOLfG1veKNlteUs+nRsbN0kr8p9dRUory59YUF88uC046s/4vnPnaky5VSq7i7lMI7E
        5WBrgJKJr0Coe5AA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] Documentation/x86: Explain the purpose for dynamic features
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951609417.5837.17571344184577472295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ad9c29f3c29197aa25d26a5f258a98e4cb901996
Gitweb:        https://git.kernel.org/tip/ad9c29f3c29197aa25d26a5f258a98e4cb901996
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 20 Jan 2023 16:18:57 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 13:02:18 -07:00

Documentation/x86: Explain the purpose for dynamic features

This summary will help to guide the proper use of the enabling model.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20230121001900.14900-2-chang.seok.bae%40intel.com
---
 Documentation/x86/xstate.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 5cec7fb..e954e79 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -11,6 +11,22 @@ are enabled by XCR0 as well, but the first use of related instruction is
 trapped by the kernel because by default the required large XSTATE buffers
 are not allocated automatically.
 
+The purpose for dynamic features
+--------------------------------
+
+Legacy userspace libraries often have hard-coded, static sizes for
+alternate signal stacks, often using MINSIGSTKSZ which is typically 2KB.
+That stack must be able to store at *least* the signal frame that the
+kernel sets up before jumping into the signal handler. That signal frame
+must include an XSAVE buffer defined by the CPU.
+
+However, that means that the size of signal stacks is dynamic, not static,
+because different CPUs have differently-sized XSAVE buffers. A compiled-in
+size of 2KB with existing applications is too small for new CPU features
+like AMX. Instead of universally requiring larger stack, with the dynamic
+enabling, the kernel can enforce userspace applications to have
+properly-sized altstacks.
+
 Using dynamically enabled XSTATE features in user space applications
 --------------------------------------------------------------------
 
