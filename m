Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A7660986
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjAFWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjAFWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:31:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E308462F;
        Fri,  6 Jan 2023 14:31:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C62E5C00C1;
        Fri,  6 Jan 2023 17:31:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 06 Jan 2023 17:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673044315; x=1673130715; bh=ZsG681Pan5
        CKaukkBdKOCNuqBF9WuoTwPInsMRA5Jvw=; b=b/o6dQThSZfMkHb++Pw/ySr5UY
        FihsdtJLv5QO3McakdeePVZ5f3Y2PFrSplcpbKL21hz75paeL24g/0EUQyVfMkK4
        CNUEUfb0BbVSQIMNBCHJFYh3U8ypcaU+KNBa1ozUEufvqM0VYxYYjzL7lFZxONeu
        3RxwQIbX4AXlQzjDeAJoA0U1/fuUhsz0CkG8nk6aJz6b7/HOhwbF4seYSRCt1dWN
        CPTIrQtSWEQecX265bLmKb/RPYTOAt7nmKHujVJQ6A6sIWt55iBm3vO2izZesbB4
        x95e8d5rgixkFsfc0F4oqQifPzAFuSqRbWKLcnYXDljKbcai/Fvrd/uQ6Oog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1673044315; x=1673130715; bh=ZsG681Pan5CKaukkBdKOCNuqBF9W
        uoTwPInsMRA5Jvw=; b=mUHHxCzISNevnvH8fxu8sc3D8JiLLOuy/eEBP0aCi6Z0
        eRymmdb8U8JSgIwEsrRQBu5U2LI5KP4saU4p9owK3ht0fI4zsgVyjqrrmiq5Ub8W
        rAx+1XhKjeGsI2RBltZOTUU+IS8+WdEpn8j/d2R1rcSwLjIQNUoE+OR9QY0KiYuT
        4ayMJRu63wh1T4T8gTlpBa6S4Zw3uvlvCeUpPqdKStagu/L/YWYPzLb+hn9r9fAp
        LdcuEoO0BvEMQsNZt1sBhXqD9aW8OBqRF/7EgYNGsq6cIrqFOAeuEzDOfOGj4bWu
        mETFBe9r5vCMupzA4DCP8uxArjwTHErdCWbLVZ7Vww==
X-ME-Sender: <xms:WaG4Y9V9PQXuMFurLC7c41ANehK0zZYj4cpF5gbjghZh8nkWiA673Q>
    <xme:WaG4Y9kNjng-xexKO6heNRz_m50Do5eElpWHyT6dAEVwGhb0l3740UcLAVyspbRx1
    yD3I8TNKHXM1cZTb_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WaG4Y5YzWd6ytsHB_sc4enACKmwhc8s86nM8CIsAsWlZctD_M-HZAQ>
    <xmx:WaG4YwUnf7dDBa06LpaPrwlmfBRscwuwk0qsbKJhsHEaeeU2f21obw>
    <xmx:WaG4Y3nfEela3IuWRIhYmy1zHq2HxNvuM9NYcWZvpOU0SzKUG-nhfA>
    <xmx:W6G4Y2fNtd-xoHAG7l9h7BngwooX8kNJWp4HHWzGR4Z_yh76HAicfg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01B77B60086; Fri,  6 Jan 2023 17:31:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
In-Reply-To: <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Fri, 06 Jan 2023 23:31:33 +0100
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
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Tsukasa OI" <research_trasio@irq.a4lg.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023, at 19:55, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The current implementation of CMO was handled using the ALTERNATIVE_X()
> macro; this was manageable when there were a limited number of platforms
> using this. Now that we are having more and more platforms coming through
> with the CMO the use of the ALTERNATIVE_X() macro becomes unmanageable.
>
> To avoid such issues this patch switches to use of function pointers
> instead of ALTERNATIVE_X() macro for cache management (the only draw being
> performance over the previous approach).
>
> void (*clean_range)(unsigned long addr, unsigned long size);
> void (*inv_range)(unsigned long addr, unsigned long size);
> void (*flush_range)(unsigned long addr, unsigned long size);
>
> The above function pointers are provided to be overridden where platforms
> using standard approach and for platforms who want handle the operation
> based on the operation the below function pointer is provided:
>
> void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
>                                       enum dma_data_direction dir,
>                                       enum dma_noncoherent_ops ops);
>
> In the current patch we have moved the ZICBOM and T-Head CMO to use
> function pointers.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This looks like a nice improvement! I have a few suggestions
for improvements, but no objections here.

> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index fac5742d1c1e..826b2ba3e61e 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
...
> @@ -44,6 +106,15 @@ static bool errata_probe_cmo(unsigned int stage,
> 
>  	riscv_cbom_block_size = L1_CACHE_BYTES;
>  	riscv_noncoherent_supported();
> +
> +	memset(&thead_cmo_ops, 0x0, sizeof(thead_cmo_ops));
> +	if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO)) {
> +		thead_cmo_ops.clean_range = &thead_cmo_clean_range;
> +		thead_cmo_ops.inv_range = &thead_cmo_inval_range;
> +		thead_cmo_ops.flush_range = &thead_cmo_flush_range;
> +		riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
> +	}

The implementation here looks reasonable, just wonder whether
the classification as an 'errata' makes sense. I would probably
consider this a 'driver' at this point, but that's just
a question of personal preference.

For the operations structure, I think a 'static const struct
riscv_cache_ops' is more intuitive than assigning the
members individually.
> +
> +enum dma_noncoherent_ops {
> +	NON_COHERENT_SYNC_DMA_FOR_DEVICE = 0,
> +	NON_COHERENT_SYNC_DMA_FOR_CPU,
> +	NON_COHERENT_DMA_PREP,
> +	NON_COHERENT_DMA_PMEM,
> +};
> +
> +/*
> + * struct riscv_cache_ops - Structure for CMO function pointers
> + * @clean_range: Function pointer for clean cache
> + * @inv_range: Function pointer for invalidate cache
> + * @flush_range: Function pointer for flushing the cache
> + * @riscv_dma_noncoherent_cmo_ops: Function pointer for platforms who 
> want
> + *  to handle CMO themselves. If this function pointer is set rest of 
> the
> + *  function pointers will be NULL.
> + */
> +struct riscv_cache_ops {
> +	void (*clean_range)(unsigned long addr, unsigned long size);
> +	void (*inv_range)(unsigned long addr, unsigned long size);
> +	void (*flush_range)(unsigned long addr, unsigned long size);
> +	void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
> +					      enum dma_data_direction dir,
> +					      enum dma_noncoherent_ops ops);
> +};

I don't quite see how the fourth operation is used here.
Are there cache controllers that need something beyond
clean/inv/flush?

> +
> +#else
> +
> +static void riscv_noncoherent_register_cache_ops(struct 
> riscv_cache_ops *ops) {}
> +
> +static inline void riscv_dma_noncoherent_clean(void *vaddr, size_t 
> size) {}
> +
> +static inline void riscv_dma_noncoherent_flush(void *vaddr, size_t 
> size) {}
> +
> +static inline void riscv_dma_noncoherent_inval(void *vaddr, size_t 
> size) {}

I think you can drop the #else path here: if there is no
noncoherent DMA, then nothing should ever call these
functions, right?

> +
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
...
> +struct riscv_cache_ops zicbom_cmo_ops = {
> +	.clean_range = &zicbom_cmo_clean_range,
> +	.inv_range = &zicbom_cmo_inval_range,
> +	.flush_range = &zicbom_cmo_flush_range,
> +};
> +#else
> +struct riscv_cache_ops zicbom_cmo_ops = {
> +	.clean_range = NULL,
> +	.inv_range = NULL,
> +	.flush_range = NULL,
> +	.riscv_dma_noncoherent_cmo_ops = NULL,
> +};
> +#endif
> +EXPORT_SYMBOL(zicbom_cmo_ops);

Same here: If the ZICBOM ISA is disabled, nothing should
reference zicbom_cmo_ops. Also, since ZICBOM is a standard
extension, I think it makes sense to always have it enabled,
at least whenever noncoherent DMA is supported, that way
it can be the default that gets used in the absence of any
nonstandard cache controller.

   Arnd
