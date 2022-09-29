Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE685EF803
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiI2Ou4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiI2Ouw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:50:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898D11F125;
        Thu, 29 Sep 2022 07:50:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D3E67320092C;
        Thu, 29 Sep 2022 10:50:47 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Thu, 29 Sep 2022 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664463047; x=1664549447; bh=zV
        i8bvDF9v9CQqO4nf5ikiOCShihdox9bFMrNX69BSQ=; b=m8PGiMVt5q6+eaQREp
        4//1arnpFcH5aB6P7QyTMfS1WA15b+zLB7RLRetEucZVGqj/0J7PwdB+1QKFrh72
        HDFesh94jpcARWFGvm/LHz8GzhKKOweyBdB2jeTo1/K3NGlcs90KEnxHVM8w1jjO
        a8o/jOsxg4AnGfoP7wL3wZK3jj5MrNyC8atVMqF+LGQivQ91hJd8LkRQMStQ+O6N
        /BMimEBC4AWPHFmUJ2+hD7lGP/8tNXyA442reM3lsJL2yiHFBdi5pWGMzURMMx4d
        x2m+W0cppvKYSTlH+ckdZ4NGzyAn8gZsD4VIu2ZbY37UEVjlACOz9m5jN2sfn3Jx
        AKxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664463047; x=1664549447; bh=zVi8bvDF9v9CQqO4nf5ikiOCShih
        dox9bFMrNX69BSQ=; b=gBQxq+ddv81CKB7YTZ8CtqKJYpkrUOxBl/k967j2Pk2l
        b5YRayrraj9i2BTWkFMEz9e2da5CfI1oUJLxp0DVYePoAVthpl+g+V+EyjYOQGNc
        Y2NOAE+D46HVvKSaHubGKpepihDDEjhRb8R7eouu4Yl62szCWdAYE0AmcsfojcL6
        6M7L/ICUAwl7fjNTNSZ02xIDgUONNi8SiM08RMljBLcCGfMTremLmoAYEWLOBglM
        Td1OYF5tDrYfp5ZFop5p2yvv+mWdJPzTKM46z/QPboFw1Q6Y2oqEKz0F+1IFCU8r
        pMyDiAHEADOP9TsJdKShAjpbSP6VHhUrqDKlcNE8Sw==
X-ME-Sender: <xms:xrA1YzeUkw2Q-USQ-CT5jWsWEl6K-PiqDmfIXSvRT01bxJ4yYl0bDQ>
    <xme:xrA1Y5OhqfsevWxrEqxAevWDh2fY8Z9vErJRxp5Ug2cDWuDlOZ03FVr8mf1_VYe6D
    ji3VQ5XdOFOV7vnJ7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:xrA1Y8g1SPNv61QTTaWmb60nQBNUuFk_YcIK2KVnv4edIBlMUfZSew>
    <xmx:xrA1Y08CVL_L95n5c7J5cgfr1tZtRak1YKT9R_EU6r8JVdvzVsSQLA>
    <xmx:xrA1Y_u578-sF0cYSNjJmNCAjkncy77IyyTP0yUHcqK1PuYb8u9uWw>
    <xmx:x7A1Y9JUOgWSrRaC8HlkID1k9lKG1Xka5xB4l9nzTfwdIb09sBPhDg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1716BA6007C; Thu, 29 Sep 2022 10:50:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <0dd4f0ad-62bd-42c3-9518-41675c7ffda8@app.fastmail.com>
In-Reply-To: <20220929144039.40011-2-konrad.dybcio@somainline.org>
References: <20220929144039.40011-1-konrad.dybcio@somainline.org>
 <20220929144039.40011-2-konrad.dybcio@somainline.org>
Date:   Thu, 29 Sep 2022 16:50:24 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     towinchenmi@gmail.com, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022, at 16:40, Konrad Dybcio wrote:
> Add support for A7-A11 SoCs by if-ing out some features only present
> on:
>
> * A11 & newer (implementation-defined IPI & UNCORE registers)
> * A11[1] & newer (fast IPI support).
>
> Also, annotate IPI regs support in the aic struct so that the driver
> can tell whether the SoC supports these, as they are written to,
> even if fast IPI is disabled. This in turn causes a crash on older
> platforms, as the implemention-defined registers either do
> something else or are not supposed to be touched - definitely not a
> NOP though.
>
> [1] A11 is supposed to use this feature, but it currently doesn't work
> for reasons unknown and hence remains disabled. It can easily be enabled
> on A11 only, as there is a SoC-specific compatible in the DT with a
> fallback to apple,aic, so that the interrupt controller gets to probe
> regardless of whether IPI Sn_... registers are used or not.
> That said, it is not yet necessary, especially with only one core up,
> and it has worked a-ok so far.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - remove EL2 register check (dts change covered this)
> - use static_branch instead of ifs
> - rename "uncore2 registers" to "uncore registers" in added code and
> update the commit message accordingly
> - create a "legacy" config struct for pre-A11 targets
> - rewrite the commit message a bit to match actual status
>
>  drivers/irqchip/irq-apple-aic.c | 56 ++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 1c2813ad8bbe..cdef99bfcfb3 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -229,6 +229,7 @@
>  #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
> 
>  static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
> +static DEFINE_STATIC_KEY_TRUE(has_uncore_regs);
> 
>  struct aic_info {
>  	int version;
> @@ -246,6 +247,7 @@ struct aic_info {
> 
>  	/* Features */
>  	bool fast_ipi;
> +	bool uncore_regs;
>  };
> 
>  static const struct aic_info aic1_info = {
> @@ -253,6 +255,8 @@ static const struct aic_info aic1_info = {
> 
>  	.event		= AIC_EVENT,
>  	.target_cpu	= AIC_TARGET_CPU,
> +
> +	.uncore_regs	= true,
>  };
> 
>  static const struct aic_info aic1_fipi_info = {
> @@ -264,6 +268,13 @@ static const struct aic_info aic1_fipi_info = {
>  	.fast_ipi	= true,
>  };
> 
> +static const struct aic_info aic1_legacy_info = {
> +	.version	= 1,
> +
> +	.event		= AIC_EVENT,
> +	.target_cpu	= AIC_TARGET_CPU,
> +};
> +
>  static const struct aic_info aic2_info = {
>  	.version	= 2,
> 
> @@ -273,6 +284,10 @@ static const struct aic_info aic2_info = {
>  };
> 
>  static const struct of_device_id aic_info_match[] = {
> +	{
> +		.compatible = "apple,s5l8960x-aic",
> +		.data = &aic1_legacy_info,
> +	},

Maybe I'm confused but shouldn't this be the apple,aic fallback and uncore_regs
should be enabled for e.g. t8103-aic then?

>  	{
>  		.compatible = "apple,t8103-aic",
>  		.data = &aic1_fipi_info,
> @@ -524,12 +539,14 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  	 * we check for everything here, even things we don't support yet.
>  	 */
> 
> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> -		if (static_branch_likely(&use_fast_ipi)) {
> -			aic_handle_ipi(regs);
> -		} else {
> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +	if (static_branch_likely(&use_fast_ipi)) {
> +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> +			if (static_branch_likely(&use_fast_ipi)) {
> +				aic_handle_ipi(regs);
> +			} else {
> +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
> +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +			}

This doesn't make much sense:

if (A) {
    if (B) {
        if (A) { // A is already guaranteed to be true here, why check it again?
            // ...
        } else {
            // how can this ever be reached then?
        }
    }
}

>  		}
>  	}
> 
> @@ -566,12 +583,14 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  					  AIC_FIQ_HWIRQ(irq));
>  	}
> 
> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == 
> UPMCR0_IMODE_FIQ &&
> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
> -		/* Same story with uncore PMCs */
> -		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> -		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +	if (static_branch_likely(&has_uncore_regs)) {
> +		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) ==
> +			UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & 
> UPMSR_IACT)) {
> +			/* Same story with uncore PMCs */
> +			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> +			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +		}
>  	}
>  }
> 
> @@ -944,7 +963,8 @@ static int aic_init_cpu(unsigned int cpu)
>  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
> 
>  	/* Pending Fast IPI FIQs */
> -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +	if (static_branch_likely(&use_fast_ipi))
> +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> 
>  	/* Timer FIQs */
>  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
> @@ -965,8 +985,9 @@ static int aic_init_cpu(unsigned int cpu)
>  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
> 
>  	/* Uncore PMC FIQ */
> -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +	if (static_branch_likely(&has_uncore_regs))
> +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> 
>  	/* Commit all of the above */
>  	isb();
> @@ -1125,6 +1146,11 @@ static int __init aic_of_ic_init(struct 
> device_node *node, struct device_node *p
>  	else
>  		static_branch_disable(&use_fast_ipi);
> 
> +	if (irqc->info.uncore_regs)
> +		static_branch_enable(&has_uncore_regs);
> +	else
> +		static_branch_disable(&has_uncore_regs);
> +
>  	irqc->info.die_stride = off - start_off;
> 
>  	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
> -- 
> 2.30.2


Sven
