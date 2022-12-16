Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01B764EEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLPQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiLPQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:21:26 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B330555
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:21:23 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 79C379209F0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:21:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1E87D920CC0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:21:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671207682; a=rsa-sha256;
        cv=none;
        b=Fr+H9xrzkWgIc4jfBPJOP4KCOsCTag37CdFvnjDokba9iI5Z1lPzSYfvQ0t2ZyMW02J7lt
        pRlfyS2Rgf6cIBFvzFVfAhpNja7GXjSRtRHjJisvfB+yzeA0RhKtJV23Tvt/MXbThsMX/W
        gCqxDoHThlQCgth6vA16/q428oSip3o1P6TgG30uVbm9QGjU2LqX4YoRMl+gxtL8t9EHGu
        NDStxbXJkV1d0NPUpEgTVz0BiiQVNSXFzFpQJScXq7BwQUmCAmO7lGv94XLqWhuRo/0rpa
        EHESNH0Kivcy6+9MSIohZap18+/oDe/0XYwN5fHSUIyjWvqnGP5FXP/B6nhBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671207682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=ntqixOp2Rzio0BYbTNNACIXCQK/YxtD97cLJBDAV5UI=;
        b=0VWwz3PQ0bbAN/lbyIK1sDX0QhS1ptg72lVc6DpQO9fhoqNBjXvHv2eSS3Q5DkfAFggzXz
        +kRTOlddOZpA4cBFnQq1QET+fVDbwyn4hxsCd30GHMfOWN/2OEeruBuXShOAKKJE/cmncN
        yaRUZftQYKgqZjWNfjtcGKMRj7s0gX4QEZGBBt0LP+sP5EuQXXDth5k9g69rpS8/z189X3
        78UALZAmu4Zh6dFPG5UYINJ9hB7+ssqKKcX7gZtXXnPx1ju0FdDb9pO4guVlPW+hs1ROTt
        8CzGIFWrajAYTs+KnmkT5dqKw6qE0wkiXow8MqsKDFZ3ngk6su2YCKRKXlbOig==
ARC-Authentication-Results: i=1;
        rspamd-6f8d97c84c-zkm4n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Arithmetic: 6e9249c27d1a3e52_1671207682352_436618466
X-MC-Loop-Signature: 1671207682352:3089387748
X-MC-Ingress-Time: 1671207682352
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.224 (trex/6.7.1);
        Fri, 16 Dec 2022 16:21:22 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4NYZ9F0bq7zXJ
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1671207681;
        bh=ntqixOp2Rzio0BYbTNNACIXCQK/YxtD97cLJBDAV5UI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=uOjwEYkoewh231QtAzac8ZB2yrw4S+dYoTWf6QzXpKonZvN7Cw/1ValnsZzDERPxJ
         PBOXkrPYirXsqpx0lKtbotoInbq9A1hal4SomyS8mrA/bVKL/5A0soCi42sJyr0R2q
         1+sfsMN2f2R5BVmt3hjGKA8zBkW87wsp+wI4gF3I=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e002b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 16 Dec 2022 08:21:18 -0800
Date:   Fri, 16 Dec 2022 08:21:18 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next v3] x86/xen/time: prefer tsc as clocksource when
 it is invariant
Message-ID: <20221216162118.GB2633@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kvm elects to use tsc instead of kvm-clock when it can detect that the
TSC is invariant.

(As of commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
invariant TSC is exposed")).

Notable cloud vendors[1] and performance engineers[2] recommend that Xen
users preferentially select tsc over xen-clocksource due the performance
penalty incurred by the latter.  These articles are persuasive and
tailored to specific use cases.  In order to understand the tradeoffs
around this choice more fully, this author had to reference the
documented[3] complexities around the Xen configuration, as well as the
kernel's clocksource selection algorithm.  Many users may not attempt
this to correctly configure the right clock source in their guest.

The approach taken in the kvm-clock module spares users this confusion,
where possible.

Both the Intel SDM[4] and the Xen tsc documentation explain that marking
a tsc as invariant means that it should be considered stable by the OS
and is elibile to be used as a wall clock source.

In order to obtain better out-of-the-box performance, and reduce the
need for user tuning, follow kvm's approach and decrease the xen clock
rating so that tsc is preferable, if it is invariant, stable, and the
tsc will never be emulated.

[1] https://aws.amazon.com/premiumsupport/knowledge-center/manage-ec2-linux-clock-source/
[2] https://www.brendangregg.com/blog/2021-09-26/the-speed-of-time.html
[3] https://xenbits.xen.org/docs/unstable/man/xen-tscmode.7.html
[4] Intel 64 and IA-32 Architectures Sofware Developer's Manual Volume
    3b: System Programming Guide, Part 2, Section 17.17.1, Invariant TSC

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Code-reviewed-by: David Reaver <me@davidreaver.com>
---
v3:
  - Temporarily drop references to public API headers
  - tsc_emulated check is redundant if tsc_mode is no emulate. (feedback from
    Boris Ostrovsky)
  - Use cpuid_count instead of cpuid when accessing a cpuid leaf with subleaves.
    (feedback from Jan Beulich)
  - Kernel has its own cpuid hypercall and can intercept checks about the tsc
    mode.  The check for PV mode is inapposite and therefore removed. (feedback
    from Jan Beulich)
v2:
  - Use cpuid information to determine if tsc is emulated.  Do not use tsc as
    clocksource if it is. (feedback from Boris Ostrovsky)
  - Move tsc checks into their own helper function
  - Add defines for tsc cpuid flags needed by new helper function.
---
 arch/x86/xen/time.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 9ef0a5cca96e..95140609c8a8 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -474,15 +474,51 @@ static void xen_setup_vsyscall_time_info(void)
 	xen_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_PVCLOCK;
 }
 
+/*
+ * Check if it is possible to safely use the tsc as a clocksource.  This is
+ * only true if the hypervisor notifies the guest that its tsc is invariant,
+ * the tsc is stable, and the tsc instruction will never be emulated.
+ */
+static int __init xen_tsc_safe_clocksource(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
+		return 0;
+
+	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
+		return 0;
+
+	if (check_tsc_unstable())
+		return 0;
+
+	/* Leaf 4, sub-leaf 0 (0x40000x03) */
+	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
+
+	/* tsc_mode = no_emulate (2) */
+	if (ebx != 2)
+		return 0;
+
+	return 1;
+}
+
 static void __init xen_time_init(void)
 {
 	struct pvclock_vcpu_time_info *pvti;
 	int cpu = smp_processor_id();
 	struct timespec64 tp;
 
-	/* As Dom0 is never moved, no penalty on using TSC there */
+	/*
+	 * As Dom0 is never moved, no penalty on using TSC there.
+	 *
+	 * If it is possible for the guest to determine that the tsc is a safe
+	 * clocksource, then set xen_clocksource rating below that of the tsc
+	 * so that the system prefers tsc instead.
+	 */
 	if (xen_initial_domain())
 		xen_clocksource.rating = 275;
+	else if (xen_tsc_safe_clocksource())
+		xen_clocksource.rating = 299;
 
 	clocksource_register_hz(&xen_clocksource, NSEC_PER_SEC);
 
-- 
2.25.1

