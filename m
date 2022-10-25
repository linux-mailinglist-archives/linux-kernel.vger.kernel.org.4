Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2F60C32C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJYFTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJYFTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:19:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5A10825C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:19:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n7so10303044plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgT+i+mNGVNzDg9gJdmB+hvKe7NxeiMDaFiv+R5BkjI=;
        b=hS/9ChV3YJjxmxKMMW0+9GKawXwm6i2bJc3ggEukZeiwEqBTN2jVDOdLHs7nVr/02T
         uvtw5ciWt17N2Z4lGB72wGamUjgLinNJnYGf3I1TGB66PiKPAsFRkM8CNddP7Sfo0gpE
         hlg8UDvWIH8lWEHc+vyQCdqx24j+ZeY1orpSfxegBD3jyIQSSvbc8rEcy54iDea3uKCa
         sWpaKAj842/jffHqySE/YT0jurlIOK94XWDOieSR8QObRTzzJU3kVn5qAQeG8btuXr2n
         ol/pzWYEJUD6FeRjaWVRvjPJi+r6LyM9r3IrhUAJClpZf6PJISK07q87SdgJfUaYjn8S
         +ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgT+i+mNGVNzDg9gJdmB+hvKe7NxeiMDaFiv+R5BkjI=;
        b=Cc9nWLISJVUi3bCf+zmpjPlCksR6C4zxiMUDG/2DJbpR8p+0RPOA0WD6aiuQxDTzI+
         QP2kZUTYc/QKJ2lvP1WJIKVS/DM23sAEDNx9soJcUoNkZstUlEnt2qoRcJpOzl6bVZMG
         UlFlLgWogZc7a6gx0+jZcp/NoUv/FKgTuoJpCHLeB4qw5jGodiuiCz70thdCM+dVyvo/
         kZOfwaAY7rBa6H+4pH1CwHP6ErAIn+5M1i8wut385/slHQtizPhglrx3zXGr2PAfCaKS
         i4AsPXaP3EyzD6zVX3aZLXzdLDOcDBXg44HOxK4fKAZLPWv6ZBffFGb4VJGwfeO77smP
         1GxA==
X-Gm-Message-State: ACrzQf32/WwRA16Gi39wve2sbwbCAev5SoOmFWw+w5k20ZjTVHkLYHcV
        w6gmA8guDJ7IXEAexX+HXkabCpBHy4ZECQ==
X-Google-Smtp-Source: AMsMyM6Tvh3NyCwZZpW/G4t3QWnDmVy5fg+RJUrXLVeBomdLSq9nppjepJpaOD7RNf+Q1/PxzSI7pQ==
X-Received: by 2002:a17:902:748c:b0:186:6a25:b6a8 with SMTP id h12-20020a170902748c00b001866a25b6a8mr24207796pll.40.1666675147201;
        Mon, 24 Oct 2022 22:19:07 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b00186b4565d1bsm525753plk.61.2022.10.24.22.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:19:06 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:49:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 15/21] cpufreq: remove s3c24xx drivers
Message-ID: <20221025051904.yius5ugsuhucpmxs@vireshk-i7>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-15-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-15-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22, 22:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All s3c24xx platforms were removed, so these five drivers are all
> obsolete now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm                  |  78 ---
>  drivers/cpufreq/Makefile                     |   6 -
>  drivers/cpufreq/s3c2410-cpufreq.c            | 155 -----
>  drivers/cpufreq/s3c2412-cpufreq.c            | 240 -------
>  drivers/cpufreq/s3c2416-cpufreq.c            | 492 --------------
>  drivers/cpufreq/s3c2440-cpufreq.c            | 321 ---------
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c    | 163 -----
>  drivers/cpufreq/s3c24xx-cpufreq.c            | 648 -------------------
>  include/linux/soc/samsung/s3c-cpufreq-core.h | 299 ---------
>  9 files changed, 2402 deletions(-)
>  delete mode 100644 drivers/cpufreq/s3c2410-cpufreq.c
>  delete mode 100644 drivers/cpufreq/s3c2412-cpufreq.c
>  delete mode 100644 drivers/cpufreq/s3c2416-cpufreq.c
>  delete mode 100644 drivers/cpufreq/s3c2440-cpufreq.c
>  delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
>  delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq.c
>  delete mode 100644 include/linux/soc/samsung/s3c-cpufreq-core.h
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 8f7a1065f344..e3e0367305ec 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -180,84 +180,6 @@ config ARM_RASPBERRYPI_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> -config ARM_S3C_CPUFREQ
> -	bool
> -	help
> -	  Internal configuration node for common cpufreq on Samsung SoC
> -
> -config ARM_S3C24XX_CPUFREQ
> -	bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
> -	depends on ARCH_S3C24XX
> -	select ARM_S3C_CPUFREQ
> -	help
> -	  This enables the CPUfreq driver for the Samsung S3C24XX family
> -	  of CPUs.
> -
> -	  For details, take a look at <file:Documentation/cpu-freq>.
> -
> -	  If in doubt, say N.
> -
> -config ARM_S3C24XX_CPUFREQ_DEBUG
> -	bool "Debug CPUfreq Samsung driver core"
> -	depends on ARM_S3C24XX_CPUFREQ
> -	help
> -	  Enable s3c_freq_dbg for the Samsung S3C CPUfreq core
> -
> -config ARM_S3C24XX_CPUFREQ_IODEBUG
> -	bool "Debug CPUfreq Samsung driver IO timing"
> -	depends on ARM_S3C24XX_CPUFREQ
> -	help
> -	  Enable s3c_freq_iodbg for the Samsung S3C CPUfreq core
> -
> -config ARM_S3C24XX_CPUFREQ_DEBUGFS
> -	bool "Export debugfs for CPUFreq"
> -	depends on ARM_S3C24XX_CPUFREQ && DEBUG_FS
> -	help
> -	  Export status information via debugfs.
> -
> -config ARM_S3C2410_CPUFREQ
> -	bool
> -	depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2410
> -	help
> -	  CPU Frequency scaling support for S3C2410
> -
> -config ARM_S3C2412_CPUFREQ
> -	bool
> -	depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2412
> -	default y
> -	select S3C2412_IOTIMING
> -	help
> -	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
> -
> -config ARM_S3C2416_CPUFREQ
> -	bool "S3C2416 CPU Frequency scaling support"
> -	depends on CPU_S3C2416
> -	help
> -	  This adds the CPUFreq driver for the Samsung S3C2416 and
> -	  S3C2450 SoC. The S3C2416 supports changing the rate of the
> -	  armdiv clock source and also entering a so called dynamic
> -	  voltage scaling mode in which it is possible to reduce the
> -	  core voltage of the CPU.
> -
> -	  If in doubt, say N.
> -
> -config ARM_S3C2416_CPUFREQ_VCORESCALE
> -	bool "Allow voltage scaling for S3C2416 arm core"
> -	depends on ARM_S3C2416_CPUFREQ && REGULATOR
> -	help
> -	  Enable CPU voltage scaling when entering the dvs mode.
> -	  It uses information gathered through existing hardware and
> -	  tests but not documented in any datasheet.
> -
> -	  If in doubt, say N.
> -
> -config ARM_S3C2440_CPUFREQ
> -	bool "S3C2440/S3C2442 CPU Frequency scaling support"
> -	depends on ARM_S3C24XX_CPUFREQ && (CPU_S3C2440 || CPU_S3C2442)
> -	default y
> -	help
> -	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
> -
>  config ARM_S3C64XX_CPUFREQ
>  	bool "Samsung S3C64XX"
>  	depends on CPU_S3C6410
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8de99b213146..692c16e4ee55 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -70,13 +70,7 @@ obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
>  obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
> -obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
> -obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
> -obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> -obj-$(CONFIG_ARM_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
>  obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
> -obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
> -obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
>  obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
> diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
> deleted file mode 100644
> index 5dcfbf0bfb74..000000000000
> diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
> deleted file mode 100644
> index 5945945ead7c..000000000000
> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> deleted file mode 100644
> index 5c221bc90210..000000000000
> diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
> deleted file mode 100644
> index 2011fb9c03a4..000000000000
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> deleted file mode 100644
> index 93971dfe7c75..000000000000
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
> deleted file mode 100644
> index 7380c32b238e..000000000000
> diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
> deleted file mode 100644
> index 3b278afb769b..000000000000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
