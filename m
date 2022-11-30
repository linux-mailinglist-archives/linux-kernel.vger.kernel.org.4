Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4C63CE50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiK3EUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiK3ET5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:19:57 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848322C652;
        Tue, 29 Nov 2022 20:19:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D7146320027A;
        Tue, 29 Nov 2022 23:19:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 29 Nov 2022 23:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669781994; x=
        1669868394; bh=geF09RMhVzrmblG0AWI/JlVzOQzpfQlKgZsik6BhT/Q=; b=q
        AUMqP4zTpNErCbXaqgejwie3I7jfnINQbuBXdm6RBdnJj0cMBxlhJ8peQKJJHFXy
        dUKPXcEEce76resM5bYw5d9DytKDUTNZRNHwaExYpVhn/wNLaMkMr3gdEaOwRjus
        J5x5BqILonmpOho1O+MWdO4ZKLczwMV6P85KpK2AHYhW79RZkbQFBCXmZNaPuo6f
        jB5MQlh2YIWbUGxttakYcCYKjlQ6Z3uR53lB5QFlbHpSsrxG2pzL3uHu6O2bGiCe
        4zaU+0eDRpZthF9CMXJXj5hHSDKleeedPkTHzm53HAAHh5cL1jJuidjvSSl3ZMah
        zwxvEQowwEk8g+dt2eUkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669781994; x=
        1669868394; bh=geF09RMhVzrmblG0AWI/JlVzOQzpfQlKgZsik6BhT/Q=; b=U
        kL3LG9ZijG0AaGC6IQEQ3koQvXCOqDOngKqlqkOfqSs9KLk/YbFGPxofnr4Oa/Sh
        XvSIBZUileRUFWkJvJ53OesPMSDnqxOC4BCNr2kz3OhCZ2i/Y8G5wTYie0pw0Z0I
        7EbM32FlxJHNL09wx7EAZIIJxrR+4i7xj3XogZ2TPYMMAC4Dg3tdN0p4p9vf48jQ
        Qx8+YEgkM9Ni8ZrZmbBP8a1Eq0WgjA5YEVweFfKdlyiBXbcWFHwIU7oxu3c5WHfv
        8sFltOQv4/ub2ZqYKrFWLedPDA6f0emVefo2tKUiZ1EG8tFtRSNgimcN/dymplB7
        mM5GvQZVOsw+imYkx+eIw==
X-ME-Sender: <xms:6dmGY2Hv5ROJQB7Q2tn1v3XfZoIUIPSEEFE-u6gDCIqtvHztUZhC4g>
    <xme:6dmGY3UuWiGaDprCfdLK5dub4R_p6U7-geSrIv5Eo8LnJVDyLiC2BMM_IPNv_NuXQ
    cecdMA5FKYt7lvZqw>
X-ME-Received: <xmr:6dmGYwI-X3p6Uv1-bidb3svDqarniEjvr86LurEwhlU3zKgq9Zo_f4G8yL-lvR3VTGzOKWG-yRxmHX6IB2AGqg4FInAmQLTg1f8kuFH71U52UwggigTIhswYLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheettdefgeeuudelvdffleejheejueeludduiedvkeffgeetueev
    vdelvdetfeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:6dmGYwGf_tadIRd4AOdQKPaY_Y9JiZaizfzChXmVyURMks__a86E1Q>
    <xmx:6dmGY8VddPxxYz_U0wA-_LQDSqHkqAbxC8U8ZlPXrkYuEPe9HcVqgQ>
    <xmx:6dmGYzOHTdKgQPTepCc5-NHP56RVkqy8nJSDZn9cfZ8JwGlsppY9Tw>
    <xmx:6tmGY9t9UXNosbkwSqnTH2p36V3wBQ1n44_HEOEE5zgfkldbs458-Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 23:19:53 -0500 (EST)
Message-ID: <167c5c23-2863-7882-15ea-e251ed3caf8d@sholland.org>
Date:   Tue, 29 Nov 2022 22:19:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-2-apatel@ventanamicro.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 1/3] RISC-V: time: initialize broadcast hrtimer based
 clock event device
In-Reply-To: <20221129140313.886192-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 08:03, Anup Patel wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Similarly to commit 022eb8ae8b5e ("ARM: 8938/1: kernel: initialize
> broadcast hrtimer based clock event device"), RISC-V needs to initiate
> hrtimers before C3STOP can be used. Otherwise, the introduction of C3STOP

Specifically it is the hrtimer-based broadcast clockevent that we need
to initialize, not hrtimers as a whole.

> for the RISC-V arch timer in commit 232ccac1bd9b
> ("clocksource/drivers/riscv: Events are stopped during CPU suspend")

Maybe add some more details here:

... leaves us without any broadcast timer registered. This prevents the
kernel from entering oneshot mode, which ...

> breaks timer behaviour, for example clock_nanosleep().
> 
> A test app that sleeps each cpu for 6, 5, 4, 3 ms respectively, HZ=250
> & C3STOP enabled, the sleep times are rounded up to the next jiffy:
> == CPU: 1 ==      == CPU: 2 ==      == CPU: 3 ==      == CPU: 4 ==
> Mean: 7.974992    Mean: 7.976534    Mean: 7.962591    Mean: 3.952179
> Std Dev: 0.154374 Std Dev: 0.156082 Std Dev: 0.171018 Std Dev: 0.076193
> Hi: 9.472000      Hi: 10.495000     Hi: 8.864000      Hi: 4.736000
> Lo: 6.087000      Lo: 6.380000      Lo: 4.872000      Lo: 3.403000
> Samples: 521      Samples: 521      Samples: 521      Samples: 521
> 
> Link: https://lore.kernel.org/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
> Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped during CPU suspend")
> Suggested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Either way:

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  arch/riscv/kernel/time.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 8217b0f67c6c..1cf21db4fcc7 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/of_clk.h>
> +#include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/delay.h>
>  #include <asm/sbi.h>
> @@ -29,6 +30,8 @@ void __init time_init(void)
>  
>  	of_clk_init(NULL);
>  	timer_probe();
> +
> +	tick_setup_hrtimer_broadcast();
>  }
>  
>  void clocksource_arch_init(struct clocksource *cs)

