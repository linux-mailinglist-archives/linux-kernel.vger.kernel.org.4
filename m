Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD963F295
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiLAOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiLAOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:20:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71548424
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:20:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q7so2026283ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6nSuHE3Pr/44zedu7eUKGL+66HovS1bsuN5zk6+UNg=;
        b=sE4Aqubu/Yue3DMRz9z7mJoZMtU8Sjuk8KH8a3UwLnb6Iiqi60SYzB/rZibodoaEJ4
         GnXmNvj3eEeB2g5ex89jlJtSlT21VWDCeLLhwJGH74P0LfyvtWSEiie3xpVGmFGpvfae
         rS2AZ8EgXcr5zoqL6uoGEXyBHmFXI3s1XM95XYd3+CuWBJmfiN/s21v1licFax/YkwDJ
         EES6vaZTYOqT5uhzKthCmto5Kd8HmWlqUd8yK8pPowZUirIaL97B0mp32W75cTqEnzjm
         3oHLUbuBsk0+e/DlDNoSSpDN+kdL40vzIQx/jHsqvfUkcMuMCZimxBvCqPF7a6uKW9wk
         Kl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nSuHE3Pr/44zedu7eUKGL+66HovS1bsuN5zk6+UNg=;
        b=uOnY6sjhmsxbvA5Ms8oj7w2LvigvH488OdWaaKBMq4H31x4BUGNKPG1/0c0/R7Iacr
         pxzXNbaD0x8N6MWI2c30IhxOVu3JSsBFjKlYG/Dmm8SKiHPabqhUaEQ6xXM9rgQ79Stl
         NUjfOqlYKjlGDBgqCfE3QnmfNOshhDNhgWc4++iItEfKXwrNjkGiXgQ4JhhP4pWnRLqL
         qdsS5YKN/0kt9nH1GnsGcE1FUG9vPWuIsmMaq0mk2ZVvIkot+kkOAYD9zJTsjoK0tZX1
         E+H4ION1SAx5BXmpJKILExV0MWMHfBbz3zDCGQuzeLCNV0wt7Vc9+3VJlZYnratAwnEY
         y5MQ==
X-Gm-Message-State: ANoB5pm7VOJzN40X+OioAwQU+u1oFBhIUDxaRJhYxFPoe8pxxNpEtWiO
        i7jt/x5QGIs0O17fe31zKbKaJg==
X-Google-Smtp-Source: AA0mqf7If5LbRmEcs/C6uyWO55A1UHXJQ+iDtv5psBgvbNuUJ38KnMDCkzKCTSkbYeB6kedias/CPw==
X-Received: by 2002:a2e:8946:0:b0:279:d37e:3f6d with SMTP id b6-20020a2e8946000000b00279d37e3f6dmr1039171ljk.163.1669904419136;
        Thu, 01 Dec 2022 06:20:19 -0800 (PST)
Received: from [192.168.1.101] (95.49.124.14.neoplus.adsl.tpnet.pl. [95.49.124.14])
        by smtp.gmail.com with ESMTPSA id x17-20020a056512079100b004b3b7557893sm657241lfr.259.2022.12.01.06.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:20:17 -0800 (PST)
Message-ID: <a1af5928-4f3f-39f8-94b7-31fbf84143f2@linaro.org>
Date:   Thu, 1 Dec 2022 15:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150
 and SA8155
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
 <20221201141619.2462705-2-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221201141619.2462705-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.12.2022 15:16, Bhupesh Sharma wrote:
> Add SoC IDs for Qualcomm SM8150 and SA8155 SoCs.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index 8b1a0f43bd93..5e0524991e99 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -102,6 +102,7 @@
>  #define QCOM_ID_SDA658			326
>  #define QCOM_ID_SDA630			327
>  #define QCOM_ID_SDM450			338
> +#define QCOM_ID_SM8150			339
>  #define QCOM_ID_SDA845			341
>  #define QCOM_ID_IPQ8072			342
>  #define QCOM_ID_IPQ8076			343
> @@ -112,6 +113,7 @@
>  #define QCOM_ID_SDA632			350
>  #define QCOM_ID_SDA450			351
>  #define QCOM_ID_SM8250			356
> +#define QCOM_ID_SA8155			362
>  #define QCOM_ID_IPQ8070			375
>  #define QCOM_ID_IPQ8071			376
>  #define QCOM_ID_IPQ8072A		389
