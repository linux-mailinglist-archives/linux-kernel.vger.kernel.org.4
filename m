Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BF75082A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGLMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjGLMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:25:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718EA0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:25:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso11109245e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164722; x=1691756722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1ZyIkq4WbMXWqsXns9THs2olK9VahWIVb3OHn8unLs=;
        b=JOhezo/1ZaTIWSt6mBTejlQYkBv3WvNx2TkyB751uV8RDLHsGi3hu3tW9xLHpiBE27
         t4RmO25UfGXyjCr5+327l2i6qJsBRlizuq4Mw3Hraf1vvDHPc7+KqAOCAAo8arDlju4T
         Gf9sZHtrCRqGKepDySmk7mN4VqXwDn0L+04sgal+ZfHzMohsv2AkZ/I6IhEwGEBSmJnE
         kRNtlyQj7knLf98OQuIJ4xTZbg7X5QIgQs1zxn0q8K55dN3NbLaYi+Q/CgXUKHKH4oiZ
         eKxmRal20B/z+d7dp1CYfWZKWSSTpmvWZZH13oueWr1KVcC1k/cL4Q/yWBFusZWwcnXf
         V8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164722; x=1691756722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ZyIkq4WbMXWqsXns9THs2olK9VahWIVb3OHn8unLs=;
        b=PZcSBDy75dyOPqGNqPiceYFkRnbSkqEZHeMIAqVal/tzEqJi2ERDjfi7yF84G1L3sN
         g7mGmBIeDfAbcl0wUD5M3+EtUbo2pPkdtt+wtMVB2PMutFxntIsLEMtmUNGxFG8fEIRG
         sCvCEpko6VzeTH3EKfg0oBNMT5ftNDqGG8eowLfHwM1Lq3qkPjIOTWqUUAvP0wsJv1YE
         9rt9xhc1wYTFhsl5KpgoZer+fgt24Fn7HJIFZ09EWvjS91cf/E+BNt3iqFq3RdiTJ4mD
         tiSFh/HLkdP7xfBsn2dAUol5LhtemUiYR2GdrnKcYFbJYnhFSq/sgfX/coxsbPRNjphP
         Kmcg==
X-Gm-Message-State: ABy/qLarrbXzqtAUwXNsSUBm7wXRN6ycgvgmce5B99ay5c7Qei+Alt+l
        uO5RGncjtzYoOh42rOFfNwd8ig==
X-Google-Smtp-Source: APBJJlH7qN4d0sOGUx0/N+ngJQbFVjX31uyhadAOMznlzUCc1KWAh341B1BGXehV5rlS7kbWZ5IdWA==
X-Received: by 2002:a19:5e06:0:b0:4fb:9595:15e9 with SMTP id s6-20020a195e06000000b004fb959515e9mr14485851lfb.22.1689164722152;
        Wed, 12 Jul 2023 05:25:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004f73eac0308sm688235lfo.183.2023.07.12.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:25:21 -0700 (PDT)
Message-ID: <a33368ef-f68c-d7ee-922a-8896a5d1f158@linaro.org>
Date:   Wed, 12 Jul 2023 15:25:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-5-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712113539.4029941-5-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 14:35, Praveenkumar I wrote:
> This patch adds thermal zone nodes for sensors present in
> IPQ5332.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v2]:
> 	Added passive trips and alignment change.
> 
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 78 +++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 0eef77e36609..a1f59af97ee8 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -480,4 +480,82 @@ timer {
>   			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
> +
> +	thermal-zones {
> +		rfa-0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 11>;
> +
> +			trips {
> +				rfa-0-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		rfa-1-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 12>;
> +
> +			trips {
> +				rfa-1-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		misc-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 13>;
> +
> +			trips {
> +				misc-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-top-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 14>;
> +
> +			trips {
> +				cpu-top-critical {
> +					temperature = <115000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <105000>;
> +					hysteresis = <1000>;
> +					type = "passive";

cooling device for this trip point?

> +				};
> +			};
> +		};
> +
> +		top-glue-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 15>;
> +
> +			trips {
> +				top-glue-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>   };

-- 
With best wishes
Dmitry

