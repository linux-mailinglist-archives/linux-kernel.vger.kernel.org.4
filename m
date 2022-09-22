Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696065E6B35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiIVSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiIVSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB70D58AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663872327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wxD8cBawNSTV3oDQ0Dx2xTfxPkwF0YEpyPKD9D/ZEfU=;
        b=FiY8o0bInhQkaZusgNJVIGltpzOQiIXRqhO6hMPOCb4nxHqxg3wsxGspXo2kUESUnSA2A3
        noyQziY7z19db7z5m90TFgRT8ghRoY1CJxrJt38JgYM7ntpdtJet5BZ1PNqb+V1P0fPSKy
        HpAxyLnWX43C6w9qRkcUJflfkWh6ht4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-8iPNmooEM8m0NH2frMTZ3w-1; Thu, 22 Sep 2022 14:45:23 -0400
X-MC-Unique: 8iPNmooEM8m0NH2frMTZ3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CC1381172B;
        Thu, 22 Sep 2022 18:45:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3513540C213F;
        Thu, 22 Sep 2022 18:45:21 +0000 (UTC)
Date:   Thu, 22 Sep 2022 14:45:19 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 00000010 - PC is at mempool_alloc
Message-ID: <YyytP71y2GosUOhr@fedora>
References: <CA+G9fYtt-921LH=fcVtaOkzfb-sA-0Qht4hrNhmGS5f_S0P+cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vKSqeyF9fWs7S3SE"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtt-921LH=fcVtaOkzfb-sA-0Qht4hrNhmGS5f_S0P+cg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vKSqeyF9fWs7S3SE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 08:11:42PM +0530, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported]
> Following kernel crash noticed on qemu-arm with linked config [1] running=
 the
> Linux next-20220916 to next-20220921.

Does this mean the test passed with next-20220916 and failed with
next-20220921?

Stefan

>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.0.0-rc5-next-20220916 (tuxmake@tuxmake)
> (Debian clang version
> 12.0.1-++20211027092659+fed41342a82f-1~exp1~20211027213207.7, Debian
> LLD 12.0.1) #1 SMP @1663313294
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=3D1=
0c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] OF: fdt: Ignoring memory range 0x100000000 - 0x140000000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0xfb800000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000ffffefff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000ffffefff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000fff=
fefff]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] psci: SMC Calling Convention v1.1
> [    0.000000] percpu: Embedded 16 pages/cpu s35220 r8192 d22124 u65536
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 784=
703
> [    0.000000] Kernel command line: console=3DttyAMA0 root=3D/dev/vda rw
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes, linear)
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:=
off
> [    0.000000] Memory: 3013400K/3145724K available (19456K kernel
> code, 2696K rwdata, 8904K rodata, 2048K init, 660K bss, 66788K
> reserved, 65536K cma-reserved, 2293756K highmem)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2,=
 Nodes=3D1
> [    0.000000] ftrace: allocating 57956 entries in 170 pages
> [    0.000000] ftrace: allocated 170 pages with 4 groups
> [    0.000000] trace event string verifier disabled
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: RCU event tracing is enabled.
> [    0.000000] rcu: RCU restricting CPUs from NR_CPUS=3D16 to nr_cpu_ids=
=3D2.
> [    0.000000] Rude variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 10 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D2
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] kfence: initialized - using 2097152 bytes for 255
> objects at 0x(ptrval)-0x(ptrval)
> [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff
> max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
> [    0.000001] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps
> every 4398046511100ns
> [    0.000012] Switching to timer-based delay loop, resolution 10ns
> [    0.000281] Console: colour dummy device 80x30
> [    0.000326] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 200.00 BogoMIPS (lpj=3D1000000)
> [    0.000341] pid_max: default: 32768 minimum: 301
> [    0.000516] Mount-cache hash table entries: 2048 (order: 1, 8192
> bytes, linear)
> [    0.000529] Mountpoint-cache hash table entries: 2048 (order: 1,
> 8192 bytes, linear)
> [    0.001185] CPU: Testing write buffer coherency: ok
> [    0.001466] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.002017] cblist_init_generic: Setting adjustable number of
> callback queues.
> [    0.002025] cblist_init_generic: Setting shift to 1 and lim to 1.
> [    0.002203] Setting up static identity map for 0x40300000 - 0x403000ac
> [    0.002600] rcu: Hierarchical SRCU implementation.
> [    0.002605] rcu: Max phase no-delay instances is 1000.
> [    0.003708] EFI services will not be available.
> [    0.004942] smp: Bringing up secondary CPUs ...
> [    0.021912] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.022242] smp: Brought up 1 node, 2 CPUs
> [    0.022255] SMP: Total of 2 processors activated (400.00 BogoMIPS).
> [    0.022264] CPU: All CPU(s) started in SVC mode.
> [    0.023253] devtmpfs: initialized
> [    0.025244] VFP support v0.3: implementor 41 architecture 3 part 40
> variant 3 rev 4
> [    0.025416] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.025433] futex hash table entries: 512 (order: 3, 32768 bytes, line=
ar)
> [    0.027364] pinctrl core: initialized pinctrl subsystem
> [    0.028822] DMI not present or invalid.
> [    0.030211] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.033026] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
> [    0.034546] thermal_sys: Registered thermal governor 'step_wise'
> [    0.034605] cpuidle: using governor menu
> [    0.034784] No ATAGs?
> [    0.034998] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.035010] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.036480] Serial: AMBA PL011 UART driver
> [    0.050536] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq =3D 28,
> base_baud =3D 0) is a PL011 rev1
> [    0.241806] printk: console [ttyAMA0] enabled
> [    0.254486] kprobes: kprobe jump-optimization is enabled. All
> kprobes are optimized if possible.
> [    0.285362] cryptd: max_cpu_qlen set to 1000
> [    0.292445] iommu: Default domain type: Translated
> [    0.294394] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.297358] SCSI subsystem initialized
> [    0.299291] usbcore: registered new interface driver usbfs
> [    0.301419] usbcore: registered new interface driver hub
> [    0.303416] usbcore: registered new device driver usb
> [    0.306685] mc: Linux media interface: v0.10
> [    0.308347] videodev: Linux video capture interface: v2.00
> [    0.310494] pps_core: LinuxPPS API ver. 1 registered
> [    0.312330] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.315763] PTP clock support registered
> [    0.317430] EDAC MC: Ver: 3.0.0
> [    0.320772] vgaarb: loaded
> [    1.213291] clocksource: Switched to clocksource arch_sys_counter
> [    1.261617] NET: Registered PF_INET protocol family
> [    1.264066] IP idents hash table entries: 16384 (order: 5, 131072
> bytes, linear)
> [    1.268674] tcp_listen_portaddr_hash hash table entries: 512
> (order: 0, 4096 bytes, linear)
> [    1.271836] Table-perturb hash table entries: 65536 (order: 6,
> 262144 bytes, linear)
> [    1.275141] TCP established hash table entries: 8192 (order: 3,
> 32768 bytes, linear)
> [    1.278123] TCP bind hash table entries: 8192 (order: 5, 131072
> bytes, linear)
> [    1.281053] TCP: Hash tables configured (established 8192 bind 8192)
> [    1.283654] MPTCP token hash table entries: 1024 (order: 2, 16384
> bytes, linear)
> [    1.286534] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    1.289060] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, l=
inear)
> [    1.291806] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    1.294943] RPC: Registered named UNIX socket transport module.
> [    1.297236] RPC: Registered udp transport module.
> [    1.298990] RPC: Registered tcp transport module.
> [    1.300771] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    1.303323] PCI: CLS 0 bytes, default 64
> [    1.306070] Initialise system trusted keyrings
> [    1.308224] workingset: timestamp_bits=3D14 max_order=3D20 bucket_orde=
r=3D6
> [    1.317882] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    1.321095] NFS: Registering the id_resolver key type
> [    1.323110] Key type id_resolver registered
> [    1.324721] Key type id_legacy registered
> [    1.326309] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
=2E.
> [    1.328829] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
> Registering...
> [    1.331640] ntfs: driver 2.1.32 [Flags: R/O].
> [    1.384889] NET: Registered PF_ALG protocol family
> [    1.386763] Key type asymmetric registered
> [    1.388330] Asymmetric key parser 'x509' registered
> [    1.390316] bounce: pool size: 64 pages
> [    1.391962] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 246)
> [    1.395268] io scheduler mq-deadline registered
> [    1.397074] io scheduler kyber registered
> [    1.411860] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
> [    1.417304] pci-host-generic 3f000000.pcie: host bridge
> /pcie@10000000 ranges:
> [    1.420204] pci-host-generic 3f000000.pcie:       IO
> 0x003eff0000..0x003effffff -> 0x0000000000
> [    1.423723] pci-host-generic 3f000000.pcie:      MEM
> 0x0010000000..0x003efeffff -> 0x0010000000
> [    1.427091] pci-host-generic 3f000000.pcie:      MEM
> 0x8000000000..0xffffffffff -> 0x8000000000
> [    1.430480] pci-host-generic 3f000000.pcie: ECAM at [mem
> 0x3f000000-0x3fffffff] for [bus 00-0f]
> [    1.434265] pci-host-generic 3f000000.pcie: PCI host bridge to bus 000=
0:00
> [    1.436963] pci_bus 0000:00: root bus resource [bus 00-0f]
> [    1.439089] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    1.441495] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efef=
fff]
> [    1.444517] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [    1.447761] pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
> [    1.450308] pci 0000:00:01.0: reg 0x10: [io  0x0000-0x001f]
> [    1.452565] pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.455697] pci 0000:00:01.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.458578] pci 0000:00:01.0: reg 0x30: [mem 0x00000000-0x0003ffff pre=
f]
> [    1.462239] pci 0000:00:02.0: [1af4:1001] type 00 class 0x010000
> [    1.465147] pci 0000:00:02.0: reg 0x10: [io  0x0000-0x003f]
> [    1.467385] pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.470065] pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.474061] pci 0000:00:03.0: [1af4:1001] type 00 class 0x010000
> [    1.476614] pci 0000:00:03.0: reg 0x10: [io  0x0000-0x003f]
> [    1.478850] pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.481531] pci 0000:00:03.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.486616] PCI: bus0: Fast back to back transfers disabled
> [    1.488855] pci 0000:00:01.0: BAR 6: assigned [mem
> 0x10000000-0x1003ffff pref]
> [    1.491658] pci 0000:00:01.0: BAR 4: assigned [mem
> 0x10040000-0x10043fff 64bit pref]
> [    1.495166] pci 0000:00:02.0: BAR 4: assigned [mem
> 0x10044000-0x10047fff 64bit pref]
> [    1.498281] pci 0000:00:03.0: BAR 4: assigned [mem
> 0x10048000-0x1004bfff 64bit pref]
> [    1.501388] pci 0000:00:01.0: BAR 1: assigned [mem 0x1004c000-0x1004cf=
ff]
> [    1.504323] pci 0000:00:02.0: BAR 1: assigned [mem 0x1004d000-0x1004df=
ff]
> [    1.506995] pci 0000:00:03.0: BAR 1: assigned [mem 0x1004e000-0x1004ef=
ff]
> [    1.509687] pci 0000:00:02.0: BAR 0: assigned [io  0x1000-0x103f]
> [    1.512101] pci 0000:00:03.0: BAR 0: assigned [io  0x1040-0x107f]
> [    1.514841] pci 0000:00:01.0: BAR 0: assigned [io  0x1080-0x109f]
> [    1.530801] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
> [    1.538805] virtio-pci 0000:00:02.0: enabling device (0100 -> 0103)
> [    1.546875] virtio-pci 0000:00:03.0: enabling device (0100 -> 0103)
> [    1.600549] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
> [    1.606511] SuperH (H)SCI(F) driver initialized
> [    1.609112] msm_serial: driver initialized
> [    1.610698] STMicroelectronics ASC driver initialized
> [    1.613420] STM32 USART driver initialized
> [    1.629133] brd: module loaded
> [    1.635033] loop: module loaded
> [    1.636719] virtio_blk virtio1: 1/0/0 default/read/poll queues
> [    1.640200] virtio_blk virtio1: [vda] 4213030 512-byte logical
> blocks (2.16 GB/2.01 GiB)
> [    1.645704] 8<--- cut here ---
> [    1.647023] Unable to handle kernel NULL pointer dereference at
> virtual address 00000010
> [    1.650186] [00000010] *pgd=3D00000000
> [    1.651610] Internal error: Oops: 5 [#1] SMP ARM
> [    1.653525] Modules linked in:
> [    1.654993] CPU: 1 PID: 40 Comm: kworker/1:1H Not tainted
> 6.0.0-rc5-next-20220916 #1
> [    1.658613] Hardware name: Generic DT based system
> [    1.660868] Workqueue: kblockd blk_mq_run_work_fn
> [    1.663088] PC is at mempool_alloc+0x30/0x1e0
> [    1.665159] LR is at __sg_alloc_table+0x90/0x15c
> [    1.667340] pc : [<c04d667c>]    lr : [<c148c308>]    psr: 80000013
> [    1.670279] sp : c2c6fcd0  ip : c38000f0  fp : c2c6fd18
> [    1.672746] r10: c38000c8  r9 : c2209f08  r8 : 00092820
> [    1.675195] r7 : c38000c8  r6 : 00000820  r5 : 00000003  r4 : 00000000
> [    1.678250] r3 : ffffffff  r2 : c24607a4  r1 : 00000820  r0 : 52e3108c
> [    1.681310] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [    1.684649] Control: 10c5383d  Table: 4020406a  DAC: 00000051
> [    1.687338] Register r0 information: non-paged memory
> [    1.689729] Register r1 information: non-paged memory
> [    1.692116] Register r2 information: non-slab/vmalloc memory
> [    1.694769] Register r3 information: non-paged memory
> [    1.697154] Register r4 information: NULL pointer
> [    1.699365] Register r5 information: non-paged memory
> [    1.701746] Register r6 information: non-paged memory
> [    1.704130] Register r7 information: non-slab/vmalloc memory
> [    1.706782] Register r8 information: non-paged memory
> [    1.709160] Register r9 information: non-slab/vmalloc memory
> [    1.711819] Register r10 information: non-slab/vmalloc memory
> [    1.714510] Register r11 information: non-slab/vmalloc memory
> [    1.717212] Register r12 information: non-slab/vmalloc memory
> [    1.719913] Process kworker/1:1H (pid: 40, stack limit =3D 0x(ptrval))
> [    1.722877] Stack: (0xc2c6fcd0 to 0xc2c70000)
> [    1.724946] fcc0:                                     00000000
> c21c1dd0 c2469ee0 ee4e1680
> [    1.728765] fce0: c2ed5370 c21bc680 c2c6fd10 c0477a88 40000013
> ee4e1680 52e3108c c38000bc
> [    1.732581] fd00: 00000003 00000003 c38000c8 00000080 00000002
> c38000c8 00000003 c148c308
> [    1.736407] fd20: 00000080 c38000bc 00000002 c38000bc 00000000
> c2209f08 c38000a8 c3800000
> [    1.740232] fd40: c2c6fd98 c1537758 00000002 00000820 c15377ac
> c083fc14 00000000 c0c50d94
> [    1.744075] fd60: c38000bc c0c5102c 00000020 00000000 c2ee1000
> 00000000 52e3108c 00000000
> [    1.747908] fd80: c2ee1000 c38000a8 c3800038 c2209f08 c2c33cc0
> c3800000 c2c6fe20 c0c50330
> [    1.751741] fda0: 00000400 000002d9 00000559 c2c6fe50 00000001
> 00000000 00000001 00000001
> [    1.755553] fdc0: 00000000 00000000 00000000 0001ede9 000003e9
> 000002e5 0000072a 00000000
> [    1.759314] fde0: 00000000 00000000 00000001 00000000 00000000
> 00000000 00000000 000163a4
> [    1.763015] fe00: 52e3108c 00000001 c2ee1000 c2c6fea0 c3800038
> c2ee1000 c3800000 c2ee1000
> [    1.766710] fe20: c2c6fe80 c0840f0c 00000000 c2ee06c0 c2ee1000
> 00000000 00000000 00000000
> [    1.770414] fe40: 00000001 00000000 c2c6fea0 c2ed52d8 c3800000
> 00000001 c2c6fe58 c2c6fe58
> [    1.774114] fe60: 52e3108c 00000000 c2c6fea0 00000001 c2ed52d8
> c2ee1004 00000000 00000000
> [    1.777768] fe80: c2c6fed0 c084a3a0 00000000 ffff8bd5 c2ee1004
> 00000100 c2ee1800 c2ee1000
> [    1.781451] fea0: c2c6fea0 c2c6fea0 00000000 00000000 52e3108c
> c2ee1004 c2c6fed8 c2ee1800
> [    1.785148] fec0: c2ee1000 c2209f08 ee4e8ad0 c2ab1500 c2c6ff00
> c0849684 c2c6fed8 c2c6fed8
> [    1.788849] fee0: c2209f08 52e3108c c2ee1000 00000000 c2ee1040
> 00000000 c2209f54 c2ab1500
> [    1.792527] ff00: c2c6ff10 c0849550 c2ee1000 c2ab1500 c2c6ff20
> c0845ae4 c2c2f580 00000003
> [    1.796197] ff20: c2c6ff50 c037dd4c c2c2f598 ee4ede05 ee4ede00
> c2c2f580 ee4e8ad0 c2203d40
> [    1.799869] ff40: ee4e8ad0 c2c2f598 ee4e8aec c2ab1500 c2c6ff80
> c037e2a4 c2c6ff80 c0477a88
> [    1.803554] ff60: 60000013 c2c32840 00000040 c2ab1cbc c2c32854
> c037df98 c2c2f580 c2ab1500
> [    1.807251] ff80: c2c6ffa8 c0384d94 c2ab1500 c2c327c0 c0384c6c
> 00000000 00000000 00000000
> [    1.810915] ffa0: 00000000 00000000 00000000 c0300168 00000000
> 00000000 00000000 00000000
> [    1.814582] ffc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    1.818241] ffe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [    1.821934]  mempool_alloc from __sg_alloc_table+0x90/0x15c
> [    1.824493]  __sg_alloc_table from sg_alloc_table_chained+0x78/0xcc
> [    1.827329]  sg_alloc_table_chained from virtblk_prep_rq+0x2fc/0x37c
> [    1.830211]  virtblk_prep_rq from virtio_queue_rq+0x58/0x318
> [    1.832773]  virtio_queue_rq from blk_mq_dispatch_rq_list+0x430/0xbd4
> [    1.835708]  blk_mq_dispatch_rq_list from
> blk_mq_do_dispatch_sched+0x2d4/0x39c
> [    1.838951]  blk_mq_do_dispatch_sched from
> __blk_mq_sched_dispatch_requests+0x108/0x16c
> [    1.842578]  __blk_mq_sched_dispatch_requests from
> blk_mq_sched_dispatch_requests+0x40/0x6c
> [    1.846353]  blk_mq_sched_dispatch_requests from
> __blk_mq_run_hw_queue+0x68/0xfc
> [    1.849697]  __blk_mq_run_hw_queue from process_one_work+0x294/0x4e0
> [    1.852584]  process_one_work from worker_thread+0x30c/0x630
> [    1.855151]  worker_thread from kthread+0x128/0x148
> [    1.857427]  kthread from ret_from_fork+0x14/0x2c
> [    1.859588] Exception stack(0xc2c6ffb0 to 0xc2c6fff8)
> [    1.861890] ffa0:                                     00000000
> 00000000 00000000 00000000
> [    1.865602] ffc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    1.869307] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.872335] Code: e50b0020 e92d4000 e28dd004 e3868a92 (e5941010)
> [    1.875137] ---[ end trace 0000000000000000 ]---
>=20
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: d5538ab91d3a9a237805be6f8c6c272af2987995
>   git_describe: next-20220916
>   kernel_version: 6.0.0-rc5
>   kernel-config: https://builds.tuxbuild.com/2EqBXI3LBi8K6Yd2YCwEkexKg80/=
config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pip=
elines/641972186
>   artifact-location: https://builds.tuxbuild.com/2EqBXI3LBi8K6Yd2YCwEkexK=
g80
>   toolchain: clang-12
>   System.map: https://builds.tuxbuild.com/2EqBXI3LBi8K6Yd2YCwEkexKg80/Sys=
tem.map
>   vmlinux.xz: https://builds.tuxbuild.com/2EqBXI3LBi8K6Yd2YCwEkexKg80/vml=
inux.xz
>=20
> [1] kernel-config:
> https://builds.tuxbuild.com/2EqBXI3LBi8K6Yd2YCwEkexKg80/config
>=20
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220916/=
testrun/11958549/suite/log-parser-test/tests/
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220916/=
testrun/11958549/suite/log-parser-test/test/check-kernel-oops-5539296/log
> https://lkft.validation.linaro.org/scheduler/job/5539296#L436
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220921/=
testrun/11997449/suite/log-parser-test/tests/
>=20
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.0.0-rc6-next-20220921 (tuxmake@tuxmake)
> (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld
> (GNU Binutils for Debian) 2.35.2) #1 SMP @1663751833
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=3D1=
0c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] OF: fdt: Ignoring memory range 0x100000000 - 0x140000000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0xfb800000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000ffffefff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000ffffefff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000fff=
fefff]
> [    0.000000] kasan: Truncating shadow for memory block at
> 0x40000000-0xffffffff to lowmem region at 0x70000000
> [    0.000000] kasan: Mapping kernel virtual memory block:
> c0000000-f0000000 at shadow: b7000000-bd000000
> [    0.000000] kasan: Mapping kernel virtual memory block:
> bf000000-c0000000 at shadow: b6e00000-b7000000
> [    0.000000] kasan: Kernel address sanitizer initialized
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] psci: SMC Calling Convention v1.1
> [    0.000000] percpu: Embedded 12 pages/cpu s18580 r8192 d22380 u49152
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 784=
703
> [    0.000000] Kernel command line: console=3DttyAMA0 root=3D/dev/vda rw
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] stackdepot hash table entries: 1048576 (order: 10,
> 4194304 bytes, linear)
> [    0.000000] Memory: 2891616K/3145724K available (22528K kernel
> code, 9426K rwdata, 16888K rodata, 2048K init, 861K bss, 188572K
> reserved, 65536K cma-reserved, 2293756K highmem)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: RCU event tracing is enabled.
> [    0.000000] rcu: RCU restricting CPUs from NR_CPUS=3D16 to nr_cpu_ids=
=3D2.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 10 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D2
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] kfence: initialized - using 2097152 bytes for 255
> objects at 0x(ptrval)-0x(ptrval)
> [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff
> max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
> [    0.000001] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps
> every 4398046511100ns
> [    0.000052] Switching to timer-based delay loop, resolution 10ns
> [    0.000823] Console: colour dummy device 80x30
> [    0.000912] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 200.00 BogoMIPS (lpj=3D1000000)
> [    0.000939] pid_max: default: 32768 minimum: 301
> [    0.001879] Mount-cache hash table entries: 2048 (order: 1, 8192
> bytes, linear)
> [    0.001904] Mountpoint-cache hash table entries: 2048 (order: 1,
> 8192 bytes, linear)
> [    0.005846] CPU: Testing write buffer coherency: ok
> [    0.006854] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.010273] Setting up static identity map for 0x40300000 - 0x403000ac
> [    0.011749] rcu: Hierarchical SRCU implementation.
> [    0.011761] rcu: Max phase no-delay instances is 1000.
> [    0.015413] EFI services will not be available.
> [    0.027415] smp: Bringing up secondary CPUs ...
> [    0.070153] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.070671] smp: Brought up 1 node, 2 CPUs
> [    0.070697] SMP: Total of 2 processors activated (400.00 BogoMIPS).
> [    0.070712] CPU: All CPU(s) started in SVC mode.
> [    0.073943] devtmpfs: initialized
> [    0.127072] VFP support v0.3: implementor 41 architecture 3 part 40
> variant 3 rev 4
> [    0.128670] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.128720] futex hash table entries: 512 (order: 3, 32768 bytes, line=
ar)
> [    0.138714] pinctrl core: initialized pinctrl subsystem
> [    0.150833] DMI not present or invalid.
> [    0.153578] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.159334] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
> [    0.176516] thermal_sys: Registered thermal governor 'step_wise'
> [    0.176773] cpuidle: using governor menu
> [    0.178497] No ATAGs?
> [    0.178959] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.178991] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.191189] Serial: AMBA PL011 UART driver
> [    0.254467] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq =3D 28,
> base_baud =3D 0) is a PL011 rev1
> [    0.459906] printk: console [ttyAMA0] enabled
> [    0.600545] cryptd: max_cpu_qlen set to 1000
> [    0.631206] iommu: Default domain type: Translated
> [    0.633294] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.643144] SCSI subsystem initialized
> [    0.649485] usbcore: registered new interface driver usbfs
> [    0.652329] usbcore: registered new interface driver hub
> [    0.654772] usbcore: registered new device driver usb
> [    0.662776] mc: Linux media interface: v0.10
> [    0.665003] videodev: Linux video capture interface: v2.00
> [    0.668200] pps_core: LinuxPPS API ver. 1 registered
> [    0.670255] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.674076] PTP clock support registered
> [    0.676639] EDAC MC: Ver: 3.0.0
> [    0.695383] vgaarb: loaded
> [    0.698137] clocksource: Switched to clocksource arch_sys_counter
> [    0.776861] NET: Registered PF_INET protocol family
> [    0.779797] IP idents hash table entries: 16384 (order: 5, 131072
> bytes, linear)
> [    0.788503] tcp_listen_portaddr_hash hash table entries: 512
> (order: 0, 4096 bytes, linear)
> [    0.791870] Table-perturb hash table entries: 65536 (order: 6,
> 262144 bytes, linear)
> [    0.794939] TCP established hash table entries: 8192 (order: 3,
> 32768 bytes, linear)
> [    0.798522] TCP bind hash table entries: 8192 (order: 5, 131072
> bytes, linear)
> [    0.802273] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.805869] MPTCP token hash table entries: 1024 (order: 2, 16384
> bytes, linear)
> [    0.809394] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    0.812100] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, l=
inear)
> [    0.815694] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.821641] RPC: Registered named UNIX socket transport module.
> [    0.824042] RPC: Registered udp transport module.
> [    0.825859] RPC: Registered tcp transport module.
> [    0.827753] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.831099] PCI: CLS 0 bytes, default 64
> [    0.840103] Initialise system trusted keyrings
> [    0.842933] workingset: timestamp_bits=3D14 max_order=3D20 bucket_orde=
r=3D6
> [    0.968005] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.980584] NFS: Registering the id_resolver key type
> [    0.982768] Key type id_resolver registered
> [    0.984451] Key type id_legacy registered
> [    0.987061] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
=2E.
> [    0.990217] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
> Registering...
> [    0.993389] ntfs: driver 2.1.32 [Flags: R/O].
> [    1.082722] NET: Registered PF_ALG protocol family
> [    1.084787] Key type asymmetric registered
> [    1.086382] Asymmetric key parser 'x509' registered
> [    1.089899] bounce: pool size: 64 pages
> [    1.092836] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 246)
> [    1.095733] io scheduler mq-deadline registered
> [    1.097502] io scheduler kyber registered
> [    1.157644] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
> [    1.173047] pci-host-generic 3f000000.pcie: host bridge
> /pcie@10000000 ranges:
> [    1.176051] pci-host-generic 3f000000.pcie:       IO
> 0x003eff0000..0x003effffff -> 0x0000000000
> [    1.179896] pci-host-generic 3f000000.pcie:      MEM
> 0x0010000000..0x003efeffff -> 0x0010000000
> [    1.183267] pci-host-generic 3f000000.pcie:      MEM
> 0x8000000000..0xffffffffff -> 0x8000000000
> [    1.186801] pci-host-generic 3f000000.pcie: ECAM at [mem
> 0x3f000000-0x3fffffff] for [bus 00-0f]
> [    1.193358] pci-host-generic 3f000000.pcie: PCI host bridge to bus 000=
0:00
> [    1.196196] pci_bus 0000:00: root bus resource [bus 00-0f]
> [    1.198489] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    1.200934] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efef=
fff]
> [    1.203785] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [    1.209132] pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
> [    1.211719] pci 0000:00:01.0: reg 0x10: [io  0x0000-0x001f]
> [    1.213937] pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.216603] pci 0000:00:01.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.219850] pci 0000:00:01.0: reg 0x30: [mem 0x00000000-0x0003ffff pre=
f]
> [    1.225469] pci 0000:00:02.0: [1af4:1001] type 00 class 0x010000
> [    1.228305] pci 0000:00:02.0: reg 0x10: [io  0x0000-0x003f]
> [    1.230649] pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.233442] pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.239584] pci 0000:00:03.0: [1af4:1001] type 00 class 0x010000
> [    1.242249] pci 0000:00:03.0: reg 0x10: [io  0x0000-0x003f]
> [    1.244609] pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [    1.247378] pci 0000:00:03.0: reg 0x20: [mem 0x00000000-0x00003fff
> 64bit pref]
> [    1.256001] PCI: bus0: Fast back to back transfers disabled
> [    1.258636] pci 0000:00:01.0: BAR 6: assigned [mem
> 0x10000000-0x1003ffff pref]
> [    1.261468] pci 0000:00:01.0: BAR 4: assigned [mem
> 0x10040000-0x10043fff 64bit pref]
> [    1.264564] pci 0000:00:02.0: BAR 4: assigned [mem
> 0x10044000-0x10047fff 64bit pref]
> [    1.267637] pci 0000:00:03.0: BAR 4: assigned [mem
> 0x10048000-0x1004bfff 64bit pref]
> [    1.271347] pci 0000:00:01.0: BAR 1: assigned [mem 0x1004c000-0x1004cf=
ff]
> [    1.274020] pci 0000:00:02.0: BAR 1: assigned [mem 0x1004d000-0x1004df=
ff]
> [    1.276690] pci 0000:00:03.0: BAR 1: assigned [mem 0x1004e000-0x1004ef=
ff]
> [    1.279688] pci 0000:00:02.0: BAR 0: assigned [io  0x1000-0x103f]
> [    1.282069] pci 0000:00:03.0: BAR 0: assigned [io  0x1040-0x107f]
> [    1.284466] pci 0000:00:01.0: BAR 0: assigned [io  0x1080-0x109f]
> [    1.361883] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
> [    1.372338] virtio-pci 0000:00:02.0: enabling device (0100 -> 0103)
> [    1.383038] virtio-pci 0000:00:03.0: enabling device (0100 -> 0103)
> [    1.847568] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
> [    1.873743] SuperH (H)SCI(F) driver initialized
> [    1.879446] msm_serial: driver initialized
> [    1.881117] STMicroelectronics ASC driver initialized
> [    1.886739] STM32 USART driver initialized
> [    1.990589] brd: module loaded
> [    2.046758] loop: module loaded
> [    2.049302] virtio_blk virtio1: 1/0/0 default/read/poll queues
> [    2.057925] virtio_blk virtio1: [vda] 4213030 512-byte logical
> blocks (2.16 GB/2.01 GiB)
> [    2.074388] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    2.077405] BUG: KASAN: null-ptr-deref in mempool_alloc+0xb0/0x1f4
> [    2.080344] Read of size 4 at addr 00000014 by task kworker/1:0H/20
> [    2.083347]
> [    2.084139] CPU: 1 PID: 20 Comm: kworker/1:0H Not tainted
> 6.0.0-rc6-next-20220921 #1
> [    2.088013] Hardware name: Generic DT based system
> [    2.090383] Workqueue: kblockd blk_mq_run_work_fn
> [    2.092775]  unwind_backtrace from show_stack+0x10/0x14
> [    2.095426]  show_stack from dump_stack_lvl+0x40/0x4c
> [    2.097885]  dump_stack_lvl from kasan_report+0x94/0xc4
> [    2.100488]  kasan_report from mempool_alloc+0xb0/0x1f4
> [    2.103138]  mempool_alloc from __sg_alloc_table+0x164/0x1c4
> [    2.105969]  __sg_alloc_table from sg_alloc_table_chained+0x5c/0xe4
> [    2.109094]  sg_alloc_table_chained from virtblk_map_data+0xd8/0x13c
> [    2.112247]  virtblk_map_data from virtio_queue_rq+0x84/0x264
> [    2.115029]  virtio_queue_rq from blk_mq_dispatch_rq_list+0x39c/0xf48
> [    2.118214]  blk_mq_dispatch_rq_list from
> blk_mq_do_dispatch_sched+0x430/0x594
> [    2.121793]  blk_mq_do_dispatch_sched from
> __blk_mq_sched_dispatch_requests+0x16c/0x23c
> [    2.125717]  __blk_mq_sched_dispatch_requests from
> blk_mq_sched_dispatch_requests+0x58/0x80
> [    2.129825]  blk_mq_sched_dispatch_requests from
> __blk_mq_run_hw_queue+0x64/0x10c
> [    2.133515]  __blk_mq_run_hw_queue from process_one_work+0x3d4/0x6dc
> [    2.136639]  process_one_work from worker_thread+0xa0/0x820
> [    2.139412]  worker_thread from kthread+0x140/0x164
> [    2.141815]  kthread from ret_from_fork+0x14/0x2c
> [    2.144129] Exception stack(0xf08e3fb0 to 0xf08e3ff8)
> [    2.146575] 3fa0:                                     00000000
> 00000000 00000000 00000000
> [    2.150506] 3fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    2.154436] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.157656] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    2.161322] Disabling lock debugging due to kernel taint
> [    2.163506] 8<--- cut here ---
> [    2.164755] Unable to handle kernel NULL pointer dereference at
> virtual address 00000014
> [    2.168058] [00000014] *pgd=3D00000000
> [    2.169891] Internal error: Oops: 5 [#1] SMP ARM
> [    2.171792] Modules linked in:
> [    2.173057] CPU: 1 PID: 20 Comm: kworker/1:0H Tainted: G    B
>        6.0.0-rc6-next-20220921 #1
> [    2.176792] Hardware name: Generic DT based system
> [    2.178843] Workqueue: kblockd blk_mq_run_work_fn
> [    2.181206] PC is at mempool_alloc+0xb4/0x1f4
> [    2.183376] LR is at kasan_report+0x9c/0xc4
> [    2.185431] pc : [<c049411c>]    lr : [<c05216ac>]    psr: 60000013
> [    2.188487] sp : f08e39c0  ip : 00000000  fp : 00000014
> [    2.191027] r10: 00000010  r9 : c03c9950  r8 : c38c5400
> [    2.193568] r7 : f08e3a60  r6 : 00092820  r5 : 00000000  r4 : bd11c73c
> [    2.196713] r3 : 00000000  r2 : c38c5400  r1 : c353ffc0  r0 : 00000010
> [    2.199868] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [    2.203313] Control: 10c5383d  Table: 4020406a  DAC: 00000051
> [    2.206068] Register r0 information: zero-size pointer
> [    2.208590] Register r1 information: non-slab/vmalloc memory
> [    2.211352] Register r2 information: slab task_struct start
> c38c5400 pointer offset 0
> [    2.215161] Register r3 information: NULL pointer
> [    2.217437] Register r4 information: non-paged memory
> [    2.219890] Register r5 information: NULL pointer
> [    2.222157] Register r6 information: non-paged memory
> [    2.224640] Register r7 information: 4-page vmalloc region starting
> at 0xf08e0000 allocated at kernel_clone+0xf0/0x408
> [    2.229783] Register r8 information: slab task_struct start
> c38c5400 pointer offset 0
> [    2.233581] Register r9 information: non-slab/vmalloc memory
> [    2.236383] Register r10 information: zero-size pointer
> [    2.238914] Register r11 information: non-paged memory
> [    2.241385] Register r12 information: NULL pointer
> [    2.243722] Process kworker/1:0H (pid: 20, stack limit =3D 0x(ptrval))
> [    2.246784] Stack: (0xf08e39c0 to 0xf08e4000)
> [    2.248933] 39c0: 41b58ab3 00000008 00092820 00000000 c03c9950
> c0388c78 00000000 00000000
> [    2.252847] 39e0: 41b58ab3 c2806330 c0494068 00000000 00000000
> f08e3fb0 c03001a8 00000000
> [    2.256795] 3a00: f08e3d6c bd11c748 f08e3aa0 00000004 f08e3d70
> c38c5400 f08e3ec5 c18a3a64
> [    2.260728] 3a20: ffffffff c2baa044 c3888a80 c38c5400 25709000
> 00000000 c38c59ac 00000000
> [    2.264642] 3a40: 41b58ab3 c29121c0 c18a39d0 00000000 00000000
> 00000000 00000000 c0398898
> [    2.268580] 3a60: ffffff04 ffff0a00 00000001 e82b3600 00000028
> b4ab2764 00000000 00000003
> [    2.272487] 3a80: 00000001 00000002 c5ac00bc 00000000 00000080
> c5ac00c8 00000000 c17b0154
> [    2.276421] 3aa0: bd11c75c 00000080 c5ac00c4 0000003c c38c5400
> 00000002 00000004 c5ac00bc
> [    2.280361] 3ac0: c5ac00a8 c38c5400 c5a5d400 c5ac00bc c5ac00c8
> c186f530 00000002 00000820
> [    2.284288] 3ae0: c186f424 c28016ac c0419268 c5ac0000 bd11c764
> f08e3b80 c5ac00a8 c0d95b18
> [    2.288225] 3b00: 40000013 00000800 ee5c41b4 00000000 00000000
> c38c5400 f08e3b78 c186f950
> [    2.292156] 3b20: 41b58ab3 c28b0fb0 c0d95a40 0001f935 e7be7000
> 00000000 00000028 bd11c76c
> [    2.296076] 3b40: 00000000 b4ab2764 0003f4a8 c5a45204 00000800
> ee5c41b4 00000000 c03883b0
> [    2.300022] 3b60: c5a45200 b4ab2764 f8838b55 c5ac0000 c5ac0060
> c5a0a000 f08e3ca0 b4ab2764
> [    2.303939] 3b80: f08e3d80 c5ac0000 c5a5d400 c5a0a000 f08e3ca0
> 00000000 f08e3d80 c5a0a0b0
> [    2.307855] 3ba0: c5ac00a8 c0d98040 e82b7198 00000000 00000008
> b4ab2764 c194b640 c5ac0038
> [    2.311810] 3bc0: c5ac003c c5ac0000 c2124260 f08e3d80 f08e3d80
> f08e3ce0 c5ac0014 c0895fd4
> [    2.315727] 3be0: 00000000 00000000 c5a5d400 c57a7228 00000000
> 00000000 00000000 ffffffff
> [    2.319656] 3c00: 00000020 f08e3c80 00000000 c38c5400 bd11c78c
> c35079e9 c1a3f4c0 bd11c788
> [    2.323592] 3c20: 41b58ab3 b4ab2764 c18abd90 e82b6c00 c4b50d00
> 7ba3fc00 00000000 c189d98c
> [    2.327508] 3c40: 00000000 c5a5c080 00000001 00000020 00000001
> 0000001f 00000000 c1871ae0
> [    2.331439] 3c60: 41b58ab3 c28276d4 c0895c38 c5a5c080 c5a0c20c
> 00000001 c5a5c0c0 00000005
> [    2.335400] 3c80: f08e3c80 f08e3c80 00000003 c18730dc 00000000
> 00000000 c5a0c214 c5a0c218
> [    2.339327] 3ca0: c5ac0000 00000001 c5a0c220 00000080 c4b50d00
> c5ac0000 c5a5d400 c5a5d400
> [    2.343267] 3cc0: c5ac0014 c5a0c200 00000000 c5a0c20c c5a5d478
> c0895684 00000001 b4ab2764
> [    2.347200] 3ce0: 00014528 f08e3d80 f08e3de0 c5a5e400 c2d603c0
> 00000000 c5a5d404 00000001
> [    2.351109] 3d00: c5a5d400 c089f970 c38c5400 c57a7228 c5a5d400
> 00000000 c38c5400 c5a5d480
> [    2.355028] 3d20: c5a5d4a8 c5a5d404 00000100 ffff8bfe c2c05d40
> c5a5d408 bd11c7ac ffffffff
> [    2.358965] 3d40: e82b7198 00000020 00000418 c2912ee4 f08e3d7c
> c03991d8 f08e3e00 e82b6b80
> [    2.362868] 3d60: 41b58ab3 c2827a24 c089f540 c2badb80 e82b6b80
> e82b71ac f08e3dac c03992ec
> [    2.366766] 3d80: f08e3d80 f08e3d80 c4b5123c c4b50a80 bd11c7bc
> c38c5400 c4b5123c c18e2184
> [    2.370710] 3da0: c4b50a80 bd11c7bc c38c5400 c039c340 00000000
> 25709000 20000093 c4b50a88
> [    2.374616] 3dc0: f08e3e40 00000020 f08e3e00 c38c5400 c380d380
> c18da380 00000009 b4ab2764
> [    2.378521] 3de0: 41b58ab3 c5a5d400 f08e3e80 c5a5d404 bd11c7c4
> c38c5400 c5a5e400 f08e3e40
> [    2.382465] 3e00: c38ba410 c089ff24 c3801300 c0521264 00000004
> c0399700 c380d384 c4b50fd0
> [    2.386392] 3e20: 41b58ab3 c2827a68 c089fdb8 c380d384 c2c07050
> c4b50a80 e82b6b48 c0388e4c
> [    2.390313] 3e40: f08e3e40 f08e3e40 07400001 e82b3600 e82b6a18
> c0417b18 e82b69d0 c2baa600
> [    2.394272] 3e60: c38c5400 c0417c0c e82b3600 e82b69ec e82b6a18
> c18e2184 e82b3600 00000001
> [    2.398195] 3e80: c3872468 c3872464 c38ba444 b4ab2764 00000018
> c5a5d400 c57a7228 c5a5d480
> [    2.402105] 3ea0: e82bbe00 00000060 c38ba40c e82b69ec c38ba410
> c08a0074 c57a7228 c5a5d400
> [    2.406053] 3ec0: c5a5d480 c0891f88 c5a5d440 c38ba400 e82b69d0
> c037cc1c f08e3f84 c039aaa8
> [    2.409979] 3ee0: 00000000 e82bbe05 c38c5400 c38ba408 c38ba404
> c38ba414 e82b69ec c38ba424
> [    2.413904] 3f00: c38ba400 c5a5d440 c5a5d444 c38ba418 ffff8b9a
> e82b69f8 e82b69f8 e82b69d0
> [    2.417843] 3f20: c38ba400 c037cfc4 e82b69ec c2c05d40 e82b69e4
> e82b6b2c e82b69e8 c38ba434
> [    2.421782] 3f40: c38c5400 c38ba424 c38ba420 c38c5618 c38ba41c
> c3507627 c194afa0 c38c5624
> [    2.425693] 3f60: c38c5bbc c38c5400 00000000 c38e8190 c38e8300
> c037cf24 c38ba400 00000000
> [    2.429605] 3f80: f082bc80 c0388db8 00000001 c38e8180 c0388c78
> 00000000 00000000 00000000
> [    2.433557] 3fa0: 00000000 00000000 00000000 c03001a8 00000000
> 00000000 00000000 00000000
> [    2.437463] 3fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    2.441366] 3fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [    2.445291]  mempool_alloc from __sg_alloc_table+0x164/0x1c4
> [    2.448096]  __sg_alloc_table from sg_alloc_table_chained+0x5c/0xe4
> [    2.451136]  sg_alloc_table_chained from virtblk_map_data+0xd8/0x13c
> [    2.454200]  virtblk_map_data from virtio_queue_rq+0x84/0x264
> [    2.456983]  virtio_queue_rq from blk_mq_dispatch_rq_list+0x39c/0xf48
> [    2.460135]  blk_mq_dispatch_rq_list from
> blk_mq_do_dispatch_sched+0x430/0x594
> [    2.463669]  blk_mq_do_dispatch_sched from
> __blk_mq_sched_dispatch_requests+0x16c/0x23c
> [    2.467515]  __blk_mq_sched_dispatch_requests from
> blk_mq_sched_dispatch_requests+0x58/0x80
> [    2.471526]  blk_mq_sched_dispatch_requests from
> __blk_mq_run_hw_queue+0x64/0x10c
> [    2.475148]  __blk_mq_run_hw_queue from process_one_work+0x3d4/0x6dc
> [    2.478214]  process_one_work from worker_thread+0xa0/0x820
> [    2.480931]  worker_thread from kthread+0x140/0x164
> [    2.483335]  kthread from ret_from_fork+0x14/0x2c
> [    2.485614] Exception stack(0xf08e3fb0 to 0xf08e3ff8)
> [    2.488064] 3fa0:                                     00000000
> 00000000 00000000 00000000
> [    2.492015] 3fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    2.495945] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.499147] Code: e58d3004 e1a0000b eb0236e0 e1a0000a (e5959014)
> [    2.502177] ---[ end trace 0000000000000000 ]---
>=20
> link:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220921/=
testrun/11997362/suite/log-parser-test/tests/
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20

--vKSqeyF9fWs7S3SE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMsrT8ACgkQnKSrs4Gr
c8jFBQgAoRI60HFN2lYGiVIJoqcOfd2aC+EMjCduTko9OKaGjaNM5a8tuVwNoWVf
mM0QT9FmgFx/DHAkXKGP8mazCmyn7/Mw1LrCHPCXFYdObRWPIqqJOZQLOrD+fGPn
HdMKjZbnBF2nW/rTy0urnl5d9yUtZ8E8TRlUz/w0n1afYOz7zdkKrg0EJENwQzpr
3LWgV7pnLKQWA05w1BKfIUUjoYFhILRyD4cA6KqJVZtpaU4EvExDrKCZheWboRP6
71ot8wvRgFXZo1Y40VxmesiJm1MRLJLXP3hmDZjBJyrtP4jb8PSd71vhCpeY2Bu4
qMko90GHeqzzm9v/cdpnPBukqqsurQ==
=PHUv
-----END PGP SIGNATURE-----

--vKSqeyF9fWs7S3SE--

