Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E241B658B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiL2KSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiL2KSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:18:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF8813F97
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:15:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f20so18977130lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNN2sBvX/0Zx4BfvDXrMZKSh4hziHTKILA1D5f6MaPw=;
        b=tVPQ4VgqeMti8VBB8bvb2w9OZUPkBxxFagYHmnqInLlC+PTsL1t127Ak2nZWAh67rn
         y72I0scdngySfHSrYhPCSC+7BfYeKmzHAxUypIAhhnnSfy72Mo27o6dU9hejfJXtmtkI
         ylwNVIU59+Cw6HD0/u4YeZOzlODHiXNPTNswEd7G36zuXyRUI/k1c3nM9E4NZ9dTTw8n
         E8I5sSByxJpQ/GxfhQLBEg/dbEf637F03YJOOXGJSHx8j8FEmhArryWuKCpU6HR71ppo
         9q0gOTbYNzDpuDKF+OQTJUR+0zLOTJSz5j5td1sY16EDmv6MF8tJ9Aee/FAyu/L8oLyd
         roog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNN2sBvX/0Zx4BfvDXrMZKSh4hziHTKILA1D5f6MaPw=;
        b=0DbVJ2UECfk7ecgn3i+ilwwr/1cw3o0YMi0VuqD5vEWDmFq8mVIB7iHDTxJZkLa6/D
         RPjbX/Uwwel5DkilHPLMUUqqZwQE9qZ9kfGH7V+0KIi2A2B+XXSoYJXoZKzLv9S97TCD
         60CNMOs6ncoSXmZs8YBpYPz58TigOjm+cn90lVBgkUUUeLJaU5AdrtGX3BKZeQJcwX0I
         wBH/9IszOJPvlim8P6AqWtiGf+xDVC+qw2ctif+fYlZX8hw/oSdeah4+0utszzk+DBNr
         08y/53pdt1OT7Cxzjyf/QdDLIWZ06ev81fcAZIPP8PMYX1zZodkT8rRqcb6mv4dUZgqA
         Rh4A==
X-Gm-Message-State: AFqh2kpSxepKTGUkQuKYxcyyDdMvMkPvd9j2qxwpVeCVJ1+DIesIsHd5
        85el+PPt398qYWxR4thuSLmH5A==
X-Google-Smtp-Source: AMrXdXvDet+IpOqiT9isaqBYpbvgjZNIHoQKKIX1RAUCcnec3JO7Zm/Y6kghsRTtnKwuA/tiOfIpEw==
X-Received: by 2002:a05:651c:233:b0:27f:79ff:6d8d with SMTP id z19-20020a05651c023300b0027f79ff6d8dmr7887501ljn.11.1672308932189;
        Thu, 29 Dec 2022 02:15:32 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id b14-20020a0565120b8e00b004ac980a1ba1sm3040839lfv.24.2022.12.29.02.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:15:31 -0800 (PST)
Message-ID: <87839ded-9fa5-beb0-429d-7be233b3d20e@linaro.org>
Date:   Thu, 29 Dec 2022 11:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/4] ARM: dts: qcom: pm8226: add IADC node
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221228230421.56250-1-rayyan@ansari.sh>
 <20221228230421.56250-4-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221228230421.56250-4-rayyan@ansari.sh>
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



On 29.12.2022 00:04, Rayyan Ansari wrote:
> Add a node for the current ADC (IADC) found in PM8226.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
> index 6af259218f63..46ba84f86c9f 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -88,6 +88,12 @@ adc-chan@f {
>  			};
>  		};
>  
> +		pm8226_iadc: adc@3600 {
> +			compatible = "qcom,pm8226-iadc", "qcom,spmi-iadc";
This needs a bindings update (unless it was merged beforehand somehow).

Konrad
> +			reg = <0x3600>;
> +			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
>  			reg = <0x6000>, <0x6100>;
