Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788BD63433D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiKVSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiKVSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048AF69DFC;
        Tue, 22 Nov 2022 10:04:54 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669140292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmY8pSPebN5KMTP5tVAW5IE+k8QrOqxPf8qBgU+NO3o=;
        b=jfBxqfQckW2PXWKSLVmYb+Mg9uMDbja+88ZNRfZiW7jF7jo07jCCP/yg3SORXETLuYGpWA
        5PfwvIH3NU/uzgD882kjthqXDWp2/bAkuDuVrW7rcX9rl3tgooE0f0zpp3jDH+6Z91LhkT
        T1Ud+FfB8LG4Emn2gppH+rdh3Dqi4+HGQmN102cZ7L9UTk5+WHJwjmoXX61vpL+pioQhZa
        +S73bGDmwxSfWg8l4v+tmVDIPmJBgYNIaiux0rBYV41KnFp2WYC4a1kQX+r1/dN7nAqi3V
        LwxTYFJDPt95Jxsh9UwWH2/IMJREy0vJgFmoQeUqkzXpOaqKZF8lx/DMIQr64g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669140292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmY8pSPebN5KMTP5tVAW5IE+k8QrOqxPf8qBgU+NO3o=;
        b=HEModx1gu9K/ILQigAw1AOQeYoQTCqjbEl+z/347Iq9LTwJY0yltpVwRZw+FxnD5eW4Dm3
        vrbJfVituH4OiwCA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Add X86_FEATURE_XENPV to disabled-features.h
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104072701.20283-2-jgross@suse.com>
References: <20221104072701.20283-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166914029143.4906.11843439869317994745.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     15e15d64bd8e12d835f6bb1b1ce3ffa13fa03a66
Gitweb:        https://git.kernel.org/tip/15e15d64bd8e12d835f6bb1b1ce3ffa13fa03a66
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 04 Nov 2022 08:26:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 15:42:33 +01:00

x86/cpufeatures: Add X86_FEATURE_XENPV to disabled-features.h

Add X86_FEATURE_XENPV to the features handled specially in
disabled-features.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221104072701.20283-2-jgross@suse.com
---
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 33d2cd0..c862552 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -81,6 +81,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_XEN_PV
+# define DISABLE_XENPV		0
+#else
+# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
+#endif
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 # define DISABLE_TDX_GUEST	0
 #else
@@ -98,7 +104,7 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
+#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
