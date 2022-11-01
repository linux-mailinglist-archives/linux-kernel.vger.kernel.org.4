Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBAA6147BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKAKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:34:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C8126;
        Tue,  1 Nov 2022 03:34:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 342F23200970;
        Tue,  1 Nov 2022 06:34:10 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Tue, 01 Nov 2022 06:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667298849; x=1667385249; bh=z1
        rNkUkf7u5akB5pgiOIOqLSL4PvlOcgKqUXRgy689Q=; b=jx4i1eWf0BAw2bQakT
        AJMarEmrE61BS7mqxBCqsdDipm/UXNNvy+YsjXSu0j2b0+FCT38HjAJiwqAJgfeh
        o3CT4NUTnbM9pf04zVxEm72PKs3EhOvMACCRQiiiLpYyAUCsLeAzgsgdSBYfnkC+
        XDzVYVEH8rO4RlpQbrYLvgfEkCadNRDU9iqotckMeXiQCHQKzCeLz7SSF8DdO7Pl
        /AS3FWe03tGaiNeQwEhqLAp/OHW2elHAxU61OasNb5i9x8G2yOGilm5i7HiGFwZy
        6657ryv8ABkm9eO/4n0GkBccY62Gwj/LIMaW9x3FuizYXqQY4GmtTw1XhcyapRoC
        +dCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667298849; x=1667385249; bh=z1rNkUkf7u5akB5pgiOIOqLSL4Pv
        lOcgKqUXRgy689Q=; b=QrJoBQb2SYbAiBy3Ajt2TdT+weCLF6vyTP6fCCHIcXRZ
        wMZ6RUXJYbd1UwUDlwUVpY9SjnVNr88s3IIE2MCqLLOD0IeaV56Hc4NhWStYQFGZ
        IcRP2JgFvuhhK52M+6oIDMI7dTg5JgHyM+OL51223duW4mvc5HYvXlrEVfyPVRxG
        +AJ+fNkOAKDhlWpuleqvCTpTBqi9GjO4zXP/6ClHzulmnGTEnjs3bcqxNt0f1l3w
        25zt5/BxiUfgsKpOjpO59tOzI3dWzV+dE0yQhObJpS3B3KhxemmPeCz6O944JXpx
        yxU1cA8+pW25BanBpGQeLucjD7pCGIvvMDDKzCCD6w==
X-ME-Sender: <xms:IPZgY3B6uJPnxqW_YXn0g4swkR6d4Ptx8ky2Yzayu0m7amaARAnqag>
    <xme:IPZgY9jdwuptHuCFqjOXWAIr3D09Rb-oD9j3HQb4R0wnqpEuV2L0mBC9g_HFjD0Eb
    fJ5cePln5Lqhv9FAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmh
    grihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepjeejfeeilefgfedtkeekfeek
    ffegleetlefhheekleeggfdttdevveduheettefgnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:IPZgYyndyNLG1Bz43rWyG7xVaFPUrR3Wx0d8ZaGBenQLcoF1YsZ1dw>
    <xmx:IPZgY5xs6OqFnbgHF8pfx0n7ZQfgk4nOP0jZPInxmq7snQRp2PEehg>
    <xmx:IPZgY8QqnnpbRY6x_Mj5DjgvOindn9KeAUWlIGHZkVOXyMqVREleZg>
    <xmx:IfZgY9LXh0qSTChG5LXKajlEEFa-gFWdFOzkiC1EzKxnflCAJnjsNg>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 04DC02A20080; Tue,  1 Nov 2022 06:34:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
In-Reply-To: <Y2DngwUc7cLB0dG7@hyeyoo>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz> <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
Date:   Tue, 01 Nov 2022 10:33:32 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Hyeonggon Yoo" <42.hyeyoo@gmail.com>
Cc:     "Feng Tang" <feng.tang@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
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
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of kmalloc
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022, at 09:31, Hyeonggon Yoo wrote:
> On Tue, Nov 01, 2022 at 09:20:21AM +0000, John Thomson wrote:
>> On Tue, 1 Nov 2022, at 07:57, Feng Tang wrote:
>> > Hi Thomson,
>> >
>> > Thanks for testing!
>> >
>> > + mips maintainer and mail list. The original report is here
>> >
>> > https://lore.kernel.org/lkml/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
>>
>> I am guessing my issue comes from __kmem_cache_alloc_lru accessing s->object_size when (kmem_cache) s is NULL?
>> If that is the case, this change is not to blame, it only exposes the issue?
>> 
>> I get the following dmesg (note very early NULL kmem_cache) with the below change atop v6.1-rc3:
>> 
>> transfer started ......................................... transfer ok, time=2.02s
>> setting up elf image... OK
>> jumping to kernel code
>> zimage at:     80B842A0 810B4EFC
>> 
>> Uncompressing Linux at load address 80001000
>> 
>> Copy device tree to address  80B80EE0
>> 
>> Now, booting the kernel...
>> 
>> [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #61 SMP Tue Nov  1 18:04:13 AEST 2022
>> [    0.000000] slub: kmem_cache_alloc called with kmem_cache: 0x0
>> [    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache: 0x0
>> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
>> [    0.000000] printk: bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
>> [    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS
>> 
>> normal boot
>> 
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 157527d7101b..10fcdf2520d2 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3410,7 +3410,13 @@ static __always_inline
>>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>  			     gfp_t gfpflags)
>>  {
>> -	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>> +	void *ret;
>> +	if (IS_ERR_OR_NULL(s)) {
>> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
>> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
>> +	} else {
>> +		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>> +	}
>>  
>>  	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
>>  
>> @@ -3419,6 +3425,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>  
>>  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
>>  {
>> +	if (IS_ERR_OR_NULL(s))
>> +		pr_warn("slub: kmem_cache_alloc called with kmem_cache: %pSR\n", s);
>>  	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc);
>> @@ -3426,6 +3434,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
>>  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>>  			   gfp_t gfpflags)
>>  {
>> +	if (IS_ERR_OR_NULL(s))
>> +		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
>>  	return __kmem_cache_alloc_lru(s, lru, gfpflags);
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
>> 
>> 
>> Any hints on where kmem_cache_alloc would be being called from this early?
>> I will start looking from /init/main.c around pr_notice("%s", linux_banner);
>
> Great. Would you try calling dump_stack(); when we observed s == NULL?
> That would give more information about who passed s == NULL to these
> functions.
>

With the dump_stack() in place:

Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
[    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
[    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
[    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
[    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
[    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
[    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<80008260>] show_stack+0x28/0xf0
[    0.000000] [<8070cdc0>] dump_stack_lvl+0x60/0x80
[    0.000000] [<801c1428>] kmem_cache_alloc+0x5c0/0x740
[    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
[    0.000000] [<80928060>] prom_init+0x44/0xf0
[    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
[    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
[    0.000000] 
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3



Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #62 SMP Tue Nov  1 19:49:52 AEST 2022
[    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache ptr: 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #62
[    0.000000] Stack : 810fff78 80084d98 80889d00 00000004 00000000 00000000 80889d5c 80c90000
[    0.000000]         80920000 807bd380 8089d368 80923bd3 00000000 00000001 80889d08 00000000
[    0.000000]         00000000 00000000 807bd380 8084bd51 00000002 00000002 00000001 6d6f4320
[    0.000000]         00000000 80c97ce9 80c97d14 fffffffc 807bd380 00000000 00000003 00000dc0
[    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] show_stack (/mnt/pool_ssd/code/linux/linux-stable-mt7621/./arch/mips/include/asm/stacktrace.h:43 /mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/kernel/traps.c:223) 
[    0.000000] dump_stack_lvl (/mnt/pool_ssd/code/linux/linux-stable-mt7621/lib/dump_stack.c:107 (discriminator 1)) 
[    0.000000] kmem_cache_alloc (/mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3318 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3406 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3418 /mnt/pool_ssd/code/linux/linux-stable-mt7621/mm/slub.c:3430) 
[    0.000000] prom_soc_init (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/mt7621.c:106 /mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/mt7621.c:177) 
[    0.000000] prom_init (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/ralink/prom.c:64) 
[    0.000000] setup_arch (/mnt/pool_ssd/code/linux/linux-stable-mt7621/arch/mips/kernel/setup.c:786) 
[    0.000000] start_kernel (/mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:279 /mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:477 /mnt/pool_ssd/code/linux/linux-stable-mt7621/init/main.c:960) 
[    0.000000] 
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3


I have not found it yet.


Cheers,
-- 
  John Thomson
