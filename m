Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E46669FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjALELo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjALELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:11:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0782841023
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:11:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so26657632lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pvn/baf5QiCOBloPlwpObevrgyxqdmuAeWZ6cxEzeUI=;
        b=M+S9wnnUVoR4QwB8fDZwUMQQ31XVdLMaDf8LcQ42T2D+6FGNTwTWXWjwkyQm0K452R
         takbokr+8wiO42RpB9jOjVdaDNHMdheNGWRBzhHrTPLpc8geFDOUYThW7zPS/3JVF00z
         IS7c07b3i7DTRl4DzoOVfmoig+9fTE1rloVG8v8Yjf7Q70xLgbCd0lc7ki3BYxWzTyzv
         ydcZ9m+9fR0u+bjsxBm3ZzPzPSDZPNbF0tbJYivN/mPmJSnuYTk+rRPRS9wx7cdzu3hy
         g9yDDEZ+rwKr9DCKkTlIGtnfJ4fOYNhv/4ERdFOIzFqHnJq/gXsJR1WF7sG9IuMIoWFd
         E43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvn/baf5QiCOBloPlwpObevrgyxqdmuAeWZ6cxEzeUI=;
        b=68MGkl/27N21LTUpwpzmKGuaLR1+w/RnXdcW04Kt/ZwiO+WHHGr7Fb+gpIlyF7vNfh
         E+SeqWzJQ95oy9TWzSCuoYmmJSItc+rfhI//T8xGINRimfm9UI98bVQt2h1dH2IZOLQe
         Z4z3khWo3DQ4IExK+HerALr8OAe1GjQLamRBZWy7B7IE3vkixBB4rdHb2MlOTa0RBgus
         1p1e0tiGSsY4lEwqTbLTqYi38YCc+QgF6wZ4Z1MS1lPvoVf2n20mDMHGBXx5o/tMpu6b
         7mrHlSArTV41ISpkXYfR3h/jtHkR7VLRXDDP/gyzl7aq/+mn4BEAQ25M4p7afbwo6+jH
         5Brg==
X-Gm-Message-State: AFqh2kr0eYgQeL1KzkSOpIDv1YaWC4Txmesm4zcHJb4sXzcCeUd/Xr8K
        f+0DzpidyBkUzyqXYF9xgizwaQ==
X-Google-Smtp-Source: AMrXdXs4CM1VLfdisNIajwoqeNbjJTs2ijY/q0iQY3SOzYyNzRLEtcVXtT00orXleLuKy6BLRMjnrQ==
X-Received: by 2002:a05:6512:2308:b0:4b5:6b87:a5ce with SMTP id o8-20020a056512230800b004b56b87a5cemr24075465lfu.46.1673496694382;
        Wed, 11 Jan 2023 20:11:34 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g5-20020a19ac05000000b0049465afdd38sm3046457lfc.108.2023.01.11.20.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 20:11:33 -0800 (PST)
Message-ID: <a1d3be86-d986-6f36-1f17-ab91e7b609c8@linaro.org>
Date:   Thu, 12 Jan 2023 06:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 4/6] ARM: dts: qcom: fix various wrong definition for
 kpss-gcc node
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
 <20230110183259.19142-5-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230110183259.19142-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 20:32, Christian Marangi wrote:
> Fix dtbs_check warning now that we have a correct kpss-gcc yaml
> schema. Add additional qcom,kpss-gcc compatible to differentiate
> devices where kpss-gcc should provide a clk and where kpss-gcc should
> just provide the registers and the syscon phandle.
> Add missing #clock-cells and remove useless clock-output-names for
> ipq806x.
> Add missing bindings for msm8960 and apq8064 kpss-gcc node.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
>   arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
>   arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
>   arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
>   arch/arm/boot/dts/qcom-msm8960.dtsi | 5 ++++-
>   5 files changed, 12 insertions(+), 6 deletions(-)

Please split this commit into two commits:
- one adding per-SoC compatibles. Mention that they are not (yet) used 
by the driver, but can serve further customisation.

- another one adding and fixing clock configuration. My notes to patch 
5/6 applies here too.

> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 1f3e0aa9ab0c..1e68b42acb91 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -880,8 +880,11 @@ mmcc: clock-controller@4000000 {
>   		};
>   
>   		l2cc: clock-controller@2011000 {
> -			compatible = "qcom,kpss-gcc", "syscon";
> +			compatible = "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
>   			reg = <0x2011000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			#clock-cells = <0>;
>   		};
>   
>   		rpm: rpm@108000 {
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 7e784b0995da..de87fcaaa836 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -570,11 +570,11 @@ IRQ_TYPE_EDGE_RISING)>,
>   		};
>   
>   		l2cc: clock-controller@2011000 {
> -			compatible = "qcom,kpss-gcc", "syscon";
> +			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
>   			reg = <0x02011000 0x1000>;
>   			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
>   			clock-names = "pll8_vote", "pxo";
> -			clock-output-names = "acpu_l2_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		acc0: clock-controller@2088000 {
> diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> index b0fe1d95d88f..61dfec3b9037 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
> +++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> @@ -116,7 +116,7 @@ lcc: clock-controller@28000000 {
>   		};
>   
>   		l2cc: clock-controller@2011000 {
> -			compatible = "qcom,kpss-gcc", "syscon";
> +			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
>   			reg = <0x02011000 0x1000>;
>   		};
>   
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index 86f76d0feff4..f601b40ebcf4 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -473,7 +473,7 @@ pm8058_led133: led@133 {
>   		};
>   
>   		l2cc: clock-controller@2082000 {
> -			compatible = "qcom,kpss-gcc", "syscon";
> +			compatible = "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
>   			reg = <0x02082000 0x1000>;
>   		};
>   
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 7debf9db7cb1..3bd07cac315b 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -183,8 +183,11 @@ clock-controller@4000000 {
>   		};
>   
>   		l2cc: clock-controller@2011000 {
> -			compatible = "qcom,kpss-gcc", "syscon";
> +			compatible = "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
>   			reg = <0x2011000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			#clock-cells = <0>;
>   		};
>   
>   		rpm: rpm@108000 {

-- 
With best wishes
Dmitry

