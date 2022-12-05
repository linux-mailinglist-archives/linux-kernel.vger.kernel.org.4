Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE495642739
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLELLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLELKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:10:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88917595
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:10:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x22so4516349ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQlmIl7mlWR7K4AzO1aVBBd7ia/rgwuou65tcT8ylg0=;
        b=indpxQXzV6DZmLi4N2/DxXfFxwhUt6+rSPVVwy6JKsH9Ht0pDjxDzvv8lwVR/NnjLs
         mGk9Tir3jDRmB/vqB506fH7nVshohXF6Cml8gy4O3DZgP777ABH7/xFWAqrwXElMfeNc
         Uk7HFpziUZo0u/xR0B7DKvdU0nBYksiE9zvpFKhj1TcgNBnecU9+mPTb198Y9eicxa70
         HXAyw7lSKu5xuSrtQRHALh5SwY2Z8qdOu8WubPAnSVMBWz1CzC+8E3AX+aBkAE64AGm3
         25kVRt7eFqtMo9spuLSToUV00VNG6u2ZZRmMOqF4SZKMVfaUnauLWHpApri80DMef+ou
         HKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wQlmIl7mlWR7K4AzO1aVBBd7ia/rgwuou65tcT8ylg0=;
        b=hRUjlo2nj/OTXln18KzCxZI0P9zD7BVmDqs2MWXCICwiBWRfBGFn7ecB/dEIoRzrEu
         Vsp1IVdAduaW79Aapl0MnuwE/JoVMrNrHBpTHqIsZpM2WWajYodPAq0L6sMr/rhicHRW
         nDnsuad0EeZ/u2uY9rEGfz3vj9p00qRpa014/EompoeigKq/2oA3yGD2G1msTcEQHoL2
         BSAjjlcDJ2cIwIxa3znAfdjXwkXb4ida9f9S4VNXcuIL6mYSLRpCLPMdFEnnA1LB12JQ
         0OBZUSwvQE/MbUXguDHgNVFudac6Pot4J7QjnR1eD6ENXnAeBo75+2UUakrj7Rjuef7F
         e1hA==
X-Gm-Message-State: ANoB5plJ0xO8Uc9Zx/6RnQRoR1M/Jz6mmwQBeWD55AMp8JwpATBzygIn
        30ZHt+1N+DWwpzn/aN5lg4YARg==
X-Google-Smtp-Source: AA0mqf6Tqe67CLOKrJhvR1b6b2P/lOKhiiMuFQlm4IfPTqperpwWlEX54RN9gXDrHqIS37WgNGvkbQ==
X-Received: by 2002:a17:906:d78d:b0:7c0:fa81:ac42 with SMTP id pj13-20020a170906d78d00b007c0fa81ac42mr2290141ejb.526.1670238641555;
        Mon, 05 Dec 2022 03:10:41 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6235998ejm.178.2022.12.05.03.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 03:10:39 -0800 (PST)
Message-ID: <47393be9-a5f4-31ef-cad1-3c2551779fe0@linaro.org>
Date:   Mon, 5 Dec 2022 12:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sa8155p-adp: fix no-mmc property
 for SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
 <20221204094438.73288-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221204094438.73288-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2022 10:44, Krzysztof Kozlowski wrote:
> There is no "no-emmc" property, so intention for SD/SDIO only nodes was
> to use "no-mmc":
> 
>    qcom/sa8155p-adp.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 01ac460d910e..25e2d9a2429e 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -397,7 +397,7 @@ &sdhc_2 {
>   	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
>   	bus-width = <4>;
>   	no-sdio;
> -	no-emmc;
> +	no-mmc;
>   };
>   
>   &uart2 {
