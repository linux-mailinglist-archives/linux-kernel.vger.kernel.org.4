Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18169D21A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBTR0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:26:21 -0500
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 09:26:20 PST
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066E1B571
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:26:20 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D49D260C8A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:17:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AFC1026103D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:17:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676913427; a=rsa-sha256;
        cv=none;
        b=4tFhZErNiFWlGTFekGbGESBLT7P5i0m0v8Yg+qA/+1JCx+qV53V5Q/WOAmlY4h45ZEedHY
        z28HRpitKQ/eQzgyGgynjk9TwhceYCogfUf/gN1nK/7U2WNluIyXRqrmDbniLBd7tVXEEo
        +V+vcFYMsY3VAxhlM6Q4DsC1mQAyn5I1mDSz3muVIycTT2eo6lSa9MuWW3So3kmzj7AyuR
        fMr7wLn/S0Xd//X9NSQe8/hPwrnWABNXB5OCQmv4q5A+akQRd32i/Gt3aC0Vk0oEDAZCCJ
        BXfJP3K9sCHiWSLPIHFDk7D0X/wvVhQKcmNFj1MfeuNdRPv7EAyP6JZha59O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676913427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1W/yHp+digs/9tQmrEdxtc9OFifUEYrTHbBFllZM5ek=;
        b=xXhwV7WREpCzUtRekSSszUEhNEH8mNVx9p8d4UqZi6lSomM0CHU90E5GCYjT5USai1LTlY
        FlcdJ9ox1Q9KJ2dbOFFj5ibWpfY2u6lNx6dwjwEqI2unAZ+ixhDU/DnOGLiqxaGmrxKFGV
        nRLbLKCHHLQ80pCdmqU1JSPRo0dYURW94VQiDpwuIozof6+lqFXymaEStikr4V0tLPjSPN
        3g46RfhYaicQAIXzz12y0gjuA3IkNZk2GkmqBckrNArxcos8yHZMWc0VvjiJL8QHOR92PR
        NgQV91jHedkYBgzUrLUnuxwxykt5gQHcEYVC2DYA1RnCXvzezoQcpOIIhPYEOQ==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-747s9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Language: 08d1ebd151a45756_1676913427950_2233105593
X-MC-Loop-Signature: 1676913427950:1356471465
X-MC-Ingress-Time: 1676913427950
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.47 (trex/6.7.1);
        Mon, 20 Feb 2023 17:17:07 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PL8H72W92zK1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676913427;
        bh=1W/yHp+digs/9tQmrEdxtc9OFifUEYrTHbBFllZM5ek=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=a6HhWuyIXd0r+Vbw2w11XEvcD5cd0lSYKKKcGgBv9WMcNKr0xU/PwnGY3RisHuanu
         nO0Men7S+hQu294AFT/WV2/RZR+ETeG8TVe/k+G3t/s+lGrQrkD5mJbGKmBfI6kOKI
         O6Op+1gN+DNAMZ58+1C+eo/z1tK2zF6BKG2tEjyo=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0067
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 09:17:04 -0800
Date:   Mon, 20 Feb 2023 09:17:04 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next 2/2] x86/xen/time: cleanup xen_tsc_safe_clocksource
Message-ID: <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676610413.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies xen_tsc_safe_clocksource() to use newly defined constants from
arch/x86/include/asm/xen/cpuid.h.  This replaces a numeric value with
XEN_CPUID_TSC_MODE_NEVER_EMULATE, and deletes a comment that is now self
explanatory.

There should be no change in the function's behavior.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 arch/x86/xen/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 95140609c8a8..cf6dd9f9fa6a 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -20,6 +20,7 @@
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/xen/cpuid.h>
 
 #include <xen/events.h>
 #include <xen/features.h>
@@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
 
-	/* tsc_mode = no_emulate (2) */
-	if (ebx != 2)
+	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
 		return 0;
 
 	return 1;
-- 
2.25.1

