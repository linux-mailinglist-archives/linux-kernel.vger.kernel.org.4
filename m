Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C9653E82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiLVKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:47:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA227901
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:47:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so2112938lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Tl2hcVeNT0vWD8ywC5G/0OTliUnFGkJ2ZnLCksg4DI=;
        b=m6EBowLOzMw5zyWmi1/hvCymiNwK94JNtplNzqbQc0NHo/HSKGRLX520+QvN0S67ls
         /L4dln0jt/I+E2z8tSEWSgPyhVnZ2vV8XDggo77xStyxjIkIpXj2qtsUy8XpfGs3zUv9
         w3uwLtCsTIBjJ/gusutbVidU+5flI93C40iDxKNZAkiR/5CaW7n9jXpEHJHcl0FDeYj0
         gUjsW6uA0YI3Rtrc5pDQUYq9kOjGZjllMxlYlGmjw4REPyxfcaYR32B5+v3qH6EgVhAP
         L4JtAS+iXFiGbcQQz1yUXIswy/9NGfLv25RAG4btdGVPRATxcAz3mBY0EkSZjEAh9KPv
         weRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tl2hcVeNT0vWD8ywC5G/0OTliUnFGkJ2ZnLCksg4DI=;
        b=76GCb4J+lagWjVQS4VxYjixUp7Mre5qBuyYBe3NK4rWMACa/9+PORo7fX7aYnis6XO
         IJZ3nPLt3M06C4d9eDl3QpOFazvw6xrXr7ox0niF1dBgUE4dAIo8qv3yV2R7+ovWvasT
         P6bCiCQbBnzQH3zt37G6CCtzzSIevzJa7S21xu1kiC2LVf6noH9o8lWBaQfQcMSOFf20
         Y4X6Ej8hwBxngJu79R2UqoOi805MAp6+42BbSI3XaN7cMooGS378RrAGigmNus9DKU4d
         Aj9Hk9kawdONFvUqCYZzuPJBLzT7jdYlMDBwnrEFIfecU7q27j9cHL6u6PbY/iZw2Gdp
         l5sA==
X-Gm-Message-State: AFqh2koej7vG03NVVBgSEWEAYwwGCDgTKsa2xsQE4gNtGJV4TSKDibJj
        y0LgC8OrKpAuaL/YwpB6rV+n+w==
X-Google-Smtp-Source: AMrXdXum0yhd+U+J7O/Sr7hX0iuI/NHaDGZNG0OyjYCTKSOOL+Iom+aE9JcEoD1nnLbhq9WLKRzroA==
X-Received: by 2002:a05:6512:2821:b0:4b5:26f3:2247 with SMTP id cf33-20020a056512282100b004b526f32247mr1787186lfb.69.1671706062000;
        Thu, 22 Dec 2022 02:47:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020ac258ea000000b004b501497b6fsm31163lfo.148.2022.12.22.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 02:47:41 -0800 (PST)
Message-ID: <1a5cc3d3-ac2d-52c8-79f4-b13252a4bb86@linaro.org>
Date:   Thu, 22 Dec 2022 11:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v14 1/5] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        dmitry.baryshkov@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671217893-17496-1-git-send-email-quic_khsieh@quicinc.com>
 <1671217893-17496-2-git-send-email-quic_khsieh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671217893-17496-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 20:11, Kuogee Hsieh wrote:
> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
> add link-frequencies property into dp_out endpoint as well. The last
> frequency specified at link-frequencies will be the max link rate
> supported by DP.
> 
> Changes in v5:
> -- revert changes at sc7180.dtsi and sc7280.dtsi
> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi
> 
> Changes in v6:
> -- add data-lanes and link-frequencies to yaml
> 
> Changes in v7:
> -- change 160000000 to 1620000000
> -- separate yaml to different patch
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Changes in v9:
> -- use symbol rate (hz) for link-frequencies at dp_out at sc7180_trogdor.dtsi
> 
> Changes in v13:
> -- delete an extra space at data-lanes
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 6 +++++-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index eae22e6..e2783dd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -814,7 +814,11 @@ hp_i2c: &i2c9 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dp_hot_plug_det>;
> -	data-lanes = <0 1>;
> +};
> +
> +&dp_out {
> +    data-lanes = <0 1>;
> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;

Messed order of nodes.

>  };
>  
>  &pm6150_adc {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index c11e371..3f363f8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -442,7 +442,11 @@ ap_i2c_tpm: &i2c14 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&dp_hot_plug_det>;
> +};
> +
> +&dp_out {

Same problem here.


Best regards,
Krzysztof

