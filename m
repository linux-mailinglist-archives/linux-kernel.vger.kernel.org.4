Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33D7615276
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKATkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKATkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:40:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D61A82C;
        Tue,  1 Nov 2022 12:40:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 651A55C00E0;
        Tue,  1 Nov 2022 15:40:02 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Tue, 01 Nov 2022 15:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667331602; x=1667418002; bh=vg
        YJ4ShTCJw+q1hns4AaRdstGfrX8Bj+zm/rkHrdINA=; b=Oq1A6gfqu6iq4VSoSW
        W2d6dnKVOxNSa9CmIsHAWsyNMy0TZlbjHrNPWFVfCXY7VWI3z755S3NWKP9M/5OD
        ts7ErDYqmlhimH9wq6+r9L+dKjvt5Sy+SnBqJa1XQuavapTeAQA21ZaVb4txKeJ6
        frbTYYaHGMVpZVMDi1lBIrOSIiMtT263YQLHkAghQr/RFyHXgq8t0jCgqJiIZ9wK
        KIcdJDUgmPIxLh8Nh+EEBUR4JeTuNmSoD+WvYbm+V/woaELAMvJRaYyNqbLVx3B2
        u7CmtJPxsNqUYUfHOGWXSU333eFajfiwJoNxhS0yRHwbu8ErLO/4rMi18ftCcEaN
        ekUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667331602; x=1667418002; bh=vgYJ4ShTCJw+q1hns4AaRdstGfrX
        8Bj+zm/rkHrdINA=; b=NdS/uGDWSLTysziCz1zO4gfksXRDKNOHr/q2bW5+aAuO
        EluzpDrDyP9PyzFL5UoLRpQcU2BKGnko58Jm1sJ/Jw457Gk1ov843QZTxZwGUc+e
        ITLvTFAYeoV93o//J9bMIz68YkypQXDABrB/kP3+aJd5Z8ExsCe4e3hQYucewc9o
        TnSiZXsAgxHAcuRCyCdAkt1kTrGgIhT6eGtdELmD5jNEA7nGiFU20CDeOLkDgdtK
        KMQHxPnaRgXgjo4LfBjntGKB5xGYZFtS7lOFZLSpVerIaU0p7+CMO3z4C9+jjvez
        MOYJFM6LRJNEyWtTFOXeHwJ+0oLIXuRlIE2zkVd9Rw==
X-ME-Sender: <xms:EHZhYwhHoa-YC0_MvH6mI4R4gPe6sVkc_6CBXWQuZZdB9xr_pEjCSQ>
    <xme:EHZhY5CK0mBce84YjYQrQSLk4GYxu0vDlGmZjy7xSqe7XLDXY_jwD2RPnk5kYuiVT
    baR2LtpGcIwtbZWcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeekfefhgfdutdeggeejtdev
    tddvvdekvedvheefheeijefhhffhjeekjefgleevgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssehjohhhnhhthhhomhhsohhn
    rdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:EXZhY4G3QvYqyOifqsFHvnTtvESzuwF23mSyWWe6ymZ2mJZTuOHWRg>
    <xmx:EXZhYxR0FRkOTnjJ4yJVZ0BKuiK-_IKmPgJWtuL01S_vK5UGo3xyZg>
    <xmx:EXZhY9woIIs6qRkJ1lxC72nqj0JXYQfsTnzGDwcHKrcevD8j6hFDyw>
    <xmx:EnZhYyw0oLqsXkr8dL5tHxz7N7vl_G_y9QdYNHE61hoYJXWi_yRgaA>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D74ED2A20079; Tue,  1 Nov 2022 15:40:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
In-Reply-To: <Y2ElURkvmGD5csMc@feng-clx>
References: <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <Y2D4D52h5VVa8QpE@hyeyoo> <Y2ElURkvmGD5csMc@feng-clx>
Date:   Tue, 01 Nov 2022 19:39:13 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Feng Tang" <feng.tang@intel.com>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>
Cc:     "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "John Crispin" <john@phrozen.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
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



On Tue, 1 Nov 2022, at 13:55, Feng Tang wrote:
> On Tue, Nov 01, 2022 at 06:42:23PM +0800, Hyeonggon Yoo wrote:
>> setup_arch() is too early to use slab allocators.
>> I think slab received NULL pointer because kmalloc is not initialized.
>> 
>> It seems arch/mips/ralink/mt7621.c is using slab too early.
>
> Cool! it is finally root caused :) Thanks!
>
> The following patch should solve it and give it a warning message, though
> I'm not sure if there is other holes.  
>
> Thanks,
> Feng
>
> ---
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 33b1886b06eb..429c21b7ecbc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1043,7 +1043,14 @@ size_t __ksize(const void *object)
>  #ifdef CONFIG_TRACING
>  void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
> -	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
> +	void *ret;
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> +		WARN_ON_ONCE(1);
> +		return s;
> +	}
> +
> +	ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
>  					    size, _RET_IP_);
> 
>  	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..85d24bb6eda7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3410,8 +3410,14 @@ static __always_inline
>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			     gfp_t gfpflags)
>  {
> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
> +	void *ret;
> 
> +	if (unlikely(ZERO_OR_NULL_PTR(s))) {
> +		WARN_ON_ONCE(1);
> +		return s;
> +	}
> +
> +	ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
> 
>  	return ret;

Yes, thank you, that patch atop v6.1-rc3 lets me boot, and shows the warning and stack dump.
Will you submit that, or how do we want to proceed?

transfer started ......................................... transfer ok, time=2.11s
setting up elf image... OK
jumping to kernel code
zimage at:     80B842A0 810B4BC0

Uncompressing Linux at load address 80001000

Copy device tree to address  80B80EE0

Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed Nov  2 05:10:01 AEST 2022
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416 kmem_cache_alloc+0x5a4/0x5e8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
[    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000 00000000 80889d04 80c90000
[    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000 00000001 80889cb0 00000000
[    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002 00000002 00000001 6d6f4320
[    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328 00000000 00000000 00000000
[    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<80008260>] show_stack+0x28/0xf0
[    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
[    0.000000] [<8002e184>] __warn+0xc4/0xf8
[    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
[    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
[    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
[    0.000000] [<80928060>] prom_init+0x44/0xf0
[    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
[    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
[    0.000000] 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
[    0.000000] printk: bootconsole [early0] enabled

Thank you for working through this with me.
I will try to address the root cause in mt7621.c.
It looks like other arch/** soc_device_register users use postcore_initcall, device_initcall,
or the ARM DT_MACHINE_START .init_machine. A quick hack to use postcore_initcall in mt7621
avoided this zero ptr kmem_cache passed to kmem_cache_alloc_lru.


Thanks,

-- 
  John Thomson
