Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DF612C67
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ3TXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3TXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:23:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FDDB1D9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:23:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 983B95C003F;
        Sun, 30 Oct 2022 15:23:42 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Sun, 30 Oct 2022 15:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667157822; x=1667244222; bh=ki
        0w8E89xq1IweuEOycTi68h20ldYBwm17VLVgE61nc=; b=Aw56PXPAHjWEYBtkyS
        NJsPJp1mWEa26PXS+uhsQraVHhzYyLvCY5LefxNYpM3iMpAMmmoUDMgaJhuDSRB1
        GpFIgAP84Ne1U4GiK/2cyNIhjnWpv5roPE9k4016fMj8HWKPTsbuEyjvU6upd19t
        Hsn2LiOQzJ3uu1Ab3g0tmTPlDGhKrGrzHgmhaeAMPw3tD0uJ9AZJY1e/CPd5ZYSY
        EkdWAILI2vIYysXEnkv6LJLpH2DQoPAQPOFdjCUXM5+RAoUxDJGOn080VpgwdBDU
        Eq0kRgfSWWSPakWwzCP4bjNWYcKfnHHh+ZjUQzDrW5ZXYLG0M80fN9w6rzjeanQ5
        6T2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667157822; x=1667244222; bh=ki0w8E89xq1IweuEOycTi68h20ld
        YBwm17VLVgE61nc=; b=f0WWAltV/OTnTYSijZiq/NryQ+2dT6NnL4p3hSztaVNX
        qlL7kZb9aAgP3A212eonGOUfnk2bKOt8khbUKQgCBQhu2J7EGVZq8VxHVEr8/1Us
        fPvoZtaIhUGLydhAiWjDHVTyq8cZGaHjM4m09B/y2JC8NpEmpUcIMuLlz2IQex5p
        IOjDyAsaS28BkWKtDpdW36SRySf67Jc5SmhIjdsUNZ/it6NnerMtsQEVJ2QNHmW+
        Q/kMIfRtHJSUnZXAcJdy+FabIIkdvtK9WWmrLASUDOfTK/9WTFoRQiWqZKOFcAwB
        gcDqdInCsUr0i/kIed+4QBTZIyeSVtOV8GzGUxLUMw==
X-ME-Sender: <xms:PM9eY5vphbLAIyz6udFLL4e0t4A5DU-yp5oGj81moFHnFlWmpe12ig>
    <xme:PM9eYyfVv19d4B-Ptwc3J1rPbUCijAKxgfwEte-OZJLfOTnuwD2f1NomDJI9sPVMm
    wtSwiNqQ8pSl2eA6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedruddtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeekfefhgfdutdeggeejtdev
    tddvvdekvedvheefheeijefhhffhjeekjefgleevgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssehjohhhnhhthhhomhhsohhn
    rdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:PM9eY8wjg2dZFQM58nlzVcEHxKjnyV7wVICEc7eDtFC905gIJI5Hvw>
    <xmx:PM9eYwPy8hGMtCKd4f2fgIGmFP2K7N7Am2cosPlS4W9XOuoc8N7ksg>
    <xmx:PM9eY5-B59pqdYEG36q0KjY6I5CI6Pr1-5L-RGiY5FuonDvv5fyffQ>
    <xmx:Ps9eYxMYzW3G_WO5bZbDWt0QgswlrOu5a5v4YO6aLbk-mc1-7R_diA>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71A9E2A20080; Sun, 30 Oct 2022 15:23:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
In-Reply-To: <20220913065423.520159-2-feng.tang@intel.com>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
Date:   Sun, 30 Oct 2022 19:23:04 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Feng Tang" <feng.tang@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Andrey Konovalov" <andreyknvl@gmail.com>
Cc:     "Dave Hansen" <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of kmalloc
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, at 06:54, Feng Tang wrote:
> kmalloc's API family is critical for mm, with one nature that it will
> round up the request size to a fixed one (mostly power of 2). Say
> when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> could be allocated, so in worst case, there is around 50% memory
> space waste.


I have a ralink mt7621 router running Openwrt, using the mips ZBOOT kernel, and appear to have bisected
a very-nearly-clean kernel v6.1rc-2 boot issue to this commit.
I have 3 commits atop 6.1-rc2: fix a ZBOOT compile error, use the Openwrt LZMA options,
and enable DEBUG_ZBOOT for my platform. I am compiling my kernel within the Openwrt build system.
No guarantees this is not due to something I am doing wrong, but any insight would be greatly appreciated.


On UART, No indication of the (once extracted) kernel booting:

transfer started ......................................... transfer ok, time=2.01s
setting up elf image... OK
jumping to kernel code
zimage at:     80BA4100 810D4720
Uncompressing Linux at load address 80001000
Copy device tree to address  80B96EE0
Now, booting the kernel...

Nothing follows

6edf2576a6cc  ("mm/slub: enable debugging memory wasting of kmalloc") reverted, normal boot:
transfer started ......................................... transfer ok, time=2.01s
setting up elf image... OK
jumping to kernel code
zimage at:     80BA4100 810D47A4
Uncompressing Linux at load address 80001000
Copy device tree to address  80B96EE0
Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc2 (john@john) (mipsel-openwrt-linux-musl-gcc (OpenWrt GCC 11.3.0 r19724+16-1521d5f453) 11.3.0, GNU ld (GNU Binutils) 2.37) #0 SMP Fri Oct 28 03:48:10 2022
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
[    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] VPE topology {2,2} total 4
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
[    0.000000] MIPS secondary cache 256kB, 8-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] percpu: Embedded 11 pages/cpu s16064 r8192 d20800 u45056
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64960
[    0.000000] Kernel command line: console=ttyS0,115200 rootfstype=squashfs,jffs2
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Writing ErrCtl register=00019146
[    0.000000] Readback ErrCtl register=00019146
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 246220K/262144K available (7455K kernel code, 628K rwdata, 1308K rodata, 3524K init, 245K bss, 15924K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.


boot continues as expected


possibly relevant config options:
grep -E '(SLUB|SLAB)' .config
# SLAB allocator options
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options
# CONFIG_SLUB_DEBUG is not set


With this commit reverted: cpuinfo and meminfo

system type		: MediaTek MT7621 ver:1 eco:3
machine			: MikroTik RouterBOARD 760iGS
processor		: 0
cpu model		: MIPS 1004Kc V2.15
BogoMIPS		: 586.13
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r1 mips32r2
ASEs implemented	: mips16 dsp mt
Options implemented	: tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 0
VPE			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

processor		: 1
cpu model		: MIPS 1004Kc V2.15
BogoMIPS		: 586.13
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r1 mips32r2
ASEs implemented	: mips16 dsp mt
Options implemented	: tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 0
VPE			: 1
VCED exceptions		: not available
VCEI exceptions		: not available

processor		: 2
cpu model		: MIPS 1004Kc V2.15
BogoMIPS		: 586.13
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r1 mips32r2
ASEs implemented	: mips16 dsp mt
Options implemented	: tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 1
VPE			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

processor		: 3
cpu model		: MIPS 1004Kc V2.15
BogoMIPS		: 586.13
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r1 mips32r2
ASEs implemented	: mips16 dsp mt
Options implemented	: tlb 4kex 4k_cache prefetch mcheck ejtag llsc pindexed_dcache userlocal vint perf_cntr_intr_bit cdmm perf
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 1
VPE			: 1
VCED exceptions		: not available
VCEI exceptions		: not available

MemTotal:         249744 kB
MemFree:          211088 kB
MemAvailable:     187364 kB
Buffers:               0 kB
Cached:             8824 kB
SwapCached:            0 kB
Active:             1104 kB
Inactive:           8860 kB
Active(anon):       1104 kB
Inactive(anon):     8860 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:         249744 kB
LowFree:          211088 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          1192 kB
Mapped:             2092 kB
Shmem:              8824 kB
KReclaimable:       1704 kB
Slab:               9372 kB
SReclaimable:       1704 kB
SUnreclaim:         7668 kB
KernelStack:         592 kB
PageTables:          264 kB
SecPageTables:	       0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      124872 kB
Committed_AS:      14676 kB
VmallocTotal:    1040376 kB
VmallocUsed:        2652 kB
VmallocChunk:          0 kB
Percpu:              272 kB


Cheers,

-- 
  John Thomson
