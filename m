Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6D6123DE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ2OXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJ2OWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:22:50 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE75FAEC;
        Sat, 29 Oct 2022 07:20:40 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5A9FB3EBD1;
        Sat, 29 Oct 2022 16:20:38 +0200 (CEST)
Message-ID: <279c1bec-5ccc-28c6-f854-d75e02649cab@somainline.org>
Date:   Sat, 29 Oct 2022 16:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: sc8280xp-x13s: Add PMR735A
 VADC channel
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-11-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221029051449.30678-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> Add VADC channel of PMR735A for measuring the on-chip die temperature.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 250e1489f029..9545b471c2fa 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "sc8280xp.dtsi"
> @@ -250,6 +251,12 @@ sys-therm@347 {
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  	};
> +
> +	pmic-die-temp@403 {
> +		reg = <PMR735A_ADC7_DIE_TEMP>;
> +		label = "pmr735a_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
>  };
>  
>  &qup0 {
