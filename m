Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8A6E82A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjDSUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDSUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:24:59 -0400
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2239768C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:24:21 -0700 (PDT)
Date:   Wed, 19 Apr 2023 22:24:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1681935859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V20VJv1TvezaAhFXg1TxVwCOql54YGFqOYPkGP8pazQ=;
        b=cT8c6lY/bJVW3tUmDsyOXCpLyLqQnkGWUJhsaPyDTQDN+T0llTayhLrryh//uChH+//JHo
        x17+hr5gXmgXXv214KbPtSXg1i5+Whi6AkB87RxbFU1t5mpoZ5++enCMNkSEDLKNkmnQb6
        3IMIQH5r+ho1nDTvIw+DjYAL79D8v9M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 03/12] ARM: exynos: Re-introduce Exynos4212 support
Message-ID: <ZEBN8ImTp/tRdej+@L14.lan>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-4-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416133422.1949-4-aweber.kernel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

On Sun, Apr 16, 2023 at 03:34:13PM +0200, Artur Weber wrote:
> The platform was originally dropped in commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), as there were
> no boards using it.
> 
> We will be adding a device that uses it, so add it back.
> 
> This effectively reverts commit 9e43eca3c874 ("ARM: EXYNOS: Remove
> Exynos4212 related dead code").
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  arch/arm/mach-exynos/Kconfig    | 5 +++++
>  arch/arm/mach-exynos/common.h   | 8 ++++++++
>  arch/arm/mach-exynos/exynos.c   | 2 ++
>  arch/arm/mach-exynos/firmware.c | 8 +++++++-
>  arch/arm/mach-exynos/pm.c       | 2 +-
>  arch/arm/mach-exynos/suspend.c  | 4 ++++
>  6 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 4d3b40e4049a..b3d5df5225fe 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -78,6 +78,11 @@ config CPU_EXYNOS4210
>  	default y
>  	depends on ARCH_EXYNOS4
>  
> +config SOC_EXYNOS4212
> +	bool "Samsung Exynos4212"
> +	default y
> +	depends on ARCH_EXYNOS4
> +
>  config SOC_EXYNOS4412
>  	bool "Samsung Exynos4412"
>  	default y
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 29eb075b24a4..c9e85d33c309 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -15,6 +15,7 @@
>  #define EXYNOS3_SOC_MASK	0xFFFFF000
>  
>  #define EXYNOS4210_CPU_ID	0x43210000
> +#define EXYNOS4212_CPU_ID	0x43220000
>  #define EXYNOS4412_CPU_ID	0xE4412200
>  #define EXYNOS4_CPU_MASK	0xFFFE0000
>  
> @@ -34,6 +35,7 @@ static inline int is_samsung_##name(void)	\
>  
>  IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
>  IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
> +IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
>  IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
>  IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
> @@ -52,6 +54,12 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
>  # define soc_is_exynos4210()	0
>  #endif
>  
> +#if defined(CONFIG_SOC_EXYNOS4212)
> +# define soc_is_exynos4212()	is_samsung_exynos4212()
> +#else
> +# define soc_is_exynos4212()	0
> +#endif
> +
>  #if defined(CONFIG_SOC_EXYNOS4412)
>  # define soc_is_exynos4412()	is_samsung_exynos4412()
>  #else
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 51a247ca4da8..5671621f1661 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -178,6 +178,7 @@ static void __init exynos_dt_machine_init(void)
>  		exynos_cpuidle.dev.platform_data = &cpuidle_coupled_exynos_data;
>  #endif
>  	if (of_machine_is_compatible("samsung,exynos4210") ||
> +	    of_machine_is_compatible("samsung,exynos4212") ||
>  	    (of_machine_is_compatible("samsung,exynos4412") &&
>  	     (of_machine_is_compatible("samsung,trats2") ||
>  		  of_machine_is_compatible("samsung,midas") ||
> @@ -192,6 +193,7 @@ static char const *const exynos_dt_compat[] __initconst = {
>  	"samsung,exynos3250",
>  	"samsung,exynos4",
>  	"samsung,exynos4210",
> +	"samsung,exynos4212",
>  	"samsung,exynos4412",
>  	"samsung,exynos5",
>  	"samsung,exynos5250",
> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index 2da5b60b59e2..110c8064ee64 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -63,12 +63,18 @@ static int exynos_cpu_boot(int cpu)
>  	 *
>  	 * On Exynos5 devices the call is ignored by trustzone firmware.
>  	 */
> -	if (!soc_is_exynos4210() && !soc_is_exynos4412())
> +	if (!soc_is_exynos4210() && !soc_is_exynos4412() &&
> +	    !soc_is_exynos4212())

Seems more logical to have 4212 before 4412 here.

>  		return 0;
>  
>  	/*
>  	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
> +	 * But, Exynos4212 has only one secondary CPU so second parameter
> +	 * isn't used for informing secure firmware about CPU id.
>  	 */
> +	if (soc_is_exynos4212())
> +		cpu = 0;

Is it necessary to set cpu = 0?  Are there any obvious issues without
it (like second cpu not being brought up)?  It seems vendor kernel
does this for both exynos4210 and exynos4212 [1], but mainline has not
done this for exynos4210 and there has been no reported issues on for
that platform as far as I know.

The assembly that handles SMC_CMD_CPU1BOOT in sboot.bin from firmware
version T310XXSBQB2 is identical to what is found in sboot.bin from
exynos4412-galaxy-s3, and it uses the cpu arg in both cases, so seems
likely that we need this and I am mostly asking out of curiosity.

[1] https://github.com/krzk/linux-vendor-backup/blob/mokee/android-3.4-samsung-galaxy-tab-s-10.5-sm-t805-exynos5420/arch/arm/mach-exynos/platsmp.c#L225-L229

Best regards,
Henrik Grimler

>  	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
>  	return 0;
>  }
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 30f4e55bf39e..9b6db04e4e34 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -161,7 +161,7 @@ void exynos_enter_aftr(void)
>  
>  	exynos_pm_central_suspend();
>  
> -	if (soc_is_exynos4412()) {
> +	if (soc_is_exynos4412() || soc_is_exynos4212()) {
>  		/* Setting SEQ_OPTION register */
>  		pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
>  			       S5P_CENTRAL_SEQ_OPTION);
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 3bf14ca78b62..df1e10033f90 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -231,6 +231,7 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
>  
>  EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
>  EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
> +EXYNOS_PMU_IRQ(exynos4212_pmu_irq, "samsung,exynos4212-pmu");
>  EXYNOS_PMU_IRQ(exynos4412_pmu_irq, "samsung,exynos4412-pmu");
>  EXYNOS_PMU_IRQ(exynos5250_pmu_irq, "samsung,exynos5250-pmu");
>  EXYNOS_PMU_IRQ(exynos5420_pmu_irq, "samsung,exynos5420-pmu");
> @@ -640,6 +641,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] __initconst = {
>  	}, {
>  		.compatible = "samsung,exynos4210-pmu",
>  		.data = &exynos4_pm_data,
> +	}, {
> +		.compatible = "samsung,exynos4212-pmu",
> +		.data = &exynos4_pm_data,
>  	}, {
>  		.compatible = "samsung,exynos4412-pmu",
>  		.data = &exynos4_pm_data,
> -- 
> 2.40.0
> 
