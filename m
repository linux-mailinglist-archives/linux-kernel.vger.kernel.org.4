Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9A628260
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiKNOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiKNOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:23:15 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15A2A73E;
        Mon, 14 Nov 2022 06:23:15 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso6720188otb.2;
        Mon, 14 Nov 2022 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kH9QzbbcRu9iwTWJWajkxWF77cOgRT2OE94g2xrIoiM=;
        b=A5Id6FqS1f0oJKc1ia6EwCy68P8oQDdPJtvfNpMfSzAgHl+0FuMKavZY/UhoZEZeys
         QbfTIeGFsiFbnb91UmXaMpW/ENyOp7ZH5Ys+mUbNV6SrzEuDElFcsJ2PSCFm54qUHSFr
         f/iAfiKs9VEX58sHmCrqgEPHWPFIYB0a+JEoDoggcAA3J4UuYBxx42kZEdH7I8k2a7H0
         edWZQFPyEHg3SZyoWWNvkJDVLOz2XYD3jbqgevRtr35mmnHZaUWeNxNmA6QtxoC5k3mG
         9rUF1F9pHI0lcOfynaqYc6KegzuiW55zt4aFvzdE9JrKqqTrCSAhESovOIQ4XKL3ciQt
         QfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH9QzbbcRu9iwTWJWajkxWF77cOgRT2OE94g2xrIoiM=;
        b=h7CDZyyHmkAxj0otHGlEEPIxonjrJfmJOvmQtXbMVjgLSZt4/8SGcW34en3xlJYjsl
         iJngXgf3BMiPxd4iVr3wFe5uoNWeVBY1xjn0WBxtDMIzZCrWfdiA+v0x2sm2fVVvme+y
         ZmSTAmyYz0QbVB6OUNLJ9fRcSK7RhSkMe7UW98s7nJNcFvP5utVhy7+w3p9+nVTgyY8K
         uk5JzMiKOHtyzkuOhmcYksqp3wZZP09wmeGpA+QH4kJjWatqnThLaBFpYDxuBmeuo5l2
         mapVn7cPG4loe3hab3h4kmiUTrurNAdejCRxTB62QjCAz585xRbvyRXkfgGNsPJ4hWuA
         SafA==
X-Gm-Message-State: ANoB5pl8euMROXdtblCmeHbZn2rwKLcY03xYDwHJ1O9/5HtJGNuVU8tr
        hyS843gN19cvUA2O4bpwk17/yOKsHS8=
X-Google-Smtp-Source: AA0mqf7SuCQEC8YQKm62BP1norgJltMmnDS9FCxT0FsecW5FiKMNuF5A/+M6HGq9bxlmdT1ml16tqw==
X-Received: by 2002:a9d:7406:0:b0:66d:6b64:dfd with SMTP id n6-20020a9d7406000000b0066d6b640dfdmr5461208otk.2.1668435794297;
        Mon, 14 Nov 2022 06:23:14 -0800 (PST)
Received: from wintermute. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id h24-20020a9d6f98000000b00661b46cc26bsm4128816otq.9.2022.11.14.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:23:13 -0800 (PST)
Message-ID: <63724f51.9d0a0220.bdb2c.ea2e@mx.google.com>
X-Google-Original-Message-ID: <20221114142305.GA9693@wintermute.>
Date:   Mon, 14 Nov 2022 08:23:05 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?iso-8859-1?Q?Jo=E3o_H_=2E?= Spies <jhlspies@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: rockchip: Add Anbernic RG351M
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
 <20221112143411.517906-6-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112143411.517906-6-maccraft123mc@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 03:34:11PM +0100, Maya Matuszczyk wrote:
> This device is a clone of Odroid Go Advance, with added PWM motor, internal
> gamepad connected on USB instead of just having it be on GPIO + ADC, and
> missing battery shunt resistor.

I have concerns about using the rk817 battery driver with no shunt
resistor. For the moment, that would result in wrong values being
given for battery capacity and current. What could be done is to
update the driver to only check voltage values when the shunt
resistor is missing (since it's the current values and columb counter
that gets affected with no resistor in place). For now though, I'd
just remove the battery and charger since it's going to report the
wrong data to users.

> 
> There's also an LED on GPIO 77(I *guess* PB5 on &gpio2), that is controlled in a weird way:
> 
> - It is set to red by setting output value to 1
> - Set to green by setting output value to 0
> - Set to yellow by setting gpio direction to input
> 
> I have no idea how to describe that in DTS, without adding a custom
> driver, for now it's just left out.

Check out this document, it says you'd group them together under a
multicolor led node:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml

> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../dts/rockchip/rk3326-anbernic-rg351m.dts   | 54 +++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 142c83d2e5aa..b379516c15eb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-anbernic-rg351m.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
> new file mode 100644
> index 000000000000..7f4726d4130e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Hardkernel Co., Ltd
> + * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
> + * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "rk3326-odroid-go.dtsi"
> +
> +/ {
> +	model = "Anbernic RG351M";
> +	compatible = "anbernic,rg351m", "rockchip,rk3326";
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		charge-full-design-microamp-hours = <3450000>;
> +		charge-term-current-microamp = <300000>;
> +		constant-charge-current-max-microamp = <2000000>;
> +		constant-charge-voltage-max-microvolt = <4200000>;
> +		factory-internal-resistance-micro-ohms = <100000>;
> +		voltage-max-design-microvolt = <4100000>;
> +		voltage-min-design-microvolt = <3500000>;
> +
> +		ocv-capacity-celsius = <20>;
> +		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
> +					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
> +					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
> +					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
> +					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
> +					<3574170 0>;
> +	};
> +
> +	vibrator {
> +		compatible = "pwm-vibrator";
> +		pwms = <&pwm0 0 1000000 0>;
> +		pwm-names = "enable";
> +	};
> +};
> +
> +/delete-node/ &builtin_gamepad;
> +/delete-node/ &vcc_host; /* conflicts with pwm vibration motor */
> +
> +&internal_display {
> +	compatible = "elida,kd35t133";
> +};
> +
> +&pwm0 {
> +	status = "okay";
> +};
> +
> +&rk817_charger {
> +	monitored-battery = <&battery>;
> +};
> -- 
> 2.38.1
> 
