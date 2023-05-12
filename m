Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF0700130
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjELHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjELHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:15:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9B106C8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:13:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42b984405so28924135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683875604; x=1686467604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPhQRy4HPP9Hjp11lzPQ3zP0xKs4X8HPNb5FmQafXzg=;
        b=4YJ/nGQcwmjEJyXetQTMv6vZEtXXnXCtVTEj6ZJdD2ZvjIzR3cQx7mlmlJ7h9/a8aM
         +I9WYuDl63SaxIOwA1i37KQb6r3G4Oz7rZEkXbkjRMnXWyghHJ0b13VY9NMQMFdRGoKm
         Z9VJG4TBTIMsIKdUPuahjsx7g2cc9PXUjdjS4hw3wCfMXEYoFfQXUv7LWHEGUV+uxFP9
         sriHw/fEKQAUcFDV1AkZcmUhz5Jcu1RByKC4NPxtiiIqicFgJSKZfEuXb1XX8YFegQdL
         rw+/2sB5eYUhznaLEfvUl3n9pgk2OOhczWSWdlYQpxPS70IfRd2V6+bsaltJgtdDJV7I
         tjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875604; x=1686467604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPhQRy4HPP9Hjp11lzPQ3zP0xKs4X8HPNb5FmQafXzg=;
        b=cSBXxyIO3pgsnv4ZFYIA9k8cucuBVgoQeT1o1z0rH4EGZxMcoV6LceEyhswbD+kl38
         iuxFbYE4PcmNLUwlN+qVIz7EBX/laerTk2ccv6TfVDElCNfRAbPcoWq/x7DDOhcDSXbG
         i7DdT4H+txH/fPXAuRJwdhOBA0rIbtMnu8ziGt5DWvdt6oB6pIAUcqKpqtyFZEDUI1MO
         UA3zMSAt5hIHD1D6yC5bulohLIeGerNfj/ijg6EZKT3J+19XssR89w2Cez+yBZ3keLGI
         D0PRkHtl+VFJ3v193yqZPls4a8bv+cQN5rv/2Zxovv2WgrzyebbPwtdWZiqYO8nTRlRl
         EXUA==
X-Gm-Message-State: AC+VfDxk6YzXWmuZvPQmkyfCwsMN7a+V2I222M0Gqob5yOJQ7JXXSrgR
        QStiIBUkTAFa6ve9dyMg0oqSTw==
X-Google-Smtp-Source: ACHHUZ5hHZ8pzx0QW5qL2MCBfXq4LuVRXmvd12CX+0R+UxFwrl9+UX5BRoq6I4Rf9oyUske5iZPZPg==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:220a:bbf8 with SMTP id t15-20020a7bc3cf000000b003f4220abbf8mr13053335wmj.34.1683875604597;
        Fri, 12 May 2023 00:13:24 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b00306281cfa59sm22474955wrr.47.2023.05.12.00.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:13:24 -0700 (PDT)
Message-ID: <2e5cae40-7040-a92f-3d11-ce68f1307049@baylibre.com>
Date:   Fri, 12 May 2023 09:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CACRpkdbjjoOoGeaqv9yQ4fTKqxt5eLDBjZCnNAYQnng3L+n8TQ@mail.gmail.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <CACRpkdbjjoOoGeaqv9yQ4fTKqxt5eLDBjZCnNAYQnng3L+n8TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2023 22:57, Linus Walleij wrote:
>> +       /* Documentation is stating that GPIO0 direction must not be changed in Linux:
>> +        * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
>> +        * Should only be changed in INITIALIZE state (prior to ON Request).
>> +        * Set statically by NVM, changing direction in application can cause a hang.
>> +        * Below can be used for test purpose only:
>> +        */
>> +
>> +#if 0
>> +       int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
>> +                                TPS65219_GPIO0_DIR_MASK, direction);
>> +       if (ret)
>> +               return ret;
>> +#endif
>> +       dev_err(gpio->tps->dev,
>> +               "GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
>> +                offset, direction);
>> +       return -EOPNOTSUPP;
>> +}
> 
> Normally people would complain about #if 0 code.
> 
> But this is a special case!
> 
> I definitely want the code to be in there somehow.
> 
> What about:
> 
> if (IS_ENABLED(DEBUG))?
> 
> If someone enables debug with an explicit -DDEBUG to the compiler
> this could be allowed.
I'm fine with your proposal. Will wait few days just in case anyone 
wants to add any comment then go for this.
