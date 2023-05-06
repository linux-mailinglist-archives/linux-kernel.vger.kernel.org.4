Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E56F905D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjEFHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjEFHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:53:30 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82AA9ED0;
        Sat,  6 May 2023 00:53:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8739E580382;
        Sat,  6 May 2023 03:53:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 06 May 2023 03:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683359606; x=1683366806; bh=qirqUm7PnGWHwQwNur2abUio9msrv//9RED
        Pco6ZlX4=; b=oUIJ95rOpDfmRIzT7ndjLdYZNMy36XDlyo33IIEnHSZ33J0jADb
        s8Wl2kVkXJ9JJL3ahFR6/tUlWgUg4T+5GlAeuQgXbA623ytSHMI6w33pgrL5gPkQ
        W8F9RgVjYAsbzO0gAELiS07CjrceJMlDMNGbnMT9Ppt63zRALUtziJnVtHYJYrC3
        a3r22nW3NOQdW6Hcx+hp4tzQSpvzL4utHV+ScKAqMXRif/hqb3qf7dOQ+j3mOiYB
        /Gww6To5Kxu+ozfU/ZCYuINBO6ysg5uyjP/XCWJL1nSywHzOgGamR8pUcOoc8zW0
        PzXXzWMa17DEz49ZSDc7azQgksBHteG3XQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683359606; x=1683366806; bh=qirqUm7PnGWHwQwNur2abUio9msrv//9RED
        Pco6ZlX4=; b=FTFVgfgd6MPCYHuvSvrDTPt1RQM4i9lYAY8vCVwWMXDobvjkv3Z
        98lyhl/R4Z82PvVH4ieQeChYq9mxrO3Tqs0Z+otZq+jWQa7lpVJmdHx3vCIv562k
        5ADJwfkwb6kvs1asZ6WGFKig2+74Ll9eG8vGoZajkWbn1RTVNMqQfOy884BWhLTb
        wyeVn3+UcWjPWKhyA06U/+/+qwSQ0waDdwo3IioSt1GthWkBHvBi5WzfTDLUwgBQ
        WNv1APC6NvhnyRkD36wa/v9PZN6oR9vyEi3DbLbtGzb4baYhlYxJ8FSQ9iQVXYTE
        oKIRXNMC90D9Vu2ER6odZWG3KS51wOQMKDA==
X-ME-Sender: <xms:cwdWZIyxfxC9bvjRyqPyh0ib1bw6Vq3YOOk7GDOHuGHr104jlhllfw>
    <xme:cwdWZMR86By_Es81Fs24nFfL6mcjYvXqEeFR5y0ciKrGphskxtRvTK7MWwtAln-3I
    9slHMOPYz1bwza1C4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cwdWZKWPJSNKGJ1BoPCjHJFB41ohvbYc5lXNMEaSpXVx65fcImDOSA>
    <xmx:cwdWZGjTC32HbA-ZJkwR9iDyfFZL5rCJIdL47Ja82EI69IRoNBcwbA>
    <xmx:cwdWZKA3HC6RuBSTtV_3Bfdw9CRHScG4KYDshiiNwwwPwz9AjH93HQ>
    <xmx:dgdWZEwIsTjJdExHIHSo4sMn188isLdlE6P98sPFv2qrASynbBpX8w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CB166B60086; Sat,  6 May 2023 03:53:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <b464c1e7-f185-46d1-8b15-9592fa0cfc25@app.fastmail.com>
In-Reply-To: <CAJF2gTSRuj3-AgynXxZeXc2vGSH8Ohn5eP2hsuKi8rTzSPLhRQ@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-10-arnd@kernel.org>
 <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
 <f460ad77-aa76-43bb-b2bb-e3b6dbcd8b03@app.fastmail.com>
 <CAJF2gTSRuj3-AgynXxZeXc2vGSH8Ohn5eP2hsuKi8rTzSPLhRQ@mail.gmail.com>
Date:   Sat, 06 May 2023 09:53:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, linux-kernel@vger.kernel.org,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Will Deacon" <will@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Brian Cain" <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional
 DMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023, at 09:25, Guo Ren wrote:
> On Fri, May 5, 2023 at 9:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> This is something we can consider. Unfortunately, this is something
>> that no architecture (except pa-risc, which has other problems)
>> does at the moment, so we'd probably need to have a proper debate
>> about this.
>>
>> We already have two conflicting ways to handle DMA_FROM_DEVICE,
>> either invalidate/invalidate, or clean/invalidate. I can see
> I vote to invalidate/invalidate.
>
...
>
>> that flush/invalidate may be a sensible option as well, but I'd
>> want to have that discussion after the series is complete, so
>> we can come to a generic solution that has the same documented
>> behavior across all architectures.
> Yes, I agree to unify them into a generic solution first. My proposal
> could be another topic in the future.

Right, I was explicitly trying to exclude that question from my
series, and left it as an architecture specific Kconfig option
based on the current behavior.

>> In particular, if we end up moving arm64 and riscv back to the
>> traditional invalidate/invalidate for DMA_FROM_DEVICE and
>> document that driver must not rely on buffers getting cleaned
> After invalidation, the cache lines are also cleaned, right? So why do
> we need to document it additionally?

I mentioned the debate in the cover letter, the full explanation
is archived at
https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/

In short, the problem that is addressed here is leaking sensitive
kernel data to user space or a device as in this sequence:

1. A DMA buffer is allocated in the kernel and contains stale data
   that is no longer needed but must not be exposed to untrusted
   userspace, i.e. encryption keys or user file pages
2. allocator uses memset() to clear out the buffer
3. buffer gets mapped into a device for DMA_FROM_DEVICE
4. writeback cache gets invalidated, uncovering the sensitive
   data by discarding the zeros
5. device returns less data than expected
6. buffer is unmapped
7. whole buffer is mapped or copied to user space

Will added his patch for arm64 to prevent this scenario by using
'clean' instead of 'invalidate' in step 4, and the same behavior
got copied to riscv but not most of the other architectures.
The dma-mapping documentation does not say anything about this
case, and an alternative approach would be to document that
device drivers must watch out for short reads in step 5, or that
kzalloc() should clean the cache in step 2. Both of these come
at a cost as well.

     Arnd
