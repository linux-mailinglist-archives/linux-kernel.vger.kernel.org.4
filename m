Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77C678184
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjAWQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAWQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:33:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07ADA2B2A3;
        Mon, 23 Jan 2023 08:33:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B2CC14;
        Mon, 23 Jan 2023 08:33:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285B33F5A1;
        Mon, 23 Jan 2023 08:33:06 -0800 (PST)
Date:   Mon, 23 Jan 2023 16:32:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y862t2Kw5tKRg9OH@FVFF77S0Q05N>
References: <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org>
 <Y8mwF0m+M1+e/fz/@eldamar.lan>
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
 <Y8oNTkUVDr7iQWzp@uudg.org>
 <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
 <Y8qOOxON9Vfsek0l@uudg.org>
 <Y8q1P8NUJYIxd1Tr@FVFF77S0Q05N>
 <Y8rctZK+QxmRNHqg@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rctZK+QxmRNHqg@uudg.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:25:57PM -0300, Luis Claudio R. Goncalves wrote:
> On Fri, Jan 20, 2023 at 03:37:35PM +0000, Mark Rutland wrote:
> > On Fri, Jan 20, 2023 at 09:51:07AM -0300, Luis Claudio R. Goncalves wrote:
> > > On Thu, Jan 19, 2023 at 08:49:28PM -0700, Jens Axboe wrote:
> > > > On 1/19/23 8:44?PM, Luis Claudio R. Goncalves wrote:
> > > > > On Thu, Jan 19, 2023 at 04:09:44PM -0700, Jens Axboe wrote:
> > > > >> On 1/19/23 2:03?PM, Salvatore Bonaccorso wrote:
> > > > >>> Hi Luis, all,
> > > > >>>
> > > > >>> On Thu, Jan 19, 2023 at 10:16:34AM -0300, Luis Claudio R. Goncalves wrote:
> > > > >>>> On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
> > > > >>>>> Hi!
> > > > >>>>>
> > > > >>>>>>> I'm pleased to announce the 5.10.162-rt78 stable release.
> > > > >>>>>>>
> > > > >>>>>>> You can get this release via the git tree at:
> > > > >>>>>>>
> > > > >>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > > > >>>>>>>
> > > > >>>>>>>   branch: v5.10-rt
> > > > >>>>>>>   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> > > > >>>>>>>
> > > > >>>>>>> Or to build 5.10.162-rt78 directly, the following patches should be applied:
> > > > >>>>>
> > > > >>>>>> I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
> > > > >>>>>> Any pointers on what maybe wrong?
> > > > >>>>>
> > > > >>>>> We see the same failure. 
> > > > >>>>>
> > > > >>>>>>   AS      arch/arm64/kernel/entry.o
> > > > >>>>>> arch/arm64/kernel/entry.S: Assembler messages:
> > > > >>>>>> arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
> > > > >>>>>> make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
> > > > >>>>>> make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
> > > > >>>>>> make: *** [Makefile:1837: arch/arm64] Error 2
> > > > >>>>>
> > > > >>>>> The line is:
> > > > >>>>>
> > > > >>>>>>        and     x2, x19, #_TIF_WORK_MASK
> > > > >>>>
> > > > >>>> I believe this is related to the arch/arm64/include/asm/thread_info.h
> > > > >>>> changes in 5.10.162-rt78, specifically:
> > > > >>>>
> > > > >>>>     79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
> > > > >>>>     1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt
> > > > >>>>
> > > > >>>> The first one is the original change, coming from stable v5.10.162 and the
> > > > >>>> second one has the merge conflict I fixed in that file due to the existence
> > > > >>>> of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.
> > > > >>>>
> > > > >>>> It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
> > > > >>>> statement reported above. Looking at
> > > > >>>>
> > > > >>>>     b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()
> > > > >>>>
> > > > >>>> specially this note
> > > > >>>>
> > > > >>>>     To ensure that _TIF_WORK_MASK can be used as an immediate value in an
> > > > >>>>     AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
> > > > >>>>     renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
> > > > >>>>
> > > > >>>> I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
> > > > >>>> to 8, with the risk of breaking something else, or backport commit
> > > > >>>> b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
> > > > >>>> TIF_NEED_RESCHED_LAZY.
> > > > >>>>
> > > > >>>> Guidance is welcome here :)
> > > > >>>
> > > > >>> Should we loop in here Jens, as having some overview of the needed
> > > > >>> changes for io_uring rebase in the 5.10.y version? (doing so in the
> > > > >>> mail).
> > > > >>
> > > > >> Huh that's funky, I built and (runtime) tested this on arm64
> > > > >> specifically. But I do remember some details about the first 8 bits on
> > > > >> arm, but not arm64.
> > > > >>
> > > > >> I guess we need to twiddle that asm to deal with eg 16 bits, rather than
> > > > >> attempt to backport any TIF removal patches.
> > > > > 
> > > > > One simple solution, tested with defconfig plus FTRACE options (including
> > > > > FTRACE_SYSCALLS) enabled, is:
> > > > > 
> > > > > diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> > > > > index 6eb36a2126e8..37f19bb49d38 100644
> > > > > --- a/arch/arm64/include/asm/thread_info.h
> > > > > +++ b/arch/arm64/include/asm/thread_info.h
> > > > > @@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
> > > > >  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
> > > > >  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
> > > > >  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> > > > > -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> > > > > +#define TIF_NEED_RESCHED_LAZY	8
> > > > >  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> > > > >  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> > > > >  #define TIF_SECCOMP		11	/* syscall secure computing */
> > > > >  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> > > > > -#define TIF_NEED_RESCHED_LAZY	13
> > > > > +#define TIF_SYSCALL_TRACE	13	/* syscall trace active */
> > > > >  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> > > > >  #define TIF_FREEZE		19
> > > > >  #define TIF_RESTORE_SIGMASK	20
> > > > > 
> > > > > Would that be acceptable? With that we ensure the bits in
> > > > > _TIF_WORK_MASK are contiguous and within the 8 bits limit you
> > > > > mentioned. And TIF_SYSCALL_TRACE did not seem to have any (build)
> > > > > problem with the new value.
> > > > 
> > > > That should work too, the _TIF_WORK_MASK bits being in the lower 8 bits
> > > > is really all we should care about.
> > > 
> > > Jens, Salvatore, Mike, I ran a few tests and confirmed that the current asm
> > > code is not restricted to 8 bits. The problems is that there is a
> > > requirement for the mask bits to be contiguous in that specific context.
> > 
> > Just to confirm from the arm64 side, the instruction using this just requires
> > the bits to be contiguous, there's no restriction on *which* bits those are.
> 
> Thank you, that's really helpful!
>  
> > If you're going to mess around with the arm64 bits, please could you Cc someone
> > form the arm64 side? e.g. I fixed a similar issue in mainline in commit:
> > 
> >   870d16757ba8918c ("arm64: make _TIF_WORK_MASK bits contiguous")
> > 
> > ... and either Will Deacon or Catalin Marinas may have had comments as they're
> > the arm64 maintainers...
> 
> Just to avoid confusion here, this change is specific to the v5.10-rt, not
> applicable upstream nor to newer RT. We only saw the problem because
> TIF_NOTIFY_SIGNAL was mapped to a bit used by TIF_NEED_RESCHED_LAZY in
> v5.10-rt (the PREEMPT_RT changes on top of stable v5.10). This is why
> nobody from the arm64 side was copied initially, as we were trying to
> assert what was the problem.

Sure, and sorry, I think my reply came across a bit stronger than I intended. I
probably should have said something like: "please feel free to rope in one of
us from the arm64 side".

I know from experience that this area is fairly subtle, and I'd like to help to
ensure that the fix doesn't introduce a subtle breakage or interact poorly with
future backports.

> > > The explanation from commit b5a5a01d8e9a ("arm64: uaccess: remove
> > > addr_limit_user_check()") describes quite well our case:
> > > 
> > >      To ensure that _TIF_WORK_MASK can be used as an immediate value in an
> > >      AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
> > >      renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
> > > 
> > > My question is: do you prefer renumbering the bits or the neat asm hack
> > > that Mike proposed? 
> > 
> > I would strongly recommend renumbering the bits over changing the asm. That's
> > going to be closer to what mainline has already done, and it avoids introducing
> > weird ifdeffery.
> > 
> > That said, rather than swapping TIF_SYSCALL_TRACE and TIF_NEED_RESCHED_LAZY,
> > you could just shuffle the bits down-by-one, keeping all the existing
> > contiguity, e.g.
> > 
> > 	#define TIF_NEED_RESCHED_LAZY    8
> > 	#define TIF_SYSCALL_TRACE        9
> > 	#define TIF_SYSCALL_AUDIT        10
> > 	#define TIF_SYSCALL_TRACEPOINT   11
> > 
> > ... and so on.
> 
> Would something like this be a good interpretation of your suggestion?
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 6eb36a212..2afd9ceb6 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> -#define TIF_SECCOMP		11	/* syscall secure computing */
> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> -#define TIF_NEED_RESCHED_LAZY	13
> +#define TIF_NEED_RESCHED_LAZY	8
> +#define TIF_SYSCALL_TRACE	9	/* syscall trace active */
> +#define TIF_SYSCALL_AUDIT	10	/* syscall auditing */
> +#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint for ftrace */
> +#define TIF_SECCOMP		12	/* syscall secure computing */
> +#define TIF_SYSCALL_EMU		13	/* syscall emulation active */

Yup, that looks god to me!

Thanks,
Mark.
