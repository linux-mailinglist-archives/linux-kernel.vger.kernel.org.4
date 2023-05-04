Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833546F64E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEDGZM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 May 2023 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEDGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:25:06 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F526B5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:25:01 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33159dbb32aso1822635ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181501; x=1685773501;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoWQLBawI/1vGZx6Rxp7lM96E1fIPAchJV0aVF52VyQ=;
        b=St+fntmH8oy3pmfUhr+4UytgVXmz7nPkA4ugH1txbgUtEfk6LznDsYS0WSiUgjK0Up
         fb4FyQKfezKUkspLnPvMNERACr8FMfCOtnaQ2Bl1IoixNNXCtvqZRKCjgRew4LYuDOoL
         hP7IS0MosuWV09DMD2nw7FhsSCcHUrzr4ihhgglqp38mLCU9Xy56+zFAF6mBeDEf1aVO
         dQvi1GA6jdVpY01mI5QkXYPsU0E1XWZrP4nw6knW4nXm3ZM2CbzZezBPC2isVGOYci5K
         ivbovjSXRI2Mw3cmCMuH+j+kYigrPER3mv3g9uqvScQ3bNWh2Qsn6Q6mmhqI0IchuEgb
         DohQ==
X-Gm-Message-State: AC+VfDyuvyQsYH3pQbta796XsHBkZlFMH8H4KBz8EQa0AoiYPkCKIUHu
        8E4n+C4CC0pHSFwjZUlsYoIPvq19tXK73tVADX3wKtyuxx7h
X-Google-Smtp-Source: ACHHUZ4Lqz2b+nA+1muaRTm1b++lu1A7i5jJo3shdvMzVtVHH6hTiy4DYvDEceBGpBosPqm5xBRQxf7tc8klLBF9E/304DT3FXJR
MIME-Version: 1.0
X-Received: by 2002:a02:7a45:0:b0:40b:c01e:6d0f with SMTP id
 z5-20020a027a45000000b0040bc01e6d0fmr11023104jad.2.1683181500940; Wed, 03 May
 2023 23:25:00 -0700 (PDT)
Date:   Wed, 03 May 2023 23:25:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074cbe805fad83bb6@google.com>
Subject: [syzbot] upstream boot error: WARNING in print_tainted
From:   syzbot <syzbot+6a9b930b1a8d784b692a@syzkaller.appspotmail.com>
To:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1081973c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=124f13edd5df0b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=6a9b930b1a8d784b692a
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a9b930b1a8d784b692a@syzkaller.appspotmail.com

Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000ffffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 520868
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
Memory: 1952316K/2097152K available (24576K kernel code, 2364K rwdata, 8404K rodata, 2048K init, 868K bss, 128452K reserved, 16384K cma-reserved, 524288K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
trace event string verifier disabled
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC physical location is 0x2c001000
rcu: srcu_init: Setting srcu_struct sizes based on contention.
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
arch_timer: cp15 timer(s) running at 62.50MHz (virt).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
Switching to timer-based delay loop, resolution 16ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
SELinux:  Initializing.
LSM support for eBPF active
stackdepot: allocating hash table of 131072 entries via kvcalloc
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre BHB: enabling loop workaround for all CPUs
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/gpio/gpiolib.c:3222 gpiod_set_value+0x6c/0xc0 drivers/gpio/gpiolib.c:3222
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<817d86c4>] (dump_backtrace) from [<817d87b8>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:826229c4 r5:60000193 r4:81f9cf30
[<817d87a0>] (show_stack) from [<817f5290>] (__dump_stack lib/dump_stack.c:88 [inline])
[<817d87a0>] (show_stack) from [<817f5290>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<817f5248>] (dump_stack_lvl) from [<817f52b4>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:82850d14
[<817f529c>] (dump_stack) from [<817d92b0>] (panic+0x120/0x370 kernel/panic.c:340)
[<817d9190>] (panic) from [<80241fa8>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c488 r2:00000001 r1:81f86028 r0:81f8da38
 r7:808919a4
[<80241f24>] (check_panic_on_warn) from [<8024219c>] (__warn+0x7c/0x180 kernel/panic.c:673)
[<80242120>] (__warn) from [<80242378>] (warn_slowpath_fmt+0xd8/0x1d8 kernel/panic.c:697)
 r8:00000009 r7:00000c96 r6:81fef2c4 r5:8260c964 r4:824adf7c
[<802422a4>] (warn_slowpath_fmt) from [<808919a4>] (gpiod_set_value+0x6c/0xc0 drivers/gpio/gpiolib.c:3222)
 r10:00000000 r9:827e1666 r8:00000001 r7:dddd1798 r6:000000ff r5:00000001
 r4:84154868
[<80891938>] (gpiod_set_value) from [<8107f2f0>] (gpio_led_set+0x5c/0x60 drivers/leds/leds-gpio.c:54)
 r5:000000ff r4:8301c1dc
[<8107f294>] (gpio_led_set) from [<8107d720>] (__led_set_brightness drivers/leds/led-core.c:47 [inline])
[<8107f294>] (gpio_led_set) from [<8107d720>] (led_set_brightness_nopm drivers/leds/led-core.c:271 [inline])
[<8107f294>] (gpio_led_set) from [<8107d720>] (led_set_brightness_nosleep+0x38/0x5c drivers/leds/led-core.c:287)
 r5:000000ff r4:8301c1dc
[<8107d6e8>] (led_set_brightness_nosleep) from [<8107da6c>] (led_set_brightness+0x64/0x68 drivers/leds/led-core.c:264)
[<8107da08>] (led_set_brightness) from [<8107e908>] (led_trigger_event drivers/leds/led-triggers.c:390 [inline])
[<8107da08>] (led_set_brightness) from [<8107e908>] (led_trigger_event+0x38/0x50 drivers/leds/led-triggers.c:380)
 r5:8415f814 r4:8301c1dc
[<8107e8d0>] (led_trigger_event) from [<8107fcd0>] (ledtrig_cpu+0xb0/0x100 drivers/leds/trigger/ledtrig-cpu.c:86)
 r7:dddd1798 r6:00000002 r5:8290cee4 r4:000001fd
[<8107fc20>] (ledtrig_cpu) from [<80208efc>] (arch_cpu_idle_exit+0x14/0x18 arch/arm/kernel/process.c:98)
 r9:827e1666 r8:00000000 r7:8260c4e0 r6:8261ae40 r5:8260c498 r4:00000000
[<80208ee8>] (arch_cpu_idle_exit) from [<80293568>] (do_idle+0x7c/0x2f0 kernel/sched/idle.c:284)
[<802934ec>] (do_idle) from [<80293af8>] (cpu_startup_entry+0x20/0x24 kernel/sched/idle.c:379)
 r10:82850000 r9:8260c440 r8:8261a934 r7:00000000 r6:8260c440 r5:82625c7c
 r4:000000ea
[<80293ad8>] (cpu_startup_entry) from [<817f7294>] (rest_init+0xdc/0xe0 init/main.c:735)
[<817f71b8>] (rest_init) from [<82400bb8>] (arch_post_acpi_subsys_init+0x0/0x20 init/main.c:834)
[<82400ba8>] (arch_call_rest_init) from [<824012f8>] (start_kernel+0x6e0/0x70c init/main.c:1088)
[<82400c18>] (start_kernel) from [<00000000>] (0x0)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
