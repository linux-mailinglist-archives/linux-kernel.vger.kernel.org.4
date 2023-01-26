Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2162E67D3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjAZSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:09:39 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4E3BD8A;
        Thu, 26 Jan 2023 10:09:38 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m8so1108162ili.7;
        Thu, 26 Jan 2023 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mIhkIOnk5xRNK1gaTSR7Ga2LMM8NeLUfAfr1aFbrekg=;
        b=Ni9lB06pk671LpQ6eLVT0cQhMQujSK07AM1fx9R1XAQ6neifK9u98sVFxBAjIOMFhv
         /6XbM/hbUFB7iFZd/xGaJ7RQL7Z6axBZOZWL+Udtb8RDMxJln3o4x5cg8vPMa7nb6Q9N
         +gS0fCl2ocTfyiQ9E3hfhvDvXpJl4yhHLFydNMtm5p88g8Np5h5A0p+tFsyZaF4AqMwQ
         NbD+zHJ2ejeuEjuhr/d/RRjs4FjppjyBNDdu/ujEDls8WTUKnaTlG3aoPKV2KErWIwyq
         s/yneVX+8Lc4abjEPbzhVag58pBwmAwOo3X0bEq3CbJPRysu8GeYhKgNORMCOxZztSQj
         qh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIhkIOnk5xRNK1gaTSR7Ga2LMM8NeLUfAfr1aFbrekg=;
        b=rj6rELBD3Z0V8xK9XCcfLoLRMojtoQv6CCmmFh7ZYjIj1pCy8kZP1zKO97KWniqsRr
         sPNuJUqiwKsLG9Y2RiI97zdg0AfovuGomBzEsdzJLp8kT/WwMUfEjP1iYf4D3dFKcOxY
         I+xEQ2tQfF++vJfeqIuVxFo4P/+FcV1TFVnxS4u3+nLwr4zfxvLGF5bJvxLre1Srs7YF
         NHjoO7ta4R3A0pLaBFc0Eo4pHO115K+e4F8cCpAaG8K9ywNCUKwGroCKUxqhImdmy8ow
         FpSczogfCsm8S2gGM3m6Sqz4BSGKJ69O8je9yMQ2m7HlM/qn20FcVRL5wla3c8wUtskT
         s8Dw==
X-Gm-Message-State: AFqh2kofxHkWlwYkrZMloYKI0xN8laPB+imHkKNXqK4TBUYe3+VBpQqL
        To7q7HLoR5+/2dkHFSD7fhWGW//Pm8ffsYvjzzujMS2fm16ZKA==
X-Google-Smtp-Source: AMrXdXurTWskMh44Ym2lZpC/9CXkF/1j2i0K6HUujRhQDXbazTWSURdDHfPyRdf/yZfaGyi30mAFuQW94kBkPnLKDc0=
X-Received: by 2002:a05:6e02:11a7:b0:30f:4eb8:1c87 with SMTP id
 7-20020a056e0211a700b0030f4eb81c87mr2922886ilj.141.1674756577869; Thu, 26 Jan
 2023 10:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com> <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com> <Y9IPCpYzfGb6k0sF@memverge.com>
In-Reply-To: <Y9IPCpYzfGb6k0sF@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 26 Jan 2023 10:09:26 -0800
Message-ID: <CANaxB-yBYEjzYdZC5jUaeO2f1YZWHHpYvGsc-9qHX3KqzUmxVQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:26 PM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Wed, Jan 25, 2023 at 08:54:48PM -0800, Andrei Vagin wrote:
> > On Wed, Jan 25, 2023 at 4:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 01/24, Gregory Price wrote:
> > > >
> > > > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > > > modify Syscall User Dispatch to suspend interception when enabled.
> > > >
> > > > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > > > SECCOMP interposition.  Without doing this, software like CRIU will
> > > > inject system calls into a process and be intercepted by Syscall
> > > > User Dispatch, either causing a crash (due to blocked signals) or
> > > > the delivery of those signals to a ptracer (not the intended behavior).
> > >
> > > Cough... Gregory, I am sorry ;)
> > >
> > > but can't we drop this patch to ?
> > >
> > > CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> > > config->mode anyway as we discussed.
> > >
> > > Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> > > with the same effect, no?
> >
> > Oleg,
> >
> > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is automatically cleared when
> > a tracer detaches. It is critical when tracers detach due to unexpected
> > reasons
> > (crashes, killed by oom, etc). In such cases, we want to be sure that a
> > tracee will continue
> > running from the point where it has been trapped.
> >
> > Thanks,
> > Andrei
>
> There might be a better place for the full C/R discussion, but it's worth
> the extra context to hash out the SUSPEND flag.
>
> The relevant kernel code i'm concerned about:
>
> static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>         unsigned long work)
> {
>   long ret = 0;
>   /* ... snip ... do syscall user dispatch */
>   if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
>     if (syscall_user_dispatch(regs))
>       return -1L;
>    }
>
>   /* Handle ptrace */
>   if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>     ret = ptrace_report_syscall_entry(regs);
>     if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
>       return -1L;
>   }
>
>   /* Do seccomp after ptrace, to catch any tracer changes. */
>   if (work & SYSCALL_WORK_SECCOMP) {
>     ret = __secure_computing(NULL);
>   }
>         /* ... snip ... */
> }
>
> The problem i'm seeing with PTRACE_O_SUSPEND_SUD is that SUD comes before
> ptrace, while Seccomp comes after.
>
> CRIU seems to use a few different methods to quiesce:
> * ptrace syscall entry traps
> * breakpoints (on sigreturn it seems)

I don't understand why it matters here. If we have
PTRACE_O_SUSPEND_SUD, all these actions
happen when the flag is set and so syscall_user_dispatch always
returns 0 and we reach ptrace
hooks.

If we don't have PTRACE_O_SUSPEND_SUD, we need to disable SUD after attaching to
a process or we need to inject our code into the region that is not under SUD.

> * masking everything but SIGSTOP and waiting for a STOP

I am not sure that I understand what part of criu you refer to here.

>
> SUD represent an issue in all three cases
> * syscall dispatch preempts ptrace traps (though syscalls may come
>   from the exclusion area, so it should hit eventually)
> * sigreturn can be changed (glibc prevents this, but the raw sigaction
>   syscall will take whatever address you give it

CRIU sets breakpoints into the parasite code that is part of the criu
code base and it is under
our control. Second, the parasite code doesn't use libc calls.

> * masking SIGSYS crashes a program on next dispatch if SUD is enabled
>

This is right and criu should not trigger dispatched syscalls ;)

Thanks,
Andrei
