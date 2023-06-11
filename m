Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223972B1E6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjFKMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFKMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:48:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F11734;
        Sun, 11 Jun 2023 05:48:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75d4aa85303so258914685a.2;
        Sun, 11 Jun 2023 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487706; x=1689079706;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFRTmqMoFnJZ0zC5NrP4IbLjA9BDp5g0LuXmguV3GvI=;
        b=izQ81f8QJvGqEzwNDL8mrnj2MubcrUgkQaZievRf6k9xsbqSmqYNcIpM9XDBSDLVfg
         GslTogZF4laXnu18uVPSBNSWnn/eAA+b/K9CPBb7A6UmYzYacpYZa+nduFCXzkX7nX4I
         OxUuvelFtqFsv4PYQ27yX/tzd0LNQ8IXs7Ff5BrW9Tmtw1DFieK84WAdBnfnYgLVRcng
         62O+jUIEcwzTa/wrTZuFNvDc/tZiRmXQ2lYTDuswdiAqoI3hy8DTtBO0v01lxGvyYPaH
         +AvXTx9VhiynNyLzHMsa03HjnvqrwyGj3G4Nzotw5K5kSqegPL0M3GgoXVp9pKBV8vWm
         n/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487706; x=1689079706;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFRTmqMoFnJZ0zC5NrP4IbLjA9BDp5g0LuXmguV3GvI=;
        b=DG4d2/U0S+ACU264ESXu1Cy6V6xsBfuOGdHOr8QgmyrnpKP8X4wh+nB7QYy3kZfIVd
         sSLaXvHs3ruQ9U4eYf4MvdHmaQ2Wq8B9uXLMx+bqQ43+0hwuiHE99k/eJmmGF94BjRrq
         fcKC31MsGUf40mHpzrmt4WzAwo0lBo24YP61ym6Vs8ZSUi0WKNmH2Cbz6pZ2cmlVKGr2
         raeDkVSmcQvVYyA71FNYDJX/vnNsqdVQriztu7Kv/sWidq8IVMnXzLwER7t6UxvjMAQo
         fTbmzvOfyLdBxY6sOeS+hg2tk2QIO7GpRLVuzRIdk5pq5158XxtIWKpjCB820VUdJjIG
         4jCw==
X-Gm-Message-State: AC+VfDzMIeVVfhjPAJ3n8mMbSEMKcDakm2XJeqUo1HLFWBgFOgqK/8rb
        Gw9deaL0MHub5R7w12/3m3c=
X-Google-Smtp-Source: ACHHUZ55eyfAZm+Dbv/q06rZj5UlUL4YElzrurvDF5Db+vt62WUCn4+2ukbZefrCRLFcRbGpAkv6/w==
X-Received: by 2002:a05:620a:190c:b0:75f:447:43a1 with SMTP id bj12-20020a05620a190c00b0075f044743a1mr5712660qkb.3.1686487705960;
        Sun, 11 Jun 2023 05:48:25 -0700 (PDT)
Received: from [10.1.97.4] (rrcs-24-39-76-222.nys.biz.rr.com. [24.39.76.222])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a004600b0075ecdc937ffsm2228790qkt.41.2023.06.11.05.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 05:48:25 -0700 (PDT)
Message-ID: <98a35030-6dd3-795c-4381-1db4e94a18e4@gmail.com>
Date:   Sun, 11 Jun 2023 07:48:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230605125248.279921-1-brgl@bgdev.pl>
 <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
 <22a21176-f2e2-bce5-2223-97cb095162c5@gmail.com>
In-Reply-To: <22a21176-f2e2-bce5-2223-97cb095162c5@gmail.com>
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

On 6/11/23 07:39, Frank Rowand wrote:
> On 6/9/23 08:47, Rob Herring wrote:
>> On Mon, Jun 5, 2023 at 6:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Drivers should be silent when they work correctly. There's no reason to
>>> emit info messages when GPIO lines are hogged. Demote the message to
>>> debug.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Suggested-by: Kent Gibson <warthog618@gmail.com>
>>> ---
>>>  drivers/gpio/gpiolib.c |  2 +-
>>>  drivers/of/unittest.c  | 16 ++++++++--------
>>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>> index a7220e04a93e..e4515bda8915 100644
>>> --- a/drivers/gpio/gpiolib.c
>>> +++ b/drivers/gpio/gpiolib.c
>>> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
>>>         /* Mark GPIO as hogged so it can be identified and removed later */
>>>         set_bit(FLAG_IS_HOGGED, &desc->flags);
>>>
>>> -       gpiod_info(desc, "hogged as %s%s\n",
>>> +       gpiod_dbg(desc, "hogged as %s%s\n",
>>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
>>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
>>>                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>> index 2191c0136531..0060334a98a7 100644
>>> --- a/drivers/of/unittest.c
>>> +++ b/drivers/of/unittest.c
>>> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
>>>          * driver is registered
>>>          */
>>>
>>> -       EXPECT_BEGIN(KERN_INFO,
>>> +       EXPECT_BEGIN(KERN_DEBUG,
>>>                      "gpio-<<int>> (line-B-input): hogged as input\n");
>>
>> As debug messages are normally off, I think you can just remove these.
> 
> This patch is an example of exactly why the message level is the first parameter
> passed to EXPECT_*().  The test results are then _always_ valid, not just
> _normally_.

One should never say never.  One should never say always. :-)

Yes, there is still the exception where debug can be enabled independently
for drivers/gpio/gpiolib.c  vs for drivers/of/unittest.c.  And dynamic
debug can make things even more wonky.

-Frank

> 
> -Frank
> 
>>
>> Rob
> 

