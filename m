Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A061F471
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiKGNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKGNfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:35:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FE7645
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:35:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k19so16296871lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2X11AN1SE9WqF7OA+kOwYlhtKODo1MfSxaBEdQklt34=;
        b=NsfpxFs2pgdaHF4BIFWkwJPEWJ9Ade5lEW522ecITl/cn6xLvG0BDAsAQw4e8QTZ4F
         dCpQc2ePGst74bNWHTGLRV+fE2LG+kjYmyPILoQcJYPPIUI4c5SLlOMlonYus2jPoqAl
         mkf53PuA7MgDlMVjXGcNpx+aPKnxVYDEpkMd221dIpRYTSKSzGzEZ8fm+BGDz20L4Ujw
         LcBkXxc5lfd0n+FhEtpeSvm+ISJMLKgaASEiCKta3/39kd/iJUjvFbnXwxmm/xU9M8Q3
         wmVBuPy9zX+4e46dJCxGFnMv7qjcFqd/Y7aYBp3g34KnHLr///6DTTHjLxBZegmoGTgA
         v+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2X11AN1SE9WqF7OA+kOwYlhtKODo1MfSxaBEdQklt34=;
        b=yp9Dg9csqVUcdZ4tYtDFOd1zANP0/e+IfVZQUUKopKMhnZWrPlc6oDvCBuCEIO8zCZ
         IOXP/wiwXqmrHKeaqxRp9WGr987FLfqjAJSs+bI52WuxuXiJW3gE3iigm41kmgQiFpls
         jaPDlb3ikVbfOI79f9/LWRlC3+ZgpvZvvItUcBod5+PGqp7SHFL6oubeqXcKI7xX5rCs
         Vc+kLGhDDkxlaAp7vSrOBpckgXYNRap1sHs9sShalOaRcEaMC9afz5hpvCbHZeGqb8OL
         9kLi9OsM1Fw9h013rXRp+PJJ0KlMCQxmtw4DrxyGsTGHnC/yMXfTVKRQzotlmTcWA/gb
         sM6A==
X-Gm-Message-State: ACrzQf1q+rMaSk87mrl1YxfP5ZbXkuhrPkaKi6oVP1Z0EgiURMNDYdcB
        FL9E0NiOZLlN5NC5MmSeMCffVw==
X-Google-Smtp-Source: AMsMyM796nt46SusQqsu1uIL2Q58WRXC8mYoYB4qnqdI4aWn51zoQ6aA+xRQYMVxkMtTY13XG8aZaQ==
X-Received: by 2002:a2e:a237:0:b0:277:746:62c2 with SMTP id i23-20020a2ea237000000b00277074662c2mr5921036ljm.236.1667828148799;
        Mon, 07 Nov 2022 05:35:48 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id p19-20020a2eb113000000b0026dfbdfc1ddsm1244075ljl.11.2022.11.07.05.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:35:48 -0800 (PST)
Message-ID: <8b56062f-946d-b28d-a050-99dbf4c856df@linaro.org>
Date:   Mon, 7 Nov 2022 14:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 3/3] arm64: dts: ti: k3-am68-sk: Add support for AM68
 SK base board
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20221107123852.8063-1-sinthu.raja@ti.com>
 <20221107123852.8063-4-sinthu.raja@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107123852.8063-4-sinthu.raja@ti.com>
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

On 07/11/2022 13:38, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The SK architecture comprises of baseboard and a SOM board. The
> AM68 Starter Kit's baseboard contains most of the actual connectors,
> power supply etc. The System on Module (SoM) is plugged on to the base
> board. Therefore, add support for peripherals brought out in the base
> board.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V2:
> *Addressed the review comments:
>  - Updated the commit description.
>  - Updated the regulator nodes: fixedregulator to "regulator-"
>  - Updated the commit $subject to align with rest of the commits.
>  - Dropped the blank lines
>  - Changed the node names that are added with underscore("_") with "-"
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-3-sinthu.raja@ti.com/
>  
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 447 ++++++++++++++++++
>  2 files changed, 449 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..eeeebda30e3d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -12,6 +12,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
> +
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> new file mode 100644
> index 000000000000..ad727495e99b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Base Board: https://www.ti.com/lit/zip/SPRR463
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am68-sk-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +
> +/ {
> +	compatible = "ti,am68-sk", "ti,j721s2";
> +	model = "Texas Instruments AM68 SK";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	aliases {
> +		serial2 = &main_uart8;
> +		mmc1 = &main_sdhci1;
> +		can0 = &mcu_mcan0;
> +		can1 = &mcu_mcan1;
> +		can2 = &main_mcan6;
> +		can3 = &main_mcan7;
> +	};
> +
> +	vusb_main: regulator-vusb-main5v0 {
> +		/* USB MAIN INPUT 5V DC */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vusb-main5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: regulator-vsys3v3 {
> +		/* Output of LM5141 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vusb_main>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-sd {
> +		/* Output of TPS22918 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: gpio-regulator-tlv71033 {

regulator-tlv... not gpio-regulator.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		/* Output of TLV71033 */
> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_3v3>;
> +		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
Best regards,
Krzysztof

