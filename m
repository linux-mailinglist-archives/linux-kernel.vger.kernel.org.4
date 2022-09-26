Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670CA5E9C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiIZI4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiIZI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:56:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A17399EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:56:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so7693298wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=cMdvVG6gsVrl67bRH/yjYyvxFVJ/s7FYCJ8TDUHq/e8=;
        b=oYcg6maKBAwLkrJtTzjJDgfU2YwyJZ4y3fiJoiClwcf/BM+Hw9KLQn4IhVUfFCSuar
         6/wAvvVn6yftGiR1m/DDzR2zzHDpdKvETW4hJMvJ82LIWqKOCPPmqmTEZH6iyhMnCBVB
         6R7IXRkcgOCIKo+Ota7tWwK+wH3X2pFqfHsGpQN8zkIHfn0RDTyM4+DfEqskaZd9erDO
         nKW+zfPuyry/nDiXxPL4+ll5MP9SXNz5XRvxCggsi63u2tZ3RKF0+NdvBUVNinYkBFxT
         Tfx9SjzqUbbT+SqywinllpMgAFp3c3DD+XRlguLKS1w7aXeX8CH5CwmGZ9tbMY8kpiKw
         Ecmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=cMdvVG6gsVrl67bRH/yjYyvxFVJ/s7FYCJ8TDUHq/e8=;
        b=ZnMWq3kz9OgBUuQpPQWTc14NoVpALEeBL0aVlwlUMA4cPJUZ1AM0SOpEa9tZ3G/YLc
         u50g6ebQpXwbtL6voO2OSS7Tyzm5k94d61gY4bK87aaf8V5xj7L2lHXVwVjGyyb9ai4J
         IEvVWP4OV6T1awBQzAgKZwDi3XBYjlLGv0l0jIHfdlbeNqDJxxiROCzrP07zy0Vm89mQ
         nOGBV/y78i2UUQTl+trz1AUySFMI1PoNsnfrBbwQLW4jbZHEC2Z8I/bHT8QSdypUZk95
         ccqXrrUchl9nKxoHK/FFr0zyfn6vdbV2XQxE++9CzuBcVRHQ50ZNCi8jY9O1MoKRMHyf
         UB2A==
X-Gm-Message-State: ACrzQf0opoDgR8GaHlB/Fh81nuAU71v4ljZsdbb8ZobdsHqrcBVC1dan
        JYgpyqJfLLBgippeONxBPqNowg==
X-Google-Smtp-Source: AMsMyM7pAEtgR9SQVfgG1QhJMXvMDKkf8XyniYQR7ul4iT246LQLXLILmqxGPic89ZHI2yzTTionMA==
X-Received: by 2002:a05:600c:1990:b0:3b4:c326:d099 with SMTP id t16-20020a05600c199000b003b4c326d099mr13751533wmq.19.1664182573985;
        Mon, 26 Sep 2022 01:56:13 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003a62052053csm13123493wms.18.2022.09.26.01.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:56:13 -0700 (PDT)
Message-ID: <2b57b492-8765-8629-1c94-ea04c0188792@linaro.org>
Date:   Mon, 26 Sep 2022 10:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8941: adjust node names to bindings
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925210229.128462-1-luca@z3ntu.xyz>
 <20220925210229.128462-2-luca@z3ntu.xyz>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925210229.128462-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/09/2022 23:02, Luca Weiss wrote:
> pm8941-misc should be called 'extcon' and pm8941-coincell 'charger'.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 33517cccee01..01f14d5f314d 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -27,7 +27,7 @@ pwrkey@800 {
>   			bias-pull-up;
>   		};
>   
> -		usb_id: misc@900 {
> +		usb_id: extcon@900 {
>   			compatible = "qcom,pm8941-misc";
>   			reg = <0x900>;
>   			interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
> @@ -138,7 +138,7 @@ pm8941_iadc: adc@3600 {
>   			qcom,external-resistor-micro-ohms = <10000>;
>   		};
>   
> -		pm8941_coincell: coincell@2800 {
> +		pm8941_coincell: charger@2800 {
>   			compatible = "qcom,pm8941-coincell";
>   			reg = <0x2800>;
>   			status = "disabled";

I think those changes are unrelated and should be split into 2 patches.

Neil
