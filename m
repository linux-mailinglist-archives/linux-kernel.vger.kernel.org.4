Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC474D498
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjGJL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGJL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:27:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59516100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:27:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso6065499e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688988420; x=1691580420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+Ouigov7V/f0TWefy/omICdopKlzJ8egLhg1vkm8FQ=;
        b=O8UkG2zgu8nXebCjlfLQ879phf7e4jpqFeV3T1p18QkJZH0bd8D0XQyHPWdgYYxqIS
         cy9WQhPs1HJA1iW5sZNc1M1XitXWd3pnn7vRGG8MxhMWWdNea7m7eFiBqkCdtGOzCkTO
         NM/jY+Gbj805A2c8RCrbgyuQejW9RVvPXag45UZ7ocz+UXG4SMkmeLzPxk2qbe03TaF0
         VeOP6I8TDtA95fgAnP2HSm1+/gUpTOrzWRKrQtbFclZQRc12jQY+Ji9X4S6A7zXXtK5o
         2fu7g9KrxFLQU2zrrM3lVHwXrfET/hIofj8OCgy6n4RIdhMmr3kgA3BuJmr9H7zV2en9
         SvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688988420; x=1691580420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+Ouigov7V/f0TWefy/omICdopKlzJ8egLhg1vkm8FQ=;
        b=YM9ezUqOH+vzBBxMhN3KOBJEtEUK31IvUIRPIFx9Iekevxlb3dIJ6Gh1HOvsHqlhlz
         c5nvjl2wkuB8PoCFwazkzTsLFz68tnAY0zPb/Le2wV31iuR2QHi9vDZINJ/safUziYk/
         atd+DQmdzGCoXug5cU0LcKWsLLq8zDmpcdbrqNNlEUSefoX7pTyV4cA/kbKo8tX3yTg5
         YCFj+01AIZ+6g1D1yaWI0p6RhIeLOwS0fgkT4EjhtSUCAzN6rzW7tmsAvOCqsqeNKdqT
         zqVq8cYGp0suLqlmv5ocU8N9T7o5AZPuk5+iBxQIqIzUzWL6N3ngWUCzaTBCqH6aC+2p
         7WJg==
X-Gm-Message-State: ABy/qLZKr0uYzWEsIcqqoMqE1PAJNo7b7ithmtjXOxWMz1yJ0tphOm+D
        xXPnboL9HjdCbeWTV3sP0f+hKQ==
X-Google-Smtp-Source: APBJJlHxFXD2/i4ZnHH56AzsZRq63Gn+i9WYZ0lInXyBG1ewVCdnt+gE8Y5+1u46kLrPXik16E6V1Q==
X-Received: by 2002:a05:6512:1146:b0:4fb:7a4e:b573 with SMTP id m6-20020a056512114600b004fb7a4eb573mr9921600lfg.5.1688988420517;
        Mon, 10 Jul 2023 04:27:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j16-20020ac25510000000b004fbb20791f3sm1664280lfk.31.2023.07.10.04.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:27:00 -0700 (PDT)
Message-ID: <7b14955f-be89-b04a-a0d1-0988a0c77501@linaro.org>
Date:   Mon, 10 Jul 2023 14:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 18/21] thermal/drivers/qcom/tsens-v0_1: convert to use
 devm_request*_irq_probe()
Content-Language: en-GB
To:     Yangtao Li <frank.li@vivo.com>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-18-frank.li@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230710095926.15614-18-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:59, Yangtao Li wrote:
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
> 
> And tglx point out that:
> 
>    If we actually look at the call sites of
>    devm_request_threaded_irq() then the vast majority of them print more or
>    less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> 
>       519 messages total (there are probably more)
> 
>       352 unique messages
> 
>       323 unique messages after lower casing
> 
>           Those 323 are mostly just variants of the same patterns with
>           slight modifications in formatting and information provided.
> 
>       186 of these messages do not deliver any useful information,
>           e.g. "no irq", "
> 
>       The most useful one of all is: "could request wakeup irq: %d"
> 
>    So there is certainly an argument to be made that this particular
>    function should print a well formatted and informative error message.
> 
>    It's not a general allocator like kmalloc(). It's specialized and in the
>    vast majority of cases failing to request the interrupt causes the
>    device probe to fail. So having proper and consistent information why
>    the device cannot be used _is_ useful.
> 
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
> 
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/qcom/tsens.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

