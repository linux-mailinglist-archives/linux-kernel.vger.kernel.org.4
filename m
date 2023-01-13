Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF6669E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAMQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjAMQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:43:08 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38063F62
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:41:30 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id bx24so548458uab.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6Lr+L/LblDc+yJNt4wnXXxJYLKQypjal3HX7Zk/JBs=;
        b=IQFN/OGInODCXa4DHXL6w34lhdPc1uMskQ5g7tFJ0oHfQYVPZoDjRMxAFWls6ofeWI
         Cc192jIOfJM4wAyYcKAzsILPmuH/oreySiel5v2C3xqH4k0ub7n9d9vDVs5g9waeUXgX
         kxFNOB1d1SEzSPi1CiaUfgjIUzSpfz0061je3FuODY/reLKaXtqBRgCCv2bNKGY0kgDu
         kg0ue1bkJsKsUnApNAYnZK2GQkeZzEiLoL3zVScbH/htfTDt4RbLoXpGVSjVF0K9pZkk
         M/oghv0bs48g7pHRF1czjSowPm9mhKnPNjFmkrPVvHGuHD6SMZykgiyvnpewOvDcA/mV
         eT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6Lr+L/LblDc+yJNt4wnXXxJYLKQypjal3HX7Zk/JBs=;
        b=CEaYqfxLa+YhzKVo6umS8ylkpJgSwmSLIOxswJsPOk+Yrj5tFN6AP8gOu1GpsQXN7y
         uCV3JNHD4Ehi299zMo2c2AeFJTOYTtI8HMAWVeWzwcTa/VH69rBjHv76xjnfDOMHj9d5
         /SJNDB1iI9U5w1YadqsizzSFcxWxevlM/5G+8SfbOKt4b3zvDUpl5lSvWeUmjrms5kxU
         XKJBsF7MDqVtSIY+RRa0oCeby8nPopHMCswrXR4jD4gcA5Sspim07hKkrHmTd44yFPX6
         AN9Z4YMUKo01s68UIxquudSodNeqPymj/vbg69aKGkShEGDeEkBgNsB10jiUNdSU1rl2
         S+GQ==
X-Gm-Message-State: AFqh2kqLGxD6shiek7yZ+eIVrNEGVTvYOZ80vtOYXStu8UCA9GV6GqLk
        R3glIf0las0k21IcH3JqTJDEs0fBkKKtaHxoO+9l7A==
X-Google-Smtp-Source: AMrXdXtVG2JMg8EoGuXDL5LQN7a3JNnSQdhfCX0+6p234rz4v8CaD7VeNzcirdl6I82sSO6ix0hQ+qTpmi9ko3osxlU=
X-Received: by 2002:ab0:3102:0:b0:5a4:c264:fb05 with SMTP id
 e2-20020ab03102000000b005a4c264fb05mr5531047ual.22.1673628089580; Fri, 13 Jan
 2023 08:41:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
 <Y8Fkjxsq5EOtGiql@casper.infradead.org> <CA+G9fYuahjaNs6ia1UOeF98hUhonAt0Z4YOFGcqOKt3J4tRvTw@mail.gmail.com>
 <Y8F+iKuJWAFsUg2m@casper.infradead.org>
In-Reply-To: <Y8F+iKuJWAFsUg2m@casper.infradead.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Jan 2023 22:11:18 +0530
Message-ID: <CA+G9fYsNyEttKsfMu5G+ZWA74HRp77ZOanom35ooFOpvVUgNbg@mail.gmail.com>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 at 21:23, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 09:14:15PM +0530, Naresh Kamboju wrote:
> > Hi Matthew,
> >
> > On Fri, 13 Jan 2023 at 19:32, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jan 13, 2023 at 06:53:01PM +0530, Naresh Kamboju wrote:
> > > > Linux next tag 20230113 boot failed on x86_64, arm64, arm and i386.
> > >
> > > Why are you still not running these stack dumps through
> > > scripts/decode_stacktrace.sh ?  That seems like it's much easier for you
> > > to do than expecting everybody who might be interested in investigating
> > > your reports to pull down enough of the build artifacts to make it work.
> >
> > Hope this will help you.
> >
> > # ./scripts/decode_stacktrace.sh vmlinux  < input.txt > output.txt
> >
> > stack dumps:
> > ------------------
> > [   15.945626] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > [   15.952588] #PF: supervisor read access in kernel mode
> > [   15.957720] #PF: error_code(0x0000) - not-present page
> > [   15.962850] PGD 8000000103213067 P4D 8000000103213067 PUD 103212067 PMD 0
> > [   15.969724] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   15.973909] CPU: 3 PID: 1 Comm: init Not tainted 6.2.0-rc3-next-20230113 #1
> > [   15.980869] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [   15.988336] RIP: 0010:do_wp_page (memory.c:?)
>
> Uh, are you compiling your kernels without debuginfo?

We have a large set of build combinations with and without debug info.

> The results
> from syzbot & 0day are much more useful:
>
> https://lore.kernel.org/linux-mm/Y8FnAwWOxLrfoWTN@casper.infradead.org/T/#u
>
> for an example.
>
> > [   16.087446] Call Trace:
> > [   16.089893]  <TASK>
> > [   16.091991] ? trace_preempt_off (??:?)
> > [   16.096087] ? __handle_mm_fault (memory.c:?)
> > [   16.100439] __handle_mm_fault (memory.c:?)
> > [   16.104617] handle_mm_fault (??:?)
> > [   16.108457] do_user_addr_fault (fault.c:?)
> > [   16.112642] exc_page_fault (??:?)
> > [   16.116394] asm_exc_page_fault (??:?)
> > [   16.120408] RIP: 0033:0x7fe169dbf31e
>
> > Call Trace:
> >  <TASK>
> >  wp_page_copy mm/memory.c:3047 [inline]
> >  do_wp_page+0x749/0x3880 mm/memory.c:3425
> >  handle_pte_fault mm/memory.c:4937 [inline]
> >  __handle_mm_fault+0x2183/0x3eb0 mm/memory.c:5061
> >  handle_mm_fault+0x1b6/0x850 mm/memory.c:5207
> >  do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1407
> >  handle_page_fault arch/x86/mm/fault.c:1498 [inline]
> >  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1554
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> > RIP: 0033:0x7f92c0e2df98
>
> See how much more useful that is?

From next time I will send regression email reports with decode_stacktrace.sh

For example:
Here is the decode stack trace from arm64 with filename and line number,

[    0.288009] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[    0.288618] Mem abort info:
[    0.288812]   ESR = 0x0000000096000006
[    0.289069]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.289427]   SET = 0, FnV = 0
[    0.289634]   EA = 0, S1PTW = 0
[    0.289851]   FSC = 0x06: level 2 translation fault
[    0.290181] Data abort info:
[    0.290382]   ISV = 0, ISS = 0x00000006
[    0.290640]   CM = 0, WnR = 0
[    0.290846] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000100931000
[    0.291273] [0000000000000008] pgd=0800000101910003,
p4d=0800000101910003, pud=0800000101911003, pmd=0000000000000000
[    0.292007] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[    0.292428] Modules linked in:
[    0.292639] CPU: 1 PID: 1 Comm: init Not tainted 6.2.0-rc3-next-20230113 #1
[    0.293100] Hardware name: linux,dummy-virt (DT)
[    0.293409] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.293874] pc : _compound_head (include/linux/page-flags.h:251)
[    0.294186] lr : do_wp_page (include/linux/rmap.h:156
mm/memory.c:3057 mm/memory.c:3425)
[    0.294443] sp : ffff80000803bbf0
[    0.294669] x29: ffff80000803bbf0 x28: ffff0000c02d0000 x27: 0000000000000a55
[    0.295140] x26: ffff0000c0980000 x25: ffff0000c0980000 x24: 0000000000000000
[    0.295621] x23: 0000000000000a55 x22: ffff0000c0932c60 x21: ffff0000c0932c60
[    0.296122] x20: 0000000000000000 x19: ffff80000803bd18 x18: 0000000000000000
[    0.296620] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000c1938400
[    0.297121] x14: ffff0000c0980000 x13: ffffdec19c918600 x12: 0000ffff86e83fff
[    0.297621] x11: 0000ffff86c86000 x10: 1fffe00018327081 x9 : ffffdec19c3ec4e8
[    0.298124] x8 : ffff80000803bb38 x7 : 0000000000000000 x6 : 0000000000000001
[    0.298624] x5 : ffffdec19dbbf000 x4 : ffffdec19dbbf2e8 x3 : 0000000000000000
[    0.299125] x2 : ffff0000c02d0000 x1 : ffff0000c02d0000 x0 : 0000000000000000
[    0.299627] Call trace:
[    0.299804] _compound_head (include/linux/page-flags.h:251)
[    0.300059] __handle_mm_fault (mm/memory.c:4937 mm/memory.c:5061)
[    0.300359] handle_mm_fault (mm/memory.c:5207)
[    0.300640] do_page_fault (arch/arm64/mm/fault.c:512
arch/arm64/mm/fault.c:612)
[    0.300909] do_mem_abort (arch/arm64/mm/fault.c:831)
[    0.301161] el0_da (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:516)
[    0.301379] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:659)
[    0.301684] el0t_64_sync (arch/arm64/kernel/entry.S:584)
[ 0.301952] Code: d65f03c0 d4210000 d503201f d503201f (f9400401)
All code
========
   0:* c0 03 5f              rolb   $0x5f,(%rbx) <-- trapping instruction
   3: d6                    (bad)
   4: 00 00                add    %al,(%rax)
   6: 21 d4                and    %edx,%esp
   8: 1f                    (bad)
   9: 20 03                and    %al,(%rbx)
   b: d5                    (bad)
   c: 1f                    (bad)
   d: 20 03                and    %al,(%rbx)
   f: d5                    (bad)
  10: 01 04 40              add    %eax,(%rax,%rax,2)
  13: f9                    stc

Code starting with the faulting instruction
===========================================
   0: 01 04 40              add    %eax,(%rax,%rax,2)
   3: f9                    stc
[    0.302379] ---[ end trace 0000000000000000 ]---
[    0.302718] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b

Thank you.

Best regards
Naresh Kamboju
