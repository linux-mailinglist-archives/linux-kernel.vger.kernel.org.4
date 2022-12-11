Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285D864952F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiLKROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLKROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 12:14:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA87BF7D;
        Sun, 11 Dec 2022 09:14:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d20so9876588edn.0;
        Sun, 11 Dec 2022 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1hAhaRqZ2A3mdQAphxr+r1hffWEvyAJ7i4Dprgirms=;
        b=cF4gRBIrcDI6x3GCalOcMnTir8IVc6eu22RZw263lkp6yh9jrIKucN50g0mApnGpU1
         ZYs/E+ZZyOKmxwFg+hMVZq0InBW9hKyWniKJwS+84gh3Om+/PhBHhiMyu7hdFu73B/73
         YBEI6QnzaKqQ7n5wxTBM6hfGI656HnhyRXxBKgJMvFBfQtHtn/FqvCM8qiXQGmhtvGUC
         QHgh9DDQ+sF6n3I2HUxhoqrIrfeEMNL26grnrhBYf5jk9pwmlxEwVVqngyN0lXz/yKyF
         14ZcffDkGZt6UeT4MdQQa3SoJTwqWrjG6e/mmJm1qNsDILrkPH3QwjdTXvU6wSiZVEdU
         G/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1hAhaRqZ2A3mdQAphxr+r1hffWEvyAJ7i4Dprgirms=;
        b=pPsGGLzq/4zDkMOHRfbHnTWiOXnhBhqENhNpEz6B3KCvfSbAhAw8sW8LdosqaKRgmq
         uQPRGe5K/gJoPgsf726n3QzOSZ+H6G1eehNyaC54X6ZcYJynoYEldlXyuQ+6U/gLIO7p
         vdj9VV4PajMUCuc2tlpWaybo2Opiy6GxIB2fZPNVnNZz7gz938jbvf3K4oNGaOU8GTxd
         Xk8GlZoGgQSpPRJvBfVSAhEPbT+gZ84hdY1dzZTqqeuOySAZatLiieEHdzQ1VnjCbHWr
         aOkZMl9qV+pjc8zj8bNAQAT55f68Df5JngaMfgf0XAs6lF5Iy+KhbDxRaSuhTDa4lxHD
         z22Q==
X-Gm-Message-State: ANoB5plSqJTgRjWHWrHLO4zsu5FRER9fibxNAFPCIpeRq+dlrLxLZTVZ
        AXozUTpTsCVcp5o219sPHe4=
X-Google-Smtp-Source: AA0mqf5n+VsOoy508pKJBhkTnscGJU8hiKT1QNIbSuNg3nFxezQfnode1+fp8v5X4vTWLDfnyoXcIA==
X-Received: by 2002:a05:6402:548c:b0:461:6f87:20be with SMTP id fg12-20020a056402548c00b004616f8720bemr10051470edb.41.1670778843163;
        Sun, 11 Dec 2022 09:14:03 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:4e59:3503:a88a:129d? (2a02-a466-68ed-1-4e59-3503-a88a-129d.fixed6.kpn.net. [2a02:a466:68ed:1:4e59:3503:a88a:129d])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090653c900b007ae693cd265sm2271355ejo.150.2022.12.11.09.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 09:14:02 -0800 (PST)
Message-ID: <c48cc4ff-9021-0e32-6e68-89fa549847cc@gmail.com>
Date:   Sun, 11 Dec 2022 18:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 01/11] iio: light: tsl2563: Do not hardcode interrupt
 trigger type
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
 <20221211132611.0ab2f29e@jic23-huawei>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20221211132611.0ab2f29e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 11-12-2022 om 14:26 schreef Jonathan Cameron:
> On Wed,  7 Dec 2022 21:03:38 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> From: Ferry Toth <ftoth@exalondelft.nl>
>>
>> Instead of hardcoding IRQ trigger type to IRQF_TRIGGER_RAISING,
>> let's respect the settings specified in the firmware description.
>> To be compatible with the older firmware descriptions, if trigger
>> type is not set up there, we'll set it to default (raising edge).
>>
>> Fixes: 388be4883952 ("staging:iio: tsl2563 abi fixes and interrupt handling")
>> Fixes: bdab1001738f ("staging:iio:light:tsl2563 remove old style event registration.")
>> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Andy, would have preferred a cover letter, so I had an obvious place
> to reply to the whole series...
> 
> Mostly I'm amazed anyone still has one of these devices (I have one but
> it's on a break out board for the stargate2/imote2 pxa27x platform that we
> dropped support for last year - I hadn't booted it for a few years)
> - I can probably bodge it onto something else but I can't say it was
> high on my todo list ;)  So nice to know that someone still cares about
> this.
> 
> So I'm curious Ferry, what device has one of these?

It's a breakout board too. I think it's something like GY-2561.

I wanted to write up an example how to get connect iio sensors to work 
with linux. So I asked my colleague who is a great fan of aliexpress if 
he had any sensor on a breakout board with I2C. In the past I had it 
working with MRAA and UPM but that seems to be a dead end now.

We have ACPI working on Intel Edison-Arduino with quite a few examples 
from Andy. And the "Arduino" header makes it very easy to wire up these 
kind of breakout boards, fantastic platform this type of developments.

Just wiring up the I2C and get it to work was easy enough. And then the 
interrupt pin makes an interesting example (even though likely useless 
for most applications of the light sensor).

Write-up here if you are interested:
https://htot.github.io/meta-intel-edison/4.6-libiio.html

> Whole series applied to the togreg branch of iio.git though note I'll only
> push this out as testing for now because I'll want to rebase that tree
> after rc1 is available.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/light/tsl2563.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
>> index d0e42b73203a..71302ae864d9 100644
>> --- a/drivers/iio/light/tsl2563.c
>> +++ b/drivers/iio/light/tsl2563.c
>> @@ -704,6 +704,7 @@ static int tsl2563_probe(struct i2c_client *client)
>>   	struct iio_dev *indio_dev;
>>   	struct tsl2563_chip *chip;
>>   	struct tsl2563_platform_data *pdata = client->dev.platform_data;
>> +	unsigned long irq_flags;
>>   	int err = 0;
>>   	u8 id = 0;
>>   
>> @@ -759,10 +760,15 @@ static int tsl2563_probe(struct i2c_client *client)
>>   		indio_dev->info = &tsl2563_info_no_irq;
>>   
>>   	if (client->irq) {
>> +		irq_flags = irq_get_trigger_type(client->irq);
>> +		if (irq_flags == IRQF_TRIGGER_NONE)
>> +			irq_flags = IRQF_TRIGGER_RISING;
>> +		irq_flags |= IRQF_ONESHOT;
>> +
>>   		err = devm_request_threaded_irq(&client->dev, client->irq,
>>   					   NULL,
>>   					   &tsl2563_event_handler,
>> -					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> +					   irq_flags,
>>   					   "tsl2563_event",
>>   					   indio_dev);
>>   		if (err) {
> 

