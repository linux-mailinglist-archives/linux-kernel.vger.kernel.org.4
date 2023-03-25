Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA986C8D53
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCYLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0312B;
        Sat, 25 Mar 2023 04:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A723460C16;
        Sat, 25 Mar 2023 11:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D381AC433D2;
        Sat, 25 Mar 2023 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679742874;
        bh=vPjezWUwf5PkMN9wm8Ys2Nw7IFlubfUlanfXia2+AKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hOVJN20zZGNaC5gtZaF5zXWOe5s0ZEa+93VnPRZ8nPm5FtkEs12OK+5lq+RZ6H5u/
         CnJd4vsOQv92v48gf94zxv6RRvrfHzU9UAj9ioqhpxTb9frHY4E9fzyxgaT7j87Jij
         sz0lh0PklsfJPEFWatsO0QeS+/VwboUKjm55yMMg4vMckmpF6ad2EPYCL0RC27AJ1L
         BpfhgN/Fvb8QjGav4GsOghTodugVhPYkvEePGzIgzih8r6oj4zw/DA7wRaM/V0Qu67
         W1CTMTuQ6x3EW7GKhsEZQXHicsY0gBTG05UenE8H60yEwSRJM1hMhV/AmKUzNWmgQg
         Ql38nrBkz7NgQ==
Message-ID: <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
Date:   Sat, 25 Mar 2023 12:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324201528.2540564-1-elder@linaro.org>
 <20230324201528.2540564-2-elder@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230324201528.2540564-2-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 21:15, Alex Elder wrote:
> Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
> nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.
> 
> Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
> Zone on this platform.
> 
> Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>  arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index ed98c83c141fc..72e25de0db5fc 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>  	status = "okay";
>  };
>  
> +&ipa {
> +	qcom,gsi-loader = "skip";
> +	status = "okay";
> +};
> +
>  &qpic_bam {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 192f9f94bc8b4..360d6dc144811 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>  
>  / {
>  	#address-cells = <1>;
> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		ipa: ipa@3e04000 {
> +			compatible = "qcom,sdx65-ipa";
> +
> +			iommus = <&apps_smmu 0x5e0 0x0>,
> +				 <&apps_smmu 0x5e2 0x0>;
> +			reg = <0x3f40000 0x10000>,
> +			      <0x3f50000 0x5000>,
> +			      <0x3e04000 0xfc000>;
> +			reg-names = "ipa-reg",
> +				    "ipa-shared",
> +				    "gsi";
> +
> +			interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "ipa",
> +					   "gsi",
> +					   "ipa-clock-query",
> +					   "ipa-setup-ready";

These look misaligned.

With above:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof

