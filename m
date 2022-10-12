Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4915FC9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJLRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJLRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:20:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F337F11A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08483B81B95
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B914C433D6;
        Wed, 12 Oct 2022 17:20:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ncFsUUsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665595242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCC8WU8fqHhCCL6BECSZHH7057yA7Q1m9CV8Moo+c9Q=;
        b=ncFsUUszG24nnTyYDSyMU8VotVZIDWXaXBjZfLsD9AlJDrGGkwE6HBUccYKTVHlPVXYMOg
        nmjuKL+yVHwTPKaNwTCdjq+mEBtf8qEh8UDZLsqRKsWcjmGnhqOCxge4nfV0V2bHevYgM/
        23vCymkwRA426m4pGDhnGLva5m8IQ80=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a567209d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Oct 2022 17:20:42 +0000 (UTC)
Date:   Wed, 12 Oct 2022 11:20:38 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <Y0b3ZsTRHWG6jGK8@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012164452.GA2990467@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:44:52AM -0700, Guenter Roeck wrote:
> On Wed, Oct 12, 2022 at 09:49:26AM -0600, Jason A. Donenfeld wrote:
> > On Wed, Oct 12, 2022 at 07:18:27AM -0700, Guenter Roeck wrote:
> > > NIP [c000000000031630] .replay_soft_interrupts+0x60/0x300
> > > LR [c000000000031964] .arch_local_irq_restore+0x94/0x1c0
> > > Call Trace:
> > > [c000000007df3870] [c000000000031964] .arch_local_irq_restore+0x94/0x1c0 (unreliable)
> > > [c000000007df38f0] [c000000000f8a444] .__schedule+0x664/0xa50
> > > [c000000007df39d0] [c000000000f8a8b0] .schedule+0x80/0x140
> > > [c000000007df3a50] [c00000000092f0dc] .try_to_generate_entropy+0x118/0x174
> > > [c000000007df3b40] [c00000000092e2e4] .urandom_read_iter+0x74/0x140
> > > [c000000007df3bc0] [c0000000003b0044] .vfs_read+0x284/0x2d0
> > > [c000000007df3cd0] [c0000000003b0d2c] .ksys_read+0xdc/0x130
> > > [c000000007df3d80] [c00000000002a88c] .system_call_exception+0x19c/0x330
> > > [c000000007df3e10] [c00000000000c1d4] system_call_common+0xf4/0x258
> > 
> > Obviously the first couple lines of this concern me a bit. But I think
> > actually this might just be a catalyst for another bug. You could view
> > that function as basically just:
> > 
> >     while (something)
> >     	schedule();
> > 
> > And I guess in the process of calling the scheduler a lot, which toggles
> > interrupts a lot, something got wedged.
> > 
> > Curious, though, I did try to reproduce this, to no avail. My .config is
> > https://xn--4db.cc/rBvHWfDZ . What's yours?
> > 
> 
> Attached. My qemu command line is

Okay, thanks, I reproduced it. In this case, I suspect
try_to_generate_entropy() is just the messenger. There's an earlier
problem:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is .__flush_tlb_pending+0x40/0xf0
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-28380-gde492c83cae0-dirty #4
Hardware name: PowerMac3,1 PPC970FX 0x3c0301 PowerMac
Call Trace:
[c0000000044c3540] [c000000000f93ef0] .dump_stack_lvl+0x7c/0xc4 (unreliable)
[c0000000044c35d0] [c000000000fc9550] .check_preemption_disabled+0x140/0x150
[c0000000044c3660] [c000000000073dd0] .__flush_tlb_pending+0x40/0xf0
[c0000000044c36f0] [c000000000334434] .__apply_to_page_range+0x764/0xa30
[c0000000044c3840] [c00000000006cad0] .change_memory_attr+0xf0/0x160
[c0000000044c38d0] [c0000000002a1d70] .bpf_prog_select_runtime+0x150/0x230
[c0000000044c3970] [c000000000d405d4] .bpf_prepare_filter+0x504/0x6f0
[c0000000044c3a30] [c000000000d4085c] .bpf_prog_create+0x9c/0x140
[c0000000044c3ac0] [c000000002051d9c] .ptp_classifier_init+0x44/0x78
[c0000000044c3b50] [c000000002050f3c] .sock_init+0xe0/0x100
[c0000000044c3bd0] [c000000000010bd4] .do_one_initcall+0xa4/0x438
[c0000000044c3cc0] [c000000002005008] .kernel_init_freeable+0x378/0x428
[c0000000044c3da0] [c0000000000113d8] .kernel_init+0x28/0x1a0
[c0000000044c3e10] [c00000000000ca3c] .ret_from_kernel_thread+0x58/0x60

This in turn is because __flush_tlb_pending() calls:

static inline int mm_is_thread_local(struct mm_struct *mm)
{
        return cpumask_equal(mm_cpumask(mm),
                              cpumask_of(smp_processor_id()));
}

__flush_tlb_pending() has a comment about this:

 * Must be called from within some kind of spinlock/non-preempt region...
 */
void __flush_tlb_pending(struct ppc64_tlb_batch *batch)

So I guess that didn't happen for some reason? Maybe this is indicative
of some lock imbalance that then gets hit later?

I've also managed to not hit this bug a few times. When it triggers,
after "kprobes: kprobe jump-optimization is enabled. All kprobes are
optimized if possible.", there's a long hang - tens seconds before it
continues. When it doesn't trigger, there's no hang at that point in the
boot process.

Jason
