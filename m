Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88A704FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjEPNtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjEPNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:49:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C055265
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:49:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96aadfb19d7so922391066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684244958; x=1686836958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grBS+q7iyYNtpmlJiltCB+JthNyOMWFlJwW3Epp/Sos=;
        b=HBRr7sH/6xzY5vpJcD68tLzE31I6o8a+NcxY2HFi4YFpzplHIJ7/PzJkngKJSuccRP
         00wk/txTUCEKzf/9Xte3uU8wqxDOk1J4BWxlrVWd0mEUB9Bk8C5q2Gt+mkUAeuqYpvxu
         /IjHj3a79JIRqSxIkcHZ2MO+RP/aqcA3GCEJYmTXAK8DqjMIwiFf7M1Ne/xzR9AWf7B5
         lkYxLJ3wjWcVVbooSh6oiB40iD0UpzXbRSP8awT1N4CcFOMPqDmG01hTv4MedoquYXMR
         r/D52eamKXZX7uxA1aNn8L2BZfWxMH70Zck3SY9Du40o3urawndmy1WWAV3E/2OiEahq
         T7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244958; x=1686836958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grBS+q7iyYNtpmlJiltCB+JthNyOMWFlJwW3Epp/Sos=;
        b=BQBZT+exCyzxlE6dLG3gAJjZKHewaFxEiW39peb1f5B2c0doF2m/ViqXZr9mVtnAmM
         mfKJew+wlgn63Zftq8dyUBCaEutc49837czwlcSs/hpnr3vLQLUYhAzlIw046hZAHCou
         3yKaO2ZGfNr5BYp0b0qeoKeBUA6R/FdB2kvoYRxOOYDWXLBTEyZg2KVw58A01WCVtmCz
         UXkIF24Hm9USOM9KvxfLxleohkeTv5zQ1qBwr0DK08fOjvofDWHxz1XSZwZ7c9ELFU4j
         Mckr2mr/lnwvWK7r5WhGkEsklyXEp7FfuENkD3tn6UUa57G6zo5/t6ivb1sxybZHYtnc
         TTiQ==
X-Gm-Message-State: AC+VfDyNIP6xmNTVcB3G9GTLlFiJfY+5CsMfJlEG5mq6PylgXaOl20i0
        GWpDgxl2svI6keTwTjX3vv0/KQ==
X-Google-Smtp-Source: ACHHUZ6QN/kV4HRxD583spR8ZSU6tjbIY8aGPRXSbA89TUY99874swg4qONJq7Wg00BCUE1z6qeGeA==
X-Received: by 2002:a17:907:97c9:b0:96a:1348:7a27 with SMTP id js9-20020a17090797c900b0096a13487a27mr25712036ejc.12.1684244957919;
        Tue, 16 May 2023 06:49:17 -0700 (PDT)
Received: from [10.2.5.18] (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00965b7bf6aa5sm10942387ejb.52.2023.05.16.06.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:49:17 -0700 (PDT)
Message-ID: <9a52e227-4f36-3766-7a1e-b2cc37a3657a@baylibre.com>
Date:   Tue, 16 May 2023 15:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2023 17:36, Bartosz Golaszewski wrote:
>> +static const struct gpio_chip tps65219_gpio_chip = {
>> +       .label                  = "tps65219-gpio",
>> +       .owner                  = THIS_MODULE,
>> +       .get_direction          = tps65219_gpio_get_direction,
>> +       .direction_input        = tps65219_gpio_direction_input,
>> +       .direction_output       = tps65219_gpio_direction_output,
>> +       .get                    = tps65219_gpio_get,
>> +       .set                    = tps65219_gpio_set,
>> +       .base                   = -1,
>> +       .ngpio                  = 3,
>> +       .can_sleep              = true,
>> +};
>> +
>> +static int tps65219_gpio_probe(struct platform_device *pdev)
>> +{
>> +       struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
>> +       struct tps65219_gpio *gpio;
>> +
>> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>> +       if (!gpio)
>> +               return -ENOMEM;
>> +
>> +       gpio->tps = tps;
>> +       gpio->gpio_chip = tps65219_gpio_chip;
> 
> Aren't you getting any warnings here about dropping the 'const' from
> the global structure?
I tried a build with W=1 to check for warning I might have missed but 
can't catch any here.
It's done in the exact same way in many other upstream drivers.
Anyway I can remove the const here if you think that could create 
trouble at some point.

Just let me know your recommendation.

Regards,
Jerome
