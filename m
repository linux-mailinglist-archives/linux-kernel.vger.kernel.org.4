Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8815BEABD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiITQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiITQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:04:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90966B16A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:04:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k10so4581862lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FogWB2FGGdAF/PqnPcBa4/GS/a8YaiRAD23uITPI7zk=;
        b=VPtjkI+boNwBC+sWLXnbJiTs2CsMQODoEZj3Q0kXubJ1OMA7atWZnTUQo3A21KFhr5
         2o0mBVwGdsOseRpFB9A1MaP7T2wiTTdIX5iZVi6gKOMbKZDwowN+qRS/d+vmr+6BL+DR
         7upD5DidRQEW3/rzdkH3bfkK37GfiNWqULvwc004e+79nXstNxRmTJ0yIUdnXYZtBFzs
         1nc3H2BXgkJdpkNwirulQqMZj8A89XOI4U55svfxzpVdXLfm/ny3GyuCWsxm7sKmDHYO
         CMVfkQBkI+DzzAFJkAUZyk+nHI1YTRaJiQhBwILXjciTBDCs2Fc5chhz6PzVuIZ4hCbe
         WVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FogWB2FGGdAF/PqnPcBa4/GS/a8YaiRAD23uITPI7zk=;
        b=vx0ZiMYnZqz6MIgvpDaDODi5JRQLGRSmfOo0FaONweZMoCqHGx5W9Gi/1q3RY5qo20
         xH6H/3t7/zlEN7NqQLMVLwi0VRhjfAONL/J2b7+mm3YXK+F1YodF5Kd4/40lMRoUoMyW
         +8FVPrjY6gHqnXOPi7Y75J+znxbPYnhbGMpWTyfLz7IUs+KxiZG/kLteXhOQFurziT5z
         TKfyYN1Tpb2KSld1O7xpfkkBcTEEqs+WtV2p2VQ1DZ9Pxl/dvXjuyhuptaIe5wOlEYcT
         l5DgjFc6lxy34FEQL9421tPPtXb3gGPlJ5O3HZ3ISsm6WXKVtWvtIpcNMYZ6TnOKVugV
         Yk4Q==
X-Gm-Message-State: ACrzQf0sKxR/dIqClZrq7boXjHk5tYs0xsanQg9zetg4swFm4KhrPxX/
        0uogni+ZjOQOgtoogvlXjzU1Ww==
X-Google-Smtp-Source: AMsMyM6sD1Pr9eVFc6gnNTiuKWVfGjowPR9KRj0qBDptnRoLcvnkhKYp34+NmU7ATCCjXNm5ebQrWg==
X-Received: by 2002:a05:6512:3e26:b0:497:3a4f:d1f with SMTP id i38-20020a0565123e2600b004973a4f0d1fmr9455339lfv.31.1663689865187;
        Tue, 20 Sep 2022 09:04:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z13-20020a2e8e8d000000b00261a8e56fe4sm23885ljk.55.2022.09.20.09.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:04:24 -0700 (PDT)
Message-ID: <62aab493-fe9b-07af-2d9a-a85ba1d1060f@linaro.org>
Date:   Tue, 20 Sep 2022 18:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add AMD DaytonaX BMC
Content-Language: en-US
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
References: <20220920153928.6454-1-aladyshev22@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920153928.6454-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 17:39, Konstantin Aladyshev wrote:
> Add initial version of device tree for the BMC in the AMD DaytonaX
> platform.


Thank you for your patch. There is something to discuss/improve.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..9eff88d410aa 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1575,6 +1575,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2600-evb-a1.dtb \
>  	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-amd-ethanolx.dtb \
> +	aspeed-bmc-amd-daytonax.dtb \
>  	aspeed-bmc-ampere-mtjade.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
> new file mode 100644
> index 000000000000..0e066b5ae0fb
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "AMD DaytonaX BMC";
> +	compatible = "amd,daytonax-bmc", "aspeed,ast2500";

Missing bindings documentation.

> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlycon";

bootargs do not belong to mainline DTS. earlycon for sure.

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fault {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Nodes are wrong.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		identify {

Ditto

> +			gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> +			<&adc 10>, <&adc 11>, <&adc 12>, <&adc 13>, <&adc 14>,
> +			<&adc 15>;
> +	};
> +};
> +
> +&fmc {

(...)


> +	fan@15 {
> +		reg = <0x07>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x0f>;
> +	};
> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> +

No need for trailing new line.

Best regards,
Krzysztof
