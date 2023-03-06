Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709B6AB9F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCFJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCFJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:35:16 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141743ABF;
        Mon,  6 Mar 2023 01:35:12 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id g3so35860510eda.1;
        Mon, 06 Mar 2023 01:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9on8nJ5BHbcHwyEQhyWGS+CeCE+weljlfDVcLlawfM=;
        b=g/WrH3BwBKy2DBb0Gepo+bWOVfXnLLrm+cV+B7H4Ut5KRvytoInhtqyLO15EjKOuxk
         w0Ftdpoy3N246exKxzONWJ2oYPdZsP11sUXG8oHowmEiSMV7n9JphDFtGJoZ9P49qaCc
         Kh+qaEw0XbABLO5hBz3PM0jN1y32VThMTAnaHKF83bIopDBlANs6vzZUNqVBnIoEZbSt
         P/z639HSSnR6+fixiGItpM4VAWzs9wRoSSrLJHqiQfpykUW1O38f0eAoyHVi/izBG3k8
         axat03h39HbKLewO08E69Jp2B+Pb7oDeyxUBqI6fZV7qF0Sb1HiCFNreU+lZUJAT4OWu
         +/sg==
X-Gm-Message-State: AO0yUKXKW3skVoeH5Zae/535WLD3ShGnae/1SjRUzn9NYtAzmghh/uRL
        7iAPUlrJRSQGCMA009kZaug=
X-Google-Smtp-Source: AK7set+ZN+g7THBufgKmu7BH8GSraRQUNBXupyiPo0/K+LWqoJPjrC4vjqfNruF+fdDvYKUm3RpgEg==
X-Received: by 2002:a17:907:3f23:b0:84d:4e4f:1f85 with SMTP id hq35-20020a1709073f2300b0084d4e4f1f85mr13827542ejc.59.1678095310491;
        Mon, 06 Mar 2023 01:35:10 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b008b17de9d1f2sm4386370ejb.15.2023.03.06.01.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:35:09 -0800 (PST)
Message-ID: <1faade8f-d5e6-fd60-bd60-22e3b79c5ba4@kernel.org>
Date:   Mon, 6 Mar 2023 10:35:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de> <20230303141139.GP2420672@google.com>
 <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
 <20230306090456.GA9667@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
In-Reply-To: <20230306090456.GA9667@google.com>
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

On 06. 03. 23, 10:04, Lee Jones wrote:
> On Mon, 06 Mar 2023, Jiri Slaby wrote:
> 
>> On 03. 03. 23, 15:11, Lee Jones wrote:
>>> On Wed, 22 Feb 2023, Florian Eckert wrote:
>>>> @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_struct *work)
>>>>    		trigger_data->tty = tty;
>>>>    	}
>>>> -	ret = tty_get_icount(trigger_data->tty, &icount);
>>>> -	if (ret) {
>>>> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
>>>> -		mutex_unlock(&trigger_data->mutex);
>>>> -		return;
>>>> -	}
>>>> -
>>>> -	if (icount.rx != trigger_data->rx ||
>>>> -	    icount.tx != trigger_data->tx) {
>>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
>>>> -
>>>> -		trigger_data->rx = icount.rx;
>>>> -		trigger_data->tx = icount.tx;
>>>> -	} else {
>>>> -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
>>>> +	switch (trigger_data->mode) {
>>>> +	case TTY_LED_CTS:
>>>> +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
>>>> +		break;
>>>> +	case TTY_LED_DSR:
>>>> +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
>>>> +		break;
>>>> +	case TTY_LED_CAR:
>>>> +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
>>>> +		break;
>>>> +	case TTY_LED_RNG:
>>>> +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
>>>> +		break;
>>>> +	case TTY_LED_CNT:
>>>
>>> I believe this requires a 'fall-through' statement.
>>
>> I don't think this is the case. Isn't fallthrough required only in cases
>> when there is at least one statement, i.e. a block?
> 
> There's no mention of this caveat in the document.
> 
> To my untrained eyes, the rule looks fairly explicit, starting with "All".
> 
> "
>    All switch/case blocks must end in one of:
> 
>    * break;
>    * fallthrough;
>    * continue;
>    * goto <label>;
>    * return [expression];
> "
> 
> If you're aware of something I'm not, please consider updating the doc.

The magic word in the above is "block", IMO. A block is defined for me 
as a list of declarations and/or statements. Which is not the case in 
the above (i.e. in sequential "case"s).

Furthermore, the gcc docs specifically say about fallthrough attribute:
It can only be used in a switch statement (the compiler will issue an 
error otherwise), after a preceding statement and before a logically 
succeeding case label, or user-defined label.

While "case X:" is technically a (label) statement, I don't think they 
were thinking of it as such here due to following "succeeding case 
label" in the text.

So checking with the code, gcc indeed skips those 
(should_warn_for_implicit_fallthrough()):
   /* Skip all immediately following labels.  */
   while (!gsi_end_p (gsi)
          && (gimple_code (gsi_stmt (gsi)) == GIMPLE_LABEL
              || gimple_code (gsi_stmt (gsi)) == GIMPLE_PREDICT))
     gsi_next_nondebug (&gsi);


Apart from that, fallthrough only makes the code harder to read:

case X:
case Y:
case Z:
default:
   do_something();

VS

case X:
   fallthrough;
case Y:
   fallthrough;
case Z:
   fallthrough;
default:
   do_something();

The first one is a clear win, IMO, and it's pretty clear that it falls 
through on purpose. And even for compiler -- it shall not produce a 
warning in that case.

regards,
-- 
js
suse labs

