Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7472F0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjFNAFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFNAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:05:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28818A2;
        Tue, 13 Jun 2023 17:05:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7608aae9355so133578585a.0;
        Tue, 13 Jun 2023 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686701104; x=1689293104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCL3XYRA6hV3EWR4V1JDlEix34yrkwfocIMDu/RoAR8=;
        b=KiZONNFZYFlTVr0nWCBS7P0vzIW9ATmQBz/P6TpWjuefA+ZvDDkupfbYvOszk2vpJN
         iJmW5qaichMxC8CezgEdwJ+VNieP1LZeRfWKy9mDS+gPKwhPE8BbL8yTTacBK81LDiG7
         YVqhJTChVMuVk6Zik/8kIVs4ox52jGhOM6SyKD9lAHqbM56NPoiCwYdyXFunG1X3u6fW
         ubDkEwFQGRnVWdx0T+uyB/htD1i1/as42IMzuY4UnJTZ7fqnPMhqPwP2n7FMKdgLlasw
         wKtAvfW6B2bfGvDc5WBP/v965Q+iZnXDANSVwjbaYVxoE2/tj94Jj04qQG5sMZKZJc52
         WnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686701104; x=1689293104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCL3XYRA6hV3EWR4V1JDlEix34yrkwfocIMDu/RoAR8=;
        b=W17sHtTWfHjsOlKya5qmcz2GUMM2HVAng8knHtPuOn5dGBCV7VWzRi8OyzfJEeAm3Y
         NhnmjDwh76ZQE81YCHTnwGnJm0gs7HBOv4qFz/gt+zFMikSQyYud5z+/ZfKU0yyFh24i
         LoWpvwEiuc1qnLGVthZfgBg9Uz6wopt3bJS82KeUhRXw/Ay+72NSWEc+xsUYOk4GPDbL
         KBllk5/7pimLJNJt0xin31/JsynkRjMESybiSRV8ZJtpwMZ+xZLMAvm4k37exShE3SMI
         enawFebVeh25Di+1ID/oncooCiVJsKZjKE4/SsXVOQIqIV9w2AYUR90KQntjhywU14SL
         P71w==
X-Gm-Message-State: AC+VfDzzpHSpG6H7mnmRwvcHO0fpbDP9Rq2xYKZkHRkZSR3x67X46iRG
        aisvOwuHA/1CwZwnoIW7PGQ=
X-Google-Smtp-Source: ACHHUZ7LVzhC6fyBwKTgVUn+XqqH0Gbz8ZHm0pKEe1+DVGaN2EhTNFjMdB5SErcBNDnPokwsoKJSRA==
X-Received: by 2002:a05:620a:8390:b0:75e:fda0:bb51 with SMTP id pb16-20020a05620a839000b0075efda0bb51mr14389604qkn.4.1686701104224;
        Tue, 13 Jun 2023 17:05:04 -0700 (PDT)
Received: from [10.1.97.4] (rrcs-24-39-76-222.nys.biz.rr.com. [24.39.76.222])
        by smtp.gmail.com with ESMTPSA id t16-20020a05620a035000b00760951ebc09sm1324508qkm.98.2023.06.13.17.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 17:05:03 -0700 (PDT)
Message-ID: <4566b922-c564-5847-facf-1a68ea6adcf4@gmail.com>
Date:   Tue, 13 Jun 2023 19:04:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230605125248.279921-1-brgl@bgdev.pl>
 <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
 <22a21176-f2e2-bce5-2223-97cb095162c5@gmail.com>
 <98a35030-6dd3-795c-4381-1db4e94a18e4@gmail.com>
 <CAL_JsqKDQy+tq7uDJ9impTr+uetkb7vz-K4BYX8bZBkpvZ=8uQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqKDQy+tq7uDJ9impTr+uetkb7vz-K4BYX8bZBkpvZ=8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 10:42, Rob Herring wrote:
> On Sun, Jun 11, 2023 at 6:48 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 6/11/23 07:39, Frank Rowand wrote:
>>> On 6/9/23 08:47, Rob Herring wrote:
>>>> On Mon, Jun 5, 2023 at 6:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Drivers should be silent when they work correctly. There's no reason to
>>>>> emit info messages when GPIO lines are hogged. Demote the message to
>>>>> debug.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> Suggested-by: Kent Gibson <warthog618@gmail.com>
>>>>> ---
>>>>>  drivers/gpio/gpiolib.c |  2 +-
>>>>>  drivers/of/unittest.c  | 16 ++++++++--------
>>>>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>>>> index a7220e04a93e..e4515bda8915 100644
>>>>> --- a/drivers/gpio/gpiolib.c
>>>>> +++ b/drivers/gpio/gpiolib.c
>>>>> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
>>>>>         /* Mark GPIO as hogged so it can be identified and removed later */
>>>>>         set_bit(FLAG_IS_HOGGED, &desc->flags);
>>>>>
>>>>> -       gpiod_info(desc, "hogged as %s%s\n",
>>>>> +       gpiod_dbg(desc, "hogged as %s%s\n",
>>>>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
>>>>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
>>>>>                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
>>>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>>>> index 2191c0136531..0060334a98a7 100644
>>>>> --- a/drivers/of/unittest.c
>>>>> +++ b/drivers/of/unittest.c
>>>>> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
>>>>>          * driver is registered
>>>>>          */
>>>>>
>>>>> -       EXPECT_BEGIN(KERN_INFO,
>>>>> +       EXPECT_BEGIN(KERN_DEBUG,
>>>>>                      "gpio-<<int>> (line-B-input): hogged as input\n");
>>>>
>>>> As debug messages are normally off, I think you can just remove these.
>>>
>>> This patch is an example of exactly why the message level is the first parameter
>>> passed to EXPECT_*().  The test results are then _always_ valid, not just
>>> _normally_.
>>
>> One should never say never.  One should never say always. :-)
>>
>> Yes, there is still the exception where debug can be enabled independently
>> for drivers/gpio/gpiolib.c  vs for drivers/of/unittest.c.  And dynamic
>> debug can make things even more wonky.
> 
> If we turned on debug messages for drivers/of/, the unittest would be
> hopelessly broken.
> 
> Debug messages are special compared to all the other levels as they
> are normally off whereas the rest are always on. For the unittest we
> should assume they are off.

Sorry, I wasn't clear enough in my last email.  My intent in that email
is to essentially agree with what you say here - if debug is enabled
then we are in a special world where the person who enabled debug has
to deal with all of the side effects and consequences of enabling
debug.

-Frank

> 
> Rob

