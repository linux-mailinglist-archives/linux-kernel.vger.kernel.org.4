Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F016D1E37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCaKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjCaKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:39:44 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30FFAF02;
        Fri, 31 Mar 2023 03:39:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id D26A1582396;
        Fri, 31 Mar 2023 06:39:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 06:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680259148; x=1680266348; bh=K1
        dAtQ4qV7dN3w/MsrN2OU4KsjceOP96vjZ3nGCDYgU=; b=O42fuk6H00j4YO3Dp1
        BZpVEg64wioju/Pf3Ul9c+yC+JB5XdicRTWH0q9GnoWih3BlKO7ycS4VkmJtYAx2
        HF3aI4h7qS/1m7O+XBotHA3SusQ/XtmZTe1SelV31060xkaQsjLC+Rty4KZ74Yvx
        8bw7878o63919IzvR+Ca6M1vkcItes1pLEXbaY77LelS2ks3dpTKB9JhtosvgxH9
        +ApSLt608JKibSkRNbNXaPZrxR74u1HpPdHhBAqQ8bKYy43F0WIYCWltJ8d+Nxr5
        UY2/i3t/A2I5dEnDHbqWHj0QoVrr3LU/Fv2icw0kSEreyID7p3UTj+/FERmgVJXo
        hzHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680259148; x=1680266348; bh=K1dAtQ4qV7dN3
        w/MsrN2OU4KsjceOP96vjZ3nGCDYgU=; b=JPaDge685EIEGG5cDvXTC6Hf/pzvm
        2LXfWsv3Z5zkMmwE8C32B+GLYMQw2biD8Wtcsh3+gN/RW67iZNDoiLvinyHfJyhO
        1CBu2+EZ095L80TMg9jHGsuvHMeo907gHC7dt+etaH2q+etaa6eyBD94aOcj5qXE
        KheUVcYo15nCVOBu+OdUldzz7zhJUqUW6aydUu5zEsy8F+hQs0Zt8D+z64A23JIS
        Kx1XI8b4kVzknXWdtURj2kbGyM2AkyJIdJez8MQRg+Lw6+RHNdZ/0/Ax+dvk71MU
        jQs0qBDD/7PUFOzJedDaOZmFQ3hTV7UBmD3GRjqxTL6du3cOOiPJCa2Yw==
X-ME-Sender: <xms:SrgmZDsH884wdhtgFP-WjqPhyahcq2rQV1BXYxePlUUQ0yWNiCYf2A>
    <xme:SrgmZEcyU5Ls198-aW06FFsOi6L4h7Wv4sRp6jrS5FzAe2-BXtlYiEn15Eala7zKN
    NcU-l2OnHMcheIfngs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SrgmZGyKbO8ZSxRvvBCAafLKJ27r0vqF2hHifh3Kk4089lyo9A36Dg>
    <xmx:SrgmZCNkB_7TNX_44TcLX_4tkrnW4QS1tFNdVPhOlh7GN3VJkP21_Q>
    <xmx:SrgmZD_ZpLN7Em5Le5BRlYn4MFCU1FD-w7XDCxVO_-sr7cT1Rt90EA>
    <xmx:TLgmZA-CWiNDzQoNLgSC2uR0Ms9CrlheEMRimwc5o7XfZdsqiN9wmg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3FF8B6008D; Fri, 31 Mar 2023 06:39:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <a8a90181-a003-47a1-8257-fcbf55752249@app.fastmail.com>
In-Reply-To: <ZCapXlrqMOpRxkSu@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-16-arnd@kernel.org>
 <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
 <ZCapXlrqMOpRxkSu@shell.armlinux.org.uk>
Date:   Fri, 31 Mar 2023 12:38:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Vineet Gupta" <vgupta@kernel.org>,
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
Subject: Re: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches before DMA
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023, at 11:35, Russell King (Oracle) wrote:
> On Fri, Mar 31, 2023 at 10:07:28AM +0100, Russell King (Oracle) wrote:
>> On Mon, Mar 27, 2023 at 02:13:11PM +0200, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > Most ARM CPUs can have write-back caches and that require
>> > cache management to be done in the dma_sync_*_for_device()
>> > operation. This is typically done in both writeback and
>> > writethrough mode.
>> > 
>> > The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
>> > (arm920t, arm940t) implementations are the exception here,
>> > and only do the cache management after the DMA is complete,
>> > in the dma_sync_*_for_cpu() operation.
>> > 
>> > Change this for consistency with the other platforms. This
>> > should have no user visible effect.
>> 
>> NAK...
>> 
>> The reason we do cache management _after_ is to ensure that there
>> is no stale data. The kernel _has_ (at the very least in the past)
>> performed DMA to data structures that are embedded within other
>> data structures, resulting in cache lines being shared. If one of
>> those cache lines is touched while DMA is progressing, then we
>> must to cache management _after_ the DMA operation has completed.
>> Doing it before is no good.

What I'm trying to address here is the inconsistency between
implementations. If we decide that we always want to invalidate
after FROM_DEVICE, I can do that as part of the series, but then
I have to change most of the other arm implementations.

Right now, the only WT cache implementations that do the the
invalidation after the DMA are cache-v4.S (arm720 integrator and
clps711x), cache-v4wt.S (arm920/arm922 at91rm9200, clps711x,
ep93xx, omap15xx, imx1 and integrator), some sparc32 leon3 and
early xtensa.

Most architectures that have write-through caches (m68k,
microblaze) or write-back caches but no speculation (all other
armv4/armv5, hexagon, openrisc, sh, most mips, later xtensa)
only invalidate before DMA but not after.

OTOH, most machines that are actually in use today (armv6+,
powerpc, later mips, microblaze, riscv, nios2) also have to
deal with speculative accesses, so they end up having to
invalidate or flush both before and after a DMA_FROM_DEVICE
and DMA_BIDIRECTIONAL.

> It looks like the main offender of "touching cache lines shared
> with DMA" has now been resolved - that was the SCSI sense buffer,
> and was fixed some time ago:
>
> commit de25deb18016f66dcdede165d07654559bb332bc
> Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date:   Wed Jan 16 13:32:17 2008 +0900
>
> /if/ that is the one and only case, then we're probably fine, but
> having been through an era where this kind of thing was the norm
> and requests to fix it did not get great responses from subsystem
> maintainers, I just don't trust the kernel not to want to DMA to
> overlapping cache lines.

Thanks for digging that out, that is very useful. It looks like this
was around the same time as 03d70617b8a7 ("powerpc: Prevent memory
corruption due to cache invalidation of unaligned DMA buffer"), so
it may well have been related. I know we also had more recent 
problems with USB drivers trying to DMA to stack, which would 
also cause problems on non-coherent machines, but some of these were
only found after we introduced VMAP_STACK.

It would be nice to use KASAN prevent reads on cache lines that
have in-flight DMA.

     Arnd
