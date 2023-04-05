Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D573C6D82AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjDEPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjDEPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:52:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51D65B9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:51:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id br6so47223335lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cKSHRYDJuL73gyjRW08bcPXREGJZF2Tn344M39OF38=;
        b=LfwxblKtQCGZwoKh3PoeIXRtHPJVVM4FtkYoUcBZEZSD0qTAZoNESMw8IGIvsnPzXH
         FlThAoYxVpqi7KyNomuYQvyUfIfmbzzIEmkEhmzFZh+EedgHcGC/En6Izjy4uibkNvaf
         Bb5iaiOG52RKhNsoJALQNXHZB8nYY/xKjQP/YC2lV8S3cfvUHI5mEBuryK1O0Yx3LUei
         rGGRfZC+9nMYBcBZdXuY5oVvMQwW8K6LN2/zCBDeU6VJ+EXG9Ht7BariodNjlKiZdFb3
         8h2Pefb7fQlG2B8rkmkAXafXCTx+qQScNp4p0ekBH0RMS5h6cAF1OOIdr7++qpKeUQNf
         5Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cKSHRYDJuL73gyjRW08bcPXREGJZF2Tn344M39OF38=;
        b=stWAKSOSBy4oA0+rQQMFwCqYLgEi30R9VdCMuiFQTR/0uICbUlpeKYl8H+WfE9kByr
         z4FM/Z6z7yU8lPntbt0H5TS7+MaIyvJo0t2Os1b3nCTSxljp53v/C1sSh8n7GDHUvRbJ
         dF7YDsfe7Uq6roHDhhfun3iLKioiU9G345vts6hql6J7gXpmq0t+O4kUta/dlpPUSJtf
         DkyKjpX3ib5zl1XyZ7+yoPBfPzDSL13iSsFKHAhdjniEZ4QSw2xgwBGOy6254dYrN59l
         Q4cQnOay6hGf3b1gJJznzK02pIG0gEZEPj3FQvBjNrJh2Q+UJ1yjQi18tMZ1h5F8MGOO
         AQug==
X-Gm-Message-State: AAQBX9eymRzNlN8A0OFRFY5hmU32zTuZj0C50RwkUdEF7ETzbq4RPvJ1
        deW5yNmmJ9n9pZSg/q8EUkt2YqW7fPGMc/t8hzc=
X-Google-Smtp-Source: AKy350ZSCHUxvjWiIhfiuCEHVpI7YqChNofOvbUvUvaGRpYf5wkIQ3wArB3n3zzfM/LeSxeOx7+qfg==
X-Received: by 2002:a19:c209:0:b0:4eb:4552:61aa with SMTP id l9-20020a19c209000000b004eb455261aamr1900518lfc.12.1680709917364;
        Wed, 05 Apr 2023 08:51:57 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id f15-20020ac2532f000000b004e887fd71acsm2857372lfh.236.2023.04.05.08.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:51:57 -0700 (PDT)
Message-ID: <94f58e02-0154-491e-094b-f1dadbaa67f0@linaro.org>
Date:   Wed, 5 Apr 2023 17:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm8250: simplify
 interrupts-extended
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
 <20230405060906.143058-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405060906.143058-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 08:09, Krzysztof Kozlowski wrote:
> The parent controller for the interrupt is GIC, so no need for
> interrupts-extended.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 7b78761f2041..fae30dc58eb5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2366,7 +2366,7 @@ txmacro: txmacro@3220000 {
>  		swr2: soundwire-controller@3230000 {
>  			reg = <0 0x03230000 0 0x2000>;
>  			compatible = "qcom,soundwire-v1.5.1";
> -			interrupts-extended = <&intc GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "core";
>  			status = "disabled";
>  
