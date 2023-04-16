Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99C6E3AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDPSAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDPSAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:00:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17041121
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:00:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dx24so14464354ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681668046; x=1684260046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8r3Ph3wlo9aaB7DgnoPHy3tyWqlgW0rD+5zyojxS3hs=;
        b=mmJl88pBJmqq7M40k9C+dTZWeToJCvvEHd5ziWNNYwChaS3z0gHAnhGbrzM0HNJUQC
         8T39fdc1hMuEpXek569W6uW8kX8i8obKHwTib6wyUhWtPldbz76omqa4+TQyhikRfrvh
         AxDluD6PekcBtZjkytKHnD9pK4FkGxucaj42VQ+7rEtk2Tdj5PpLJgHDyW7LR9Wm0/DR
         KnxnINvuh0Clp9VDXXm7gnt4U16gJCVxrRFX66npHV/AtwG1pGCrPx6K/UODFATp6H4b
         9a8Rl6am6CO86e6teZ9CqliGKVMXttYXxVIHKbFCX/byeAs4H5A0bITRdzGSEuWk9OP+
         yL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668046; x=1684260046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r3Ph3wlo9aaB7DgnoPHy3tyWqlgW0rD+5zyojxS3hs=;
        b=Sb//2bmfqkZrj9RfRUYPuKP+FcdUVSkmiSMAbx/rZu11gOlTWMhkeAB3xwrsoLK7fV
         KCb4tEZ916CJpcOizFSz4eduo8ZkWHzcr1ujp6ZJebR52uaHs7/cNA+wn5IXQafN0K1E
         sfdzirg3Ff6OBmzHSe1lrgCU7MWxZgYlF+5709sTpBpMt2I+mty1Wwwed+RnChExWW8L
         SpJDDUATM0SknQMx416/+xqO50yI0CN0mdM+wygWR1g4Kf9y8ZEfs9q1aF7Kd4bxOY6V
         oIBPbU6MB2f1q45nE+v1BTDogprOpbZWWdnrzK1/wOnl0hi9jen/mJsVJy/ViqXGxcds
         ls3A==
X-Gm-Message-State: AAQBX9ccAaISuodzlDyZizAeHOWdg3D+xttTUxOqAeaFKRe/Mh5dnREk
        gMnblqV25E/sgWwL4CZ/zprcQA==
X-Google-Smtp-Source: AKy350bEeekS6PjjoYeaY9ZD65LfZf1mhdBAyCQ7201c+Gz5Stjr8OqVkeI9F4SK1ojfGrPXfXNLmg==
X-Received: by 2002:a17:906:a945:b0:870:d9a:9ebb with SMTP id hh5-20020a170906a94500b008700d9a9ebbmr5530065ejb.38.1681668046515;
        Sun, 16 Apr 2023 11:00:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709066ad100b0094f6f45b2c1sm576598ejs.156.2023.04.16.11.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:00:46 -0700 (PDT)
Message-ID: <21eff2e7-1ebc-1d98-6e5e-025f5cf7b822@linaro.org>
Date:   Sun, 16 Apr 2023 20:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/12] ARM: exynos: Re-introduce Exynos4212 support
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
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
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-4-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-4-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:34, Artur Weber wrote:
> The platform was originally dropped in commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), as there were
> no boards using it.

This is not accurate. Platform was not dropped with that commit. This
was only DTS. I propose to drop it and focus on commit which you are
reverting.

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

Keep them ordered, so 4210, 4212 and 4412.

>  		return 0;
>  
>  	/*
>  	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
> +	 * But, Exynos4212 has only one secondary CPU so second parameter
> +	 * isn't used for informing secure firmware about CPU id.
>  	 */
> +	if (soc_is_exynos4212())
> +		cpu = 0;
> +
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

Ditto

Best regards,
Krzysztof

