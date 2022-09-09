Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663D5B41BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIIVxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIIVxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:53:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4829EC743;
        Fri,  9 Sep 2022 14:53:34 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWlwE-0008Pa-Qn; Fri, 09 Sep 2022 23:53:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add regulator suffix to BPI-R2-Pro
Date:   Fri, 09 Sep 2022 23:53:26 +0200
Message-ID: <17097488.0ZKypZ73Fx@diego>
In-Reply-To: <20220906155503.10971-1-linux@fw-web.de>
References: <20220906155503.10971-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 6. September 2022, 17:55:03 CEST schrieb Frank Wunderlich:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add -regulator suffix to regulator names on Banana Pi R2 Pro board as
> discussed on Mailinglist
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

looks like my b4 thanks mail got lost, so manually:

applied for 6.1

Thanks
Heiko

> ---
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220825193836.54262-6-linux@fw-web.de/
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index 7a8d55a898f5..432469697544 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -46,7 +46,7 @@ green_led: led-1 {
>  		};
>  	};
>  
> -	dc_12v: dc-12v {
> +	dc_12v: dc-12v-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "dc_12v";
>  		regulator-always-on;
> @@ -66,7 +66,7 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> -	vcc3v3_sys: vcc3v3-sys {
> +	vcc3v3_sys: vcc3v3-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc3v3_sys";
>  		regulator-always-on;
> @@ -76,7 +76,7 @@ vcc3v3_sys: vcc3v3-sys {
>  		vin-supply = <&dc_12v>;
>  	};
>  
> -	vcc5v0_sys: vcc5v0-sys {
> +	vcc5v0_sys: vcc5v0-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_sys";
>  		regulator-always-on;
> @@ -146,7 +146,7 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
>  		vin-supply = <&vcc3v3_pi6c_05>;
>  	};
>  
> -	vcc5v0_usb: vcc5v0_usb {
> +	vcc5v0_usb: vcc5v0_usb-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_usb";
>  		regulator-always-on;
> @@ -156,7 +156,7 @@ vcc5v0_usb: vcc5v0_usb {
>  		vin-supply = <&dc_12v>;
>  	};
>  
> -	vcc5v0_usb_host: vcc5v0-usb-host {
> +	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
>  		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> @@ -168,7 +168,7 @@ vcc5v0_usb_host: vcc5v0-usb-host {
>  		vin-supply = <&vcc5v0_usb>;
>  	};
>  
> -	vcc5v0_usb_otg: vcc5v0-usb-otg {
> +	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
>  		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> 




