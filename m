Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49551738938
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjFUPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjFUPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:31:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F291
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:31:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DA5035C00A0;
        Wed, 21 Jun 2023 11:31:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687361495; x=1687447895; bh=HJ
        zrcymNDK/30NtyNUALiWIqzreIddQyX3G4I6rsQh4=; b=wA1oD9SCppUkUOBsRB
        2O9j2IdxeO3T6qlF/M9ggnUDvMn7gbgy80q2B/NO4vJS+dVtjTK/bS6voLzF6QSp
        urx3PvTwrWEIZSk54zKRZqpiqn9Sg/uwFQ23eQg5HbykVHdbJbafJcoJtCKvL7EA
        +YvPlwnim3eHm7g1boRmRsiW9qvbdwNr6qyX/cQQvuxz9cqDnq42NGT0Ii9ez7PN
        drplFEs3d2IyihQ3IIDSEehYZtd7gbWNMCs2Re7LtmRQUESM2aah+Q+JUj0r1/QQ
        FmW9tCSBU/3t0bjcO0R+Iu1mRqX596fY9T7tId6fhWV2C1LqOb1Ng9bDwoVr7uIa
        otXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687361495; x=1687447895; bh=HJzrcymNDK/30
        NtyNUALiWIqzreIddQyX3G4I6rsQh4=; b=Dh84IE10gK3ubTGvWEgdMBh3HkFsA
        AOb1S2oH6rasvJCWw7I6ytNSdUxu8JgpjdqR32NDo7mePuPRsiz8m4+J+35tqfED
        bJgaqj1Sxc0Ro19WK38v26ALBM3PQ01Mmu7HqH85xWCkGCbP0RBlliXcme7bytiU
        PU9Ou1sFCAAWT3EAG8oM0i4BtygpoLYqcWfRdzKdreVaacflUO2W2tg3RHJk1VZ5
        LqFnQ3Q7W6vxgSEdNDIgom2P58MJXNa1+me8v8ibowsrWRSKTdHJo4D9EiU+jSp3
        hCR5REYGJx2DD2NZYhWBXHd1CxRrrGxzx+lO2V192tVSMTdrfolgAU3/A==
X-ME-Sender: <xms:1xeTZB-aQTubQv7pxOTKuL8O_C2o8qsK2DSjXs7nNdVchg9d5aXCsw>
    <xme:1xeTZFuV8GltP0BynVPsMrDHFldyhuHz-R_lNe0RECxRODul3AWkCh0V5x956g7Bb
    g2-za3-pDOV2ebDUTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkedujeffgeefveefueeggeegtedugeeufeeuffeifeeifefgkeeltdejhedu
    ueelnecuffhomhgrihhnpeguohgtkhgvrhdrihhopdhqvghmuhdrohhrghdplhhinhgrrh
    hordhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1xeTZPCx49JhC-aUe6kkpUh9y8lTIm_nP8donfvVSED78CeSPUZYFQ>
    <xmx:1xeTZFfP88pgVQQGpfzt803IsuUGxlVKTXvDFE4KD8VMegEN-Fd21g>
    <xmx:1xeTZGM2j0j8OkflDYEtElhfZm5nwYHH-rk6ehpHHQUWcJFPau0SDg>
    <xmx:1xeTZDp-qqJ2WUWctkFrxqfFIJzePzGyss5lbSapn_9RSuCHu5wpBQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73548B60089; Wed, 21 Jun 2023 11:31:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
In-Reply-To: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
Date:   Wed, 21 Jun 2023 17:31:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Benjamin Copeland" <ben.copeland@linaro.org>
Cc:     "Peter Zijlstra" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP tracing
 testing.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023, at 16:16, Naresh Kamboju wrote:
> Hi Team,
>
> FYI,
> qemu-x86_64 booting with 8.0.0 still see int3: when running LTP tracing testing.
>
> docker.io/linaro/tuxrun-qemu:v8.0.0 qemu-system-x86_64

Thanks for the report. I've added the x86 and kernel lists as well
as Peter Zijlstra to Cc.

> Running tests.......
> ftrace_regression01 1 TPASS: Finished running the test
> <4>[   49.874424] int3: 0000 [#1] PREEMPT SMP PTI
> <4>[   49.874634] int3: 0000 [#2] PREEMPT SMP PTI
> <4>[   49.874656] int3: 0000 [#3] PREEMPT SMP PTI
> <4>[   49.874669] int3: 0000 [#4] PREEMPT SMP PTI
> <4>[   49.874680] int3: 0000 [#5] PREEMPT SMP PTI
> <4>[   49.874691] int3: 0000 [#6] PREEMPT SMP PTI
> <4>[   49.874703] int3: 0000 [#7] PREEMPT SMP PTI
> <4>[   49.874714] int3: 0000 [#8] PREEMPT SMP PTI
> <4>[   49.874725] int3: 0000 [#9] PREEMPT SMP PTI

At first looked a bit like it's hitting on multiple CPUs, but 
I also see that the instance only has two CPUs, so apparently
this instance is hitting the same bug recursively from
the exception handler.

> <4>[   49.874736] int3: 0000 [#10] PREEMPT SMP PTI
> <4>[   49.874750] int3: 0000 [#11] PREEMPT SMP PTI
> <4>[   49.874761] int3: 0000 [#12] PREEMPT SMP PTI
> <4>[   49.874772] int3: 0000 [#13] PREEMPT SMP PTI
> <4>[   49.874783] int3: 0000 [#14] PREEMPT SMP PTI
> <4>[   49.874828] int3: 0000 [#15] PREEMPT SMP PTI
> <4>[   49.874894] int3: 0000 [#16] PREEMPT SMP PTI
> <4>[   49.874907] int3: 0000 [#17] PREEMPT SMP PTI
> <4>[   49.874918] int3: 0000 [#18] PREEMPT SMP PTI
> <4>[   49.874930] int3: 0000 [#19] PREEMPT SMP PTI
> <4>[   49.874941] int3: 0000 [#20] PREEMPT SMP PTI
> <4>[   49.874953] int3: 0000 [#21] PREEMPT SMP PTI
> <4>[   49.874964] int3: 0000 [#22] PREEMPT SMP PTI
> <4>[   49.874976] int3: 0000 [#23] PREEMPT SMP PTI
> <4>[   49.874987] int3: 0000 [#24] PREEMPT SMP PTI
> <4>[   49.874999] int3: 0000 [#25] PREEMPT SMP PTI
> <4>[   49.875010] int3: 0000 [#26] PREEMPT SMP PTI
> <4>[   49.875021] int3: 0000 [#27] PREEMPT SMP PTI
> <4>[   49.875032] int3: 0000 [#28] PREEMPT SMP PTI
> <4>[   49.875043] int3: 0000 [#29] PREEMPT SMP PTI
> <4>[   49.875054] int3: 0000 [#30] PREEMPT SMP PTI
> <4>[   49.875282] ------------[ cut here ]------------
> <4>[   49.875687] ------------[ cut here ]------------
> <2>[   49.875904] kernel BUG at kernel/entry/common.c:454!
> <4>[   49.876652] invalid opcode: 0000 [#31] PREEMPT SMP PTI
> <4>[   49.876845] CPU: 1 PID: 317 Comm: ftrace_regressi Not tainted
> 6.4.0-rc7-next-20230621 #1
> <4>[   49.876994] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> <4>[   49.877119] RIP: 0010:irqentry_nmi_enter+0x68/0x70
> <4>[   49.877756] Code: 48 8b 0d 7b 3a 6a 73 c7 81 88 08 00 00 00 00
> 00 00 85 c0 0f 95 c3 e8 27 02 00 00 e8 22 93 fe fe 89 d8 5b 5d c3 cc
> cc cc cc cc <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90
> <4>[   49.877929] RSP: 0000:fffffe3e79ab6ee8 EFLAGS: 00000046
> <4>[   49.878425] RAX: 0000000000000000 RBX: fffffe3e79ab6f58 RCX:
> 00000000fe00ffdb
> <4>[   49.878444] RDX: 00000000ffffa445 RSI: 0000000000000000 RDI:
> fffffe3e79ab6f58
> <4>[   49.878460] RBP: fffffe3e79ab6ef0 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   49.878475] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffa44502ab5a00
> <4>[   49.878490] R13: 0000000000000000 R14: 0000000000000000 R15:
> ffffab17000ccfd8
> <4>[   49.878540] FS:  00007f91069b4740(0000)
> GS:ffffa4457bd00000(0000) knlGS:0000000000000000
> <4>[   49.878579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   49.878596] CR2: ffffab17000ccfd8 CR3: 0000000102be8000 CR4:
> 00000000000006e0
> <4>[   49.878695] Call Trace:
> <4>[   49.878892]  <#DF>
> <4>[   49.879037]  ? __die_body+0x6c/0xc0
> <4>[   49.879123]  ? die+0xae/0xe0
> <4>[   49.879151]  ? do_trap+0x8d/0x160
> <4>[   49.879178]  ? irqentry_nmi_enter+0x68/0x70
> <4>[   49.879199]  ? handle_invalid_op+0x7f/0xd0
> <4>[   49.879213]  ? irqentry_nmi_enter+0x68/0x70
> <4>[   49.879237]  ? exc_invalid_op+0x36/0x50
> <4>[   49.879259]  ? asm_exc_invalid_op+0x1f/0x30
> <4>[   49.879316]  ? irqentry_nmi_enter+0x68/0x70
> <4>[   49.879344]  exc_double_fault+0x107/0x1b0
> <4>[   49.879416]  asm_exc_double_fault+0x23/0x30
> <4>[   49.879479] RIP: 0010:0xffffffffc00ac0ac

I don't know much about x86 exception handling, but my guess is
that this is where the stack overflows, so this backtrace
is not all that useful. Looking at the full log from your link,
I see that recursion through asm_exc_int3:

<4>[   49.886694]  ? exc_int3+0x62/0x80
<4>[   49.886714]  ? asm_exc_int3+0x3e/0x50
<4>[   49.886759]  ? preempt_count_sub+0x5/0x80
<4>[   49.886783]  ? preempt_count_sub+0x5/0x80
<4>[   49.886805]  ? irq_work_queue+0x40/0x80
<4>[   49.886826]  ? defer_console_output+0x49/0x80
<4>[   49.886840]  ? vprintk+0x42/0x60
<4>[   49.886857]  ? _printk+0x5d/0x80
<4>[   49.886891]  ? die+0x9c/0xe0
<4>[   49.886922]  ? exc_int3+0x62/0x80
<4>[   49.886942]  ? asm_exc_int3+0x3e/0x50
<4>[   49.886966]  ? __pfx_tick_sched_timer+0x10/0x10
<4>[   49.886980]  ? __pfx_read_tsc+0x10/0x10
<4>[   49.887010]  ? preempt_count_sub+0x5/0x80
<4>[   49.887035]  ? preempt_count_sub+0x5/0x80
<4>[   49.887057]  ? __hrtimer_run_queues+0xee/0x330
<4>[   49.887070]  ? _raw_spin_unlock_irqrestore+0x28/0x50
<4>[   49.887085]  ? __hrtimer_run_queues+0xee/0x330
<4>[   49.887136]  ? hrtimer_interrupt+0xf6/0x390
<4>[   49.887167]  ? __sysvec_apic_timer_interrupt+0x64/0x1a0
<4>[   49.887189]  ? sysvec_apic_timer_interrupt+0x7a/0x90
<4>[   49.887206]  </IRQ>
<4>[   49.887219]  <TASK>
<4>[   49.887231]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
<4>[   49.887252]  ? sched_rt_period_timer+0x4/0x390
<4>[   49.887272]  ? __pfx_do_sync_core+0x10/0x10
<4>[   49.887305]  ? insn_get_displacement+0x9/0x160
<4>[   49.887329]  ? insn_get_displacement+0x9/0x160
<4>[   49.887344]  ? insn_get_immediate+0xd2/0x270
<4>[   49.887365]  ? insn_decode+0x113/0x150
<4>[   49.887384]  ? text_poke_loc_init+0xea/0x220
<4>[   49.887429]  ? sched_rt_period_timer+0x4/0x390
<4>[   49.887451]  ? text_poke_queue+0x89/0xa0
<4>[   49.887477]  ? ftrace_replace_code+0x149/0x1f0
<4>[   49.887508]  ? ftrace_modify_all_code+0x71/0x140
<4>[   49.887533]  ? arch_ftrace_update_code+0xd/0x20
<4>[   49.887550]  ? ftrace_shutdown+0xf5/0x220
<4>[   49.887577]  ? unregister_ftrace_function+0x2e/0x150
<4>[   49.887608]  ? stack_trace_sysctl+0x82/0xb0
<4>[   49.887636]  ? proc_sys_call_handler+0x18b/0x280
<4>[   49.887675]  ? proc_sys_write+0x17/0x20
<4>[   49.887692]  ? vfs_write+0x324/0x3f0
<4>[   49.887742]  ? ksys_write+0x75/0xe0
<4>[   49.887771]  ? __x64_sys_write+0x1f/0x30
<4>[   49.887787]  ? do_syscall_64+0x48/0xa0
<4>[   49.887802]  ? sysvec_apic_timer_interrupt+0x4d/0x90
<4>[   49.887822]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
<4>[   49.887878]  </TASK>

This looks like a timer interrupt happens inside of
text_poke_loc_init(), i.e. while the kernel is modifying
itself, and presumably adding (or removing) an int3
instruction that is later hit inside of the timer function.

While our previous theory was that this was most likely
a qemu bug in dealing with self-modifying code, this might
actually hint at a problem in the kernel after all.

I think Peter understands this function best, he probably
sees more here than I do.

> Link:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17699662/suite/log-parser-test/tests/
>
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17699662/suite/log-parser-test/test/check-kernel-panic/log
>
> - Naresh

   Arnd
