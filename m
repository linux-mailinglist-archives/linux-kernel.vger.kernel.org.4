Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE16DA1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjDFTvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbjDFTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:51:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF99F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:51:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so52209872lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680810671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcXs2SGxl8yT2WI08MaUsydieqFeN/OG4gvIutKSaIM=;
        b=uUgBhfwK1lYS/bWyIW7HZord9ImkwgZGvW6pk74imNsO407GInv9+MsCeOTfnjiLb0
         ZZqD82AM9rEYP3sXTJ7V2sguRGQiXcUMuxVSSNlhFsSM5ICjzzawCyjAdml9cZkJP1K9
         wrU359qabplJ4zwBrOdzjF76ho9Ww+AcVCpWaqnCbkSCHF/MijNEKvX0xNdg6r9zL0KU
         qe92e5y+NWXljN6mOQxqmvX6NQp1dIqO4qLYVQiQy6Tfgq1N3xqeD9KDhKvzrJ/WuzfA
         vi1JV5LCE6jE2ygnsy5saK5FPihAqUgJROiECa/djW6YGepKTZ9810Awgh/CbWZRh/O/
         Gwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcXs2SGxl8yT2WI08MaUsydieqFeN/OG4gvIutKSaIM=;
        b=SElaHw4/E277HsaO2+QcmyurXB1HPidXC/qlZ1piW5zPyCrjPOD9KkvRx7f3H8w4tI
         5HVJaqEvMjM2RzA2GszK0r9lQ48eIrTiTkiCKECsb5NoISOTQnUXkLHfMvcGwuDcFHzL
         u1VjRafFIy9jU7zv7Fs/A73QlitkSlXixTRVIkto94Cx0Lpmd625vb6gRh9JdDvL1m9M
         0Ilefga35Z2+NhLn0LMaivWyImUo6pRC6K0Ea/3jdJA5X4y55MMgrwptlV9x9sV5V7Wt
         dzYWtmgAhSWy/qWFyLBpUGw5ew4niuTz3VC84J71eA50J+vb4oyLuJaLmLOr6ux2t+zH
         Y63w==
X-Gm-Message-State: AAQBX9crHJTn+7xAxPdCcEqpr8RcWqd2Sax2sm+x7VsoEtTAJ566TVvf
        PclKZQ9sTdDhzO4H2tDB2xjZRFTjHRtIXnf6DbE=
X-Google-Smtp-Source: AKy350YeQOs8GOsdJTBw35OhrEjXDHpv/rUNEqD962WbLnKUZUV5yuiX4L1S+GgeVXz3GaYOeQHh/Q==
X-Received: by 2002:ac2:48b1:0:b0:4db:513b:6ef4 with SMTP id u17-20020ac248b1000000b004db513b6ef4mr90249lfg.11.1680810671327;
        Thu, 06 Apr 2023 12:51:11 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u11-20020ac248ab000000b004dc4af9089bsm390646lfg.231.2023.04.06.12.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:51:10 -0700 (PDT)
Message-ID: <18eb5708-bf51-26c3-51a0-70a5069ffdbe@linaro.org>
Date:   Thu, 6 Apr 2023 21:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 5/5] arm64: dts: qcom: ipq9574: Add cpufreq support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-6-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406070032.22243-6-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 09:00, Devi Priya wrote:
> Add cpu freq nodes in the device tree to bump cpu frequency above 800MHz.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
> 	- No change
> 
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 58 +++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 1f9b7529e7ed..cfef87b5fd22 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> @@ -37,6 +38,10 @@
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		CPU1: cpu@1 {
> @@ -45,6 +50,10 @@
>  			reg = <0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -53,6 +62,10 @@
>  			reg = <0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -61,6 +74,10 @@
>  			reg = <0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		L2_0: l2-cache {
> @@ -75,6 +92,47 @@
>  		reg = <0x0 0x40000000 0x0 0x0>;
>  	};
>  
> +	cpu_opp_table: opp-table-cpu {
This is not sorted properly. It should probably come
after memory alphabetically ('o' > 'm')

Konrad
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-936000000 {
> +			opp-hz = /bits/ 64 <936000000>;
> +			opp-microvolt = <725000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz = /bits/ 64 <1104000000>;
> +			opp-microvolt = <787500>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <862500>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1488000000 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <925000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <987500>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			opp-microvolt = <1062500>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-ipq9574", "qcom,scm";
