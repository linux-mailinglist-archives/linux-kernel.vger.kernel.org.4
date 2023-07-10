Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CD74D3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGJKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:48:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B316B5;
        Mon, 10 Jul 2023 03:48:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D224032000E5;
        Mon, 10 Jul 2023 06:48:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 10 Jul 2023 06:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688986096; x=1689072496; bh=w6ICekzr9KYZl8W9GIefXJYjQf4JFQn5qnN
        fJewCe0o=; b=nQ9QPUY7wS4rGy1GEx42RGy7zp+AksoN/jMq8WNwG0z2osUupCr
        J9FCFjCMQhZzOeMBdbAPDvJNf6/9vSEk1Xgus5bb0b6s2jl3/78ll4i1pxSDE4Md
        IyYevHeXLqId94HhwpLfGiCdlhK7u/lUft/J2an/R9HCgZMMnykcm/dksNSgfGW6
        CaqSo/8+1GO63j/tAXVF7y8g/HmJr/3vxWuDA8eD9rHYXHdGc7ccNYgCVuoVGWEu
        WG+zirxyXjMWPuyrIbW32eAIdWRO1fySvx1DAXSXhPRzlxXvW0VCqujirzS2Nsla
        K8yW1Lsd7hBXvkhVQNAmzQLqwz1zCuero5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688986096; x=1689072496; bh=w6ICekzr9KYZl8W9GIefXJYjQf4JFQn5qnN
        fJewCe0o=; b=ZkHAMHcbMSh1Cq9/wENzdf6XnZDO3hN+tF0dL4gCNTP63yq1kI7
        ouBrcHvC7ga3zHOd0hwKM9+vlgEpZ3EqXtBKXskKqQEiF+5FPhZ+OyQZdXeLmhUR
        2wt99SbCrVFp3hgR4FL02QNladiiOJzCnzctSx/DhxSNu9LHJpa86na5gZw7Zq+S
        sDebcPreC98DKlvOWyKoHyKD9qd3m6y+HlCseY9wyi51oLx8J/8R4PKygkID2UqQ
        MiC28xYtLxbENXTQK9fC7+xUSnGmaFpyh8JeB7gfeVFjWhiErmlSdV/QmNO/P+1Q
        I9ZVwrlrM1z4fjAOQfAfKwvWssXcYWJFN/w==
X-ME-Sender: <xms:7-GrZOcyM_IwsSAN3huzeuwrzzmtSq7THzuQUmQShF94vnvOcl8ocw>
    <xme:7-GrZINScqYkuBJOWHd8u0hwbLWVKha-XGzafH46_DSlQbiodUB6MWhamSxUB7MUo
    vQkIc5y1Jtbv9UaTGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7-GrZPgr8zYvmVFXmnbnMS3NtLQQtmz5-jv6lXu88VzpihAllXP1HA>
    <xmx:7-GrZL_0jbydbTZqbeybbDHudMrq1LomKnmCrTapMDCvDU2pucECtg>
    <xmx:7-GrZKuTrFBHm95YEXOfD6k2tciSw_rH1wD7vp9n-FAOXSFJuIPlXQ>
    <xmx:8OGrZFkWl6_FpcxOtWF-dHE_ALqF2KLzUta3CuKeQKEqGeFqlGkLLw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 093AE1700089; Mon, 10 Jul 2023 06:48:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com>
In-Reply-To: <0f771b11539d5a3871691af901315ee2034b577c.camel@physik.fu-berlin.de>
References: <20230706154520.11257-1-bhe@redhat.com>
 <20230706154520.11257-12-bhe@redhat.com>
 <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
 <0f771b11539d5a3871691af901315ee2034b577c.camel@physik.fu-berlin.de>
Date:   Mon, 10 Jul 2023 12:47:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Christoph Hellwig" <hch@lst.de>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Helge Deller" <deller@gmx.de>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>, linux-sh@vger.kernel.org,
        "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH v8 11/19] sh: add <asm-generic/io.h> including
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023, at 10:45, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-07-10 at 10:17 +0200, Geert Uytterhoeven wrote:
>> Thanks for your patch, which is now commit edad4470b45298ba ("sh:
>> add <asm-generic/io.h> including") in next-20230710.
>>=20
>> This break dreamcast_defconfig:
>>=20
>>   CC      arch/sh/kernel/asm-offsets.s
>> In file included from ./arch/sh/include/asm/io.h:290,
>> ./include/asm-generic/io.h:636:15: error: redefinition of =E2=80=98in=
b_p=E2=80=99
>>   636 | #define inb_p inb_p
>>       |               ^~~~~

>> > index f7938fe0f911..5ba4116b4265 100644
>> > --- a/arch/sh/include/asm/io_noioport.h
>> > +++ b/arch/sh/include/asm/io_noioport.h
>> > @@ -53,6 +53,13 @@ static inline void ioport_unmap(void __iomem *ad=
dr)
>> >  #define outw_p(x, addr)        outw((x), (addr))
>> >  #define outl_p(x, addr)        outl((x), (addr))
>> >=20
>> > +#define insb insb
>> > +#define insw insw
>> > +#define insl insl
>> > +#define outsb outsb
>> > +#define outsw outsw
>> > +#define outsl outsl

It looks like only the "noioport" variant got some of the
extra macro definitions, but the version for PCI still needs the
same six macros, plus the ones of inb/outb etc, something like
this:

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 24c560c065ec7..2135e32145c54 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -241,6 +241,26 @@ __BUILD_IOPORT_STRING(q, u64)
=20
 #endif
=20
+#define inb(addr)      inb(addr)
+#define inw(addr)      inw(addr)
+#define inl(addr)      inl(addr)
+#define outb(x, addr)  outb((x), (addr))
+#define outw(x, addr)  outw((x), (addr))
+#define outl(x, addr)  outl((x), (addr))
+
+#define inb_p(addr)    inb(addr)
+#define inw_p(addr)    inw(addr)
+#define inl_p(addr)    inl(addr)
+#define outb_p(x, addr)        outb((x), (addr))
+#define outw_p(x, addr)        outw((x), (addr))
+#define outl_p(x, addr)        outl((x), (addr))
+
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
=20
 #define IO_SPACE_LIMIT 0xffffffff
=20
diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_=
noioport.h
index 5ba4116b4265c..12dad91f41c1e 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -46,20 +46,6 @@ static inline void ioport_unmap(void __iomem *addr)
        BUG();
 }
=20
-#define inb_p(addr)    inb(addr)
-#define inw_p(addr)    inw(addr)
-#define inl_p(addr)    inl(addr)
-#define outb_p(x, addr)        outb((x), (addr))
-#define outw_p(x, addr)        outw((x), (addr))
-#define outl_p(x, addr)        outl((x), (addr))
-
-#define insb insb
-#define insw insw
-#define insl insl
-#define outsb outsb
-#define outsw outsw
-#define outsl outsl
-
 static inline void insb(unsigned long port, void *dst, unsigned long co=
unt)
 {
        BUG();

I think ideally all the I/O port stuff in arch/sh/ could just be
removed after the conversion to asm-generic/io.h, but the
microdev_ioport_map() function oddity gets in the way of that,
unless someone wants to clean up that platform. As far as I
can tell, the ethernet, display, USB and PCI devices on it already
broke at some point (afbb9d8d5266b, 46bc85872040a), so it might
be easier to remove it entirely.

> I'm not happy though that this patch is in linux-next without being Ac=
ked by me
> or being reviewed by anyone. We should always make sure first that the=
 code
> actually builds and has been tested on real hardware.

I think that if the series has been posted eight times, you had
your chance to do a review, especially since I pointed out that
merging this one would have avoid the unxlate_dev_mem_ptr() bug
as well.

Having the series go into linux-next sounds appropriate like this,
the entire purpose of that is to find such bugs and Andrew can jus
fold the fixup into the broken patch.=20

Let me know if you prefer the simple version with the extra
#defines or if we should just use the generic inb/outb implementation
immediately and drop microdev in a separate patch.

      Arnd
