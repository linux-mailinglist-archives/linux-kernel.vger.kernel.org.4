Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB66577BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiL1OZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiL1OZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:25:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B8B90
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:25:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bf43so23824018lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygg4rZrJblpZ6eqkZAtejmvUQwK/bibHGkf2D9EMGIM=;
        b=BUMDGfKKV22rQbn8SNIQb9RAQHxfELwgw6NrxPFq85ffLnigQXv8yyBybUZy+gr96m
         egezrCwLm9bGn/lfSkiSHPlWlsex7MOZfydyP3oPP957mabM2vGvVi0sm5Io6jZo2e1T
         4u0E+g8FhPCQOI6rq3aOpGvQZ+gnioj1AtGsHBmAFZshKidyhJwxcaW7gccjYtc1eImc
         d/GJKDhLL24i360XSC+yGicc3zMCZmCC9jS0M5L+mz7ybihnCmr3SIl8WbMfeC0K67wK
         5ST63pLx21PNCL3MOUbC4cRrgb6ktRJnSa+Q+6xGuNH0sG2UNGDvOeYfiurS5ZvZSpuw
         Ubeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygg4rZrJblpZ6eqkZAtejmvUQwK/bibHGkf2D9EMGIM=;
        b=eVtUbwLD2gegrY9OLAgv+qz0HGxjWzuyjysx+YalUFwNXH603VgT6TNeKOtejIxyyJ
         IWWaB94Z3sQoVhW4B0m+ZXYHdiNo8tnm8gNfH6FXAxf2aqCsxB1qem6tXZawwBDx+m18
         OhrvtDURN9qdFKr+6co+cflPHuRQftVG1Ns9cD50eX6ZHKU/e+N1x1lI6hGFrdrstaq+
         blcgXZs+KHom1JUs6k3WXRX7rI975CVQrnkH1kZJRWts8u1HOGgmttL4/hwKmDcB1Vnn
         lNVirOtBisP8v8Fj322qcFXSlcQLlbG4Q5tuv6k5Sp5liKL9Hmxq/SJs77PtRd1KXCAU
         pzuQ==
X-Gm-Message-State: AFqh2krRc81gCB3aNcG53LvMzRN54RD5p1W9B3x/RHtPwWT9UIypRpnh
        0L2eKfyhf4TkwSMFXxKro9C9Pg==
X-Google-Smtp-Source: AMrXdXvtfDNkf8QO95Rlz6ZYLer9mXJSPCN1r/5ISLAJ2smSsYjdzD+58fKhGTVqtYGOIJVyQVBEEg==
X-Received: by 2002:a19:7110:0:b0:4b5:5a25:f2d0 with SMTP id m16-20020a197110000000b004b55a25f2d0mr7778543lfc.44.1672237543647;
        Wed, 28 Dec 2022 06:25:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020a2e9a81000000b0027fcb748a32sm451291lji.52.2022.12.28.06.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 06:25:43 -0800 (PST)
Message-ID: <279dc76c-9e60-dd93-e2d2-c2dad241620f@linaro.org>
Date:   Wed, 28 Dec 2022 15:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8350: add missing
 core_bi_pll_test_se GCC clock
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
 <d2e303d9-3ac4-f574-680f-4f5ccbf5ed13@linaro.org>
 <5001001a-203f-e832-f916-ce483b2d8ea1@linaro.org>
 <97a27c10-411e-8823-507c-ebb3f71a48ed@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <97a27c10-411e-8823-507c-ebb3f71a48ed@linaro.org>
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

On 28/12/2022 13:50, Dmitry Baryshkov wrote:
> On 28/12/2022 13:55, Krzysztof Kozlowski wrote:
>> On 28/12/2022 12:37, Konrad Dybcio wrote:
>>>
>>>
>>> On 28.12.2022 12:24, Krzysztof Kozlowski wrote:
>>>> The GCC bindings expect core_bi_pll_test_se clock input, even if it is
>>>> optional:
>>>>
>>>>    sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>> Is it even going to be used by anybody, or should we just drop
>>> it on the driver side as per usual?
>>
>> It's mentioned as possible parent, so there might be users somewhere...
>> Or you want to say that other binding and DTS users cannot use that clock?
> 
> Yes. In the past few months we have been removing the core_bi_pll_test 
> from the old clock drivers (and new clock drivers mostly lack them). 
> Let's remove it from the rest of clock drivers.

If you are going to start doing the same work, please at least share it
upfront.

Best regards,
Krzysztof

