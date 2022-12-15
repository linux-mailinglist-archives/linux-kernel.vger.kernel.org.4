Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C064DBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLOM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:59:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752892B25D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:59:18 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s25so9865873lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llSMRHSy8fgpG88Qu7rkldd0ovXSCuBQ6quLIMM8cUQ=;
        b=DmPKEbk+miQLCapY/IsQqkSV/b44yx7ASxmgkXl3CzuhNpg7lcofWNtM1JgK5fMxrP
         eZKe2+fWED5QvpOG14PK5DpcSrcp+xE4gmJmgwENgQzcPyqssazV7BxwJFCDzx+VGyt6
         Nx7YXy60QsFbXPS57alA6EXS7MmnQQ9VZeoijvBMYBCpbjrC9wTtmDOy0HVt10gINL2a
         uNTq91Efa6ovksuGKgEbZrMqrRAaBuCiiO72zGmCHXTQPFPnqF3Cfvr0aIfIap5YMaG1
         rDE9QMF04RjxL3rPebEYFpJ8thmiKQw1ILXo4xi4OgWgz9+kN+R2oyIHOl/9UduYM7Bx
         wzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llSMRHSy8fgpG88Qu7rkldd0ovXSCuBQ6quLIMM8cUQ=;
        b=2UyOqM2Py4bwg0XbCjNUXlZqdx2ngJ0/YxO0kpoAB2HbT/iyjApRMGp694CdI6FNTS
         t6ut6Z0lSLSBijlOSSJ9PWWK3Ovda0N85cgJTop6tS/bHAGiC99MYU/RLRlKQYFT/vDj
         wUOGd0607pjDhBuDt1n2080ThB4DVxZbd60s5ShscbU6VJDyEf3i4ShKGgEl23s+ii1N
         XEAQsKZuWMl2JkIyZ1ASSepjTu3myTXm40TfUH/z9/Mu18gC0cBpKQ77rJfLjDy4fXS5
         /wzjhw+BMUXrZ5MK4AVjOWNNLVKwVmlZUhmqRm2B7UgKfzLMFL6vjGp8y78iMMjDGbxI
         Pb0w==
X-Gm-Message-State: ANoB5pk/FZ91LcwbNnDQVN/+ruP+ebVWsgP76EruxrQpqr7N3/jxfQZL
        vOgMxd3pido71FOW28glFt5hGg==
X-Google-Smtp-Source: AA0mqf4MvuxcJCpBYYDHZflz5phGsIFb9j+cuEr3AVvxBMMcQehX8PmKMor9XsgFdQ6gUAlgdRHLNw==
X-Received: by 2002:a2e:96c4:0:b0:279:c5ef:c05e with SMTP id d4-20020a2e96c4000000b00279c5efc05emr7593868ljj.6.1671109156795;
        Thu, 15 Dec 2022 04:59:16 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id r20-20020a2e8e34000000b00279e0b8bae5sm838818ljk.84.2022.12.15.04.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:59:16 -0800 (PST)
Message-ID: <54980c40-f49c-c895-591d-c2d9626c3fc0@linaro.org>
Date:   Thu, 15 Dec 2022 13:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: pm8450a: add rtc node
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
References: <20221214210908.1788284-1-echanude@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214210908.1788284-1-echanude@redhat.com>
Content-Type: text/plain; charset=UTF-8
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



On 14.12.2022 22:09, Eric Chanudet wrote:
> Add the rtc block on pm8450a first pmic to enable the rtc for
> sa8540p-ride.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm8450a.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8450a.dtsi b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
> index 34fc72896761..c9b8da43b237 100644
> --- a/arch/arm64/boot/dts/qcom/pm8450a.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
> @@ -13,6 +13,14 @@ pm8450a: pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> +			wakeup-source;
> +		};
> +
>  		pm8450a_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
