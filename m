Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1F64A48C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiLLQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLLQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:05:31 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88E11806
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:05:29 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AEE724280A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:05:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3D1F54198F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:05:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670861127; a=rsa-sha256;
        cv=none;
        b=I8TrtoxejXRNxtZPx3xRx8a/Kn2lWvSMPnSqiknyxRkRRf7fCqhGBttjb69DcG7sMNRtnb
        kTgm0szlYoizJciWnwxj/18rXBqoLqlMe4J/GbbRvyoGSU3Uu1Yr+Eg324vSOM2FLSS4Sm
        /OUuQ10IVhrF9sO2bfWfGmIwADleXo2+IkiWEXDsqeLd2YnKKKT7Q0cP6hywMP8on4wXPw
        aNamZqSpCQdJ/wLwNvgHfPjLX4im+CEjAwFZq0tIspywbVheseiV0+Zaq9mtPqBaVZZihw
        JAgeTeKtSvc5EgNA9ubTqzeC92u1837tmY6pMFII/8mBgnqdEfQK0x5uL1Qg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670861127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=eTQuoFAvDCg5Wk/HY/QA0RgQaxrFIn7prIyIP8P5BA8=;
        b=1UIQwTq99aT9X86dJy7bq+qR8bOdSnCSIPQPNW4ezjaymQ/sjHRqXRtbAEd046YkCR/L65
        6oTS3g1ChcE6UaLCg8fSb6+1oa8rDACxU3AAAgKrg7ug7xXtJ4d+ehAeOL5PN5nb1n6rfz
        t8rNBlVwW/hm9VXOJtJJgCSDunKD1EwPP1/uW8ddveTJ3zRxg97RyTd8zr5IuuqiltQIUU
        ZHmUD0N0uWhjWjfsiCHAhHbvoLnW7NYi6CFntWMUHXfXp6BjOXA9IjusCiHm/x82JXoL2n
        /aa634nczszED7RTdk/GoKGTX7fb1GtU+9fASxFqjnQv9Zvn1UkCXwl36ReYcg==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-cslfv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Reign-Arithmetic: 63d76a125358ab75_1670861127551_4006702340
X-MC-Loop-Signature: 1670861127551:4117110136
X-MC-Ingress-Time: 1670861127551
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.8 (trex/6.7.1);
        Mon, 12 Dec 2022 16:05:27 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4NW60k3jCzzPS
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1670861126;
        bh=eTQuoFAvDCg5Wk/HY/QA0RgQaxrFIn7prIyIP8P5BA8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nmfTdh0MzhuVwJ4HwvjvorQHBgs0vj8eAOA6Ul9XT0o9zbmCyMKLpERyPCXvWY5Sl
         +GTlDaQAuN/IcaYEqih+UE1AfZ60EsMYkaSz5YppWsdHLEmzU7g8CpMn3b7ptm6dVN
         rZxPYrOPp7HZtQInZgk1DLHwGsyCR+nRHNf5LfEw=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0062
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 12 Dec 2022 08:05:24 -0800
Date:   Mon, 12 Dec 2022 08:05:24 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource when
 it is invariant
Message-ID: <20221212160524.GB1973@templeofstupid.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212155730.GA1973@templeofstupid.com>
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
and is elibile to be used as a wall clock source.  The Xen documentation
further clarifies that this is only reliable on HVM and PVH because PV
cannot intercept a cpuid instruction.

In order to obtain better out-of-the-box performance, and reduce the
need for user tuning, follow kvm's approach and decrease the xen clock
rating so that tsc is preferable, if it is invariant, stable, the
guest is a HVM or PVH domain, and the tsc is not emulated.

[1] https://aws.amazon.com/premiumsupport/knowledge-center/manage-ec2-linux-clock-source/
[2] https://www.brendangregg.com/blog/2021-09-26/the-speed-of-time.html
[3] https://xenbits.xen.org/docs/unstable/man/xen-tscmode.7.html
[4] Intel 64 and IA-32 Architectures Sofware Developer's Manual Volume
    3b: System Programming Guide, Part 2, Section 17.17.1, Invariant TSC

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Code-reviewed-by: David Reaver <me@davidreaver.com>
---
v2:
  - Use cpuid information to determine if tsc is emulated.  Do not use tsc as
    clocksource if it is. (feedback from Boris Ostrovsky)
  - Move tsc checks into their own helper function
  - Add defines for tsc cpuid flags needed by new helper function.
---
 arch/x86/include/asm/xen/cpuid.h |  6 +++++
 arch/x86/xen/time.c              | 43 +++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
index 6daa9b0c8d11..d9d7432481e9 100644
--- a/arch/x86/include/asm/xen/cpuid.h
+++ b/arch/x86/include/asm/xen/cpuid.h
@@ -88,6 +88,12 @@
  *             EDX: shift amount for tsc->ns conversion
  * Sub-leaf 2: EAX: host tsc frequency in kHz
  */
+#define XEN_CPUID_TSC_EMULATED       (1u << 0)
+#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
+#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
+#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
+#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
+#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)
 
 /*
  * Leaf 5 (0x40000x04)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 9ef0a5cca96e..4100b1c3f38d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -20,6 +20,7 @@
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/xen/cpuid.h>
 
 #include <xen/events.h>
 #include <xen/features.h>
@@ -474,15 +475,55 @@ static void xen_setup_vsyscall_time_info(void)
 	xen_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_PVCLOCK;
 }
 
+/*
+ * Check if it is possible to safely use the tsc as a clocksource.  This is only
+ * true if the domain is HVM or PVH, the hypervisor notifies the guest that its
+ * tsc is invariant, and the tsc instruction is not going to be emulated.
+ */
+static int __init xen_tsc_safe_clocksource(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!(xen_hvm_domain() || xen_pvh_domain()))
+		return 0;
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
+	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
+
+	if (eax & XEN_CPUID_TSC_EMULATED)
+		return 0;
+
+	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
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
+	 * clocksource, then set xen_clocksource rating below that of the tsc so
+	 * that the system prefers tsc instead.
+	 */
 	if (xen_initial_domain())
 		xen_clocksource.rating = 275;
+	else if (xen_tsc_safe_clocksource())
+		xen_clocksource.rating = 299;
 
 	clocksource_register_hz(&xen_clocksource, NSEC_PER_SEC);
 
-- 
2.25.1

