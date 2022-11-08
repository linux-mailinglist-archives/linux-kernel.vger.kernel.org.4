Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79157621B69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiKHSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKHSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:04:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967531EC7C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:04:56 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id d3so22309657ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8lLQrLa9lfgAhLWiz3+cGR1Ww6pJngs3/YRtX20tqU=;
        b=sZTVQpeTSHFjr+vC32q4RN/mHfcdVDA7xMdjOfiBBiyUhOyrcNX8kulqsn9u47xJDy
         7g2p9vwgCTeTO32/qyifA0JKI49z7XHqzY84Xt6sPThEcTr/xLABqlKtdGPbTQifVLKB
         S4UrFVqJ+46VhcGCprDLY/KOmDBQ4l7O42VgEcaz+xcNPP3z1UBHAAt3YnQEYB/frwpW
         +RurAV5t7YFtRvczfhQgFKZJgy04tQsKUHFFCGLmcz0xzHnezTR2PtoQfkMJIyN4zsoE
         Vm88ikl9RysO6sqVxgD+/pYjn5o9CBP25LlHWaXD88BkLVtfPq291940TOPU+77Sa3yJ
         A4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8lLQrLa9lfgAhLWiz3+cGR1Ww6pJngs3/YRtX20tqU=;
        b=PPO8wTPTmSxtbE0upDIhGPNsuU4HFeF9YntEPfCsiNpOhlO1iTQnbhJxPD72vacORc
         oUkOnE1w/MtQxrR3am+KUSdOhrnHTvq7p5bjUk8ZHjTUzSAe6hCPA1bSULydodx+AfJI
         J9BZlGwm9XRYpH8q4vIbN6FMSVAYhXi8FFYMtlpG2u2VYkfPi5vWmHdv2fqn04kMjNSt
         M6LXDLNQyamnStydfmHWEnF7LkSoRQzoHWzo60efxapzWzRDJBdJCNkHG1pZvVK6QvfH
         X8PFQ76nHSh9O0NjDnuoWni6xum2P+EANFIhomwRblmD4buRdfihXbknvGpugLzpjRQz
         jpYQ==
X-Gm-Message-State: ACrzQf3eh6rqeezJJO90rN9JVyQJzmxAxn+RfUzf3eoXufOxewqhWy05
        baU+cQTuNGh3BdbCvNdvtKU4gQ==
X-Google-Smtp-Source: AMsMyM4N+JvIZIj0O9kVtpNaG937zWm4KuV/52/nYkXR3qUQ3hkYMoNVIoxbh4ec7Z8LvK6zCWW6LQ==
X-Received: by 2002:a2e:9d5a:0:b0:25e:2c67:edaf with SMTP id y26-20020a2e9d5a000000b0025e2c67edafmr19844245ljj.437.1667930693415;
        Tue, 08 Nov 2022 10:04:53 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512228400b00498f570aef2sm1868606lfu.209.2022.11.08.10.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:04:52 -0800 (PST)
Message-ID: <357a9396-57b2-ce55-5825-eed14ff3c14e@linaro.org>
Date:   Tue, 8 Nov 2022 19:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Add rk3588-evb1 board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com
References: <20221108171500.99599-1-sebastian.reichel@collabora.com>
 <20221108171500.99599-5-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108171500.99599-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 18:14, Sebastian Reichel wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC,
> connect via UART or Ethernet.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I acked something very different. This has several new stuff with things
to fix, so please drop my ack.

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 156 ++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index c6c69a4e3777..4230881371fa 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -739,6 +739,11 @@ properties:
>            - const: rockchip,rk3568-bpi-r2pro
>            - const: rockchip,rk3568
>  
> +      - description: Rockchip RK3588 Evaluation board
> +        items:
> +          - const: rockchip,rk3588-evb1-v10
> +          - const: rockchip,rk3588
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 8c15593c0ca4..12ed53de11eb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -72,3 +72,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> new file mode 100644
> index 000000000000..a9b8e0ed1125
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3588 EVB1 V10 Board";
> +	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	vcc12v_dcin: vcc12v-dcin {

Node names should be generic, so at least regualtor prefix or suffix
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
Best regards,
Krzysztof

