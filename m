Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8E6D220B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjCaOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:07:02 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348D12BEC;
        Fri, 31 Mar 2023 07:07:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9922258268E;
        Fri, 31 Mar 2023 10:07:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 10:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680271620; x=1680278820; bh=+r
        gNhiMMjEW6BpggDCxFKA75rbxQmdy0+ukYIJ3bDgk=; b=Pc8kv25VKXGtVL8XCr
        3j3OyLGuWT6fYZF4NiwCRSt2tF6Fvv+TvuB3E6vCgJxcx8jtprcWN7JhJIb5bFg2
        QjX2dTkxS7vu8lEIMWBWsDYl97OCtsdbMeLBYqYod6LmrQLwz6X9dnEM2DC3RbsF
        l+ZrPpgYIJwpYnZsWOD+D8D4vZfa7BzCpk20Wm+5tpjxuWKtCea7CNOxLGjwN0Kf
        tlV2osHlUJtCPxStVVsWCouRtYd6oC6yvc/82UQkegFPtfh4i+a9vmrPlD8S2nco
        JEOtyi3Nvv+b2bMF5uVMQVu4rR5BYDFXTTi+56wXtT9zHrrAZPk25XyVk4fpD22v
        vd9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680271620; x=1680278820; bh=+rgNhiMMjEW6B
        pggDCxFKA75rbxQmdy0+ukYIJ3bDgk=; b=ThX+0gPluUf21axDbewoG8ZUb9ZCI
        i0OKuY8x6SHo5JLyVpBW3rfjzSmDSVxilv/zSCMWNE0tgR8m2qZm4mnm4gkcNxqW
        89SKN3kk2vmevNs9sy5Kin7GMD4yD/ekmbdf34GqKCe/l/8lxcLL+vnuWz2lChpu
        3Zo8zTUwiUedMCRG088mBVfUHI7lup/3rDF5eNQz44ieRjCxaj4W8DPGoIIHa2BK
        9H7CKIM4HDqOkN7mS+DGINLbPX/RDhPjOasY3gx1JgWz7gfW05X4V3TRJlnwK7zt
        CFRZet/VpBWg0mniTU4O4BNc6kUxm9MTbMy8MEEXngy5TEIuOKVwamwPw==
X-ME-Sender: <xms:A-kmZN-NQK8nhMUyRf5ekRpQt0SQLm794OnAliR37Fz0V0Y8EubhUw>
    <xme:A-kmZBvefBGt64uw2QC6BFb3pDKvRP2O2N2W7bHCv7CCsaZwEMxJX6w17qlRvc42h
    tCPMuFp7jIPctCc6j0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:A-kmZLAr-8NrhylOVBIyMvPHI_UWEvFUIf9K_uEA1HijTRWrHwB1pA>
    <xmx:A-kmZBcmVUZ5C14t-tmZlAihuZ8BKuZ2UIRi3q9MCBvTIumo_qQHsg>
    <xmx:A-kmZCOm8b2LG_LernyD1ipDqx2PMx3LjSdvpU7uuZXZS7AUbOvhIA>
    <xmx:BOkmZOPEbwROHyknFwRDsQrWLZqsYSuvISFZMaO-MvqpTgjoh6bLGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0E1DB60092; Fri, 31 Mar 2023 10:06:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <1be05746-9deb-49cb-b106-71b2db8318cd@app.fastmail.com>
In-Reply-To: <ZCGv18wnEtoFvtfM@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
 <ZCGv18wnEtoFvtfM@shell.armlinux.org.uk>
Date:   Fri, 31 Mar 2023 16:06:37 +0200
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
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean() helper
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023, at 17:01, Russell King (Oracle) wrote:
> On Mon, Mar 27, 2023 at 02:13:16PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
>> PG_dcache_clean after a DMA, but no other architecture does this here.
>
> ... because this is an arm32 specific feature. Generically, it's
> PG_arch_1, which is a page flag free for architecture use. On arm32
> we decided to use this to mark whether we can skip dcache writebacks
> when establishing a PTE - and thus it was decided to call it
> PG_dcache_clean to reflect how arm32 decided to use that bit.
>
> This isn't just a DMA thing, there are other places that we update
> the bit, such as flush_dcache_page() and copy_user_highpage().
>
> So thinking that the arm32 PG_dcache_clean is something for DMA is
> actually wrong.
>
> Other architectures are free to do their own other optimisations
> using that bit, and their implementations may be DMA-centric.

The flag is used the same way on most architectures, though some
use the opposite polarity and call it PG_dcache_dirty. The only
other architecture that uses it for DMA is ia64, with the difference
being that this also marks the page as clean even for coherent
DMA, not just when doing a flush as part of noncoherent DMA.

Based on Robin's reply it sounds that this is not a valid assumption
on Arm, if a coherent DMA can target a dirty dcache line without
cleaning it.

     Arnd
