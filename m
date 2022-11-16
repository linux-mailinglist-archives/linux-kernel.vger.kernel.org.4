Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8062CC54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiKPVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiKPVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:10:07 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA6F25;
        Wed, 16 Nov 2022 13:09:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n21so22149ejb.9;
        Wed, 16 Nov 2022 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ns1LjN7LDOisfItghrtwfAVBSGRle5+9Se4Swypp1g=;
        b=M8uEQNFgXgozUQo4QSSqKH8obmhXwRnk0caYpEaYa1iwX6nbAK8kV3ibaRQ6xY24or
         uQFVF40LwzRx+JbPh42rUtxZ26ROM0dAvHR0AjAD375f+cd+I7caz9QQZK8N+n0wBcZp
         84vEs3d64vJVTKeJvOmPBcElLYQdmYFaXJSP+jkDk15xJWcennQLTX9sA2hiQfYZFas4
         YhTdTe91TeZq7nZsXH/nxftykYXMtl/Wik69Sopcx8VFia7ki3kKcHLSlFjHP2oRr2m3
         AVmGpJJifwFjDtQAOHfkJ3hwzhQi9gxdpMiSKBqu54mUliJ4lVxt5Uzc10+mKtil+TbW
         A93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ns1LjN7LDOisfItghrtwfAVBSGRle5+9Se4Swypp1g=;
        b=iNG4zcmpFKwdej1NoHJYjhqqxeXOblV96BsMJjWphAWPcO2BdZdoLJ4b1RZ+DEDsT3
         WpmwmhrlnVmVll7mZyEBF02F02gLiVFzszBpKRl3krxaze1oqYweE2SBD/b+HqyxwTsK
         dyUVZsESUdrx0IZM9oUqa9Bc95OuYTWwPutgvLimSnHKJVeadpCaEuzII26AGu3mZGMn
         mJQpYrKadHMO7hZyq6gVffnAru3RXts2GMyGjVk7kN3eKukTB8nzXxKJr+xR5xMct24b
         bJVj11+rnL5t04HHU1Z8IvfAxIMyAsAulZOErhnJIcMNzeKzTorgeCYZYRvv7CJ1fRqU
         0xpw==
X-Gm-Message-State: ANoB5pmUAFUyojmrkkmnZXzTSi6V/k306tER7USVrRN8cUQtQagNeh4U
        Q+TaaIqvy6Tvnza2kbdNyEgY3kcaKPQ=
X-Google-Smtp-Source: AA0mqf4BjVjZFroaSuB8MBzrMoVmm84KlFri1SoXR5d2638IsydqP4mwAwGlZTkxC/i8Conf1OoYpQ==
X-Received: by 2002:a17:906:6893:b0:7ad:14f8:7583 with SMTP id n19-20020a170906689300b007ad14f87583mr20075501ejr.185.1668632990289;
        Wed, 16 Nov 2022 13:09:50 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007ad96726c42sm4786736ejf.91.2022.11.16.13.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 13:09:49 -0800 (PST)
Message-ID: <51383b41-6b02-df0f-797a-5336799fd097@gmail.com>
Date:   Wed, 16 Nov 2022 22:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 4/5] arm64: dts: rockchip: Add rk3588-evb1 board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com
References: <20221115161702.163057-1-sebastian.reichel@collabora.com>
 <20221115161702.163057-5-sebastian.reichel@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20221115161702.163057-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more comments.
Have a look if it's useful...

On 11/15/22 17:17, Sebastian Reichel wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC,
> connect via UART or Ethernet.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
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

This list used to be sort on description.
Since rk3566/rk3568 it's out of order. Heiko?

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
> index 000000000000..38413517f2eb
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

sort includes

> +
> +/ {
> +	model = "Rockchip RK3588 EVB1 V10 Board";
> +	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> +

alias for i2c2, uart2, gmac0

> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	vcc12v_dcin: regulator-vcc12v-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <
> +			  0  20  20  21  21  22  22  23
> +			 23  24  24  25  25  26  26  27
> +			 27  28  28  29  29  30  30  31
> +			 31  32  32  33  33  34  34  35
> +			 35  36  36  37  37  38  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255
> +		>;
> +		default-brightness-level = <200>;
> +
> +		pwms = <&pwm2 0 25000 0>;
> +		power-supply = <&vcc12v_dcin>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-mode = "rgmii-rxid";
> +	clock_in_out = "output";
> +
> +	snps,reset-gpio = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +
> +	tx_delay = <0x43>;
> +	rx_delay = <0x00>;
> +
> +	phy-handle = <&rgmii_phy>;
> +	status = "okay";
> +};
> +
> +&mdio0 {

> +	rgmii_phy: phy@1 {

rgmii_phy: ethernet-phy@1 {

From phy-provider.yaml:

properties:
  $nodename:
    pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"

The phy nodename is used by a phy-handle.
The parent node is compatible with "snps,dwmac-mdio",
so change nodename to 'ethernet-phy', for which '#phy-cells'
is not a required property

> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;

> +		#phy-cells = <0>;

remove

Also for rock-5a board.

> +	};
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
> +

> +&i2c2 {

sort node name

> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +

> +&pinctrl {

sort node name

> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +};
> +

> +&pwm2 {

sort node name

> +	status = "okay";
> +};
