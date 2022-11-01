Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF261435C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKACnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKACnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:43:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6816178A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:42:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ACD65C00CD;
        Mon, 31 Oct 2022 22:42:56 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Mon, 31 Oct 2022 22:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667270576; x=1667356976; bh=/d
        wKm9SsHVF+uc6H4cCJSM/BggzQOsC1bv5VwAzfx5w=; b=TLdlHt4nbWshMvpEf2
        7iBFabk9yfw8BZgGq50uBhfiTZlE0T1nPLQAUiMPxm+WXsIblFnkYlb3km7DXyAf
        ZnrC6g428BYZdFgqg/iW2gfXxAhwsRmvqBw0zPg9Bu17AbaFtodxH0INzrNwWpDx
        V4wmIxLbyHPEVli9Djq0Y89mWLUohvn2qxlvp9pmigkfmHJO8L4Yga7c5+P6LiJ7
        Fn3NC612D+ixTYHDolFFGm4Z/MHpWC437KDqloKM9a19E3PuVfCHHZryqs0yoY4i
        1KGpVru8bap+NOtLC84E3TdcUV/w6vj7vcLQpMnXF4zM+5CTqpnRJIoFHOVxYdt9
        xh5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667270576; x=1667356976; bh=/dwKm9SsHVF+uc6H4cCJSM/BggzQ
        OsC1bv5VwAzfx5w=; b=Htik0XU818a/xurg5F2b6JdlJNsswQDdp3gQZB/Pqu31
        TwCfkc7oX584Qfzh17vFJgc232eYf2+DcWGD8MGcYufuUIYT/ys6YtGf+qtOGYt4
        5BAsYMY0wvKXZOMYs9vvqNsVyNQy2oKsRa+3uK4FZ4NENzVBmxYs/mYX7Cag9XEw
        dUxazRbZ+fY2pTNhjiNONWxsWQgUE2K093271na7i0JfytdfxgcN4ZpEDzMTaOEc
        3vp0dndcZ6dJ55qj+ENOEItOVp9AAoio4ttSkKX4NdZHC2TyCgd1W9KeilMXmwu5
        XFEwR9UafYkQhWucbaA7o9jUCbjVwzxji1KHwxVfgw==
X-ME-Sender: <xms:r4dgY_bJ1KJuRJjGxL5d2A1xbcMAQY-ZyYw6m5gSovZFnxeEQfbncQ>
    <xme:r4dgY-Ydy0wW6Fcg7Isc_xSmKcXaAQXICu6vFo4n5WpfHenG1TTai1ptkS30f14CW
    goqIAG_HPY6J2QQ7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeggdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmh
    grihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepkeefhffguddtgeegjedtvedt
    vddvkeevvdehfeehieejhffhhfejkeejgfelveegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshesjhhohhhnthhhohhmshhonhdr
    fhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:r4dgYx-3wCqeEnC193H4AU_rM8kJGYOZK-LASIRiBJCWRlfU2AAXQQ>
    <xmx:r4dgY1o-C1CZzeI_jHgsDJJXr--Hep3Qq0ngZQO_BTKnmXNF5jzPyQ>
    <xmx:r4dgY6osCvI8vH-fIgn5PS-JyBEd4uziuvu1b7USSv2CXZENXTeUxA>
    <xmx:sIdgY9-75UVaJPCJLVIZXwEcZ6OcwmYiHX-VDM2UfA9_xQEEjybcCg>
Feedback-ID: if0294502:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E03D2A20080; Mon, 31 Oct 2022 22:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <00ce752c-17e0-4813-afa3-fe1510545b23@app.fastmail.com>
In-Reply-To: <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz> <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
Date:   Tue, 01 Nov 2022 02:41:45 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "John Thomson" <lists@johnthomson.fastmail.com.au>,
        "Feng Tang" <feng.tang@intel.com>
Cc:     "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
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


On Tue, 1 Nov 2022, at 00:18, John Thomson wrote:
> I may have got lucky. it appears as though this is all I need to boot:
> (against 6.1-rc3), and with the Bootlin toolchain. Will test my other 
> build system as well.
>
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3276,7 +3276,7 @@ static void *__slab_alloc(struct kmem_cache *s, 
> gfp_t gfpflags, int node,
>         c = slub_get_cpu_ptr(s->cpu_slab);
>  #endif
> 
> -       p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> +       p = ___slab_alloc(s, gfpflags, node, addr, c, 0);
>  #ifdef CONFIG_PREEMPT_COUNT
>         slub_put_cpu_ptr(s->cpu_slab);
>  #endif

Tested that with and without SLUB_DEBUG


Testing without SLUB_DEBUG below:
With this change on 6.1-rc3:
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..5fdb7609bb9e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3410,6 +3410,8 @@ static __always_inline
 void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
                             gfp_t gfpflags)
 {
+
+       pr_warn("SLUB: __slab_alloc from slab_alloc s->object_size=%d\n", s->object_size);
        void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
        trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);


UART & boot stops here:
transfer started ......................................... transfer ok, time=2.00s
setting up elf image... OK
jumping to kernel code
zimage at:     80B842A0 810B4BE4

Uncompressing Linux at load address 80001000

Copy device tree to address  80B80EE0

Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #34 SMP Tue Nov  1 12:33:10 AEST 2022
[    0.000000] Overriding previously set SMP ops
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
[    0.000000] Kernel command line: earlyprintk=ttyS0,115200 console=ttyS0,115200 rootfstype=squashfs,jffs2
[    0.000000] Unknown kernel command line parameters "earlyprintk=ttyS0,115200", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Writing ErrCtl register=00011146
[    0.000000] Readback ErrCtl register=00011146
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 246284K/262144K available (7417K kernel code, 630K rwdata, 1304K rodata, 3500K init, 245K bss, 15860K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=32
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=132
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=300
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 256
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=512
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=512
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=256
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=256
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=256
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=128
[    0.000000] clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0xcaf478abb4, max_idle_ns: 440795247997 ns
[    0.000000] SLUB: __slab_alloc from slab_alloc s->object_size=256
[    0.000004] sched_clock: 64 bits at 880MHz, resolution 1ns, wraps every 4398046511103ns


This change, and kernel boots fine:

diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..e9677c04d19c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3410,7 +3410,11 @@ static __always_inline
 void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
                             gfp_t gfpflags)
 {
-       void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
+
+       /*
+       pr_warn("SLUB: __slab_alloc from slab_alloc s->object_size=%d\n", s->object_size);
+       void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);*/
+       void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
 
        trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 


Cheers,

-- 
  John Thomson
