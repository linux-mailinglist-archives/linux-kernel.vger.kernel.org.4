Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA072B1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFKMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFKMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:39:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE342E63;
        Sun, 11 Jun 2023 05:39:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f9e36e5ea8so11065451cf.3;
        Sun, 11 Jun 2023 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487197; x=1689079197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddaw/98usWKqo9LXEQ3oXd23WqC3x1yMaUSTSAxj6Po=;
        b=Alqi4glh/pcDbLn8cBdVsqXSqxuuGz6qLo270zjsz4o29HCxIoCgO3RIwwgtv9RWY8
         pQQpBXFj6TOJlg23zFA5dp4dt2bauW8iMO5gq6bXMZo0cuWb/viGOIyavT1rZx/XOQik
         +S/G35jELWmBs0/4xZ1jjMwKXhnTEpxZwIWZcnTLT2rDNAOl3PkQhjsiPS44Gt1Kw3Bp
         XiGno0wZuw+HkwsAGYtIU2qR4L4SVMd29+rzqmPqcUUhQuk5BRybXc3lkY/bNBfj95FO
         hdLE7Pl+DIZ0hFjXz8+4BqsPa8elh8nEqyacA/HCM85WmqaOg0dwSmxPckSek2qiIQ7h
         fYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487197; x=1689079197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddaw/98usWKqo9LXEQ3oXd23WqC3x1yMaUSTSAxj6Po=;
        b=X+hIFeAppT97AMcBwY8CRw9QExx7XIpW+MeZelYSj5RP+s1Uw2+LfK2ugaceTg+TZB
         JRcjSD9xg2gBPzbFZsG1VhaWAPq+iQHRKqnnYVG6k/ieKV2Z6FtG0H2hljCgJXD+Lrgw
         OH6kx8sznzWNDEk4HBidPz1Ejxv+ToiX47m3wjCIOMYPOeQw39UK88nO9OAM7VfFUict
         5x0cTpjzV8z0NzNTfMN/MrbORWpsL3DtQcRdNvgcSRX/9LIij82eiPLk8baBw2wAuMQ0
         7rfgFb4aU1FsnGHdXIzKfibRI9I3fwCnNurBkkc3nEwfDEbWuL13sOVw5qlEclyFSuV8
         7TYA==
X-Gm-Message-State: AC+VfDyjs72/VhwropdHOxNsOcPIWS3t8L2Cq7BJXtOPuUU0u/1sf747
        UNXtPl0K8Yq0zsjz3mCLq3A=
X-Google-Smtp-Source: ACHHUZ5dYz6T2L3E4eMVDIjz2tj7aIB3Oi16Wg+I1xH70IOUG8m+FjkltpD5kBNTc3DA9c2pfSNfbA==
X-Received: by 2002:ac8:7f03:0:b0:3f9:cb01:9da9 with SMTP id f3-20020ac87f03000000b003f9cb019da9mr7941277qtk.38.1686487196880;
        Sun, 11 Jun 2023 05:39:56 -0700 (PDT)
Received: from [10.1.97.4] (rrcs-24-39-76-222.nys.biz.rr.com. [24.39.76.222])
        by smtp.gmail.com with ESMTPSA id bq13-20020a05622a1c0d00b003f872332a9asm2603444qtb.64.2023.06.11.05.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 05:39:56 -0700 (PDT)
Message-ID: <22a21176-f2e2-bce5-2223-97cb095162c5@gmail.com>
Date:   Sun, 11 Jun 2023 07:39:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
Content-Language: en-US
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
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

On 6/9/23 08:47, Rob Herring wrote:
> On Mon, Jun 5, 2023 at 6:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Drivers should be silent when they work correctly. There's no reason to
>> emit info messages when GPIO lines are hogged. Demote the message to
>> debug.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Suggested-by: Kent Gibson <warthog618@gmail.com>
>> ---
>>  drivers/gpio/gpiolib.c |  2 +-
>>  drivers/of/unittest.c  | 16 ++++++++--------
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index a7220e04a93e..e4515bda8915 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
>>         /* Mark GPIO as hogged so it can be identified and removed later */
>>         set_bit(FLAG_IS_HOGGED, &desc->flags);
>>
>> -       gpiod_info(desc, "hogged as %s%s\n",
>> +       gpiod_dbg(desc, "hogged as %s%s\n",
>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
>>                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 2191c0136531..0060334a98a7 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(void)
>>          * driver is registered
>>          */
>>
>> -       EXPECT_BEGIN(KERN_INFO,
>> +       EXPECT_BEGIN(KERN_DEBUG,
>>                      "gpio-<<int>> (line-B-input): hogged as input\n");
> 
> As debug messages are normally off, I think you can just remove these.

This patch is an example of exactly why the message level is the first parameter
passed to EXPECT_*().  The test results are then _always_ valid, not just
_normally_.

-Frank

> 
> Rob

