Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1960EA02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiJZUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiJZULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:11:22 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E63118769;
        Wed, 26 Oct 2022 13:11:19 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EE9643F73D;
        Wed, 26 Oct 2022 22:11:16 +0200 (CEST)
Message-ID: <cd4bea2e-3832-1684-ff8e-2236ccdbe558@somainline.org>
Date:   Wed, 26 Oct 2022 22:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8450: move SDHCI pin
 configuration to DTSI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
 <20221026200357.391635-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221026200357.391635-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/10/2022 22:03, Krzysztof Kozlowski wrote:
> The SDHCI pin configuration/mux nodes are actually common to all
> upstreamed boards, so define them in SoC DTSI to reduce code
> duplication.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>
> In theory drive strength belongs to the board DTS, not SoC DTSI, but I
> am following the advice here:
> https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
> ---
>   .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 20 -------------------
>   arch/arm64/boot/dts/qcom/sm8450.dtsi          | 20 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> index 82918c2d956f..718c690af8ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> @@ -572,26 +572,6 @@ &spi10 {
>   &tlmm {
>   	gpio-reserved-ranges = <28 4>;
>   
> -	sdc2_default_state: sdc2-default-state {
> -		clk-pins {
> -			pins = "sdc2_clk";
> -			drive-strength = <16>;
> -			bias-disable;
> -		};
> -
> -		cmd-pins {
> -			pins = "sdc2_cmd";
> -			drive-strength = <16>;
> -			bias-pull-up;
> -		};
> -
> -		data-pins {
> -			pins = "sdc2_data";
> -			drive-strength = <16>;
> -			bias-pull-up;
> -		};
> -	};
> -
>   	ts_int_default: ts-int-default-state {
>   		pins = "gpio23";
>   		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1d1775334575..1df5c964c6f7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2515,6 +2515,26 @@ tlmm: pinctrl@f100000 {
>   			gpio-ranges = <&tlmm 0 0 211>;
>   			wakeup-parent = <&pdc>;
>   
> +			sdc2_default_state: sdc2-default-state {
> +				clk-pins {
> +					pins = "sdc2_clk";
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc2_cmd";
> +					drive-strength = <16>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc2_data";
> +					drive-strength = <16>;
> +					bias-pull-up;
> +				};
> +			};
> +
>   			sdc2_sleep_state: sdc2-sleep-state {
>   				clk-pins {
>   					pins = "sdc2_clk";
