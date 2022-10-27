Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAC60FB04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiJ0O7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiJ0O7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:59:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF43AF53
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:59:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z30so1072400qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsQVftKSeBAc1FbMNJ35HF2pgqCq1gNRi3OVMUbJA30=;
        b=H6mjRFz9bKTBGET0cIaEajnv1a9/LQ6ojXq8xpg3JdPEvWTzteKUm8ggA8TNOTqip+
         NvTeAzaBYcGBmNclHrqexy/c1jDbht/2LK76s9cCVKJTrsq/M26MpH9SAr/q6TsvYXE4
         B1BeD1A/JBohH2FvRqeoX/kHniSnk8Uh9IfFhX3TRMhlgLl4sfTUClUsm5UkOG8YvJwZ
         FZGFvkoc2UsuK7bE2kqg0nfSaf5X41YxRtpPobxCVRNRO9Qbi4ERufAfJoXOzqnymK0p
         ADQR2T0jn9jOmvfNDb5d48CO/MCJY9hWj7RfTuJproiTSGoXLBQAOebTIzkVMFwyn4ic
         Ra0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsQVftKSeBAc1FbMNJ35HF2pgqCq1gNRi3OVMUbJA30=;
        b=MBDLfNh4sAOl6oywCBgzfp4E8tl9wz9esECLYGdp+y+69vsXME0mifz71vkXd6y6uw
         O13V6FXmaRx+9UYnwem2hwlb3aL9jp4Vd/qdseA15gKjdvPqT9DSsGCz8tzcIC1ZD+ol
         gdkAnAneAXv/jRdJlKR5LNWfooVGRptBovDRihng/3YpzlyQ7fXSw13tDAymRXpan9F7
         AgkHdgA+g9UOv1RCfy+lDipR8AYgR6DdxInxR4dSTP2Plr019Y1epl3yVheevssFkV/8
         xQUosbCYDmt3Mr7eTyOvYuPnAPzI3QQTX//WznARyMr+nhyQVVkY3Z5V/pj7SvKU4dhp
         ACjw==
X-Gm-Message-State: ACrzQf0QDlpCtbt51wClKJs0Xb0aWUSJhiCzGAWIM3J0tnIpHw8Y2i0V
        NoXjW8Mb1Ou5g0jhP9zMRlmXmw==
X-Google-Smtp-Source: AMsMyM55HGtvEs91o/AnOm1jyLgdQjFebhs2S+lDBlp0J8R+GXQThXx6GckPGpFjWXZu/LjC33Chow==
X-Received: by 2002:a05:620a:45ac:b0:6f8:7c0c:20f with SMTP id bp44-20020a05620a45ac00b006f87c0c020fmr8425800qkb.270.1666882767987;
        Thu, 27 Oct 2022 07:59:27 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006cfc01b4461sm1091819qko.118.2022.10.27.07.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:59:27 -0700 (PDT)
Message-ID: <35ed0b8f-04f1-d544-a0d8-19d12e7c0ef8@linaro.org>
Date:   Thu, 27 Oct 2022 10:59:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 4/4] ARM: dts: rockchip: add rk3128-evb.dts
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
        heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
 <e0679728-7a15-50e1-8a5e-847db1528726@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e0679728-7a15-50e1-8a5e-847db1528726@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 20:54, Johan Jonker wrote:
> Add rk3128-evb.dts
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile       |   1 +
>  arch/arm/boot/dts/rk3128-evb.dts | 105 +++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3128-evb.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 68ac9b360..0f26539d2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1127,6 +1127,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3066a-marsboard.dtb \
>  	rk3066a-mk808.dtb \
>  	rk3066a-rayeager.dtb \
> +	rk3128-evb.dtb \
>  	rk3188-bqedison2qc.dtb \
>  	rk3188-px3-evb.dtb \
>  	rk3188-radxarock.dtb \
> diff --git a/arch/arm/boot/dts/rk3128-evb.dts b/arch/arm/boot/dts/rk3128-evb.dts
> new file mode 100644
> index 000000000..6ad4549d5
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3128-evb.dts
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2017 Rockchip Electronics Co., Ltd
> + */
> +
> +/dts-v1/;
> +
> +#include "rk3128.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3128 Evaluation board";
> +	compatible = "rockchip,rk3128-evb", "rockchip,rk3128";
> +
> +	aliases {
> +		mmc0 = &emmc;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	memory@60000000 {
> +		device_type = "memory";
> +		reg = <0x60000000 0x40000000>;
> +	};
> +
> +	vcc5v0_otg: vcc5v0-otg-drv {

Generic node names, so at least regulator prefix or suffix.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_otg";
> +		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&otg_vbus_drv>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-drv {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		gpio = <&gpio2 23 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_vbus_drv>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "xin32k";
> +	};
> +};
> +
> +&usb2phy {
> +	status = "okay";
> +};
> +
> +&usb2phy_host {
> +	status = "okay";
> +};
> +
> +&usb2phy_otg {
> +	status = "okay";
> +};
> +
> +&usb_host_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host_ohci {
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	vbus-supply = <&vcc5v0_otg>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	usb_otg {

No underscores in node names

> +		otg_vbus_drv: otg-vbus-drv {
> +			rockchip,pins = <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb_host {

Ditto

> +		host_vbus_drv: host-vbus-drv {
> +			rockchip,pins = <2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> --
> 2.20.1
> 

Best regards,
Krzysztof

