Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A76E4083
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDQHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDQHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:17:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EB40EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:16:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so7336491fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681715817; x=1684307817;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QiBVp3gGgaCofXC+1Vj1Z3lhTucobf0EXSDOFyEzvkc=;
        b=KwoE4XXavU7Mm3vHfHqB4kCKFtEGt08vCgXiHJCIReCXaUDAClW5vI1OINj5FThnKa
         no49q/U4yv5G2TqIjEEBbCEXyINWRkmblucpCiVFGWg/QGy9XzCbzEyhSPbCDB1DIHKv
         gwZkkD0+dDh2zxhYwfPYTvkzrvXWUAJ9fpJlXCSnpC/4k2yXgiU9ZEKl+obQ/sIKTXqj
         Vqww8XJGXVEtIVY/nb1uiEv6XB4Ra0u/3W81oP8pquM/a4gitX2kSW+uqMuVsGCHsvMH
         erePoYPI5QosBQVxHBPzzbs5l6QMCkH3dpg6Q2H1HdWZWkgn+SvmvDqwwKedofoYWYy0
         YYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715817; x=1684307817;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiBVp3gGgaCofXC+1Vj1Z3lhTucobf0EXSDOFyEzvkc=;
        b=Td3RlJqNNbS15uAdiu8P8FrqOJ84+oisV3wwqNV9C+ozJ55O6QQ6FJKaFHOM91QWZN
         rxGdVWPyOIgBCshBl9FC20mAkSGBj2tPG003hVlTypHaG6oZlPUYw2Dhsrh8Uv+wiHU5
         ywhQ2Q/xD7joSTKDtUzJWNgO+ZeuArDagOugauFtrvqw5yVctDfb0tPF9ssmBdHF8Ygf
         AEjczwSOHT493R7lMFNmH2zf2ms60FIQueUcYzIoYIrc5TQdLeB1TnShSCPLhIn4Msuc
         zQO3Kg64zechGorbNCPkgpUOG0Rn3XP+TqwPqhfgmRcZs5aRn6Zb5LytNqB6fgsqTmxH
         yjbg==
X-Gm-Message-State: AAQBX9fCShzUyUmSRgVNNKUE/gjQL8OH9sHiOUOMQsE35VZLes9USH5d
        6oymEVN6s3nhulTWM4wKOO+EN0ux1hkfZqeT71M=
X-Google-Smtp-Source: AKy350b+w7JF8MVxoxYMrUTAnekinQKn7y3XBROa9yHM/OkhZhbeVPC/bG8VWCcxy0XR+5NwIAcsTw==
X-Received: by 2002:a19:520d:0:b0:4ec:5648:70e4 with SMTP id m13-20020a19520d000000b004ec564870e4mr1517206lfb.12.1681715817630;
        Mon, 17 Apr 2023 00:16:57 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id m26-20020ac24ada000000b004eaf8b20014sm1944835lfp.76.2023.04.17.00.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:16:57 -0700 (PDT)
Message-ID: <ab2af7a2-8f5e-0909-327c-5405ec26aaba@linaro.org>
Date:   Mon, 17 Apr 2023 09:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8150: drop snps,dw-pcie fallback
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
 <20230416151311.346596-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416151311.346596-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 17:13, Krzysztof Kozlowski wrote:
> Qualcomm PCI express root complex does not use snps,dw-pcie fallback:
> 
>   ['qcom,pcie-sm8150', 'snps,dw-pcie'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 024b3c79ea11..1d22eca9cbde 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1823,7 +1823,7 @@ dma@10a2000 {
>  		};
>  
>  		pcie0: pci@1c00000 {
> -			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
> +			compatible = "qcom,pcie-sm8150";
>  			reg = <0 0x01c00000 0 0x3000>,
>  			      <0 0x60000000 0 0xf1d>,
>  			      <0 0x60000f20 0 0xa8>,
> @@ -1918,7 +1918,7 @@ pcie0_lane: phy@1c06200 {
>  		};
>  
>  		pcie1: pci@1c08000 {
> -			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
> +			compatible = "qcom,pcie-sm8150";
>  			reg = <0 0x01c08000 0 0x3000>,
>  			      <0 0x40000000 0 0xf1d>,
>  			      <0 0x40000f20 0 0xa8>,
