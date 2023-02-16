Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A819699424
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBPMRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBPMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:17:47 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE13A9E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:17:46 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id j18so1090324vkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kKetw1FKB0l1/O0VGIOBIy83NDOmUM2G2EzyQfB0t8E=;
        b=BwFxiUvLRaAoiWRpwesN2mqYNgghaKUuWbnlpJ/sk3pZvvm93cO1IhCG4eNz/PTkUm
         iOjh0+L0wqCDySKkLe8ozbGuXJcrcfQb7z6EoI1BvsgiDUm/B7QTlN81s7O5AyIKTRBC
         NHHJtSjPQ3s/rFs/d9kLi3OAg6LF9RC4D21T4iTHwZ56SygZJpgTK8uF5Dmp6r2yqV9R
         Axr6qtQw6XR0M1OAXy2qqImm7AYC+fKPUDl0543wEaIFrW39LupBKjn2nrKguJJjXi2i
         PQNtuDJUGt7UhaQqSDp711kNCraiieB07qG1r5SPi1E94PZP/23oGL1fukiOP/98/ofY
         fWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKetw1FKB0l1/O0VGIOBIy83NDOmUM2G2EzyQfB0t8E=;
        b=3v5BfrbMO6xl16cu2dPgRXile1xyN9SyDOgWKHVyVoestUR7cZdJr5Gs6VC5SBj+cY
         W4K0271X9wybXmsGQJMFvWUeM/V8IDdp0u7orID0rA3YNVC8mU/5sZu/7IN6Irhj6X/u
         N9dL+SclM1h8Lh34svGyeTPTd9XrfXiGf78JfxI+xR1GkXeB3mjpBlQ3UMo6nutP2PwU
         qD0wTG3jylYkG7tuBrowiCDhi+wBfGN+LsyzDxjBn5XxObnB/73m+XRdIs9SgMzhKByB
         leLfDykDOvUeG8YAFBCdb2Qhga5FSgVDo+185Qd6MHwm8QBLLCZkIcbARrDYGSr6hRau
         TWJg==
X-Gm-Message-State: AO0yUKVEGFWFCN9XvWtvmX7yRwW3kZAxEX2emlZQEJDrCYZ3iNzBVA3o
        yN4qo7aEH6MrBJtXJAGwhiM4BqYoGlARUFtEtHhyfg==
X-Google-Smtp-Source: AK7set/czZP8+ltYWHLj+fc65XnlAV9FAdSonSkk+EFC+lmnC+5KsaG+8DaN1DkSaVWv1AvGuEvKnMTB6okR3c9+Ymk=
X-Received: by 2002:a1f:13d4:0:b0:3ea:78fc:6dd8 with SMTP id
 203-20020a1f13d4000000b003ea78fc6dd8mr983810vkt.21.1676549864979; Thu, 16 Feb
 2023 04:17:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
In-Reply-To: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Feb 2023 13:17:08 +0100
Message-ID: <CANpmjNOnU+vsOzXJZ_usj81NE371jUJoqtyvFvi_g9_QjZ=F-g@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

+Cc Andrey, Alex

On Thu, 16 Feb 2023 at 13:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following kernel panic noticed while running KUNIT testing on qemu-x86_64
> with KASAN enabled kernel.
>
> CONFIG_KASAN=y
> CONFIG_KUNIT=y
> CONFIG_KUNIT_ALL_TESTS=y
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> ---------
> <5>[    0.000000] Linux version 6.2.0-rc8-next-20230216
> (tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU
> ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1676522550
> <6>[    0.000000] Command line: console=ttyS0,115200 rootwait
> root=/dev/sda debug verbose console_msg_format=syslog earlycon
> <6>[    0.000000] x86/fpu: x87 FPU will use FXSAVE
> <6>[    0.000000] signal: max sigframe size: 1440
> ...
> <6>[    0.001000] kasan: KernelAddressSanitizer initialized
> ...
> <6>[   16.570308] KTAP version 1
> <6>[   16.570801] 1..62
> <6>[   16.574277]     KTAP version 1
> ...
> <6>[   38.688296]     ok 16 kmalloc_uaf_16
> <3>[   38.692992]     # kmalloc_oob_in_memset: EXPECTATION FAILED at
> mm/kasan/kasan_test.c:558
> <3>[   38.692992]     KASAN failure expected in \"memset(ptr, 0, size
> + KASAN_GRANULE_SIZE)\", but none occurred
> <6>[   38.695659]     not ok 17 kmalloc_oob_in_memset
> <3>[   38.702362]     # kmalloc_oob_memset_2: EXPECTATION FAILED at
> mm/kasan/kasan_test.c:505
> <3>[   38.702362]     KASAN failure expected in \"memset(ptr + size -
> 1, 0, 2)\", but none occurred
> <6>[   38.704750]     not ok 18 kmalloc_oob_memset_2
> <3>[   38.710076]     # kmalloc_oob_memset_4: EXPECTATION FAILED at
> mm/kasan/kasan_test.c:518
> <3>[   38.710076]     KASAN failure expected in \"memset(ptr + size -
> 3, 0, 4)\", but none occurred
> <6>[   38.712349]     not ok 19 kmalloc_oob_memset_4
> <3>[   38.718545]     # kmalloc_oob_memset_8: EXPECTATION FAILED at
> mm/kasan/kasan_test.c:531
> <3>[   38.718545]     KASAN failure expected in \"memset(ptr + size -
> 7, 0, 8)\", but none occurred
> <6>[   38.721274]     not ok 20 kmalloc_oob_memset_8
> <3>[   38.726201]     # kmalloc_oob_memset_16: EXPECTATION FAILED at
> mm/kasan/kasan_test.c:544
> <3>[   38.726201]     KASAN failure expected in \"memset(ptr + size -
> 15, 0, 16)\", but none occurred
> <6>[   38.728269]     not ok 21 kmalloc_oob_memset_16
> <4>[   38.735350] general protection fault, probably for non-canonical
> address 0xa0de1c2100000008: 0000 [#1] PREEMPT SMP KASAN PTI
> <4>[   38.737084] CPU: 0 PID: 131 Comm: kunit_try_catch Tainted: G
> B            N 6.2.0-rc8-next-20230216 #1
> <4>[   38.738232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.14.0-2 04/01/2014
> <4>[   38.739202] RIP: 0010:__stack_depot_save+0x16b/0x4a0
> <4>[   38.740158] Code: 29 c8 89 c3 48 8b 05 bc ef 4a 03 89 de 23 35
> ac ef 4a 03 4c 8d 04 f0 4d 8b 20 4d 85 e4 75 0b eb 77 4d 8b 24 24 4d
> 85 e4 74 6e <41> 39 5c 24 08 75 f0 41 3b 54 24 0c 75 e9 31 c0 49 8b 7c
> c4 18 49
> <4>[   38.742135] RSP: 0000:ffff88815b409a00 EFLAGS: 00000286
> <4>[   38.743055] RAX: ffff88815a600000 RBX: 00000000a0de1c21 RCX:
> 000000000000000e
> <4>[   38.744084] RDX: 000000000000000e RSI: 00000000000e1c21 RDI:
> 00000000282127a7
> <4>[   38.745061] RBP: ffff88815b409a58 R08: ffff88815ad0e108 R09:
> 0000000005d4305e
> <4>[   38.746039] R10: ffffed1020693eb9 R11: ffff88815b409ff8 R12:
> a0de1c2100000000
> <4>[   38.747012] R13: 0000000000000001 R14: 0000000000000800 R15:
> ffff88815b409a68
> <4>[   38.748039] FS:  0000000000000000(0000)
> GS:ffff88815b400000(0000) knlGS:0000000000000000
> <4>[   38.749066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   38.749848] CR2: a0de1c2100000008 CR3: 000000012c2ae000 CR4:
> 00000000000006f0
> <4>[   38.750769] DR0: ffffffff97419b80 DR1: ffffffff97419b81 DR2:
> ffffffff97419b82
> <4>[   38.751712] DR3: ffffffff97419b83 DR6: 00000000ffff0ff0 DR7:
> 0000000000000600
> <4>[   38.752692] Call Trace:
> <4>[   38.753288]  <IRQ>
> <4>[   38.753795]  kasan_save_stack+0x4c/0x60
> <4>[   38.754479]  ? kasan_save_stack+0x3c/0x60
> <4>[   38.755112]  ? kasan_set_track+0x29/0x40
> <4>[   38.756690]  ? kasan_save_free_info+0x32/0x50
> <4>[   38.757186]  ? ____kasan_slab_free+0x175/0x1d0
> <4>[   38.757830]  ? __kasan_slab_free+0x16/0x20
> <4>[   38.758525]  ? __kmem_cache_free+0x18c/0x300
> <4>[   38.759187]  ? kfree+0x7c/0x120
> <4>[   38.759756]  ? free_kthread_struct+0x78/0xa0
> <4>[   38.760516]  ? free_task+0x96/0xa0
> <4>[   38.761127]  ? __put_task_struct+0x1a2/0x1f0
> <4>[   38.761843]  ? delayed_put_task_struct+0xec/0x110
> <4>[   38.762595]  ? rcu_core+0x4e3/0x1010
> <4>[   38.763180]  ? rcu_core_si+0x12/0x20
> <4>[   38.763842]  ? __do_softirq+0x18f/0x502
> <4>[   38.764464]  ? __irq_exit_rcu+0xa1/0xe0
> <4>[   38.764982]  ? irq_exit_rcu+0x12/0x20
> <4>[   38.765760]  ? sysvec_apic_timer_interrupt+0x7d/0xa0
> <4>[   38.766544]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> <4>[   38.767391]  ? memmove+0x3c/0x1c0
> <4>[   38.767994]  ? kunit_try_run_case+0x8e/0x130
> <4>[   38.768718]  ? kunit_generic_run_threadfn_adapter+0x33/0x50
> <4>[   38.769477]  ? kthread+0x17f/0x1b0
> <4>[   38.769871]  ? ret_from_fork+0x2c/0x50
> <4>[   38.770841]  ? kfree+0x7c/0x120
> <4>[   38.771470]  kasan_set_track+0x29/0x40
> <4>[   38.772101]  kasan_save_free_info+0x32/0x50
> <4>[   38.772855]  ____kasan_slab_free+0x175/0x1d0
> <4>[   38.773536]  ? free_kthread_struct+0x78/0xa0
> <4>[   38.774175]  __kasan_slab_free+0x16/0x20
> <4>[   38.774865]  __kmem_cache_free+0x18c/0x300
> <4>[   38.775553]  kfree+0x7c/0x120
> <4>[   38.776137]  free_kthread_struct+0x78/0xa0
> <4>[   38.776840]  free_task+0x96/0xa0
> <4>[   38.777220]  __put_task_struct+0x1a2/0x1f0
> <4>[   38.778103]  delayed_put_task_struct+0xec/0x110
> <4>[   38.778786]  rcu_core+0x4e3/0x1010
> <4>[   38.779450]  ? __pfx_rcu_core+0x10/0x10
> <4>[   38.780147]  ? __pfx_read_tsc+0x10/0x10
> <4>[   38.780750]  ? __do_softirq+0x11f/0x502
> <4>[   38.781480]  rcu_core_si+0x12/0x20
> <4>[   38.782073]  __do_softirq+0x18f/0x502
> <4>[   38.782755]  ? __pfx___do_softirq+0x10/0x10
> <4>[   38.783442]  ? trace_preempt_on+0x20/0xa0
> <4>[   38.784070]  ? __irq_exit_rcu+0x17/0xe0
> <4>[   38.784767]  __irq_exit_rcu+0xa1/0xe0
> <4>[   38.785377]  irq_exit_rcu+0x12/0x20
> <4>[   38.786028]  sysvec_apic_timer_interrupt+0x7d/0xa0
> <4>[   38.786781]  </IRQ>
> <4>[   38.787107]  <TASK>
> <4>[   38.787639]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> <4>[   38.788698] RIP: 0010:memmove+0x3c/0x1c0
> <4>[   38.789436] Code: 49 39 f8 0f 8f b5 00 00 00 48 83 fa 20 0f 82
> 01 01 00 00 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48
> 48 83 ea 20 <48> 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18
> 48 8d 76
> <4>[   38.791297] RSP: 0000:ffff888103507e08 EFLAGS: 00000286
> <4>[   38.792130] RAX: ffff8881033e9000 RBX: ffff8881033e9000 RCX:
> 0000000000000000
> <4>[   38.792969] RDX: fffffffffff8727e RSI: ffff888103461d64 RDI:
> ffff888103461d60
> <4>[   38.793818] RBP: ffff888103507eb8 R08: 0000000100000000 R09:
> 0000000000000000
> <4>[   38.794643] R10: 0000000000000000 R11: 0000000000000000 R12:
> 1ffff110206a0fc2
> <4>[   38.795458] R13: ffff888100327b60 R14: ffff888103507e90 R15:
> fffffffffffffffe
> <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10
> <4>[   38.798257]  ? __kasan_check_write+0x18/0x20
> <4>[   38.798923]  ? _raw_spin_lock_irqsave+0xa2/0x110
> <4>[   38.799617]  ? _raw_spin_unlock_irqrestore+0x2c/0x60
> <4>[   38.800491]  ? trace_preempt_on+0x20/0xa0
> <4>[   38.801150]  ? __kthread_parkme+0x4f/0xd0
> <4>[   38.801778]  kunit_try_run_case+0x8e/0x130
> <4>[   38.802505]  ? __pfx_kunit_try_run_case+0x10/0x10
> <4>[   38.803197]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
> <4>[   38.803997]  kunit_generic_run_threadfn_adapter+0x33/0x50
> <4>[   38.804749]  kthread+0x17f/0x1b0
> <4>[   38.805377]  ? __pfx_kthread+0x10/0x10
> <4>[   38.806025]  ret_from_fork+0x2c/0x50
> <4>[   38.806716]  </TASK>
> <4>[   38.807261] Modules linked in:
> <4>[   38.809163] ---[ end trace 0000000000000000 ]---
> <4>[   38.809731] RIP: 0010:__stack_depot_save+0x16b/0x4a0
> <4>[   38.810988] Code: 29 c8 89 c3 48 8b 05 bc ef 4a 03 89 de 23 35
> ac ef 4a 03 4c 8d 04 f0 4d 8b 20 4d 85 e4 75 0b eb 77 4d 8b 24 24 4d
> 85 e4 74 6e <41> 39 5c 24 08 75 f0 41 3b 54 24 0c 75 e9 31 c0 49 8b 7c
> c4 18 49
> <4>[   38.812911] RSP: 0000:ffff88815b409a00 EFLAGS: 00000286
> <4>[   38.813435] RAX: ffff88815a600000 RBX: 00000000a0de1c21 RCX:
> 000000000000000e
> <4>[   38.815407] RDX: 000000000000000e RSI: 00000000000e1c21 RDI:
> 00000000282127a7
> <4>[   38.816630] RBP: ffff88815b409a58 R08: ffff88815ad0e108 R09:
> 0000000005d4305e
> <4>[   38.817540] R10: ffffed1020693eb9 R11: ffff88815b409ff8 R12:
> a0de1c2100000000
> <4>[   38.818685] R13: 0000000000000001 R14: 0000000000000800 R15:
> ffff88815b409a68
> <4>[   38.819949] FS:  0000000000000000(0000)
> GS:ffff88815b400000(0000) knlGS:0000000000000000
> <4>[   38.821375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   38.822431] CR2: a0de1c2100000008 CR3: 000000012c2ae000 CR4:
> 00000000000006f0
> <4>[   38.823562] DR0: ffffffff97419b80 DR1: ffffffff97419b81 DR2:
> ffffffff97419b82
> <4>[   38.824702] DR3: ffffffff97419b83 DR6: 00000000ffff0ff0 DR7:
> 0000000000000600
> <0>[   38.826157] Kernel panic - not syncing: Fatal exception in interrupt
> <0>[   38.828641] Kernel Offset: 0x12400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> <0>[   38.830146] ---[ end Kernel panic - not syncing: Fatal exception
> in interrupt ]---
>
>
> links:
> ----
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230216/testrun/14817835/suite/log-parser-test/test/check-kernel-panic/log
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230216/testrun/14817835/suite/log-parser-test/tests/
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230216/testrun/14817835/suite/log-parser-test/test/check-kernel-panic/details/
>
>
> steps to reproduce:
> ---
> tuxrun  \
>  --runtime podman  \
>  --device qemu-x86_64  \
>  --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2Lo0yXyxgpsuMQhyLdw5jKk9nSj/bzImage
>  \
>  --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Lo0yXyxgpsuMQhyLdw5jKk9nSj/modules.tar.xz
>  \
>  --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2LUxobLpTjiRrzSKqqYOwhong7e/images/intel-corei7-64/lkft-tux-image-intel-corei7-64-20230209111930.rootfs.ext4.gz
>  \
>  --parameters SKIPFILE=skipfile-lkft.yaml  \
>  --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
>  --tests kunit  \
>  --timeouts boot=15 kunit=30
>
> --
> Linaro LKFT
> https://lkft.linaro.org
