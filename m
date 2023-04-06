Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502056D9DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjDFQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjDFQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:40:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2C8A255
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:40:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n21so2838816ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680799201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hmuub5XFek/J7yZRXiFvjEFpOewLgR0Tr6Mam0kUoMQ=;
        b=drMJmyIYsxy1uh3byBCf9+TGbQYwfEa5KyPf1dWWZ8Xfro9/3/ifv5I8Htcd2BuIyA
         D8FdlbmK0c7ubKLkXfG6DNI5aqaSrq4blwwMszvssap4j0Y0sn8htsufiprFq9vmDIj6
         NCKFJfjgKNuyPetKR6J4i9MQT2HZQ1KNKzcMmA9yjBUouzSekSBhRmM2LQwCx6qM8cft
         kuj25spDIuHbsLcLA3WJu6ljlPed9yx6dUdPESHZUQJVXv9Sm4W+sdwgBYdNJdSsEh+T
         TjPmOsE93oo6SFID1YuVOeJCuANgn6m3XhiMCF8PZp1SmN4dmKyoOPV8HzJT3jntpggP
         peSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmuub5XFek/J7yZRXiFvjEFpOewLgR0Tr6Mam0kUoMQ=;
        b=056dfxPQpdePyzSgJjpSLiVpbx7/p8GUlDDjZZnmuyfqg7bJ0PW3XpbK5fQqM084/c
         K+m3il/3tbItiqfHlolPltMSTwWRThf99Ae0RypfFFNJJWUbyvErV6oprnaQ9vuMz2JV
         MQS3TFRXaB0WCc1C4UaS3kWClmHg50LsjQi2b6nbSE2DCsx22DA95CPOkLiC+4C4Jex3
         skhuQU9iIcA244sAOHntbGOzfXhei5pB/C6TP+88udvO8OvbnWlStAUynmQOTqi2qDw/
         i1peWa8QrD3ZClIjDWDIO9UxxxMx5mszMILU1JBEUlyP3TeMqD7XHl4isF8yKhMBZJG8
         yDUQ==
X-Gm-Message-State: AAQBX9e8g0tM/MRriVvA/An5wE7dAkoJBj1Xach4Yz2sVV3gmOH/FoQD
        IXke6XbyCDA5dFTtNhH2y1xpEw==
X-Google-Smtp-Source: AKy350Z3yzs/hx03BNLuEf7YJao+6JsqUiyCFSpQAmDH3M8D2LwjqjBQxJxdXxZhmwwBH+iGutWkBg==
X-Received: by 2002:a17:907:c0f:b0:949:87f1:2ca0 with SMTP id ga15-20020a1709070c0f00b0094987f12ca0mr6267574ejc.71.1680799200921;
        Thu, 06 Apr 2023 09:40:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id fy8-20020a170906b7c800b0093e23d03d72sm1022593ejb.177.2023.04.06.09.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:40:00 -0700 (PDT)
Message-ID: <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
Date:   Thu, 6 Apr 2023 18:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406154900.6423-3-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:49, Christoph Niedermaier wrote:
> Add support for Marantec maveo box. The system is used to get a
> smart conntection to a door drive. It has USB, WiFi, Bluetooth,
> Zigbee and NFC interfaces. The core of this system is a soldered
> i.MX6ULL DHCOR SoM from DH electronics.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Correct the vendor prefix
>     - Change pinconfig of User and Reset button
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts | 361 ++++++++++++++++++++++++++
>  2 files changed, 362 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index aa8fb4b7cdcc..58d3334164e2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -751,6 +751,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-dhcom-drc02.dtb \
>  	imx6ull-dhcom-pdk2.dtb \
>  	imx6ull-dhcom-picoitx.dtb \
> +	imx6ull-dhcor-maveo-box.dtb \
>  	imx6ull-jozacp.dtb \
>  	imx6ull-kontron-bl.dtb \
>  	imx6ull-myir-mys-6ulx-eval.dtb \
> diff --git a/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts b/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> new file mode 100644
> index 000000000000..83bacac19933
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2023 DH electronics GmbH
> + * Copyright (C) 2023 Marantec electronics GmbH
> + *
> + * DHCOM iMX6ULL variant:
> + * DHCR-iMX6ULL-C080-R051-SPI-WBT-I-01LG
> + * DHCOR PCB number: 578-200 or newer
> + * maveo box PCB number: 525-200 or newer
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ull-dhcor-som.dtsi"
> +
> +/ {
> +	model = "DH electronics i.MX6ULL DHCOR on maveo box";
> +	compatible = "marantec,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
> +		     "fsl,imx6ull";
> +
> +	aliases {
> +		/delete-property/ mmc0; /* Avoid double definitions */

I don't understand it. What is "double definition" of aliases?

> +		/delete-property/ mmc1;
> +		mmc2 = &usdhc2; /* eMMC should be mmc2 */

Why? How is this labeled on the board (physically or on schematics)? If
you answer here "for booting", then the answer is NAK. Don't add
software policies to Devicetree.

Best regards,
Krzysztof

