Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6785606572
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiJTQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJTQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:11:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9541BA1EF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:11:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f22so13999508qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjND8v0kxIDdqqvu1arlPzZY/50/bVt5UUHEd9Hc6l8=;
        b=b8ua3Wh8cy1kO+Zu7dDl4JVjOIHgFK8Rhcvmsq5Ho7fELSREC1zzyjlTxATwmwLfi/
         E0fx+Y6HzSGnvuiYa8nI5kDIi8/lkcvDogz5CAwGjgTwqDQga/XagkqDsPzwYYJ4VpFJ
         HFwbsKPgRgFd1VgWcxLP3tVx0UjaACjwLE0+Vhry9pa8aoI7bQVASHO7vfEqM3ZSDfCI
         clpCZHprXq6F4arPBXDU3DxoEF8FbX2s+jNQYYX23DBGrgcsxVya3J8PYlp3sR7HpEMB
         qdE50Y10CW2kzjHK1OrGKA1R5ZzKYlF35aYkW0oRDWVD8aORUdk5CW8KoUn4vdY7vxWz
         cLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjND8v0kxIDdqqvu1arlPzZY/50/bVt5UUHEd9Hc6l8=;
        b=zRoIzSMoAWp1wNbAtKCXuO0lA9d7EU+TaqcL09xcRQR09MofyHDa733Jnsemf9kFk6
         /Ou8auJSgVm4F6+5NdAj1Of96JSkAfYmO7qaKU7R+EL0nnRWpa92zMhcaeYvSQUeAK3+
         YsCxAyINZuGb1rpHL5fKAei5FjJdCpUL96qS4GT1gdXh4nf+aqYVCitgWA70LIb3bNS5
         q7p0Wl0tjKUvjP9epB01H3KU/xAr+g5GFOIdYF/yuRepIK0K3ksyZl3zuoI2rRQFzR1P
         PNSkp6RYpEfFqFU96c3HwJSGxfohISXMChkMp/q1x+k1nJJoHO2fA0ULxVvyBhsvsJD/
         m0UQ==
X-Gm-Message-State: ACrzQf3WyCCYm1VgibV1A7s06viAnHQk45eR5DirtAgGpoRw52CYkIgs
        KOzhqx0JuLTzeLSbiqQ8Xsio+5PFCno=
X-Google-Smtp-Source: AMsMyM7GqdNzjiBGJaTnfCxaENkgpRO+9WfJP67pnCVnH8960sskHK358GLJOg53xNtFAKSOAj03Bw==
X-Received: by 2002:a05:622a:591:b0:39c:f3c8:117c with SMTP id c17-20020a05622a059100b0039cf3c8117cmr11893331qtb.270.1666282282991;
        Thu, 20 Oct 2022 09:11:22 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2ddd:3518:c7e:dcca])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006ce2c3c48ebsm7620219qkp.77.2022.10.20.09.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:11:22 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:11:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        feng.tang@intel.com, ying.huang@intel.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [lib/cpumask] 6f9c07be9d:
 WARNING:at_include/linux/cpumask.h:#prefill_possible_map
Message-ID: <Y1FzKVLlLPrhb47D@yury-laptop>
References: <202210201612.9d7547bf-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210201612.9d7547bf-yujie.liu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:05:51PM +0800, kernel test robot wrote:
> feng.tang@intel.com, ying.huang@intel.com, Geert Uytterhoeven
> <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>
> BCC: "Du, Julie" <julie.du@intel.com>, "Li, Philip" <philip.li@intel.com>, "Sang, Oliver" <oliver.sang@intel.com>
> 
> Hi Yury,
> 
> We noticed that below patch adds a FORCE_NR_CPUS config, and it is
> expected to show a warning when this config is enabled and
> CONFIG_NR_CPUS doesn't match the actual number of CPUs we have. But we
> also noticed that it not only shows a warning but could also break boot
> test in some cases. We are not sure if the break is actually related to
> this patch or not, so we send this report FYI.
> 
> We noticed that a fix patch was posted at:
> 
> https://lore.kernel.org/all/20221019225939.1646349-1-yury.norov@gmail.com/
> 
> FORCE_NR_CPUS won't be enabled by allmodconfig or allyesconfig after
> applying the fix, but looks it could still be enabled by randconfig. Not
> sure if this is an expected behavior, but since our test robot runs many
> randconfig tests, this warning could still be triggered frequently and
> go to boot failure at last.
> 
> Please kindly help to give some advice on handling this config in our
> testing. Thanks.
> 
> Please check below report for more details:
> 
> 
> Greeting,

Hi guys,

Thanks for the report.

Indeed, if FORCE_NR_CPUS is enabled by randconfig, it may cause at least
boot warning. I'm either not sure if the following alloc_pages is
related to the config, but anyways...

The most logical solution would be disabling FORCE_NR_CPUS in
randconfig before building the kernel. We can do it in a post-script,
like:

make randconfig
scripts/config -d FORCE_NR_CPUS
scripts/config -e UNFORCE_NR_CPUS
make

Or we can create a pre-configuration file, so that randconfig would do
its work based on that. We already have such pre-configs for powerpc
and risc:
        arch/riscv/configs/32-bit.config
        arch/powerpc/configs/32-bit.config
        arch/powerpc/configs/64-bit.config
        arch/riscv/configs/64-bit.config

Maybe it's time to create a generic config of this sort.

Please let me know if that sounds sane to you. I'm not very familiar
to build system things, but I'll be happy to help implementing this,
if needed.

Thanks,
Yury
 
> FYI, we noticed WARNING:at_include/linux/cpumask.h:#prefill_possible_map due to commit (built with gcc-11):
> 
> commit: 6f9c07be9d020489326098801f0661f754c7c865 ("lib/cpumask: add FORCE_NR_CPUS config option")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [    1.202510][    T0] ------------[ cut here ]------------
> [    1.203154][    T0] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:47 prefill_possible_map+0x658/0x752
> [    1.204324][    T0] Modules linked in:
> [    1.204784][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc4-00007-g6f9c07be9d02 #1 932ff7067730c9c41b5dfbe76b284979ed361812
> [    1.206225][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    1.207440][    T0] RIP: 0010:prefill_possible_map+0x658/0x752
> [    1.208132][    T0] Code: 48 b8 c0 0c e9 ac f9 65 f1 d6 48 31 c3 41 81 fc 00 20 00 00 75 0f 48 b8 87 5c 7b 08 b0 8d fa be 48 01 c3 eb 08 48 c1 cb 04 90 <0f> 0b 90 48 b8 4e b5 bb 31 4d 01 2f 87 ba ff ff 37 00 48 31 c3 48
> [    1.210403][    T0] RSP: 0000:ffffffff86007ea0 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
> [    1.211453][    T0] RAX: d6f165f9ace90cc0 RBX: 12342d6dca2d2c88 RCX: 1ffffffff0cbcb9c
> [    1.212441][    T0] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    1.213417][    T0] RBP: ffffffff86007ec8 R08: 0000000000000000 R09: 0000000000000000
> [    1.214394][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> [    1.215355][    T0] R13: 0000000000002000 R14: 0000000000000002 R15: 0000000000000002
> [    1.216314][    T0] FS:  0000000000000000(0000) GS:ffffffff886ec000(0000) knlGS:0000000000000000
> [    1.217368][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.218158][    T0] CR2: ffff88843ffff000 CR3: 0000000006016000 CR4: 00000000000406b0
> [    1.219118][    T0] Call Trace:
> [    1.219495][    T0]  <TASK>
> [    1.219843][    T0]  ? setup_arch+0x12ed/0x14b8
> [    1.220390][    T0]  ? start_kernel+0xac/0x53a
> [    1.220942][    T0]  ? secondary_startup_64_no_verify+0xdf/0xeb
> [    1.221688][    T0]  </TASK>
> [    1.222041][    T0] irq event stamp: 0
> [    1.222491][    T0] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    1.223315][    T0] hardirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.224224][    T0] softirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    1.225052][    T0] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.225921][    T0] ---[ end trace 0000000000000000 ]---
> [    1.226613][    T0] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> [    1.227389][    T0] mapped IOAPIC to ffffffffff5fc000 (fec00000)
> [    1.228333][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI devices
> [    1.229282][    T0] Booting paravirtualized kernel on KVM
> [    1.229970][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    1.317066][    T0] ------------[ cut here ]------------
> [    1.317826][    T0] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:47 set_nr_cpu_ids+0x9/0x10
> [    1.319013][    T0] Modules linked in:
> [    1.319521][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.0.0-rc4-00007-g6f9c07be9d02 #1 932ff7067730c9c41b5dfbe76b284979ed361812
> [    1.321281][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    1.322636][    T0] RIP: 0010:set_nr_cpu_ids+0x9/0x10
> [    1.323315][    T0] Code: c4 90 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc 81 ff 00 20 00 00 74 04 90 <0f> 0b 90 31 ff c3 cc 41 57 41 56 49 89 fe 41 55 41 54 55 48 63 ee
> [    1.325852][    T0] RSP: 0000:ffffffff86007f18 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
> [    1.326960][    T0] RAX: 0000000000000001 RBX: 637a31c17f8457e0 RCX: b238ee5e1c5024c3
> [    1.327991][    T0] RDX: 194935e2cb673ce9 RSI: 0000000000000000 RDI: 0000000000000002
> [    1.329039][    T0] RBP: ffffffff86007f48 R08: 617720303d6e776f R09: 745f676f64686374
> [    1.330067][    T0] R10: 7268745f676f6468 R11: 003034323d687365 R12: 0000000000000000
> [    1.331141][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    1.332169][    T0] FS:  0000000000000000(0000) GS:ffffffff886ec000(0000) knlGS:0000000000000000
> [    1.333324][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.334181][    T0] CR2: ffff88843ffff000 CR3: 0000000006016000 CR4: 00000000000406b0
> [    1.335222][    T0] Call Trace:
> [    1.335652][    T0]  <TASK>
> [    1.336038][    T0]  start_kernel+0xbf/0x53a
> [    1.336634][    T0]  secondary_startup_64_no_verify+0xdf/0xeb
> [    1.337415][    T0]  </TASK>
> [    1.337810][    T0] irq event stamp: 0
> [    1.338324][    T0] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    1.339269][    T0] hardirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.340205][    T0] softirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    1.341135][    T0] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.342071][    T0] ---[ end trace 0000000000000000 ]---
> [    1.342799][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8192 nr_cpu_ids:8192 nr_node_ids:1
> [    1.345155][    T0] percpu: Embedded 72 pages/cpu s257888 r8192 d28832 u1048576
> [    1.346237][    T0] pcpu-alloc: s257888 r8192 d28832 u1048576 alloc=1*2097152
> ...
> 
> [    8.585546][    T1] UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
> [    8.588299][    T1] ------------[ cut here ]------------
> [    8.589520][    T1] WARNING: CPU: 1 PID: 1 at mm/page_alloc.c:5491 __alloc_pages+0xad/0x333
> [    8.591101][    T1] Modules linked in:
> [    8.591973][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.0.0-rc4-00007-g6f9c07be9d02 #1 932ff7067730c9c41b5dfbe76b284979ed361812
> [    8.594697][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    8.596715][    T1] RIP: 0010:__alloc_pages+0xad/0x333
> [    8.597876][    T1] Code: 0f ba e2 0d c7 44 24 20 01 00 00 00 f3 ab 72 22 83 fe 0a 76 26 80 3d 61 89 77 06 00 0f 85 3a 02 00 00 c6 05 54 89 77 06 01 90 <0f> 0b 90 e9 2a 02 00 00 83 fe 0a 0f 87 21 02 00 00 23 15 22 86 7d
> [    8.601650][    T1] RSP: 0000:ffffc9000001fc50 EFLAGS: 00010246
> [    8.602909][    T1] RAX: 0000000000000000 RBX: 1ffff92000003f8a RCX: 0000000000000000
> [    8.604579][    T1] RDX: 0000000000040cc0 RSI: 000000000000000b RDI: ffffc9000001fca8
> [    8.606320][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    8.607938][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000040cc0
> [    8.609652][    T1] R13: 000000000000000b R14: 0000000000800000 R15: dffffc0000000000
> [    8.611249][    T1] FS:  0000000000000000(0000) GS:ffff88839d100000(0000) knlGS:0000000000000000
> [    8.613115][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.614422][    T1] CR2: 0000000000000000 CR3: 0000000006016000 CR4: 00000000000406a0
> [    8.616073][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    8.617764][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    8.619379][    T1] Call Trace:
> [    8.620124][    T1]  <TASK>
> [    8.620782][    T1]  ? __alloc_pages_slowpath+0x82a/0x82a
> [    8.622189][    T1]  ? __raw_spin_lock_init+0x39/0x101
> [    8.623310][    T1]  kmalloc_order+0x33/0x9f
> [    8.624237][    T1]  kmalloc_order_trace+0x13/0x104
> [    8.626664][    T1]  udp_init+0x8b/0x1ab
> [    8.627574][    T1]  inet_init+0x399/0x572
> [    8.628477][    T1]  ? ipv4_mib_init_net+0x6ea/0x6ea
> [    8.629671][    T1]  do_one_initcall+0x140/0x30d
> [    8.630660][    T1]  ? rcu_lock_acquire+0x33/0x33
> [    8.631853][    T1]  ? rcu_read_lock_sched_held+0x70/0xcd
> [    8.633086][    T1]  ? lock_is_held+0x8/0x8
> [    8.634035][    T1]  ? trace_kmalloc+0x79/0xcf
> [    8.634998][    T1]  do_initcalls+0x30d/0x36b
> [    8.635953][    T1]  kernel_init_freeable+0x352/0x3b8
> [    8.637112][    T1]  ? rest_init+0x1b6/0x1b6
> [    8.638085][    T1]  kernel_init+0x14/0x124
> [    8.639035][    T1]  ret_from_fork+0x1f/0x30
> [    8.639958][    T1]  </TASK>
> [    8.640656][    T1] irq event stamp: 261127
> [    8.641672][    T1] hardirqs last  enabled at (261139): [<ffffffff81255553>] __up_console_sem+0x40/0x5c
> [    8.643581][    T1] hardirqs last disabled at (261148): [<ffffffff81255533>] __up_console_sem+0x20/0x5c
> [    8.645520][    T1] softirqs last  enabled at (261042): [<ffffffff8400056d>] __do_softirq+0x56d/0x61e
> [    8.647455][    T1] softirqs last disabled at (261037): [<ffffffff81190b9f>] __irq_exit_rcu+0xa0/0xe8
> [    8.649404][    T1] ---[ end trace 0000000000000000 ]---
> [    8.650547][    T1] Kernel panic - not syncing: UDP: failed to alloc udp_busylocks
> [    8.652035][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.0.0-rc4-00007-g6f9c07be9d02 #1 932ff7067730c9c41b5dfbe76b284979ed361812
> [    8.653378][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    8.653378][    T1] Call Trace:
> [    8.653378][    T1]  <TASK>
> [    8.653378][    T1]  dump_stack_lvl+0x57/0x86
> [    8.653378][    T1]  panic+0x21e/0x42d
> [    8.653378][    T1]  ? panic_print_sys_info+0x85/0x85
> [    8.653378][    T1]  ? rcu_read_lock_sched_held+0x70/0xcd
> [    8.653378][    T1]  ? lock_is_held+0x8/0x8
> [    8.653378][    T1]  udp_init+0x179/0x1ab
> [    8.653378][    T1]  inet_init+0x399/0x572
> [    8.653378][    T1]  ? ipv4_mib_init_net+0x6ea/0x6ea
> [    8.653378][    T1]  do_one_initcall+0x140/0x30d
> [    8.653378][    T1]  ? rcu_lock_acquire+0x33/0x33
> [    8.653378][    T1]  ? rcu_read_lock_sched_held+0x70/0xcd
> [    8.653378][    T1]  ? lock_is_held+0x8/0x8
> [    8.653378][    T1]  ? trace_kmalloc+0x79/0xcf
> [    8.653378][    T1]  do_initcalls+0x30d/0x36b
> [    8.653378][    T1]  kernel_init_freeable+0x352/0x3b8
> [    8.653378][    T1]  ? rest_init+0x1b6/0x1b6
> [    8.653378][    T1]  kernel_init+0x14/0x124
> [    8.653378][    T1]  ret_from_fork+0x1f/0x30
> [    8.653378][    T1]  </TASK>
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202210201612.9d7547bf-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-6.0.0-rc4-00007-g6f9c07be9d02 .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
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
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 6.0.0-rc4 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=110300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23900
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23900
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=123
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_UAPI_HEADER_TEST=y
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_SYSVIPC_COMPAT=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_WATCH_QUEUE=y
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_CONTEXT_TRACKING=y
> CONFIG_CONTEXT_TRACKING_IDLE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_BPF_JIT is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_PREEMPT_DYNAMIC is not set
> CONFIG_SCHED_CORE=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_FORCE_TASKS_RCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_FORCE_TASKS_RUDE_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_FORCE_TASKS_TRACE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_FANOUT=64
> CONFIG_RCU_FANOUT_LEAF=16
> # CONFIG_RCU_NOCB_CPU is not set
> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_PRINTK_INDEX=y
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> CONFIG_UCLAMP_TASK=y
> CONFIG_UCLAMP_BUCKETS_COUNT=5
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_CGROUPS=y
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CPUSETS is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> # CONFIG_TIME_NS is not set
> # CONFIG_IPC_NS is not set
> CONFIG_USER_NS=y
> # CONFIG_PID_NS is not set
> # CONFIG_NET_NS is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> # CONFIG_BOOT_CONFIG is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # end of Kernel Performance Events And Counters
> 
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_X86_X2APIC is not set
> # CONFIG_X86_MPPARSE is not set
> CONFIG_GOLDFISH=y
> # CONFIG_X86_CPU_RESCTRL is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> # CONFIG_IOSF_MBI is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_PARAVIRT_SPINLOCKS is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> # CONFIG_GART_IOMMU is not set
> CONFIG_BOOT_VESA_SUPPORT=y
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> # CONFIG_SCHED_CLUSTER is not set
> CONFIG_SCHED_SMT=y
> # CONFIG_SCHED_MC is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_PERF_EVENTS_AMD_UNCORE is not set
> # CONFIG_PERF_EVENTS_AMD_BRS is not set
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> # CONFIG_X86_IOPL_IOPERM is not set
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> # CONFIG_MICROCODE_AMD is not set
> # CONFIG_MICROCODE_LATE_LOADING is not set
> # CONFIG_X86_MSR is not set
> CONFIG_X86_CPUID=y
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> # CONFIG_AMD_MEM_ENCRYPT is not set
> # CONFIG_NUMA is not set
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> # CONFIG_X86_PMEM_LEGACY is not set
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_X86_UMIP=y
> CONFIG_CC_HAS_IBT=y
> # CONFIG_X86_KERNEL_IBT is not set
> # CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> CONFIG_X86_INTEL_TSX_MODE_ON=y
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_X86_SGX is not set
> # CONFIG_EFI is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_SCHED_HRTICK=y
> # CONFIG_KEXEC is not set
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> CONFIG_DEBUG_HOTPLUG_CPU0=y
> CONFIG_COMPAT_VDSO=y
> CONFIG_LEGACY_VSYSCALL_XONLY=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_CC_HAS_SLS=y
> CONFIG_CC_HAS_RETURN_THUNK=y
> CONFIG_SPECULATION_MITIGATIONS=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> # CONFIG_RETPOLINE is not set
> # CONFIG_CPU_IBPB_ENTRY is not set
> # CONFIG_CPU_IBRS_ENTRY is not set
> CONFIG_SLS=y
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_HIBERNATION is not set
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> CONFIG_PM_USERSPACE_AUTOSLEEP=y
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_DEBUGGER=y
> # CONFIG_ACPI_DEBUGGER_USER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_FPDT=y
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> # CONFIG_ACPI_BUTTON is not set
> CONFIG_ACPI_TINY_POWER_BUTTON=y
> CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> # CONFIG_ACPI_THERMAL is not set
> CONFIG_ACPI_PLATFORM_PROFILE=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=y
> CONFIG_ACPI_CUSTOM_METHOD=y
> # CONFIG_ACPI_NFIT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> # CONFIG_ACPI_APEI_GHES is not set
> CONFIG_ACPI_APEI_EINJ=y
> CONFIG_ACPI_APEI_ERST_DEBUG=y
> CONFIG_ACPI_DPTF=y
> CONFIG_DPTF_POWER=y
> CONFIG_DPTF_PCH_FIVR=y
> CONFIG_ACPI_CONFIGFS=y
> CONFIG_ACPI_PFRUT=y
> CONFIG_ACPI_PCC=y
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> # CONFIG_CPU_FREQ_STAT is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_AMD_PSTATE is not set
> # CONFIG_X86_ACPI_CPUFREQ is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_P4_CLOCKMOD=y
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_CPU_IDLE_GOV_TEO=y
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> # CONFIG_INTEL_IDLE is not set
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_MMCONF_FAM10H=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> CONFIG_X86_X32_ABI=y
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_MMU_GATHER_MERGE_VMAS=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_HAVE_OBJTOOL=y
> CONFIG_HAVE_JUMP_LABEL_HACK=y
> CONFIG_HAVE_NOINSTR_HACK=y
> CONFIG_HAVE_NOINSTR_VALIDATION=y
> CONFIG_HAVE_UACCESS_VALIDATION=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_ISA_BUS_API=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_ICQ=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=y
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_WBT=y
> # CONFIG_BLK_WBT_MQ is not set
> # CONFIG_BLK_DEBUG_FS is not set
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_ACORN_PARTITION=y
> # CONFIG_ACORN_PARTITION_CUMANA is not set
> # CONFIG_ACORN_PARTITION_EESOX is not set
> # CONFIG_ACORN_PARTITION_ICS is not set
> # CONFIG_ACORN_PARTITION_ADFS is not set
> # CONFIG_ACORN_PARTITION_POWERTEC is not set
> CONFIG_ACORN_PARTITION_RISCIX=y
> CONFIG_AIX_PARTITION=y
> CONFIG_OSF_PARTITION=y
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> # CONFIG_SGI_PARTITION is not set
> CONFIG_ULTRIX_PARTITION=y
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> # CONFIG_SYSV68_PARTITION is not set
> CONFIG_CMDLINE_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> # end of IO Schedulers
> 
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_ZPOOL=y
> CONFIG_SWAP=y
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="deflate"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=y
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_STAT=y
> 
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> CONFIG_SLUB_STATS=y
> CONFIG_SLUB_CPU_PARTIAL=y
> # end of SLAB allocator options
> 
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> # CONFIG_MEMORY_HOTPLUG is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_COMPACTION=y
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_FRONTSWAP=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=7
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ZONE_DMA=y
> CONFIG_ZONE_DMA32=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_SECRETMEM=y
> CONFIG_ANON_VMA_NAME=y
> # CONFIG_USERFAULTFD is not set
> 
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=y
> CONFIG_DAMON_VADDR=y
> CONFIG_DAMON_PADDR=y
> CONFIG_DAMON_SYSFS=y
> CONFIG_DAMON_DBGFS=y
> # CONFIG_DAMON_RECLAIM is not set
> # CONFIG_DAMON_LRU_SORT is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_COMPAT_NETLINK_MESSAGES=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> CONFIG_UNIX_DIAG=y
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_ADVANCED is not set
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_EGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NF_CONNTRACK=m
> CONFIG_NF_LOG_SYSLOG=m
> CONFIG_NF_CONNTRACK_SECMARK=y
> # CONFIG_NF_CONNTRACK_PROCFS is not set
> # CONFIG_NF_CONNTRACK_LABELS is not set
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_IRC=m
> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CT_NETLINK=m
> # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_SIP=m
> CONFIG_NF_NAT_MASQUERADE=y
> # CONFIG_NF_TABLES is not set
> CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XTABLES_COMPAT=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
> 
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> CONFIG_NETFILTER_XT_TARGET_LOG=m
> CONFIG_NETFILTER_XT_NAT=m
> # CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> # CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> # end of Core Netfilter Configuration
> 
> # CONFIG_IP_SET is not set
> # CONFIG_IP_VS is not set
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=m
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> # CONFIG_NF_DUP_IPV4 is not set
> CONFIG_NF_LOG_ARP=m
> CONFIG_NF_LOG_IPV4=m
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_NAT=m
> # CONFIG_IP_NF_TARGET_MASQUERADE is not set
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_RAW is not set
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> CONFIG_NF_REJECT_IPV6=m
> CONFIG_NF_LOG_IPV6=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> CONFIG_IP6_NF_MANGLE=m
> # CONFIG_IP6_NF_RAW is not set
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=m
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=y
> CONFIG_GARP=y
> CONFIG_MRP=y
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=y
> CONFIG_VLAN_8021Q_GVRP=y
> CONFIG_VLAN_8021Q_MVRP=y
> # CONFIG_DECNET is not set
> CONFIG_LLC=y
> CONFIG_LLC2=y
> # CONFIG_ATALK is not set
> CONFIG_X25=y
> CONFIG_LAPB=y
> CONFIG_PHONET=y
> # CONFIG_6LOWPAN is not set
> CONFIG_IEEE802154=y
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=y
> CONFIG_MAC802154=y
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=y
> # CONFIG_NET_SCH_HTB is not set
> CONFIG_NET_SCH_HFSC=y
> # CONFIG_NET_SCH_PRIO is not set
> CONFIG_NET_SCH_MULTIQ=y
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFB=y
> CONFIG_NET_SCH_SFQ=y
> CONFIG_NET_SCH_TEQL=y
> CONFIG_NET_SCH_TBF=y
> # CONFIG_NET_SCH_CBS is not set
> CONFIG_NET_SCH_ETF=y
> CONFIG_NET_SCH_TAPRIO=y
> CONFIG_NET_SCH_GRED=y
> CONFIG_NET_SCH_DSMARK=y
> CONFIG_NET_SCH_NETEM=y
> # CONFIG_NET_SCH_DRR is not set
> CONFIG_NET_SCH_MQPRIO=y
> CONFIG_NET_SCH_SKBPRIO=y
> CONFIG_NET_SCH_CHOKE=y
> CONFIG_NET_SCH_QFQ=y
> # CONFIG_NET_SCH_CODEL is not set
> # CONFIG_NET_SCH_FQ_CODEL is not set
> CONFIG_NET_SCH_CAKE=y
> CONFIG_NET_SCH_FQ=y
> # CONFIG_NET_SCH_HHF is not set
> CONFIG_NET_SCH_PIE=y
> CONFIG_NET_SCH_FQ_PIE=y
> CONFIG_NET_SCH_PLUG=y
> CONFIG_NET_SCH_ETS=y
> CONFIG_NET_SCH_DEFAULT=y
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_FQ_PIE is not set
> # CONFIG_DEFAULT_SFQ is not set
> CONFIG_DEFAULT_PFIFO_FAST=y
> CONFIG_DEFAULT_NET_SCH="pfifo_fast"
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> # CONFIG_NET_CLS_BASIC is not set
> CONFIG_NET_CLS_TCINDEX=y
> # CONFIG_NET_CLS_ROUTE4 is not set
> # CONFIG_NET_CLS_FW is not set
> # CONFIG_NET_CLS_U32 is not set
> # CONFIG_NET_CLS_RSVP is not set
> CONFIG_NET_CLS_RSVP6=y
> # CONFIG_NET_CLS_FLOW is not set
> # CONFIG_NET_CLS_CGROUP is not set
> # CONFIG_NET_CLS_BPF is not set
> CONFIG_NET_CLS_FLOWER=y
> # CONFIG_NET_CLS_MATCHALL is not set
> # CONFIG_NET_EMATCH is not set
> # CONFIG_NET_CLS_ACT is not set
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=m
> CONFIG_BATMAN_ADV=y
> CONFIG_BATMAN_ADV_BATMAN_V=y
> CONFIG_BATMAN_ADV_BLA=y
> CONFIG_BATMAN_ADV_DAT=y
> # CONFIG_BATMAN_ADV_NC is not set
> CONFIG_BATMAN_ADV_MCAST=y
> CONFIG_BATMAN_ADV_DEBUG=y
> # CONFIG_BATMAN_ADV_TRACING is not set
> # CONFIG_OPENVSWITCH is not set
> CONFIG_VSOCKETS=y
> CONFIG_VSOCKETS_DIAG=y
> # CONFIG_VSOCKETS_LOOPBACK is not set
> CONFIG_VIRTIO_VSOCKETS=y
> CONFIG_VIRTIO_VSOCKETS_COMMON=y
> # CONFIG_NETLINK_DIAG is not set
> CONFIG_MPLS=y
> # CONFIG_NET_MPLS_GSO is not set
> # CONFIG_MPLS_ROUTING is not set
> CONFIG_NET_NSH=y
> CONFIG_HSR=y
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> CONFIG_QRTR=y
> CONFIG_QRTR_SMD=y
> CONFIG_QRTR_TUN=y
> CONFIG_QRTR_MHI=y
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
> 
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=y
> # CONFIG_AX25_DAMA_SLAVE is not set
> # CONFIG_NETROM is not set
> CONFIG_ROSE=y
> 
> #
> # AX.25 network device drivers
> #
> CONFIG_MKISS=y
> # CONFIG_6PACK is not set
> # CONFIG_BPQETHER is not set
> CONFIG_BAYCOM_SER_FDX=y
> # CONFIG_BAYCOM_SER_HDX is not set
> CONFIG_YAM=y
> # end of AX.25 network device drivers
> 
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> # CONFIG_CAN_GW is not set
> CONFIG_CAN_J1939=y
> CONFIG_CAN_ISOTP=y
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> CONFIG_WIRELESS=y
> CONFIG_WIRELESS_EXT=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> CONFIG_WEXT_PRIV=y
> CONFIG_CFG80211=y
> # CONFIG_NL80211_TESTMODE is not set
> CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> # CONFIG_CFG80211_DEFAULT_PS is not set
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=y
> CONFIG_CFG80211_WEXT=y
> CONFIG_MAC80211=y
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> # CONFIG_MAC80211_MESH is not set
> CONFIG_MAC80211_LEDS=y
> # CONFIG_MAC80211_DEBUGFS is not set
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> CONFIG_MAC80211_DEBUG_MENU=y
> # CONFIG_MAC80211_NOINLINE is not set
> CONFIG_MAC80211_VERBOSE_DEBUG=y
> # CONFIG_MAC80211_MLME_DEBUG is not set
> # CONFIG_MAC80211_STA_DEBUG is not set
> # CONFIG_MAC80211_HT_DEBUG is not set
> CONFIG_MAC80211_OCB_DEBUG=y
> # CONFIG_MAC80211_IBSS_DEBUG is not set
> CONFIG_MAC80211_PS_DEBUG=y
> CONFIG_MAC80211_TDLS_DEBUG=y
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_FD=y
> CONFIG_NET_9P_VIRTIO=y
> CONFIG_NET_9P_DEBUG=y
> CONFIG_CAIF=y
> CONFIG_CAIF_DEBUG=y
> CONFIG_CAIF_NETDEV=y
> CONFIG_CAIF_USB=y
> # CONFIG_CEPH_LIB is not set
> CONFIG_NFC=y
> CONFIG_NFC_DIGITAL=y
> # CONFIG_NFC_NCI is not set
> CONFIG_NFC_HCI=y
> CONFIG_NFC_SHDLC=y
> 
> #
> # Near Field Communication (NFC) devices
> #
> CONFIG_NFC_TRF7970A=y
> # CONFIG_NFC_SIM is not set
> CONFIG_NFC_PN544=y
> CONFIG_NFC_PN544_I2C=y
> CONFIG_NFC_PN533=y
> CONFIG_NFC_PN533_I2C=y
> CONFIG_NFC_MICROREAD=y
> CONFIG_NFC_MICROREAD_I2C=y
> CONFIG_NFC_ST21NFCA=y
> CONFIG_NFC_ST21NFCA_I2C=y
> CONFIG_NFC_ST95HF=y
> # end of Near Field Communication (NFC) devices
> 
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_FAILOVER=y
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> CONFIG_EISA=y
> CONFIG_EISA_VLB_PRIMING=y
> CONFIG_EISA_PCI_EISA=y
> # CONFIG_EISA_VIRTUAL_ROOT is not set
> # CONFIG_EISA_NAMES is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_LOADER_COMPRESS_XZ=y
> CONFIG_FW_LOADER_COMPRESS_ZSTD=y
> CONFIG_FW_CACHE=y
> CONFIG_FW_UPLOAD=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SCCB=y
> CONFIG_REGMAP_SPI_AVMM=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MHI_BUS=y
> CONFIG_MHI_BUS_DEBUG=y
> # CONFIG_MHI_BUS_PCI_GENERIC is not set
> CONFIG_MHI_BUS_EP=y
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=y
> CONFIG_EDD_OFF=y
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_ISCSI_IBFT_FIND=y
> CONFIG_ISCSI_IBFT=y
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
> CONFIG_CS_DSP=y
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_SMI=y
> CONFIG_GOOGLE_COREBOOT_TABLE=y
> CONFIG_GOOGLE_MEMCONSOLE=y
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
> CONFIG_GOOGLE_VPD=y
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=y
> # CONFIG_NFTL is not set
> CONFIG_INFTL=y
> CONFIG_RFD_FTL=y
> CONFIG_SSFDC=y
> # CONFIG_SM_FTL is not set
> # CONFIG_MTD_OOPS is not set
> CONFIG_MTD_PSTORE=y
> CONFIG_MTD_SWAP=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> # CONFIG_MTD_CFI_NOSWAP is not set
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> CONFIG_MTD_CFI_LE_BYTE_SWAP=y
> CONFIG_MTD_CFI_GEOMETRY=y
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_MAP_BANK_WIDTH_8=y
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_32=y
> # CONFIG_MTD_CFI_I1 is not set
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> CONFIG_MTD_CFI_I8=y
> # CONFIG_MTD_OTP is not set
> CONFIG_MTD_CFI_INTELEXT=y
> # CONFIG_MTD_CFI_AMDSTD is not set
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> CONFIG_MTD_PHYSMAP=y
> # CONFIG_MTD_PHYSMAP_COMPAT is not set
> # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> CONFIG_MTD_SBC_GXX=y
> # CONFIG_MTD_AMD76XROM is not set
> # CONFIG_MTD_ICHXROM is not set
> # CONFIG_MTD_ESB2ROM is not set
> # CONFIG_MTD_CK804XROM is not set
> # CONFIG_MTD_SCB2_FLASH is not set
> # CONFIG_MTD_NETtel is not set
> # CONFIG_MTD_L440GX is not set
> # CONFIG_MTD_PCI is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_DATAFLASH=y
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> # CONFIG_MTD_DATAFLASH_OTP is not set
> CONFIG_MTD_MCHP23K256=y
> CONFIG_MTD_MCHP48L640=y
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> CONFIG_MTD_PHRAM=y
> CONFIG_MTD_MTDRAM=y
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> CONFIG_MTD_BLOCK2MTD=y
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=y
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> # CONFIG_MTD_ONENAND_GENERIC is not set
> CONFIG_MTD_ONENAND_OTP=y
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_RAW_NAND=y
> 
> #
> # Raw/parallel NAND flash controllers
> #
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> # CONFIG_MTD_NAND_CAFE is not set
> CONFIG_MTD_NAND_MXIC=y
> CONFIG_MTD_NAND_GPIO=y
> CONFIG_MTD_NAND_PLATFORM=y
> CONFIG_MTD_NAND_ARASAN=y
> 
> #
> # Misc
> #
> CONFIG_MTD_NAND_NANDSIM=y
> # CONFIG_MTD_NAND_RICOH is not set
> CONFIG_MTD_NAND_DISKONCHIP=y
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> # CONFIG_MTD_SPI_NAND is not set
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> CONFIG_MTD_NAND_ECC_MXIC=y
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> CONFIG_MTD_UBI_BLOCK=y
> # CONFIG_MTD_HYPERBUS is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_UBLK is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_COMMON=y
> CONFIG_NVME_CORE=y
> # CONFIG_BLK_DEV_NVME is not set
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_AUTH=y
> CONFIG_NVME_TARGET=y
> CONFIG_NVME_TARGET_PASSTHRU=y
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=y
> CONFIG_NVME_TARGET_FCLOOP=y
> # CONFIG_NVME_TARGET_TCP is not set
> # CONFIG_NVME_TARGET_AUTH is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> # CONFIG_AD525X_DPOT is not set
> CONFIG_DUMMY_IRQ=y
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> CONFIG_ICS932S401=y
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> CONFIG_LATTICE_ECP3_CONFIG=y
> CONFIG_SRAM=y
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_XILINX_SDFEC=y
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=y
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_EEPROM_EE1004=y
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_GENWQE is not set
> CONFIG_ECHO=y
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_HABANA_AI is not set
> CONFIG_PVPANIC=y
> CONFIG_PVPANIC_MMIO=y
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> CONFIG_CHR_DEV_ST=y
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> CONFIG_SCSI_SAS_LIBSAS=y
> # CONFIG_SCSI_SAS_ATA is not set
> # CONFIG_SCSI_SAS_HOST_SMP is not set
> CONFIG_SCSI_SRP_ATTRS=y
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> CONFIG_ISCSI_BOOT_SYSFS=y
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> CONFIG_SCSI_AHA1740=y
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_ISCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_EFCT is not set
> CONFIG_SCSI_SIM710=y
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=y
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> # CONFIG_ATA_VERBOSE_ERROR is not set
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> CONFIG_SATA_ZPODD=y
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> # CONFIG_SATA_AHCI is not set
> CONFIG_SATA_AHCI_PLATFORM=y
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> # CONFIG_ATA_SFF is not set
> # CONFIG_MD is not set
> CONFIG_TARGET_CORE=y
> CONFIG_TCM_IBLOCK=y
> CONFIG_TCM_FILEIO=y
> CONFIG_TCM_PSCSI=y
> CONFIG_TCM_USER2=y
> CONFIG_LOOPBACK_TARGET=y
> # CONFIG_ISCSI_TARGET is not set
> # CONFIG_SBP_TARGET is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> # CONFIG_FIREWIRE_OHCI is not set
> CONFIG_FIREWIRE_SBP2=y
> # CONFIG_FIREWIRE_NET is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_MHI_NET is not set
> # CONFIG_ARCNET is not set
> # CONFIG_CAIF_DRIVERS is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> # CONFIG_CAVIUM_PTP is not set
> # CONFIG_LIQUIDIO is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> CONFIG_NET_VENDOR_DAVICOM=y
> # CONFIG_DM9051 is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_FUNGIBLE=y
> CONFIG_NET_VENDOR_GOOGLE=y
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_I40E is not set
> # CONFIG_IGC is not set
> CONFIG_NET_VENDOR_WANGXUN=y
> # CONFIG_TXGBE is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_OCTEON_EP is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> # CONFIG_SFC_SIENA is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_CAN_DEV=y
> # CONFIG_CAN_VCAN is not set
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_NETLINK=y
> CONFIG_CAN_CALC_BITTIMING=y
> # CONFIG_CAN_CAN327 is not set
> # CONFIG_CAN_KVASER_PCIEFD is not set
> # CONFIG_CAN_SLCAN is not set
> # CONFIG_CAN_C_CAN is not set
> # CONFIG_CAN_CC770 is not set
> # CONFIG_CAN_CTUCANFD_PCI is not set
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> # CONFIG_CAN_SJA1000 is not set
> # CONFIG_CAN_SOFTING is not set
> 
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
> 
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> # CONFIG_ADM8211 is not set
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_ATH9K is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> # CONFIG_ATH11K is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> # CONFIG_ATMEL is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> # CONFIG_BRCMSMAC is not set
> # CONFIG_BRCMFMAC is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> # CONFIG_AIRO is not set
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> # CONFIG_IWLWIFI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_HERMES is not set
> # CONFIG_P54_COMMON is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> # CONFIG_MWIFIEX is not set
> # CONFIG_MWL8K is not set
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> # CONFIG_MT76x0E is not set
> # CONFIG_MT76x2E is not set
> # CONFIG_MT7603E is not set
> # CONFIG_MT7615E is not set
> # CONFIG_MT7663S is not set
> # CONFIG_MT7915E is not set
> # CONFIG_MT7921E is not set
> # CONFIG_MT7921S is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_PURELIFI=y
> CONFIG_WLAN_VENDOR_RALINK=y
> # CONFIG_RT2X00 is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_RTL8180 is not set
> CONFIG_RTL_CARDS=y
> # CONFIG_RTL8192CE is not set
> # CONFIG_RTL8192SE is not set
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> # CONFIG_RTW88 is not set
> # CONFIG_RTW89 is not set
> CONFIG_WLAN_VENDOR_RSI=y
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_SILABS=y
> # CONFIG_WFX is not set
> CONFIG_WLAN_VENDOR_ST=y
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=y
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_QTNFMAC_PCIE is not set
> # CONFIG_MAC80211_HWSIM is not set
> # CONFIG_VIRT_WIFI is not set
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=y
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5520 is not set
> CONFIG_KEYBOARD_ADP5588=y
> CONFIG_KEYBOARD_ADP5589=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> CONFIG_KEYBOARD_QT2160=y
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> CONFIG_KEYBOARD_LKKBD=y
> CONFIG_KEYBOARD_GPIO=y
> CONFIG_KEYBOARD_GPIO_POLLED=y
> CONFIG_KEYBOARD_TCA6416=y
> CONFIG_KEYBOARD_TCA8418=y
> # CONFIG_KEYBOARD_MATRIX is not set
> CONFIG_KEYBOARD_LM8323=y
> # CONFIG_KEYBOARD_LM8333 is not set
> CONFIG_KEYBOARD_MAX7359=y
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
> CONFIG_KEYBOARD_STOWAWAY=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_KEYBOARD_CROS_EC=y
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> CONFIG_KEYBOARD_CYPRESS_SF=y
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_PS2 is not set
> CONFIG_MOUSE_SERIAL=y
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=y
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=y
> CONFIG_JOYSTICK_A3D=y
> # CONFIG_JOYSTICK_ADC is not set
> CONFIG_JOYSTICK_ADI=y
> # CONFIG_JOYSTICK_COBRA is not set
> CONFIG_JOYSTICK_GF2K=y
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> CONFIG_JOYSTICK_INTERACT=y
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> CONFIG_JOYSTICK_TMDC=y
> CONFIG_JOYSTICK_IFORCE=y
> # CONFIG_JOYSTICK_IFORCE_232 is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> CONFIG_JOYSTICK_SPACEORB=y
> CONFIG_JOYSTICK_SPACEBALL=y
> CONFIG_JOYSTICK_STINGER=y
> CONFIG_JOYSTICK_TWIDJOY=y
> CONFIG_JOYSTICK_ZHENHUA=y
> # CONFIG_JOYSTICK_AS5011 is not set
> CONFIG_JOYSTICK_JOYDUMP=y
> # CONFIG_JOYSTICK_XPAD is not set
> CONFIG_JOYSTICK_PSXPAD_SPI=y
> # CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
> # CONFIG_JOYSTICK_PXRC is not set
> CONFIG_JOYSTICK_QWIIC=y
> # CONFIG_JOYSTICK_FSIA6B is not set
> # CONFIG_JOYSTICK_SENSEHAT is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> CONFIG_TOUCHSCREEN_AD7877=y
> CONFIG_TOUCHSCREEN_AD7879=y
> CONFIG_TOUCHSCREEN_AD7879_I2C=y
> # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> CONFIG_TOUCHSCREEN_ATMEL_MXT=y
> # CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
> CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
> CONFIG_TOUCHSCREEN_BU21013=y
> CONFIG_TOUCHSCREEN_BU21029=y
> CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
> CONFIG_TOUCHSCREEN_CY8CTMA140=y
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> CONFIG_TOUCHSCREEN_DA9052=y
> CONFIG_TOUCHSCREEN_DYNAPRO=y
> CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> # CONFIG_TOUCHSCREEN_EETI is not set
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> CONFIG_TOUCHSCREEN_HIDEEP=y
> CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
> CONFIG_TOUCHSCREEN_ILI210X=y
> CONFIG_TOUCHSCREEN_ILITEK=y
> CONFIG_TOUCHSCREEN_S6SY761=y
> CONFIG_TOUCHSCREEN_GUNZE=y
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> CONFIG_TOUCHSCREEN_ELO=y
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> CONFIG_TOUCHSCREEN_WACOM_I2C=y
> CONFIG_TOUCHSCREEN_MAX11801=y
> CONFIG_TOUCHSCREEN_MCS5000=y
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
> CONFIG_TOUCHSCREEN_MSG2638=y
> CONFIG_TOUCHSCREEN_MTOUCH=y
> CONFIG_TOUCHSCREEN_IMAGIS=y
> CONFIG_TOUCHSCREEN_INEXIO=y
> CONFIG_TOUCHSCREEN_MK712=y
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
> CONFIG_TOUCHSCREEN_UCB1400=y
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
> CONFIG_TOUCHSCREEN_WM831X=y
> # CONFIG_TOUCHSCREEN_WM97XX is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> CONFIG_TOUCHSCREEN_MC13783=y
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> CONFIG_TOUCHSCREEN_TSC200X_CORE=y
> CONFIG_TOUCHSCREEN_TSC2004=y
> CONFIG_TOUCHSCREEN_TSC2005=y
> CONFIG_TOUCHSCREEN_TSC2007=y
> # CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> CONFIG_TOUCHSCREEN_SILEAD=y
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> CONFIG_TOUCHSCREEN_ST1232=y
> CONFIG_TOUCHSCREEN_STMFTS=y
> CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
> CONFIG_TOUCHSCREEN_SX8654=y
> CONFIG_TOUCHSCREEN_TPS6507X=y
> CONFIG_TOUCHSCREEN_ZET6223=y
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
> CONFIG_TOUCHSCREEN_ROHM_BU21023=y
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> CONFIG_TOUCHSCREEN_ZINITIX=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_AD714X=y
> # CONFIG_INPUT_AD714X_I2C is not set
> CONFIG_INPUT_AD714X_SPI=y
> CONFIG_INPUT_ARIZONA_HAPTICS=y
> CONFIG_INPUT_ATC260X_ONKEY=y
> # CONFIG_INPUT_BMA150 is not set
> CONFIG_INPUT_E3X0_BUTTON=y
> # CONFIG_INPUT_PCSPKR is not set
> # CONFIG_INPUT_MAX77693_HAPTIC is not set
> # CONFIG_INPUT_MAX8925_ONKEY is not set
> CONFIG_INPUT_MC13783_PWRBUTTON=y
> # CONFIG_INPUT_MMA8450 is not set
> CONFIG_INPUT_APANEL=y
> CONFIG_INPUT_GPIO_BEEPER=y
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> CONFIG_INPUT_KXTJ9=y
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> # CONFIG_INPUT_RETU_PWRBUTTON is not set
> CONFIG_INPUT_AXP20X_PEK=y
> # CONFIG_INPUT_TWL6040_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PCF50633_PMU is not set
> CONFIG_INPUT_PCF8574=y
> # CONFIG_INPUT_PWM_BEEPER is not set
> CONFIG_INPUT_PWM_VIBRA=y
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> CONFIG_INPUT_DA7280_HAPTICS=y
> CONFIG_INPUT_DA9052_ONKEY=y
> CONFIG_INPUT_DA9055_ONKEY=y
> # CONFIG_INPUT_DA9063_ONKEY is not set
> CONFIG_INPUT_WM831X_ON=y
> CONFIG_INPUT_ADXL34X=y
> # CONFIG_INPUT_ADXL34X_I2C is not set
> CONFIG_INPUT_ADXL34X_SPI=y
> # CONFIG_INPUT_IQS269A is not set
> CONFIG_INPUT_IQS626A=y
> CONFIG_INPUT_IQS7222=y
> CONFIG_INPUT_CMA3000=y
> # CONFIG_INPUT_CMA3000_I2C is not set
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
> # CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
> CONFIG_INPUT_DRV260X_HAPTICS=y
> CONFIG_INPUT_DRV2665_HAPTICS=y
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_RMI4_CORE=y
> # CONFIG_RMI4_I2C is not set
> CONFIG_RMI4_SPI=y
> # CONFIG_RMI4_SMB is not set
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F54=y
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_SERIO_GPIO_PS2=y
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> # CONFIG_GAMEPORT_NS558 is not set
> # CONFIG_GAMEPORT_L4 is not set
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_LDISC_AUTOLOAD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_MEN_MCB=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> # CONFIG_SERIAL_8250_RSA is not set
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=y
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_PERICOM=y
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_MAX3100=y
> # CONFIG_SERIAL_MAX310X is not set
> CONFIG_SERIAL_UARTLITE=y
> # CONFIG_SERIAL_UARTLITE_CONSOLE is not set
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> # CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
> CONFIG_SERIAL_ALTERA_UART=y
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> # CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
> CONFIG_SERIAL_ARC=y
> CONFIG_SERIAL_ARC_CONSOLE=y
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> CONFIG_SERIAL_FSL_LINFLEXUART=y
> # CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
> # CONFIG_SERIAL_MEN_Z135 is not set
> CONFIG_SERIAL_SPRD=y
> # CONFIG_SERIAL_SPRD_CONSOLE is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_GOLDFISH_TTY=y
> CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> CONFIG_NULL_TTY=y
> CONFIG_HVC_DRIVER=y
> CONFIG_RPMSG_TTY=y
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_PANIC_STRING=y
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> # CONFIG_IPMI_SSIF is not set
> CONFIG_IPMI_IPMB=y
> CONFIG_IPMI_WATCHDOG=y
> CONFIG_IPMI_POWEROFF=y
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> CONFIG_HW_RANDOM_INTEL=y
> # CONFIG_HW_RANDOM_AMD is not set
> CONFIG_HW_RANDOM_BA431=y
> CONFIG_HW_RANDOM_VIA=y
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_XIPHERA=y
> # CONFIG_APPLICOM is not set
> CONFIG_MWAVE=y
> # CONFIG_DEVMEM is not set
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> # CONFIG_XILLYBUS is not set
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_ACPI_I2C_OPREGION is not set
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_MUX_GPIO=y
> CONFIG_I2C_MUX_LTC4306=y
> CONFIG_I2C_MUX_PCA9541=y
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_REG=y
> CONFIG_I2C_MUX_MLXCPLD=y
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_CHT_WC=y
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> CONFIG_I2C_EMEV2=y
> CONFIG_I2C_GPIO=y
> # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_TAOS_EVM=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=y
> CONFIG_I2C_CROS_EC_TUNNEL=y
> CONFIG_I2C_VIRTIO=y
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_SLAVE_TESTUNIT is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> # CONFIG_SPI_MEM is not set
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_CADENCE is not set
> CONFIG_SPI_DESIGNWARE=y
> # CONFIG_SPI_DW_DMA is not set
> # CONFIG_SPI_DW_PCI is not set
> # CONFIG_SPI_DW_MMIO is not set
> CONFIG_SPI_NXP_FLEXSPI=y
> CONFIG_SPI_GPIO=y
> # CONFIG_SPI_MICROCHIP_CORE is not set
> CONFIG_SPI_LANTIQ_SSC=y
> CONFIG_SPI_OC_TINY=y
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> CONFIG_SPI_SC18IS602=y
> # CONFIG_SPI_SIFIVE is not set
> CONFIG_SPI_MXIC=y
> CONFIG_SPI_XCOMM=y
> CONFIG_SPI_XILINX=y
> CONFIG_SPI_ZYNQMP_GQSPI=y
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> CONFIG_SPI_MUX=y
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=y
> # CONFIG_SPI_LOOPBACK_TEST is not set
> CONFIG_SPI_TLE62X0=y
> CONFIG_SPI_SLAVE=y
> # CONFIG_SPI_SLAVE_TIME is not set
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=y
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PTP_1588_CLOCK_KVM=y
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> CONFIG_PTP_1588_CLOCK_IDTCM=y
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> CONFIG_PINCTRL_SX150X=y
> 
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> CONFIG_PINCTRL_LYNXPOINT=y
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_ALDERLAKE=y
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> CONFIG_PINCTRL_DENVERTON=y
> CONFIG_PINCTRL_ELKHARTLAKE=y
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=y
> CONFIG_PINCTRL_ICELAKE=y
> CONFIG_PINCTRL_JASPERLAKE=y
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=y
> CONFIG_PINCTRL_METEORLAKE=y
> CONFIG_PINCTRL_SUNRISEPOINT=y
> CONFIG_PINCTRL_TIGERLAKE=y
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=y
> CONFIG_GPIO_CDEV_V1=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_MB86S7X=y
> # CONFIG_GPIO_MENZ127 is not set
> CONFIG_GPIO_SIOX=y
> # CONFIG_GPIO_VX855 is not set
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> CONFIG_GPIO_IT87=y
> CONFIG_GPIO_SCH311X=y
> CONFIG_GPIO_WINBOND=y
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> CONFIG_GPIO_PCA953X=y
> # CONFIG_GPIO_PCA953X_IRQ is not set
> CONFIG_GPIO_PCA9570=y
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ADP5520=y
> # CONFIG_GPIO_ARIZONA is not set
> CONFIG_GPIO_BD9571MWV=y
> CONFIG_GPIO_DA9052=y
> CONFIG_GPIO_DA9055=y
> CONFIG_GPIO_LP3943=y
> CONFIG_GPIO_LP873X=y
> CONFIG_GPIO_TPS65086=y
> # CONFIG_GPIO_TPS6586X is not set
> CONFIG_GPIO_TQMX86=y
> CONFIG_GPIO_TWL6040=y
> CONFIG_GPIO_UCB1400=y
> # CONFIG_GPIO_WHISKEY_COVE is not set
> CONFIG_GPIO_WM831X=y
> CONFIG_GPIO_WM8994=y
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> CONFIG_GPIO_MAX7301=y
> CONFIG_GPIO_MC33880=y
> CONFIG_GPIO_PISOSR=y
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> CONFIG_W1_MASTER_DS2482=y
> CONFIG_W1_MASTER_DS1WM=y
> CONFIG_W1_MASTER_GPIO=y
> # CONFIG_W1_MASTER_SGI is not set
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=y
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> # CONFIG_W1_SLAVE_DS2423 is not set
> # CONFIG_W1_SLAVE_DS2805 is not set
> # CONFIG_W1_SLAVE_DS2430 is not set
> CONFIG_W1_SLAVE_DS2431=y
> # CONFIG_W1_SLAVE_DS2433 is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=y
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> # CONFIG_W1_SLAVE_DS28E04 is not set
> CONFIG_W1_SLAVE_DS28E17=y
> # end of 1-wire Slaves
> 
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> CONFIG_GENERIC_ADC_BATTERY=y
> # CONFIG_IP5XXX_POWER is not set
> CONFIG_MAX8925_POWER=y
> # CONFIG_WM831X_BACKUP is not set
> # CONFIG_WM831X_POWER is not set
> # CONFIG_TEST_POWER is not set
> CONFIG_CHARGER_ADP5061=y
> # CONFIG_BATTERY_CW2015 is not set
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> CONFIG_BATTERY_DS2781=y
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> CONFIG_MANAGER_SBS=y
> CONFIG_BATTERY_BQ27XXX=y
> # CONFIG_BATTERY_BQ27XXX_I2C is not set
> # CONFIG_BATTERY_BQ27XXX_HDQ is not set
> CONFIG_BATTERY_DA9052=y
> CONFIG_CHARGER_DA9150=y
> CONFIG_BATTERY_DA9150=y
> # CONFIG_AXP20X_POWER is not set
> CONFIG_BATTERY_MAX17040=y
> CONFIG_BATTERY_MAX17042=y
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_CHARGER_PCF50633=y
> # CONFIG_CHARGER_MAX8903 is not set
> CONFIG_CHARGER_LP8727=y
> # CONFIG_CHARGER_LP8788 is not set
> # CONFIG_CHARGER_GPIO is not set
> CONFIG_CHARGER_MANAGER=y
> # CONFIG_CHARGER_LT3651 is not set
> CONFIG_CHARGER_LTC4162L=y
> CONFIG_CHARGER_MAX77976=y
> # CONFIG_CHARGER_MAX8998 is not set
> CONFIG_CHARGER_MT6360=y
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=y
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ2515X=y
> CONFIG_CHARGER_BQ25890=y
> # CONFIG_CHARGER_BQ25980 is not set
> CONFIG_CHARGER_BQ256XX=y
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_CHARGER_TPS65090 is not set
> CONFIG_BATTERY_GAUGE_LTC2941=y
> # CONFIG_BATTERY_GOLDFISH is not set
> CONFIG_BATTERY_RT5033=y
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_CHARGER_BD99954=y
> CONFIG_BATTERY_UG3105=y
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> CONFIG_HWMON_DEBUG_CHIP=y
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> CONFIG_SENSORS_ABITUGURU3=y
> CONFIG_SENSORS_AD7314=y
> CONFIG_SENSORS_AD7414=y
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> CONFIG_SENSORS_ADM1026=y
> CONFIG_SENSORS_ADM1029=y
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> CONFIG_SENSORS_ADT7X10=y
> CONFIG_SENSORS_ADT7310=y
> # CONFIG_SENSORS_ADT7410 is not set
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> CONFIG_SENSORS_AHT10=y
> CONFIG_SENSORS_AS370=y
> CONFIG_SENSORS_ASC7621=y
> CONFIG_SENSORS_AXI_FAN_CONTROL=y
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> CONFIG_SENSORS_APPLESMC=y
> CONFIG_SENSORS_ASB100=y
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=y
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> CONFIG_SENSORS_CORSAIR_PSU=y
> CONFIG_SENSORS_DRIVETEMP=y
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=y
> # CONFIG_I8K is not set
> CONFIG_SENSORS_DA9052_ADC=y
> # CONFIG_SENSORS_DA9055 is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> CONFIG_SENSORS_F71805F=y
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_MC13783_ADC=y
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=y
> # CONFIG_SENSORS_G762 is not set
> CONFIG_SENSORS_HIH6130=y
> CONFIG_SENSORS_IBMAEM=y
> CONFIG_SENSORS_IBMPEX=y
> # CONFIG_SENSORS_IIO_HWMON is not set
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> # CONFIG_SENSORS_JC42 is not set
> CONFIG_SENSORS_POWR1220=y
> CONFIG_SENSORS_LINEAGE=y
> CONFIG_SENSORS_LTC2945=y
> CONFIG_SENSORS_LTC2947=y
> # CONFIG_SENSORS_LTC2947_I2C is not set
> CONFIG_SENSORS_LTC2947_SPI=y
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC2992=y
> # CONFIG_SENSORS_LTC4151 is not set
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> # CONFIG_SENSORS_MAX1111 is not set
> CONFIG_SENSORS_MAX127=y
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> CONFIG_SENSORS_MAX31722=y
> CONFIG_SENSORS_MAX31730=y
> # CONFIG_SENSORS_MAX6620 is not set
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> CONFIG_SENSORS_MAX31790=y
> # CONFIG_SENSORS_MCP3021 is not set
> CONFIG_SENSORS_MLXREG_FAN=y
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_TPS23861=y
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> CONFIG_SENSORS_MR75203=y
> CONFIG_SENSORS_ADCXX=y
> CONFIG_SENSORS_LM63=y
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> # CONFIG_SENSORS_LM80 is not set
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> # CONFIG_SENSORS_LM93 is not set
> CONFIG_SENSORS_LM95234=y
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=y
> CONFIG_SENSORS_NTC_THERMISTOR=y
> CONFIG_SENSORS_NCT6683=y
> CONFIG_SENSORS_NCT6775_CORE=y
> CONFIG_SENSORS_NCT6775=y
> CONFIG_SENSORS_NCT6775_I2C=y
> # CONFIG_SENSORS_NCT7802 is not set
> CONFIG_SENSORS_NPCM7XX=y
> # CONFIG_SENSORS_PCF8591 is not set
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=y
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
> # CONFIG_SENSORS_FSP_3Y is not set
> CONFIG_SENSORS_IBM_CFFPS=y
> CONFIG_SENSORS_DPS920AB=y
> CONFIG_SENSORS_INSPUR_IPSPS=y
> CONFIG_SENSORS_IR35221=y
> # CONFIG_SENSORS_IR36021 is not set
> CONFIG_SENSORS_IR38064=y
> # CONFIG_SENSORS_IR38064_REGULATOR is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> # CONFIG_SENSORS_LM25066 is not set
> CONFIG_SENSORS_LT7182S=y
> CONFIG_SENSORS_LTC2978=y
> # CONFIG_SENSORS_LTC2978_REGULATOR is not set
> # CONFIG_SENSORS_LTC3815 is not set
> CONFIG_SENSORS_MAX15301=y
> CONFIG_SENSORS_MAX16064=y
> CONFIG_SENSORS_MAX16601=y
> CONFIG_SENSORS_MAX20730=y
> # CONFIG_SENSORS_MAX20751 is not set
> CONFIG_SENSORS_MAX31785=y
> CONFIG_SENSORS_MAX34440=y
> CONFIG_SENSORS_MAX8688=y
> CONFIG_SENSORS_MP2888=y
> CONFIG_SENSORS_MP2975=y
> CONFIG_SENSORS_MP5023=y
> CONFIG_SENSORS_PIM4328=y
> CONFIG_SENSORS_PLI1209BC=y
> # CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
> # CONFIG_SENSORS_PM6764TR is not set
> CONFIG_SENSORS_PXE1610=y
> CONFIG_SENSORS_Q54SJ108A2=y
> # CONFIG_SENSORS_STPDDC60 is not set
> CONFIG_SENSORS_TPS40422=y
> CONFIG_SENSORS_TPS53679=y
> # CONFIG_SENSORS_UCD9000 is not set
> # CONFIG_SENSORS_UCD9200 is not set
> CONFIG_SENSORS_XDPE152=y
> CONFIG_SENSORS_XDPE122=y
> # CONFIG_SENSORS_XDPE122_REGULATOR is not set
> # CONFIG_SENSORS_ZL6100 is not set
> # CONFIG_SENSORS_SBTSI is not set
> CONFIG_SENSORS_SBRMI=y
> CONFIG_SENSORS_SHT15=y
> # CONFIG_SENSORS_SHT21 is not set
> CONFIG_SENSORS_SHT3x=y
> # CONFIG_SENSORS_SHT4x is not set
> CONFIG_SENSORS_SHTC1=y
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_SY7636A=y
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=y
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_ADS7871=y
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> CONFIG_SENSORS_INA238=y
> CONFIG_SENSORS_INA3221=y
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> CONFIG_SENSORS_TMP108=y
> CONFIG_SENSORS_TMP401=y
> CONFIG_SENSORS_TMP421=y
> CONFIG_SENSORS_TMP464=y
> CONFIG_SENSORS_TMP513=y
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> CONFIG_SENSORS_VT1211=y
> # CONFIG_SENSORS_VT8231 is not set
> CONFIG_SENSORS_W83773G=y
> # CONFIG_SENSORS_W83781D is not set
> CONFIG_SENSORS_W83791D=y
> # CONFIG_SENSORS_W83792D is not set
> CONFIG_SENSORS_W83793=y
> # CONFIG_SENSORS_W83795 is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> # CONFIG_SENSORS_W83627HF is not set
> CONFIG_SENSORS_W83627EHF=y
> # CONFIG_SENSORS_WM831X is not set
> CONFIG_SENSORS_XGENE=y
> CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=y
> CONFIG_SENSORS_ATK0110=y
> CONFIG_SENSORS_ASUS_EC=y
> CONFIG_THERMAL=y
> CONFIG_THERMAL_NETLINK=y
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_DEVFREQ_THERMAL=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_THERMAL_VECTOR=y
> CONFIG_X86_PKG_TEMP_THERMAL=y
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_BXT_PMIC_THERMAL is not set
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_INTEL_TCC_COOLING is not set
> CONFIG_INTEL_HFI_THERMAL=y
> # end of Intel thermal drivers
> 
> # CONFIG_GENERIC_ADC_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> # CONFIG_BCMA_DRIVER_GPIO is not set
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> CONFIG_PMIC_ADP5520=y
> CONFIG_MFD_AAT2870_CORE=y
> CONFIG_MFD_BCM590XX=y
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> # CONFIG_MFD_CROS_EC_DEV is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_SPI=y
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> # CONFIG_MFD_DA9062 is not set
> CONFIG_MFD_DA9063=y
> CONFIG_MFD_DA9150=y
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_SPI=y
> CONFIG_MFD_MC13XXX_I2C=y
> CONFIG_MFD_MP2629=y
> CONFIG_HTC_PASIC3=y
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_INTEL_SOC_PMIC is not set
> CONFIG_INTEL_SOC_PMIC_BXTWC=y
> CONFIG_INTEL_SOC_PMIC_CHTWC=y
> CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
> CONFIG_INTEL_SOC_PMIC_MRFLD=y
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> CONFIG_MFD_INTEL_PMC_BXT=y
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=y
> CONFIG_MFD_MAX8925=y
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> CONFIG_MFD_MT6360=y
> CONFIG_MFD_MT6397=y
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> # CONFIG_PCF50633_ADC is not set
> CONFIG_PCF50633_GPIO=y
> CONFIG_UCB1400_CORE=y
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> CONFIG_MFD_RT5033=y
> # CONFIG_MFD_RC5T583 is not set
> CONFIG_MFD_SI476X_CORE=y
> CONFIG_MFD_SIMPLE_MFD_I2C=y
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> CONFIG_MFD_SKY81452=y
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> CONFIG_MFD_LP3943=y
> CONFIG_MFD_LP8788=y
> CONFIG_MFD_TI_LMU=y
> # CONFIG_MFD_PALMAS is not set
> CONFIG_TPS6105X=y
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=y
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TPS6586X=y
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> CONFIG_TWL6040_CORE=y
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> CONFIG_MFD_TQMX86=y
> # CONFIG_MFD_VX855 is not set
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> CONFIG_MFD_ARIZONA_SPI=y
> CONFIG_MFD_CS47L24=y
> CONFIG_MFD_WM5102=y
> CONFIG_MFD_WM5110=y
> CONFIG_MFD_WM8997=y
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM831X_SPI=y
> # CONFIG_MFD_WM8350_I2C is not set
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_WCD934X is not set
> CONFIG_MFD_ATC260X=y
> CONFIG_MFD_ATC260X_I2C=y
> CONFIG_MFD_INTEL_M10_BMC=y
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> # CONFIG_REGULATOR_88PG86X is not set
> CONFIG_REGULATOR_ACT8865=y
> CONFIG_REGULATOR_AD5398=y
> CONFIG_REGULATOR_AAT2870=y
> # CONFIG_REGULATOR_ARIZONA_LDO1 is not set
> CONFIG_REGULATOR_ARIZONA_MICSUPP=y
> CONFIG_REGULATOR_ATC260X=y
> # CONFIG_REGULATOR_AXP20X is not set
> CONFIG_REGULATOR_BCM590XX=y
> CONFIG_REGULATOR_BD9571MWV=y
> CONFIG_REGULATOR_DA9052=y
> # CONFIG_REGULATOR_DA9055 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_ISL9305=y
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LM363X=y
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=y
> # CONFIG_REGULATOR_LP8788 is not set
> CONFIG_REGULATOR_LTC3589=y
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX1586=y
> CONFIG_REGULATOR_MAX8649=y
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8893 is not set
> CONFIG_REGULATOR_MAX8907=y
> CONFIG_REGULATOR_MAX8925=y
> CONFIG_REGULATOR_MAX8952=y
> CONFIG_REGULATOR_MAX8998=y
> CONFIG_REGULATOR_MAX20086=y
> # CONFIG_REGULATOR_MAX77693 is not set
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=y
> # CONFIG_REGULATOR_MC13783 is not set
> CONFIG_REGULATOR_MC13892=y
> CONFIG_REGULATOR_MP8859=y
> CONFIG_REGULATOR_MT6311=y
> CONFIG_REGULATOR_MT6323=y
> # CONFIG_REGULATOR_MT6358 is not set
> CONFIG_REGULATOR_MT6359=y
> CONFIG_REGULATOR_MT6360=y
> CONFIG_REGULATOR_MT6397=y
> # CONFIG_REGULATOR_PCA9450 is not set
> CONFIG_REGULATOR_PCF50633=y
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> CONFIG_REGULATOR_PV88090=y
> # CONFIG_REGULATOR_PWM is not set
> CONFIG_REGULATOR_RT4801=y
> # CONFIG_REGULATOR_RT5033 is not set
> # CONFIG_REGULATOR_RT5190A is not set
> CONFIG_REGULATOR_RT5759=y
> # CONFIG_REGULATOR_RT6160 is not set
> CONFIG_REGULATOR_RT6245=y
> # CONFIG_REGULATOR_RTQ2134 is not set
> # CONFIG_REGULATOR_RTMV20 is not set
> # CONFIG_REGULATOR_RTQ6752 is not set
> CONFIG_REGULATOR_SKY81452=y
> CONFIG_REGULATOR_SLG51000=y
> # CONFIG_REGULATOR_SY7636A is not set
> CONFIG_REGULATOR_TPS51632=y
> CONFIG_REGULATOR_TPS6105X=y
> CONFIG_REGULATOR_TPS62360=y
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65086=y
> # CONFIG_REGULATOR_TPS65090 is not set
> CONFIG_REGULATOR_TPS65132=y
> # CONFIG_REGULATOR_TPS6524X is not set
> # CONFIG_REGULATOR_TPS6586X is not set
> CONFIG_REGULATOR_WM831X=y
> CONFIG_REGULATOR_WM8994=y
> CONFIG_RC_CORE=y
> # CONFIG_LIRC is not set
> CONFIG_RC_MAP=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_IMON_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> # CONFIG_IR_NEC_DECODER is not set
> # CONFIG_IR_RC5_DECODER is not set
> CONFIG_IR_RC6_DECODER=y
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_IR_SANYO_DECODER is not set
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_SONY_DECODER=y
> CONFIG_IR_XMP_DECODER=y
> CONFIG_RC_DEVICES=y
> CONFIG_IR_ENE=y
> CONFIG_IR_FINTEK=y
> CONFIG_IR_ITE_CIR=y
> # CONFIG_IR_NUVOTON is not set
> CONFIG_IR_SERIAL=y
> # CONFIG_IR_SERIAL_TRANSMITTER is not set
> CONFIG_IR_WINBOND_CIR=y
> CONFIG_RC_LOOPBACK=y
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_RC=y
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=y
> CONFIG_MEDIA_SUPPORT_FILTER=y
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> CONFIG_MEDIA_SDR_SUPPORT=y
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=y
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=y
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> CONFIG_VIDEO_ADV_DEBUG=y
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_V4L2_FWNODE=y
> CONFIG_V4L2_ASYNC=y
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
> CONFIG_DVB_ULE_DEBUG=y
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_DRIVERS is not set
> 
> #
> # MMC/SDIO DVB adapters
> #
> # CONFIG_SMS_SDIO_DRV is not set
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=y
> CONFIG_DVB_FIREDTV_INPUT=y
> CONFIG_VIDEOBUF2_CORE=y
> CONFIG_VIDEOBUF2_V4L2=y
> CONFIG_VIDEOBUF2_MEMOPS=y
> CONFIG_VIDEOBUF2_VMALLOC=y
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> CONFIG_VIDEO_IR_I2C=y
> 
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_APTINA_PLL=y
> # CONFIG_VIDEO_AR0521 is not set
> CONFIG_VIDEO_HI556=y
> CONFIG_VIDEO_HI846=y
> # CONFIG_VIDEO_HI847 is not set
> # CONFIG_VIDEO_IMX208 is not set
> CONFIG_VIDEO_IMX214=y
> CONFIG_VIDEO_IMX219=y
> CONFIG_VIDEO_IMX258=y
> CONFIG_VIDEO_IMX274=y
> # CONFIG_VIDEO_IMX290 is not set
> CONFIG_VIDEO_IMX319=y
> CONFIG_VIDEO_IMX355=y
> CONFIG_VIDEO_MAX9271_LIB=y
> CONFIG_VIDEO_MT9M001=y
> CONFIG_VIDEO_MT9M032=y
> CONFIG_VIDEO_MT9M111=y
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T001 is not set
> CONFIG_VIDEO_MT9T112=y
> CONFIG_VIDEO_MT9V011=y
> # CONFIG_VIDEO_MT9V032 is not set
> CONFIG_VIDEO_MT9V111=y
> CONFIG_VIDEO_NOON010PC30=y
> # CONFIG_VIDEO_OG01A1B is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV08D10 is not set
> # CONFIG_VIDEO_OV13858 is not set
> CONFIG_VIDEO_OV13B10=y
> CONFIG_VIDEO_OV2640=y
> CONFIG_VIDEO_OV2659=y
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> CONFIG_VIDEO_OV2740=y
> CONFIG_VIDEO_OV5647=y
> CONFIG_VIDEO_OV5648=y
> CONFIG_VIDEO_OV5670=y
> CONFIG_VIDEO_OV5675=y
> CONFIG_VIDEO_OV5693=y
> CONFIG_VIDEO_OV5695=y
> CONFIG_VIDEO_OV6650=y
> CONFIG_VIDEO_OV7251=y
> CONFIG_VIDEO_OV7640=y
> CONFIG_VIDEO_OV7670=y
> CONFIG_VIDEO_OV772X=y
> CONFIG_VIDEO_OV7740=y
> CONFIG_VIDEO_OV8856=y
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9640 is not set
> CONFIG_VIDEO_OV9650=y
> # CONFIG_VIDEO_OV9734 is not set
> CONFIG_VIDEO_RDACM20=y
> # CONFIG_VIDEO_RDACM21 is not set
> CONFIG_VIDEO_RJ54N1=y
> CONFIG_VIDEO_S5C73M3=y
> # CONFIG_VIDEO_S5K4ECGX is not set
> CONFIG_VIDEO_S5K5BAF=y
> CONFIG_VIDEO_S5K6A3=y
> CONFIG_VIDEO_S5K6AA=y
> CONFIG_VIDEO_SR030PC30=y
> CONFIG_VIDEO_VS6624=y
> # CONFIG_VIDEO_CCS is not set
> CONFIG_VIDEO_ET8EK8=y
> CONFIG_VIDEO_M5MOLS=y
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> CONFIG_VIDEO_AD5820=y
> # CONFIG_VIDEO_AK7375 is not set
> CONFIG_VIDEO_DW9714=y
> # CONFIG_VIDEO_DW9768 is not set
> CONFIG_VIDEO_DW9807_VCM=y
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> CONFIG_VIDEO_LM3646=y
> # end of Flash devices
> 
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_CS3308=y
> CONFIG_VIDEO_CS5345=y
> # CONFIG_VIDEO_CS53L32A is not set
> CONFIG_VIDEO_MSP3400=y
> CONFIG_VIDEO_SONY_BTF_MPX=y
> CONFIG_VIDEO_TDA1997X=y
> # CONFIG_VIDEO_TDA7432 is not set
> CONFIG_VIDEO_TDA9840=y
> CONFIG_VIDEO_TEA6415C=y
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_TVAUDIO is not set
> CONFIG_VIDEO_UDA1342=y
> CONFIG_VIDEO_VP27SMPX=y
> CONFIG_VIDEO_WM8739=y
> CONFIG_VIDEO_WM8775=y
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> # CONFIG_VIDEO_SAA6588 is not set
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> CONFIG_VIDEO_ADV7180=y
> CONFIG_VIDEO_ADV7183=y
> # CONFIG_VIDEO_ADV7604 is not set
> CONFIG_VIDEO_ADV7842=y
> # CONFIG_VIDEO_ADV7842_CEC is not set
> CONFIG_VIDEO_BT819=y
> CONFIG_VIDEO_BT856=y
> CONFIG_VIDEO_BT866=y
> # CONFIG_VIDEO_KS0127 is not set
> CONFIG_VIDEO_ML86V7667=y
> CONFIG_VIDEO_SAA7110=y
> # CONFIG_VIDEO_SAA711X is not set
> CONFIG_VIDEO_TC358743=y
> # CONFIG_VIDEO_TC358743_CEC is not set
> CONFIG_VIDEO_TVP514X=y
> # CONFIG_VIDEO_TVP5150 is not set
> CONFIG_VIDEO_TVP7002=y
> CONFIG_VIDEO_TW2804=y
> # CONFIG_VIDEO_TW9903 is not set
> # CONFIG_VIDEO_TW9906 is not set
> CONFIG_VIDEO_TW9910=y
> CONFIG_VIDEO_VPX3220=y
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=y
> CONFIG_VIDEO_CX25840=y
> # end of Video decoders
> 
> #
> # Video encoders
> #
> # CONFIG_VIDEO_AD9389B is not set
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> CONFIG_VIDEO_ADV7343=y
> CONFIG_VIDEO_ADV7393=y
> # CONFIG_VIDEO_ADV7511 is not set
> # CONFIG_VIDEO_AK881X is not set
> CONFIG_VIDEO_SAA7127=y
> CONFIG_VIDEO_SAA7185=y
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=y
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=y
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> CONFIG_SDR_MAX2175=y
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> CONFIG_VIDEO_I2C=y
> CONFIG_VIDEO_M52790=y
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # CONFIG_VIDEO_THS7303 is not set
> # end of Miscellaneous helper chips
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=y
> # CONFIG_VIDEO_GS1662 is not set
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_E4000=y
> # CONFIG_MEDIA_TUNER_FC0011 is not set
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> CONFIG_MEDIA_TUNER_FC0013=y
> # CONFIG_MEDIA_TUNER_FC2580 is not set
> CONFIG_MEDIA_TUNER_IT913X=y
> # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> CONFIG_MEDIA_TUNER_MAX2165=y
> # CONFIG_MEDIA_TUNER_MC44S803 is not set
> CONFIG_MEDIA_TUNER_MSI001=y
> # CONFIG_MEDIA_TUNER_MT2060 is not set
> CONFIG_MEDIA_TUNER_MT2063=y
> # CONFIG_MEDIA_TUNER_MT20XX is not set
> CONFIG_MEDIA_TUNER_MT2131=y
> CONFIG_MEDIA_TUNER_MT2266=y
> CONFIG_MEDIA_TUNER_MXL301RF=y
> # CONFIG_MEDIA_TUNER_MXL5005S is not set
> CONFIG_MEDIA_TUNER_MXL5007T=y
> CONFIG_MEDIA_TUNER_QM1D1B0004=y
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> CONFIG_MEDIA_TUNER_QT1010=y
> # CONFIG_MEDIA_TUNER_R820T is not set
> CONFIG_MEDIA_TUNER_SI2157=y
> # CONFIG_MEDIA_TUNER_SIMPLE is not set
> CONFIG_MEDIA_TUNER_TDA18212=y
> # CONFIG_MEDIA_TUNER_TDA18218 is not set
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> # CONFIG_MEDIA_TUNER_TDA9887 is not set
> CONFIG_MEDIA_TUNER_TEA5761=y
> CONFIG_MEDIA_TUNER_TEA5767=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC4000=y
> CONFIG_MEDIA_TUNER_XC5000=y
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_M88DS3103=y
> # CONFIG_DVB_MXL5XX is not set
> # CONFIG_DVB_STB0899 is not set
> # CONFIG_DVB_STB6100 is not set
> CONFIG_DVB_STV090x=y
> # CONFIG_DVB_STV0910 is not set
> CONFIG_DVB_STV6110x=y
> # CONFIG_DVB_STV6111 is not set
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=y
> # CONFIG_DVB_MN88472 is not set
> CONFIG_DVB_MN88473=y
> # CONFIG_DVB_SI2165 is not set
> CONFIG_DVB_TDA18271C2DD=y
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=y
> CONFIG_DVB_CX24116=y
> # CONFIG_DVB_CX24117 is not set
> CONFIG_DVB_CX24120=y
> CONFIG_DVB_CX24123=y
> CONFIG_DVB_DS3000=y
> CONFIG_DVB_MB86A16=y
> # CONFIG_DVB_MT312 is not set
> CONFIG_DVB_S5H1420=y
> # CONFIG_DVB_SI21XX is not set
> CONFIG_DVB_STB6000=y
> # CONFIG_DVB_STV0288 is not set
> CONFIG_DVB_STV0299=y
> # CONFIG_DVB_STV0900 is not set
> CONFIG_DVB_STV6110=y
> CONFIG_DVB_TDA10071=y
> CONFIG_DVB_TDA10086=y
> # CONFIG_DVB_TDA8083 is not set
> CONFIG_DVB_TDA8261=y
> # CONFIG_DVB_TDA826X is not set
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_TUA6100=y
> CONFIG_DVB_TUNER_CX24113=y
> CONFIG_DVB_TUNER_ITD1000=y
> # CONFIG_DVB_VES1X93 is not set
> # CONFIG_DVB_ZL10036 is not set
> CONFIG_DVB_ZL10039=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_AF9013=y
> CONFIG_DVB_CX22700=y
> CONFIG_DVB_CX22702=y
> CONFIG_DVB_CXD2820R=y
> CONFIG_DVB_CXD2841ER=y
> CONFIG_DVB_DIB3000MB=y
> CONFIG_DVB_DIB3000MC=y
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_DIB9000=y
> # CONFIG_DVB_DRXD is not set
> CONFIG_DVB_EC100=y
> # CONFIG_DVB_L64781 is not set
> CONFIG_DVB_MT352=y
> # CONFIG_DVB_NXT6000 is not set
> # CONFIG_DVB_RTL2830 is not set
> CONFIG_DVB_RTL2832=y
> # CONFIG_DVB_S5H1432 is not set
> # CONFIG_DVB_SI2168 is not set
> CONFIG_DVB_SP887X=y
> CONFIG_DVB_STV0367=y
> # CONFIG_DVB_TDA10048 is not set
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_ZD1301_DEMOD=y
> # CONFIG_DVB_ZL10353 is not set
> CONFIG_DVB_CXD2880=y
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_STV0297=y
> CONFIG_DVB_TDA10021=y
> # CONFIG_DVB_TDA10023 is not set
> # CONFIG_DVB_VES1820 is not set
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_AU8522=y
> CONFIG_DVB_AU8522_DTV=y
> CONFIG_DVB_AU8522_V4L=y
> CONFIG_DVB_BCM3510=y
> CONFIG_DVB_LG2160=y
> CONFIG_DVB_LGDT3305=y
> CONFIG_DVB_LGDT3306A=y
> CONFIG_DVB_LGDT330X=y
> CONFIG_DVB_MXL692=y
> # CONFIG_DVB_NXT200X is not set
> # CONFIG_DVB_OR51132 is not set
> # CONFIG_DVB_OR51211 is not set
> CONFIG_DVB_S5H1409=y
> # CONFIG_DVB_S5H1411 is not set
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_DIB8000=y
> CONFIG_DVB_MB86A20S=y
> # CONFIG_DVB_S921 is not set
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_MN88443X=y
> # CONFIG_DVB_TC90522 is not set
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> # CONFIG_DVB_TUNER_DIB0090 is not set
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_A8293=y
> CONFIG_DVB_AF9033=y
> CONFIG_DVB_ASCOT2E=y
> # CONFIG_DVB_ATBM8830 is not set
> CONFIG_DVB_HELENE=y
> # CONFIG_DVB_HORUS3A is not set
> CONFIG_DVB_ISL6405=y
> # CONFIG_DVB_ISL6421 is not set
> CONFIG_DVB_ISL6423=y
> CONFIG_DVB_IX2505V=y
> CONFIG_DVB_LGS8GL5=y
> # CONFIG_DVB_LGS8GXX is not set
> # CONFIG_DVB_LNBH25 is not set
> CONFIG_DVB_LNBH29=y
> CONFIG_DVB_LNBP21=y
> CONFIG_DVB_LNBP22=y
> CONFIG_DVB_M88RS2000=y
> CONFIG_DVB_TDA665x=y
> # CONFIG_DVB_DRX39XYJ is not set
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> # CONFIG_DVB_CXD2099 is not set
> CONFIG_DVB_SP2=y
> # end of Customise DVB Frontends
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=y
> # CONFIG_AGP is not set
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DBI=y
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DISPLAY_HELPER=y
> CONFIG_DRM_DISPLAY_DP_HELPER=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> CONFIG_DRM_SCHED=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> CONFIG_DRM_I2C_NXP_TDA9950=y
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=y
> CONFIG_DRM_ANALOGIX_DP=y
> # end of Display Interface Bridges
> 
> CONFIG_DRM_ETNAVIV=y
> CONFIG_DRM_ETNAVIV_THERMAL=y
> # CONFIG_DRM_BOCHS is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> CONFIG_DRM_SIMPLEDRM=y
> # CONFIG_TINYDRM_HX8357D is not set
> CONFIG_TINYDRM_ILI9163=y
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> CONFIG_TINYDRM_ILI9486=y
> CONFIG_TINYDRM_MI0283QT=y
> CONFIG_TINYDRM_REPAPER=y
> # CONFIG_TINYDRM_ST7586 is not set
> CONFIG_TINYDRM_ST7735R=y
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_SSD130X is not set
> CONFIG_DRM_LEGACY=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_VIA is not set
> # CONFIG_DRM_SAVAGE is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_NOMODESET=y
> CONFIG_DRM_PRIVACY_SCREEN=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> # CONFIG_FB_BIG_ENDIAN is not set
> CONFIG_FB_LITTLE_ENDIAN=y
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_ARC=y
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> # CONFIG_FB_N411 is not set
> CONFIG_FB_HGA=y
> CONFIG_FB_OPENCORES=y
> CONFIG_FB_S1D13XXX=y
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> CONFIG_FB_SM501=y
> CONFIG_FB_IBM_GXT4500=y
> # CONFIG_FB_GOLDFISH is not set
> CONFIG_FB_VIRTUAL=y
> CONFIG_FB_METRONOME=y
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_L4F00242T03=y
> CONFIG_LCD_LMS283GF05=y
> CONFIG_LCD_LTV350QV=y
> CONFIG_LCD_ILI922X=y
> CONFIG_LCD_ILI9320=y
> CONFIG_LCD_TDO24M=y
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=y
> CONFIG_LCD_AMS369FG06=y
> CONFIG_LCD_LMS501KF03=y
> CONFIG_LCD_HX8357=y
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_KTD253=y
> CONFIG_BACKLIGHT_PWM=y
> # CONFIG_BACKLIGHT_DA9052 is not set
> CONFIG_BACKLIGHT_MAX8925=y
> CONFIG_BACKLIGHT_APPLE=y
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> CONFIG_BACKLIGHT_SAHARA=y
> CONFIG_BACKLIGHT_WM831X=y
> CONFIG_BACKLIGHT_ADP5520=y
> # CONFIG_BACKLIGHT_ADP8860 is not set
> CONFIG_BACKLIGHT_ADP8870=y
> CONFIG_BACKLIGHT_PCF50633=y
> CONFIG_BACKLIGHT_AAT2870=y
> CONFIG_BACKLIGHT_LM3630A=y
> CONFIG_BACKLIGHT_LM3639=y
> CONFIG_BACKLIGHT_LP855X=y
> # CONFIG_BACKLIGHT_LP8788 is not set
> CONFIG_BACKLIGHT_SKY81452=y
> # CONFIG_BACKLIGHT_GPIO is not set
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> CONFIG_BACKLIGHT_ARCXCNN=y
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> # CONFIG_FRAMEBUFFER_CONSOLE is not set
> # end of Console display driver support
> 
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SOUND_OSS_CORE=y
> # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_PCM_ELD=y
> CONFIG_SND_PCM_IEC958=y
> CONFIG_SND_DMAENGINE_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_SEQ_DEVICE=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_COMPRESS_OFFLOAD=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> # CONFIG_SND_PCM_OSS is not set
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=y
> CONFIG_SND_VERBOSE_PROCFS=y
> # CONFIG_SND_VERBOSE_PRINTK is not set
> CONFIG_SND_CTL_FAST_LOOKUP=y
> CONFIG_SND_DEBUG=y
> # CONFIG_SND_DEBUG_VERBOSE is not set
> CONFIG_SND_PCM_XRUN_DEBUG=y
> CONFIG_SND_CTL_INPUT_VALIDATION=y
> # CONFIG_SND_CTL_DEBUG is not set
> # CONFIG_SND_JACK_INJECTION_DEBUG is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> CONFIG_SND_SEQUENCER_OSS=y
> # CONFIG_SND_SEQ_HRTIMER_DEFAULT is not set
> CONFIG_SND_SEQ_MIDI_EVENT=y
> CONFIG_SND_SEQ_MIDI=y
> CONFIG_SND_AC97_CODEC=y
> # CONFIG_SND_DRIVERS is not set
> CONFIG_SND_PCI=y
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ASIHPI is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_OXYGEN is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CTXFI is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_INDIGOIOX is not set
> # CONFIG_SND_INDIGODJX is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_LOLA is not set
> # CONFIG_SND_LX6464ES is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SE6X is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VIRTUOSO is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
> 
> #
> # HD-Audio
> #
> # CONFIG_SND_HDA_INTEL is not set
> # end of HD-Audio
> 
> CONFIG_SND_HDA_PREALLOC_SIZE=0
> # CONFIG_SND_SPI is not set
> CONFIG_SND_FIREWIRE=y
> CONFIG_SND_FIREWIRE_LIB=y
> CONFIG_SND_DICE=y
> # CONFIG_SND_OXFW is not set
> CONFIG_SND_ISIGHT=y
> # CONFIG_SND_FIREWORKS is not set
> # CONFIG_SND_BEBOB is not set
> # CONFIG_SND_FIREWIRE_DIGI00X is not set
> CONFIG_SND_FIREWIRE_TASCAM=y
> CONFIG_SND_FIREWIRE_MOTU=y
> # CONFIG_SND_FIREFACE is not set
> CONFIG_SND_SOC=y
> CONFIG_SND_SOC_AC97_BUS=y
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> CONFIG_SND_SOC_COMPRESS=y
> CONFIG_SND_SOC_ADI=y
> # CONFIG_SND_SOC_ADI_AXI_I2S is not set
> CONFIG_SND_SOC_ADI_AXI_SPDIF=y
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> # CONFIG_SND_AMD_ACP_CONFIG is not set
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> # CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
> # CONFIG_SND_ATMEL_SOC is not set
> CONFIG_SND_BCM63XX_I2S_WHISTLER=y
> CONFIG_SND_DESIGNWARE_I2S=y
> CONFIG_SND_DESIGNWARE_PCM=y
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> CONFIG_SND_SOC_FSL_ASRC=y
> # CONFIG_SND_SOC_FSL_SAI is not set
> CONFIG_SND_SOC_FSL_AUDMIX=y
> CONFIG_SND_SOC_FSL_SSI=y
> CONFIG_SND_SOC_FSL_SPDIF=y
> CONFIG_SND_SOC_FSL_ESAI=y
> CONFIG_SND_SOC_FSL_MICFIL=y
> # CONFIG_SND_SOC_FSL_EASRC is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> CONFIG_SND_SOC_FSL_UTILS=y
> CONFIG_SND_SOC_FSL_RPMSG=y
> CONFIG_SND_SOC_IMX_AUDMUX=y
> # end of SoC Audio for Freescale CPUs
> 
> CONFIG_SND_I2S_HI6210_I2S=y
> CONFIG_SND_SOC_IMG=y
> # CONFIG_SND_SOC_IMG_I2S_IN is not set
> CONFIG_SND_SOC_IMG_I2S_OUT=y
> CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
> # CONFIG_SND_SOC_IMG_SPDIF_IN is not set
> CONFIG_SND_SOC_IMG_SPDIF_OUT=y
> CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> # CONFIG_SND_SOC_INTEL_AVS is not set
> CONFIG_SND_SOC_MTK_BTCVSD=y
> # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> CONFIG_SND_SOC_XILINX_I2S=y
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> CONFIG_SND_SOC_I2C_AND_SPI=y
> 
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_WM_ADSP=y
> CONFIG_SND_SOC_AC97_CODEC=y
> CONFIG_SND_SOC_ADAU_UTILS=y
> CONFIG_SND_SOC_ADAU1372=y
> CONFIG_SND_SOC_ADAU1372_I2C=y
> CONFIG_SND_SOC_ADAU1372_SPI=y
> # CONFIG_SND_SOC_ADAU1701 is not set
> CONFIG_SND_SOC_ADAU17X1=y
> CONFIG_SND_SOC_ADAU1761=y
> CONFIG_SND_SOC_ADAU1761_I2C=y
> CONFIG_SND_SOC_ADAU1761_SPI=y
> CONFIG_SND_SOC_ADAU7002=y
> CONFIG_SND_SOC_ADAU7118=y
> CONFIG_SND_SOC_ADAU7118_HW=y
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> CONFIG_SND_SOC_AK4104=y
> CONFIG_SND_SOC_AK4118=y
> CONFIG_SND_SOC_AK4375=y
> # CONFIG_SND_SOC_AK4458 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> CONFIG_SND_SOC_AK4613=y
> # CONFIG_SND_SOC_AK4642 is not set
> CONFIG_SND_SOC_AK5386=y
> CONFIG_SND_SOC_AK5558=y
> CONFIG_SND_SOC_ALC5623=y
> CONFIG_SND_SOC_AW8738=y
> CONFIG_SND_SOC_BD28623=y
> CONFIG_SND_SOC_BT_SCO=y
> CONFIG_SND_SOC_CROS_EC_CODEC=y
> CONFIG_SND_SOC_CS35L32=y
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> CONFIG_SND_SOC_CS35L35=y
> CONFIG_SND_SOC_CS35L36=y
> CONFIG_SND_SOC_CS35L41_LIB=y
> CONFIG_SND_SOC_CS35L41=y
> CONFIG_SND_SOC_CS35L41_SPI=y
> CONFIG_SND_SOC_CS35L41_I2C=y
> # CONFIG_SND_SOC_CS35L45_SPI is not set
> # CONFIG_SND_SOC_CS35L45_I2C is not set
> CONFIG_SND_SOC_CS42L42=y
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> CONFIG_SND_SOC_CS42L52=y
> # CONFIG_SND_SOC_CS42L56 is not set
> CONFIG_SND_SOC_CS42L73=y
> # CONFIG_SND_SOC_CS4234 is not set
> CONFIG_SND_SOC_CS4265=y
> # CONFIG_SND_SOC_CS4270 is not set
> CONFIG_SND_SOC_CS4271=y
> # CONFIG_SND_SOC_CS4271_I2C is not set
> CONFIG_SND_SOC_CS4271_SPI=y
> CONFIG_SND_SOC_CS42XX8=y
> CONFIG_SND_SOC_CS42XX8_I2C=y
> # CONFIG_SND_SOC_CS43130 is not set
> CONFIG_SND_SOC_CS4341=y
> CONFIG_SND_SOC_CS4349=y
> # CONFIG_SND_SOC_CS53L30 is not set
> CONFIG_SND_SOC_CX2072X=y
> CONFIG_SND_SOC_DA7213=y
> CONFIG_SND_SOC_DMIC=y
> CONFIG_SND_SOC_HDMI_CODEC=y
> CONFIG_SND_SOC_ES7134=y
> CONFIG_SND_SOC_ES7241=y
> # CONFIG_SND_SOC_ES8316 is not set
> CONFIG_SND_SOC_ES8328=y
> CONFIG_SND_SOC_ES8328_I2C=y
> CONFIG_SND_SOC_ES8328_SPI=y
> # CONFIG_SND_SOC_GTM601 is not set
> # CONFIG_SND_SOC_HDA is not set
> CONFIG_SND_SOC_ICS43432=y
> # CONFIG_SND_SOC_INNO_RK3036 is not set
> CONFIG_SND_SOC_MAX98088=y
> CONFIG_SND_SOC_MAX98357A=y
> CONFIG_SND_SOC_MAX98504=y
> CONFIG_SND_SOC_MAX9867=y
> CONFIG_SND_SOC_MAX98927=y
> CONFIG_SND_SOC_MAX98520=y
> CONFIG_SND_SOC_MAX98373=y
> CONFIG_SND_SOC_MAX98373_I2C=y
> CONFIG_SND_SOC_MAX98390=y
> CONFIG_SND_SOC_MAX98396=y
> CONFIG_SND_SOC_MAX9860=y
> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
> # CONFIG_SND_SOC_PCM1681 is not set
> CONFIG_SND_SOC_PCM1789=y
> CONFIG_SND_SOC_PCM1789_I2C=y
> CONFIG_SND_SOC_PCM179X=y
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> CONFIG_SND_SOC_PCM179X_SPI=y
> CONFIG_SND_SOC_PCM186X=y
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> CONFIG_SND_SOC_PCM186X_SPI=y
> CONFIG_SND_SOC_PCM3060=y
> CONFIG_SND_SOC_PCM3060_I2C=y
> # CONFIG_SND_SOC_PCM3060_SPI is not set
> CONFIG_SND_SOC_PCM3168A=y
> CONFIG_SND_SOC_PCM3168A_I2C=y
> CONFIG_SND_SOC_PCM3168A_SPI=y
> CONFIG_SND_SOC_PCM5102A=y
> CONFIG_SND_SOC_PCM512x=y
> # CONFIG_SND_SOC_PCM512x_I2C is not set
> CONFIG_SND_SOC_PCM512x_SPI=y
> CONFIG_SND_SOC_RK3328=y
> CONFIG_SND_SOC_RL6231=y
> # CONFIG_SND_SOC_RT5616 is not set
> CONFIG_SND_SOC_RT5631=y
> CONFIG_SND_SOC_RT5640=y
> CONFIG_SND_SOC_RT5659=y
> # CONFIG_SND_SOC_RT9120 is not set
> CONFIG_SND_SOC_SGTL5000=y
> CONFIG_SND_SOC_SIGMADSP=y
> CONFIG_SND_SOC_SIGMADSP_REGMAP=y
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> CONFIG_SND_SOC_SIMPLE_MUX=y
> CONFIG_SND_SOC_SPDIF=y
> CONFIG_SND_SOC_SSM2305=y
> CONFIG_SND_SOC_SSM2518=y
> CONFIG_SND_SOC_SSM2602=y
> CONFIG_SND_SOC_SSM2602_SPI=y
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> CONFIG_SND_SOC_SSM4567=y
> CONFIG_SND_SOC_STA32X=y
> CONFIG_SND_SOC_STA350=y
> # CONFIG_SND_SOC_STI_SAS is not set
> CONFIG_SND_SOC_TAS2552=y
> # CONFIG_SND_SOC_TAS2562 is not set
> CONFIG_SND_SOC_TAS2764=y
> # CONFIG_SND_SOC_TAS2770 is not set
> # CONFIG_SND_SOC_TAS2780 is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> CONFIG_SND_SOC_TAS571X=y
> CONFIG_SND_SOC_TAS5720=y
> # CONFIG_SND_SOC_TAS5805M is not set
> CONFIG_SND_SOC_TAS6424=y
> CONFIG_SND_SOC_TDA7419=y
> CONFIG_SND_SOC_TFA9879=y
> CONFIG_SND_SOC_TFA989X=y
> CONFIG_SND_SOC_TLV320ADC3XXX=y
> CONFIG_SND_SOC_TLV320AIC23=y
> CONFIG_SND_SOC_TLV320AIC23_I2C=y
> CONFIG_SND_SOC_TLV320AIC23_SPI=y
> CONFIG_SND_SOC_TLV320AIC31XX=y
> CONFIG_SND_SOC_TLV320AIC32X4=y
> # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
> CONFIG_SND_SOC_TLV320AIC3X=y
> CONFIG_SND_SOC_TLV320AIC3X_I2C=y
> CONFIG_SND_SOC_TLV320AIC3X_SPI=y
> CONFIG_SND_SOC_TLV320ADCX140=y
> # CONFIG_SND_SOC_TS3A227E is not set
> CONFIG_SND_SOC_TSCS42XX=y
> # CONFIG_SND_SOC_TSCS454 is not set
> CONFIG_SND_SOC_UDA1334=y
> # CONFIG_SND_SOC_WCD9335 is not set
> CONFIG_SND_SOC_WM8510=y
> CONFIG_SND_SOC_WM8523=y
> CONFIG_SND_SOC_WM8524=y
> CONFIG_SND_SOC_WM8580=y
> CONFIG_SND_SOC_WM8711=y
> # CONFIG_SND_SOC_WM8728 is not set
> CONFIG_SND_SOC_WM8731=y
> # CONFIG_SND_SOC_WM8731_I2C is not set
> CONFIG_SND_SOC_WM8731_SPI=y
> CONFIG_SND_SOC_WM8737=y
> CONFIG_SND_SOC_WM8741=y
> CONFIG_SND_SOC_WM8750=y
> CONFIG_SND_SOC_WM8753=y
> # CONFIG_SND_SOC_WM8770 is not set
> CONFIG_SND_SOC_WM8776=y
> CONFIG_SND_SOC_WM8782=y
> CONFIG_SND_SOC_WM8804=y
> CONFIG_SND_SOC_WM8804_I2C=y
> # CONFIG_SND_SOC_WM8804_SPI is not set
> CONFIG_SND_SOC_WM8903=y
> CONFIG_SND_SOC_WM8904=y
> # CONFIG_SND_SOC_WM8940 is not set
> CONFIG_SND_SOC_WM8960=y
> CONFIG_SND_SOC_WM8962=y
> # CONFIG_SND_SOC_WM8974 is not set
> CONFIG_SND_SOC_WM8978=y
> CONFIG_SND_SOC_WM8985=y
> # CONFIG_SND_SOC_ZL38060 is not set
> CONFIG_SND_SOC_MAX9759=y
> CONFIG_SND_SOC_MT6351=y
> CONFIG_SND_SOC_MT6358=y
> CONFIG_SND_SOC_MT6660=y
> CONFIG_SND_SOC_NAU8315=y
> # CONFIG_SND_SOC_NAU8540 is not set
> CONFIG_SND_SOC_NAU8810=y
> CONFIG_SND_SOC_NAU8821=y
> CONFIG_SND_SOC_NAU8822=y
> CONFIG_SND_SOC_NAU8824=y
> CONFIG_SND_SOC_TPA6130A2=y
> CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
> CONFIG_SND_SOC_LPASS_WSA_MACRO=y
> CONFIG_SND_SOC_LPASS_VA_MACRO=y
> # CONFIG_SND_SOC_LPASS_RX_MACRO is not set
> CONFIG_SND_SOC_LPASS_TX_MACRO=y
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=y
> CONFIG_SND_SIMPLE_CARD=y
> CONFIG_SND_X86=y
> CONFIG_SND_VIRTIO=y
> CONFIG_AC97_BUS=y
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> # CONFIG_HID_GENERIC is not set
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=y
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> # CONFIG_HID_CHERRY is not set
> CONFIG_HID_COUGAR=y
> CONFIG_HID_MACALLY=y
> CONFIG_HID_CMEDIA=y
> CONFIG_HID_CYPRESS=y
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_EZKEY is not set
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> CONFIG_HID_WALTOP=y
> CONFIG_HID_VIEWSONIC=y
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=y
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> # CONFIG_HID_JABRA is not set
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_MAGICMOUSE=y
> CONFIG_HID_MALTRON=y
> # CONFIG_HID_MAYFLASH is not set
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> # CONFIG_HID_MONTEREY is not set
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NINTENDO=y
> # CONFIG_NINTENDO_FF is not set
> # CONFIG_HID_NTI is not set
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> # CONFIG_HID_PLAYSTATION is not set
> # CONFIG_HID_RAZER is not set
> CONFIG_HID_PRIMAX=y
> CONFIG_HID_SAITEK=y
> CONFIG_HID_SEMITEK=y
> # CONFIG_HID_SPEEDLINK is not set
> CONFIG_HID_STEAM=y
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_SMARTJOYPLUS=y
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=y
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> CONFIG_HID_WIIMOTE=y
> CONFIG_HID_XINMO=y
> CONFIG_HID_ZEROPLUS=y
> # CONFIG_ZEROPLUS_FF is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> CONFIG_HID_ALPS=y
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> # end of Intel ISH HID support
> 
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=y
> # CONFIG_MMC_BLOCK is not set
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=y
> # CONFIG_MMC_SDHCI_PCI is not set
> # CONFIG_MMC_SDHCI_ACPI is not set
> CONFIG_MMC_SDHCI_PLTFM=y
> CONFIG_MMC_SDHCI_F_SDH30=y
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> CONFIG_MMC_SPI=y
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_CQHCI=y
> CONFIG_MMC_HSQ=y
> # CONFIG_MMC_TOSHIBA_PCI is not set
> CONFIG_MMC_MTK=y
> # CONFIG_MMC_SDHCI_XENON is not set
> CONFIG_SCSI_UFSHCD=y
> CONFIG_SCSI_UFS_BSG=y
> # CONFIG_SCSI_UFS_HPB is not set
> CONFIG_SCSI_UFS_FAULT_INJECTION=y
> # CONFIG_SCSI_UFS_HWMON is not set
> # CONFIG_SCSI_UFSHCD_PCI is not set
> # CONFIG_SCSI_UFSHCD_PLATFORM is not set
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> CONFIG_MEMSTICK_UNSAFE_RESUME=y
> CONFIG_MSPRO_BLOCK=y
> CONFIG_MS_BLOCK=y
> 
> #
> # MemoryStick Host Controller Drivers
> #
> # CONFIG_MEMSTICK_TIFM_MS is not set
> # CONFIG_MEMSTICK_JMICRON_38X is not set
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=y
> CONFIG_LEDS_LM3532=y
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_MT6323 is not set
> CONFIG_LEDS_PCA9532=y
> # CONFIG_LEDS_PCA9532_GPIO is not set
> CONFIG_LEDS_GPIO=y
> # CONFIG_LEDS_LP3944 is not set
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP50XX=y
> CONFIG_LEDS_LP8788=y
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_WM831X_STATUS is not set
> # CONFIG_LEDS_DA9052 is not set
> CONFIG_LEDS_DAC124S085=y
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> CONFIG_LEDS_ADP5520=y
> CONFIG_LEDS_MC13783=y
> # CONFIG_LEDS_TCA6507 is not set
> CONFIG_LEDS_TLC591XX=y
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_MENF21BMC is not set
> CONFIG_LEDS_IS31FL319X=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=y
> CONFIG_LEDS_NIC78BX=y
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> # CONFIG_LEDS_TPS6105X is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # RGB LED drivers
> #
> # CONFIG_LEDS_PWM_MULTICOLOR is not set
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> # CONFIG_LEDS_TRIGGER_DISK is not set
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> CONFIG_LEDS_TRIGGER_CAMERA=y
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> CONFIG_LEDS_TRIGGER_NETDEV=y
> CONFIG_LEDS_TRIGGER_PATTERN=y
> CONFIG_LEDS_TRIGGER_AUDIO=y
> # CONFIG_LEDS_TRIGGER_TTY is not set
> 
> #
> # Simple LED drivers
> #
> CONFIG_ACCESSIBILITY=y
> CONFIG_A11Y_BRAILLE_CONSOLE=y
> 
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=y
> # CONFIG_SPEAKUP_SYNTH_ACNTSA is not set
> CONFIG_SPEAKUP_SYNTH_APOLLO=y
> CONFIG_SPEAKUP_SYNTH_AUDPTR=y
> CONFIG_SPEAKUP_SYNTH_BNS=y
> CONFIG_SPEAKUP_SYNTH_DECTLK=y
> # CONFIG_SPEAKUP_SYNTH_DECEXT is not set
> CONFIG_SPEAKUP_SYNTH_LTLK=y
> CONFIG_SPEAKUP_SYNTH_SOFT=y
> CONFIG_SPEAKUP_SYNTH_SPKOUT=y
> # CONFIG_SPEAKUP_SYNTH_TXPRT is not set
> CONFIG_SPEAKUP_SYNTH_DUMMY=y
> # end of Speakup console speech
> 
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> CONFIG_RTC_DEBUG=y
> # CONFIG_RTC_NVMEM is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> # CONFIG_RTC_INTF_PROC is not set
> # CONFIG_RTC_INTF_DEV is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> CONFIG_RTC_DRV_ABX80X=y
> # CONFIG_RTC_DRV_DS1307 is not set
> CONFIG_RTC_DRV_DS1374=y
> CONFIG_RTC_DRV_DS1672=y
> CONFIG_RTC_DRV_LP8788=y
> # CONFIG_RTC_DRV_MAX6900 is not set
> CONFIG_RTC_DRV_MAX8907=y
> # CONFIG_RTC_DRV_MAX8925 is not set
> # CONFIG_RTC_DRV_MAX8998 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> CONFIG_RTC_DRV_ISL1208=y
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> CONFIG_RTC_DRV_PCF85063=y
> CONFIG_RTC_DRV_PCF85363=y
> CONFIG_RTC_DRV_PCF8563=y
> # CONFIG_RTC_DRV_PCF8583 is not set
> CONFIG_RTC_DRV_M41T80=y
> CONFIG_RTC_DRV_M41T80_WDT=y
> CONFIG_RTC_DRV_BQ32K=y
> CONFIG_RTC_DRV_TPS6586X=y
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=y
> CONFIG_RTC_DRV_RX8010=y
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> CONFIG_RTC_DRV_EM3027=y
> CONFIG_RTC_DRV_RV3028=y
> CONFIG_RTC_DRV_RV3032=y
> # CONFIG_RTC_DRV_RV8803 is not set
> CONFIG_RTC_DRV_SD3078=y
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_DRV_M41T93=y
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> CONFIG_RTC_DRV_DS1305=y
> CONFIG_RTC_DRV_DS1343=y
> CONFIG_RTC_DRV_DS1347=y
> CONFIG_RTC_DRV_DS1390=y
> CONFIG_RTC_DRV_MAX6916=y
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=y
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> CONFIG_RTC_DRV_PCF2123=y
> CONFIG_RTC_DRV_MCP795=y
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> CONFIG_RTC_DRV_RX6110=y
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1286 is not set
> CONFIG_RTC_DRV_DS1511=y
> CONFIG_RTC_DRV_DS1553=y
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=y
> CONFIG_RTC_DRV_DS2404=y
> # CONFIG_RTC_DRV_DA9052 is not set
> CONFIG_RTC_DRV_DA9055=y
> CONFIG_RTC_DRV_DA9063=y
> CONFIG_RTC_DRV_STK17TA8=y
> CONFIG_RTC_DRV_M48T86=y
> CONFIG_RTC_DRV_M48T35=y
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> # CONFIG_RTC_DRV_BQ4802 is not set
> CONFIG_RTC_DRV_RP5C01=y
> # CONFIG_RTC_DRV_V3020 is not set
> CONFIG_RTC_DRV_WM831X=y
> CONFIG_RTC_DRV_PCF50633=y
> # CONFIG_RTC_DRV_CROS_EC is not set
> 
> #
> # on-CPU RTC drivers
> #
> CONFIG_RTC_DRV_FTRTC010=y
> CONFIG_RTC_DRV_MC13XXX=y
> CONFIG_RTC_DRV_MT6397=y
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_GOLDFISH=y
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_UDMABUF=y
> CONFIG_DMABUF_MOVE_NOTIFY=y
> CONFIG_DMABUF_DEBUG=y
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> CONFIG_DMABUF_SYSFS_STATS=y
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> CONFIG_UIO_PRUSS=y
> # CONFIG_UIO_MF624 is not set
> # CONFIG_VFIO is not set
> CONFIG_VIRT_DRIVERS=y
> # CONFIG_VMGENID is not set
> # CONFIG_VBOXGUEST is not set
> # CONFIG_NITRO_ENCLAVES is not set
> CONFIG_VIRTIO_ANCHOR=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> # CONFIG_VIRTIO_PCI is not set
> # CONFIG_VIRTIO_BALLOON is not set
> CONFIG_VIRTIO_INPUT=y
> CONFIG_VIRTIO_MMIO=y
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST=y
> CONFIG_VHOST_MENU=y
> CONFIG_VHOST_NET=y
> CONFIG_VHOST_SCSI=y
> # CONFIG_VHOST_VSOCK is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=y
> CONFIG_COMEDI=y
> CONFIG_COMEDI_DEBUG=y
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> CONFIG_COMEDI_MISC_DRIVERS=y
> # CONFIG_COMEDI_BOND is not set
> # CONFIG_COMEDI_TEST is not set
> # CONFIG_COMEDI_PARPORT is not set
> CONFIG_COMEDI_ISA_DRIVERS=y
> # CONFIG_COMEDI_PCL711 is not set
> CONFIG_COMEDI_PCL724=y
> CONFIG_COMEDI_PCL726=y
> # CONFIG_COMEDI_PCL730 is not set
> # CONFIG_COMEDI_PCL812 is not set
> CONFIG_COMEDI_PCL816=y
> CONFIG_COMEDI_PCL818=y
> CONFIG_COMEDI_PCM3724=y
> CONFIG_COMEDI_AMPLC_DIO200_ISA=y
> CONFIG_COMEDI_AMPLC_PC236_ISA=y
> CONFIG_COMEDI_AMPLC_PC263_ISA=y
> # CONFIG_COMEDI_RTI800 is not set
> CONFIG_COMEDI_RTI802=y
> CONFIG_COMEDI_DAC02=y
> CONFIG_COMEDI_DAS16M1=y
> CONFIG_COMEDI_DAS08_ISA=y
> CONFIG_COMEDI_DAS16=y
> CONFIG_COMEDI_DAS800=y
> CONFIG_COMEDI_DAS1800=y
> CONFIG_COMEDI_DAS6402=y
> # CONFIG_COMEDI_DT2801 is not set
> # CONFIG_COMEDI_DT2811 is not set
> CONFIG_COMEDI_DT2814=y
> CONFIG_COMEDI_DT2815=y
> CONFIG_COMEDI_DT2817=y
> # CONFIG_COMEDI_DT282X is not set
> CONFIG_COMEDI_DMM32AT=y
> # CONFIG_COMEDI_FL512 is not set
> # CONFIG_COMEDI_AIO_AIO12_8 is not set
> CONFIG_COMEDI_AIO_IIRO_16=y
> # CONFIG_COMEDI_II_PCI20KC is not set
> CONFIG_COMEDI_C6XDIGIO=y
> CONFIG_COMEDI_MPC624=y
> CONFIG_COMEDI_ADQ12B=y
> # CONFIG_COMEDI_NI_AT_A2150 is not set
> CONFIG_COMEDI_NI_AT_AO=y
> CONFIG_COMEDI_NI_ATMIO=y
> CONFIG_COMEDI_NI_ATMIO16D=y
> # CONFIG_COMEDI_NI_LABPC_ISA is not set
> CONFIG_COMEDI_PCMAD=y
> CONFIG_COMEDI_PCMDA12=y
> CONFIG_COMEDI_PCMMIO=y
> CONFIG_COMEDI_PCMUIO=y
> # CONFIG_COMEDI_MULTIQ3 is not set
> CONFIG_COMEDI_S526=y
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> CONFIG_COMEDI_8254=y
> CONFIG_COMEDI_8255=y
> # CONFIG_COMEDI_8255_SA is not set
> CONFIG_COMEDI_KCOMEDILIB=y
> CONFIG_COMEDI_AMPLC_DIO200=y
> CONFIG_COMEDI_AMPLC_PC236=y
> CONFIG_COMEDI_DAS08=y
> CONFIG_COMEDI_ISADMA=y
> CONFIG_COMEDI_NI_TIO=y
> CONFIG_COMEDI_NI_ROUTING=y
> # CONFIG_COMEDI_TESTS is not set
> CONFIG_STAGING=y
> # CONFIG_RTLLIB is not set
> # CONFIG_RTL8723BS is not set
> # CONFIG_RTS5208 is not set
> # CONFIG_VT6655 is not set
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16203=y
> CONFIG_ADIS16240=y
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7816=y
> # end of Analog to digital converters
> 
> #
> # Analog digital bi-direction converters
> #
> CONFIG_ADT7316=y
> CONFIG_ADT7316_SPI=y
> # CONFIG_ADT7316_I2C is not set
> # end of Analog digital bi-direction converters
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7746=y
> # end of Capacitance to digital converters
> 
> #
> # Direct Digital Synthesis
> #
> # CONFIG_AD9832 is not set
> CONFIG_AD9834=y
> # end of Direct Digital Synthesis
> 
> #
> # Network Analyzer, Impedance Converters
> #
> CONFIG_AD5933=y
> # end of Network Analyzer, Impedance Converters
> 
> #
> # Active energy metering IC
> #
> # CONFIG_ADE7854 is not set
> # end of Active energy metering IC
> 
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S1210 is not set
> # end of Resolver to digital converters
> # end of IIO staging drivers
> 
> # CONFIG_FB_SM750 is not set
> # CONFIG_STAGING_MEDIA is not set
> # CONFIG_FIREWIRE_SERIAL is not set
> # CONFIG_FB_TFT is not set
> CONFIG_KS7010=y
> # CONFIG_GREYBUS_AUDIO is not set
> CONFIG_GREYBUS_BOOTROM=y
> CONFIG_GREYBUS_FIRMWARE=y
> CONFIG_GREYBUS_HID=y
> # CONFIG_GREYBUS_LIGHT is not set
> CONFIG_GREYBUS_LOG=y
> CONFIG_GREYBUS_LOOPBACK=y
> CONFIG_GREYBUS_POWER=y
> # CONFIG_GREYBUS_RAW is not set
> CONFIG_GREYBUS_VIBRATOR=y
> CONFIG_GREYBUS_BRIDGED_PHY=y
> CONFIG_GREYBUS_GPIO=y
> CONFIG_GREYBUS_I2C=y
> # CONFIG_GREYBUS_PWM is not set
> CONFIG_GREYBUS_SDIO=y
> CONFIG_GREYBUS_SPI=y
> CONFIG_GREYBUS_UART=y
> # CONFIG_PI433 is not set
> CONFIG_FIELDBUS_DEV=y
> # CONFIG_QLGE is not set
> # CONFIG_VME_BUS is not set
> CONFIG_GOLDFISH_PIPE=y
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_ACPI=y
> CONFIG_CHROMEOS_LAPTOP=y
> CONFIG_CHROMEOS_PSTORE=y
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC=y
> # CONFIG_CROS_EC_I2C is not set
> CONFIG_CROS_EC_SPI=y
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> CONFIG_CROS_KBD_LED_BACKLIGHT=y
> CONFIG_CHROMEOS_PRIVACY_SCREEN=y
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_MLXREG_HOTPLUG is not set
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> CONFIG_NVSW_SN2201=y
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> CONFIG_SURFACE_GPE=y
> CONFIG_SURFACE_HOTPLUG=y
> CONFIG_SURFACE_PRO3_BUTTON=y
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACPI_WMI is not set
> CONFIG_ACERHDF=y
> CONFIG_ACER_WIRELESS=y
> # CONFIG_AMD_PMC is not set
> # CONFIG_AMD_HSMP is not set
> CONFIG_ADV_SWBUTTON=y
> # CONFIG_APPLE_GMUX is not set
> CONFIG_ASUS_LAPTOP=y
> CONFIG_ASUS_WIRELESS=y
> CONFIG_ASUS_TF103C_DOCK=y
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_FUJITSU_LAPTOP=y
> CONFIG_FUJITSU_TABLET=y
> # CONFIG_GPD_POCKET_FAN is not set
> CONFIG_HP_ACCEL=y
> CONFIG_WIRELESS_HOTKEY=y
> # CONFIG_IBM_RTL is not set
> CONFIG_SENSORS_HDAPS=y
> CONFIG_THINKPAD_ACPI=y
> CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=y
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> # CONFIG_INTEL_ATOMISP2_LED is not set
> CONFIG_INTEL_SAR_INT1092=y
> # CONFIG_INTEL_SKL_INT3472 is not set
> # CONFIG_INTEL_PMC_CORE is not set
> 
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
> 
> #
> # Intel Uncore Frequency Control
> #
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # end of Intel Uncore Frequency Control
> 
> CONFIG_INTEL_HID_EVENT=y
> CONFIG_INTEL_VBTN=y
> CONFIG_INTEL_INT0002_VGPIO=y
> CONFIG_INTEL_BXTWC_PMIC_TMU=y
> CONFIG_INTEL_CHTDC_TI_PWRBTN=y
> CONFIG_INTEL_MRFLD_PWRBTN=y
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_RST is not set
> CONFIG_INTEL_SMARTCONNECT=y
> # CONFIG_INTEL_VSEC is not set
> CONFIG_PCENGINES_APU2=y
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=y
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> CONFIG_TOSHIBA_HAPS=y
> CONFIG_ACPI_CMPC=y
> CONFIG_PANASONIC_LAPTOP=y
> CONFIG_SYSTEM76_ACPI=y
> # CONFIG_TOPSTAR_LAPTOP is not set
> CONFIG_SERIAL_MULTI_INSTANTIATE=y
> CONFIG_MLX_PLATFORM=y
> CONFIG_TOUCHSCREEN_DMI=y
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_SCU_IPC=y
> CONFIG_INTEL_SCU=y
> # CONFIG_INTEL_SCU_PCI is not set
> CONFIG_INTEL_SCU_PLATFORM=y
> CONFIG_INTEL_SCU_IPC_UTIL=y
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> # CONFIG_P2SB is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> CONFIG_LMK04832=y
> # CONFIG_COMMON_CLK_MAX9485 is not set
> CONFIG_COMMON_CLK_SI5341=y
> CONFIG_COMMON_CLK_SI5351=y
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> CONFIG_CLK_TWL6040=y
> # CONFIG_COMMON_CLK_PWM is not set
> CONFIG_XILINX_VCU=y
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> CONFIG_ALTERA_MBOX=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> CONFIG_IOMMU_DEBUGFS=y
> # CONFIG_AMD_IOMMU is not set
> # CONFIG_VIRTIO_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CHAR=y
> CONFIG_RPMSG_CTRL=y
> CONFIG_RPMSG_NS=y
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> CONFIG_SOC_TI=y
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=y
> # CONFIG_EXTCON_FSA9480 is not set
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> # CONFIG_EXTCON_INTEL_CHT_WC is not set
> CONFIG_EXTCON_INTEL_MRFLD=y
> CONFIG_EXTCON_MAX3355=y
> CONFIG_EXTCON_MAX77843=y
> CONFIG_EXTCON_PTN5150=y
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> # CONFIG_EXTCON_USBC_CROS_EC is not set
> # CONFIG_EXTCON_USBC_TUSB320 is not set
> CONFIG_MEMORY=y
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> CONFIG_IIO_BUFFER_DMA=y
> CONFIG_IIO_BUFFER_DMAENGINE=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> # CONFIG_IIO_CONFIGFS is not set
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> CONFIG_IIO_TRIGGERED_EVENT=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=y
> # CONFIG_ADIS16209 is not set
> CONFIG_ADXL313=y
> CONFIG_ADXL313_I2C=y
> CONFIG_ADXL313_SPI=y
> CONFIG_ADXL355=y
> CONFIG_ADXL355_I2C=y
> # CONFIG_ADXL355_SPI is not set
> CONFIG_ADXL367=y
> # CONFIG_ADXL367_SPI is not set
> CONFIG_ADXL367_I2C=y
> CONFIG_ADXL372=y
> CONFIG_ADXL372_SPI=y
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_BMA180 is not set
> CONFIG_BMA220=y
> CONFIG_BMA400=y
> CONFIG_BMA400_I2C=y
> CONFIG_BMA400_SPI=y
> # CONFIG_BMC150_ACCEL is not set
> CONFIG_BMI088_ACCEL=y
> CONFIG_BMI088_ACCEL_SPI=y
> CONFIG_DA280=y
> CONFIG_DA311=y
> CONFIG_DMARD06=y
> # CONFIG_DMARD09 is not set
> CONFIG_DMARD10=y
> CONFIG_FXLS8962AF=y
> CONFIG_FXLS8962AF_I2C=y
> CONFIG_FXLS8962AF_SPI=y
> CONFIG_IIO_ST_ACCEL_3AXIS=y
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
> CONFIG_KXSD9=y
> CONFIG_KXSD9_SPI=y
> # CONFIG_KXSD9_I2C is not set
> CONFIG_KXCJK1013=y
> CONFIG_MC3230=y
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> CONFIG_MMA7660=y
> # CONFIG_MMA8452 is not set
> CONFIG_MMA9551_CORE=y
> CONFIG_MMA9551=y
> # CONFIG_MMA9553 is not set
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> # CONFIG_SCA3000 is not set
> # CONFIG_SCA3300 is not set
> # CONFIG_STK8312 is not set
> CONFIG_STK8BA50=y
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=y
> CONFIG_AD7091R5=y
> CONFIG_AD7124=y
> CONFIG_AD7192=y
> CONFIG_AD7266=y
> CONFIG_AD7280=y
> CONFIG_AD7291=y
> # CONFIG_AD7292 is not set
> # CONFIG_AD7298 is not set
> CONFIG_AD7476=y
> CONFIG_AD7606=y
> CONFIG_AD7606_IFACE_PARALLEL=y
> CONFIG_AD7606_IFACE_SPI=y
> CONFIG_AD7766=y
> # CONFIG_AD7768_1 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7791 is not set
> CONFIG_AD7793=y
> # CONFIG_AD7887 is not set
> CONFIG_AD7923=y
> CONFIG_AD7949=y
> CONFIG_AD799X=y
> # CONFIG_AXP20X_ADC is not set
> # CONFIG_AXP288_ADC is not set
> CONFIG_CC10001_ADC=y
> CONFIG_DA9150_GPADC=y
> CONFIG_ENVELOPE_DETECTOR=y
> CONFIG_HI8435=y
> CONFIG_HX711=y
> CONFIG_INTEL_MRFLD_ADC=y
> CONFIG_LP8788_ADC=y
> CONFIG_LTC2471=y
> # CONFIG_LTC2485 is not set
> CONFIG_LTC2496=y
> CONFIG_LTC2497=y
> CONFIG_MAX1027=y
> # CONFIG_MAX11100 is not set
> CONFIG_MAX1118=y
> CONFIG_MAX1241=y
> CONFIG_MAX1363=y
> CONFIG_MAX9611=y
> CONFIG_MCP320X=y
> # CONFIG_MCP3422 is not set
> CONFIG_MCP3911=y
> CONFIG_MEDIATEK_MT6360_ADC=y
> CONFIG_MEN_Z188_ADC=y
> # CONFIG_MP2629_ADC is not set
> # CONFIG_NAU7802 is not set
> CONFIG_SD_ADC_MODULATOR=y
> # CONFIG_TI_ADC081C is not set
> CONFIG_TI_ADC0832=y
> # CONFIG_TI_ADC084S021 is not set
> CONFIG_TI_ADC12138=y
> # CONFIG_TI_ADC108S102 is not set
> # CONFIG_TI_ADC128S052 is not set
> CONFIG_TI_ADC161S626=y
> # CONFIG_TI_ADS1015 is not set
> CONFIG_TI_ADS7950=y
> CONFIG_TI_ADS8344=y
> CONFIG_TI_ADS8688=y
> CONFIG_TI_ADS124S08=y
> # CONFIG_TI_ADS131E08 is not set
> CONFIG_TI_AM335X_ADC=y
> # CONFIG_TI_TLC4541 is not set
> CONFIG_TI_TSC2046=y
> CONFIG_VF610_ADC=y
> CONFIG_XILINX_XADC=y
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> CONFIG_AD74413R=y
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
> # CONFIG_ADA4250 is not set
> CONFIG_HMC425=y
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=y
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=y
> CONFIG_ATLAS_EZO_SENSOR=y
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> CONFIG_BME680_SPI=y
> CONFIG_CCS811=y
> CONFIG_IAQCORE=y
> CONFIG_SCD30_CORE=y
> # CONFIG_SCD30_I2C is not set
> CONFIG_SCD4X=y
> # CONFIG_SENSIRION_SGP30 is not set
> CONFIG_SENSIRION_SGP40=y
> CONFIG_SPS30=y
> CONFIG_SPS30_I2C=y
> CONFIG_SENSEAIR_SUNRISE_CO2=y
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORS_COMMONS is not set
> CONFIG_IIO_SSP_SENSORHUB=y
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_SPI=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD3552R=y
> CONFIG_AD5064=y
> # CONFIG_AD5360 is not set
> # CONFIG_AD5380 is not set
> # CONFIG_AD5421 is not set
> CONFIG_AD5446=y
> # CONFIG_AD5449 is not set
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5592R=y
> CONFIG_AD5593R=y
> # CONFIG_AD5504 is not set
> CONFIG_AD5624R_SPI=y
> # CONFIG_LTC2688 is not set
> CONFIG_AD5686=y
> # CONFIG_AD5686_SPI is not set
> CONFIG_AD5696_I2C=y
> CONFIG_AD5755=y
> CONFIG_AD5758=y
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> CONFIG_AD5766=y
> # CONFIG_AD5770R is not set
> CONFIG_AD5791=y
> CONFIG_AD7293=y
> CONFIG_AD7303=y
> # CONFIG_AD8801 is not set
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> CONFIG_LTC1660=y
> CONFIG_LTC2632=y
> CONFIG_M62332=y
> CONFIG_MAX517=y
> CONFIG_MAX5821=y
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4922 is not set
> # CONFIG_TI_DAC082S085 is not set
> CONFIG_TI_DAC5571=y
> # CONFIG_TI_DAC7311 is not set
> # CONFIG_TI_DAC7612 is not set
> CONFIG_VF610_DAC=y
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # CONFIG_ADMV8818 is not set
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> CONFIG_AD9523=y
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=y
> CONFIG_ADF4371=y
> CONFIG_ADMV1013=y
> CONFIG_ADMV1014=y
> CONFIG_ADMV4420=y
> CONFIG_ADRF6780=y
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=y
> CONFIG_ADIS16130=y
> # CONFIG_ADIS16136 is not set
> CONFIG_ADIS16260=y
> CONFIG_ADXRS290=y
> CONFIG_ADXRS450=y
> CONFIG_BMG160=y
> CONFIG_BMG160_I2C=y
> CONFIG_BMG160_SPI=y
> CONFIG_FXAS21002C=y
> CONFIG_FXAS21002C_I2C=y
> CONFIG_FXAS21002C_SPI=y
> CONFIG_MPU3050=y
> CONFIG_MPU3050_I2C=y
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> CONFIG_AFE4404=y
> # CONFIG_MAX30100 is not set
> CONFIG_MAX30102=y
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> CONFIG_DHT11=y
> CONFIG_HDC100X=y
> CONFIG_HDC2010=y
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> CONFIG_HTS221_SPI=y
> CONFIG_HTU21=y
> CONFIG_SI7005=y
> CONFIG_SI7020=y
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> # CONFIG_ADIS16460 is not set
> CONFIG_ADIS16475=y
> CONFIG_ADIS16480=y
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_BMI160_SPI=y
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> CONFIG_KMX61=y
> CONFIG_INV_ICM42600=y
> # CONFIG_INV_ICM42600_I2C is not set
> CONFIG_INV_ICM42600_SPI=y
> CONFIG_INV_MPU6050_IIO=y
> CONFIG_INV_MPU6050_I2C=y
> CONFIG_INV_MPU6050_SPI=y
> CONFIG_IIO_ST_LSM6DSX=y
> CONFIG_IIO_ST_LSM6DSX_I2C=y
> CONFIG_IIO_ST_LSM6DSX_SPI=y
> # CONFIG_IIO_ST_LSM9DS0 is not set
> # end of Inertial measurement units
> 
> CONFIG_IIO_ADIS_LIB=y
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> CONFIG_ACPI_ALS=y
> # CONFIG_ADJD_S311 is not set
> CONFIG_ADUX1020=y
> CONFIG_AL3010=y
> # CONFIG_AL3320A is not set
> CONFIG_APDS9300=y
> # CONFIG_APDS9960 is not set
> CONFIG_AS73211=y
> CONFIG_BH1750=y
> CONFIG_BH1780=y
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> CONFIG_CM3323=y
> CONFIG_CM3605=y
> CONFIG_CM36651=y
> CONFIG_GP2AP002=y
> CONFIG_GP2AP020A00F=y
> CONFIG_SENSORS_ISL29018=y
> CONFIG_SENSORS_ISL29028=y
> # CONFIG_ISL29125 is not set
> CONFIG_JSA1212=y
> # CONFIG_RPR0521 is not set
> CONFIG_LTR501=y
> CONFIG_LV0104CS=y
> # CONFIG_MAX44000 is not set
> CONFIG_MAX44009=y
> CONFIG_NOA1305=y
> CONFIG_OPT3001=y
> # CONFIG_PA12203001 is not set
> # CONFIG_SI1133 is not set
> # CONFIG_SI1145 is not set
> CONFIG_STK3310=y
> CONFIG_ST_UVIS25=y
> CONFIG_ST_UVIS25_I2C=y
> CONFIG_ST_UVIS25_SPI=y
> CONFIG_TCS3414=y
> CONFIG_TCS3472=y
> # CONFIG_SENSORS_TSL2563 is not set
> CONFIG_TSL2583=y
> CONFIG_TSL2591=y
> CONFIG_TSL2772=y
> # CONFIG_TSL4531 is not set
> CONFIG_US5182D=y
> # CONFIG_VCNL4000 is not set
> CONFIG_VCNL4035=y
> CONFIG_VEML6030=y
> CONFIG_VEML6070=y
> # CONFIG_VL6180 is not set
> # CONFIG_ZOPT2201 is not set
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8974 is not set
> CONFIG_AK8975=y
> CONFIG_AK09911=y
> CONFIG_BMC150_MAGN=y
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=y
> # CONFIG_MAG3110 is not set
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> # CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> # CONFIG_SENSORS_HMC5843_SPI is not set
> CONFIG_SENSORS_RM3100=y
> CONFIG_SENSORS_RM3100_I2C=y
> CONFIG_SENSORS_RM3100_SPI=y
> CONFIG_YAMAHA_YAS530=y
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=y
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=y
> # CONFIG_DS1803 is not set
> CONFIG_MAX5432=y
> CONFIG_MAX5481=y
> CONFIG_MAX5487=y
> # CONFIG_MCP4018 is not set
> # CONFIG_MCP4131 is not set
> CONFIG_MCP4531=y
> CONFIG_MCP41010=y
> # CONFIG_TPL0102 is not set
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=y
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> CONFIG_BMP280_SPI=y
> CONFIG_DLHL60D=y
> # CONFIG_DPS310 is not set
> # CONFIG_HP03 is not set
> CONFIG_ICP10100=y
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> CONFIG_MPL115_SPI=y
> CONFIG_MPL3115=y
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> # CONFIG_MS5611_SPI is not set
> # CONFIG_MS5637 is not set
> CONFIG_IIO_ST_PRESS=y
> CONFIG_IIO_ST_PRESS_I2C=y
> # CONFIG_IIO_ST_PRESS_SPI is not set
> # CONFIG_T5403 is not set
> CONFIG_HP206C=y
> CONFIG_ZPA2326=y
> CONFIG_ZPA2326_I2C=y
> CONFIG_ZPA2326_SPI=y
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> CONFIG_AS3935=y
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_CROS_EC_MKBP_PROXIMITY=y
> # CONFIG_ISL29501 is not set
> CONFIG_LIDAR_LITE_V2=y
> CONFIG_MB1232=y
> # CONFIG_PING is not set
> CONFIG_RFD77402=y
> CONFIG_SRF04=y
> CONFIG_SX_COMMON=y
> CONFIG_SX9310=y
> # CONFIG_SX9324 is not set
> CONFIG_SX9360=y
> CONFIG_SX9500=y
> CONFIG_SRF08=y
> CONFIG_VCNL3020=y
> CONFIG_VL53L0X_I2C=y
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=y
> CONFIG_AD2S1200=y
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> CONFIG_MAXIM_THERMOCOUPLE=y
> CONFIG_MLX90614=y
> CONFIG_MLX90632=y
> CONFIG_TMP006=y
> CONFIG_TMP007=y
> # CONFIG_TMP117 is not set
> # CONFIG_TSYS01 is not set
> CONFIG_TSYS02D=y
> CONFIG_MAX31856=y
> # CONFIG_MAX31865 is not set
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> CONFIG_PWM_CLK=y
> # CONFIG_PWM_CROS_EC is not set
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LP3943=y
> CONFIG_PWM_LPSS=y
> # CONFIG_PWM_LPSS_PCI is not set
> CONFIG_PWM_LPSS_PLATFORM=y
> # CONFIG_PWM_PCA9685 is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_BOARD_TPCI200 is not set
> CONFIG_SERIAL_IPOCTAL=y
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=y
> # CONFIG_RESET_TI_TPS380X is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_USB_LGM_PHY is not set
> CONFIG_PHY_CAN_TRANSCEIVER=y
> 
> #
> # PHY drivers for Broadcom platforms
> #
> CONFIG_BCM_KONA_USB2_PHY=y
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_CPCAP_USB is not set
> CONFIG_PHY_INTEL_LGM_EMMC=y
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=y
> # CONFIG_MCB_PCI is not set
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> # CONFIG_RAS is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> # CONFIG_LIBNVDIMM is not set
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> CONFIG_NVMEM_RMEM=y
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> # CONFIG_STM_PROTO_BASIC is not set
> CONFIG_STM_PROTO_SYS_T=y
> CONFIG_STM_DUMMY=y
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=y
> # CONFIG_STM_SOURCE_FTRACE is not set
> CONFIG_INTEL_TH=y
> # CONFIG_INTEL_TH_PCI is not set
> # CONFIG_INTEL_TH_ACPI is not set
> # CONFIG_INTEL_TH_GTH is not set
> CONFIG_INTEL_TH_STH=y
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> CONFIG_TEE=y
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> # CONFIG_MUX_ADGS1408 is not set
> # CONFIG_MUX_GPIO is not set
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=y
> CONFIG_INTERCONNECT=y
> CONFIG_COUNTER=y
> CONFIG_INTERRUPT_CNT=y
> # CONFIG_INTEL_QEP is not set
> # CONFIG_MOST is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> CONFIG_EXT3_FS=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_CHECK=y
> CONFIG_REISERFS_PROC_INFO=y
> # CONFIG_REISERFS_FS_XATTR is not set
> CONFIG_JFS_FS=y
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_SECURITY=y
> CONFIG_JFS_DEBUG=y
> CONFIG_JFS_STATISTICS=y
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=y
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> # CONFIG_F2FS_FS_POSIX_ACL is not set
> CONFIG_F2FS_FS_SECURITY=y
> CONFIG_F2FS_CHECK_FS=y
> # CONFIG_F2FS_FAULT_INJECTION is not set
> CONFIG_F2FS_FS_COMPRESSION=y
> # CONFIG_F2FS_FS_LZO is not set
> CONFIG_F2FS_FS_LZ4=y
> # CONFIG_F2FS_FS_LZ4HC is not set
> CONFIG_F2FS_FS_ZSTD=y
> CONFIG_F2FS_IOSTAT=y
> CONFIG_ZONEFS_FS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> CONFIG_QUOTA_DEBUG=y
> CONFIG_QFMT_V1=y
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> # CONFIG_VIRTIO_FS is not set
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=y
> CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> # CONFIG_PROC_VMCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_TMPFS_INODE64 is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> CONFIG_ADFS_FS=y
> CONFIG_ADFS_FS_RW=y
> CONFIG_AFFS_FS=y
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=y
> CONFIG_HFSPLUS_FS=y
> CONFIG_BEFS_FS=y
> CONFIG_BEFS_DEBUG=y
> # CONFIG_BFS_FS is not set
> CONFIG_EFS_FS=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> CONFIG_JFFS2_FS_WBUF_VERIFY=y
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_FS_XATTR is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_RTIME=y
> CONFIG_UBIFS_FS=y
> # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> CONFIG_UBIFS_FS_LZO=y
> CONFIG_UBIFS_FS_ZLIB=y
> CONFIG_UBIFS_FS_ZSTD=y
> CONFIG_UBIFS_ATIME_SUPPORT=y
> CONFIG_UBIFS_FS_XATTR=y
> # CONFIG_UBIFS_FS_SECURITY is not set
> CONFIG_UBIFS_FS_AUTHENTICATION=y
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> # CONFIG_SQUASHFS_XATTR is not set
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=y
> # CONFIG_MINIX_FS is not set
> CONFIG_OMFS_FS=y
> CONFIG_HPFS_FS=y
> # CONFIG_QNX4FS_FS is not set
> CONFIG_QNX6FS_FS=y
> # CONFIG_QNX6FS_DEBUG is not set
> CONFIG_ROMFS_FS=y
> CONFIG_ROMFS_BACKED_BY_BLOCK=y
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_BLOCK=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> CONFIG_PSTORE_LZ4HC_COMPRESS=y
> CONFIG_PSTORE_842_COMPRESS=y
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> CONFIG_PSTORE_CONSOLE=y
> CONFIG_PSTORE_PMSG=y
> CONFIG_PSTORE_RAM=y
> CONFIG_PSTORE_ZONE=y
> CONFIG_PSTORE_BLK=y
> CONFIG_PSTORE_BLK_BLKDEV=""
> CONFIG_PSTORE_BLK_KMSG_SIZE=64
> CONFIG_PSTORE_BLK_MAX_REASON=2
> CONFIG_PSTORE_BLK_PMSG_SIZE=64
> CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=y
> CONFIG_UFS_FS_WRITE=y
> # CONFIG_UFS_DEBUG is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> # CONFIG_NLS_CODEPAGE_850 is not set
> CONFIG_NLS_CODEPAGE_852=y
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> # CONFIG_NLS_CODEPAGE_863 is not set
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> # CONFIG_NLS_CODEPAGE_949 is not set
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> # CONFIG_NLS_ISO8859_1 is not set
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> # CONFIG_NLS_ISO8859_5 is not set
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> CONFIG_NLS_MAC_INUIT=y
> # CONFIG_NLS_MAC_ROMANIAN is not set
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_REQUEST_CACHE=y
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_USER_DECRYPTED_DATA=y
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> CONFIG_SECURITY_DMESG_RESTRICT=y
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> # CONFIG_SECURITY_NETWORK is not set
> # CONFIG_SECURITY_PATH is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> # CONFIG_INTEGRITY_SIGNATURE is not set
> CONFIG_INTEGRITY_AUDIT=y
> # CONFIG_IMA is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf,integrity"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> CONFIG_GCC_PLUGIN_STACKLEAK=y
> CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
> CONFIG_STACKLEAK_METRICS=y
> # CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
> CONFIG_ZERO_CALL_USED_REGS=y
> # end of Memory initialization
> 
> CONFIG_RANDSTRUCT_NONE=y
> # CONFIG_RANDSTRUCT_FULL is not set
> # CONFIG_RANDSTRUCT_PERFORMANCE is not set
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_ENGINE=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_ECDSA=y
> CONFIG_CRYPTO_ECRDSA=y
> CONFIG_CRYPTO_SM2=y
> CONFIG_CRYPTO_CURVE25519=y
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XCTR=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_NHPOLY1305=y
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> CONFIG_CRYPTO_NHPOLY1305_AVX2=y
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_HCTR2=y
> CONFIG_CRYPTO_ESSIV=y
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> # CONFIG_CRYPTO_XXHASH is not set
> CONFIG_CRYPTO_BLAKE2B=y
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
> CONFIG_CRYPTO_CRC64_ROCKSOFT=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLYVAL=y
> CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
> CONFIG_CRYPTO_POLY1305=y
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> CONFIG_CRYPTO_SHA256_SSSE3=y
> CONFIG_CRYPTO_SHA512_SSSE3=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_SM3_GENERIC=y
> CONFIG_CRYPTO_SM3_AVX_X86_64=y
> CONFIG_CRYPTO_STREEBOG=y
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAMELLIA_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST5_AVX_X86_64=y
> CONFIG_CRYPTO_CAST6=y
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_DES3_EDE_X86_64=y
> # CONFIG_CRYPTO_FCRYPT is not set
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CHACHA20_X86_64=y
> CONFIG_CRYPTO_ARIA=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
> # CONFIG_CRYPTO_SM4_GENERIC is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_KDF800108_CTR=y
> CONFIG_CRYPTO_USER_API=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> # CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
> CONFIG_CRYPTO_HASH_INFO=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> # CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> CONFIG_CRYPTO_DEV_ATMEL_I2C=y
> CONFIG_CRYPTO_DEV_ATMEL_ECC=y
> CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
> # CONFIG_CRYPTO_DEV_CCP is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA1=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_LIB_MEMNEQ=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC64_ROCKSOFT=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_BCH_CONST_PARAMS=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_CMA=y
> # CONFIG_DMA_PERNUMA_CMA is not set
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DMA_MAP_BENCHMARK=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_FORCE_NR_CPUS=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACKDEPOT_ALWAYS_INIT=y
> CONFIG_REF_TRACKER=y
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> CONFIG_STACKTRACE_BUILD_ID=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_MISC is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=y
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_GDB_SCRIPTS=y
> CONFIG_FRAME_WARN=8192
> CONFIG_STRIP_ASM_SYMS=y
> CONFIG_READABLE_ASM=y
> CONFIG_HEADERS_INSTALL=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_OBJTOOL=y
> CONFIG_NOINSTR_VALIDATION=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> CONFIG_DEBUG_FS_ALLOW_NONE=y
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> CONFIG_NET_DEV_REFCNT_TRACKER=y
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # CONFIG_DEBUG_NET is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_TABLE_CHECK=y
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> # CONFIG_DEBUG_OBJECTS_FREE is not set
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> # CONFIG_DEBUG_OBJECTS_WORK is not set
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_SHRINKER_DEBUG=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
> CONFIG_KASAN_VMALLOC=y
> # CONFIG_KASAN_MODULE_TEST is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=m
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> CONFIG_CSD_LOCK_WAIT_DEBUG=y
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PLIST=y
> CONFIG_DEBUG_SG=y
> CONFIG_DEBUG_NOTIFIERS=y
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> # CONFIG_PROVE_RCU_LIST is not set
> CONFIG_TORTURE_TEST=m
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_RETHOOK=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> CONFIG_SAMPLES=y
> CONFIG_SAMPLE_AUXDISPLAY=y
> # CONFIG_SAMPLE_TRACE_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_PRINTK is not set
> # CONFIG_SAMPLE_TRACE_ARRAY is not set
> # CONFIG_SAMPLE_KOBJECT is not set
> # CONFIG_SAMPLE_HW_BREAKPOINT is not set
> # CONFIG_SAMPLE_KFIFO is not set
> # CONFIG_SAMPLE_RPMSG_CLIENT is not set
> # CONFIG_SAMPLE_CONFIGFS is not set
> CONFIG_SAMPLE_HIDRAW=y
> # CONFIG_SAMPLE_LANDLOCK is not set
> CONFIG_SAMPLE_PIDFD=y
> # CONFIG_SAMPLE_SECCOMP is not set
> # CONFIG_SAMPLE_TIMER is not set
> CONFIG_SAMPLE_UHID=y
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> CONFIG_SAMPLE_ANDROID_BINDERFS=y
> CONFIG_SAMPLE_VFS=y
> CONFIG_SAMPLE_WATCHDOG=y
> CONFIG_SAMPLE_WATCH_QUEUE=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> CONFIG_DEBUG_ENTRY=y
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_PM_NOTIFIER_ERROR_INJECT=y
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAILSLAB=y
> CONFIG_FAIL_PAGE_ALLOC=y
> CONFIG_FAULT_INJECTION_USERCOPY=y
> # CONFIG_FAIL_MAKE_REQUEST is not set
> CONFIG_FAIL_IO_TIMEOUT=y
> CONFIG_FAIL_FUTEX=y
> # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export category='functional'
> 	export timeout='10m'
> 	export job_origin='boot.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='bisect'
> 	export testbox='vm-snb'
> 	export tbox_group='vm-snb'
> 	export branch='linus/master'
> 	export commit='6f9c07be9d020489326098801f0661f754c7c865'
> 	export kconfig='x86_64-randconfig-r005-20221017'
> 	export nr_vm=300
> 	export submit_id='635055118f307d2a2b36de16'
> 	export job_file='/lkp/jobs/scheduled/vm-meta-59/boot-1-debian-11.1-x86_64-20220510.cgz-6f9c07be9d020489326098801f0661f754c7c865-20221020-141867-1nbglkc-0.yaml'
> 	export id='0833ab14d574d6bb0ed4f85aaa9b90bdb3080aae'
> 	export queuer_version='/zday/lkp'
> 	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='16G'
> 	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
> 	export ssh_base_port=23032
> 	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
> 	export rootfs='debian-11.1-x86_64-20220510.cgz'
> 	export compiler='gcc-11'
> 	export enqueue_time='2022-10-20 03:50:41 +0800'
> 	export _id='635055118f307d2a2b36de16'
> 	export _rt='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865/8'
> 	export scheduler_version='/lkp/lkp/.src-20221019-184203'
> 	export arch='x86_64'
> 	export max_uptime=600
> 	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
> 	export bootloader_append='root=/dev/ram0
> RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865/8
> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865/vmlinuz-6.0.0-rc4-00007-g6f9c07be9d02
> branch=linus/master
> job=/lkp/jobs/scheduled/vm-meta-59/boot-1-debian-11.1-x86_64-20220510.cgz-6f9c07be9d020489326098801f0661f754c7c865-20221020-141867-1nbglkc-0.yaml
> user=lkp
> ARCH=x86_64
> kconfig=x86_64-randconfig-r005-20221017
> commit=6f9c07be9d020489326098801f0661f754c7c865
> vmalloc=256M initramfs_async=0 page_owner=on
> initcall_debug
> max_uptime=600
> LKP_SERVER=internal-lkp-server
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export schedule_notify_address=
> 	export meta_host='vm-meta-59'
> 	export kernel='/pkg/linux/x86_64-randconfig-r005-20221017/gcc-11/6f9c07be9d020489326098801f0661f754c7c865/vmlinuz-6.0.0-rc4-00007-g6f9c07be9d02'
> 	export dequeue_time='2022-10-20 04:36:58 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-meta-59/boot-1-debian-11.1-x86_64-20220510.cgz-6f9c07be9d020489326098801f0661f754c7c865-20221020-141867-1nbglkc-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper sleep
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


