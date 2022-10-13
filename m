Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B25FD68A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJMJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJMJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:00:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429E74CFF;
        Thu, 13 Oct 2022 02:00:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x18so1531067ljm.1;
        Thu, 13 Oct 2022 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNE4qUQqzu93/6vXJMBQM2AFw2RHljprSLDwsm+neOU=;
        b=pVjyLBqDIjcgf0fgJNwZMzcNpxeOM71h9E4Bp9PFTFTAgazQm1KbsiM06kBgO5rzBj
         ubRqaxlFAxhzgOdGUaF5oP3KxWDUCNpT1Go5IVDuc9gtpVwBV47eoY0KkrXEnf3JxVRt
         yDiHetoYx02CsgbnjYGIeiC1t2cdcOKKDVbkjQ7OkpjceU8zDvx6yQbE2OraaLW+4VFB
         lI1Qxs1e+GgNx25g/fuQppf7LEBCWL3LVSFWkqiotLpj8VmqXwuvpTBj9GHvLWlYh9Ha
         7ieNjj7xUeHVPIln8I5XgAFxmsL2zMX2kmvd6wSO+khmgQMlV3Ga8smBb7kiXzty66+l
         i5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNE4qUQqzu93/6vXJMBQM2AFw2RHljprSLDwsm+neOU=;
        b=SZiPd1yBPglkTYN3voXDWIq9YrcApRPtRhmLqxprwlCY79S52WtW591iOCg8oIOvyP
         m2PfDCHeWZh5nT7sFLb+2lNe5vuyffU7SjOOmzGXFJm2AIMacHx6hEvx+YIZ3mtGSZBy
         AhQwEQeByIU7McHRRKHCcadYzT6fv34oFvWopJazLvTNLrdykpz4sxVH2X+rAy7vOTzx
         /ZABrrXKYWXZ8JbiAAZhx/FaTpzlk4Edd/hURwfR8aRPDrloJ5zO5DxMYsLFrVpO8C0q
         2u13dYRFKJELhOO8XYsUDK3q5p/5hANXsIpvoZnhBY5bf3LOA5zwquwiAyjyX/T7G7p3
         1UMw==
X-Gm-Message-State: ACrzQf0vYNuDXnCkL4Oic4K564RUEwx24OSvmjsu+ba6KgW5LMuA6Cbx
        5FIFSWN2JuBfIKVjyQNoNXM93r24+JiSeqkuzYQ=
X-Google-Smtp-Source: AMsMyM6KCovwcC+KuunmSDqNwoiu5h733rpSccVj0V9Bn4xNlfjwCRjdHTFwrkvx3z2vWyM7A52YsCtZDAsa2bT5/Oc=
X-Received: by 2002:a2e:beaa:0:b0:25e:34d0:4d57 with SMTP id
 a42-20020a2ebeaa000000b0025e34d04d57mr12480574ljr.329.1665651620845; Thu, 13
 Oct 2022 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1665561689-29498-1-git-send-email-zhaoyang.huang@unisoc.com>
 <202210131309.fe5427b-oliver.sang@intel.com> <CAGWkznE_BJ+_e7tt7CxVMHLbO5NMpq5U50WEZyubgPYJ5aR2DQ@mail.gmail.com>
 <252c19a1-ab66-2668-f005-86c85061351b@suse.cz>
In-Reply-To: <252c19a1-ab66-2668-f005-86c85061351b@suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 13 Oct 2022 16:59:51 +0800
Message-ID: <CAGWkznGCK4wdvoUKrJa=NqK1UQciMZ-io06gCyyfG3qXtmewTA@mail.gmail.com>
Subject: Re: [mm] db8d280d38: PANIC:early_exception
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, steve.kang@unisoc.com
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

On Thu, Oct 13, 2022 at 4:51 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/13/22 10:38, Zhaoyang Huang wrote:
> > @Vlastimil Could you please have an eye on this series of robot
> > reports which are caused by stack_depot_init related issues. The
> > problem arises from a very early access of stack_depot_save/init by
> > kmemleak within setup_arch which happens even before
> > stack_depot_early_init and zone related data ready. I would like to
> > suggest adding a criteria at the entrance check of stack_depot_save
> > which help the stackdepot API more aggregation and the caller free to
> > call
>
> From the report it seems to me the problem is in your set_track_prepare():
>
> +       if (!kmemleak_initialized)
> +               stack_depot_init();
>
> stack_depot_init() should be called only once and from well defined places,
> this looks like neither condition is met.
yes, but this is not the key point for this series problem as kmemleak
wants to access stack_depot_save during setup_arch and lead to NULL
stack_table access. To my understanding, there is no way to provide a
valid stack_table so far until stack_depot_early_init called. kmemleak
could take another action if it get a vacant trace_handle from
stack_depot_save.
>
> > [    0.062350][    T0]  ? stack_depot_init.cold+0x5/0xbd
> > [    0.063072][    T0]  ? set_track_prepare+0x6e/0x80
> > [    0.063957][    T0]  ?
> > __raw_callee_save___native_queued_spin_unlock+0x11/0x22
> > [    0.064952][    T0]  ? write_comp_data+0x2a/0x80
> > [    0.065623][    T0]  ? strncpy+0x2f/0x60
> > [    0.066205][    T0]  ? __create_object+0x10c/0x3c0
> > [    0.066904][    T0]  ? kmemleak_alloc_phys+0x6f/0x80
> > [    0.067561][    T0]  ? memblock_alloc_range_nid+0x274/0x28f
> > [    0.068396][    T0]  ? memblock_phys_alloc_range+0xa4/0xb3
> > [    0.069200][    T0]  ? reserve_real_mode+0x87/0xd7
> > [    0.069895][    T0]  ? setup_arch+0x6a9/0x995
> > [    0.070526][    T0]  ? start_kernel+0x7c/0x854
> > [    0.071195][    T0]  ? load_ucode_bsp+0x1bb/0x1c6
> > [    0.071875][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
> > [    0.072682][    T0]  </TASK>
> >
> > On Thu, Oct 13, 2022 at 1:58 PM kernel test robot <oliver.sang@intel.com> wrote:
> >>
> >>
> >> Hi zhaoyang.huang,
> >>
> >> seems this is the fix based on our report
> >>     "[mm]  0e949320db: BUG:kernel_NULL_pointer_dereference,address"
> >> at
> >>     https://lore.kernel.org/all/202210121406.d4ebc9bc-oliver.sang@intel.com/
> >> but now it seems have new issue. report FYI
> >>
> >>
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-11):
> >>
> >> commit: db8d280d38efb061ad1a57ce060cbb917a4cf503 ("[RFC PATCHv2] mm: use stack_depot for recording kmemleak's backtrace")
> >> url: https://github.com/intel-lab-lkp/linux/commits/zhaoyang-huang/mm-use-stack_depot-for-recording-kmemleak-s-backtrace/20221012-160458
> >> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> >> patch link: https://lore.kernel.org/linux-mm/1665561689-29498-1-git-send-email-zhaoyang.huang@unisoc.com
> >> patch subject: [RFC PATCHv2] mm: use stack_depot for recording kmemleak's backtrace
> >>
> >> in testcase: boot
> >>
> >> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>
> >>
> >> +-------------------------------+------------+------------+
> >> |                               | 95f1b43741 | db8d280d38 |
> >> +-------------------------------+------------+------------+
> >> | boot_successes                | 20         | 0          |
> >> | boot_failures                 | 0          | 18         |
> >> | PANIC:early_exception         | 0          | 18         |
> >> | RIP:nr_free_zone_pages        | 0          | 18         |
> >> | BUG:kernel_hang_in_boot_stage | 0          | 18         |
> >> +-------------------------------+------------+------------+
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >> | Link: https://lore.kernel.org/r/202210131309.fe5427b-oliver.sang@intel.com
> >>
> >>
> >> [    0.029254][    T0] Scan for SMP in [mem 0x00000000-0x000003ff]
> >> [    0.030178][    T0] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
> >> [    0.031080][    T0] Scan for SMP in [mem 0x000f0000-0x000fffff]
> >> [    0.043370][    T0] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
> >> [    0.044301][    T0]   mpc: f5bb0-f5c80
> >> PANIC: early exception 0x0e IP 10:ffffffff8149c282 error 0 cr2 0x1e08
> >> [    0.045770][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-00711-gdb8d280d38ef #5
> >> [    0.046970][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> >> [ 0.048356][ T0] RIP: 0010:nr_free_zone_pages (kbuild/src/x86_64-2/include/linux/mmzone.h:1478 kbuild/src/x86_64-2/include/linux/mmzone.h:1504 kbuild/src/x86_64-2/mm/page_alloc.c:5886)
> >> [ 0.049158][ T0] Code: e9 a3 5c 0b 00 0f 1f 00 e8 9b cd be ff 65 8b 05 14 b8 b8 7e 48 98 41 54 48 8b 04 c5 e0 e4 bc 83 53 89 fb 4c 8d 80 00 1e 00 00 <3b> b8 08 1e 00 00 72 5b 49 8b 10 45 31 e4 48 85 d2 75 05 eb 35 49
> >> All code
> >> ========
> >>    0:   e9 a3 5c 0b 00          jmpq   0xb5ca8
> >>    5:   0f 1f 00                nopl   (%rax)
> >>    8:   e8 9b cd be ff          callq  0xffffffffffbecda8
> >>    d:   65 8b 05 14 b8 b8 7e    mov    %gs:0x7eb8b814(%rip),%eax        # 0x7eb8b828
> >>   14:   48 98                   cltq
> >>   16:   41 54                   push   %r12
> >>   18:   48 8b 04 c5 e0 e4 bc    mov    -0x7c431b20(,%rax,8),%rax
> >>   1f:   83
> >>   20:   53                      push   %rbx
> >>   21:   89 fb                   mov    %edi,%ebx
> >>   23:   4c 8d 80 00 1e 00 00    lea    0x1e00(%rax),%r8
> >>   2a:*  3b b8 08 1e 00 00       cmp    0x1e08(%rax),%edi                <-- trapping instruction
> >>   30:   72 5b                   jb     0x8d
> >>   32:   49 8b 10                mov    (%r8),%rdx
> >>   35:   45 31 e4                xor    %r12d,%r12d
> >>   38:   48 85 d2                test   %rdx,%rdx
> >>   3b:   75 05                   jne    0x42
> >>   3d:   eb 35                   jmp    0x74
> >>   3f:   49                      rex.WB
> >>
> >> Code starting with the faulting instruction
> >> ===========================================
> >>    0:   3b b8 08 1e 00 00       cmp    0x1e08(%rax),%edi
> >>    6:   72 5b                   jb     0x63
> >>    8:   49 8b 10                mov    (%r8),%rdx
> >>    b:   45 31 e4                xor    %r12d,%r12d
> >>    e:   48 85 d2                test   %rdx,%rdx
> >>   11:   75 05                   jne    0x18
> >>   13:   eb 35                   jmp    0x4a
> >>   15:   49                      rex.WB
> >> [    0.051803][    T0] RSP: 0000:ffffffff83603d18 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> >> [    0.052881][    T0] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0001ffff84b317e0
> >> [    0.053932][    T0] RDX: 0000000000000485 RSI: 0001ffffffffffff RDI: 0000000000000002
> >> [    0.055007][    T0] RBP: ffffffff84b077d0 R08: 0000000000001e00 R09: 0000000000000000
> >> [    0.056054][    T0] R10: ffffffff81b16d30 R11: 0001ffff84b317e8 R12: 0000000000000001
> >> [    0.057088][    T0] R13: ffffffff84b077d8 R14: 0000000000098000 R15: 0000000000007000
> >> [    0.058160][    T0] FS:  0000000000000000(0000) GS:ffffffff842c9000(0000) knlGS:0000000000000000
> >> [    0.059440][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [    0.060381][    T0] CR2: 0000000000001e08 CR3: 00000000043b6000 CR4: 00000000000406a0
> >> [    0.061516][    T0] Call Trace:
> >> [    0.061969][    T0]  <TASK>
> >> [ 0.062350][ T0] ? stack_depot_init.cold (kbuild/src/x86_64-2/lib/stackdepot.c:258)
> >> [ 0.063072][ T0] ? set_track_prepare (kbuild/src/x86_64-2/mm/slub.c:752)
> >> [ 0.063957][ T0] ? __raw_callee_save___native_queued_spin_unlock (??:?)
> >> [ 0.064952][ T0] ? write_comp_data (kbuild/src/x86_64-2/kernel/kcov.c:236)
> >>
> >>
> >> To reproduce:
> >>
> >>         # build kernel
> >>         cd linux
> >>         cp config-6.0.0-rc3-00711-gdb8d280d38ef .config
> >>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> >>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> >>         cd <mod-install-dir>
> >>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> >>
> >>
> >>         git clone https://github.com/intel/lkp-tests.git
> >>         cd lkp-tests
> >>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> >>
> >>         # if come across any failure that blocks the test,
> >>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >>
> >>
> >>
> >> --
> >> 0-DAY CI Kernel Test Service
> >> https://01.org/lkp
> >>
> >>
>
