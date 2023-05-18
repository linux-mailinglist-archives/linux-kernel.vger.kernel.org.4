Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235947077D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjERCJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjERCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C033AAA;
        Wed, 17 May 2023 19:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E6E63AF8;
        Thu, 18 May 2023 02:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3EEC433EF;
        Thu, 18 May 2023 02:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684375758;
        bh=9obMk6AZmvHe9BCy9surK81tpa8yMdMfGVW9yRTcpvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjG5A9fC790sBDxbZoTfoTVeG1YzvfsrPKGv0UUQAEpDwGfKWQvbTWx/aKUInScKj
         20rKq6DZOaBFoIlYhiiBsD8EStKottaYxIkVjqTcfRNVb0p6TmdZIzvH2tvjqSn5ze
         294ybGC4oWoa1KM5MHVv2MfM/gXD2D69y0JzXb89QvZTGdkdd/4Ntz5io9BKui8v4+
         7NhGpHpHr4vEsXHGwfgqu3nfsH7qE3N55IoUPEmHMwgCeCUV/z2cpbO7PEmJsDNGCE
         jtk2EQVypHI7GYjop2mkyb/cbxfY688dJLvMzg9gctamF5L4unRaQfslvgrtHsGIX2
         r1BVwSAVO7b0A==
Date:   Wed, 17 May 2023 19:13:07 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
Message-ID: <20230518021307.z63xrx5v2lhd3byf@ripper>
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
 <20230515-topic-rb2-bits-v1-3-a52d154a639d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515-topic-rb2-bits-v1-3-a52d154a639d@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:04:14PM +0200, Konrad Dybcio wrote:
> Add the three LEDs (blue/yellow/green) connected to TLMM GPIOs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 36 ++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 9b539720f05d..eeee268ebfe2 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/leds/common.h>
>  #include "sm4250.dtsi"
>  
>  / {
> @@ -30,6 +31,38 @@ hdmi_con: endpoint {
>  		};
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-bt {
> +			label = "blue:bt";
> +			function = LED_FUNCTION_BLUETOOTH;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +
> +		led-user0 {
> +			label = "green:user0";
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&tlmm 52 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +
> +		led-wlan {
> +			label = "yellow:wlan";
> +			function = LED_FUNCTION_WLAN;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
> +
>  	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VREG_HDMI_OUT_1P2";
> @@ -385,8 +418,7 @@ &sleep_clk {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <43 2>, <47 1>,
> -			       <49 1>, <52 1>, <54 1>,
> +	gpio-reserved-ranges = <43 2>, <49 1>, <54 1>,

How come pin 49 becomes inaccessible here? Was this intended for the
previous patch?

Regards,
Bjorn

>  			       <56 3>, <61 2>, <64 1>,
>  			       <68 1>, <72 8>, <96 1>;
>  
> 
> -- 
> 2.40.1
> 
