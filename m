Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98B56AC5E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCFPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCFPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:51:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E84736692
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:51:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy23so40382299edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678117896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5WKaU91nJ+P694TRYOMgx3cq+DGCFPwL6ikgUxC3C8=;
        b=ESjcJLj063dMnQZWJplGSMwup2iaf+HjpoquiqJhkDgqe+Bwe6KLmnVVMs75iGiqRx
         Vr7OqpYnid1HjGlasFK+9AhAlB5S4IHdRaeE/MWdSmSHDascJfwiIIieyVNjC3qXv56F
         cbaFPprTTejA/Ub9UwI0JUHkt+6AktbMoISxFB9Dm4DzWvxl/s9nj4l1nVolAUlQNaeq
         NRcq0O1+qSCYXKjQcUioybt/B+ExBG9Qdq+9ayEOYY0NnfidFsmtP6dFJ6uZ7ch/mSL7
         W5subhoHbAsx1NXexaN2YeqvF7Fv6QOC7RFeQQlenvKCZcVsvUJCf9r/K/FrhKb2+BS0
         yyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5WKaU91nJ+P694TRYOMgx3cq+DGCFPwL6ikgUxC3C8=;
        b=N0S5Fxy8qCG1Ed01g+YXD8jhCYae7iNiWrq5RuaKA87ntpFg3JflV0zmqGK1ffadFW
         p6zFDe3cBVQgNjiO5WGr9SMjnbjHa62l2M+Qex7Y75/MEdbuKpVIbsm5y6IP31piNJr9
         57k+qS2MRtq47XxKNh0zrtBpqWiGKo4PP0Xc++VekshqrlkntDpHoUZm581wFbj3om+e
         SV7AFQ/MUk0CIa2LVUVos1IkFTI2nqjA8qS/6FRvN9P840b0hFcQVRYqAyJ4Dzjdx/NJ
         MLI1x5fOriyH+QdkMK7nSX5v3eOD9PVVAb2qf584ftZM82nOucYoJuaqDCy6vlzSZw5a
         L9+Q==
X-Gm-Message-State: AO0yUKWcLsDM4148jVXVJyXX6snAHGxbgX+HMqdiQgbU/NjltNXSF2ne
        ItRuFfh/csWhuYecR1Yf66fnbQ==
X-Google-Smtp-Source: AK7set9lwg+x+76RsWJ6nVbbLxkGydKTP4r6kdOcHarLbeeJ9W9GJHfsJJMd5ctUdgw3OxunMd+uEA==
X-Received: by 2002:aa7:c2d4:0:b0:4ae:eab6:9ff8 with SMTP id m20-20020aa7c2d4000000b004aeeab69ff8mr11998310edp.13.1678117896054;
        Mon, 06 Mar 2023 07:51:36 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:c1e7:5006:98ac:f57? ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id n26-20020a50c21a000000b004a27046b7a7sm5320836edf.73.2023.03.06.07.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:51:35 -0800 (PST)
Message-ID: <48c8a0cf-08dc-a831-33ef-3b8e32eef2d3@linaro.org>
Date:   Mon, 6 Mar 2023 16:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/6] clk: samsung: exynos850: Add missing clocks for PM
Content-Language: en-US
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20230223042133.26551-1-semen.protsenko@linaro.org>
 <167811290503.11716.15730246749418548221.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167811290503.11716.15730246749418548221.b4-ty@linaro.org>
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

On 06/03/2023 15:28, Krzysztof Kozlowski wrote:
> On Wed, 22 Feb 2023 22:21:27 -0600, Sam Protsenko wrote:
>> As a part of preparation for PM enablement in Exynos850 clock driver,
>> this patch series implements CMU_G3D, and also main gate clocks for AUD
>> and HSI CMUs. The series brings corresponding changes to bindings, the
>> driver and SoC dts file.
>>
>> Changes in v2:
>>   - Rebased all patches on top of the most recent soc/for-next tree
>>   - Added A-b and R-b tags
>>   - Minor fixes
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/6] dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
>       https://git.kernel.org/krzk/linux/c/067ba1605806e52118bb598afb357718df9f0e19
> [2/6] dt-bindings: clock: exynos850: Add AUD and HSI main gate clocks
>       https://git.kernel.org/krzk/linux/c/e289665ed0d6df9fca3ebc128f1232d305e4600b
> [3/6] clk: samsung: clk-pll: Implement pll0818x PLL type
>       https://git.kernel.org/krzk/linux/c/a6feedab8ab9a9e4483deb0bcc87919d92c88b7e
> [4/6] clk: samsung: exynos850: Implement CMU_G3D domain
>       https://git.kernel.org/krzk/linux/c/c5704a56893b4e77e434597c7c53d878bb3073b0
> [5/6] clk: samsung: exynos850: Add AUD and HSI main gate clocks
>       https://git.kernel.org/krzk/linux/c/d8d12e0d079aff4b1d8079a0a55944c0596f1d67
> [6/6] arm64: dts: exynos: Add CMU_G3D node for Exynos850 SoC
>       https://git.kernel.org/krzk/linux/c/ad8f6ad9a4f219950df65731a8ff91baa022c4b0

And builds are broken. Please mention in cover letter or commit
dependencies and ordering...

Best regards,
Krzysztof

