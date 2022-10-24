Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B060ADD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiJXOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiJXOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:36:10 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2E5857C6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:11:20 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id h14so8082937pjv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiP9jS952IZOWcL/pVtNm5S9NucWCd+fi6C3AHbXT/o=;
        b=Wmjw+YBbfbQzr4P3mGJzdz86Pr1QTcS8Xx0ZDy3yQG5kMeVAWjvvzMAGPOlpqZA4Hd
         nX1PTIKK4WGThZMRatkX7W62zknb05+sb435nbmW/m+zJk7RWBfqVK2DF2mzVAljEnvR
         rJy9vg+9UyyOFUzXo6fx1spl+kxJv9k6cGosUCrIBvZf94YBh1Qu+yGBLHNXvXBJigmN
         EZ608QbdhjYMG58PwJ4pLxhHEGP3UipSJbVjyf8GXoqop8AQEeoMTBl0p4DJnpL6XScw
         IrkKjSCjjjuUf+z3yg8/i2NdD6cNllkY9ZilJBO0+7Gm9qc0MgS9D5gEHhiF+y3/QcXm
         SLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiP9jS952IZOWcL/pVtNm5S9NucWCd+fi6C3AHbXT/o=;
        b=4ikO72VWXMlKCoHSceOA93tAWxKFE0rDgzKAoxT1tndOSraTt5u9lf6gT00CL0xNqU
         YML7cLWyIH8de6v6OXPU3PTunU5yQqhiP/w1s5Kf727dFoYXbK0LYBekGQYpBhXSGjTM
         lEJOdSrbpLB5l29qVpELoeis7JwBv90ncimt0F6UTV4QYFS2rVrke4uYQs2XHSsXj8Jh
         d56G9aKz3jdtOsmi/Vq9cIrK3MG6PuV8/FhpNHbhwyXYoFV7MtVMlEJPIn02YM3DnQ32
         3FVXanv/niZkL7mtnvtxma86Cyfe6mpy38RdXhBclfTIof/QfrmWVS+YggYz3VcQzBEK
         UdQw==
X-Gm-Message-State: ACrzQf3JbhzSjdPdmbK3QkHsCnzeH1XZ2KQ9GiI7rm4PSKU4zQi5zSi0
        iSjLvdJ2+SkOS0JrZ9siAKqE3pxwbzauIA==
X-Google-Smtp-Source: AMsMyM4B5Snj6u5GQrG1tZZFXhC/VAAEyUP1giWk5ju319EFibalR6g5PfblDQDPQyIyehJLwnKEYg==
X-Received: by 2002:a05:6214:27ea:b0:4bb:6e71:7cc6 with SMTP id jt10-20020a05621427ea00b004bb6e717cc6mr4320206qvb.24.1666614599792;
        Mon, 24 Oct 2022 05:29:59 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 5-20020a370805000000b006ec09d7d357sm14636384qki.47.2022.10.24.05.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:29:59 -0700 (PDT)
Message-ID: <fc923325-335d-e768-ea72-ba1712320d9d@linaro.org>
Date:   Mon, 24 Oct 2022 08:29:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 05/21] ARM: s3c: simplify platform code
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-5-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Following down the now unused symbols and header files, some additional
> content can be dropped that is used by neither the s3c64xx DT support
> nor the crag6410 board.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c/Kconfig                    |  50 --
>  arch/arm/mach-s3c/Kconfig.s3c64xx            |   5 -
>  arch/arm/mach-s3c/Makefile                   |   2 -
>  arch/arm/mach-s3c/Makefile.s3c64xx           |   1 -
>  arch/arm/mach-s3c/adc-core.h                 |  24 -
>  arch/arm/mach-s3c/ata-core-s3c64xx.h         |  24 -
>  arch/arm/mach-s3c/backlight-s3c64xx.h        |  22 -
>  arch/arm/mach-s3c/cpu.h                      |  47 --
>  arch/arm/mach-s3c/dev-audio-s3c64xx.c        | 127 ----
>  arch/arm/mach-s3c/devs.c                     | 725 -------------------
>  arch/arm/mach-s3c/devs.h                     |  37 -
>  arch/arm/mach-s3c/dma-s3c64xx.h              |  57 --
>  arch/arm/mach-s3c/dma.h                      |   2 -
>  arch/arm/mach-s3c/gpio-cfg-helpers.h         | 124 ----
>  arch/arm/mach-s3c/gpio-cfg.h                 |  19 -
>  arch/arm/mach-s3c/gpio-core.h                |   3 -
>  arch/arm/mach-s3c/gpio-samsung.c             | 443 +----------
>  arch/arm/mach-s3c/iic-core.h                 |   7 -
>  arch/arm/mach-s3c/init.c                     |  26 +-
>  arch/arm/mach-s3c/map-s3c.h                  |  37 -
>  arch/arm/mach-s3c/onenand-core-s3c64xx.h     |  32 -
>  arch/arm/mach-s3c/otom.h                     |  25 -
>  arch/arm/mach-s3c/pm-core-s3c64xx.h          |  17 -
>  arch/arm/mach-s3c/pm-s3c64xx.c               |  83 ---
>  arch/arm/mach-s3c/pm.c                       |   7 +-
>  arch/arm/mach-s3c/pm.h                       |  12 -
>  arch/arm/mach-s3c/regs-srom-s3c64xx.h        |  55 --
>  arch/arm/mach-s3c/s3c6400.c                  |   6 -
>  arch/arm/mach-s3c/s3c6410.c                  |   9 -
>  arch/arm/mach-s3c/sdhci.h                    |  25 -
>  arch/arm/mach-s3c/setup-ide-s3c64xx.c        |  40 -
>  arch/arm/mach-s3c/sleep-s3c64xx.S            |  27 -
>  include/linux/platform_data/media/s5p_hdmi.h |  32 -
>  33 files changed, 6 insertions(+), 2146 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c/adc-core.h
>  delete mode 100644 arch/arm/mach-s3c/ata-core-s3c64xx.h
>  delete mode 100644 arch/arm/mach-s3c/backlight-s3c64xx.h
>  delete mode 100644 arch/arm/mach-s3c/dma-s3c64xx.h
>  delete mode 100644 arch/arm/mach-s3c/dma.h
>  delete mode 100644 arch/arm/mach-s3c/onenand-core-s3c64xx.h
>  delete mode 100644 arch/arm/mach-s3c/otom.h
>  delete mode 100644 arch/arm/mach-s3c/regs-srom-s3c64xx.h
>  delete mode 100644 arch/arm/mach-s3c/setup-ide-s3c64xx.c
>  delete mode 100644 include/linux/platform_data/media/s5p_hdmi.h
> 
> diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
> index 0dde4010aa64..b3656109f1f7 100644
> --- a/arch/arm/mach-s3c/Kconfig
> +++ b/arch/arm/mach-s3c/Kconfig
> @@ -90,36 +90,6 @@ config S3C_DEV_I2C1
>  	help
>  	  Compile in platform device definitions for I2C channel 1
>  
> -config S3C_DEV_I2C2
> -	bool
> -	help
> -	  Compile in platform device definitions for I2C channel 2
> -
> -config S3C_DEV_I2C3
> -	bool
> -	help
> -	  Compile in platform device definition for I2C controller 3
> -
> -config S3C_DEV_I2C4
> -	bool
> -	help
> -	  Compile in platform device definition for I2C controller 4
> -
> -config S3C_DEV_I2C5
> -	bool
> -	help
> -	  Compile in platform device definition for I2C controller 5
> -
> -config S3C_DEV_I2C6
> -	bool
> -	help
> -	  Compile in platform device definition for I2C controller 6
> -
> -config S3C_DEV_I2C7
> -	bool
> -	help
> -	  Compile in platform device definition for I2C controller 7
> -
>  config S3C_DEV_FB
>  	bool
>  	help
> @@ -135,26 +105,6 @@ config S3C_DEV_USB_HSOTG
>  	help
>  	  Compile in platform device definition for USB high-speed OtG
>  
> -config S3C_DEV_WDT
> -	bool
> -	help
> -	  Compile in platform device definition for Watchdog Timer
> -
> -config S3C_DEV_NAND
> -	bool
> -	help
> -	  Compile in platform device definition for NAND controller
> -
> -config S3C_DEV_ONENAND
> -	bool
> -	help
> -	  Compile in platform device definition for OneNAND controller
> -
> -config S3C_DEV_RTC
> -	bool
> -	help
> -	  Compile in platform device definition for RTC
> -
>  config S3C64XX_DEV_SPI0
>  	bool
>  	help
> diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
> index c403d7642f0a..c52c7ce1d8fa 100644
> --- a/arch/arm/mach-s3c/Kconfig.s3c64xx
> +++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
> @@ -15,12 +15,9 @@ menuconfig ARCH_S3C64XX
>  	select HAVE_TCM
>  	select PLAT_SAMSUNG
>  	select PM_GENERIC_DOMAINS if PM
> -	select S3C_DEV_NAND if ATAGS
>  	select S3C_GPIO_TRACK if ATAGS
> -	select S3C2410_WATCHDOG

This does not seem right. S3C2410_WATCHDOG is a driver used by all
(including Exynos) platforms.

>  	select SAMSUNG_ATAGS if ATAGS
>  	select SAMSUNG_WAKEMASK if PM
> -	select WATCHDOG
>  	help
>  	  Samsung S3C64XX series based systems
>  
> @@ -121,10 +118,8 @@ config MACH_WLF_CRAGG_6410
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
>  	select S3C_DEV_I2C1
> -	select S3C_DEV_RTC

This as well.

>  	select S3C_DEV_USB_HOST
>  	select S3C_DEV_USB_HSOTG
> -	select S3C_DEV_WDT
>  	select SAMSUNG_DEV_KEYPAD
>  	select SAMSUNG_DEV_PWM
>  	help



Best regards,
Krzysztof

