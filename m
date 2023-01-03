Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EDC65C52D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjACRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbjACRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:39:01 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0FEE35;
        Tue,  3 Jan 2023 09:39:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F2C05C00BA;
        Tue,  3 Jan 2023 12:38:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Jan 2023 12:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672767539; x=
        1672853939; bh=AL41jm0bguHLbqwrfAY4uxQqONM6OmyCgIZjUnM7MhM=; b=d
        WUZ0AB08T6h79Dkaxh4cGAeJG2slCfBS89ihY8HncRtwJkRdYHoo/soj6xIGodFB
        TmQUJLh33qJjWqbBt9Z9mRaEYUDU4J5zOXTD7HN2b3qpVz1HiECN39Yey+AIHWOG
        aaghK+DJnB9Ar0M7Lp5Q8SZ549NnM4Co8r5dlbh+JUtBn9O6xW+LP6yLz/m/gkGL
        qj/7ZFV492XVqNn3V8CzApVihQZjHxBT676v0pczf2Q4kQRVFA+pk5genOI6fB10
        5NhvorWjCvX6jIlMjTeskOvPooD5A35vFnAj1Xo4jBYNrIlmz9umeEgmumxERDlM
        ejhcXIEYRQFrw1cieHKPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672767539; x=
        1672853939; bh=AL41jm0bguHLbqwrfAY4uxQqONM6OmyCgIZjUnM7MhM=; b=L
        vzS2C0SkocKeU/XbJN8x6KO5vIwGnw1b6jThBhExLaAKeRYPBMyNZMck1mQ9pw6Q
        7t8I0fOTNt4cdswGBYik7H/Cq0bPtkeFMpc+7BWBB71ElBZD8m7FZAwsdRO3P7VP
        vbW1ETXOVderwqBbjBf+pFwZDnh8+KYG9dHCNtGomAPEpkwyBXAdEeGov4jieHeo
        DmUB+NnkPIc7Eazgg7Y3JPxZM0Hpb9IdAPoe6D96OeniJpDfiyC5GuHhANuVUNcY
        SU7NLqVfnZb9RDXnIIwYou28WZJkJO41/lHzSTSthEbuTUY9+3bdst4B0ggM6aV9
        gnXD8NObBkso6AkFNGUsA==
X-ME-Sender: <xms:Mmi0Yy2DCzQ5foQDze7omumT1bouPZXNpDmiNQuKD0lRdRhVO9YYqw>
    <xme:Mmi0Y1FkM7xCJwra159l-QxlutI2OXCL3WGNVj8XsmdJJEiB-GteP_jdb-a4GQpdq
    niICcU11FGUnNKN0Q>
X-ME-Received: <xmr:Mmi0Y67UDv4UnB8dvhJqCjMUxmDkxkYuSoMODz_CcWCGgTcDbl2FG0Dqa2DKZkksLMPD_PCLN-LkFWFJUjbE2sqJxwdiFfog8W0EUvqTjPFzsuttb6709rUWrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduhffffefhffduudetvdffkeetveeiueegfeelleffiedtuddt
    ffduhefgtdefgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:Mmi0Yz1OsLjfm_IkpncCnLTdTU5zX_3ETiF2zrokr6Hae927X9TUDg>
    <xmx:Mmi0Y1Hi20uqFRepiCYMU38DV3bRWqMsVxZCtYZxOccqKEaqceB0mw>
    <xmx:Mmi0Y8--hju2a4AyxXA1z_3xjha49esfvTrRUJ6Oe62trjaPgsi6-w>
    <xmx:M2i0Y0B4GbZOV4tICJ2STc5iL9V8bOOpiVrvUoj6iXG_YUdAIKx0BQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jan 2023 12:38:57 -0500 (EST)
Message-ID: <6c8b40e5-7543-c86a-e3f1-f9df12e3745c@sholland.org>
Date:   Tue, 3 Jan 2023 11:38:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 16:46, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Having a clocksource_arch_init() callback always sets vdso_clock_mode to
> VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
> required for the riscv-timer.
> 
> This works for platforms where just riscv-timer clocksource is present.
> On platforms where other clock sources are available we want them to
> register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.
> 
> On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
> avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
> move setting of vdso_clock_mode in the riscv-timer driver instead of doing
> this in clocksource_arch_init() callback as done similarly for ARM/64
> architecture.
> 
> [0] drivers/clocksource/renesas-ostm.c
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Samuel Holland <samuel@sholland.org>
> ---
> RFC -> v2
> * Dropped vdso_default static global variable
> * Used IS_ENABLED() macro
> * Included Tested-by from Samuel
> 
> RFC:
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  arch/riscv/Kconfig                | 1 -
>  arch/riscv/kernel/time.c          | 9 ---------
>  drivers/clocksource/timer-riscv.c | 5 +++++
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..9c687da7756d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,7 +12,6 @@ config 32BIT
>  
>  config RISCV
>  	def_bool y
> -	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_HAS_BINFMT_FLAT
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 8217b0f67c6c..42bee305e997 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -30,12 +30,3 @@ void __init time_init(void)
>  	of_clk_init(NULL);
>  	timer_probe();
>  }
> -
> -void clocksource_arch_init(struct clocksource *cs)
> -{
> -#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> -	cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
> -#else
> -	cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> -#endif
> -}
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 55dad7965f43..c416e5e934bf 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -77,6 +77,11 @@ static struct clocksource riscv_clocksource = {
>  	.mask		= CLOCKSOURCE_MASK(64),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.read		= riscv_clocksource_rdtime,
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
> +#else
> +	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,

The else case isn't strictly necessary because VDSO_CLOCKMODE_NONE is
the default. Either way it looks fine to me.

Reviewed-by: Samuel Holland <samuel@sholland.org>

And I tested v2 as well.

Regards,
Samuel

> +#endif
>  };
>  
>  static int riscv_timer_starting_cpu(unsigned int cpu)

