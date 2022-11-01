Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7B614233
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKAASy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:18:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B66340
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:18:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E4A85C00DA;
        Mon, 31 Oct 2022 20:18:46 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Mon, 31 Oct 2022 20:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667261926; x=1667348326; bh=fi
        mXTSH5ZLpHfGKWM0j4zT+1so1IP4NpiYE5OssGC/c=; b=J1pUU7BERazf1IeLBd
        jAWNGQAB2kKYNThwgOANWSBBBAbnUxGN9q8hSYqVwMI4gYFnfyN3UQzun4eLndEd
        IwCpynC7CK/cLg+QktJAiVQ8FimTS7jnB2iT8OKV5IylFxdHuZexPndnPJ9KFnZa
        ekksJw1NoKXHNH7GmqVdgNRtHQkqB04ySo8BOi3agwwS0BbxFiSo/cwubK/RuQm4
        kWW/w/WGH/yRkWTBo2WLo8vnDwxPl5N2OKH7GHTtExEI+MU8MWS4POPweskpvect
        7IhaXIBh+G0u+ERvlnQ7inrwxxKnKWBJz8G5PhTlIZjzq9UPrCUmp7WC72r3eO6+
        CdEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667261926; x=1667348326; bh=fimXTSH5ZLpHfGKWM0j4zT+1so1I
        P4NpiYE5OssGC/c=; b=Z3P5fypnqKglxy1Mw/0alIqLLvyCi1HVyzxSDnZUIyDA
        XDYW6nDULoHv3jXTEv8CHHdB5YHQX9qxPzDC/3F5WkGI9QvgTaHc3XhMfr3VNMWM
        oleabt+4AMlPllGgscypqUTZigHmVPaURtZuQBf5PCqPC5sXiZhMV40oin9+eaNx
        jAQh+fg33NfDaFtEKElq15W2vVlE/CA/1fLa32BmN2xeZeGXSpVm9L9tfLWx2Xzs
        XUTyPV09IF7ioG5c4tqrK4XOAUNPMmDT9cPRCRQUKCghaGBT6Y1ngTGyfHF5/4rI
        R9CzV04lyJR8CfR9FkHOiRQQx7NoUP3XujvTboTFGA==
X-ME-Sender: <xms:5GVgY699hbxKzHuSY6C2zB1vzbhcJfrTYBFw6zJIpB0Y4UJcVYiC2g>
    <xme:5GVgY6vZCxv6bDUxsAm6ECgsB2g9DwFjykHr9X8z2-fhtsqQewgojfFCsS2ZN0Gem
    L2S4UyW-eSGBPz8YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeggddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmh
    grihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepkeefhffguddtgeegjedtvedt
    vddvkeevvdehfeehieejhffhhfejkeejgfelveegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshesjhhohhhnthhhohhmshhonhdr
    fhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:5GVgYwConxQxZaHrkMScgBLIVSfU_n2Q3-eVscNgZ7QvjD9QPpy_Kw>
    <xmx:5GVgYyf0zV0xhlUqYS56AExooi7Go68jlav443JUV4mdOG-MOaYogw>
    <xmx:5GVgY_PCQxx2lzkC0UmAE1Q1FianhfOY5q98ekgxZsOkucT7AlWxIA>
    <xmx:5mVgY8eDrdN-eX_8gePN0WeOq5TVkwVKJcRXn_uu2i0yNWSbisKDWQ>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A370A2A20080; Mon, 31 Oct 2022 20:18:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
In-Reply-To: <Y1+0sbQ3R4DB46NX@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz> <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
Date:   Tue, 01 Nov 2022 00:18:19 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Feng Tang" <feng.tang@intel.com>
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

On Mon, 31 Oct 2022, at 11:42, Feng Tang wrote:
> On Mon, Oct 31, 2022 at 10:05:58AM +0000, John Thomson wrote:
>> On Mon, 31 Oct 2022, at 02:36, Feng Tang wrote:
>> >> > 
>> >> > possibly relevant config options:
>> >> > grep -E '(SLUB|SLAB)' .config
>> >> > # SLAB allocator options
>> >> > # CONFIG_SLAB is not set
>> >> > CONFIG_SLUB=y
>> >> > CONFIG_SLAB_MERGE_DEFAULT=y
>> >> > # CONFIG_SLAB_FREELIST_RANDOM is not set
>> >> > # CONFIG_SLAB_FREELIST_HARDENED is not set
>> >> > # CONFIG_SLUB_STATS is not set
>> >> > CONFIG_SLUB_CPU_PARTIAL=y
>> >> > # end of SLAB allocator options
>> >> > # CONFIG_SLUB_DEBUG is not set
>> >> 
>> >> Also not having CONFIG_SLUB_DEBUG enabled means most of the code the 
>> >> patch/commit touches is not even active.
>> >> Could this be some miscompile or code layout change exposing some 
>> >> different bug, hmm.
>> 
>> Yes, it could be.
>> 
>> >> Is it any different if you do enable CONFIG_SLUB_DEBUG ?
>> 
>> No change
>> 
>> >> Or change to CONFIG_SLAB? (that would be really weird if not)
>> 
>> This boots fine
>> 
>> > I haven't found any clue from the code either, and I compiled
>> > kernel with the config above and tested booting on an Alder-lake
>> > desktop and a QEMU, which boot fine.
>> >
>> > Could you provide the full kernel config and demsg (in compressed
>> > format if you think it's too big), so we can check more?
>> 
>> Attached
>> 
>> > Thanks,
>> > Feng
>> 
>> vmlinux is bigger, and entry point is larger (0x8074081c vs 0x807407dc revert vs 0x8073fcbc),
>> so that may be it? Or not?
>> revert + SLUB_DEBUG + SLUB_DEBUG_ON is bigger still, but does successfully boot.
>> vmlinux entry point is 0x8074705c
>
> Thanks for prompt info!
>
> As I can't reproduce it locally yet, could you help try 3 tests separately:
> * change the O2/O3 compile option to O1
> * try the attached 0001 patch (which cut part of commit)
> * try attached 0001+0002 patch

None of these changed my outcome.

I also tried compiling the same linux tree & config with the Bootlin toolchain
(mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0)
with the same results.
I will look into finding or building a mips clang toolchain.

No JTAG capability to debug, sorry.

I get the same outcome with either the ZBOOT vmlinuz, or vmlinux

Same happening with 6.1-rc3


After some blind poking around changing (how much of the commit affected) mm/slub.c,
I may have got lucky. it appears as though this is all I need to boot:
(against 6.1-rc3), and with the Bootlin toolchain. Will test my other build system as well.

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3276,7 +3276,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
        c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-       p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
+       p = ___slab_alloc(s, gfpflags, node, addr, c, 0);
 #ifdef CONFIG_PREEMPT_COUNT
        slub_put_cpu_ptr(s->cpu_slab);
 #endif


Would like to hear your thoughts, but I will keep digging.

>
> Thanks!
>
>
> - Feng
>
>
>
>
> Attachments:
> * 0001-reduced-slub-patch.patch
> * 0002-reorder-the-partial_context-initialization.patch

-- 
  John Thomson
