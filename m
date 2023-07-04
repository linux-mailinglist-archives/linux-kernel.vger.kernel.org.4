Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FB746B02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGDHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGDHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:47:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372AD10F8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:46:50 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A1621EC05DE;
        Tue,  4 Jul 2023 09:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688456808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q4UeB1uLKeFEqAIkIfeG5wnUQ/u1Vgt6kJ8LoBaSEuw=;
        b=BRddrt/YuGajkoD+BJxFoNqYRcGJktbucBtHOHaAk9Wi6uYE5brAzHNOjGWGE/UfCjdpc0
        c+Uk4inITMcOEB2njO1/bcm9kuEHGkUvlph256pXu0bdiwk8KIPqNIV8rOkz9asRvhwkYC
        4LaMizjfCY7m+okT5ETef6aVsp/ySnA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZrSkZG91ZA_T; Tue,  4 Jul 2023 07:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688456800; bh=q4UeB1uLKeFEqAIkIfeG5wnUQ/u1Vgt6kJ8LoBaSEuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANshQ7I2d46nzfxmqLMq1BZxnCgzuXDbWxsqa7mpCvJCuOwwb8BQUbnNZt6NjxCjU
         XKSunDu0HypNXm553xsMoSlUNLwVa4Y11fGMoUx3PI60LgRQUixpR9USJNZ/8bGJ6C
         lc7nlx4jeUVK2gJH3VmeScT1+j1bnCta9V73zAObZyjIdoygQP/FMjOoOf9+wNGpb7
         iqmGTFAV038AFbX2s2qh5i7eMc9koFJ0J2bMdMEXpSKrSvAfGrYHMl878Uk84iiiUJ
         JaouYVHJnfnp8+hV2Lc8MHlSZvVm2Y6IhHrui+4c4rAcdvc4u6YxvDYifNtmR9SX1S
         8y1O9UsacXKtWg9encb6TP86oMVKDHtn6FVdPCPtMcTAgBR/VSkzp22sjlXdOuKlFL
         DYiE/EiNvNvXn5JTyzzaGB/hwABWW3RgYhogCvhEuH5FLd0hX/zuMwUYPbquAvqDXv
         aL1f4vU2WXSPJSOEmmyR5cyRaZzNR2yH5D2o7ZdJY1s8wHO25kHWLQNFPAevFMi539
         bQbhnD5EagfFhYNYBI4Sq5F4osSI6ONUDmzpey0yJkr0Jem0AMkbJnkVXuzBu9NeIU
         Lo031cTYTyY04GQ97kENzcS/zLWyTwzEz1xtLC+Rakl4GkNm+7cUOqWftCaNltkyx3
         yCcCvQr1ZltFAmZwgfVNO+pA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6565640E01EB;
        Tue,  4 Jul 2023 07:46:36 +0000 (UTC)
Date:   Tue, 4 Jul 2023 09:46:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 02:54:19PM +0200, Peter Zijlstra wrote:
> So you're saying that AMD tsc_deadline and x2apic MSRs *do* imply
> ordering constraints unlike the Intel ones?

Yah, that's the default situation. Only those two - TSC_DEADLINE and
x2APIC MSRs - and on *Intel* are special.

> Can we pls haz a document link for that, also a comment?

Why document the default? The SDM is already documenting this exception.
For everything else WRMSR is serializing.

> Moving this code while changing it meant I had to look at it _3_ times
> before I spotted you changed it :/

I figured it is a simple enough patch - no need to do a sole movement
one.

> Both instructions are 3 bytes, a 6 byte nop would be better, no?

Why? You wanna save the branch insn when sending IPIs through the
x2APIC? Does that really matter? I doubt it...

> 	asm volatile (ALTERNATIVE("mfence; lfence;", "", X86_FEATURE_AMD));

There's no X86_FEATURE_AMD :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
