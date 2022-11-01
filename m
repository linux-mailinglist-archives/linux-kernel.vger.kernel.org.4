Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB49614687
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKAJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:21:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293D183A8;
        Tue,  1 Nov 2022 02:21:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E8A4A32006F5;
        Tue,  1 Nov 2022 05:21:29 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Tue, 01 Nov 2022 05:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667294489; x=1667380889; bh=Dm
        Xcbh9DqaxTidfPEVRhGG+9ZolCRC1Se1Rd95/vqz4=; b=bmvYswt1B92Yx+FDX7
        KL4ZPZ9jIPcqU6eco2cO4QR6U4FlgIIRCKCqm6sECof4qGhQh3+eEaL1gpcf4rir
        rBk0JncdKtJqeRBglxBUM4xku0NsHymB6uNOknsHMMTGQ5VpSv9aZc9FtSaws5sB
        r0i+BdDjQMGSPhJHU1AdO0UkDHZ75YORfxo6YtikYIaf3FvlfcT71H9BwgbxqKs6
        TiHPyLthYSqh4VNFMv8pTO2UJKQFLBPQMc9uy8SovzYLKUC6GQy6xEi1p9gYVDdK
        70+7lKiJu5u9DZGJKh8dEDJH47nMtrAjrS6xBDH6Pf3jVnMKUyQaRUQ90IbURjlP
        2zNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667294489; x=1667380889; bh=DmXcbh9DqaxTidfPEVRhGG+9ZolC
        RC1Se1Rd95/vqz4=; b=NWQ36jlqzp1+xxohT0ZSzXSPkWWA/eeyBpQtz29TEitj
        B2zEw4SWePIpohw4WCV0SGREYDHKe9AkUgJrv6tUIAQkBRf5SRpF2CMS6v6pnaMJ
        i7kK8W4ekPTPuixPnEAFAox5ZbLjIVzukyGPWZEbOocOOrTBSWZbINn8oHUhD/rR
        SSFZllolzcpAalF/ncFf8iiSuYVHnpG4n087do3IL1fYwFwGTf3nxNKLR76DD3Iz
        pLtayC80y39K4dV7Ma0XWSKAG0polbUqv/CzEIxox1uyIADEfJmpCxKRtx9Vhbck
        992rWY44IjHLWJr7ge4Q3WFOvBCmPOKUy8DlqtB9pA==
X-ME-Sender: <xms:F-VgYzUOYmWCzfhs9Y8mafW1xiYw3z3zlw0Yg1cpMpLWHEbFHn0R2A>
    <xme:F-VgY7nGVZp9MdbhwGh3T7gC-q7F-Z8X80u-6R267VcCfvEkTUOnzwsxa5OFTdUcC
    wK_E9mEvEXT8P-Lsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmh
    grihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepjeejfeeilefgfedtkeekfeek
    ffegleetlefhheekleeggfdttdevveduheettefgnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:F-VgY_Yq_F4ld2wYsxpZkKbbvA8uCOSdLsMeaoaAijpuCS4_0AEPIQ>
    <xmx:F-VgY-W6ojN479ExDsA5xCkJtX3gwATcRzH4ftYW8UrnOoLGF30Yuw>
    <xmx:F-VgY9kVk02sOLPiLYKNuYIU-gw80TJ70Cg8I-uupaVumhV43og5eQ>
    <xmx:GeVgY8fHMBPdSwWodz6CdXqbUOVIcUiXxClLzUJDmuWLwMBUPgWtZw>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B42052A20080; Tue,  1 Nov 2022 05:21:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
In-Reply-To: <Y2DReuPHZungAGsU@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz> <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
 <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
Date:   Tue, 01 Nov 2022 09:20:21 +0000
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

On Tue, 1 Nov 2022, at 07:57, Feng Tang wrote:
> Hi Thomson,
>
> Thanks for testing!
>
> + mips maintainer and mail list. The original report is here
>
> https://lore.kernel.org/lkml/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/



I am guessing my issue comes from __kmem_cache_alloc_lru accessing s->object_size when (kmem_cache) s is NULL?
If that is the case, this change is not to blame, it only exposes the issue?

I get the following dmesg (note very early NULL kmem_cache) with the below change atop v6.1-rc3:

transfer started ......................................... transfer ok, time=2.02s
setting up elf image... OK
jumping to kernel code
zimage at:     80B842A0 810B4EFC

Uncompressing Linux at load address 80001000

Copy device tree to address  80B80EE0

Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john) (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #61 SMP Tue Nov  1 18:04:13 AEST 2022
[    0.000000] slub: kmem_cache_alloc called with kmem_cache: 0x0
[    0.000000] slub: __kmem_cache_alloc_lru called with kmem_cache: 0x0
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0001992f (MIPS 1004Kc)
[    0.000000] MIPS: machine is MikroTik RouterBOARD 760iGS

normal boot


diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..10fcdf2520d2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3410,7 +3410,13 @@ static __always_inline
 void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			     gfp_t gfpflags)
 {
-	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
+	void *ret;
+	if (IS_ERR_OR_NULL(s)) {
+		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
+		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, 0);
+	} else {
+		ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
+	}
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
@@ -3419,6 +3425,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
+	if (IS_ERR_OR_NULL(s))
+		pr_warn("slub: kmem_cache_alloc called with kmem_cache: %pSR\n", s);
 	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
@@ -3426,6 +3434,8 @@ EXPORT_SYMBOL(kmem_cache_alloc);
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
+	if (IS_ERR_OR_NULL(s))
+		pr_warn("slub: __kmem_cache_alloc_lru called with kmem_cache: %pSR\n", s);
 	return __kmem_cache_alloc_lru(s, lru, gfpflags);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);


Any hints on where kmem_cache_alloc would be being called from this early?
I will start looking from /init/main.c around pr_notice("%s", linux_banner);

Thank you for your help.

Let me know if you want me to stop replying to this mm/slub debug memory wasting email,
and take this to a new email?

Cheers,
-- 
  John Thomson
