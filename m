Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B125F8CAB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJIRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJIRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:46:28 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820222531;
        Sun,  9 Oct 2022 10:46:25 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9A06E3EECF;
        Sun,  9 Oct 2022 19:46:22 +0200 (CEST)
Date:   Sun, 9 Oct 2022 19:46:21 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/40] arm64: dts: qcom: sm6125: align TLMM pin
 configuration with DT schema
Message-ID: <20221009174621.ecamh76faoibuykv@SoMainline.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
 <20220912061746.6311-35-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912061746.6311-35-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-12 08:17:40, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with '-state'
> suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts  |  4 ++--
>  arch/arm64/boot/dts/qcom/sm6125.dtsi                   | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 0aad2e94e757..6a8b88cc4385 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -87,7 +87,7 @@ &hsusb_phy1 {
>  };
>  
>  &sdc2_off_state {
> -	sd-cd {
> +	sd-cd-pins {
>  		pins = "gpio98";
>  		drive-strength = <2>;
>  		bias-disable;
> @@ -95,7 +95,7 @@ sd-cd {
>  };
>  
>  &sdc2_on_state {
> -	sd-cd {
> +	sd-cd-pins {
>  		pins = "gpio98";
>  		drive-strength = <2>;
>  		bias-pull-up;
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 8c582a9e4ada..1fe3fa3ad877 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -387,19 +387,19 @@ tlmm: pinctrl@500000 {
>  			#interrupt-cells = <2>;
>  
>  			sdc2_off_state: sdc2-off-state {
> -				clk {
> +				clk-pins {
>  					pins = "sdc2_clk";
>  					drive-strength = <2>;
>  					bias-disable;
>  				};
>  
> -				cmd {
> +				cmd-pins {
>  					pins = "sdc2_cmd";
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
>  
> -				data {
> +				data-pins {
>  					pins = "sdc2_data";
>  					drive-strength = <2>;
>  					bias-pull-up;
> @@ -413,13 +413,13 @@ clk {
>  					bias-disable;
>  				};
>  
> -				cmd {
> +				cmd-pins-pins {

Is this double -pins-pins suffix intended?

- Marijn

>  					pins = "sdc2_cmd";
>  					drive-strength = <10>;
>  					bias-pull-up;
>  				};
>  
> -				data {
> +				data-pins {
>  					pins = "sdc2_data";
>  					drive-strength = <10>;
>  					bias-pull-up;
> -- 
> 2.34.1
> 
