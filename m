Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158A369F9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjBVRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjBVRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:18:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388B23127
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:18:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z42so866183ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZMsMNKryIwR/OeQId+MpW2HJ78jeGftvuKDzTXo6Vo=;
        b=rwvM6bYXrPO3KZuj2AzMWITfL0PdEAgRSMh92oGQ88rPc8/X1+yxUZmBApVMrQ2RRk
         XLngbd/PefrdT2GrFeCNLN9tBu7WY4x189a9bl6KOU9u5i1yFrWp8fmNxpLc8MWB4ete
         neTGARuG1avKmvWVVfiKm7iT3soP6p4k8CRpOWw1mK5+B01d5QlDqvZEYlx8Ag4Yy77b
         h+R/3v3idPsG0q2ItpufCBLUCX1MNEJIUUMLF5IkDXW59JFZMATq7hAbEgY7q9okaW+I
         IfRtcR/8Msw4RCUJ/TwwN+72BTuumcVCtHyV611KdWjVsWWNBYQeSiNzjuX9JQvtlpbP
         l6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZMsMNKryIwR/OeQId+MpW2HJ78jeGftvuKDzTXo6Vo=;
        b=oOeZKxUxbF2cpuzMyhnN26/4MtCTlCqiZCxqxDt78h0wmJ7v91jCNIfA8qnoMzXK0y
         WEgiL6K0xBJfYKRS1yiqqO0/x8Pmik+XiJYCwkng71rZi9da+rmtQIHKhtsa0F+X6idE
         K/oVlvHnAvIdNJ6NmDuWhFtJzZt1ggf3d2P1Co8kJHbiI/Mk79y3x9mej86wflnE3bG0
         OiOKZptQnxz4Uedw1Ea1m5VjSWJ5USLNmkxIzeNhsmpyhA+Iqk+zsOQXvB6lobtFn6e/
         vkXqq8Tta37NrWOr00SWLu1ylMDrfkr+PWcndzX6VtpyZIx2J46Z0C4KyaKUdni5I9p3
         ssAQ==
X-Gm-Message-State: AO0yUKVolxb0Esvbvk1EwVXSZo5RQEcpODfv2s3YDrBuatwmEdibdNbp
        wjN/+GWD+3x8LXEdk1rWsSGsCg==
X-Google-Smtp-Source: AK7set/T/Iv3eABTBRx05+Qn0B0IKh+wIymlFgEzJm9eVk0wcaZd7cBHusmAO4oV/6GTaxUQuBySqQ==
X-Received: by 2002:a2e:b4a6:0:b0:288:d4bb:4020 with SMTP id q6-20020a2eb4a6000000b00288d4bb4020mr3262218ljm.32.1677086311273;
        Wed, 22 Feb 2023 09:18:31 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id t3-20020a05651c204300b002947029eacfsm864343ljo.23.2023.02.22.09.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:18:30 -0800 (PST)
Message-ID: <39e69f3c-5b81-d04f-c89c-a8173622493a@linaro.org>
Date:   Wed, 22 Feb 2023 18:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-4-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222120411.55197-4-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 13:04, Bryan O'Donoghue wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
> The msm8939-pm8916.dtsi include configures the regulator supplies of
> MSM8939 used together with PM8916, as recommended by Qualcomm. In rare
> cases where boards deviate from the recommended design they can just
> avoid using this include.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 82 ++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> new file mode 100644
> index 0000000000000..18a1b3cca01d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "msm8939.dtsi"
> +#include "pm8916.dtsi"
> +
> +&dsi0 {
> +	vdda-supply = <&pm8916_l2>;
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi1 {
> +	vdda-supply = <&pm8916_l2>;
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi_phy0 {
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&dsi_phy1 {
> +	vddio-supply = <&pm8916_l6>;
> +};
> +
> +&mpss {
> +	pll-supply = <&pm8916_l7>;
> +};
> +
> +&pronto {
> +	vddpx-supply = <&pm8916_l7>;
> +
> +	iris {
> +		vddxo-supply = <&pm8916_l7>;
> +		vddrfa-supply = <&pm8916_s3>;
> +		vddpa-supply = <&pm8916_l9>;
> +		vdddig-supply = <&pm8916_l5>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm8916_l8>;
> +	vqmmc-supply = <&pm8916_l5>;
> +};
> +
> +&sdhc_2 {
> +	vmmc-supply = <&pm8916_l11>;
> +	vqmmc-supply = <&pm8916_l12>;
> +};
> +
> +&usb_hs_phy {
> +	v1p8-supply = <&pm8916_l7>;
> +	v3p3-supply = <&pm8916_l13>;
> +};
> +
> +&rpm_requests {
> +	smd_rpm_regulators: regulators {
> +		compatible = "qcom,rpm-pm8916-regulators";
> +
> +		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
> +		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
> +		pm8916_s3: s3 {};
> +		pm8916_s4: s4 {};
> +
> +		pm8916_l1: l1 {};
> +		pm8916_l2: l2 {};
> +		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
> +		pm8916_l4: l4 {};
> +		pm8916_l5: l5 {};
> +		pm8916_l6: l6 {};
> +		pm8916_l7: l7 {};
> +		pm8916_l8: l8 {};
> +		pm8916_l9: l9 {};
> +		pm8916_l10: l10 {};
> +		pm8916_l11: l11 {};
> +		pm8916_l12: l12 {};
> +		pm8916_l13: l13 {};
> +		pm8916_l14: l14 {};
> +		pm8916_l15: l15 {};
> +		pm8916_l16: l16 {};
> +		pm8916_l17: l17 {};
> +		pm8916_l18: l18 {};
> +	};
> +};
