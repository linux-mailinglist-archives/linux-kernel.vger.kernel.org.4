Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E56772F8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 23:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAVWS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAVWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 17:18:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFDB12F28;
        Sun, 22 Jan 2023 14:18:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 18so12577203edw.7;
        Sun, 22 Jan 2023 14:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKR/NM8SHAkaMPo15BdSQmhUiv/K6yWGm40EuRJqFtQ=;
        b=JSVlhxCOSrZRvyAemaFpJQ0db6qlzxHpOYj9RYgz7ugu7cIEL4LujNQW8o2morcIHU
         swL7ZXbInKNJbVd7pqPzM1Y/2uY2kDKjZREOdVaFURVPYba1kPTjLLrMHVwFK/IvVZjM
         WJB8boQvldJyhLTU3Ky8/2PqKpSYImQYbddoEU25tP1xBJoNaQMbghiNIhatYGCPrkAy
         19eG7T3CMg0yYpIRiLepRSdUmxUFRAMvQztNUJXIMDihz1uFtaaSDc9JSkFXQi5fUsx8
         qTYzGuOSBjjHHPgEgpLbJYz7K9XROcyuQA3Bs9QHs2O78hSgvKai9LVe4+3jAQO8vX6S
         ObMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKR/NM8SHAkaMPo15BdSQmhUiv/K6yWGm40EuRJqFtQ=;
        b=PD3dz6Tr1B8+3Ob61UQWPUAja86zubeUoJbJ241SxgmHolsOMcpSYZpQGZOtxkDLI+
         zVn/6cQHU0wgYS5rKnfaJo5ubPKjBfaUAAXRMNrKh8KrwL+l6XM1AkiDMW4K3DyVAhMA
         J2Ba4E469D+rmmloeQnZg0ks3klCd73+H2VYvMV7x4SkQHnZ2PcobD/HE9uPcNNlcXnQ
         aI56kW5oSUmbswV0LmePCOu7YjaDpxPFtq7QTf4BFinOjPtF6NQR9T95hdHaLCnumlgH
         v7kA4b+L0qIbXg/QKhwWW+WAZIL+bGlYsHOZCHGsCwP/8AX2T01XcNcHSG+EsNyEVTJY
         gZYg==
X-Gm-Message-State: AFqh2kq3G0BDJV8swzFrLmctDGby+XLHUgBg83+BrL3dO31nvEPSB0yr
        gRRIldpSRRIM34cUqO+KMnw=
X-Google-Smtp-Source: AMrXdXv8l0iDTOgokA3kmMe3mN46gdX9LKOXSTLWRPODs290LJUZj+yo2RzHc8nx4FG3eXcSiDfnAg==
X-Received: by 2002:a05:6402:221b:b0:493:a6eb:874f with SMTP id cq27-20020a056402221b00b00493a6eb874fmr22571079edb.7.1674425902063;
        Sun, 22 Jan 2023 14:18:22 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm7244882eda.17.2023.01.22.14.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 14:18:21 -0800 (PST)
Message-ID: <d34ad55c-62c4-6eaf-8f73-19a675264a7c@gmail.com>
Date:   Sun, 22 Jan 2023 23:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] leds: ledtrig-tty.c: call led_set_brightness() when
 the blocking callback is not available
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Qingtao Cao <qingtao.cao.au@gmail.com>,
        Qingtao Cao <qingtao.cao@digi.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209001039.7287-1-qingtao.cao@digi.com>
 <20221209124058.dwez7wohs7dfeiik@pengutronix.de>
 <Y7WnMISK20Z4hsg1@google.com>
 <ad4a1069-72c6-a431-336f-ed78a57a1ba0@gmail.com>
 <Y8qW1tlDmw6KEIuu@google.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <Y8qW1tlDmw6KEIuu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 14:27, Lee Jones wrote:
> On Sat, 07 Jan 2023, Jacek Anaszewski wrote:
> 
>> Hi all,
>>
>> On 1/4/23 17:20, Lee Jones wrote:
>>> On Fri, 09 Dec 2022, Uwe Kleine-König wrote:
>>>
>>>> On Fri, Dec 09, 2022 at 10:10:38AM +1000, Qingtao Cao wrote:
>>>>> The Marvell GPIO controller's driver will setup its struct gpio_chip's can_sleep
>>>>> false, making create_gpio_led() setting up the brightness_set function pointer
>>>>> instead of the brightness_set_blocking function pointer. In this case the
>>>>> nonblocking version led_set_brightness() should be fallen back on by ledtrig_tty_work()
>>>>>
>>>>> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
>>>>> ---
>>>>>    drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
>>>>> index f62db7e520b5..e43d285b5d06 100644
>>>>> --- a/drivers/leds/trigger/ledtrig-tty.c
>>>>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>>>>> @@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *work)
>>>>>    	if (icount.rx != trigger_data->rx ||
>>>>>    	    icount.tx != trigger_data->tx) {
>>>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>>>> +		if (trigger_data->led_cdev->brightness_set_blocking)
>>>>> +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>>>> +		else if (trigger_data->led_cdev->brightness_set)
>>>>> +			led_set_brightness(trigger_data->led_cdev, LED_ON);
>>>>
>>>> I had similar issues in the past where a function call worked for
>>>> sleeping LEDs but not atomic ones (or the other way around? Don't
>>>> remember the details.)
>>>>
>>>> I wonder if there isn't a function that does the right thing no matter
>>>> what type the LED is. The other triggers should have the same issue, and
>>>> doing the above check in all of them just looks wrong.
>>>
>>> Anyone fancy taking a deeper dive into this?
>>>
>>> I'd usually have a go myself, but I'm presently swamped.
>>>
>>> Pavel already has an idea?
>>>
>>
>> There is led_set_brightness_nosleep() and it should be used here
>> from the beginning. Generally it should be used always in triggers.
> 
> Thanks for helping to keep an eye on things Jacek.
> 
> Much appreciated.
> 

No problem, I still read the list and can elaborate
on various details of LED subsystem, as needed.

-- 
Best regards,
Jacek Anaszewski
