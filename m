Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02435E6E65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIVV2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiIVV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:28:09 -0400
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 14:28:09 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9610F736
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:28:08 -0700 (PDT)
Message-ID: <659fc2fe-f820-04ad-8a4f-224b4d4bd97b@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1663881758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYMCYi0P3f0uCs3zXu9KgEbi+wTwz81X89dKXGgBfIo=;
        b=JnAKBACcsruAYDfVZcI5L8Dy8qhkZQMYhEYqqFRu9iscTDdGVSeRbyM8Kz4e3GNO4lw5pt
        +iO2qmp2N8Hn/QtGZSuQEA8vyz7IoTTYWGqWV8RJCTjIFB3+4PMvUe/07xIsRw6mF2V7jZ
        6zmBseXq2OyciOnMA7dGCRKJuWikOTE1jd5ny0RR0SYXEvrZGlnpZFWjiTr7RwUxvPD8IT
        IegQIlu948/Dc0zokruQrCou/TT5IQaP4I7tsftNRMGrG5SUNn64ZkYqyD0wsAt8JI5Zzm
        zwCLXLEO6aLXmPEaWWmpjX7koyZRCcdy1UufqQTShmgB3Xp6A47Oq2+k387m/g==
Date:   Thu, 22 Sep 2022 23:22:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI and GPU on quartz64-b
Content-Language: da-DK
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920143446.633956-1-frattaroli.nicolas@gmail.com>
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <20220920143446.633956-1-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be based against linux-next and not mainline. It fails to 
apply on mainline for me.

Den 20.09.2022 kl. 16.34 skrev Nicolas Frattaroli:
> This enables the GPU and HDMI output (including HDMI audio) on
> the PINE64 Quartz64 Model B single board computer.
>
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>   .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 60 +++++++++++++++++++
>   1 file changed, 60 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 0f623198970f..77b179cd20e7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -4,6 +4,7 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>   #include "rk3566.dtsi"
>   
>   / {
> @@ -28,6 +29,17 @@ gmac1_clkin: external-gmac1-clock {
>   		#clock-cells = <0>;
>   	};
>   
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   
> @@ -183,6 +195,33 @@ &gmac1m1_clkinout
>   	status = "okay";
>   };
>   
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	status = "okay";
>   
> @@ -456,6 +495,10 @@ &i2c5 {
>   	status = "disabled";
>   };
>   
> +&i2s0_8ch {
> +	status = "okay";
> +};
> +
>   &i2s1_8ch {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2s1m0_sclktx
The above part does not seem to exist in the current mainline (rc6) git 
repo.
> @@ -677,3 +720,20 @@ &usb_host0_ehci {
>   &usb_host0_ohci {
>   	status = "okay";
>   };
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
