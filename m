Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628C166110E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjAGSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjAGSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:34:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795363F10C;
        Sat,  7 Jan 2023 10:34:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m6so6646954lfj.11;
        Sat, 07 Jan 2023 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6x+D6IIkokXsO6D3yDWBce6sU94M0ZxPLwwBNHRy5xw=;
        b=mATYV0y+ivVQ/rw1dZeTlhhQAcjBU4gO4MWSpyhCJSvXwWCA2kH8SCdV5ztoy0pHMb
         IhboAfhxEeZY6Drgm6F+U4XjJ3wDRyH7HIp1CvwKJkGW1YTAlhzAd6DbX0VyjJwxklQT
         l7E2njDEbpUDuxeARR6UD4BxtE6prB4GmaGSro5W9SRtPn3r2pp/1qtzjHT01HOFDl+e
         l7ElzoWjk7OxYU59mLUNX9cfr0MNBaxIDp89WRv2+EZzswE0dlBb8/rOCJl+7O1DJx5t
         u3jxGzs6CCJVOyo1IKWmCnQHIgEiP6is22pFZbhM4w9oJ31Sc6XBUsGg9g2YPYH4LCmT
         PhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6x+D6IIkokXsO6D3yDWBce6sU94M0ZxPLwwBNHRy5xw=;
        b=iEL7s7/AmiOLTyLHEn7drtEc6M/wTmf0fYuUNGQF1oPnpIcP4MDvi8mc6gBe8YZCoV
         NwrAbONAekan/nyIkDwmxkJc0hUWnnzCiA96AzInAKDio/vdIJzg9CLbYMNi7uiRzriw
         hfRY1IX6ar73CvnoUXhNIkWkQFroaoNaQij9I0w6Tl0Of176hJdL6nqBr9kjh1qBciBK
         63SxCBclYzOE139oH68MhOYlSdOf8LzkmsVx+dNWSOUWw6LYPTMxoO8iYkWwU6OUEWK7
         3cJ9Sd4boAzNXgj1VbZHf23M6GYVUjFRcYieJpUzAoWmqa3S6iPAHstOSMnF5b0LgeqT
         gb9g==
X-Gm-Message-State: AFqh2ko/PQevZVYWqd5Mbeh1hHpIfxCHKQ4SFa4fGCRUB3dl96wDv5Ad
        2qzXAGm0NPWPbQQ4rATmBiA=
X-Google-Smtp-Source: AMrXdXuFPOSMlIQVrC3Okp96r33pws7LkDLbLiXDUB5wvehdr8gvAdVQUAdCv1URwX2qsY0roNjinA==
X-Received: by 2002:a05:6512:3d2a:b0:4b4:b8fc:4aba with SMTP id d42-20020a0565123d2a00b004b4b8fc4abamr19911868lfv.25.1673116476771;
        Sat, 07 Jan 2023 10:34:36 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm675603lfr.261.2023.01.07.10.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 10:34:36 -0800 (PST)
Message-ID: <ad4a1069-72c6-a431-336f-ed78a57a1ba0@gmail.com>
Date:   Sat, 7 Jan 2023 19:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] leds: ledtrig-tty.c: call led_set_brightness() when
 the blocking callback is not available
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Qingtao Cao <qingtao.cao.au@gmail.com>,
        Qingtao Cao <qingtao.cao@digi.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209001039.7287-1-qingtao.cao@digi.com>
 <20221209124058.dwez7wohs7dfeiik@pengutronix.de>
 <Y7WnMISK20Z4hsg1@google.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <Y7WnMISK20Z4hsg1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 1/4/23 17:20, Lee Jones wrote:
> On Fri, 09 Dec 2022, Uwe Kleine-König wrote:
> 
>> On Fri, Dec 09, 2022 at 10:10:38AM +1000, Qingtao Cao wrote:
>>> The Marvell GPIO controller's driver will setup its struct gpio_chip's can_sleep
>>> false, making create_gpio_led() setting up the brightness_set function pointer
>>> instead of the brightness_set_blocking function pointer. In this case the
>>> nonblocking version led_set_brightness() should be fallen back on by ledtrig_tty_work()
>>>
>>> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
>>> ---
>>>   drivers/leds/trigger/ledtrig-tty.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
>>> index f62db7e520b5..e43d285b5d06 100644
>>> --- a/drivers/leds/trigger/ledtrig-tty.c
>>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>>> @@ -122,12 +122,18 @@ static void ledtrig_tty_work(struct work_struct *work)
>>>   
>>>   	if (icount.rx != trigger_data->rx ||
>>>   	    icount.tx != trigger_data->tx) {
>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>> +		if (trigger_data->led_cdev->brightness_set_blocking)
>>> +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>> +		else if (trigger_data->led_cdev->brightness_set)
>>> +			led_set_brightness(trigger_data->led_cdev, LED_ON);
>>
>> I had similar issues in the past where a function call worked for
>> sleeping LEDs but not atomic ones (or the other way around? Don't
>> remember the details.)
>>
>> I wonder if there isn't a function that does the right thing no matter
>> what type the LED is. The other triggers should have the same issue, and
>> doing the above check in all of them just looks wrong.
> 
> Anyone fancy taking a deeper dive into this?
> 
> I'd usually have a go myself, but I'm presently swamped.
> 
> Pavel already has an idea?
> 

There is led_set_brightness_nosleep() and it should be used here
from the beginning. Generally it should be used always in triggers.

-- 
Best regards,
Jacek Anaszewski
