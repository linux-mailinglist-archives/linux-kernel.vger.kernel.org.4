Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A25E76B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiIWJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIWJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:19:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613FFAD7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:19:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f9so18840294lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kn1SujOTRSyA2lpFvTg92J/mHIxi4T22q5/4Og5DL18=;
        b=Eravv2cszM2onFllxNWqYfBkD2740qBYFMRrXIf/p9/edgz7MSfXRZdUAyJ2AaU3vC
         Mdz+alj2diNP/8pOAzvz3iRVzsPgFAMP8pZuwVy4EMwG+p3JIHRHdwS8KvHzmWjm0WFD
         YwHr1fiqKz1ijvu+1ezC7ufTqVnYqE8x6MoVAP3RX38AfAzYvVMxAd23G5CXD/L0Dk/Q
         qy/UsJUcbonOM68PnejWezrVckk9dqriUPgTWZQCtA3LETESFBcDxT46EqDVm83rEcn9
         VjMwMczMe9F7mc2DZZxDOIVxmpyG0qcWW6faK1eJ74cuApyVV2LsFfktYCX6kgQBTqS9
         aW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kn1SujOTRSyA2lpFvTg92J/mHIxi4T22q5/4Og5DL18=;
        b=w/9HiCM1pIfN971BlmMGuXKdm7wx9R4KsjbDMaMiiHa5/xxC1yoOslVd3zUJVy0dOP
         zxR2lCxmAHuMfyQGFKUdwTCKQIwXPDpYScTC3ipxFzyskQm3nEeKNDUSc9M+SlsowX+L
         mdaeTc2pKgisSkeHcpkds4R5ly35t8ZOLXCyIOuwGP/8KYYsytvKNHneqDjlSdikQUyh
         lGxivYJW5pmsFLR7/xARpTZHNXHU+OSkiWs0RRDTGXDqouMtApYLrs4uXp3NtNM5l6pk
         IoAz6A+NzRgPRqMVG/YyrG+MuKNfBsD0nmBG2y7VFDll1mxV1/Nc4CT07zjhbNJjwVsM
         qyeQ==
X-Gm-Message-State: ACrzQf1KLO5FYUkGZRH0szJQE+2krU0ZjIr3WTWQk+9IxFjpbmr3dmm0
        5ChWHTwofmOood+OWMoAw8vuZA==
X-Google-Smtp-Source: AMsMyM7rAP554ffKv14+G5Z04osY2Lbv/LSvwWpONmenm703lxvFiMvD7gT95QU2MxQKWO3kXuJzyQ==
X-Received: by 2002:a05:6512:10ce:b0:49e:ad1f:3d7 with SMTP id k14-20020a05651210ce00b0049ead1f03d7mr2653889lfg.609.1663924763678;
        Fri, 23 Sep 2022 02:19:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g20-20020a2ea4b4000000b0026bddcf75d1sm1294971ljm.44.2022.09.23.02.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:19:23 -0700 (PDT)
Message-ID: <8a256c49-1a7a-42bb-2daf-cc0c66b9f7a6@linaro.org>
Date:   Fri, 23 Sep 2022 11:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
Content-Language: en-US
To:     Mauri Sandberg <maukka@ext.kapsi.fi>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-3-maukka@ext.kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922202458.7592-3-maukka@ext.kapsi.fi>
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

On 22/09/2022 22:24, Mauri Sandberg wrote:
> Add a device tree for D-Link DNS-323. The device has three different
> variants; A1, B1 and C1. Common parts are included in a .dtsi file
> and each hardware variant has its own .dts file.

Thank you for your patch. There is something to discuss/improve.

> +
> +/delete-node/ &sata;
> +
> +&gpio0 {
> +	pinctrl-0 = <&pmx_gpio_misc>;
> +	pinctrl-names = "default";
> +
> +	/* The DNS323 rev A1 power LED requires GPIO 4 to be low. */
> +	pin_gpio0_4 {

No underscores in node names.

> +		gpio-hog;
> +		gpios = <4 GPIO_ACTIVE_LOW>;
> +		output-high;
> +		line-name = "Power led enable";
> +	};
> +};
> +
> +&pmx_gpio_misc {
> +	marvell,pins = "mpp4";
> +};
> +
> +&pmx_ge {
> +	marvell,pins = "mpp11", "mpp12", "mpp13", "mpp14", "mpp15",
> +		       "mpp16", "mpp17", "mpp18", "mpp19";
> +};
> diff --git a/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts b/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
> new file mode 100644
> index 000000000000..e01ba809ffca
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include "orion5x-mv88f5182.dtsi"
> +#include "orion5x-dlink-dns323.dtsi"
> +
> +/ {
> +	model = "D-Link DNS-323 rev B1";
> +	compatible = "dlink,dns323b1", "dlink,dns323", "marvell,orion5x-88f5182",
> +		     "marvell,orion5x";
> +};
> +
> +&gpio0 {
> +	pinctrl-0 = <&pmx_gpio_misc>;
> +	pinctrl-names = "default";
> +
> +	/* The rev B1 has a flag to indicate the system is up.
> +	 * Without this flag set, power LED will flash and cannot be
> +	 * controlled via gpio-leds.
> +	 */
> +	pin_gpio0_3 {

No underscores in node names.

Best regards,
Krzysztof

