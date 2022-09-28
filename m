Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6125ED688
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiI1Hll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiI1HkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:40:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF3F312E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:38:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cc5so18391170wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=9mwqVpcROHFrTuun+8fH0k0fzdJFZz46YIZVmPKpuM0=;
        b=dqb92086L3WbdmsM2vxAQEEN6+JbVZN0w9+uVpNEhj1bGsDBA1zzuPo+IaW2gGHqGH
         PhQm3zVFFKePmtYcZOnF206vDk+NEHCzAgeeQKzaKb0VCqqgHVGbYWNFyM/oDidkThwW
         J4CLQ0VcmO8jIoipyCrQgnKoHDr4e5vWgfXiLaQ15lmUiqoezLzsZd+cZfEYFj94cE1E
         2ywyCFD8pH3wLO9TozuoR2Jafb0vxmh4es2pOHUVPrdhhuE2h7/TH2cMwTunpo7PxuRM
         24VkPKFG19EHEDPrti7s1UVvWGLJPqGjCCfJ3wzEZ3PWpw01Wh4gzGvg1pCfV4fNGPtw
         Z6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=9mwqVpcROHFrTuun+8fH0k0fzdJFZz46YIZVmPKpuM0=;
        b=4Lqt+1rWH4/tZUekKLEJ8Uj1NsJejlI8uSS8+8Gy+lUNaDRwKFN0YwU7oXRAwPWXvA
         udh1UeWI7WsBnu7NYTdMPy8Aik/orrPgchf4hJVwXQj0+i4bYA9jOOw0/OwkCS7v66h5
         /dhZSIPtKHTUVU1iAIuP1iPH3lXGQqrtXpaH7tU7P19zCOW3EF3yOQnC8cmThzTpIOb+
         ropsYbQeVr0Cfk7+7bNY6dw+/CC+M6EYkvc2QbnMiHQ4FNr3A/L7NMzQUTfaUYnoGPbG
         2v/JVJH5akuEV8tAB6N8Y5USyBIig1nHHgd6GMGl2Q5gtXn0Zo2Bz3bY3X3SbaB9Ox1I
         lirQ==
X-Gm-Message-State: ACrzQf20Y8oLukyZ6IMhT9CjTx1WfFrJWsTab08NwVTlTTGP3Im7OMwo
        f34y7V9jV9tgPY8NXDSpvulXeA==
X-Google-Smtp-Source: AMsMyM70jaPUX0HYeQSyigtQZAXaqR1jhEaKm6f1s+rJ/gb94ZIZgWq8iycJ8wjFpkFgGA4s9wRhcg==
X-Received: by 2002:a05:6000:1e14:b0:22b:3aa1:f310 with SMTP id bj20-20020a0560001e1400b0022b3aa1f310mr17725979wrb.108.1664350729006;
        Wed, 28 Sep 2022 00:38:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id ba11-20020a0560001c0b00b0022a9246c853sm3552446wrb.41.2022.09.28.00.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:38:48 -0700 (PDT)
Message-ID: <d78d7a8f-e116-b18f-9a4d-eadecef329ca@linaro.org>
Date:   Wed, 28 Sep 2022 09:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/12] arm64: dts: qcom: sm8250: correct LPASS pin pull
 down
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
 <20220927153429.55365-4-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220927153429.55365-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 17:34, Krzysztof Kozlowski wrote:
> The pull-down property is actually bias-pull-down.
> 
> Fixes: 3160c1b894d9 ("arm64: dts: qcom: sm8250: add lpass lpi pin controller node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a5b62cadb129..8f402b912c62 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2454,7 +2454,7 @@ data {
>   					pins = "gpio7";
>   					function = "dmic1_data";
>   					drive-strength = <2>;
> -					pull-down;
> +					bias-pull-down;
>   					input-enable;
>   				};
>   			};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
