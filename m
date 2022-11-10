Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5739B623A89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiKJDiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE952EF78;
        Wed,  9 Nov 2022 19:37:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BA5FB82082;
        Thu, 10 Nov 2022 03:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F05C433D6;
        Thu, 10 Nov 2022 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668051475;
        bh=lZXtpzLo2/ASL4uK18DoxCgRBXORqhOqiDewc3fzgEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4fEByReKUShO4ybn82uCHH+5XD61fEIHfw5aMvsIX6ujtzfImbnC4mcFARpQ46bh
         IuyJaXgWGj1iJSR/GqSwO0M4v0w67Me5JvQH1e7xOBNQPjuBGHxnonCcDjn2BAIrSg
         v71+SpDeNfDEcLCJFYOodCnn0ffj5CRxCfGIK7y182HwVIxIDuwVtMl4XEOm7okv4s
         4T9+DAXzgbGLBTdA29p2micO1tmymKzUIWVKLPLrShx7evlMjT35MVaX0TBY4UGaM2
         wKZJdN+yvnvjZvkgUVHMpPdxvMgPb1/thd6rv9IJNlMFk8+zR/y7E9HC8y4FAGD1Lx
         ca24MdiEPtqng==
Date:   Wed, 9 Nov 2022 21:37:53 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom-msm8960-cdp: align TLMM pin
 configuration with DT schema
Message-ID: <20221110033753.oyhl7z2edsrkkepg@builder.lan>
References: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
 <20221109105140.48196-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109105140.48196-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:51:40AM +0100, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add Rb tag
> ---
>  arch/arm/boot/dts/qcom-msm8960-cdp.dts | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> index 3a484ac53917..9a3a510f88ca 100644
> --- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> +++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> @@ -60,33 +60,32 @@ &gsbi5_serial {
>  };
>  
>  &msmgpio {
> -	spi1_default: spi1_default {
> -		 mux {
> -			pins = "gpio6", "gpio7", "gpio9";
> -			function = "gsbi1";
> -		 };
> -
> -		 mosi {
> +	spi1_default: spi1-default-state {
> +		 mosi-pins {
>  			pins = "gpio6";
> +			function = "gsbi1";
>  			drive-strength = <12>;
>  			bias-disable;
>  		 };
>  
> -		 miso {
> +		 miso-pins {
>  			pins = "gpio7";
> +			function = "gsbi1";
>  			drive-strength = <12>;
>  			bias-disable;
>  		 };
>  
> -		 cs {
> +		 cs-pins {
>  			pins = "gpio8";
> +			function = "gpio";

I'm changing this to "gsbi1" while applying this patch.

Regards,
Bjorn

>  			drive-strength = <12>;
>  			bias-disable;
>  			output-low;
>  		 };
>  
> -		 clk {
> +		 clk-pins {
>  			pins = "gpio9";
> +			function = "gsbi1";
>  			drive-strength = <12>;
>  			bias-disable;
>  		 };
> -- 
> 2.34.1
> 
