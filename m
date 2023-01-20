Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02327675ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjATRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:05:04 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94D7495C;
        Fri, 20 Jan 2023 09:05:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5D3D33200A46;
        Fri, 20 Jan 2023 12:05:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 12:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674234300; x=
        1674320700; bh=YXir1cBKVSIl8ncpYdIhv313q6EHddedfJlIGmxdQ48=; b=j
        0K/SidyWGRubZXkXPnrsLz5CVySWPQULowlDXUz6HY1MaFN/D4LsuOcGTMy6oAOy
        9pUHEBw4fLHSEJP3rwO4DFW80gEVGwvGsFf4R1Oo+Ny8/D2ySBhbXJK89Fu89kPg
        2oJZKpmjpghLVS3RQP4p0IZqG5FGtcRXtJdFc5AvqIJIOZELmbDiQp8zohlOf3wH
        BQpy2ZcIg/NRxqJiaEjDsck0mwp6xbq4mGb7YeGnvMcDTI8+byRSDyh0aFQfkrC5
        MFwTmadSGVVhJYOpxLEUxwpXDi0gVBJaZzusUpGn6r2flXD9fcaZrdFaBWuwMzPV
        PAStBxMywbMPUrSi8F2kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674234300; x=
        1674320700; bh=YXir1cBKVSIl8ncpYdIhv313q6EHddedfJlIGmxdQ48=; b=C
        MknTjwegB1X/8av4QkyxN7bM1FGuYJSuE/HQruTFttXJzE1w4SBCy3HDpkYolOGs
        iE4FZjdZGMinnYysNs+5GRdq0b79kZ7k95UavTuRRVbknHLqyXjEE+97ZnxN4+Nm
        Kzt62o7tq+a65P9Non0UZfyHxDGs94Ye+Y+l4QK+Ard1sd1Wrp4T/QF+v8Ke2jsZ
        MuAZEL4o1beL80y3H8zaj5UbjX5Eo/fb89aYQH57tgOccVzrUno0y5Dbf17x3cyW
        /Tsis+X6GJsl35eXxyc8nwUzbgG11zPmYkVrMCptR83Sy8d3fBNZWMiAVJ2hVsYJ
        Sxz3eZWy/qup6wBeV1ugg==
X-ME-Sender: <xms:usnKY9DDWOO1TbiUwWKN4wMlTkIgSymB87bFgcCOJx-25CwJzyvdUA>
    <xme:usnKY7hbbrgWzWEtEanTgoBG1iRKRFjHfYoubEqGdQPmCIRGC8UjGT458pXS0yh7y
    -ZIsH2HmHtJXuYbmoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:usnKY4m1ZMIO0sagwSwcUAnazWKJB8-UJkAL4nxKYLIun1aaYF0Pyw>
    <xmx:usnKY3zNKa0SBYpjno7jpxY2VsRH-Q5qqvFhn5p1vjjSw9KoYJ6fpA>
    <xmx:usnKYySq_XvVHO2CFShTw8eXQd0-jbHe_iwRcO8MmLfdV0M9twZDUw>
    <xmx:vMnKY7RFLwGz9Au1jewjf4t8UD_4RhNXA7Haog3YJU4lFiwLen8sRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC226B60086; Fri, 20 Jan 2023 12:04:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com>
In-Reply-To: <20230113054807.GA23179@lst.de>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
 <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
 <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
 <20230110070144.GG10289@lst.de>
 <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
 <20230113054807.GA23179@lst.de>
Date:   Fri, 20 Jan 2023 18:04:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Tsukasa OI" <research_trasio@irq.a4lg.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023, at 06:48, Christoph Hellwig wrote:
> On Tue, Jan 10, 2023 at 04:03:06PM +0100, Arnd Bergmann wrote:
>> I looked at all the implementations now and put them in a table[1]
>> to see what the differences are. The only bit that I think needs
>> discussion is the dma_sync_single_for_device(DMA_FROM_DEVICE) op
>> that I mentioned above. I see that arm64, csky, powerpc, riscv
>> and parisc all write out at least partical cache lines first to
>> avoid losing dirty data in the part that is not written by the
>> device[2][3], while the other ones don't[4].=20
>
> I'm tempted to declare [4] buggy until proof of the inverse.

Having looked at this some more, I see that the powerpc
version is a bit problematic here as well: this one
flushes the partial cache lines before and after the
DMA transfer, while only invalidating the full
cache lines. If a partical cache line gets written
to by the CPU while the buffer is owned by the device,
this means that the received data from the device is
immediately overwritten by the second flush.

The arm64 and riscv behavior of doing a flush before
and an invalidate after the DMA seems a bit more
appropriate, as that ends up keeping the DMA
data but discarding anything written by the CPU.

Obviously there is no winning either way if the same
cache line gets written by both CPU and device, I'm
just trying to figure out what behavior we actually
want here.

The best I can think of so far is:

- flush the partial cache lines before the DMA,
  as powerpc does, and just invalidate the full
  cache lines

- only invalidate but not clean/flush after the
  DMA. This is the arm64 behavior

- warn when flushing partial cache lines
  if dma_debug is enabled.

>> I also see that at least arc, arm, mips and riscv all want
>> CPU specific cache management operations to be registered
>> at boot time. While Russell had some concerns about your
>> suggestion to generalize the arm version, we could start
>> by moving the abstracted riscv version into
>> kernel/dma/direct.c and make sure it can be shared with
>> at least mips and arc, provided that we can agree on the
>> DMA_FROM_DEVICE behavior.
>
> Yes, I'd really like to start out with a common version and then
> move bits over.  There's also some interesting bits about handling
> highmem for architectures that needs virtual addresss for flushing
> that might be worth sharing, too.
>
> Th=D1=96s should be a new file in kernel/dma/ as it's not only used by
> dma-direct but also by dma-iommu, and to keep the code nicely
> separated.
>
> Can you give it a go?

I started this at the beginning of the week but couldn't
finish it at all, but still plan to get back to it
next week.

Aside from the question for how to handle flush vs invalidate
on DMA_FROM_DEVICE, I'm still trying to figure out how to
best handle highmem with architecture specific cache management
operations. The easy approach would be to leave that up
to the architecture, passing only a physical address to
the flush function. A nicer interface might be to move the
loop over highmem pages out into common code, flush
lowmem pages by virtual addresss, and have a separate
callback for highmem pages that takes a page pointer,
like

struct dma_cache_ops {
        void (*dma_cache_wback_inv)(void *start, unsigned long sz);
        void (*dma_cache_inv)(void *start, unsigned long sz);
        void (*dma_cache_wback)(void *start, unsigned long sz);
#ifdef CONFIG_HIGHMEM
        void (*dma_cache_wback_inv_high_page)(struct page *, size_t star=
t, unsigned long sz);
        void (*dma_cache_inv_high_page)(struct page *, size_t start, uns=
igned long sz);
        void (*dma_cache_wback_high_page)(struct page *, size_t start, u=
nsigned long sz);
#endif
};

Let me know if you have a preference here, before I spend
too much time on something we don't want in the end.

     Arnd
