Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4805FC150
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJLHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:37:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191C2642;
        Wed, 12 Oct 2022 00:37:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m19so23156586lfq.9;
        Wed, 12 Oct 2022 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjfphTrD74SCe2Wqn9sjzTarSBfrRBT5WV/r6ddhkjc=;
        b=AoIoo8VCzL3Q/mizCE+qWAtBX4JpELxjdtE6seGxWpX14JcAJCVDbzhjw9M7n828Qr
         i7vnT7gPoFXwP+OqdiiqDFy0T+O6R1gHN9OmKVo88ikUINEwjLMbS2MQWegnuIczVSQJ
         Kxn/uSwkdNWQqffzNSbd/i1tooPQ8bu3t9WXrdaZr/TimhUwo2na8XHIboH1scxbt3xB
         bN4pf66PcE8JVfurzdLpaOa9ihSSj2uswXRAvAOwBjGIRUOMN5kzzunaCGzpxUpD5qZ5
         rbfxNYCnj3uXNY7DsQOzcK68MYXQ3fLcmz3bv73QjON1TfW6uEh1vRArEiqnfsLp4xXa
         B0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjfphTrD74SCe2Wqn9sjzTarSBfrRBT5WV/r6ddhkjc=;
        b=C7O0f0C1/cAvDAK78E3NpAaFLdGw5k22YB8ZcNw9bwoUc+PNseGTyhwHjIfLTmSzp0
         xpZS3vgbQ8Xo/NMh2SaqxGA2IfVmAarXdydv7SqlLH/B+1jnzcQNcy/lE7g8qguFK3l9
         oLZfPlkMijWUGqwGpO14JsIyN7kD9eKS4pVVBkJhcI+w9F481TJZ8t5RlxOBTL3euPif
         ezMqqyY+giUMfgYaaZ5XfrVdkhuZu5EAv1mnug2l/Ncgb0UJrSruyOCQPtAucunXRnw6
         fDVzcmiD5Gdw9PZXm3DpcumpI/OK9DE4zWUPlQGEZi1QcC7mNwTmJJrShqd/JQ+Wx4UJ
         JDIw==
X-Gm-Message-State: ACrzQf0oUoLOf8lBcp6c4660/0sxyQ2vb90k+flkaF/v4WPZXkPYJRNE
        t+wImi8LmYZzlMDrIZ0e358jZL/B6U7NcXmTNjU=
X-Google-Smtp-Source: AMsMyM4sgAAd2sHPlijuFV3EPm6SjKYIRCRRKlhOqGL78Xp1B9gu+vUic/xGRHnKmdeyIFoT2tY7/7rJ8lWLSoQyCdU=
X-Received: by 2002:a05:6512:3404:b0:4a2:c780:7077 with SMTP id
 i4-20020a056512340400b004a2c7807077mr7958380lfr.165.1665560243465; Wed, 12
 Oct 2022 00:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <1665450964-27487-1-git-send-email-zhaoyang.huang@unisoc.com> <202210121406.d4ebc9bc-oliver.sang@intel.com>
In-Reply-To: <202210121406.d4ebc9bc-oliver.sang@intel.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 12 Oct 2022 15:36:54 +0800
Message-ID: <CAGWkznHr-dOdq0MG0DTz6XwEU8LpxURK-7jmHw2+7K0PMSOk3A@mail.gmail.com>
Subject: Re: [mm] 0e949320db: BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
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

This is introduced by a very early kmemleak_alloc before kmemleak_init
which gets an object from mem_pool, which could not be produced on my
v5.4 based environment, sorry for the disturbance. I would like to
send a fixup later.

On Wed, Oct 12, 2022 at 2:34 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 0e949320dbee7ffe242b1a9b4fc59661e954e6e5 ("[Resend PATCH] mm: use stack_depot for recording kmemleak's backtrace")
> url: https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-use-stack_depot-for-recording-kmemleak-s-backtrace/20221011-091833
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/linux-mm/1665450964-27487-1-git-send-email-zhaoyang.huang@unisoc.com
> patch subject: [Resend PATCH] mm: use stack_depot for recording kmemleak's backtrace
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +---------------------------------------------+------------+------------+
> |                                             | 029cc2b410 | 0e949320db |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 6          | 0          |
> | boot_failures                               | 0          | 6          |
> | BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
> | Oops:#[##]                                  | 0          | 6          |
> | RIP:__stack_depot_save                      | 0          | 6          |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
> +---------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/r/202210121406.d4ebc9bc-oliver.sang@intel.com
>
>
> [    0.244585][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    0.246464][    T0] #PF: supervisor read access in kernel mode
> [    0.247823][    T0] #PF: error_code(0x0000) - not-present page
> [    0.249179][    T0] PGD 0 P4D 0
> [    0.249986][    T0] Oops: 0000 [#1] SMP PTI
> [    0.251025][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-00707-g0e949320dbee #4
> [    0.252895][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [ 0.255242][ T0] RIP: 0010:__stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:452)
> [ 0.256583][ T0] Code: 03 48 c7 c7 ec 17 b3 84 e8 91 e8 85 ff 44 89 e0 23 05 74 a8 01 03 48 8d 04 c3 48 89 c3 48 89 c7 48 89 44 24 28 e8 d4 f9 85 ff <4c> 8b 33 4d 85 f6 0f 84 b6 00 00 00 8b 04 24 83 e8 01 48 8d 04 c5
> All code
> ========
>    0:   03 48 c7                add    -0x39(%rax),%ecx
>    3:   c7                      (bad)
>    4:   ec                      in     (%dx),%al
>    5:   17                      (bad)
>    6:   b3 84                   mov    $0x84,%bl
>    8:   e8 91 e8 85 ff          callq  0xffffffffff85e89e
>    d:   44 89 e0                mov    %r12d,%eax
>   10:   23 05 74 a8 01 03       and    0x301a874(%rip),%eax        # 0x301a88a
>   16:   48 8d 04 c3             lea    (%rbx,%rax,8),%rax
>   1a:   48 89 c3                mov    %rax,%rbx
>   1d:   48 89 c7                mov    %rax,%rdi
>   20:   48 89 44 24 28          mov    %rax,0x28(%rsp)
>   25:   e8 d4 f9 85 ff          callq  0xffffffffff85f9fe
>   2a:*  4c 8b 33                mov    (%rbx),%r14              <-- trapping instruction
>   2d:   4d 85 f6                test   %r14,%r14
>   30:   0f 84 b6 00 00 00       je     0xec
>   36:   8b 04 24                mov    (%rsp),%eax
>   39:   83 e8 01                sub    $0x1,%eax
>   3c:   48                      rex.W
>   3d:   8d                      .byte 0x8d
>   3e:   04 c5                   add    $0xc5,%al
>
> Code starting with the faulting instruction
> ===========================================
>    0:   4c 8b 33                mov    (%rbx),%r14
>    3:   4d 85 f6                test   %r14,%r14
>    6:   0f 84 b6 00 00 00       je     0xc2
>    c:   8b 04 24                mov    (%rsp),%eax
>    f:   83 e8 01                sub    $0x1,%eax
>   12:   48                      rex.W
>   13:   8d                      .byte 0x8d
>   14:   04 c5                   add    $0xc5,%al
> [    0.261023][    T0] RSP: 0000:ffffffff83603ca8 EFLAGS: 00010046
> [    0.262337][    T0] RAX: ffffffff83613cd8 RBX: 0000000000000000 RCX: ffffffff81b16f8c
> [    0.264139][    T0] RDX: 0000000000000b64 RSI: 0000000000000000 RDI: 0000000000000000
> [    0.265948][    T0] RBP: 00000000c5a6b597 R08: ffffffff8479d118 R09: 0000000000000000
> [    0.267668][    T0] R10: 0000000000000004 R11: 0001ffffffffffff R12: 0000000027b2cd0a
> [    0.269492][    T0] R13: 0000000000000003 R14: 000000004954f68c R15: ffffffff83603d54
> [    0.271315][    T0] FS:  0000000000000000(0000) GS:ffffffff842c9000(0000) knlGS:0000000000000000
> [    0.273215][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.274736][    T0] CR2: 0000000000000000 CR3: 000000000360a000 CR4: 00000000000406b0
> [    0.276558][    T0] Call Trace:
> [    0.277339][    T0]  <TASK>
> [ 0.278031][ T0] stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:534)
> [ 0.279163][ T0] set_track_prepare (kbuild/src/x86_64-2/mm/slub.c:752)
> [ 0.280296][ T0] ? memblock_alloc_range_nid (kbuild/src/x86_64-2/mm/memblock.c:1424)
> [ 0.281692][ T0] ? memblock_alloc_internal (kbuild/src/x86_64-2/mm/memblock.c:1514)
> [ 0.282985][ T0] ? memblock_alloc_try_nid (kbuild/src/x86_64-2/mm/memblock.c:1614 (discriminator 3))
> [ 0.286557][ T0] ? setup_command_line (kbuild/src/x86_64-2/init/main.c:631)
> [ 0.287706][ T0] ? start_kernel (kbuild/src/x86_64-2/init/main.c:965)
> [ 0.288803][ T0] ? secondary_startup_64_no_verify (kbuild/src/x86_64-2/arch/x86/kernel/head_64.S:358)
> [ 0.290257][ T0] ? __raw_callee_save___native_queued_spin_unlock (??:?)
> [ 0.291867][ T0] ? write_comp_data (kbuild/src/x86_64-2/kernel/kcov.c:236)
> [ 0.292883][ T0] ? strncpy (kbuild/src/x86_64-2/lib/string.c:115)
> [ 0.293763][ T0] __create_object (kbuild/src/x86_64-2/mm/kmemleak.c:681)
> [ 0.294761][ T0] kmemleak_alloc_phys (kbuild/src/x86_64-2/mm/kmemleak.c:1212)
> [ 0.295882][ T0] memblock_alloc_range_nid (kbuild/src/x86_64-2/mm/memblock.c:1424)
> [ 0.297105][ T0] memblock_alloc_internal (kbuild/src/x86_64-2/mm/memblock.c:1514)
> [ 0.298293][ T0] memblock_alloc_try_nid (kbuild/src/x86_64-2/mm/memblock.c:1614 (discriminator 3))
> [ 0.299516][ T0] setup_command_line (kbuild/src/x86_64-2/init/main.c:631)
> [ 0.300691][ T0] start_kernel (kbuild/src/x86_64-2/init/main.c:965)
> [ 0.301806][ T0] ? load_ucode_bsp (kbuild/src/x86_64-2/arch/x86/kernel/cpu/microcode/core.c:176)
> [ 0.302954][ T0] secondary_startup_64_no_verify (kbuild/src/x86_64-2/arch/x86/kernel/head_64.S:358)
> [    0.304315][    T0]  </TASK>
> [    0.305039][    T0] Modules linked in:
> [    0.305938][    T0] CR2: 0000000000000000
> [    0.306882][    T0] ---[ end trace 0000000000000000 ]---
> [ 0.307913][ T0] RIP: 0010:__stack_depot_save (kbuild/src/x86_64-2/lib/stackdepot.c:452)
> [ 0.309033][ T0] Code: 03 48 c7 c7 ec 17 b3 84 e8 91 e8 85 ff 44 89 e0 23 05 74 a8 01 03 48 8d 04 c3 48 89 c3 48 89 c7 48 89 44 24 28 e8 d4 f9 85 ff <4c> 8b 33 4d 85 f6 0f 84 b6 00 00 00 8b 04 24 83 e8 01 48 8d 04 c5
> All code
> ========
>    0:   03 48 c7                add    -0x39(%rax),%ecx
>    3:   c7                      (bad)
>    4:   ec                      in     (%dx),%al
>    5:   17                      (bad)
>    6:   b3 84                   mov    $0x84,%bl
>    8:   e8 91 e8 85 ff          callq  0xffffffffff85e89e
>    d:   44 89 e0                mov    %r12d,%eax
>   10:   23 05 74 a8 01 03       and    0x301a874(%rip),%eax        # 0x301a88a
>   16:   48 8d 04 c3             lea    (%rbx,%rax,8),%rax
>   1a:   48 89 c3                mov    %rax,%rbx
>   1d:   48 89 c7                mov    %rax,%rdi
>   20:   48 89 44 24 28          mov    %rax,0x28(%rsp)
>   25:   e8 d4 f9 85 ff          callq  0xffffffffff85f9fe
>   2a:*  4c 8b 33                mov    (%rbx),%r14              <-- trapping instruction
>   2d:   4d 85 f6                test   %r14,%r14
>   30:   0f 84 b6 00 00 00       je     0xec
>   36:   8b 04 24                mov    (%rsp),%eax
>   39:   83 e8 01                sub    $0x1,%eax
>   3c:   48                      rex.W
>   3d:   8d                      .byte 0x8d
>   3e:   04 c5                   add    $0xc5,%al
>
> Code starting with the faulting instruction
> ===========================================
>    0:   4c 8b 33                mov    (%rbx),%r14
>    3:   4d 85 f6                test   %r14,%r14
>    6:   0f 84 b6 00 00 00       je     0xc2
>    c:   8b 04 24                mov    (%rsp),%eax
>    f:   83 e8 01                sub    $0x1,%eax
>   12:   48                      rex.W
>   13:   8d                      .byte 0x8d
>   14:   04 c5                   add    $0xc5,%al
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-6.0.0-rc3-00707-g0e949320dbee .config
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>
