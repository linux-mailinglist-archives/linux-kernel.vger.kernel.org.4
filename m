Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6465BADF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiIPNSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIPNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:17:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547CA3D16;
        Fri, 16 Sep 2022 06:17:55 -0700 (PDT)
Received: from [89.101.193.70] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZBE5-000384-PT; Fri, 16 Sep 2022 15:17:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: k3566-quartz64-a: fix names entries, refactor
Date:   Fri, 16 Sep 2022 15:17:48 +0200
Message-ID: <1916265.yKVeVyVuyW@phil>
In-Reply-To: <YyRxp7pDCyikNLGc@lab.hqhome163.com>
References: <YyRxp7pDCyikNLGc@lab.hqhome163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro,

Am Freitag, 16. September 2022, 14:52:55 CEST schrieb Alessandro Carminati:
> Fix esisting "No underscores in node names" general rule, and prepare for
> new board versions.

if there is an "and" in your patch message, this always is a strong
indication that things want to be multiple patches, doing things separately.

- regulator node names
- and the separation + move

at least.


> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  2 +-
>  ...-quartz64-a.dts => rk3566-quartz64-a.dtsi} | 27 ++++++++-----------
>  .../dts/rockchip/rk3566-quartz64-a.usb3.dts   |  9 +++++++
>  3 files changed, 21 insertions(+), 17 deletions(-)
>  rename arch/arm64/boot/dts/rockchip/{rk3566-quartz64-a.dts => rk3566-quartz64-a.dtsi} (97%)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index ef79a672804a..97ec6c156346 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -59,7 +59,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> -dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.usb3.dtb

I don't think we're using dots to denote separation.
Just use another dash ("-").

>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> rename to arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
> index d943559b157c..ac3da5b2c1b2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
> @@ -28,7 +28,7 @@ gmac1_clkin: external-gmac1-clock {
>  		#clock-cells = <0>;
>  	};
>  
> -	fan: gpio_fan {
> +	fan: fan {

I do think "gpio-fan" with a dash might be nicer, as we don't
have an address that indicates which fan it is.

>  		compatible = "gpio-fan";
>  		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map = <0    0
> @@ -38,7 +38,7 @@ fan: gpio_fan {
>  		#cooling-cells = <2>;
>  	};
>  
> -	hdmi-con {
> +	hdmi-connector {
>  		compatible = "hdmi-connector";
>  		type = "a";
>  
> @@ -116,7 +116,7 @@ simple-audio-card,codec {
>  		};
>  	};
>  
> -	vcc12v_dcin: vcc12v_dcin {
> +	vcc12v_dcin: vcc12v-dcin {

The newly agreed on scheme is to have  "-regulator" at the end

	vcc12v_dcin: vcc12v-dcin-regulator {

would be the new name.

Heiko


