Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF15746D39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjGDJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGDJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:22:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4551703
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:22:37 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4DF1EC053F;
        Tue,  4 Jul 2023 11:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688462555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G2ELpD9uAx110G37H+EcPaBIW7h/0XMkeqrBnGBdhIM=;
        b=QabHBT9ixMEqahfOYPegEBAmyLmE2miTWoIT+H4MlNI2+9X2H+4fBvyiHZ7wNb0FkMJDs6
        rGolCIhShzMPZpV9pdv8WA+W30M8Imp2fFVw9vrf82/wb9For/T3OvYf+LSHuikt+F33sz
        RYg2jP4n7femyuqM4GcRExz6qMHy6Qo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ew399TRR9yra; Tue,  4 Jul 2023 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688462551; bh=G2ELpD9uAx110G37H+EcPaBIW7h/0XMkeqrBnGBdhIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoXVUBQDiNPTICOoa1cqfRJJ/qVEdOgyLn4wz5iddUSZklhLhnsBQajwyZg7iJar8
         Rr//erD8SD0/daGVQZETFEjiBezPEpfmMUsX6cJvZJPsnQFdzwpTZHTUd2KDZO6EkT
         m/X0PkUDnUaQvVSzsFC2/UBWCIZv8jPnFzxyvKJKRrOpL3gNbM8Auv/RyCPPwhfd2S
         0UMZqTxt2JWmBxr5nXzFAjP8PFMfZ3QKlBJM93/UWuN/a+1Oh3Is5AKZxzFooGDgoa
         jwuHj7Lk8gxb26N6Uo9TcpIRAU6U1bl8LGk5nbVXHWZNkBNc1OpIcuWKrinyLJQ36j
         yv5aD8W9gKHUe0PYFXHFNjpiOzxAKbJc2eaYCRNZKgc8fzOWh4GIEdIPRFOIDF1OYf
         20yxbMG22e88vKowRTfikKtbG8MxIAb38Tej5Pe8IEDCnsdOJUgahYT1EIekoMOdQs
         i/ohpSrdml8avRXMAk7t2wnGh3f3/FZFhw4mTHIZREnHDxkH9kXoEMDgSM6QlMjuyU
         GapwKjz8hvKICNREKJtifbKGVdwg64fixaB7f3S+o6y0HpiSO5J3q28FoDa1PdC0hU
         CObKwUpgCWgECPTN79iFXtO6jDQ3y33ToOXL6O6HBe9Ib2q4H8xh0bd2R9hk7RUhTv
         LTE/deUf5lNBSd5PbPBrzaio=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1EFE40E0033;
        Tue,  4 Jul 2023 09:22:27 +0000 (UTC)
Date:   Tue, 4 Jul 2023 11:22:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230704090132.GP4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:01:32AM +0200, Peter Zijlstra wrote:
> So they are normal MSRs like all other? AMD doesn't have any exceptions
> for MSRs, they all the same?

Yap, as far as I know.

> Dunno, code density, speculation, many raisons to avoid jumps :-)

Looking at x2apic_send_IPI asm:

	cmpb	$2, boot_cpu_data+1(%rip)	#, boot_cpu_data.x86_vendor
# arch/x86/kernel/apic/x2apic_phys.c:44: 	u32 dest = per_cpu(x86_cpu_to_apicid, cpu);
	movq	__per_cpu_offset(,%rdi,8), %rdx	# __per_cpu_offset[cpu_7(D)], __per_cpu_offset[cpu_7(D)]
	movzwl	(%rdx,%rax), %edx	# *_8,
# ./arch/x86/include/asm/processor.h:753: 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
	je	.L114	#,
# ./arch/x86/include/asm/processor.h:754: 		asm volatile("mfence; lfence" : : : "memory");
#APP
# 754 "./arch/x86/include/asm/processor.h" 1
	mfence; lfence

So gcc already does mix unrelated insns so that they can all go in
parallel. So it is a

	CMP RIP-relative
	JE

So yeah, I guess, on the one hand we want to avoid conditional jumps
but, on the other, sprinkling alternatives everywhere without a good
reason is a waste. Especially if this branch is going to be
predicted-taken most of the time and it wouldn't matter.

So I'm still not convinced. We could measure it on my Coffeelake box
which says

"Switched APIC routing to cluster x2apic."

but I don't think it'll be visible.

> > > 	asm volatile (ALTERNATIVE("mfence; lfence;", "", X86_FEATURE_AMD));
> > 
> > There's no X86_FEATURE_AMD :)
> 
> I know, but that's easily fixed.

Yeah, there's X86_VENDOR_AMD too. I can see the confusion ensue.

I'm wondering if we could make:

	alternative("mfence; lfence;", "", X86_VENDOR_AMD);

work...

Might come in handy in the future.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
