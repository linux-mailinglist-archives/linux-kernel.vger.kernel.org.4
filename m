Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70076FD07A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjEIVEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEIVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:04:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF825279
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:03:57 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-33389ee5c78so73692125ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 14:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666237; x=1686258237;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8hkvADHrZOhRuMtpMAqhjaF/KO/MdYW9grgisaEVY0=;
        b=ca9SMiQWJBag2W3pBXU5nGG9orKqlw7PwZRsYBvpz+VJA/3687/VgzdmVWQnVQ7o7j
         kr7qSjoTqhwpnTnRCIxY2H3PG0aFYmsi8f0iIIJhhX+xV8vn6gN3pfX6d2kY8JmF8X3r
         Mz5o0KE9viki6Vc/RNvYZO3hyikaLYsWKzRKgpNeB72A5vhvj25YEMVsPDjOtv4VZX3p
         kMm0vkLML5JKBq8c5Z5758r8kAORoSxoac0j4cpWex2eCTvelF5g/0T6RlYKjV+ATSDB
         PRcccs39FmqJprtioq6Av0jb+6oS1FMRYnZYBKCtZ/tVRlBSCk/UVSXJGkoqw1ZKtCt9
         W2Qw==
X-Gm-Message-State: AC+VfDwi8dpTYXSoj7rUkRoLYYR1pSBLVIRlupQnruqYBLLw1J/QvTgt
        Ky+mQBofDbZTg6RjoG6Zl+4xltNrUJ9OC7RbXJN5dGDrD3fb
X-Google-Smtp-Source: ACHHUZ644cLDxW29pjem5XY5WXV2y4K5qxPiTto8IY0/pngErvwu6aj4wlY08McP2Bcvgx+RsDFujyO8cWYSCdlOFXsmUdAQYBQ/
MIME-Version: 1.0
X-Received: by 2002:a92:c982:0:b0:331:21ed:30c7 with SMTP id
 y2-20020a92c982000000b0033121ed30c7mr8177082iln.0.1683666236981; Tue, 09 May
 2023 14:03:56 -0700 (PDT)
Date:   Tue, 09 May 2023 14:03:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9c9a505fb4917f6@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in do_page_fault
From:   syzbot <syzbot+49207572d7fa5be562a0@syzkaller.appspotmail.com>
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

HEAD commit:    ba0ad6ed89fd media: nxp: imx8-isi: fix buiding on 32-bit
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c3d40c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86fee67199911d
dashboard link: https://syzkaller.appspot.com/bug?extid=49207572d7fa5be562a0
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-ba0ad6ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/590de311efa7/vmlinux-ba0ad6ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7007b545886c/zImage-ba0ad6ed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49207572d7fa5be562a0@syzkaller.appspotmail.com

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
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000041 when read
[00000041] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at do_page_fault+0x14/0x3b8 arch/arm/mm/fault.c:276
LR is at gpiod_set_raw_value_commit+0x4c/0x168 drivers/gpio/gpiolib.c:3030
pc : [<802160d8>]    lr : [<808906c4>]    psr: 40000113
sp : 82601e08  ip : 82601e50  fp : 82601e4c
r10: 00000000  r9 : 827e1666  r8 : 00000001
r7 : 8261ae40  r6 : 00000001  r5 : 8404f4a8  r4 : 00000002
r3 : 802160c4  r2 : 00000001  r1 : 00000002  r0 : 831c0640
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd
Register r0 information: slab kmalloc-512 start 831c0600 pointer offset 64 size 512
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: non-slab/vmalloc memory
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-192 start 8404f480 pointer offset 40 size 192
Register r6 information: non-paged memory
Register r7 information: non-slab/vmalloc memory
Register r8 information: non-paged memory
Register r9 information: non-slab/vmalloc memory
Register r10 information: NULL pointer
Register r11 information: non-slab/vmalloc memory
Register r12 information: non-slab/vmalloc memory
Process swapper/0 (pid: 0, stack limit = 0x82600000)
Stack: (0x82601e08 to 0x82602000)
1e00:                   80201410 80298db8 817f6f00 817f6de8 04200002 82604d40
1e20: ffff8d67 00000002 8404f4a8 00000001 831c0640 00000001 827e1666 00000000
1e40: 82601e7c 82601e50 808906c4 802160d0 00000003 8404f4a8 00000001 000000ff
1e60: dddd1798 00000001 827e1666 00000000 82601e8c 82601e80 80890d54 80890684
1e80: 82601ea4 82601e90 80891ae8 80890d0c 8326c9dc 000000ff 82601ebc 82601ea8
1ea0: 8107f920 80891aa4 8326c9dc 000000ff 82601ecc 82601ec0 8107dd50 8107f8d0
1ec0: 82601ee4 82601ed0 8107e09c 8107dd24 8326c9dc 84655294 82601f04 82601ee8
1ee0: 8107ef38 8107e044 000001fd 8290cee4 00000002 dddd1798 82601f2c 82601f08
1f00: 81080300 8107ef0c 00000000 8260c498 8261ae40 8260c4e0 00000000 827e1666
1f20: 82601f3c 82601f30 80208efc 8108025c 82601f84 82601f40 80293570 80208ef4
1f40: 8260c440 00000000 81f86214 824af2f8 817f6f00 cbc96766 82601f84 000000ea
1f60: 82625c7c 8260c440 00000000 8261a934 8260c440 82850000 82601f94 82601f88
1f80: 80293b00 80293500 82601fa4 82601f98 817f7c74 80293aec 82601fb4 82601fa8
1fa0: 82400bb8 817f7ba4 82601ff4 82601fb8 824012f8 82400bb4 00000000 00000000
1fc0: 00000000 00000000 ffffffff 00000000 00000000 820ad698 82484a70 00000000
1fe0: 00000000 000008e0 00000000 82601ff8 00000000 82400c24 00000000 00000000
Backtrace: 
[<802160c4>] (do_page_fault) from [<808906c4>] (gpiod_set_raw_value_commit+0x4c/0x168 drivers/gpio/gpiolib.c:3030)
 r10:00000000 r9:827e1666 r8:00000001 r7:831c0640 r6:00000001 r5:8404f4a8
 r4:00000002
[<80890678>] (gpiod_set_raw_value_commit) from [<80890d54>] (gpiod_set_value_nocheck+0x54/0x58 drivers/gpio/gpiolib.c:3204)
 r10:00000000 r9:827e1666 r8:00000001 r7:dddd1798 r6:000000ff r5:00000001
 r4:8404f4a8 r3:00000003
[<80890d00>] (gpiod_set_value_nocheck) from [<80891ae8>] (gpiod_set_value+0x50/0xc0 drivers/gpio/gpiolib.c:3223)
[<80891a98>] (gpiod_set_value) from [<8107f920>] (gpio_led_set+0x5c/0x60 drivers/leds/leds-gpio.c:54)
 r5:000000ff r4:8326c9dc
[<8107f8c4>] (gpio_led_set) from [<8107dd50>] (__led_set_brightness drivers/leds/led-core.c:47 [inline])
[<8107f8c4>] (gpio_led_set) from [<8107dd50>] (led_set_brightness_nopm drivers/leds/led-core.c:271 [inline])
[<8107f8c4>] (gpio_led_set) from [<8107dd50>] (led_set_brightness_nosleep+0x38/0x5c drivers/leds/led-core.c:287)
 r5:000000ff r4:8326c9dc
[<8107dd18>] (led_set_brightness_nosleep) from [<8107e09c>] (led_set_brightness+0x64/0x68 drivers/leds/led-core.c:264)
[<8107e038>] (led_set_brightness) from [<8107ef38>] (led_trigger_event drivers/leds/led-triggers.c:390 [inline])
[<8107e038>] (led_set_brightness) from [<8107ef38>] (led_trigger_event+0x38/0x50 drivers/leds/led-triggers.c:380)
 r5:84655294 r4:8326c9dc
[<8107ef00>] (led_trigger_event) from [<81080300>] (ledtrig_cpu+0xb0/0x100 drivers/leds/trigger/ledtrig-cpu.c:86)
 r7:dddd1798 r6:00000002 r5:8290cee4 r4:000001fd
[<81080250>] (ledtrig_cpu) from [<80208efc>] (arch_cpu_idle_exit+0x14/0x18 arch/arm/kernel/process.c:98)
 r9:827e1666 r8:00000000 r7:8260c4e0 r6:8261ae40 r5:8260c498 r4:00000000
[<80208ee8>] (arch_cpu_idle_exit) from [<80293570>] (do_idle+0x7c/0x2f0 kernel/sched/idle.c:284)
[<802934f4>] (do_idle) from [<80293b00>] (cpu_startup_entry+0x20/0x24 kernel/sched/idle.c:379)
 r10:82850000 r9:8260c440 r8:8261a934 r7:00000000 r6:8260c440 r5:82625c7c
 r4:000000ea
[<80293ae0>] (cpu_startup_entry) from [<817f7c74>] (rest_init+0xdc/0xe0 init/main.c:735)
[<817f7b98>] (rest_init) from [<82400bb8>] (arch_post_acpi_subsys_init+0x0/0x20 init/main.c:834)
[<82400ba8>] (arch_call_rest_init) from [<824012f8>] (start_kernel+0x6e0/0x70c init/main.c:1088)
[<82400c18>] (start_kernel) from [<00000000>] (0x0)
Code: e92ddff0 e24cb004 e24dd01c ee1d7f70 (e5923040) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e92ddff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
   4:	e24cb004 	sub	fp, ip, #4
   8:	e24dd01c 	sub	sp, sp, #28
   c:	ee1d7f70 	mrc	15, 0, r7, cr13, cr0, {3}
* 10:	e5923040 	ldr	r3, [r2, #64]	; 0x40 <-- trapping instruction


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
