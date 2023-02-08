Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EC868EBFF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBHJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBHJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:47:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA07EB4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:47:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1005523wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKWqqdCURAlapoO/zHZWEUEDu0sAlPmjm8qcDQuj3/o=;
        b=AFNOTmmNdAi4x/iq0lW+2oa3/iowxBepitKje/bk2kk6yjnAWpmUgP0MxfcniCjMxL
         cLVfAlnvmWE1JOFK+8cRNKB9+jnZPN/Sf1bAwNmd2DXnENBFmaxqXe89MujccTCkMjRX
         IA9ExMtJqnxPKYjrRlhRKRu9d2T6d1TyhYDVvkBsnZKjCn16fglpcS8NgLgbqBs/MrBk
         6Nn+1J85dwESa8fl0Wpw5IubPMiiJ80dniqqtFCMdOgeDFjUFU2cCnpyECRe2lAtbUzB
         Q/+5V9F8RD666Uv4wNDwe5gSu8XLVXf+jVKFoZN/mHwN5GyHTvmMo++vW7ic6HPqKT6p
         to2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKWqqdCURAlapoO/zHZWEUEDu0sAlPmjm8qcDQuj3/o=;
        b=kgrJ6+FKVuTRQBOKxmFIyBTUb7tkV63Kf1e7+o/XDAsV2YBwHwKZ4oFP8Lk1DFHxqf
         6jWL9Xr4BzswYb93yDLvVCfDPz+cqmDoaS7uo9gLUbau/46eikoDX06IgA2R+SDGFQZE
         817criyWWhJ2gCk3HLJhqnvx8gjYaPz5wJ7BgcWnxQN+CxjTIDlpNI3ZKUdKDQzq91+p
         vGTaqL0uTnngOzp8jqEpFX8J0gXtEccQ+Z4SocZvc/ohLHJ37g5sNs40VYxBr2AWwNhx
         5w9pQZvx8LHjqA9sIR51416p3Dczd39Uo804ryrbYM1PuBagEAB571n8PAaXJ0h14eFd
         HD4A==
X-Gm-Message-State: AO0yUKXxCyHLiGYu0jRYcDYJ2vyHLZmeRNSk4ObxxBePAE2XgUusw6kA
        /tIIWB3nclD5oLWDGr6XGQSfPw==
X-Google-Smtp-Source: AK7set+ZZUFlxV399UI0n/SVY7Of+MZ69YbRTQXn/l8hvQlxCOmoVOKCL1/Tu0HKM2KpvYZ47j80mg==
X-Received: by 2002:a05:600c:a291:b0:3e0:1a9:b1e0 with SMTP id hu17-20020a05600ca29100b003e001a9b1e0mr7956771wmb.25.1675849623242;
        Wed, 08 Feb 2023 01:47:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003dd19baf45asm1434879wmo.40.2023.02.08.01.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:47:02 -0800 (PST)
Message-ID: <045f1afa-f442-0f4c-7dd2-292ac472b12f@linaro.org>
Date:   Wed, 8 Feb 2023 10:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230206103337.21000-1-quic_devipriy@quicinc.com>
 <20230206103337.21000-5-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206103337.21000-5-quic_devipriy@quicinc.com>
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

On 06/02/2023 11:33, Devi Priya wrote:
> Add pinctrl definitions for the TLMM of IPQ9574
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V7:
> 	- Corrected the indentation in the Makefile
> 	- Unwrapped the lines in ipq9574_groups wherever applicable
> 
>  drivers/pinctrl/qcom/Kconfig           |  11 +
>  drivers/pinctrl/qcom/Makefile          |   1 +
>  drivers/pinctrl/qcom/pinctrl-ipq9574.c | 828 +++++++++++++++++++++++++
>  3 files changed, 840 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

