Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB52669FA90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBVRzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjBVRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:55:14 -0500
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062F3E629
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:55:05 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8BCFA6C0D80
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:55:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1315D6C0FED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:55:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677088503; a=rsa-sha256;
        cv=none;
        b=oUdm9hPUqOZPk3vnqDVNvwRGFiGgkP3riHS/4KnKqpryF5x9+kDQ1ctioBviUfZRAx6eBR
        +1YUfEM9AqlqHDHbiQNSC/cVdzRSg9357PvAdzLD6LnFk0l6xPWHuh6wYka8sRakgD9Gye
        NCbWybR9dO+RLH+EceZFA4qEuYHe9kVo4D0LDicI5GOW/yNHb/G6tMlfB/o/niJcsAPnDR
        KeYBueEw/M1qzfDILMnGssRbRinNxXpaKcIiuPrtKQQobQ+FFkEPsfWSCNqFoK9qEGp83N
        VYbQphexIc82r8gaZO0VYRPxt+vBwqq6tvxAjWfAXyDCShk1Zvl3e6gePesWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677088503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SFO62oAKLgPH71Y0Xq/5Q3j7DH6Nq6RDi9wLwjcluGc=;
        b=2nnWgivDo+ddQX4rXiVJFmvq/Lt3TNfeg2LRMvHtY8AiKcE+pzC/vycn8nbgRTl7yPqU0A
        LT/Ue7aCX26pdUYZpg8/T907x83j0NB0X77V0Zk/w/Lt/NewKyOi1AZBUDrB8nh/OsCD5m
        HLa5K/EScxZ4ixB3H6zxM9odvnD5LnsIgpOKu1EYrpFfqh0tRvGIZWjR8Zaa6FmS2WpxET
        9Obv94jt83r9628x9ZYi78/eUFyTxuKtrO+5Ggpj+crL88aSqbkbFXYCY303AIyq0ac9zp
        1VJc4xeHA2JSG18pZqwu1Vg20wGjC8JwjVjnC0S1/V3OC5PDSEo8GxFUsYNG0Q==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-tlhbm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Imminent: 6e390c0c2f524750_1677088503372_3885356842
X-MC-Loop-Signature: 1677088503372:3174618892
X-MC-Ingress-Time: 1677088503372
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.140 (trex/6.7.1);
        Wed, 22 Feb 2023 17:55:03 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PMP1x5cvdz3L
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677088502;
        bh=SFO62oAKLgPH71Y0Xq/5Q3j7DH6Nq6RDi9wLwjcluGc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eeNdy4H+j7lG6Sne8OpERURhOxfjYoo41SOiAGXZQlESWISax/NRObaYPfTyzFJF7
         js3TD4KnZUKPTPauRebQivsARvaC2EYQAHbTJ8toeSAPHu1bDB4FuINUhD1dt/rflX
         6+D3NX4iCssGRBTfJ7L/G8wVVzNoKOJmCStUVLb0=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e004a
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 22 Feb 2023 09:54:56 -0800
Date:   Wed, 22 Feb 2023 09:54:56 -0800
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
Subject: [PATCH linux-next v2 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
Message-ID: <a69ca370fecf85d312d2db633d9438ace2af6e5b.1677038165.git.kjlx@templeofstupid.com>
References: <cover.1677038165.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677038165.git.kjlx@templeofstupid.com>
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
 arch/x86/xen/time.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 95140609c8a8..94056013a2a4 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -20,6 +20,7 @@
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/xen/cpuid.h>
 
 #include <xen/events.h>
 #include <xen/features.h>
@@ -495,11 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
 	/* Leaf 4, sub-leaf 0 (0x40000x03) */
 	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
 
-	/* tsc_mode = no_emulate (2) */
-	if (ebx != 2)
-		return 0;
-
-	return 1;
+	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
 }
 
 static void __init xen_time_init(void)
-- 
2.25.1

