Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123270BE60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjEVMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjEVMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:30:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBB1988
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:26:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30644c18072so3789435f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684758409; x=1687350409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEaX8WhwboBEc6UgbMSxe5Jo+RE1bpmPJglCuEjejv0=;
        b=ZiyXi5mj46qZs5cRDwXSALxq2q6Wr34xjKFCdrL9RvSOo7jl1rLiH1FOJ7ScllRxN+
         UpJVYoj++XLXJ7h2lvcouJWScoc6tL5ESZK9enz8ZRK7BnoHum4mOM09LtzPDUAcrIAQ
         LTB9VtjdxoeoyweLvXMQH/UvhEfh49uUhG9GmUcHZeQuP8bX99Ta+DWmlpMbGe4dBjiW
         nrZd91lQ2G9BSOCgpnn/Mhh7KHN/aGc82UFvFzraMUy5eXFydaI1COAQS5YogvEpAws7
         0qryjlPxx+KqvL0suhQKoYMCnxkMCj6xjvxtXz5vFR1W5FQRWd3rpSuXVTnEEOJNyL1u
         F9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758409; x=1687350409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEaX8WhwboBEc6UgbMSxe5Jo+RE1bpmPJglCuEjejv0=;
        b=D5yonXGXrM3Cklu7ZgdJICTUKRXU5TLXVwhb9svNbWJqDhA8dKu9mbiWEkPAbc9YX8
         bhPnG2YHI0K9oGpka4btd/HIt2b8oJhjXETFA03VeK5ZDR/TQUZLnq17BV+rMDSy72Pz
         TE2UeFNhBEsqIXqK9MyXPfIsVF+I/+0POpEDcUSj4uN7VpYGaPbMEgtxnzONNLDdh8OW
         xHW3Nszd44EsgFJeEKpJz/fNmLE4cCJnbbjUT9Lud8Uumrhvp1wMgO02mLjXkd7jN1KS
         n/+wR3mTnz5abt3zVV7MWggGAolZD0WpTDT9X52HHnUbyY+fhTUqr+DYw/nhzLe4lyHG
         GknA==
X-Gm-Message-State: AC+VfDwC6GDe4GDOYtkRmrvt6+PrAEujoJr86EwEyfqRWM2tvYv1aQPz
        +v7qYJrLbg/XXlRTFZb+QHrWbQ==
X-Google-Smtp-Source: ACHHUZ6uVYGLu/k0kOcjRdUMY/5MGNk02xLAtvueCfV/L4V4MZRkiJlDvQ6zqI0ZqWE0IjHjks/low==
X-Received: by 2002:a5d:594a:0:b0:2f7:c224:cd32 with SMTP id e10-20020a5d594a000000b002f7c224cd32mr7254934wri.10.1684758409343;
        Mon, 22 May 2023 05:26:49 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id o2-20020a056000010200b002ca864b807csm7766430wrx.0.2023.05.22.05.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 05:26:48 -0700 (PDT)
Message-ID: <071614c0-0f84-6087-47c6-385541c5733d@baylibre.com>
Date:   Mon, 22 May 2023 14:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CACRpkdbjjoOoGeaqv9yQ4fTKqxt5eLDBjZCnNAYQnng3L+n8TQ@mail.gmail.com>
 <2e5cae40-7040-a92f-3d11-ce68f1307049@baylibre.com>
 <20230517063303.GO14287@atomide.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <20230517063303.GO14287@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2023 08:33, Tony Lindgren wrote:
> * jerome Neanne <jneanne@baylibre.com> [230512 07:13]:
>>
>>
>> On 11/05/2023 22:57, Linus Walleij wrote:
>>>> +       /* Documentation is stating that GPIO0 direction must not be changed in Linux:
>>>> +        * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
>>>> +        * Should only be changed in INITIALIZE state (prior to ON Request).
>>>> +        * Set statically by NVM, changing direction in application can cause a hang.
>>>> +        * Below can be used for test purpose only:
>>>> +        */
>>>> +
>>>> +#if 0
>>>> +       int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
>>>> +                                TPS65219_GPIO0_DIR_MASK, direction);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +#endif
>>>> +       dev_err(gpio->tps->dev,
>>>> +               "GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
>>>> +                offset, direction);
>>>> +       return -EOPNOTSUPP;
>>>> +}
>>>
>>> Normally people would complain about #if 0 code.
>>>
>>> But this is a special case!
>>>
>>> I definitely want the code to be in there somehow.
>>>
>>> What about:
>>>
>>> if (IS_ENABLED(DEBUG))?
>>>
>>> If someone enables debug with an explicit -DDEBUG to the compiler
>>> this could be allowed.
>> I'm fine with your proposal. Will wait few days just in case anyone wants to
>> add any comment then go for this.
> 
> Just wondering.. Would it help for the driver probe to set gpio0 as a gpio
> hog after reading the configured value?
> 
> Maybe the multi device enable just means the pin may be shared with no
> specific hardware reason to not change it during the runtime?

Your point looks valid. But I think we can't simply add a regular 
"gpio-hog" as a property in the device tree because we don't have a one 
to one mapping for GPIO consumer (theoretically we can have more than 2 
PMICs).

I think your suggestion is to read the multi-device value through regmap 
then "kind of" hog gpio with devm_gpio_request_one
So that gpio0 is preserved from being requested by other user.
Is this correct understanding?

Practically the board I'm using for test currently only have one PMIC.
I'm reluctant to implement additional logic that does not look so 
"conventional" that I can't test.

If maintainers agree, I'll postpone the implementation of your proposal 
until a platform compatible with this implementation is available for 
testing. So that we can check what is most accurate in real life.

Side Note: wo this implementation use of the driver is less optimal in 
multi-device configuration but still usable.

Regards,
Jerome.
