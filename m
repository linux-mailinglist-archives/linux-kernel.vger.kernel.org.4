Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8496F83C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjEENTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjEENT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:19:26 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1E11E9BD;
        Fri,  5 May 2023 06:19:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A10F5802A0;
        Fri,  5 May 2023 09:19:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 05 May 2023 09:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683292759; x=1683299959; bh=MFewdMftG+wRD887OcQ41hQs0awPz56T0ru
        yGnj8ABI=; b=T7QiYreOPC+QycowzVZsUb+Flt5SaOjHFxAhKjqZsP+nsbKyqVd
        vQ8eowoEYwNI/GU+ISyjC+jWPEKamuy6X2bmGmXoFQmBFMRt3DPTZF7imVRis0gr
        S0EkyyDbQvtLD7pfZ4AsHyrYk42NDSyf8/wa7V9JGjoeIM+dclks9qkVsfuCYS36
        2bnobzF6Lg7r4sP9JfGrvCZy6bK7TL5qDUup6dDDozkhtlDKoL2JENn8cqmA5ZJ5
        wLu4/Si0kCVvWmQxVaYqYa+bPXXPogECh5ZRpy0s2bQVgjpqCgavDgb5K4Sf79fl
        Z2ACYtb7nNPJlBQY7RKS+i0yrfAvSYbn6sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683292759; x=1683299959; bh=MFewdMftG+wRD887OcQ41hQs0awPz56T0ru
        yGnj8ABI=; b=FVvu2kHfPB+goofUSO7GBQXw9iAuEK1luvy6mN9DIT3CnY67Gls
        0KZVLaa6ELu1958ejxqPitibsxtjnQdtVNl7Z4DIo/7t6vSCqKnMSbKFtiZxUfg8
        SuTynEk2oMcUtF9nJJbJg0GYURVCU7bPEPfG8kEUYCku0K859h+BHBVlobnzbNVb
        9jCOuQHGR9JdwHKNFMPcOBCnbMbqE970CGlmaHJPbDGFzyO5if6gbd+OUkaHxy+L
        frNzAleO1fKFLe9X7xNq2nNbq2hrGATg6TTB1yBWoA0Wjb4XH3SHavwUomASSa1B
        aF2LKjYsYglP/xYL6ASj4zNf9qShE/HNiUg==
X-ME-Sender: <xms:UwJVZOh9cnZIXMM77LhNvXoz2YNii-arffCBI32Pq_fv4QfUTdVISg>
    <xme:UwJVZPAntNX3cn4OGLtqo2LRLlqkpl7Dvxks5UPOgyYyhnzhUynPY4VJ3y3azSULF
    _Z-HMCpBmE7SFSlVlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UwJVZGH5NsIuOroPMeDuiba-Tn1p718Jzhmp9sTCmS-1lOWUaiFtVQ>
    <xmx:UwJVZHTAxF0WKn8MsTwRzrxqsy1jTv31MgcN7ZNnDyiETst0t2wtOQ>
    <xmx:UwJVZLzt4fDtGxTef6RbmcqquDaW2xXV0M3lt4aM-O0fppZufkssOQ>
    <xmx:VwJVZHhc7KCJPgnStXUQtZd0bp63LSI-wEqxVbh0vya0G4fcoSCVFw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 110CDB60089; Fri,  5 May 2023 09:19:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <f460ad77-aa76-43bb-b2bb-e3b6dbcd8b03@app.fastmail.com>
In-Reply-To: <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-10-arnd@kernel.org>
 <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
Date:   Fri, 05 May 2023 15:18:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, "Vineet Gupta" <vgupta@kernel.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023, at 07:47, Guo Ren wrote:
> On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:

>>
>> riscv also invalidates the caches before the transfer, which does
>> not appear to serve any purpose.
> Yes, we can't guarantee the CPU pre-load cache lines randomly during
> dma working.
>
> But I've two purposes to keep invalidates before dma transfer:
>  - We clearly tell the CPU these cache lines are invalid. The caching
> algorithm would use these invalid slots first instead of replacing
> valid ones.
>  - Invalidating is very cheap. Actually, flush and clean have the same
> performance in our machine.

The main purpose of the series was to get consistent behavior on
all machines, so I really don't want a custom optimization on
one architecture. You make a good point about cacheline reuse
after invalidation, but if we do that, I'd suggest doing this
across all architectures.

> So, how about:
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-nonco=
herent.c
> index d919efab6eba..2c52fbc15064 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, siz=
e_t size,
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_FROM_DEVICE:
> -               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> -               break;
>         case DMA_BIDIRECTIONAL:
>                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
>                 break;

This is something we can consider. Unfortunately, this is something
that no architecture (except pa-risc, which has other problems)
does at the moment, so we'd probably need to have a proper debate
about this.

We already have two conflicting ways to handle DMA_FROM_DEVICE,
either invalidate/invalidate, or clean/invalidate. I can see
that flush/invalidate may be a sensible option as well, but I'd
want to have that discussion after the series is complete, so
we can come to a generic solution that has the same documented
behavior across all architectures.

In particular, if we end up moving arm64 and riscv back to the
traditional invalidate/invalidate for DMA_FROM_DEVICE and
document that driver must not rely on buffers getting cleaned
before a partial DMA_FROM_DEVICE, the question between clean
or flush becomes moot as well.

> @@ -42,7 +40,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t=
 size,
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
>                 /* I'm not sure all drivers have guaranteed cacheline
> alignment. If not, this inval would cause problems */
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>                 break;

This is my original patch, and I would not mix it with the other
change. The problem with non-aligned DMA_BIDIRECTIONAL buffers in
is that both flush and inval would be wrong if you get simultaneous
writes from device and cpu to the same cache line, so there is
no way to win this. Using inval instead of flush would at least
work if the CPU data in the cacheline is read-only from the CPU,
so that seems better than something that is always wrong.

The documented API is that sharing the cache line is not allowed
at all, so anything that would observe a difference between the
two is also a bug. One idea that we have considered already is
that we could overwrite the unused bits of the cacheline with
poison values and/or mark them as invalid using KASAN for debugging
purposes, to find drivers that already violate this.

      Arnd
