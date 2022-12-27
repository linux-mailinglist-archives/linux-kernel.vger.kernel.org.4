Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BD6570F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiL0XRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiL0XRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:17:42 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3EDDE97;
        Tue, 27 Dec 2022 15:17:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2CB2D320092B;
        Tue, 27 Dec 2022 18:17:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Dec 2022 18:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672183051; x=
        1672269451; bh=F0QkIAB41jYkIimhGOo727aX99iPc7fnfFYfTCyrtmQ=; b=F
        EHq+Z3SDZCwyUwik5ZqJiMj8VI6ZVsoMptvjIEq7gnI2sgvdJBHAIfFSxIlY4Cjo
        VS4pXKz/1jK0iywBvo8389upTi/pT/vkHm15x+D/16ji7EOGxf5rCgbABz0xSuel
        DiI0oEEw3K26LRvpQJ5xzXye7uP6PRDVNKXo/0ZTquMLmG7apirqOuwP5ZPKO0Pt
        3EN5DykvH2sYLG4woBNbSG3CqrNxJAfyRnm4M6N6o07mpcso1MrGUTgjqqbntNYy
        9fq2nv3xipEGYr7n8zOeRhtZZE9aLo6f1Gbwui51IyodnrQ2ZGzFlyrm+OaLEGQw
        SAa6aIcB8JKWMN+YpwOWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672183051; x=
        1672269451; bh=F0QkIAB41jYkIimhGOo727aX99iPc7fnfFYfTCyrtmQ=; b=J
        vHsP8T+NeP72LDLuGIbnHrkmmpx0juGLiMirKf3bB3SAEoB0hgp7sl/COdrFI/bk
        juy+I8zib07iQoiinUu5h2Sp3TGhE1Urgg3nyR2IktWwZ5F5fqf7kb9DuUgv5Lii
        dxJGgqG168H9d/hew8fGm7Pm56rZZUkOrr4kXGQCmvVxSXZU7cDVnj63ZqZHZT3Q
        QWa6+gh6GcknBCQuISNc8geedJSYFSz+EW88577IAgY68R3hPd/i7f3oQGyvgMzH
        331Yb5KaDXdcIOeEzZvazd5l8vVu90nQTGBFRSpr1NUDLucfWFYrff4A7k6xjTv7
        RFdyeM3vib95KKANvvfIg==
X-ME-Sender: <xms:Cn2rY5KScurZ-Y83olgZbqhjcWYliStHDsBX3ipyDuepR1f_xDN8wA>
    <xme:Cn2rY1KwBcVlosR1r2UDVCfpVMS2gKKrLlogcEU4hw1RQme3W7Gr1-1KjDN3LEmyO
    qaU95lpqYChv3Gkhg>
X-ME-Received: <xmr:Cn2rYxsXzp4cA1wOl4Slf9f37tYQ0FlXK8BiwG2J7MgShuoX3jS2mImBpZ1D5EHIbhr2QXkRB3LGDbqSGLVs8lt7gBkABASAocWC56R8bF7Dc6SbE5bGTpiaOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Cn2rY6aEScJsbKgmyYpnN6EDPjmFcNkm7TYhPESYL4U7WQUlu1IOdQ>
    <xmx:Cn2rYwZjxj-k5GRiSQT4wTsYghJvjV2-q3te8pYoCyYBWBlOxCDRUQ>
    <xmx:Cn2rY-Ap3mJGjMh-XGYt_iQ2LBtNwe_cYU3U5uFgwNPnKlEN9fALNg>
    <xmx:C32rYwr28Jbu8ruDwkMGxtYfDTOybqHw0B5LEeBgGYnmsHy0qS_mAQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Dec 2022 18:17:29 -0500 (EST)
Message-ID: <a92eda53-90ed-718d-6925-0d9afbb029c5@sholland.org>
Date:   Tue, 27 Dec 2022 17:17:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
In-Reply-To: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 15:58, Prabhakar wrote:
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

This is definitely a good change to make, but shouldn't we still prefer
the architectural CSR-based clocksource over an MMIO-based clocksource?
It has double the number of bits, and reading it should have less
overhead. So I think we also want to increase the rating of
riscv_clocksource.

D1 is in the same situation, as timer-sun4i.c registers a clocksource
with a higher rating than riscv_clocksource. Without this patch,
tools/testing/selftests/vDSO/vdso_test_correctness fails. With this
patch, it passes, so:

Tested-by: Samuel Holland <samuel@sholland.org>

> [0] drivers/clocksource/renesas-ostm.c
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/Kconfig                | 1 -
>  arch/riscv/kernel/time.c          | 9 ---------
>  drivers/clocksource/timer-riscv.c | 7 +++++++
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7ea12de636bd..b269e062c1b1 100644
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
> index 969a552da8d2..7ec9668cd36d 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -29,6 +29,12 @@
>  
>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
>  
> +#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
> +#else
> +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */

We don't have any workarounds like arm_arch_timer, so we do not need
this indirection through vdso_default. You can set .vdso_clock_mode
directly in the declaration of riscv_clocksource.

Regards,
Samuel

> +
>  static int riscv_clock_next_event(unsigned long delta,
>  		struct clock_event_device *ce)
>  {
> @@ -158,6 +164,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  		return -ENODEV;
>  	}
>  
> +	riscv_clocksource.vdso_clock_mode = vdso_default;
>  	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
>  	       __func__, cpuid, hartid);
>  	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);

