Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB1652DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLUIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:12:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFEF1F2C4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:12:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b13so22363438lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmMv6arrS6NFNzx+/euB/gP43n+k7aQRktlJ3iUoiuI=;
        b=JrLRWpcaGKgvEuvTvOKCdDB9dLrlP2SrGhu+JtRlNZMIdwJhJKESxdEnGVtzkAmmDw
         B60eEmRSmM6lctZTVYwi8E0moO3zsm6/JuUdnT/kQwn0duiDaQB9Fz4AG4xslyH5JpEb
         +RSDqEZAFQUWTJKV99CkoyplVeY81d3mUr7gUG+YhO3IDk244JbtlQUeEeAiWaXg0gpG
         RnNfNQBQUDjgNVW/BGWJizaVMKn0I2o0dtBpV26lFnFRL3RPCyc6tTWGjc8EOhguVaOt
         AQbsiS3X6bYpAf0aelHTU21NfGJUvPTEOxUPhwp2XZr/eWZIKOe7pQa1kfuhIi5d+EXN
         AYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmMv6arrS6NFNzx+/euB/gP43n+k7aQRktlJ3iUoiuI=;
        b=U3brpW34ho5cni1NPbb9Pg3GldBxUYluLouxDgbjHbfK/60PEtdHVffHXgNsLo9BX9
         BFwxcW+48V0cMbjWnn/4NbNxC03e1SPwyN1SIMVY5YDZJKyB7gD3ljmq1plTc7ax30+G
         w9okzu0wRNfpHMfVrNwZTBFxfhhxdiO9QQbC2mUnfXKOsPJvbZhsdC6gxM5a6lErQoWW
         lA8qKL26NK/FWy3O1QnAknLBLosvVNNJUvqCFKDDxS2qSj4J5f0Vr8PBlyGINPoaIjrI
         GjJRgWD5lbTDzTzlFiwn6PCBaCI7KoWgjs2BGefekko1QtiWYDHvjNPRhDAj5GIQ/lF3
         ZUKA==
X-Gm-Message-State: AFqh2kqKwX56WSTy2dAKm7itf3CjkZ2zrcPXradT1TlYX4Shv10rWVmm
        StgIKjbVXiNXvLPGSNzCYpCmNA==
X-Google-Smtp-Source: AMrXdXvuA8QbIWLU3k0yNJc6O3vB5Weh4uzIGXMr+BpW9Slch9F478xD1kzjF/Usr1R/66DQozY+pA==
X-Received: by 2002:a05:6512:3769:b0:4a4:68b7:f86d with SMTP id z9-20020a056512376900b004a468b7f86dmr391286lft.17.1671610329114;
        Wed, 21 Dec 2022 00:12:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r14-20020ac24d0e000000b004aa0870b5e5sm1776887lfi.147.2022.12.21.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:12:08 -0800 (PST)
Message-ID: <afd7851b-0846-c21f-a769-10fb920c7c80@linaro.org>
Date:   Wed, 21 Dec 2022 09:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: add display port audio
Content-Language: en-US
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221221071734.2887901-1-judyhsiao@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221071734.2887901-1-judyhsiao@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 08:17, Judy Hsiao wrote:
> Add DisplayPort sound node and lpass_cpu node
> in sc7280-herobrine-audio-rt5682.dtsi.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> 
> --
> ---

That's not a correct patch format. Apply it, git show and you will see
the error.

> 
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> index af685bc35e10..69e7aa7b2f6c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -33,9 +33,22 @@ codec {
>  		};
>  
>  		dai-link@1 {
> -			link-name = "ALC5682";
> +			link-name = "DisplayPort";

Why do you change link@1 from DP to ALC?

Best regards,
Krzysztof

