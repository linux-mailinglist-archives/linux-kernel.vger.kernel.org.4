Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206A739DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFVJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:55:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B5E4B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:52:30 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD3061EC040E;
        Thu, 22 Jun 2023 11:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687427549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=zhH6AjcPURsFkoDkgja4eWVNzPjcyMw07ZViYweHo4o=;
        b=fR1JH0Z18ng6RJOiDhM1FoZa9GwmeG2SiYOck4izvj/q2EWR/oLrCxKaEnEPkEo5+wrJRM
        8iD4F5YFJWVSeLoRRQF70dM5tbxW/kgNUHQ6tAOpPiQGK0Lk9rG3KMwrrA1m3yaRbiYqiu
        03+suwUOCh5cH9UqtWoo72FOIvJK0QM=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9u-pBkZxAQVq; Thu, 22 Jun 2023 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687427543; bh=IepMFlL+R/OX9G+2lxDjr/FKsizM+iLX6JWYez3NXQk=;
        h=From:To:Cc:Subject:Date:From;
        b=jFdZybfIAqydpKWnoVXfe/tuD2utsoGJPJsl4Uy4QSqVezxnIavkkk133gq59ncAD
         Wy5IH5FAFY7XFWsk5EG9HNlzkE7ifftH1g/RBtqj/WzK0syITKGHE07bUPbAbhazwk
         OQZosTwfz8bh3Uu4WhSCDG+auYRTJylegKJs65ADABFh85+OQk+sdTMGm0ub/gSDLp
         0K4uEXBmqovfp3Sy+lkJbD9pozyVHqCEcnLFNdJTLdmYu/sa4TN4mlEakyfzMa1cm/
         +b8S5agvTQx37FFhQxuJu3i4K4qaqmUgWLEJynCNRzVV54Tnziu/BdPJJuWAY8TxkZ
         cM94/clm5EZpIeAgJnlt2L2teBKqp9oFwR/o2z9GYFHsgO5C0WfSRbKGUuUBPYbxf+
         4+VU8AKv8IRAiXL8zUe004NmcX+wXs8tNsbc6lu1PiifhQeSjbmTTRD8hU7OuaVxzh
         ce4fdoa7JdPgF12VC8JkxpCV6r82fYnOeNde4jllMQNf4oUkjcmlW8OIeqSJ0lnZjC
         tN0oiKO3OdjdCNkgJeFQM5wYesFKm3J+XBcS5XB5npM+Aq93r/GmiPQCOjKNOfSSl1
         EuBbqySI7ZVI/yK/C1b97q++nBsPg/QrkplwCPiSTnGN5UJBH1G/uZ2wFBxqb+gq0E
         lI5U9x51MNV5jpi+Ymg7yGb0=
Received: from zn.tnic (p200300Ea971DC565329c23FfFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DEF340E0145;
        Thu, 22 Jun 2023 09:52:20 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Date:   Thu, 22 Jun 2023 11:52:12 +0200
Message-Id: <20230622095212.20940-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

AMD does not have the requirement for a synchronization barrier when
acccessing a certain group of MSRs. Do not incur that unnecessary
penalty there.

While at it, move to processor.h to avoid include hell. Untangling that
file properly is a matter for another day.

Some notes on the performance aspect of why this is relevant, courtesy
of Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>:

On a AMD Zen4 system with 96 cores, a modified ipi-bench[1] on a VM
shows x2AVIC IPI rate is 3% to 4% lower than AVIC IPI rate. The
ipi-bench is modified so that the IPIs are sent between two vCPUs in the
same CCX. This also requires to pin the vCPU to a physical core to
prevent any latencies. This simulates the use case of pinning vCPUs to
the thread of a single CCX to avoid interrupt IPI latency.

In order to avoid run-to-run variance (for both x2AVIC and AVIC), the
below configurations are done:

  1) Disable Power States in BIOS (to prevent the system from going to
     lower power state)

  2) Run the system at fixed frequency 2500MHz (to prevent the system
     from increasing the frequency when the load is more)

With the above configuration:

*) Performance measured using ipi-bench for AVIC:
  Average Latency:  1124.98ns [Time to send IPI from one vCPU to another =
vCPU]

  Cumulative throughput: 42.6759M/s [Total number of IPIs sent in a secon=
d from
  				     48 vCPUs simultaneously]

*) Performance measured using ipi-bench for x2AVIC:
  Average Latency:  1172.42ns [Time to send IPI from one vCPU to another =
vCPU]

  Cumulative throughput: 40.9432M/s [Total number of IPIs sent in a secon=
d from
  				     48 vCPUs simultaneously]

From above, x2AVIC latency is ~4% more than AVIC. However, the expectatio=
n is
x2AVIC performance to be better or equivalent to AVIC. Upon analyzing
the perf captures, it is observed significant time is spent in
weak_wrmsr_fence() invoked by x2apic_send_IPI().

With the fix to skip weak_wrmsr_fence()

*) Performance measured using ipi-bench for x2AVIC:
  Average Latency:  1117.44ns [Time to send IPI from one vCPU to another =
vCPU]

  Cumulative throughput: 42.9608M/s [Total number of IPIs sent in a secon=
d from
  				     48 vCPUs simultaneously]

Comparing the performance of x2AVIC with and without the fix, it can be s=
een
the performance improves by ~4%.

Performance captured using an unmodified ipi-bench using the 'mesh-ipi' o=
ption
with and without weak_wrmsr_fence() on a Zen4 system also showed signific=
ant
performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option=
 ignores
CCX or CCD and just picks random vCPU.

  Average throughput (10 iterations) with weak_wrmsr_fence(),
        Cumulative throughput: 4933374 IPI/s

  Average throughput (10 iterations) without weak_wrmsr_fence(),
        Cumulative throughput: 6355156 IPI/s

[1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi=
-bench

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/barrier.h   | 18 ------------------
 arch/x86/include/asm/processor.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrie=
r.h
index 35389b2af88e..0216f63a366b 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -81,22 +81,4 @@ do {									\
=20
 #include <asm-generic/barrier.h>
=20
-/*
- * Make previous memory operations globally visible before
- * a WRMSR.
- *
- * MFENCE makes writes visible, but only affects load/store
- * instructions.  WRMSR is unfortunately not a load/store
- * instruction and is unaffected by MFENCE.  The LFENCE ensures
- * that the WRMSR is not reordered.
- *
- * Most WRMSRs are full serializing instructions themselves and
- * do not require this barrier.  This is only required for the
- * IA32_TSC_DEADLINE and X2APIC MSRs.
- */
-static inline void weak_wrmsr_fence(void)
-{
-	asm volatile("mfence; lfence" : : : "memory");
-}
-
 #endif /* _ASM_X86_BARRIER_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
index b216ac80ebcc..983406342484 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -735,4 +735,23 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif
=20
+/*
+ * Make previous memory operations globally visible before
+ * a WRMSR.
+ *
+ * MFENCE makes writes visible, but only affects load/store
+ * instructions.  WRMSR is unfortunately not a load/store
+ * instruction and is unaffected by MFENCE.  The LFENCE ensures
+ * that the WRMSR is not reordered.
+ *
+ * Most WRMSRs are full serializing instructions themselves and
+ * do not require this barrier.  This is only required for the
+ * IA32_TSC_DEADLINE and X2APIC MSRs.
+ */
+static inline void weak_wrmsr_fence(void)
+{
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
+		asm volatile("mfence; lfence" : : : "memory");
+}
+
 #endif /* _ASM_X86_PROCESSOR_H */
--=20
2.35.1

