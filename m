Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D9678161
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjAWQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjAWQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:29:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3528870
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 18so15202410edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKssQjT0tBAIcMGA7sy6uVnZ+7ctGhG589LfOj9iPM4=;
        b=ra8YRUF27QzHnqdyA14HM2CmmW1iaqWhqNwqTQ40IBQj5BNlOwrwvijQckzo603txi
         NLAft7LmzsOZ68vMmxoLt1NtUWK/6MwZN3r6CHN3TqN277qPSpTIxydPCHQqXQAN15sK
         TecSFNTZ2Qbpu6R6DGwkNL3Q/506aB363mbT5ORZilu2PLC4PRsM08VrkAGZkI/+WDPf
         hyTKV54iGsr7/cXJlBaj07Bpdh/hNX2p7GRosJD2rIVEf5swRjrQWfb+to4MziyFVtHA
         waLfpw7IDyZ6MOpc7CeDUdd1BgoTn0MSOM+kTcVOZujgGC067tEM7lZfzYr8JbVy2xpJ
         9GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKssQjT0tBAIcMGA7sy6uVnZ+7ctGhG589LfOj9iPM4=;
        b=XKZL3y8pfrhMnbICO6mx9R17cxoBKK/ki9kA7YD12XRKMbVpVEfbU8MZ/dFDh6Y4vS
         MmhKpUdYuS+W6dwtsJbRGEYIcj0TvwmnTt1sEox2mwtgyB7j4oCDA856loVq81TVnL5j
         J1Y8LR1IPyaayApn76dJQ8zP+Q6pvlbzgBG33Nh+RxCDsZrkE9b0rFtTYk6oDncXiAqf
         xBa+l3/aqdoQ6rXXQFTwhkdmMZW/eWKEIaH2JZdzGYr1QBJ8HBq57hCIwwc4ZQDw03+6
         oNW4GLgi5sn1vh2rm/rh5Q3Z+2eUpzV9v18oFmuSm16H73Lilu+xmCbQa3M3jUthiZtI
         I3lA==
X-Gm-Message-State: AFqh2kqjere9fvxFUFyY+/+/XXdblBnASQJK1cz+9AfmuOpuEfuVArOV
        uKZo3lvQN+BQOTXLCukutiywIQ==
X-Google-Smtp-Source: AMrXdXv1GX4u+Y7AlbbtBpW8QTT7PEL4SlT5DUn114sbtysSuuDSjZW/AY4j8nFBOPxP+YCtYf9Uzg==
X-Received: by 2002:a05:6402:194c:b0:498:b9ea:1896 with SMTP id f12-20020a056402194c00b00498b9ea1896mr30530035edz.9.1674491347207;
        Mon, 23 Jan 2023 08:29:07 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b004954c90c94bsm21795741edo.6.2023.01.23.08.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:29:06 -0800 (PST)
Message-ID: <3d85bc42-22bf-ec40-12f9-0d684af1a68b@linaro.org>
Date:   Mon, 23 Jan 2023 17:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8350: drop incorrect cells
 from serial
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123125612.154840-1-krzysztof.kozlowski@linaro.org>
 <20230123125612.154840-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123125612.154840-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 13:56, Krzysztof Kozlowski wrote:
> The serial/UART device node does not have children with unit addresses,
> so adderss/size cells are not correct.
> 
> Fixes: cf03cd7e12bd ("arm64: dts: qcom: sm8350: Set up WRAP0 QUPs")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. None
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 4efe79985186..018f26f729f1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1031,8 +1031,6 @@ uart2: serial@98c000 {
>  				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&rpmhpd SM8350_CX>;
>  				operating-points-v2 = <&qup_opp_table_100mhz>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  				status = "disabled";
>  			};
>  
