Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13B65B058
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjABLNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjABLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:13:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1914BFF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:13:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so41164689lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp/E2xpiQcIxTmzefLDj7yuF/B7XddyP9lDxrbw6PoM=;
        b=DYJlyMTVI4rxn39VkT5M3nz3eaDXhl4w28+zHZK9w0mI2Si/iX0jXFizuUscUvl0vx
         Gyj02tCO46fWHOx6dAFUQi578kRJxKagnUSMTHVoYXDri6kTL3eWenmk12k6dK6Hmi7S
         2VnjaHosyjFSbaHQP2IpEEE9/3sTxoEYS0KIfWTn1Daa/1n/vjuQKg8iN+gmUX7Vk4OC
         M+Zo3+9Bl+UPV2UYH8j2VG4VwNR8LpF/uxWj5WZr9HseF6faxwMoPU4VPVNPfUNd5pQM
         5FFtb7NADSs7bT3B7vEoq0bqlcFbE/YX+seQ7nVPWq/iBvVWw/16hAwdT7HKP3BDzbPi
         Bh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp/E2xpiQcIxTmzefLDj7yuF/B7XddyP9lDxrbw6PoM=;
        b=cESpDRyUgyDzNQWVfNjoVqnqyExqPEVYxC/ftZKm/1BSgBHTK3iY6Emcgny0pSriQr
         k/WPieXYfS257VT1PKQo2LqhcsHVgpQ+Ne+fcUHuRkxPH52fa+OBskOYKKrB+wePBTnj
         STzVKJMgz4ptS97DadO0Crr7Vd1iAmW1B3XrO8WuDUrKispg4f9+wRbXS6FWlRWOYRAZ
         +xgKLxDVJkwfo1X9dr6q9DgyXjemox1H2nRx8lYXDConZ1s3BaBkS/ueIQFUPSbzciBC
         CbSmyueqoxpO5IMix6xlEe/L0UXD0HZ2hoD1y0F6UNHmYByEQkMHc4ly12WXs8H+BAqY
         6aGw==
X-Gm-Message-State: AFqh2koSeDX28TwR04oYZ4tXRQj5nd3LYeqNY64X5A5Rpk0kdVay07bU
        074U4PBP0CORPfE4+hrUVmrRnw==
X-Google-Smtp-Source: AMrXdXuJEjDK5aDk4+uxB27Xvh0Mngk3VKSbJaTWJC1SZSp2rv28LmzW2jsvRhfZP/hsxecqsLhJFw==
X-Received: by 2002:a05:6512:3da2:b0:4b9:f5e5:8fb4 with SMTP id k34-20020a0565123da200b004b9f5e58fb4mr15978692lfv.3.1672658020368;
        Mon, 02 Jan 2023 03:13:40 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x4-20020a19f604000000b004cb0d2735c0sm2694260lfe.266.2023.01.02.03.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:13:40 -0800 (PST)
Message-ID: <cd172e6e-a8c0-0e2c-971f-590e155c4a76@linaro.org>
Date:   Mon, 2 Jan 2023 12:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sc8280xp: clean up tx-macro node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-4-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230102105038.8074-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 11:50, Johan Hovold wrote:
> Drop the bogus address and size-cells properties from the tx-macro node,
> which do not have any child nodes.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index c1ce2d7b3675..11e3d560c627 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1784,8 +1784,6 @@ txmacro: txmacro@3220000 {
>  			clock-output-names = "mclk";
>  
>  			#clock-cells = <0>;
> -			#address-cells = <2>;
> -			#size-cells = <2>;
>  			#sound-dai-cells = <1>;
>  
>  			status = "disabled";
