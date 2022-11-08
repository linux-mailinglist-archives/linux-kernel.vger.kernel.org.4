Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6E621E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKHVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKHVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:10:34 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C053C6EC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:10:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b9so22959040ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZAafqOZBdpxx83ZFYFN1Hi8JWgUTuB0MF2wqgfb+j0=;
        b=BmbRlhuIxfQgv60+/uxmJD2mUTMS1D0a5vXHhZdSI+B0M5n7f+PY+aY+i3bYejK+47
         QAdInA8SRHniQJjhhghXtj43Y63XNmSMkmmTfTfgYedB6o8JaZTnyatSRXboWFXzzkD8
         g2QTiyGD9OFXonYu/wW1c7sVz7Lz7oaxfiWFJNRGfSlCfaPJrTkpgUNBuc9HeD98Ah24
         YpHZNx0F0/+cfv0RdCs+sd/hp7I/iGeLbyq/AyZr/jaiGdiBxohdkNnS+fx/fy2Hpfyr
         3WxJzj5MdugdN3Sot7qFgjiKrVQpDMLOmwPQXKT4N6+Tmja50fD0vqu1PTZ0NNp4I0Lt
         djPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZAafqOZBdpxx83ZFYFN1Hi8JWgUTuB0MF2wqgfb+j0=;
        b=igISaQTnMEyad3Es5AKLum+HonzWjaekLzWiP8SQ4WRknMExmD8W/U2H+Yur3PdKA5
         nO5XJqughQlyFYjfxsdy7aHigdaQPFoHrdX4pUogAjGarxnR90YBhzGfSYWzct/JFQqB
         klMcivH/cbB5r3QzVzncHJtrcfTn6FY1EYubB9G/2G1IjFPTW4JWes2481mOey1Kwb29
         bopUOgHYkbgDPnCUp1jfZK/qa667yruksMIIpo7JY1fn6Z/YQ6+NhhE1SgfxfrwPRGFn
         TonsTnYWiG8m4MXMwOn+5C9u9ZGsDExuinxf5dTwndInuUiEvLBJQYBdLY8xZXb3zNAM
         YSeg==
X-Gm-Message-State: ACrzQf2KWcVrbeGr9vH4mdWF5WBMztoSejdBfshwRv+byxbF0Tgdb7DD
        mv4/6pMuinoTxFln4ZWABHAamA==
X-Google-Smtp-Source: AMsMyM4fusBtXtXt1yqqm9JfpkjsgoZrmDOHZ38/STvFvd3nHz0ohLlYZyuEMRbdkEJIFvFcju188w==
X-Received: by 2002:a05:651c:1207:b0:277:276a:9d7b with SMTP id i7-20020a05651c120700b00277276a9d7bmr19141181lja.129.1667941831467;
        Tue, 08 Nov 2022 13:10:31 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id q13-20020a056512210d00b0049c29292250sm1932529lfr.149.2022.11.08.13.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 13:10:30 -0800 (PST)
Message-ID: <b482360f-16d2-6a7d-2cbe-72f2a1c6f50f@linaro.org>
Date:   Tue, 8 Nov 2022 22:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 02/18] dt-bindings: msm: dsi-controller-main: Fix
 power-domain constraint
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-3-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107235654.1769462-3-bryan.odonoghue@linaro.org>
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

On 08/11/2022 00:56, Bryan O'Donoghue wrote:
> power-domain is required for the sc7180 dispcc GDSC but not every qcom SoC
> has a similar dependency for example the aqp8064.
> 
> Most Qcom SoC's using mdss-dsi-ctrl seem to have the ability to
> power-collapse the MDP without collapsing DSI.
> 
> For example the qcom vendor kernel commit for apq8084, msm8226, msm8916, msm8974
> 
> https://review.carbonrom.org/plugins/gitiles/CarbonROM/android_kernel_oneplus_msm8994/+/7b5c011a770daa2811778937ed646237a28a8694
> 
> "ARM: dts: msm: add mdss gdsc supply to dsi controller device
> 
>  It is possible for the DSI controller to be active when MDP is
>  power collapsed. DSI controller needs to have it's own vote for
>  mdss gdsc to ensure that gdsc remains on in such cases."
> 
> This however doesn't appear to be the case for the apq8064 so we shouldn't
> be marking power-domain as required in yaml checks.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Your Cc list is huge and not necessary to store in git log. For example
I am appearing there twice. Please keep it under '---'.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

