Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAC74D49B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGJL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGJL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:27:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E797115
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:27:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6648013e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688988432; x=1691580432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V49SdTgWSJVm+8H0cDj3W1KdF5iv0fx1nxbNVddDqD4=;
        b=j+ubNvFsU35Gx9khBQyVcoeJTZpuCjph4XLlySFF8Z2nE9eVk8V1SOKNb7msbucIUs
         DAEyViZMvQLPOgeVyo6QbxTZ0lSZXMl/yGvaw/nYloMuSjyMVlYFg5OrvWPYNhmbQHcp
         ipDlG7bSpds/wxSI2uNp2rZUxHTB7a/x6nglRxuOkoYziha0PvmVQs3SP8XTggew6JHY
         +zADg2zhanlCBwNXlob/nQy1XLaz+stwbY3+5VO+HK1nyEHHHjT8WGkEflND3pj3hmpm
         4SrfA/bN8/8QqegPJffOHvb00AOMBNOaktN6oP1tDT5MNjZuPykN/Dj5d0NgcKXJuGQG
         P1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688988432; x=1691580432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V49SdTgWSJVm+8H0cDj3W1KdF5iv0fx1nxbNVddDqD4=;
        b=YQfVr7TihD6hU1m84Xd/jmwofX1bhXvzwGgZ49J0xIfesd7dfSoM2iIl1RLxwt/LOc
         ydolxD8a5JN594NRQz90diCBK/RVsXXrJwsYQyg4r9tAj1wbiJHxUq4O/mzYIRlgyMpG
         RoGCkvwCz89pgogM++i3eK/uNO+KNVNv7VCTsgYYRxsh6Mfs5U0P0TzknFJCIstmiv0w
         DCC9FcZmdQhh+JOXwspp4AkGd45UVrjlKxcFhgtokH5x6KjWHcViZ0Ukg4VM2PIjPz6j
         GUXSVgkeCJXXMXJeB2JVchSS1HTwpPacItL9UcKCSj2UmtDt1YKFawUewWhplejDNx5L
         xFUw==
X-Gm-Message-State: ABy/qLYYB2945Lquai+c2g/nmSGk5W3343f12AogghAG7ZzE9ckoZPIS
        pRkJxbNa4GRu/bx6zFhMDy+KtA==
X-Google-Smtp-Source: APBJJlHbmEzUGQGMe1oZoR+rASq12BLSBpneDA42HeklwM38Tw1z6hVETNPfigi6EZp91VUBQVYntw==
X-Received: by 2002:a05:6512:4023:b0:4f9:5316:d5b with SMTP id br35-20020a056512402300b004f953160d5bmr11636082lfb.64.1688988432670;
        Mon, 10 Jul 2023 04:27:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d7-20020ac25ec7000000b004fb75943aa0sm1656386lfq.196.2023.07.10.04.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:27:12 -0700 (PDT)
Message-ID: <ce12d48d-1830-4200-0350-557d4a648190@linaro.org>
Date:   Mon, 10 Jul 2023 14:27:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 19/21] thermal: qcom-spmi-adc-tm5: convert to use
 devm_request*_irq_probe()
Content-Language: en-GB
To:     Yangtao Li <frank.li@vivo.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
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
 <20230710095926.15614-19-frank.li@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230710095926.15614-19-frank.li@vivo.com>
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
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

