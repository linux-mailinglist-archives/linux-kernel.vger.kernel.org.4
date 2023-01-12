Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540A6669F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjALEIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjALEI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:08:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464341A6A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:08:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so26607038lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7THg9ysCyORDofeZeb5cwtB7iuBZFtsX/HadXdT8Cw=;
        b=JSrrop6cbxT6UHOx++WjIFHUJA14AEqhdd7iyueO6KaLW2hklkdfbUkkMwavZRuJ+J
         V4h4cJSpkn70lAm8aywuVHCa5mnla+WFXlScoGk7lYajz8+V/1I6YNIz/1TB3W+jkyTC
         biNQn7ufYDlKnqMPoVEQGHQXZ9c3ZpQ9sE2DpAsx2JW3a2Gi/gN0MZdhCVjj6nf7cDE5
         Qt1NNyXZtj3T9UTZh0s0O0IF+oVZo0t6Tpom9Zx9e5POSJimkt98vJ9BkKMnxa+b7Mmq
         jCRkBwIoiSZRIgUhxZZvAkadElfqfVc3jj49ngj1/wj+X4Y+FuCnF1gCFvC75+SEI0Os
         Vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7THg9ysCyORDofeZeb5cwtB7iuBZFtsX/HadXdT8Cw=;
        b=hPvGdecY7zqPQEp1FB+Z8YFO9tWKV0DvQUy+EVAot31+s86hfvG2WgHCeG3em/5eLW
         Ll6oeZIkhG3ihRsKJxg77T+FUGdmutz8Jpe8MWJ9/FQS+H7LUwSHRmbK3YQEhGUVuLqI
         aSrSRHgnyXzrvjxmv2QuswRgYFOCuGOWbnNdmR5oS4w/O4goaMMFTlCQQnWs8tACddVi
         AYFwYC6myp6tWL5qpztlU8gnIY7/wnE5u3VnwfeJ5RxRPw158tR3Q4HbCz4NxvKxDlw0
         TnSvHG9ku5MkmSCLQ5j5Og/OK1gGsiuqUwrOR4ob30TC8mlFzwjH0/mWNaWZ0VGnJEYr
         ZOsg==
X-Gm-Message-State: AFqh2kpZfAMgVsLvzBAisXIvPWjKeKvjycroCPf7ncitWtoXnARvK7MB
        D9hR3fPxR1ChyluMxC6r0aY7ag==
X-Google-Smtp-Source: AMrXdXupBBJwsfIUeUpY7ybPBGb99U6p5RPRzBKJP75fEXRSyGFUaSn9Rymxvcovw8XaXyFpwQ/ZGg==
X-Received: by 2002:ac2:4e07:0:b0:4cc:ff7c:4846 with SMTP id e7-20020ac24e07000000b004ccff7c4846mr77463lfr.0.1673496503796;
        Wed, 11 Jan 2023 20:08:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24e85000000b004917a30c82bsm3058632lfr.153.2023.01.11.20.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 20:08:23 -0800 (PST)
Message-ID: <b69d816a-4277-ed6b-5d3a-8ede7ad01178@linaro.org>
Date:   Thu, 12 Jan 2023 06:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 5/6] ARM: dts: qcom: fix various wrong definition for
 kpss-acc-v1
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
 <20230110183259.19142-6-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230110183259.19142-6-ansuelsmth@gmail.com>
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
> Fix dtbs_check warning now that we have a correct kpss-acc-v1 yaml
> schema.

I think the commit message is a bit misleading. You are not barely 
fixing the warnings, you are adding the clocks configuration. Please 
adjust the commit subject and drop the first sentence of the commit message.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Add missing clocks, clock-names, clock-output-names and #clock-cells
> bindings for each kpss-acc-v1 clock-controller to reflect Documentation
> schema.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++++++++++
>   arch/arm/boot/dts/qcom-ipq8064.dtsi |  8 ++++++++
>   arch/arm/boot/dts/qcom-msm8960.dtsi |  8 ++++++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 1e68b42acb91..af84f2d350ef 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -389,21 +389,37 @@ timer@200a000 {
>   		acc0: clock-controller@2088000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu0_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		acc1: clock-controller@2098000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu1_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		acc2: clock-controller@20a8000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x020a8000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu2_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		acc3: clock-controller@20b8000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu3_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		saw0: power-controller@2089000 {
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index de87fcaaa836..e796094a7af5 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -580,6 +580,10 @@ l2cc: clock-controller@2011000 {
>   		acc0: clock-controller@2088000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu0_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		saw0: regulator@2089000 {
> @@ -591,6 +595,10 @@ saw0: regulator@2089000 {
>   		acc1: clock-controller@2098000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu1_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		saw1: regulator@2099000 {
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 3bd07cac315b..4fd56d85be3f 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -208,11 +208,19 @@ regulators {
>   		acc0: clock-controller@2088000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu0_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		acc1: clock-controller@2098000 {
>   			compatible = "qcom,kpss-acc-v1";
>   			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			clock-output-names = "acpu1_aux";
> +			#clock-cells = <0>;
>   		};
>   
>   		saw0: regulator@2089000 {

-- 
With best wishes
Dmitry

