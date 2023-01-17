Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3066E7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjAQUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjAQUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:31:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E44FC3D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:17:37 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e10so22747813pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xgV/SZ8ETts0p/F1SYwIOGkOPAJK3JwasEqgPm/ua9k=;
        b=kxbltlCa5KiY2grjjE02ZlPoiDDLBMthuShIG5sqFiOtBMap+KYDWZYfjsUEIi5ioD
         OAXYZM1hCGqb4uqPwVpfm+vgJkx/3GI8i1rDazC2IEXMPwUFOZvWqyL9nJmWQpnnEPD5
         ZTv/LfN66Fkbj+tCTo3NizQDlvvT6wiBjYQ7zE85jP/MQzN5BD67dM2DzRhNE80vVwXy
         +7gtsYmLduOf5oBnWupdrlIAxXTJl1QrTVRS8toI9TR6HZz1jWBw3kwc4MGqPkjYfJCW
         UJINdxAE8fVN4RyRnGRiPS8Hw1W5goGXQUgK3Z/L50KeN0+ZbAxe5q1NOBz+PNd8L/RI
         iFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgV/SZ8ETts0p/F1SYwIOGkOPAJK3JwasEqgPm/ua9k=;
        b=v80Ei5WQyDDFuPH8RrY2xL4hETDymAN1RG71asTQ3Se4z+2QOHxekXeu2g5swRLOXj
         jT9DWyQpXanXHJnbwOJT5u1ChAyVf74I1rfRcmO//3JSO21C0ATmqm4SN+5DPNgkRRTa
         WkTbvAbuTwtX+qdS88azJZjkcKoxvOm06BMyTqnZQTakk4dmry410esnz9qBMIDE7IV4
         RVQPk4KpTo0DNRgWuP5nrNz7Yrvzm3Z0wrS1Ts2rPfEShZrubOJP5mf/Mouh9bcQE4AP
         tfXkaJWZ0ISqmvvieJupeWjE3Ff3fyrd29rRvP/8HidzVYMIScc3Arnr/ghpHb2gXfj1
         tKOg==
X-Gm-Message-State: AFqh2krwu1Wu78MkJOInK6ET/5mP4jcSGFiFZOxCbTDn5l4pQ2vvKgUy
        6uFosGSMmg74A/jv86+xZCwbwHjkjtNgHQPBaop7TQ==
X-Google-Smtp-Source: AMrXdXtDqOG5QlMZYECRdGHEBBMMBUt8IoqHQDP1z5Ql6csgodRoRX705ojQtoQ11raWmQ/0ncdWiOvUp9wWtR3tTU4=
X-Received: by 2002:a63:78a:0:b0:4ce:52b4:aff8 with SMTP id
 132-20020a63078a000000b004ce52b4aff8mr300030pgh.427.1673983047213; Tue, 17
 Jan 2023 11:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
 <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
 <CAKwvOdnCJmcGurUpHcdO44vVazz67jGDTXzug9LGv6C84xGmPw@mail.gmail.com> <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com>
In-Reply-To: <CAHk-=wjfmmYPw0wX1BW6gi_KAhdZi+81or024JFcRYHiQh-jpw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Jan 2023 11:17:15 -0800
Message-ID: <CAKwvOd=fcF=y-mBtPZ9QcVe++__jo11St4=+roPKrGh5D6FH_g@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        joao@overdrivepizza.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 17, 2023 at 10:26 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Jan 17, 2023 at 9:29 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Side note: that's not something new or unusual. It's been the case
> > > since I started testing clang - we have several code-paths where we
> > > use "unlikely()" to try to get very unlikely cases to be out-of-line,
> > > and clang just mostly ignores it, or treats it as a very weak hint. I
> > > think the only way to get clang to treat it as a *strong* hint is to
> > > use PGO.
> >
> > I'd be surprised if that were intentional or by design.
> >
> > Do you guys have a bug report we could look at?
>
> Heh. I actually sent you an example long ago. Let me go fish it out of
> my mail archives and quote some of it below so that you can find it in
> yours..
>
>               Linus
>
> [ Time passes. Found this email to you and Bill Wendling from Feb 16,
> 2020, Message-ID
> CAHk-=wigVshsByCMjkUiZyQSR5N5zi2aAeQc+VJCzQV=nm8E7g@mail.gmail.com ]:
>
>   Anyway, I'm looking at clang code generation, and comparing it with
>   gcc on one of my "this has been optimized to hell and back" functions:
>   __d_lookup_rcu().
>
>   It looks like clang does frame pointers, and ignores our
>   likely/unlikely annotations.
>
>   So this code:
>
>                 if (unlikely(parent->d_flags & DCACHE_OP_COMPARE)) {
>                         int tlen;
>                         const char *tname;
>                         ......
>
>   doesn't actually jump out of line, but instead generates the unlikely
>   case as the fallthrough:
>
>         testb   $2, (%r12)
>         je      .LBB50_9
>         ... unlikely code goes here...


Perhaps that was compiler version or config specific?

$ make LLVM=1 -j128 defconfig fs/dcache.o
$ llvm-objdump -d  --no-show-raw-insn
--disassemble-symbols=__d_lookup_rcu fs/dcache.o
0000000000003210 <__d_lookup_rcu>:
    3210:      endbr64
    3214:      pushq %rbp
    3215:      pushq %r15
    3217:      pushq %r14
    3219:      pushq %r12
    321b:      pushq %rbx
    321c:      testb $0x2, (%rdi)
    321f:      jne 0x32d7 <__d_lookup_rcu+0xc7>
...
    32d7:      popq %rbx
    32d8:      popq %r12
    32da:      popq %r14
    32dc:      popq %r15
    32de:      popq %rbp
    32df:      jmp 0x3300 <__d_lookup_rcu_op_compare>

That looks like what you want, yeah?

Your original report was from nearly 3 years ago; could have fixed a
few instances of branch weights not getting propagated since then.

What's going on in this case in this thread? I know we don't support
hot/cold attributes on labels yet, but if static_branch_likely (or
friends) is being used, we assign the indirect branches a 0%
likeliness/branch-weight.

>
>   and then the likely case ends up having unfortunate reloads inside the
>   hot loop. Possibly because it has one fewer free registers than gcc
>   because of the frame pointer.
>
>   I didn't look into _why_ clang generates frame pointers but gcc
>   doesn't. It may be just a compiler default, I think we don't end up
>   explicitly asking either way.
>
> [ And then Bill replied with this ]
>
>   It's not a no-op. We add branch probabilities to the IR, whether
>   they're honored or not depends on the transformation. But they
>   *should* be honored when available. I've seen in the past that instead
>   of moving unlikely blocks out of the way (like gcc, which moves them
>   below the function's "ret" instruction), LLVM will do something like
>   this:
>
>     <normal code>
>     <jmp to loop conditional test>
>         <unlikely code>
>         <more likely code>
>     <loop conditional test>
>     <...>
>
>   I.e. the loop is rotated and the unlikely code is first and the hotter
>   code is closer together but between the unlikely and conditional test.
>   Could this be what's going on? Otherwise, maybe clang decided that
>   it's not beneficial to move the code out-of-line because the benefit
>   was minimal? (I'm guessing here.)



-- 
Thanks,
~Nick Desaulniers
