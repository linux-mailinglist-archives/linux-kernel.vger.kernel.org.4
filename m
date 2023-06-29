Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1039742487
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2K52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjF2K4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:56:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6E358B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:56:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba03becc6so32124e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688036187; x=1690628187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7Es22f+qmqIYUbq2m24EW4HG+xWpZDw823veO7t87g=;
        b=au75T3nGEwiijIKy8ejeucQ+G1slqYYJrIzmYdyPgn/pZhYoiMSG4H1C9puI+S8h+U
         Y88s/zW6nXBqGbXSGZbXwcj+tBfNMtldbaboWaOakat8123dq0ZJjH0Trf7wmPJfXzOY
         5ifzMfB6KNTDB60qT5qcPU7TwEA/syA0fZ8vvkWJ+JGnGxtJb7sDt3mtmrExCRHoxp50
         9uKxB95AT/CGD691nq3Gx5DU/XGqs6nuAh56nvpzDhMqhfm0CSQioyM+NK9pe8BTadxZ
         wbXeruw+hqzMXkUSezOaXQPM8/CZ+DscJbXXQLZ17OU3fdhdlwH8yMTskEwjvRNwkpAS
         xgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688036187; x=1690628187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7Es22f+qmqIYUbq2m24EW4HG+xWpZDw823veO7t87g=;
        b=NuuuMfwbSFGAhm1zqmGUTgDN24PRGrBqbseLGJhZdc2OOkItGuJj9hcdYvJ1ANmT9x
         PTaEM6Ivoj5RFqbQS+SDO12i7/3oqIokTdKTZoRkRKaySIs8FKkpuwjsOX8jGcq2BjxU
         Xbvqk/SvuwZGEcfa2BR30KLjP6weI2sNBkgdwwHrN+xeSHKpeUcT31WK5g83hqY3p9ey
         5z9pFcQMhlUACVTt1/dq7u3h93491DfpEv3u42Y7OWL7lr9oUgLCzpmJ8SUk9OSiBiFH
         99+vNgaOq251Z/UOC2cFIHLBswYeZvuPk8r/iFRegU5Qxm7Ep9YWHyE+kHUYzd45sO1W
         f++g==
X-Gm-Message-State: ABy/qLbdqONkxr8saVPOpWdLEcdKjxlbUY5XtvdPHz4O5Qxj+SUQExN4
        7cNOse4I4sJlC2lBSKOB7O6BPg==
X-Google-Smtp-Source: ACHHUZ6uCCsA72nHBEJeClAY0LKCCkK/SiNWp4r9atclYUh7lEO9fg7DN5y4FDNmwNH0R1AzIGkG0g==
X-Received: by 2002:a05:6512:3f4:b0:4f8:6253:540 with SMTP id n20-20020a05651203f400b004f862530540mr1269195lfq.19.1688036186931;
        Thu, 29 Jun 2023 03:56:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b7-20020ac247e7000000b004f7673823d3sm2275679lfp.150.2023.06.29.03.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 03:56:26 -0700 (PDT)
Message-ID: <4a267feb-5855-1427-c378-b2615eae4f84@linaro.org>
Date:   Thu, 29 Jun 2023 13:56:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: sm6125: Add dispcc node
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-13-03e430a2078c@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230627-sm6125-dpu-v2-13-03e430a2078c@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 23:14, Marijn Suijten wrote:
> Enable and configure the dispcc node on SM6125 for consumption by MDSS
> later on.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index edb03508dba3..a5cc0d43d2d9 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
>    */
>   
> +#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
>   #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>   #include <dt-bindings/clock/qcom,rpmcc.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> @@ -1203,6 +1204,30 @@ sram@4690000 {
>   			reg = <0x04690000 0x10000>;
>   		};
>   
> +		dispcc: clock-controller@5f00000 {
> +			compatible = "qcom,sm6125-dispcc";
> +			reg = <0x05f00000 0x20000>;
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <&gcc GCC_DISP_AHB_CLK>,
> +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> +			clock-names = "bi_tcxo",
> +				      "dsi0_phy_pll_out_byteclk",
> +				      "dsi0_phy_pll_out_dsiclk",
> +				      "dsi1_phy_pll_out_dsiclk",
> +				      "dp_phy_pll_link_clk",
> +				      "dp_phy_pll_vco_div_clk",
> +				      "cfg_ahb_clk",
> +				      "gcc_disp_gpll0_div_clk_src";
> +			power-domains = <&rpmpd SM6125_VDDCX>;

Would it be logical to specify the required-opps too?

> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>   		apps_smmu: iommu@c600000 {
>   			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>   			reg = <0x0c600000 0x80000>;
> 

-- 
With best wishes
Dmitry

