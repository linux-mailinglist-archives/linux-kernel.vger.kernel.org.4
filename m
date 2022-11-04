Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF361A036
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKDSp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:45:24 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEA1159
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:45:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13bd19c3b68so6466447fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NV83KxWMCgm8d3lX6N2XD/X3pgMPbPFqLyrnekZ5Vg=;
        b=HDRUAGmsW4DaW/5fSzLojMSlrIkg313/GFUpXTW7swvA/QRWKbG2ZmjsLPt4LRKmuy
         Wza/0J8D3X5U/0RQl0MidHZVQJkyyNNUtclmE1s9IHdqCpCU/94ztUjY8BVPrNrQpB0L
         EJYCTuDiCED9VaXXXKRAmCedwwgpN14zOCB193e9dxGJoIADdQdVje1jD8sxWcNTTWPG
         S8dxY5yq2hk4vpIMB2si3QMSfWUxwY6atrD+kxQDT/GENPS8fgxUgYs7kP1PfFtwY1gf
         jv/Rhxqsdf/w28Y7RQE/klgJYCo90ZSoLeNcqEkgtmybBb79ESiNZV5ScQg54owl+Adf
         71Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NV83KxWMCgm8d3lX6N2XD/X3pgMPbPFqLyrnekZ5Vg=;
        b=gJmcOwygLwo185jfSuTpVYHJWUNwKCmut+aIQ7oCGkWClrgu/PUIe45I05yNGaaT4f
         Sufjz3AiqfoUvY2f+CI4370Hkxb3C9Y+OSq9qCnLOsdFLGwjYRuxA81dQKh/8aSejrvW
         vzy/D8hSZYer4ylbZ69ztse4CG0oisZHu5aKmxm9Hiw3QUs4fjyaHf+u7F5K+2O8/g3v
         n2xAsiZyizEEYyF97eoWJqxeCrweAFoL3o2SBfefU4sYDrFD5Ccz1yLkAc7XwQwPdt9E
         eQrWI/TMqTM1UD4EtQR7Vjkus1P3MZSqPtcVa31xtP3LJr0GM677nAOjU/rla8bfV6YX
         Cd/A==
X-Gm-Message-State: ACrzQf1e4FvSrmC3UN4wbPRECFiGOiRWoUP5jcE0mjXyNmXGuAVeXk9f
        CELv9QHz9DuZeWDZJpSPWSu+PFcChVI6+SNp/sALDw==
X-Google-Smtp-Source: AMsMyM7z85luj2jGHkQ4A1IWTeq7E/bHmTY5vvKW7ynS9rCmnL0o5zTu09Dm128CdPqQb+5ogZTinuZgOk73wu91Vuo=
X-Received: by 2002:a05:6870:b6a3:b0:13b:f4f1:7dec with SMTP id
 cy35-20020a056870b6a300b0013bf4f17decmr22509706oab.282.1667587521720; Fri, 04
 Nov 2022 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000035fba305eca64106@google.com> <Y2UvigDr9ctxlEEE@google.com>
 <CACT4Y+Zb0T4bPk=gzYtexPqHTGSFAHaeY6DCYq268GV4+TM+gQ@mail.gmail.com>
 <Y2U+8cM9z0axes2y@google.com> <Y2VOU96gcoor288M@google.com>
 <CACT4Y+Y6A0wooT1ua9qcoGuRBV9nF5sfF4q3-tSs3y+AqnGvfA@mail.gmail.com> <Y2Vcvf2AiUJ5jCVf@google.com>
In-Reply-To: <Y2Vcvf2AiUJ5jCVf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 11:45:10 -0700
Message-ID: <CACT4Y+ZUiiKNH56QM-JAy0ykh1fJ+CJ-k-aMcWD1euTbviKcwQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in get_desc
To:     Sean Christopherson <seanjc@google.com>
Cc:     syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>,
        bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
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

On Fri, 4 Nov 2022 at 11:41, Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > On Fri, 4 Nov 2022 at 10:39, 'Sean Christopherson' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Fri, Nov 04, 2022, Sean Christopherson wrote:
> > > > On Fri, Nov 04, 2022, Dmitry Vyukov wrote:
> > > > > On Fri, 4 Nov 2022 at 08:28, 'Sean Christopherson' via syzkaller-bugs
> > > > > <syzkaller-bugs@googlegroups.com> wrote:
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> > > > > > >
> > > > > > > BUG: unable to handle page fault for address: fffffbc5a1c22e00
> > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
> > > > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > > > CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > > > RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
> > > > > >
> > > > > > I'm pretty sure this is the same thing as
> > > > > >
> > > > > >   BUG: unable to handle kernel paging request in vmx_handle_exit_irqoff
> > > > > >
> > > > > > I'll verify and get a patch posted shortly.
> > > > >
> > > > > This repro does not create any VMs, it's just:
> > > > >
> > > > > iopl(0x3)
> > > > > rt_sigreturn()
> > > > >
> > > > > Do you still think it's related to the vmx_handle_exit_irqoff issue?
> > > >
> > > > Yes, the issue is that the shadow for the read-only IDT mapping in the CPU entry
> > > > area isn't populated (commit 9fd429c28073 ("x86/kasan: Map shadow for percpu pages
> > > > on demand") is to blame).  The bug manifests anytime software manually does an IDT
> > > > lookup.
> > >
> > > Hrm, but the lookup is into the GDT, not the IDT, and I haven't been able to reproduce
> > > this one.  I'll leave it open for now.
> >
> > The repro calls rt_sigreturn() w/o actually setting up the signal
> > frame (mcontext, etc). So I assume the kernel will restore completely
> > bogus/random user-space mcontext. The data it reads from the stack may
> > be uninit or depend on the compiler, etc.
> >
> > As the result it should get completely random segment selector here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/x86/lib/insn-eval.c?id=81214a573d19ae2fa5b528286ba23cd1cb17feec#n725
> >
> > Can it be out-of-bounds or something?
>
> The lookup is on CS.base (I trimmed the stack in my first reply) as part of the
> IOPL emulation to see if userspace is attempting CLI or STI, so it's not related
> to the sigframe.
>
>   insn_get_seg_base arch/x86/lib/insn-eval.c:725 [inline]
>   insn_get_effective_ip+0x187/0x1f0 arch/x86/lib/insn-eval.c:1476
>   fixup_iopl_exception+0xd0/0x190 arch/x86/kernel/traps.c:627
>   __exc_general_protection arch/x86/kernel/traps.c:752 [inline]
>   exc_general_protection+0x176/0x210 arch/x86/kernel/traps.c:728
>   asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:564
>  RIP: 0003:0x7f250f3abf8c
>
> It does look like some form out out-of-bounds selector though.  The offset in the
> splat suggests CS.sel is something way above __USER_CS, which would explain why
> insn_get_effective_ip() is doing a lookup in the first place (CS.base is assumed
> to be 0 if userspace is in 64-bit mode, user_64bit_mode() is true if CS == __USER_CS)),
> I just can't figure out how that tiny reproducer is getting a bad CS.  And the above
> RIP strongly suggests userspace is indeed in 64-bit mode.

My understanding is that rt_sigreturn() restores complete user context
from the info stored on the stack.
Normally signal delivery will store that info on the stack first. But
in this case there is no signal delivery, so rt_sigreturn() reads
complete garbage from the stack and restores it into the context. I
assume this can setup any non-sense CS and maybe even pretend this is
not normal x86_64 mode (?).
