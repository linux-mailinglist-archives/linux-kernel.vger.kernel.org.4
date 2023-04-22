Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA36EB905
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDVMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:06:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5BF1FC8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 05:06:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec8da7aaf8so2734675e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682165163; x=1684757163;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8xysbB7X/7A4n/D8hoYzoSsechy/AMNA5gr6X9cM5A=;
        b=s/2FOzpY8njzNnG01Ka5k8qMmzCnFrvFUqkUlGZyWPq2Orv+7mi7xeieovU8TGK37e
         tEzZi2WbK1/My/xgqtLm5SRFUfo2vSJfnigJIIMmgCwxWuhi/Zla1o9OPHsZkDjbZGwP
         fEQFkfXiiQoeETXGSGEQXoQE30KDtTnQ6yUVcTALy8LFZCSdgLtfhpcOMU6HxM/7y+zG
         aabbxrsHjQocTxDgKRZLIrGCj23kqU7UvcGtjpOMr6dwJy6wPri8M30u5QVgdkVxcSIt
         oJgLZsqBfK/bANJ2SelwPUgeNhx6arq39LuQThqb5DhN7cQ8IMc8362IsRE89sulPQJ/
         /x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682165163; x=1684757163;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8xysbB7X/7A4n/D8hoYzoSsechy/AMNA5gr6X9cM5A=;
        b=Q03owLVVHAvSBAvlD+0s4dB8YdiQN2CbrKwhcFsNH7djGiHeY/1wBNcUgRghDT8l8a
         i39Kn3TOA3N7uGGdnobza0BL7lnCgLH7UlgmFewRCcEdrxsoc1/ILgs4RKL1WEsbCzT5
         +7TcTxsmNe0yqtLZwPVbRJTX5me0VTrF/SsT3Hz2BsgwNEHu6F4FMxlGhJ4hrqGOfbTI
         tZNUX9fgHA6lcHPLUGCfKpCE5T0myVrhlXUXmJNi1sNUqX5t9dZ91rqGX+9POTq47h7l
         /yUpEwkLR3YgmSf+fuE0+0d/lnJGRRNyIY/ECBPgNZTzRL0zdZm1xus6GhQOXH2NtWRI
         pzlw==
X-Gm-Message-State: AAQBX9ejp7/i19rWFVApqvkD9GzMpybrEgRTZHd5lHkkCMJL1GRWEjBp
        gA2RraiR/YWnjnTEo+xjOSKoyg==
X-Google-Smtp-Source: AKy350bipweNDmu8aBHDiKdbJuJowLsE0ToVDrHVVUoJphkdNedyPHdcn0hyhQNWsgexdEQuix8voA==
X-Received: by 2002:a2e:b0d3:0:b0:2a7:80f6:e503 with SMTP id g19-20020a2eb0d3000000b002a780f6e503mr1473364ljl.1.1682165163398;
        Sat, 22 Apr 2023 05:06:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y10-20020ac2420a000000b004e811e3554dsm876346lfh.185.2023.04.22.05.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 05:06:02 -0700 (PDT)
Message-ID: <62ae510f-428a-78e5-75db-e32d4039db0f@linaro.org>
Date:   Sat, 22 Apr 2023 14:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFT RFC PATCH] arm64: dts: qcom: sdm630-nile: correct duplicated
 reserved memory node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211921.79871-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211921.79871-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:19, Krzysztof Kozlowski wrote:
> SoC DTSI already comes with 85800000 reserved memory node, so assume the
> author wanted to update its length.  This fixes dtbs W=1 warning:
> 
>   Warning (unique_unit_address_if_enabled): /reserved-memory/qhee-code@85800000: duplicate unit-address (also used in node /reserved-memory/reserved@85800000)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> What was the original code intention?
Hm, perhaps the original introduction had the common definition
wrong.. I see a downstream sdm630.dtsi and sdm660.dtsi having
the qhee_code sized at 0x37...

I'm fine with either resolution, I think..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index 2ca713a3902a..3033723fc6ff 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -138,11 +138,6 @@ debug@ffb00000 {
>  			no-map;
>  		};
>  
> -		reserved@85800000 {
> -			reg = <0x00 0x85800000 0x00 0x3700000>;
> -			no-map;
> -		};
> -
>  		cont_splash_mem: splash@9d400000 {
>  			reg = <0 0x9d400000 0 (1920 * 1080 * 4)>;
>  			no-map;
> @@ -256,6 +251,10 @@ &pon_resin {
>  	linux,code = <KEY_VOLUMEUP>;
>  };
>  
> +&qhee_code {
> +	reg = <0x00 0x85800000 0x00 0x3700000>;
> +};
> +
>  &qusb2phy0 {
>  	status = "okay";
>  
