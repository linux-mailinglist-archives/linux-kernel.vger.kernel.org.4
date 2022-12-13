Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED7664B273
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiLMJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiLMJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:34:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDA1181E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id q6so3930024lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLw0ijR1P/QD9sJWgEsC47rvSjzALvfc0oOU7u/vybA=;
        b=NBUP0i5Bo2JkflYl1q3hwzwprllGNpNuqiKPi/amMmRsmY+a+D3OmD1qQ6VMIM1q0w
         QBVFw9DyLwTZQyu8Ib0UYPlz4LJsw9digHXjlSedrc2LbvphEVDc0HLZsqmmXwSxgjpm
         ETPqGJsdXmy4fqfcvB1Pa9OsRJwRilv44JEE1vNTyMTJN80WlcVO+dlRjPGQDVCMOM/N
         LeXVIEBzkxiKb1y7zjGiSkwjmFcQAFPtSEtLNmynoFpfH5c74LXMw8oe56U28bBrbfgq
         1vV/W0JJRTkht3B3jQpVgc0dOpg9yQP+qlPks6b7xjHzqJmvmwIVoKXVvUmOvPWY1IyB
         7aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLw0ijR1P/QD9sJWgEsC47rvSjzALvfc0oOU7u/vybA=;
        b=Cor87RHWyVlbtc55SNko6+3DPbsdYLO4zjPfO824Hiku0uZmQ/+djcAXs97W04s03I
         uolsA9YBGl5W2r1EURPHjkY9+ierVaTEZn71wlLc5/I2ZIdomqfXS+SQDYxfR/0EhDn7
         Nry7alMmllWD+yDwDgv4tnV2OxoQE4pNqpK+h9F77TYTNO/Va87wg0riLLUCcpw87Tgk
         A6wbAvGGWx3jd7SWCDeegF2naxXvqKUH6EWjPsOFcSQdOb3aKXVF7N+8lyBnQ4kMQ3VD
         3asZP0FOa2iZ17EwwWPNk6mVXOdhe1LNsiIO+hBUK08t8fhUSg0Tmdl911+gjQnVjh7L
         gNog==
X-Gm-Message-State: ANoB5pnj5GlfHAX/nHdx8BLQUp3yULuL9BTyalDkQnIiMwVu6ORg7Nes
        mYeLf5DxPYsFLGVXo7I1FBtjgA==
X-Google-Smtp-Source: AA0mqf4tDEGssHvi1Y8Iw+rQfW3lTrApyG+FO9irlSBVUQZJQPDEFS6w+1HcbI8GMkJwIlbDn2UAnw==
X-Received: by 2002:ac2:5e61:0:b0:4b3:9b88:d9ce with SMTP id a1-20020ac25e61000000b004b39b88d9cemr6911432lfr.46.1670924092676;
        Tue, 13 Dec 2022 01:34:52 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004b57a253deasm289014lfr.162.2022.12.13.01.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:34:52 -0800 (PST)
Message-ID: <da24e41b-4509-2dd6-1659-be001b447daf@linaro.org>
Date:   Tue, 13 Dec 2022 10:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 12/12] ARM: dts: qcom: msm8960: add qcom,kpss-wdt-mdm9615
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-12-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212163532.142533-12-krzysztof.kozlowski@linaro.org>
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



On 12.12.2022 17:35, Krzysztof Kozlowski wrote:
> Add specific compatible to timer/watchdog device node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-mdm9615.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> index a6331e5ebe09..536bd7b50762 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
> +++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
> @@ -79,7 +79,8 @@ intc: interrupt-controller@2000000 {
>  		};
>  
>  		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-wdt-mdm9615", "qcom,kpss-timer",
> +				     "qcom,msm-timer";
>  			interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>,
>  				     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>,
>  				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>;
