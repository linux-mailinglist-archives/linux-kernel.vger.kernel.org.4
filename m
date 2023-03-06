Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998296AB6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCFG5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:57:33 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351311A49D;
        Sun,  5 Mar 2023 22:57:32 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7478397wmb.0;
        Sun, 05 Mar 2023 22:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rVKFNICUiosMKhBpyplwuprzcEnyE+B2l5hfazP7zE=;
        b=lHx2LBug5Hkw2lgBdR/dIXKZVpkCq0zuG7MfH0MCfvuq5Yx1Uw2Fkznp3TlRHpGIWb
         yRMXeT0DGSoAYPRRuhMmPIgbctwMHcr9i3fKE1F0PA6ywoerKoYpJCc4wd0kRlERsRCu
         UigHlFHryjLvzFgESfTMVF/Md0A4xdpfI0hXrBJwFeFxz3ZnF0d56LyZ+OSj7odDdo11
         hlh+FfeuwaLKrMJpcvbW4ptFiCWO6CyCNOiftBpJViBSVN51wbKpZE6WIC1KiUXJcaDs
         WDeBuzQweirqPxn7rg4J8SR1OPNi4OPI93ZInNix1+iUdw6KYcVzBBpCNY/K0GiKhiN7
         2A3w==
X-Gm-Message-State: AO0yUKXswmZ3PE7IbXXi+pawimjVqZj1ZeU4eWyqyGai7HKU0UERgrd+
        Vequu0ivpFzWaJIo3uSng2YAlTgJJliR1A==
X-Google-Smtp-Source: AK7set++PzSugaLMb9ntcRa1NaTS46WIvaJ62xq3bFDBE885ih8Hg+A+v2ZOXNDWUR2XeIa+t8oMpw==
X-Received: by 2002:a05:600c:4fd6:b0:3e2:6ec:7fb7 with SMTP id o22-20020a05600c4fd600b003e206ec7fb7mr8300622wmq.0.1678085850213;
        Sun, 05 Mar 2023 22:57:30 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id i47-20020a05600c4b2f00b003eb5a531232sm9334722wmp.38.2023.03.05.22.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:57:29 -0800 (PST)
Message-ID: <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
Date:   Mon, 6 Mar 2023 07:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Florian Eckert <fe@dev.tdt.de>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de> <20230303141139.GP2420672@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230303141139.GP2420672@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 03. 23, 15:11, Lee Jones wrote:
> On Wed, 22 Feb 2023, Florian Eckert wrote:
>> @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_struct *work)
>>   		trigger_data->tty = tty;
>>   	}
>>   
>> -	ret = tty_get_icount(trigger_data->tty, &icount);
>> -	if (ret) {
>> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
>> -		mutex_unlock(&trigger_data->mutex);
>> -		return;
>> -	}
>> -
>> -	if (icount.rx != trigger_data->rx ||
>> -	    icount.tx != trigger_data->tx) {
>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>> -
>> -		trigger_data->rx = icount.rx;
>> -		trigger_data->tx = icount.tx;
>> -	} else {
>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
>> +	switch (trigger_data->mode) {
>> +	case TTY_LED_CTS:
>> +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
>> +		break;
>> +	case TTY_LED_DSR:
>> +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
>> +		break;
>> +	case TTY_LED_CAR:
>> +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
>> +		break;
>> +	case TTY_LED_RNG:
>> +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
>> +		break;
>> +	case TTY_LED_CNT:
> 
> I believe this requires a 'fall-through' statement.

I don't think this is the case. Isn't fallthrough required only in cases 
when there is at least one statement, i.e. a block?

> Documentation/process/deprecated.rst
> 
>> +	default:
>> +		ret = tty_get_icount(trigger_data->tty, &icount);
>> +		if (ret) {
>> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
>> +			mutex_unlock(&trigger_data->mutex);
>> +			return;
>> +		}
>> +


-- 
js

