Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2407242EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjFFMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbjFFMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:46:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2210C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:46:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so9227849a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686055553; x=1688647553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YacwtbnUno0IGNzrMAEltE3NymQuYjNoVttmwVMJWAM=;
        b=ZlqhXZ+5hvJZyt81cQ47SzdYh7TH5Bq/KejcuVjBkAQQd8xffF80kYVHwn0ym1SEgK
         W7txtUblLRMywAwK4tjH6N0jvjFXskKYA2/02RudaMyqMM3Wtk5Iacyol7+QQHN5nZG1
         mCFgHniUKLMyL6kYE57KeedzCsmTXQy4Azm1kn49BGpsyzO1KdvMJl8N/tn8HKTXNb4E
         42rQwEktOQG1BCmKp8Q2ZqjGLO/irSD2Hn1H1gbQMKgF6Q2dtd7LT6z2MGPNUkz9zB2x
         vr0WnaCpaqUoRdBCKiEy+UMOUmIYZXtHP3GlVvOtNaC0aEc5rLdoFANkaxteBnN5psVC
         5QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055553; x=1688647553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YacwtbnUno0IGNzrMAEltE3NymQuYjNoVttmwVMJWAM=;
        b=Nd/SDV//Hi5ITKLMqjz0b2YBVHnfqG2I+xECoHFOgIO3m8CkDtjeBUBq597WKh/QTw
         ZFBx3LAwh6EAw4wjZL6+zh7hl9AVERuhCtAUxXny4JYxptnUZpixiYXQjVcKxiaH30yi
         KG7+Pg2zJL4R/Qt0rj24fzwCkFhdx0m7NYzTZ5K5IH14jD78PQAXknpUHUbtU4srrGil
         iHC1jPUbJkb7GniRZ8rWjx1oYqG5YFeo35CB2ZPH+i19HzSlyOxqZ6zm8YSuofAkaZ8n
         jqbBP9eJ5nyrqCRmO6xXRE9sEcgexE4wNNEfxbWdWhuCUrARM9cUSBVHIHBszae7Vm4G
         NwMg==
X-Gm-Message-State: AC+VfDzqy5fg+6JBeuNDqpbu86fSa7hpC9ftH1CqAKY4z6nxGm5YKxmn
        2kkaJbplPpGb0Fgo6616Dhjptw==
X-Google-Smtp-Source: ACHHUZ42tTvaNTNY9stNfznY3znrSbX7YjVIa6+KTc8of1bQ6mBRCp2PWliXxn95o6oyVMRqW8Qykw==
X-Received: by 2002:a17:906:58d4:b0:977:d53e:4055 with SMTP id e20-20020a17090658d400b00977d53e4055mr2433962ejs.58.1686055553367;
        Tue, 06 Jun 2023 05:45:53 -0700 (PDT)
Received: from [10.2.5.28] (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906869300b0097461a7ebdcsm5500768ejx.82.2023.06.06.05.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:45:52 -0700 (PDT)
Message-ID: <e487f966-aafb-7d21-935d-b1d0ac7c21ac@baylibre.com>
Date:   Tue, 6 Jun 2023 14:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Content-Language: en-US
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
 <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
 <ZHXZBCwk6tTu8gjY@surfacebook>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <ZHXZBCwk6tTu8gjY@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 13:07, andy.shevchenko@gmail.com wrote:
> Tue, May 30, 2023 at 09:59:59AM +0200, Jerome Neanne kirjoitti:
> 
> First of all, I have a bit of déjà vu that I have given already some comments
> that left neither answered nor addressed.
Sorry for that. I did not realized that some comments on the cover 
letter also apply to commit message.
> 
>> Add support for TPS65219 PMICs GPIO interface.
>>
>> 3 GPIO pins:
>> - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
>> - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
>>
>> GPIO0 is statically configured as input or output prior to Linux boot.
>> it is used for MULTI_DEVICE_ENABLE function.
>> This setting is statically configured by NVM.
>> GPIO0 can't be used as a generic GPIO (specification Table 8-34).
>> It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.
>>
>> Datasheet describes specific usage for non standard GPIO.
>> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
> 
> Can you convert this to be a Datasheet tag? Currently even Link is *not* a tag
> because there must be no blank lines in the tag block.
> 
>> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> 
I misinterpreted this comment. I looked at wrong examples but I think I 
understand now that the right usage is to have all the tags grouped 
together into one block which is delimited by blank lines before and 
after the whole block.
I'll then do this and put all the Datasheet/Link into the tag block. 
Stop putting Links inside the commit message right after I refer to it.
https://www.kernel.org/doc/html/latest/process/5.Posting.html#patch-formatting-and-changelogs

> ...
> 
>> +	help
>> +	  Select this option to enable GPIO driver for the TPS65219 chip family.
>> +	  GPIO0 is statically configured as input or output prior to Linux boot.
>> +	  It is used for MULTI_DEVICE_ENABLE function.
>> +	  This setting is statically configured by NVM.
>> +	  GPIO0 can't be used as a generic GPIO.
>> +	  It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.
>> +
>> +	  This driver can also be built as a module.
>> +	  If so, the module will be called gpio_tps65219.
> 
> Random indentation. Can you use as much room as available on each line, please?
Sure for next iteration, I choosed 80 columns here to stay consistent 
with other configs. I kept a carriage return after the first sentence 
like it is done for other descriptions.
This driver can also be built as a module... is separated with a blank 
line as it is done in all other configs.
For all the other lines, I now keep the same line until last word 
strictly exceed column 80.

> 
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * GPIO driver for TI TPS65219 PMICs
>> + *
>> + * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/mfd/tps65219.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> ...
> 
>> +static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
>> +{
>> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
>> +	struct device *dev = gpio->tps->dev;
>> +	int ret, val;
>> +
>> +	if (offset != TPS65219_GPIO0_IDX) {
>> +		dev_err(dev, "GPIO%d is output only, cannot get\n", offset);
> 
>> +		return -EOPNOTSUPP;
> 
> This seems blind following the checkpatch false warning. The checkpatch does
> not know about subsystem details, i.e. GPIOLIB uses ENOTSUPP in the callbacks.
> The userspace won't see that as GPIOLIB takes care of translating it when
> needed.
> 
Thanks for explaining, I'm often in trouble for choosing the error code. 
I'll replace here and all other places where it's used with EOPNOTSUPP.

Regards,
Jerome
