Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6528E6D82AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbjDEPw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbjDEPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:52:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FA76A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:52:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g19so34129867lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzhGkCCE7Mmse3BXh1R6OwWUFg/6uxYNifrssBA8/10=;
        b=RTcDdys/xqW5gM53VxD5eUZfe++zteVv3zK0GZQs+udTNMQNDzW6VKV7HTHqx3I1mq
         abMO+hINJMvgKt1jSfoq+K6058w5R7H/Gz6NM7FBzyo0an3sP1jR3HFPMix53UpSagWc
         9itE6Aw2GDkoFv2FTuav7IJIeF6OKX2aU6FGLL6qL7aDPCrzP+TLa1nwZe/kaS4/qLvj
         MA5EjSGckxoO28/RU4+aa778fdwaQAD1CPCDQ/vY/tqpEHN8Eh+ALMfgpRI2TgwO6B1f
         tD9RUDC7jRVt0QkqimCcnrtCwuKIDtpZhs6oLchHVuvkzEAeIGbTAKQpT+73LRdh7GR5
         4Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzhGkCCE7Mmse3BXh1R6OwWUFg/6uxYNifrssBA8/10=;
        b=zu3O8T+A+ukWheKH4093bm9GFN5xi9fCW4merRmuFezYE02APMttMEY1NopinRhgMS
         WUELWe2xPQBk0ZjbrYbk5IkcJ12mCJmWJ2+oYlo97D/pBcJ/MHGiBH/lbqukyEo1G3L0
         bB8QYdVIeMKtVD6hyCBn7anhEcZSBaKdYRXxZrHmwavv2gqR4lcTsr1D8CnPg95DmGos
         lxqkchNfQ2DMEX49LknY6O4lS3fHPe+SJO7Hi/M1oEWVkPmingIYFnTK0xuZLCQbYDDs
         PQNWl8hrzUFs5jcM3li36H5Mx0crd7Q9l68s5u9KO6P3uAGHJ1tZIsYP7wIkDLmXwxHO
         9k9A==
X-Gm-Message-State: AAQBX9f/o2B9L5pAMHK5WOJfKz/8vKJItkC1HKD3+kf/EXdVZ9oUJRlf
        5oLJ8zJqIDRY2W5eY6OjjsMjRA==
X-Google-Smtp-Source: AKy350aboXNnQOxQffuMVZGBS1YW3IivyHOCDAxSN+Nh9v8H4PML4Vl64+16f/8MX3+PYl7C/avJrQ==
X-Received: by 2002:a05:6512:951:b0:4eb:beb:5edd with SMTP id u17-20020a056512095100b004eb0beb5eddmr1609116lft.20.1680709932376;
        Wed, 05 Apr 2023 08:52:12 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u28-20020a056512041c00b004dc4c1e1e97sm2869112lfk.264.2023.04.05.08.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:52:12 -0700 (PDT)
Message-ID: <f9311055-ca42-f497-0049-ac5428713ea7@linaro.org>
Date:   Wed, 5 Apr 2023 17:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8450: simplify
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
 <20230405060906.143058-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405060906.143058-5-krzysztof.kozlowski@linaro.org>
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
> The parent controller for both interrupts is GIC, so no need for
> interrupts-extended.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1dd000748f9e..1dc5d2c49aad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2298,8 +2298,8 @@ swr0: soundwire-controller@3250000 {
>  		swr2: soundwire-controller@33b0000 {
>  			compatible = "qcom,soundwire-v1.7.0";
>  			reg = <0 0x033b0000 0 0x2000>;
> -			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "core", "wakeup";
>  
>  			clocks = <&vamacro>;
