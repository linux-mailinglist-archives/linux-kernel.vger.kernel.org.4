Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC274D490
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjGJL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjGJL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:26:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CABE5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:26:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso68085411fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688988360; x=1691580360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWwzakbEs/DZYhCACtrdfUav4U/LjuKbiuYOMVQq52M=;
        b=N2eSuqTHIkMg4c2Ok8QHWv/LxcTcE3pjXayPd0AvKrx3FrtohXhioE+eP07t4yPd4W
         7z6SLhAz/IjZEqwtATPLrNRzNO+p6qjjNVA8kK26ubGjTRu0kalpRMkBbMzgOe66BerX
         c/vwRfqch5yWiz/3ouBy9uuQItgf9vya5OSEaNwxhdAxo1GYiW4BX6I1uIx24/9PSaed
         byFHUGG0v+QIdxpxEeJ9bXJzAwrdnf+xn4h4taYM9YWeQQmqhqyUb93+IvsDlTNbHjme
         KLtgpNFbKhsrIBlf4CW0x/h6cdQuSD0tWyESC2oy//JJVjsT7ctiG5NnTvUwAPw0K3yg
         6cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688988360; x=1691580360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWwzakbEs/DZYhCACtrdfUav4U/LjuKbiuYOMVQq52M=;
        b=YcJGl/ggSv16zV4riVUc5VKKRmM+x0b/JEGmq2mH4xpBHkyuFH/OWlUhgTQTSGd1yh
         7SVTQWekLyRaz0+GFm6QUFJq4j91zPiM2gjvIDUXmzajsf02d3v9RFDv8LZFGPSr17iQ
         lXKIbFS7atgZEXbB+QpttDUR/ygGV8W09ySJAOp+1mR377KRgyqa6/ADcqLGUIGIgZpQ
         tuohwovTiJCVg51ZonzW8aOR/2SJJEbYq3mknIZReLwZGZlkybSYceXCATJ0QyyuL6uA
         euLMnJUh4yaFg32tRgUBTi1CIkFKXJOVOjNnPbTMlpGC1kkdaviRWagjhIv3vqmVy3O8
         pMBw==
X-Gm-Message-State: ABy/qLbQdfewFhJ9/6WIHX0jjw9Q+jokWQmSywCJNMZNDxwSa42eJ/pD
        J9jjYHRLbOofN0GoONI4xLZp9Q==
X-Google-Smtp-Source: APBJJlGi+EeCDCdYyM78omuOf+TLnJSq6bLhKA1z6rnKTnzz7Tl5tfshLfzOd/xsmMWRmixUz7fzdg==
X-Received: by 2002:a2e:8295:0:b0:2b6:9ab8:9031 with SMTP id y21-20020a2e8295000000b002b69ab89031mr7250803ljg.16.1688988360315;
        Mon, 10 Jul 2023 04:26:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b6e49ac3a2sm1942553ljc.119.2023.07.10.04.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:25:59 -0700 (PDT)
Message-ID: <c628dff0-bb0c-f78d-7302-599c5329c977@linaro.org>
Date:   Mon, 10 Jul 2023 14:25:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 06/21] thermal/drivers/db8500: convert to use
 devm_request*_irq_probe()
Content-Language: en-GB
To:     Yangtao Li <frank.li@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-6-frank.li@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230710095926.15614-6-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
>   drivers/thermal/db8500_thermal.c | 16 ++++++----------
>   drivers/thermal/qcom/lmh.c       |  7 +++----

Please split LMH to a separate driver.

>   2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index fca5c2c93bf9..0ef8fc2eb4a1 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>   	if (low_irq < 0)
>   		return low_irq;
>   
> -	ret = devm_request_threaded_irq(dev, low_irq, NULL,
> +	ret = devm_request_threaded_irq_probe(dev, low_irq, NULL,
>   		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> -		"dbx500_temp_low", th);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to allocate temp low irq\n");
> +		"dbx500_temp_low", th, "temp low");
> +	if (ret < 0)
>   		return ret;
> -	}
>   
>   	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
>   	if (high_irq < 0)
>   		return high_irq;
>   
> -	ret = devm_request_threaded_irq(dev, high_irq, NULL,
> +	ret = devm_request_threaded_irq_probe(dev, high_irq, NULL,
>   		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
> -		"dbx500_temp_high", th);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to allocate temp high irq\n");
> +		"dbx500_temp_high", th, "temp high");
> +	if (ret < 0)
>   		return ret;
> -	}
>   
>   	/* register of thermal sensor and get info from DT */
>   	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index f6edb12ec004..48a14d7e8bf5 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -207,11 +207,10 @@ static int lmh_probe(struct platform_device *pdev)
>   
>   	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
>   	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
> -	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> -			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
> -			       "lmh-irq", lmh_data);
> +	ret = devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq,
> +				     IRQF_ONESHOT | IRQF_NO_SUSPEND,
> +				     "lmh-irq", lmh_data, NULL);
>   	if (ret) {
> -		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
>   		irq_domain_remove(lmh_data->domain);
>   		return ret;
>   	}

-- 
With best wishes
Dmitry

