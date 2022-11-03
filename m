Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE836177E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:46:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6902ACB;
        Thu,  3 Nov 2022 00:46:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D690D5C00DF;
        Thu,  3 Nov 2022 03:46:28 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Thu, 03 Nov 2022 03:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667461588; x=1667547988; bh=UJ
        Z0UysFtjqjPIhOXvrXl9HpVojGVqoZMb7srL4hqgM=; b=FC+Hvo6gBuNfJFvN7t
        PepS2kfLAqKwLgZ1E8jMfgBPVrUgq2h7ZoZfLx1Fr3xjTWMwltpi5DCIBgcQtMb0
        hCfPWTE5Dxcaehj6B7AnmqSP1D6ac5WnSZOP1hg+01aTNKFoj1FVy51WaDEoNd1M
        yWgrvoUk9hWWg95tlY86MFO9cOGnC1AwgUkPpsAFl3HjMrUEla+J8IwNYlLKhbTQ
        gSCESpSg7cf2wUhMnsEzgsPwsw+NcUCBklJKrQXJjpGDlRtYwdG/sCVy7NecTG06
        oPgkHpF+CMmiWB2LtrGs+whg7LOYy3XjYIMFZRcdlz1Zk0BS8vjrVx7EjLOiIY2l
        7bzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667461588; x=1667547988; bh=UJZ0UysFtjqjPIhOXvrXl9HpVojG
        VqoZMb7srL4hqgM=; b=cvCkb37chz2XVByqN5aIh7DmQTkZ63n8jLJVAkpFhJKf
        nKS0iw65gibFD75Xu/u4ZupnHxPfRZ0oCNQwTO8r5oHXLxRrPvJt10xZ4+QnO9ra
        4zZ7//UQN7jhu0gnoaiEowAEXebyqthKOiWghcGwU94ARMEr+n5gGvrQcloKcMvf
        J16A476mIBVkSfICJSBEujTf4hFncE7OLFV0TG6yUkpmwQYYuW7eJgkMC9w42Pbj
        W6EK1/fqruup/LL+rIIZz4PsOGpncVFuTjgkV1kO4KySRnvlRKcMVzgz7cTS9Quy
        HDEk6EY9d3Ur3A27UlTPjpi2pE8TYYHNFPblleYoBQ==
X-ME-Sender: <xms:03FjY7b1CAJwEuzluTxLif4B88JXlNghnCfO2eG1MaKSB7A_FCm-mg>
    <xme:03FjY6Y-UIo2Aau6fJrpHEbbm2WcFjVhtUvcGRn14177hNBSvwZXLMc3UQu2XLaSf
    bc1GyQwGL4woAhdAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeejjeefieelgfeftdekkeef
    keffgeelteelhfehkeelgefgtddtveevudehteetgfenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:03FjY98o3Kiu4I6CSH9uilu0NoH7Ih6mkFGolflG5k3i8TCRM2Z6-w>
    <xmx:03FjYxot7QbczOxt5fdS2BWXeauqOf_ZLQ8VXESEdWvC7vBA8paBhw>
    <xmx:03FjY2pUvWU4z2LA7p-0jmUCKmvuQjFQwiMjDY0pFM_MJ0yvrvmhHQ>
    <xmx:1HFjY6oCruZq-H7sCgY9ssAM3LduTSZ-Pv_fsrM3Ec4HIMvHFnJQ8w>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C91C2A20085; Thu,  3 Nov 2022 03:46:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <f479b9cc-1301-410c-a36e-80c365964566@app.fastmail.com>
In-Reply-To: <Y2NrRt5FF+zi4Vf1@feng-clx>
References: <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <Y2D4D52h5VVa8QpE@hyeyoo> <Y2ElURkvmGD5csMc@feng-clx>
 <70002fbe-34ec-468e-af67-97e4bf97819b@app.fastmail.com>
 <Y2IJSR6NLVyVTsDY@feng-clx> <Y2IZNqpABkdxxPjv@hyeyoo>
 <Y2NrRt5FF+zi4Vf1@feng-clx>
Date:   Thu, 03 Nov 2022 07:45:49 +0000
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
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022, at 07:18, Feng Tang wrote:
> On Wed, Nov 02, 2022 at 04:16:06PM +0900, Hyeonggon Yoo wrote:
>> On Wed, Nov 02, 2022 at 02:08:09PM +0800, Feng Tang wrote:
> [...]
>> > > transfer started ......................................... transfer ok, time=2.11s
>> > > setting up elf image... OK
>> > > jumping to kernel code
>> > > zimage at:     80B842A0 810B4BC0
>> > > 
>> > > Uncompressing Linux at load address 80001000
>> > > 
>> > > Copy device tree to address  80B80EE0
>> > > 
>> > > Now, booting the kernel...
>> > > 
>> > > [    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed Nov  2 05:10:01 AEST 2022
>> > > [    0.000000] ------------[ cut here ]------------
>> > > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416 kmem_cache_alloc+0x5a4/0x5e8
>> > > [    0.000000] Modules linked in:
>> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
>> > > [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000 00000000 80889d04 80c90000
>> > > [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000 00000001 80889cb0 00000000
>> > > [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002 00000002 00000001 6d6f4320
>> > > [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328 00000000 00000000 00000000
>> > > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000 00000020 80010000 80010000
>> > > [    0.000000]         ...
>> > > [    0.000000] Call Trace:
>> > > [    0.000000] [<80008260>] show_stack+0x28/0xf0
>> > > [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
>> > > [    0.000000] [<8002e184>] __warn+0xc4/0xf8
>> > > [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
>> > > [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
>> > > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
>> > > [    0.000000] [<80928060>] prom_init+0x44/0xf0
>> > > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
>> > > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
>> > > [    0.000000] 
>> > > [    0.000000] ---[ end trace 0000000000000000 ]---
>> > > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
>> > > [    0.000000] printk: bootconsole [early0] enabled
>> > > 
>> > > Thank you for working through this with me.
>> > > I will try to address the root cause in mt7621.c.
>> > > It looks like other arch/** soc_device_register users use postcore_initcall, device_initcall,
>> > > or the ARM DT_MACHINE_START .init_machine. A quick hack to use postcore_initcall in mt7621
>> > > avoided this zero ptr kmem_cache passed to kmem_cache_alloc_lru.
>> > 
>> > If IIUC, the prom_soc_init() is only called once in kernel, can the
>> > 'soc_dev_attr' just be defined as a global data structure instead
>> > of calling kzalloc(), as its size is small only containing 7 pointers.
>> 
>> But soc_device_registers() too uses kmalloc. I think calling it
>> after slab initialization will be best solution - if that is correct.
>
> Yes, you are right, there is other kmalloc() down the call chain.
>
> Hi John,
>
> Will you verify and submit a patch for your proposal of deferring
> calling prom_soc_init()? thanks
>
> - Feng

Hi Feng,

My proposed mt7621.c changes are RFC here:
https://lore.kernel.org/lkml/20221103050538.1930758-1-git@johnthomson.fastmail.com.au/
That series lets me boot the v6.1-rc3 kernel. I have only tried it with my config (as sent earlier). If there are other suspect config settings that I should test, please let me know?
I used device_initcall, but postcore_initcall also works fine.
I rephrased Vlastimil's explanation and used it in patch 3 description.
I have not referenced a Fixes tag yet (unsure which/if any I should use)

Cheers,
-- 
  John Thomson
