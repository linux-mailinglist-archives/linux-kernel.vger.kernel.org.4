Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B96A1A64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBXKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBXKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:35:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423166950
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:33:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i9so17160287lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677234836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRnJwyzUqjuU0z+FmmZHaXTEUHiO7ZvbRBc0gbEAgJU=;
        b=aKBXMYK/kVOe/kD1qhF3ZDqDvd5kp6IBmz2E17O+HeDB/qoUgpJYnIGkhf5ipfOS5H
         eDIuO9r3azNw03ljLdHWlQKbaYDmGteB3h8BMmsyP1ig2mqHUasRSqUaGDKV7gD7TTQt
         q2wqrensFNHhxu7q0TmJyBQPB1pyea4EqiZh+2DrRfKxk6kGkPu35JvpiyWfQl8fyNPv
         ZjGEtIx/pl36JZ9+cxXnjZlktPOSyeeKH5AM1daVeJSfxoPoxx26RSrENA1KXCHRnNxm
         ha9m9XhXZOLaSH3fL4fmc7w6tw6AZOJWPfmUwph81GFrbUEiv6dfnmBgMKKWOqAug9kG
         2hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677234836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRnJwyzUqjuU0z+FmmZHaXTEUHiO7ZvbRBc0gbEAgJU=;
        b=grIHNdAJji2LipAn+QMKj12bZqEPwvyRkXOwYdBbIqlRSBxyGo3egVt80PY7VQe8Yj
         d9ze0kaN0HiIH+Z1BL34wpv3iBBT7v5TSF4285RJQAXaRZk0Mh6RlSRbe3jcKG63Mjpd
         pnM+HTAxfiu8x6tirABBHcJuTrryMyAyMEETyDUyZQThKJN5Xfgpa43ZfC0AxT9TIj48
         LqnUyHgiXM92idt44YHGik5Ai9WlraKBXm94eS7oczOoddAADETV5N419DUJLa+Hp+uE
         3wbHOoG7xF7jLvm7Es8eShw5KzXHW0GoSbEnp1pN27PL3HUGnFQx6UOoV0SF6plBhpMr
         nLXQ==
X-Gm-Message-State: AO0yUKW5RIO3+dbhL3l2U4oEf639vMtToQ0Ko/t8/b7kpt9wPGNZD+9R
        IUQpHpvzvEVhgglTgEBtkdnpnw==
X-Google-Smtp-Source: AK7set+rwdNqYZOVQEUon/RZ3hjn9Oox/3KITLrfJ0GFkSIV+QoQ9z3F7EiuRivMQxZStUOUkWnvsQ==
X-Received: by 2002:a05:6512:41a:b0:4d8:69c3:f76a with SMTP id u26-20020a056512041a00b004d869c3f76amr4707992lfk.11.1677234836215;
        Fri, 24 Feb 2023 02:33:56 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b004db3dc10189sm835989lfb.292.2023.02.24.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:33:55 -0800 (PST)
Message-ID: <d7d2b443-298b-700d-4ef5-9fd37f9e1467@linaro.org>
Date:   Fri, 24 Feb 2023 11:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix the iommu mask used for
 PCIe controllers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.sharma@linaro.org,
        srinivas.kandagatla@linaro.org, quic_vkamble@quicinc.com,
        stable@vger.kernel.org
References: <20230224080045.6577-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230224080045.6577-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 09:00, Manivannan Sadhasivam wrote:
> The iommu mask should be 0x3f as per Qualcomm internal documentation.
> Without the correct mask, the PCIe transactions from the endpoint will
> result in SMMU faults. Hence, fix it!
> 
> Cc: stable@vger.kernel.org # 5.19
> Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index fd20096cfc6e..13e0ce828606 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1826,7 +1826,7 @@ pcie0: pci@1c00000 {
>  				      "slave_q2a",
>  				      "tbu";
>  
> -			iommus = <&apps_smmu 0x1d80 0x7f>;
> +			iommus = <&apps_smmu 0x1d80 0x3f>;
>  			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
>  				    <0x100 &apps_smmu 0x1d81 0x1>;
>  
> @@ -1925,7 +1925,7 @@ pcie1: pci@1c08000 {
>  			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
>  			assigned-clock-rates = <19200000>;
>  
> -			iommus = <&apps_smmu 0x1e00 0x7f>;
> +			iommus = <&apps_smmu 0x1e00 0x3f>;
>  			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
>  				    <0x100 &apps_smmu 0x1e01 0x1>;
>  
