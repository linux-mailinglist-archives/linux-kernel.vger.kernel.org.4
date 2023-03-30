Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E932F6D10EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjC3Vea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC3Ve2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:34:28 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790335B5;
        Thu, 30 Mar 2023 14:34:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5B925320094E;
        Thu, 30 Mar 2023 17:34:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 17:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680212063; x=1680298463; bh=hp
        uSAgqfUaqD/ysKyJQwTcBXNZjA8xYFCgAGQ8d1bL8=; b=vPTfmWAyebme5BY4p6
        J4ucGHGxrN86sr2fRjD+KS3geiZl6TYAyvsUFTPJV9vgZm+YpnhnUAfkJuQyjcZ0
        HsUAp7qWX2x1XpqS/6Avrs5R6vNIeD2d9e0BclI7l4+Xa85yS7RJ7d4zBfAPteQY
        IqSl4R+T8FOxkEJWL3lxLJOTpvEslf10gn2QFIk8BUptkGAC1qgV7vk6wPe9Et7X
        9jJquc17UpAUSDRMARTnPuIVSBD/q6atWEbNYS/Tde0YqW4Rrc97T0IXg06IROeW
        rxADsu62hJFwbM1wo85cXh3YgY7X/taN2HPLNJWSvyzj1m98x8wrioQ3DIfdaF4V
        2+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680212063; x=1680298463; bh=hpuSAgqfUaqD/
        ysKyJQwTcBXNZjA8xYFCgAGQ8d1bL8=; b=ZRndJORL0aLLZMdezjvfovMzjPjgD
        /SKaR2niKqMry7R8FNFZGjh6xUJlJtOb6rhudt5wAj1K9u1sYHvrZpeqlEDxoKFj
        CTdphfMnjq0IF2XCIbcOBtcqdVkl5LClq/oTtAv9Q5Ek04a3t4xNLzeteriILCbR
        wFgeLl4JeUAV7iqsnUT3fP1OZ96KKTukwHGEcPp2mXXWnfg6M875wmv6yXpM9OSy
        0Yx6bCmmskVhOyGFO/I5Pf+60RdcF2NNRAmXxzKR1nCNajILfNoGjY5Flxnbcdz0
        NKA2Ph3MOwJlhjfrjqwQjxoLGItm1DUYfekI3VnjvQGVBMEAu6735U2nQ==
X-ME-Sender: <xms:XwAmZHnJYWMFJmQOZtTITumy-EB4NgW6rRQXnIGt1NOfbyYHegs37w>
    <xme:XwAmZK2aJx29Qpw-cq6bhpawMaG2yq2NHtOziL7jTMDJDb85mCeqym62zH29mwsxN
    rKC1pGPxWAiawX49cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XwAmZNqhsJPQicXWZvvxtikvnPQm5OVNl49IFAyrhhZRaiF1V9y9SA>
    <xmx:XwAmZPkxehnn8E_iSkk91ZnWcfXm8zZDhRls891efa4l0d1EpjMgMA>
    <xmx:XwAmZF3BvN2SH4R7BPA2b39JA-WzPFTCtSkq0rWw-BoDi1Rm7vRXsw>
    <xmx:XwAmZE3yMMFvvLb-B40Fm_jatYudGBfd4G6AXs6SphEee8iJQan4tQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01C80B60086; Thu, 30 Mar 2023 17:34:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
In-Reply-To: <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Thu, 30 Mar 2023 23:34:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function pointers
 for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 22:42, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Currently, selecting which CMOs to use on a given platform is done using
> and ALTERNATIVE_X() macro. This was manageable when there were just two
> CMO implementations, but now that there are more and more platforms coming
> needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageable.
>
> To avoid such issues this patch switches to use of function pointers
> instead of ALTERNATIVE_X() macro for cache management (the only drawback
> being performance over the previous approach).
>
> void (*clean_range)(unsigned long addr, unsigned long size);
> void (*inv_range)(unsigned long addr, unsigned long size);
> void (*flush_range)(unsigned long addr, unsigned long size);
>
> The above function pointers are provided to be overridden for platforms
> needing CMO.
>
> Convert ZICBOM and T-HEAD CMO to use function pointers.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This is looking pretty good. There are a few things that I
still see sticking out, and I think I've mentioned some of 
them before, but don't remember if there was a reason for
doing it like this:

> +#ifdef CONFIG_ERRATA_THEAD_CMO

I would rename this to not call this an 'ERRATA' but
just make it a driver. Not important though, and there
was probably a reason you did it like this.

> +extern struct riscv_cache_ops noncoherent_cache_ops;
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops 
> *ops);
> +
> +static inline void riscv_dma_noncoherent_clean(void *vaddr, size_t 
> size)
> +{
> +	if (noncoherent_cache_ops.clean_range) {
> +		unsigned long addr = (unsigned long)vaddr;
> +
> +		noncoherent_cache_ops.clean_range(addr, size);
> +	}
> +}

The type case should not be necessary here. Instead I would 
make the callbacks use 'void *' as well, not 'unsigned long'.

It's possible that some future cache controller driver requires
passing physical addresses, as is common for last level cache,
but as long as all drivers pass virtual addresses, it's easier
to do the phys_to_virt() in common code.

It also seems wrong to have the fallback be to do nothing
when the pointer is NULL, since that cannot actually work
when a device is not cache coherent.

I would either initialize the function pointer to the
zicbom version and remove the NULL check, or keep the
pointer NULL and have an explicit
'else zicbom_clean_range()' fallback.

> +static void zicbom_register_cmo_ops(void)
> +{
> +	riscv_noncoherent_register_cache_ops(&zicbom_cmo_ops);
> +}
> +#else
> +static void zicbom_register_cmo_ops(void) {}
> +#endif

As far as I recall, the #else path here was needed previously
to work around a binutils dependency, but with the current
code, it should be possible to just always enable
CONFIG_RISCV_ISA_ZICBOM when RISCV_DMA_NONCOHERENT is used.

     Arnd
