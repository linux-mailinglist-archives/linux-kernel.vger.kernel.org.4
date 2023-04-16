Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E696E376B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDPK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDPK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:26:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137AE56;
        Sun, 16 Apr 2023 03:26:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt6so18655160ejb.0;
        Sun, 16 Apr 2023 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640781; x=1684232781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18TERSmaaXbG0DMiqdELwQx5niIwl3EaR30SKNprfWo=;
        b=aGGelyyqD5Nr2w71fggyoZWACdgQRp1RtuLRXiZdI/2LbrY5wpd9TLV2CJ/EBIQEJm
         aaPPSGLLnDly5MPj5zGJihzMvugqhJF2pyA/amJ5T33bGNKMpGkJFzCKDfvJdUgb6/c4
         8h+i3ysoZLQHMWToxGKTM/ZGbbwgNFV7HrB2P7Tqmeazh/2iozntttsHHbjzbKrtjoTy
         TiGTS4zMy418tREL5XNO7hzLfLxVGYkhXGtY6ItqCRgHCZMZALVe3Ukn5H+nzNzpL+T2
         dVj/WISR2aGrfttx10cOAXa59yyCTDepMVq5YrkWpXV4457SmXpkBTAHpP49HkcWIYeF
         AvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640781; x=1684232781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18TERSmaaXbG0DMiqdELwQx5niIwl3EaR30SKNprfWo=;
        b=ik4A6zlmdhaSrKdETXPuUyvWf2vzw1cP8/28f0p8446fYZHTdjwtbLTq9HnV47e58b
         IvRMt2w2W9k0tHu5vfNXIDh3HPMx4Q+Ung2Wlp5ZWiqTHzVi/3kSCKYU3LSs1lbNaRQs
         PHpXm85WBKn/iOYCvzF0gjnPDv2cWbAPgrf/3K8n4g44Dd8OUtRALKk1GAbrZmbEoa3k
         b9A1behXlYQkZR+ev9XwJ+LEdNQXxvj1OUjMC5VRHH0rZ6aDlBRmdtJwfRIeGTYA2AD8
         e+oHM1R/hBfVX52bSS7UgGiTDVhtPd+1m6S39EAssSYiD81BVb8Bo6t5zlHgjRo9R+6i
         uGbw==
X-Gm-Message-State: AAQBX9c2+qG3pLxnR2uGSRutJ2jRP/kLM+2cAcbBEonKRnndHg8UkZwm
        YRLKirOrVAWaT6Di/KxkbA0=
X-Google-Smtp-Source: AKy350ZHhU8Zzl8mH9AXBlTuo6j42D0d7sHHVuXJZiIXLupMYOpRNUGLEb0QwKEXeNl9UcbFIVudQQ==
X-Received: by 2002:a17:906:9407:b0:94f:1:8468 with SMTP id q7-20020a170906940700b0094f00018468mr4188570ejx.17.1681640781251;
        Sun, 16 Apr 2023 03:26:21 -0700 (PDT)
Received: from [192.168.50.244] (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402068200b005069175dcb7sm1787767edy.58.2023.04.16.03.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 03:26:20 -0700 (PDT)
Message-ID: <3e513119-4d6a-18ec-aaec-1c6b2b7e35b4@gmail.com>
Date:   Sun, 16 Apr 2023 12:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 00/12] Re-introduce Exynos4212 support and add Samsung
 Galaxy Tab 3 8.0 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 12:16, Artur Weber wrote:
> This patches re-introduces the Exynos4212 platform and adds support
> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
> 
>   - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>   - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>   - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
> 
> What works:
> 
>   - Display and backlight
>   - Touchscreen (without touchkeys)
>   - GPIO buttons, hall sensor
>   - WiFi and Bluetooth
>   - USB, fuel gauge, charging (partial)
>   - Accelerometer and magnetometer
>   - WiFi model only: light sensor

This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel 
controller driver" for the display panel support for the Samsung Galaxy 
3 8.0 boards.

> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> Artur Weber (12):
>    dt-bindings: soc: samsung: add Exynos4212 PMU compatible
>    dt-bindings: clock: add Exynos4212 clock compatible
>    ARM: exynos: Re-introduce Exynos4212 support
>    soc: samsung: Re-introduce Exynos4212 support
>    clk: samsung: Add Exynos4212 compatible to CLKOUT driver
>    clk: samsung: Re-add support for Exynos4212 CPU clock
>    Revert "media: exynos4-is: Remove dependency on obsolete SoC support"
>    Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"
>    ARM: dts: Move common Exynos4x12 definitions to exynos4x12.dtsi
>    ARM: dts: Re-introduce Exynos4212 DTSI
>    dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
>    ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
> 
>   .../bindings/arm/samsung/samsung-boards.yaml  |   10 +
>   .../bindings/clock/samsung,exynos-clock.yaml  |    1 +
>   .../bindings/soc/samsung/exynos-pmu.yaml      |    3 +
>   arch/arm/boot/dts/Makefile                    |    3 +
>   arch/arm/boot/dts/exynos4212-tab3-3g8.dts     |   30 +
>   arch/arm/boot/dts/exynos4212-tab3-lte8.dts    |   43 +
>   arch/arm/boot/dts/exynos4212-tab3-wifi8.dts   |   25 +
>   arch/arm/boot/dts/exynos4212-tab3.dtsi        | 1175 +++++++++++++++++
>   arch/arm/boot/dts/exynos4212.dtsi             |  157 +++
>   arch/arm/boot/dts/exynos4412.dtsi             |  645 +--------
>   ...2-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |    4 +-
>   arch/arm/boot/dts/exynos4x12.dtsi             |  665 ++++++++++
>   arch/arm/mach-exynos/Kconfig                  |    5 +
>   arch/arm/mach-exynos/common.h                 |    8 +
>   arch/arm/mach-exynos/exynos.c                 |    2 +
>   arch/arm/mach-exynos/firmware.c               |    8 +-
>   arch/arm/mach-exynos/pm.c                     |    2 +-
>   arch/arm/mach-exynos/suspend.c                |    4 +
>   drivers/clk/samsung/clk-exynos-clkout.c       |    3 +
>   drivers/clk/samsung/clk-exynos4.c             |   44 +-
>   .../media/platform/samsung/exynos4-is/Kconfig |    2 +-
>   .../platform/samsung/exynos4-is/fimc-core.c   |    2 +-
>   .../platform/samsung/exynos4-is/fimc-lite.c   |    2 +-
>   drivers/phy/samsung/Kconfig                   |    2 +-
>   drivers/soc/samsung/exynos-pmu.c              |    9 +
>   drivers/soc/samsung/exynos-pmu.h              |    2 +
>   drivers/soc/samsung/exynos4-pmu.c             |   13 +-
>   27 files changed, 2213 insertions(+), 656 deletions(-)
>   create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
>   create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
>   create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
>   create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
>   create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
>   rename arch/arm/boot/dts/{exynos4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} (99%)
>   create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
> 

