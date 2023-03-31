Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9436D2690
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCaRUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjCaRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:20:42 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A4B474;
        Fri, 31 Mar 2023 10:20:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id ED12F5825B1;
        Fri, 31 Mar 2023 13:20:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 13:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680283237; x=1680290437; bh=Io
        6Y2nZvpWRrWXAKol5WpEbEU7vs4k1dMfq+xXU6ebw=; b=NzNnOxCFwRCxKTIhBp
        UkTdA1QrJ0VBJBAssHPYnFLTEc20QImZBr+yhF1WHFOwiVQ/TkKmYOFyeYEr7/8r
        GD1FXZ+DOdP4irwH+qJns8z0e3B/ONHZgjzpSHCzaPaMhJFZzUPm3TK2xUS0BQlh
        V9VtSyul+J/OV+r3iY3+NHZkA/eHv3BHVJqTGYmRGB+AKO62xQhh3c/bffk1QrCL
        4R0Dy4NdEfwvXMfOXe9abUeXxvUMNzrGZC+L2sJKtKN5Y24hiaazrc9fhLwyYNrz
        RuUulKg1j4ExMX9feY2TsdjGjqZMe6J9bcUYIHHFkMRYqyDd5msKT4MskvSGpcAG
        21NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680283237; x=1680290437; bh=Io6Y2nZvpWRrW
        XAKol5WpEbEU7vs4k1dMfq+xXU6ebw=; b=U+cgwONxidqWgKBVF4Cwme9zOzYI2
        GHfNWmF7faOn2hpYWAXr9uCaB+kRfx8x+If9o7AiJRQdXmZzrLTIx+01XlSobpGj
        tx/B80EyyvLzhr0jS+WvKCsZENulYL7m5wPMUTdJb7/jnKnzVYJe9r53sFvFdoUS
        ORJ0wKGqlFZ/gnR1aDkea3h9mr+spOIyBw2wQ5ta5IE5aJ2ENRQn77Ui1q5LYroG
        Ey/jSpqL6OllDKNAU05Fmyz8Di7Du486u0d4ZaTD/TXHw+8DPr0T0wqs2W1r3ODK
        XNS0I4c5ax7vZ0LR3yLyhzXIyKPFJT8esJCNqFzAmfFa35y/YQvJUZmdw==
X-ME-Sender: <xms:YxYnZFHZks67OPDKgqM3qNN1TrlveZNOuQOJuwJ7nkUmBpfYrB4jOA>
    <xme:YxYnZKVpZ8DtZm9lpeqkdhWozXvOOYyLLHmXUbWyTH7ZHAbHnlhCIWBJyqSHtQL49
    neyAs4_hbX1694_koU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YxYnZHKRbkbB-44_TpVFkjPVaYYSIMc47ok1I9ZYEBlajcxJz7OEbg>
    <xmx:YxYnZLHFu4lfS71F1yqzdUx9_eqZeQ-f2fZ0nfGecguxlfzUs5YbfQ>
    <xmx:YxYnZLX2_1EWxKGOoANqHtihIaHICg9c9O-TrgOS4Ld0OigXHrR5FQ>
    <xmx:ZRYnZO0TSJVIJiVIXYibXzBAOoD0hgjOerlHiYWlfC4-7fTTbUhOEQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AD8E3B60092; Fri, 31 Mar 2023 13:20:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <f32d19da-8f33-4707-8be2-65dc060f4a78@app.fastmail.com>
In-Reply-To: <cc3a78b6-b126-226f-b41a-061716aacd15@arm.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
 <cb9367fb-0897-244d-15b6-fdfafde2a1c0@arm.com>
 <df6340c8-6ac2-4459-a9e5-c411020962d6@app.fastmail.com>
 <cc3a78b6-b126-226f-b41a-061716aacd15@arm.com>
Date:   Fri, 31 Mar 2023 19:20:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
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
        "Christoph Hellwig" <hch@lst.de>,
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
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean() helper
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023, at 17:12, Robin Murphy wrote:
> On 31/03/2023 3:00 pm, Arnd Bergmann wrote:
>> On Mon, Mar 27, 2023, at 14:48, Robin Murphy wrote:
>> 
>> To be on the safe side, I'd have to pass a flag into
>> arch_dma_mark_clean() about coherency, to let the arm
>> implementation still require the extra dcache flush
>> for coherent DMA, while ia64 can ignore that flag.
>
> Coherent DMA on Arm is assumed to be inner-shareable, so a coherent DMA 
> write should be pretty much equivalent to a coherent write by another 
> CPU (or indeed the local CPU itself) - nothing says that it *couldn't* 
> dirty a line in a data cache above the level of unification, so in 
> general the assumption must be that, yes, if coherent DMA is writing 
> data intended to be executable, then it's going to want a Dcache clean 
> to PoU and an Icache invalidate to PoU before trying to execute it. By 
> comparison, a non-coherent DMA transfer will inherently have to 
> invalidate the Dcache all the way to PoC in its dma_unmap, thus cannot 
> leave dirty data above the PoU, so only the Icache maintenance is 
> required in the executable case.

Ok, makes sense. I've already started reworking my patch for it.

> (FWIW I believe the Armv8 IDC/DIC features can safely be considered 
> irrelevant to 32-bit kernels)
>
> I don't know a great deal about IA-64, but it appears to be using its 
> PG_arch_1 flag in a subtly different manner to Arm, namely to optimise 
> out the *Icache* maintenance. So if anything, it seems IA-64 is the 
> weirdo here (who'd have guessed?) where DMA manages to be *more* 
> coherent than the CPUs themselves :)

I checked this in the ia64 manual, and as far as I can tell, it originally
only had one cacheflush instruction that flushes the dcache and invalidates
the icache at the same time. So flush_icache_range() actually does
both and flush_dcache_page() instead just marks the page as dirty to
ensure flush_icache_range() does not get skipped after a writing a
page from the kernel.

On later Itaniums, there is apparently a separate icache flush
instruction that gets used in flush_icache_range(), but that
still works for the DMA case that is allowed to skip the flush.

> This is all now making me think we need some careful consideration of 
> whether the benefits of consolidating code outweigh the confusion of 
> conflating multiple different meanings of "clean" together...

The difference in usage of PG_dcache_clean/PG_dcache_dirty/PG_arch_1
across architectures is certainly big enough that we can't just
define a a common arch_dma_mark_clean() across architectures, but
I think the idea of having a common entry point for
arch_dma_mark_clean() to be called from the dma-mapping code
to do something architecture specific after a DMA is clean still
makes sense, 

     Arnd
