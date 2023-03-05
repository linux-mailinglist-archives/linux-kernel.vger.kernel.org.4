Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB46AAFE5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCEN1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCEN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:27:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F712051
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:27:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cy23so28008133edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678022858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk9e/fOya2qw+v+GTDMWGjK594tp8ByxmYu2FhMlkrs=;
        b=f4P4IYU00G7BMwwH+EjFsp8cMyDWi546De7SwAspqCuwfPFTMSjwNdpJ+czCK3lgXZ
         34/82qa0iR1AxYL3LQScFIrmXNT3Nrgql2FyUvl0OV/5anS6hVIh4RTHRsLL9fltLbfb
         Ij5TuIVzXvSdp8zOlEgLJT5K6UEcjme1Wh1aY4eiikwa4Tgc+WVSV607fdBKSPKEtAOU
         CS519h3IWx/A2dyk0V/6FRHi8tTf0AXZzXQ7sI5rj9rNEllNQZsS8NTmVcieVMbPRLyB
         Bkua+h7r7nZb87CRO7BhLgg/QNCsvq99yZYht5ZJ2eEoDql8vGb41Yt2l5MQayjZWxO/
         pg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678022858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk9e/fOya2qw+v+GTDMWGjK594tp8ByxmYu2FhMlkrs=;
        b=xgWL1BzhbcNEyNr+TPT69s5cRR8Oyw8P2MyTlRcsO1vUjJY1GdbxkAXnh+w/8Q23hJ
         RzdkQvKJ97aF7lQR74m7+CTmrNp6llh5IjZ7gygwkRyzRxrUQqRcCAyI0NTO4JC3kYxk
         RFvn+BiB3Q6ENQ2GORzp76UK5/7pH2zVHiBNvzmj8RJzOkMi45IeOvH/h3pF1saRZrbK
         wNzgudJADh8spuD9NUK/t5vIoPOg1W+WLad9e85B8xSHl5FvTL8HeqJjdGx2t1FSKSN2
         k+v/7jy4oO0laKItE4dpM3U6+Cm328E8+nxK/K6wIZsqqlwjsLkQjLsJKLdET+lX3uEo
         phQg==
X-Gm-Message-State: AO0yUKXrSitgHV/2l6IDTY+x7eNwTDCmrznyqSF6ynN/isRX/q7CJ3y8
        jKyrxUTFxubTN6gxkNrLlodw3A==
X-Google-Smtp-Source: AK7set8uCdsNlNMXYyxX/Y6M92riRRMG0J6OaMxyzNkpROQSRFo91Q8DBrj+HWkcSkVJ99QQlASuIg==
X-Received: by 2002:aa7:d28d:0:b0:4ad:99de:91bc with SMTP id w13-20020aa7d28d000000b004ad99de91bcmr7653033edq.31.1678022858321;
        Sun, 05 Mar 2023 05:27:38 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id f27-20020a50a6db000000b004acc61206cfsm3681839edc.33.2023.03.05.05.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 05:27:37 -0800 (PST)
Message-ID: <b0344291-d1f5-23d5-2d48-50bf15999fd7@linaro.org>
Date:   Sun, 5 Mar 2023 14:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
 <431a8ae1-54a7-e71a-484d-cab618a2a1c4@roeck-us.net>
 <20230305111500.jvass6ymkity4nnd@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305111500.jvass6ymkity4nnd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2023 12:15, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Sat, Mar 04, 2023 at 02:10:47PM -0800, Guenter Roeck wrote:
>> On 3/4/23 13:46, Christophe JAILLET wrote:
>>> Le 04/03/2023 à 17:56, Guenter Roeck a écrit :
>>>> The devm_clk_get[_optional]_enabled() helpers:
>>>>      - call devm_clk_get[_optional]()
>>>>      - call clk_prepare_enable() and register what is needed in order to
>>>>        call clk_disable_unprepare() when needed, as a managed resource.
>>>>
>>>> This simplifies the code and avoids the calls to clk_disable_unprepare().
>>>>
>>>> While at it, use dev_err_probe consistently, and use its return value
>>>> to return the error code.
>>>>
>>>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>   drivers/watchdog/s3c2410_wdt.c | 45 +++++++---------------------------
>>>>   1 file changed, 9 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>>>> index 200ba236a72e..a1fcb79b0b7c 100644
>>>> --- a/drivers/watchdog/s3c2410_wdt.c
>>>> +++ b/drivers/watchdog/s3c2410_wdt.c
>>>> @@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>>       if (IS_ERR(wdt->reg_base))
>>>>           return PTR_ERR(wdt->reg_base);
>>>> -    wdt->bus_clk = devm_clk_get(dev, "watchdog");
>>>> -    if (IS_ERR(wdt->bus_clk)) {
>>>> -        dev_err(dev, "failed to find bus clock\n");
>>>> -        return PTR_ERR(wdt->bus_clk);
>>>> -    }
>>>> -
>>>> -    ret = clk_prepare_enable(wdt->bus_clk);
>>>> -    if (ret < 0) {
>>>> -        dev_err(dev, "failed to enable bus clock\n");
>>>> -        return ret;
>>>> -    }
>>>> +    wdt->bus_clk = devm_clk_get_enabled(dev, "watchdog");
>>>> +    if (IS_ERR(wdt->bus_clk))
>>>> +        return dev_err_probe(dev, PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
>>>>       /*
>>>>        * "watchdog_src" clock is optional; if it's not present -- just skip it
>>>>        * and use "watchdog" clock as both bus and source clock.
>>>>        */
>>>> -    wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
>>>> -    if (IS_ERR(wdt->src_clk)) {
>>>> -        dev_err_probe(dev, PTR_ERR(wdt->src_clk),
>>>> -                  "failed to get source clock\n");
>>>> -        ret = PTR_ERR(wdt->src_clk);
>>>> -        goto err_bus_clk;
>>>> -    }
>>>> -
>>>> -    ret = clk_prepare_enable(wdt->src_clk);
>>>> -    if (ret) {
>>>> -        dev_err(dev, "failed to enable source clock\n");
>>>> -        goto err_bus_clk;
>>>> -    }
>>>> +    wdt->src_clk = devm_clk_get_optional_enabled(dev, "watchdog_src");
>>>> +    if (IS_ERR(wdt->src_clk))
>>>> +        return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed to get source clock\n");
>>>>       wdt->wdt_device.min_timeout = 1;
>>>>       wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
>>>> @@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>>                    S3C2410_WATCHDOG_DEFAULT_TIME);
>>>>           } else {
>>>>               dev_err(dev, "failed to use default timeout\n");
>>>> -            goto err_src_clk;
>>>> +            return ret;
>>>
>>> Hi,
>>>
>>> Nit: this also could be "return dev_err_probe()"
>>>
>>>>           }
>>>>       }
>>>> @@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>>                      pdev->name, pdev);
>>>>       if (ret != 0) {
>>>>           dev_err(dev, "failed to install irq (%d)\n", ret);
>>>> -        goto err_src_clk;
>>>> +        return ret;
>>>
>>> Nit: this also could be "return dev_err_probe()"
>>>
>>
>> The primary reason to call dev_err_probe() is that the error may be
>> -EPROBE_DEFER, in which case the error message is suppressed.
>> That is not the case for those two functions; they never return
>> -EPROBE_DEFER. Calling dev_err_probe() would give the false impression
>> that the functions _might_ return -EPROBE_DEFER.
> 
> That is subjective. In my book dev_err_probe() handling -EPROBE_DEFER is
> only one aspect. Another is that using it allows to have return and error
> message in a single line and also that if already other exit paths use
> it to get a consistent style for the emitted messages. Having said that
> *I* wouldn't assume that the previous call might return -EPROBE_DEFER
> just because dev_err_probe() is used.
> 

I agree with this. I stopped looking at dev_err_probe() as related to
deferred probe. It is just useful helper in the context of probe. With
or without defer.

Best regards,
Krzysztof

