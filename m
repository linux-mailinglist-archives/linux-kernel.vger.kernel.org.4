Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778B68AE2C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBEDxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Feb 2023 22:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBEDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 22:53:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E376D24125
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 19:53:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id j7-20020a056e02014700b00310d217f518so5810814ilr.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 19:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/OoocmntBUGVFncftmvWretzEm54zAWlq8mtSGo5rE=;
        b=H2/D3J3BvvpG2cRCM4ZyRfN8RD3KmMJBDTI0umsa+YpWTTeus/vnurSr3wfi7N8Dnt
         AGb35b8ktO5Dskuv3tyU2Yu6kY9Xy4KxOQs7d65jr/XElD83Vzt5s51NxfweAeNkA5hn
         BMXLyl2r+/czahjF3TDZSCD8PSWXgw0XYd4F/VSDR4GcvQ+5omHnVfi17fYmiAyjFUdx
         gp2WqSCy5F2Lo4fbVuieqc8AuQDMDMsmmaeAXw3tcun6tkYT7V50HHNywjjJOAb6ozxr
         ARnEHKPoPJtfCaCm0NPxYd3gMVmJZCitlrjKGfb3uM80eW7iIuH0J8ZQbMbShfonh+NM
         AdRg==
X-Gm-Message-State: AO0yUKXglghZsD0L8TmO3rrfGR2FTkUPXSCojiWBfOL9S7SCdIvoBEIU
        /OC6Pw+DLXCuNVjNYqFRj/j0/1Q+smDNI5OnPdA6gdGszGUC
X-Google-Smtp-Source: AK7set84I9ZbEmlaXSbzsFbJXfy6Cv7fhVgQJKyPwNyw0O56to0oZyVlQKjoJj5nlJqRPV1ePOTColQMGWGVZ1W47YsEH6oVEtsf
MIME-Version: 1.0
X-Received: by 2002:a02:3b63:0:b0:3a5:deb3:52a5 with SMTP id
 i35-20020a023b63000000b003a5deb352a5mr3830313jaf.49.1675569197130; Sat, 04
 Feb 2023 19:53:17 -0800 (PST)
Date:   Sat, 04 Feb 2023 19:53:17 -0800
In-Reply-To: <20230205024238.1163-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caaaa405f3ebda0f@google.com>
Subject: Re: [syzbot] WARNING in kernfs_get (4)
From:   syzbot <syzbot+9be7b6c4b696be5d83ef@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

, MinObjects=0, CPUs=2, Nodes=2
[    1.717501][    T0] allocated 134217728 bytes of page_ext
[    1.718540][    T0] Node 0, zone      DMA: page owner found early allocated 0 pages
[    1.734855][    T0] Node 0, zone    DMA32: page owner found early allocated 16480 pages
[    1.749210][    T0] Node 0, zone   Normal: page owner found early allocated 0 pages
[    1.761271][    T0] Node 1, zone   Normal: page owner found early allocated 16387 pages
[    1.765251][    T0] Dynamic Preempt: full
[    1.768283][    T0] Running RCU self tests
[    1.769110][    T0] Running RCU synchronous self tests
[    1.770405][    T0] rcu: Preemptible hierarchical RCU implementation.
[    1.771628][    T0] rcu: 	RCU lockdep checking is enabled.
[    1.772927][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    1.774914][    T0] rcu: 	RCU callback double-/use-after-free debug is enabled.
[    1.778891][    T0] rcu: 	RCU debug extended QS entry/exit.
[    1.780014][    T0] 	All grace periods are expedited (rcu_expedited).
[    1.781966][    T0] 	Trampoline variant of Tasks RCU enabled.
[    1.783245][    T0] 	Tracing variant of Tasks RCU enabled.
[    1.784739][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    1.786570][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    1.787814][    T0] Running RCU synchronous self tests
[    1.838925][    T0] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    1.841535][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.843893][    T0] kfence: initialized - using 2097152 bytes for 255 objects at 0xffff88823bc00000-0xffff88823be00000
[    1.848775][    T0] Console: colour VGA+ 80x25
[    1.850276][    T0] printk: console [ttyS0] enabled
[    1.850276][    T0] printk: console [ttyS0] enabled
[    1.853413][    T0] printk: bootconsole [earlyser0] disabled
[    1.853413][    T0] printk: bootconsole [earlyser0] disabled
[    1.855838][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.858426][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.859376][    T0] ... MAX_LOCK_DEPTH:          48
[    1.860552][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    1.861693][    T0] ... CLASSHASH_SIZE:          4096
[    1.863082][    T0] ... MAX_LOCKDEP_ENTRIES:     131072
[    1.864096][    T0] ... MAX_LOCKDEP_CHAINS:      262144
[    1.864989][    T0] ... CHAINHASH_SIZE:          131072
[    1.866080][    T0]  memory used by lock dependency info: 20657 kB
[    1.871691][    T0]  memory used for stack traces: 8320 kB
[    1.873559][    T0]  per task-struct memory footprint: 1920 bytes
[    1.875136][    T0] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.877636][    T0] ACPI: Core revision 20221020
[    1.879981][    T0] APIC: Switch to symmetric I/O mode setup
[    1.881638][    T0] x2apic enabled
[    1.885803][    T0] Switched APIC routing to physical x2apic.
[    1.893298][    T0] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
[    1.895225][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fb722e6169, max_idle_ns: 440795315647 ns
[    1.897819][    T0] Calibrating delay loop (skipped) preset value.. 4400.50 BogoMIPS (lpj=22002540)
[    1.907869][    T0] pid_max: default: 32768 minimum: 301
[    1.909069][    T0] LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,integrity,tomoyo,apparmor,bpf
[    1.911604][    T0] landlock: Up and running.
[    1.912502][    T0] Yama: becoming mindful.
[    1.913463][    T0] TOMOYO Linux initialized
[    1.914930][    T0] AppArmor: AppArmor initialized
[    1.915865][    T0] LSM support for eBPF active
[    1.922407][    T0] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc hugepage)
[    1.928135][    T0] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hugepage)
[    1.932994][    T0] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    1.935952][    T0] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    1.941258][    T0] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    1.943936][    T0] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.945781][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.947867][    T0] Spectre V2 : Mitigation: IBRS
[    1.949618][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.952093][    T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    1.953984][    T0] RETBleed: Mitigation: IBRS
[    1.957848][    T0] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.960347][    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    1.962099][    T0] MDS: Mitigation: Clear CPU buffers
[    1.964603][    T0] TAA: Mitigation: Clear CPU buffers
[    1.965867][    T0] MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.981330][    T0] Freeing SMP alternatives memory: 116K
[    1.984341][    T0] Running RCU synchronous self tests
[    1.987821][    T0] Running RCU synchronous self tests
[    2.111432][    T1] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.20GHz (family: 0x6, model: 0x4f, stepping: 0x0)
[    2.117493][    T1] cblist_init_generic: Setting adjustable number of callback queues.
[    2.117793][    T1] cblist_init_generic: Setting shift to 1 and lim to 1.
[    2.118358][    T1] cblist_init_generic: Setting shift to 1 and lim to 1.
[    2.120842][    T1] Running RCU-tasks wait API self tests
[    2.238098][    T1] Performance Events: unsupported p6 CPU model 79 no PMU driver, software events only.
[    2.248777][    T1] rcu: Hierarchical SRCU implementation.
[    2.250923][    T1] rcu: 	Max phase no-delay instances is 1000.
[    2.258590][   T14] Callback from call_rcu_tasks_trace() invoked.
[    2.261457][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    2.263689][    T1] smp: Bringing up secondary CPUs ...
[    2.267943][    T1] x86: Booting SMP configuration:
[    2.269141][    T1] .... node  #0, CPUs:      #1
[    2.271428][    T1] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    2.271428][    T1] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[    2.277943][    T1] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    2.280865][    T1] smp: Brought up 2 nodes, 2 CPUs
[    2.281814][    T1] smpboot: Max logical packages: 1
[    2.283214][    T1] smpboot: Total of 2 processors activated (8801.01 BogoMIPS)
[    2.289093][    T1] devtmpfs: initialized
[    2.290610][    T1] sysfs: cannot create duplicate filename '//platform'
[    2.290610][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc6-next-20230131-syzkaller-09515-g80bd9028feca-dirty #0
[    2.292379][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
[    2.293844][    T1] Call Trace:
[    2.294334][    T1]  <TASK>
[    2.294828][    T1]  dump_stack_lvl+0x136/0x150
[    2.295942][    T1]  sysfs_warn_dup+0x80/0xa0
[    2.297243][    T1]  sysfs_create_dir_ns+0x237/0x290
[    2.297793][    T1]  ? sysfs_create_mount_point+0xb0/0xb0
[    2.297793][    T1]  ? spin_bug+0x1c0/0x1c0
[    2.297793][    T1]  ? kobject_add_internal+0x12d/0x9e0
[    2.297793][    T1]  ? do_raw_spin_unlock+0x175/0x230
[    2.297793][    T1]  kobject_add_internal+0x2c7/0x9e0
[    2.297793][    T1]  kset_register+0x169/0x260
[    2.297793][    T1]  bus_register+0x230/0xc20
[    2.297793][    T1]  platform_bus_init+0x3e/0xa0
[    2.297793][    T1]  driver_init+0x38/0x60
[    2.297793][    T1]  kernel_init_freeable+0x42b/0x900
[    2.297793][    T1]  ? rest_init+0x2b0/0x2b0
[    2.297793][    T1]  kernel_init+0x1e/0x2c0
[    2.297793][    T1]  ? rest_init+0x2b0/0x2b0
[    2.297793][    T1]  ret_from_fork+0x1f/0x30
[    2.297793][    T1]  </TASK>
[    2.307843][    T1] kobject_add_internal failed for platform with -EEXIST, don't try to register things with the same name in the same directory.
[    2.310575][    T1] ------------[ cut here ]------------
[    2.311327][    T1] Device 'platform' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    2.313636][    T1] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:2291 device_release+0x1b5/0x240
[    2.317815][    T1] Modules linked in:
[    2.318583][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc6-next-20230131-syzkaller-09515-g80bd9028feca-dirty #0
[    2.320242][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
[    2.321651][    T1] RIP: 0010:device_release+0x1b5/0x240
[    2.322452][    T1] Code: c1 ea 03 80 3c 02 00 0f 85 96 00 00 00 4c 8b 6d 50 4d 85 ed 74 1b e8 0a 3e 6a fc 4c 89 ee 48 c7 c7 a0 94 cd 8a e8 0b d9 31 fc <0f> 0b e9 e7 fe ff ff e8 ef 3d 6a fc 48 89 ea 48 b8 00 00 00 00 00
[    2.327815][    T1] RSP: 0000:ffffc90000067e58 EFLAGS: 00010282
[    2.329139][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    2.330511][    T1] RDX: ffff8881400a8000 RSI: ffffffff81692aec RDI: 0000000000000005
[    2.331965][    T1] RBP: ffffffff8d40ccc0 R08: 0000000000000005 R09: 0000000000000000
[    2.333427][    T1] R10: 0000000080000000 R11: 0000000000000000 R12: ffff888144a28000
[    2.334702][    T1] R13: ffffffff8acde860 R14: ffffffff8acde860 R15: 0000000000000000
[    2.336135][    T1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[    2.337810][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.339203][    T1] CR2: 0000000000000000 CR3: 000000000c571000 CR4: 00000000003506e0
[    2.340338][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.341852][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.343006][    T1] Call Trace:
[    2.343585][    T1]  <TASK>
[    2.348082][    T1]  kobject_put+0x1c2/0x4d0
[    2.348082][    T1]  device_unregister+0x30/0xc0
[    2.348082][    T1]  platform_bus_init+0x6b/0xa0
[    2.348082][    T1]  driver_init+0x38/0x60
[    2.349919][    T1]  kernel_init_freeable+0x42b/0x900
[    2.351030][    T1]  ? rest_init+0x2b0/0x2b0
[    2.351733][    T1]  kernel_init+0x1e/0x2c0
[    2.353339][    T1]  ? rest_init+0x2b0/0x2b0
[    2.354220][    T1]  ret_from_fork+0x1f/0x30
[    2.355137][    T1]  </TASK>
[    2.359190][    T1] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    2.359190][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc6-next-20230131-syzkaller-09515-g80bd9028feca-dirty #0
[    2.359190][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
[    2.359190][    T1] Call Trace:
[    2.359190][    T1]  <TASK>
[    2.359190][    T1]  dump_stack_lvl+0xd9/0x150
[    2.367824][    T1]  panic+0x61b/0x6c0
[    2.367824][    T1]  ? panic_smp_self_stop+0x90/0x90
[    2.367824][    T1]  ? show_trace_log_lvl+0x285/0x390
[    2.367824][    T1]  ? device_release+0x1b5/0x240
[    2.367824][    T1]  check_panic_on_warn+0xb1/0xc0
[    2.367824][    T1]  __warn+0xf2/0x4f0
[    2.367824][    T1]  ? device_release+0x1b5/0x240
[    2.367824][    T1]  report_bug+0x206/0x2b0
[    2.377836][    T1]  handle_bug+0x3c/0x70
[    2.377836][    T1]  exc_invalid_op+0x18/0x50
[    2.377836][    T1]  asm_exc_invalid_op+0x1a/0x20
[    2.377836][    T1] RIP: 0010:device_release+0x1b5/0x240
[    2.377836][    T1] Code: c1 ea 03 80 3c 02 00 0f 85 96 00 00 00 4c 8b 6d 50 4d 85 ed 74 1b e8 0a 3e 6a fc 4c 89 ee 48 c7 c7 a0 94 cd 8a e8 0b d9 31 fc <0f> 0b e9 e7 fe ff ff e8 ef 3d 6a fc 48 89 ea 48 b8 00 00 00 00 00
[    2.377836][    T1] RSP: 0000:ffffc90000067e58 EFLAGS: 00010282
[    2.377836][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    2.387900][    T1] RDX: ffff8881400a8000 RSI: ffffffff81692aec RDI: 0000000000000005
[    2.387900][    T1] RBP: ffffffff8d40ccc0 R08: 0000000000000005 R09: 0000000000000000
[    2.387900][    T1] R10: 0000000080000000 R11: 0000000000000000 R12: ffff888144a28000
[    2.387900][    T1] R13: ffffffff8acde860 R14: ffffffff8acde860 R15: 0000000000000000
[    2.387900][    T1]  ? vprintk+0x8c/0xa0
[    2.387900][    T1]  ? device_release+0x1b5/0x240
[    2.397826][    T1]  kobject_put+0x1c2/0x4d0
[    2.397826][    T1]  device_unregister+0x30/0xc0
[    2.397826][    T1]  platform_bus_init+0x6b/0xa0
[    2.397826][    T1]  driver_init+0x38/0x60
[    2.397826][    T1]  kernel_init_freeable+0x42b/0x900
[    2.397826][    T1]  ? rest_init+0x2b0/0x2b0
[    2.397826][    T1]  kernel_init+0x1e/0x2c0
[    2.397826][    T1]  ? rest_init+0x2b0/0x2b0
[    2.397826][    T1]  ret_from_fork+0x1f/0x30
[    2.407859][    T1]  </TASK>
[    2.407859][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build4151365248=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 9dfcf09cf
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9dfcf09cf38eb123a007af28c5ee2562718893a0 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230123-142548'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9dfcf09cf38eb123a007af28c5ee2562718893a0 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230123-142548'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9dfcf09cf38eb123a007af28c5ee2562718893a0 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230123-142548'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"9dfcf09cf38eb123a007af28c5ee2562718893a0\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=15b247a5480000


Tested on:

commit:         80bd9028 Add linux-next specific files for 20230131
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=904dc2f450eaad4a
dashboard link: https://syzkaller.appspot.com/bug?extid=9be7b6c4b696be5d83ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153e4c5d480000

