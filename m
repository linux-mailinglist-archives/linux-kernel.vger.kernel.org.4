Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427155EC380
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiI0NDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiI0NDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:03:13 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0017AC81
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:03:12 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 39C9D3F335;
        Tue, 27 Sep 2022 15:03:10 +0200 (CEST)
Message-ID: <335f759a-3279-4ab3-10c0-55daa313e669@somainline.org>
Date:   Tue, 27 Sep 2022 15:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: pm8941: fix vadc channel node names
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925161821.78030-1-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925161821.78030-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 18:18, Luca Weiss wrote:
> Node names for the channel are supposed to be adc-chan@REG.
> 
> Use this format and at the same time sort the nodes by reg value.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 9cd49deb9fa7..3c15eecf2f21 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -101,26 +101,33 @@ pm8941_vadc: adc@3100 {
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
>  
> -			bat_temp {
> -				reg = <VADC_LR_MUX1_BAT_THERM>;
> +
> +			adc-chan@6 {
> +				reg = <VADC_VBAT_SNS>;
>  			};
> -			die_temp {
> +
> +			adc-chan@8 {
>  				reg = <VADC_DIE_TEMP>;
>  			};
> -			ref_625mv {
> +
> +			adc-chan@9 {
>  				reg = <VADC_REF_625MV>;
>  			};
> -			ref_1250v {
> +
> +			adc-chan@10 {
>  				reg = <VADC_REF_1250MV>;
>  			};
> -			ref_gnd {
> +
> +			adc-chan@14 {
>  				reg = <VADC_GND_REF>;
>  			};
> -			ref_vdd {
> +
> +			adc-chan@15 {
>  				reg = <VADC_VDD_VADC>;
>  			};
> -			vbat_sns {
> -				reg = <VADC_VBAT_SNS>;
> +
> +			adc-chan@48 {
> +				reg = <VADC_LR_MUX1_BAT_THERM>;
>  			};
>  		};
>  
