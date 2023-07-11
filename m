Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985D74F0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGKNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGKNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:51:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFEA6;
        Tue, 11 Jul 2023 06:51:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36BDoi1R079883;
        Tue, 11 Jul 2023 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689083444;
        bh=/YUB4GBbaphoaU9tJr7wui9tOQdC4Ic8TH3McZncG7k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rWrnAI1/BEWCBJMUUx3PnQ60mwHulcHh4ICI+iQXi5/z+PwIbvOMD8g780k6FP+f8
         0onsIjeYCq52zN2jb67/AFV6+fcHjPAIz5V7KOFvLwI8Tf88ANQMdfKfPGIeVnywOk
         6Cxk41f8ZGl1SptWXk8/4l8WcDWYL3b80+KeQgEc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36BDoigI115156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 08:50:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 08:50:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 08:50:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36BDoib4070789;
        Tue, 11 Jul 2023 08:50:44 -0500
Date:   Tue, 11 Jul 2023 08:50:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: ti: add missing space before {
Message-ID: <20230711135044.5m3juyupjuha5up5@handwork>
References: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:57-20230705, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts | 2 +-
>  arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 2 +-
>  arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts    | 8 ++++----

Tony: Could you pick this up?

Reviewed-by: Nishanth Menon <nm@ti.com>

>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts b/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
> index afd04a423856..17a1632a8ac1 100644
> --- a/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
> +++ b/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
> @@ -391,7 +391,7 @@ &spi1 {
>  	pinctrl-names = "default";
>  	cs-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
>  
> -	display@0{
> +	display@0 {
>  		compatible = "lego,ev3-lcd";
>  		reg = <0>;
>  		spi-max-frequency = <10000000>;
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> index 8949578e62e8..2062fe561642 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> @@ -137,7 +137,7 @@ uart01_spi2_pins: uart01-spi2-pins {
>  				>;
>  			};
>  
> -			dfesync_rp1_pins: dfesync-rp1-pins{
> +			dfesync_rp1_pins: dfesync-rp1-pins {
>  				pinctrl-single,bits = <
>  					/* DFESYNC_RP1_SEL */
>  					0x0 0x0 0x2
> diff --git a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
> index 863552393c07..edaddc7b6a5e 100644
> --- a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
> +++ b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
> @@ -58,7 +58,7 @@ vdd_core: fixed-regulator-vdd_core {
>  		vin-supply = <&vdd_corereg>;
>  	};
>  
> -	v1_8dreg: fixed-regulator-v1_8dreg{
> +	v1_8dreg: fixed-regulator-v1_8dreg {
>  		compatible = "regulator-fixed";
>  		regulator-name = "V1_8DREG";
>  		regulator-min-microvolt = <1800000>;
> @@ -68,7 +68,7 @@ v1_8dreg: fixed-regulator-v1_8dreg{
>  		vin-supply = <&v24_0d>;
>  	};
>  
> -	v1_8d: fixed-regulator-v1_8d{
> +	v1_8d: fixed-regulator-v1_8d {
>  		compatible = "regulator-fixed";
>  		regulator-name = "V1_8D";
>  		regulator-min-microvolt = <1800000>;
> @@ -78,7 +78,7 @@ v1_8d: fixed-regulator-v1_8d{
>  		vin-supply = <&v1_8dreg>;
>  	};
>  
> -	v1_5dreg: fixed-regulator-v1_5dreg{
> +	v1_5dreg: fixed-regulator-v1_5dreg {
>  		compatible = "regulator-fixed";
>  		regulator-name = "V1_5DREG";
>  		regulator-min-microvolt = <1500000>;
> @@ -88,7 +88,7 @@ v1_5dreg: fixed-regulator-v1_5dreg{
>  		vin-supply = <&v24_0d>;
>  	};
>  
> -	v1_5d: fixed-regulator-v1_5d{
> +	v1_5d: fixed-regulator-v1_5d {
>  		compatible = "regulator-fixed";
>  		regulator-name = "V1_5D";
>  		regulator-min-microvolt = <1500000>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
