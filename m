Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE86D8280
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjDEPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbjDEPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:48:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAC271C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:48:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h25so47240718lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709679;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKonR24nSDyYm7Ieqk2dep9FKR54QCn4B5tDZ24y3Ng=;
        b=kKbrZ+iaSC7Yu3YzKNADH2icpm070dKP/SIWuzHzfqtY9x1sKSwCV9A5c1oq+qRnr8
         EtaDE+nLrlL3vppSRsOU5mzLhBfAuLe5m9ckaA/1pkDYNcVQLxNXT00tGbFJqAEP3MXt
         CUf/U7t0js36Gdnw4wHz8Yw4m+Vx099qJC6ytO6iIccjxaeW0YjD8bjHXyG/EB2lRXbk
         F8fXgBWmWeiM0/8Q4eCV5AsREpf+CCo+ORd0rjMcCr3WTLW+pHakS354Ni4lldDKlUF+
         5/qreD+ZkuXFuE+kOEsoUQE2cXd3ImLVLfgcFcfDEkGxldhc5gURj/VZJQZyMZk+m2bn
         kymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709679;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKonR24nSDyYm7Ieqk2dep9FKR54QCn4B5tDZ24y3Ng=;
        b=lrCBwl4d0tdfjFwo5GDzocALXlZzZN1D4P1owVFbzGPt/P5TfXgtjmWDD0KmRCNEK7
         hfrR01tkTLP4dDZ4Gu2zQPYqTsQjkDlKTwpNrpr6DD1KWNC0JgVRs4q8Kl+v7EAywTip
         PeSWknxCspy0HL3uA0oOunKl3MFaZ1b9jeWXVyTNYptKM0b5yOkHN8SmiQHBW0vWETGk
         DfGGC+ir+66Y5aK2KhlZCm1ORp/4mzVAtj+9W6KOYFrelwai8U8YftkxuS6LeixX/YEm
         lNQhuVoGmjETW87Nx4waKrO129igNFex7yxaqh9+QhmHHcZgGwQvBr0ptJQS+0PJizwB
         C3zw==
X-Gm-Message-State: AAQBX9eAJkqg9Qpxp1GJbZHcZj+uJD/6Y5UD+IwnFTx/p9BpBH8b4Ah2
        Dq8bc9LGLy11LBwMiFkXvgJ1ONgNT+ztemRTZ0U=
X-Google-Smtp-Source: AKy350YlOtrby8+1b2cWK3t+U7P4jjX4N6JAdSanLEFgBA9bMA8rVw6MHD6eUQT/DED8AJ1d61hy6Q==
X-Received: by 2002:ac2:511e:0:b0:4e8:893f:8079 with SMTP id q30-20020ac2511e000000b004e8893f8079mr1693229lfb.64.1680709679152;
        Wed, 05 Apr 2023 08:47:59 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2862449lfq.134.2023.04.05.08.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:47:58 -0700 (PDT)
Message-ID: <11e9c41c-fc5b-c072-9386-4b1bc11c6f41@linaro.org>
Date:   Wed, 5 Apr 2023 17:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc8280xp: simplify
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
 <20230405060906.143058-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405060906.143058-3-krzysztof.kozlowski@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index c195a57fd180..82c697118163 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2602,8 +2602,8 @@ swr0: soundwire-controller@3250000 {
>  		swr2: soundwire-controller@3330000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03330000 0 0x2000>;
> -			interrupts-extended = <&intc GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "core", "wakeup";
>  
>  			clocks = <&txmacro>;
