Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF46F211D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbjD1XPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjD1XPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:15:15 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFF49F5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:15:11 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4404923f23eso132135e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682723710; x=1685315710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7e+nHIFuatwbcI4DP4dA/OyvxyUcowK6zncEM6+Pks=;
        b=P9jhqDu3YaYzF3pT8VcdPgqFP0doNyCstqibqAjicK8T5z70VxhfPgONi5P0DyaiAl
         pJHyqJXRp1fHghOc15pA44/LdK0BFEM7+vsNzEzbOmv9oXVozou5y06qH5KluGGxnd+e
         qudNj6JUOTEBtbHk/AMuhcYh4wGgfbkehI44Z6WaUX/yravhpTRsoz46GKgwNU7e/VHm
         jnqkhzG72ENJHm0+Nq56WETZAwdhe1UvlC2p1GsXZlN2zu941MGB8TJ7KRFAUwFNhhh3
         vTbCOF4Sw8olfMPqvsCBYFPNPzR906RHFsLIG/0lV+YY3Lnt83t6mKHOjeO6qhTyojCH
         C4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682723710; x=1685315710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7e+nHIFuatwbcI4DP4dA/OyvxyUcowK6zncEM6+Pks=;
        b=K1zr2gP1UV+V9Xum1LGbb4stzZpU6miaFdFQns5HWn8BVgsbttRzzkI3KyEeeSgzNq
         lv5xUI2UJMSamckzH1pRLWywB7sTDO8XV0kOvwpaNNOQO1jWZDFi+cctwlFxJ9hZfOOB
         jJdsZlm7yJSk4bfT3hgj/CYnTqn1n5pjx/EbNK1Jg1VKCuo+JYK2dM+jR2bIaffdws3j
         RBGlD+Ni/Y2C+gqluIKACakqMBtybJLdlo9+ucjh1zcHb0IulA/UCp5tOAKDCKAAWUwh
         KmiPYItK2MwLIVPpNwj7u7aRb4tq4sjZTe2gmcAQlGYylHDBMDdNra09EWROWsuKfVZ1
         sRPQ==
X-Gm-Message-State: AC+VfDw5WAdNoLMY5WEV/hWYVvCVj0YW7UVv990rV3RGwEq84Nm6WFs2
        NeNWDyrboDNo2B1HKPiOAwlToy4JBsIohR+UMN58oQ==
X-Google-Smtp-Source: ACHHUZ5123+hYgAJTfUfRk/69D02O4gVuouTa7oG5nJSHTbyC8xqUTcXni4hks5JgJ/eWZyV04XajmyTjI037lJsR5M=
X-Received: by 2002:a1f:4344:0:b0:446:ee73:8c01 with SMTP id
 q65-20020a1f4344000000b00446ee738c01mr2414642vka.8.1682723710150; Fri, 28 Apr
 2023 16:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230428112039.886496777@linuxfoundation.org>
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 29 Apr 2023 00:14:59 +0100
Message-ID: <CA+G9fYveLf0kWbhCPm9fm3sDCVk3HQrAph0rF0j8HU21jMxGHw@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 12:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions while running LTP controllers testing with 6.3 kernel on i386
and ftrace testing from x86.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is not always reproducible.

x86 crash log:
--------------
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check [PASS]
# [2] Basic test for tracers [PASS]
# [3] Basic trace clock test [PASS]
# [4] Basic event tracing check [PASS]
# [5] Change the ringbuffer size<47>[  106.586512]
systemd-journald[95]: Sent WATCHDOG=3D1 notification.
[PASS]
# [6] Snapshot and tracing setting [PASS]
# [7] trace_pipe and trace_marker [PASS]
# [8] Test ftrace direct functions against tracers<4>[  113.917567]
...
<47>[  190.132853] systemd-journald[95]: Sent WATCHDOG=3D1 notification.
<4>[  213.968606] int3: 0000 [#1] PREEMPT SMP PTI
<4>[  213.969006] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.1-rc1 #1
<4>[  213.969088] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  213.969282] RIP: 0010:update_rq_clock+0x5/0x20
<4>[  213.969783] Code: 0d 48 83 c4 40 c3 cc cc cc cc 0f 0b eb e3 e8
52 94 e0 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
0f 1f 00 0f <1f> 44 00 00 f6 87 88 09 00 00 02 74 05 c3 cc cc cc cc e9
d4 c3 ff
<4>[  213.969877] RSP: 0018:ffffb529c0003ea0 EFLAGS: 00000082
<4>[  213.970040] RAX: 00000000fffeaed4 RBX: 0000000000000001 RCX:
ffffa2383bc2b340
<4>[  213.970075] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffffa2383bc2b340
<4>[  213.970104] RBP: 00000000ffff9934 R08: 0000000000000003 R09:
0000000000000000
<4>[  213.970134] R10: ffffffff8d4060c0 R11: ffffb529c0003ff8 R12:
0000000000000000
<4>[  213.970188] R13: ffffa2383bc2b340 R14: ffffa2383bc2b340 R15:
0000000000000000
<4>[  213.970263] FS:  0000000000000000(0000)
GS:ffffa2383bc00000(0000) knlGS:0000000000000000
<4>[  213.970302] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  213.970333] CR2: 00007f16b5507ae4 CR3: 0000000100252000 CR4:
00000000000006f0
<4>[  213.970465] Call Trace:
<4>[  213.970716]  <IRQ>
<4>[  213.970841]  update_blocked_averages+0x58/0x5e0
<4>[  213.971160]  _nohz_idle_balance.isra.0+0x2db/0x330
<4>[  213.971341]  __do_softirq+0x10a/0x38c
<4>[  213.971457]  __irq_exit_rcu+0x86/0xb0
<4>[  213.971503]  irq_exit_rcu+0xe/0x20
<4>[  213.971543]  sysvec_call_function_single+0x6a/0x80
<4>[  213.971622]  </IRQ>
<4>[  213.971654]  <TASK>
<4>[  213.971688]  asm_sysvec_call_function_single+0x1a/0x20
<4>[  213.971796] RIP: 0010:default_idle+0xf/0x20
<4>[  213.971843] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 53 f8
32 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90
90 90 90
<4>[  213.971866] RSP: 0018:ffffffff8d403ea0 EFLAGS: 00000202
<4>[  213.971907] RAX: ffffa2383bc280c0 RBX: ffffffff8d40c900 RCX:
4000000000000000
<4>[  213.971926] RDX: 0000000000000001 RSI: ffffffff8d0cc130 RDI:
0000000000099fe4
<4>[  213.971993] RBP: 0000000000000000 R08: 0000000000099fe4 R09:
00000031d27ffa40
<4>[  213.972016] R10: 0000000000000000 R11: 0000000000000002 R12:
0000000000000000
<4>[  213.972034] R13: 0000000000000000 R14: ffffffff8d40c030 R15:
0000000000000000
<4>[  213.972326]  default_idle_call+0x36/0xf0
<4>[  213.972373]  do_idle+0x1d8/0x220
<4>[  213.972466]  cpu_startup_entry+0x1d/0x20
<4>[  213.972519]  rest_init+0xc3/0xd0
<4>[  213.972564]  arch_call_rest_init+0xe/0x30
<4>[  213.972654]  start_kernel+0x46d/0x770
<4>[  213.972751]  secondary_startup_64_no_verify+0xe0/0xeb
<4>[  213.972939]  </TASK>
<4>[  213.973072] Modules linked in: fuse configfs [last unloaded:
ftrace_direct]
<4>[  214.012764] ---[ end trace 0000000000000000 ]---
<4>[  214.012773] int3: 0000 [#2] PREEMPT SMP PTI
<4>[  214.012858] RIP: 0010:update_rq_clock+0x5/0x20
<4>[  214.012887] CPU: 1 PID: 571 Comm: ftracetest Tainted: G      D
         6.3.1-rc1 #1
<4>[  214.012919] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  214.012926] Code: 0d 48 83 c4 40 c3 cc cc cc cc 0f 0b eb e3 e8
52 94 e0 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
0f 1f 00 0f <1f> 44 00 00 f6 87 88 09 00 00 02 74 05 c3 cc cc cc cc e9
d4 c3 ff
<4>[  214.012951] RSP: 0018:ffffb529c0003ea0 EFLAGS: 00000082
<4>[  214.012940] RIP: 0010:update_rq_clock+0x5/0x20
<4>[  214.012985] Code: 0d 48 83 c4 40 c3 cc cc cc cc 0f 0b eb e3 e8
52 94 e0 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
0f 1f 00 0f <1f> 44 00 00 f6 87 88 09 00 00 02 74 05 c3 cc cc cc cc e9
d4 c3 ff
<4>[  214.013005] RSP: 0018:ffffb529c00c0ef0 EFLAGS: 00000002
<4>[  214.013047] RAX: 00000000fffeaee7 RBX: ffffa2383bd2b340 RCX:
ffffa2383bd2b340
<4>[  214.013008]
<4>[  214.013065] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffffa2383bd2b340
<4>[  214.013076] RAX: 00000000fffeaed4 RBX: 0000000000000001 RCX:
ffffa2383bc2b340
<4>[  214.013084] RBP: 0000000000000000 R08: ffffa2383bd1f2c0 R09:
7fffffffffffffff
<4>[  214.013094] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffffa2383bc2b340
<4>[  214.013104] R10: ffffffff8d4060c0 R11: 00000000000280ab R12:
0000000000000101
<4>[  214.013112] RBP: 00000000ffff9934 R08: 0000000000000003 R09:
0000000000000000
<4>[  214.013123] R13: ffffa2383bd2b340 R14: ffffffff8d4060f8 R15:
0000000000000007
<4>[  214.013130] R10: ffffffff8d4060c0 R11: ffffb529c0003ff8 R12:
0000000000000000
<4>[  214.013142] FS:  00007f589909c740(0000)
GS:ffffa2383bd00000(0000) knlGS:0000000000000000
<4>[  214.013149] R13: ffffa2383bc2b340 R14: ffffa2383bc2b340 R15:
0000000000000000
<4>[  214.013165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  214.013169] FS:  0000000000000000(0000)
GS:ffffa2383bc00000(0000) knlGS:0000000000000000
<4>[  214.013186] CR2: 00007f16b54e181c CR3: 00000001069e2000 CR4:
00000000000006e0
<4>[  214.013191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  214.013207] Call Trace:
<4>[  214.013210] CR2: 00007f16b5507ae4 CR3: 0000000100252000 CR4:
00000000000006f0
<4>[  214.013252]  <IRQ>
<4>[  214.013272]  update_blocked_averages+0x58/0x5e0
<0>[  214.013359] Kernel panic - not syncing: Fatal exception in interrupt
<4>[  214.013353]  ? update_blocked_averages+0x5/0x5e0
<4>[  214.013483]  run_rebalance_domains+0x49/0x70
<4>[  214.013620]  __do_softirq+0x10a/0x38c
<4>[  214.013747]  __irq_exit_rcu+0x86/0xb0
<4>[  214.013788]  irq_exit_rcu+0xe/0x20
<4>[  214.013824]  sysvec_apic_timer_interrupt+0x6a/0x80
<4>[  214.013874]  </IRQ>
<4>[  214.013892]  <TASK>
<4>[  214.013921]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
<4>[  214.013965] RIP: 0010:__text_poke+0x2aa/0x450
<4>[  214.014004] Code: 00 00 48 01 f2 e8 66 16 04 00 49 81 fd 70 78
a3 8b 0f 84 08 01 00 00 48 83 7c 24 18 00 74 06 e8 cc 48 18 00 fb 48
8b 7c 24 30 <e8> 91 ac ea 00 48 8b 44 24 38 65 48 2b 04 25 28 00 00 00
0f 85 6a
<4>[  214.014027] RSP: 0018:ffffb529c04bbc20 EFLAGS: 00000246
<4>[  214.014064] RAX: 0000000000027bb4 RBX: ffffffff8bae2b10 RCX:
0000000000000000
<4>[  214.014084] RDX: ffffa2383bd00000 RSI: 0000000000000000 RDI:
fffff631440015a8
<4>[  214.014103] RBP: 0000000000000001 R08: 00000000000000cc R09:
0000000000000001
<4>[  214.014123] R10: ffffb529c04bbcac R11: ffffffff8df2095a R12:
ffffa237c00561e0
<4>[  214.014143] R13: ffffffff8ba37870 R14: 0000000000000b10 R15:
0000000000000b11
<4>[  214.014179]  ? __pfx_text_poke_memcpy+0x10/0x10
<4>[  214.014227]  ? __pfx_task_non_contending+0x10/0x10
<4>[  214.014466]  text_poke_bp_batch+0x8a/0x300
<4>[  214.014538]  ? __wake_up_locked_key+0x4/0x20
<4>[  214.014608]  text_poke_queue+0x6c/0xa0
<4>[  214.014676]  ftrace_replace_code+0x19a/0x220
<4>[  214.014773]  ftrace_modify_all_code+0x14a/0x180
<4>[  214.014826]  ftrace_shutdown.part.0+0x10e/0x1e0
<4>[  214.014882]  unregister_ftrace_graph+0x55/0x90
<4>[  214.014920]  tracing_set_tracer+0x119/0x270
<4>[  214.014986]  tracing_set_trace_write+0x90/0xd0
<4>[  214.015153]  vfs_write+0xcb/0x410
<4>[  214.015245]  ? trace_hardirqs_on+0x21/0x90
<4>[  214.015282]  ? trace_graph_return+0xb4/0x100
<4>[  214.015426]  ? ftrace_regs_caller_end+0x61/0x61
<4>[  214.015469]  ksys_write+0x6f/0xf0
<4>[  214.015547]  ? ftrace_regs_caller_end+0x61/0x61
<4>[  214.015580]  do_syscall_64+0x3e/0x90
<4>[  214.015631]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
<4>[  214.015669] RIP: 0033:0x7f5899197190
<4>[  214.015897] Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48
c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00
00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec
28 48 89
<4>[  214.015920] RSP: 002b:00007ffc73238a88 EFLAGS: 00000202
ORIG_RAX: 0000000000000001
<4>[  214.015967] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f5899197190
<4>[  214.015999] RDX: 0000000000000004 RSI: 000055a4a8f346a0 RDI:
0000000000000001
<4>[  214.016018] RBP: 000055a4a8f346a0 R08: 0000000000000002 R09:
000055a4a8f4b98b
<4>[  214.016037] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000001
<4>[  214.016056] R13: 0000000000000004 R14: 0000000000000002 R15:
0000000000000000
<4>[  214.016232]  </TASK>
<4>[  214.016251] Modules linked in: fuse configfs [last unloaded:
ftrace_direct]
<4>[  214.017050] ---[ end trace 0000000000000000 ]---
<4>[  214.017081] RIP: 0010:update_rq_clock+0x5/0x20
<4>[  214.017128] Code: 0d 48 83 c4 40 c3 cc cc cc cc 0f 0b eb e3 e8
52 94 e0 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
0f 1f 00 0f <1f> 44 00 00 f6 87 88 09 00 00 02 74 05 c3 cc cc cc cc e9
d4 c3 ff
<4>[  214.017152] RSP: 0018:ffffb529c0003ea0 EFLAGS: 00000082
<4>[  214.017188] RAX: 00000000fffeaed4 RBX: 0000000000000001 RCX:
ffffa2383bc2b340
<4>[  214.017422] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffffa2383bc2b340
<4>[  214.017444] RBP: 00000000ffff9934 R08: 0000000000000003 R09:
0000000000000000
<4>[  214.017464] R10: ffffffff8d4060c0 R11: ffffb529c0003ff8 R12:
0000000000000000
<4>[  214.017484] R13: ffffa2383bc2b340 R14: ffffa2383bc2b340 R15:
0000000000000000
<4>[  214.017505] FS:  00007f589909c740(0000)
GS:ffffa2383bd00000(0000) knlGS:0000000000000000
<4>[  214.017530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  214.017552] CR2: 00007f16b54e181c CR3: 00000001069e2000 CR4:
00000000000006e0
<0>[  217.337191] Shutting down cpus with NMI
<0>[  217.338269] Kernel Offset: 0xaa00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfff


i386 kernel crash:
---------------

[    0.000000] Linux version 6.3.1-rc1 (tuxmake@tuxmake) (Debian clang
version 17.0.0 (++20230417071830+ae77aceba5ad-1~exp1~20230417071935.630),
Debian LLD 17.0.0) #1 SMP PREEMPT_DYNAMIC @1682689312
...
cgroup_fj_stress 1 TPASS: All done!
cgroup_fj_stress 2 TINFO: Removing all ltp subgroups...
<4>[   92.135813] int3: 0000 [#1] PREEMPT SMP
<4>[   92.136105] CPU: 0 PID: 3107 Comm: cgroup_fj_stres Not tainted
6.3.1-rc1 #1
<4>[   92.136265] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[   92.136441] EIP: get_page_from_freelist+0xf1/0xc70
<4>[   92.136848] Code: 89 45 8c 8d 04 5b 89 45 94 c7 45 a4 00 00 00
00 c7 45 a8 00 00 00 00 89 5d e0 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 8b 45 0c 80 78 14 00 89 7d e4 74 28 89 f8 89
f7 8b 70
<4>[   92.136925] EAX: 00000000 EBX: 00000000 ECX: 00000054 EDX: 00000801
<4>[   92.136952] ESI: ca2aa4c8 EDI: ca2a9d40 EBP: c3cf1d28 ESP: c3cf1c90
<4>[   92.136986] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 0000=
0297
<4>[   92.137023] CR0: 80050033 CR2: b7d10ec8 CR3: 02cb7000 CR4: 000006d0
<4>[   92.137143] Call Trace:
<4>[   92.137451]  ? sysvec_call_function_single+0x2c/0x30
<4>[   92.137539]  ? sysvec_call_function+0x30/0x30
<4>[   92.137557]  ? irqentry_exit+0x30/0x40
<4>[   92.137574]  ? sysvec_call_function_single+0x2c/0x30
<4>[   92.137602]  ? __alloc_pages+0x8d/0x270
<4>[   92.137625]  __alloc_pages+0xf5/0x270
<4>[   92.137678]  pte_alloc_one+0x25/0xa0
<4>[   92.137702]  __pte_alloc+0x22/0xe0
<4>[   92.137721]  ? __get_user_pages+0x1cd/0x3a0
<4>[   92.137743]  handle_mm_fault+0xb94/0xdf0
<4>[   92.137762]  ? mt_find+0x90/0x180
<4>[   92.137790]  ? __irq_exit_rcu+0x3c/0xd0
<4>[   92.137812]  __get_user_pages+0x1cd/0x3a0
<4>[   92.137836]  ? __down_read_common+0x317/0x460
<4>[   92.137860]  get_user_pages_remote+0xb9/0x340
<4>[   92.137893]  get_arg_page+0x5c/0x120
<4>[   92.137915]  ? up_write+0x45/0xc0
<4>[   92.137936]  copy_string_kernel+0x93/0x120
<4>[   92.137955]  ? alloc_bprm+0x1c8/0x230
<4>[   92.137978]  do_execveat_common+0x1eb/0x2a0
<4>[   92.138001]  __ia32_sys_execve+0x29/0x30
<4>[   92.138024]  __do_fast_syscall_32+0x86/0xcc
<4>[   92.138039]  ? irqentry_exit_to_user_mode+0xf/0x1c
<4>[   92.138056]  ? irqentry_exit+0x12/0x40
<4>[   92.138073]  ? trace_hardirqs_on_prepare+0x26/0x70
<4>[   92.138093]  ? irqentry_exit_to_user_mode+0xf/0x1c
<4>[   92.138113]  do_fast_syscall_32+0x29/0x5c
<4>[   92.138131]  do_SYSENTER_32+0x12/0x14
<4>[   92.138146]  entry_SYSENTER_32+0x98/0xf1
<4>[   92.138256] EIP: 0xb7f4c539
<4>[   92.138573] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8
01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5
0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 58 b8 77 00 00 00 cd 80
90 90 90
<4>[   92.138586] EAX: ffffffda EBX: 0869e180 ECX: 086f3f50 EDX: 087069f0
<4>[   92.138595] ESI: 0869e180 EDI: 00000020 EBP: 08705540 ESP: bfe8e708
<4>[   92.138605] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 0000=
0292
<4>[   92.138718] Modules linked in:
<4>[   92.164397] ---[ end trace 0000000000000000 ]---
<4>[   92.164662] EIP: get_page_from_freelist+0xf1/0xc70
<4>[   92.164706] Code: 89 45 8c 8d 04 5b 89 45 94 c7 45 a4 00 00 00
00 c7 45 a8 00 00 00 00 89 5d e0 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 8b 45 0c 80 78 14 00 89 7d e4 74 28 89 f8 89
f7 8b 70
<4>[   92.164721] EAX: 00000000 EBX: 00000000 ECX: 00000054 EDX: 00000801
<4>[   92.164731] ESI: ca2aa4c8 EDI: ca2a9d40 EBP: c3cf1d28 ESP: c3cf1c90
<4>[   92.164741] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 0000=
0297
<4>[   92.164753] CR0: 80050033 CR2: b7d10ec8 CR3: 02cb7000 CR4: 000006d0
<0>[   92.164918] Kernel panic - not syncing: Fatal exception in interrupt
<0>[   92.165882] Kernel Offset: disabled

log links,
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3=
-rc4-935-gf45bb34ed520/testrun/16605304/suite/log-parser-test/test/check-ke=
rnel-panic/log
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3=
-rc4-935-gf45bb34ed520/testrun/16605678/suite/log-parser-test/test/check-ke=
rnel-panic/log
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3=
-rc4-935-gf45bb34ed520/testrun/16605670/suite/log-parser-test/tests/


--
Linaro LKFT
https://lkft.linaro.org
