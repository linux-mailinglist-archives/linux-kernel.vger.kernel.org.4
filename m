Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23A6750828
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGLMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjGLMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:24:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F98B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:24:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so10755682e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164684; x=1691756684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wa9JW/WgSJqIhnDFJ2lPwRLRAbKTDP/bdGMeL+uenak=;
        b=D+WMjx18oS3oIW7sOM5dXoBvbr81cFxTK7JJVYjKyWCVESTeY4BJ/7pci13Gw+mAth
         984AuwsloliHjFXAAyHnKpUCSkaoHtzKNL9BEmaxbH7Iyf6CMfxYsJbc5yoTn+eoEzxr
         zEGBWKBmqfwFUxLn6qvhrZ+swEYdYpTyzEInPyWAOfDstGK67WMBTO9K7qEVmr+emUQl
         iP1qYbFE/3BXMr+KeYc0p8+zb4rsHaoIz76qqG3ePqzdWqNkSZVWREI0/RQgLkxRAxj3
         VQGuxa0l48WWDBuvbsJc2LkB9qumVFuuS9HfhqkfRexwVtdofwfDgF6ZchcXezOutjfC
         TcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164684; x=1691756684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wa9JW/WgSJqIhnDFJ2lPwRLRAbKTDP/bdGMeL+uenak=;
        b=VBJjg+JejEKEx58gl8fEuggL2Vs3bSLCCvpQNN/qxaqFOxToUVd46stKsvE+zJdp+r
         nc1BTvnTqjuz93TmfF8oklJTycTRDrY7JJCe3EpKhDILf9qClcJkggXuNHuF28mjbcyH
         ccZkQUN95a21oKBoy2z54uqEFd1FcZuGf2vciFww4v3CAa6pgm0D4FgAiOtSzKXiLvxC
         QwtNRJyPebq4wJeKY3oHRc11qOvy0pJ19ZbGOsp4LXcJISA6byw+EULQhA40uTvvgy0I
         mJqR9KzZ1Bse6z4xMg3M/1Qml/RIxrS3viM8QD0QYxJ2j+eFHggONnCast1CFSeyk4bb
         tcnA==
X-Gm-Message-State: ABy/qLbzoR3lWzOdCcLlwouWIkCSmp581kTYASW5Z6Uu+grjzhpHkSNA
        8GeNSgJiCuNua0UO7xjgC2kw8Q==
X-Google-Smtp-Source: APBJJlHK3CtRUxX9Fq4xB1c0C+pE6yEyeluKd9AcBaQOLzyeBaGibEe7Ex4O9ymSaESzIa5HVUjiHQ==
X-Received: by 2002:a05:6512:32bb:b0:4fb:89c1:c209 with SMTP id q27-20020a05651232bb00b004fb89c1c209mr14725929lfe.62.1689164684068;
        Wed, 12 Jul 2023 05:24:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25288000000b004fb8c0f247fsm685755lfm.129.2023.07.12.05.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:24:43 -0700 (PDT)
Message-ID: <a95dd01a-943f-e2d4-777f-a139fbc25238@linaro.org>
Date:   Wed, 12 Jul 2023 15:24:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: ipq5332: Add tsens node
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
 <20230712113539.4029941-4-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712113539.4029941-4-quic_ipkumar@quicinc.com>
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
> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v2]:
> 	Included qfprom nodes only for available sensors and removed
> 	the offset suffix.
> 
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db44624..0eef77e36609 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -150,6 +150,46 @@ qfprom: efuse@a4000 {
>   			reg = <0x000a4000 0x721>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +
> +			tsens_mode: mode@3e1 {
> +				reg = <0x3e1 0x1>;
> +				bits = <0 3>;
> +			};
> +
> +			tsens_base0: base0@3e1 {
> +				reg = <0x3e1 0x2>;
> +				bits = <3 10>;
> +			};
> +
> +			tsens_base1: base1@3e2 {
> +				reg = <0x3e2 0x2>;
> +				bits = <5 10>;
> +			};
> +
> +			s11: s11@3a5 {
> +				reg = <0x3a5 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s12: s12@3a6 {
> +				reg = <0x3a6 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s13: s13@3a6 {
> +				reg = <0x3a6 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s14: s14@3ad {
> +				reg = <0x3ad 0x2>;
> +				bits = <7 4>;
> +			};
> +
> +			s15: s15@3ae {
> +				reg = <0x3ae 0x1>;
> +				bits = <3 4>;
> +			};
>   		};
>   
>   		rng: rng@e3000 {
> @@ -159,6 +199,32 @@ rng: rng@e3000 {
>   			clock-names = "core";
>   		};
>   
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5332-tsens";
> +			reg = <0x4a9000 0x1000>,
> +			      <0x4a8000 0x1000>;
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base0>,
> +				      <&tsens_base1>,
> +				      <&s11>,
> +				      <&s12>,
> +				      <&s13>,
> +				      <&s14>,
> +				      <&s15>;
> +			nvmem-cell-names = "mode",
> +					   "base0",
> +					   "base1",
> +					   "s11",
> +					   "s12",
> +					   "s13",
> +					   "s14",
> +					   "s15";

Previously you had data for other sensors here. Are they not used at 
all, not wired, have no known-good placement? I think it might be better 
to declare all sensors here (and in the driver too) and then consider 
enabling only a pile of them in the thermal-zone node.

> +			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";
> +			#qcom,sensors = <5>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		tlmm: pinctrl@1000000 {
>   			compatible = "qcom,ipq5332-tlmm";
>   			reg = <0x01000000 0x300000>;

-- 
With best wishes
Dmitry

