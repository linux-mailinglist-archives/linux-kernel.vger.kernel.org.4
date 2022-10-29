Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0479D61238C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ2OQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2OQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:16:24 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F045F82
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:16:22 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 483E63EFD3;
        Sat, 29 Oct 2022 16:16:20 +0200 (CEST)
Message-ID: <061d3d94-9e60-21f3-9e9e-ea121142cd05@somainline.org>
Date:   Sat, 29 Oct 2022 16:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 06/12] arm64: dts: qcom: sc8280xp-pmics: Add support
 for TM5 block in PMK8280
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-7-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221029051449.30678-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> Thermal Monitoring block ADC5 (TM5) in PMK8280 can be used to monitor the
> temperature from secondary PMICs like PM8280.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index 3c56e4cb5b5b..6f95743bf87d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -84,6 +84,16 @@ pmk8280_vadc: adc@3100 {
>  			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#io-channel-cells = <1>;
>  		};
> +
> +		pmk8280_adc_tm: adc-tm@3400 {
> +			compatible = "qcom,spmi-adc-tm5-gen2";
> +			reg = <0x3400>;
> +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#thermal-sensor-cells = <1>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	pmc8280_1: pmic@1 {
