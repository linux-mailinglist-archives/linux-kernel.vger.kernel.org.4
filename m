Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE66DCD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDJWNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDJWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:13:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40FE6F;
        Mon, 10 Apr 2023 15:13:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so4792982pji.1;
        Mon, 10 Apr 2023 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164782; x=1683756782;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMv4LjF4o6jkuy6zo53qlI8FQIadftxcQckNesNUGgc=;
        b=Vlfr0s21iniva1rOgUJAHzoDGA+KHAt0y6OxnQ/9AZtaQ30+aZz9Dimp2jDA/kKVOQ
         56UOTnUbh9MCHqNy7LagGORkWVleFm6Fb8PRs/swJlSPlgCEnfxVKlWR3FfcuCWbZzFV
         +ubiwiRh+JJCgcMc7BA4kGC9pGxaZn6zBQMP4XTyFOwq4Tmi2xRQonRC/fnZxkDhAjPF
         J/quhHj+AMglgEosMzKqtzAJp0M0L/QPUTSFyTDvMCC1i4Sb62lf2CzfBzO35qMCyh9x
         IRARd6b9XYoQIiqLnUfoM9MKhN9LFbCAkScgzomNGEhf0rjmm57waLtubfkaWpaqcwk3
         BHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164782; x=1683756782;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMv4LjF4o6jkuy6zo53qlI8FQIadftxcQckNesNUGgc=;
        b=2qhyx8RhdoA+8k5tLgvlhS6WQ7T5OcmcegcmawhIHNTOLTPk6gg20yA/JmgIh5HIRt
         10KijJAIHR7uxaVbkRUfHS69rSWCzM6YczuENL27QaTNJE7Shl1SMbOz8g4aKl4OR6ut
         dVD7jwgK1ANu0XfqI//1ywFAkfYEpoeER1CMCQbZ4wMy+zGHpMqqmRl0/VPzURwt/a8r
         DG0CTz734Lt5imtxBZ7shEHTj89dqjzxma772zD6i+7RWoyQwKqewYBPKoy+WyBb69FI
         TElSIIfzIL/TVbqWtk2GL7HxZgde2Yjjy5YDDTCSNVklIIdo1Hoivy2MkERVxMaJIN1+
         EQYg==
X-Gm-Message-State: AAQBX9dhsetW0xilTwaybtK1u20s3bPzrsQErmawsoGzGbg69xlMEygf
        7/T1iNMjPRemWHo2DhnrnbU=
X-Google-Smtp-Source: AKy350Zl8B7OdADQ5YSqEYRUFIfl8f2DA0umQsBdki27ZlL2GPY1f7rHMzuxtffyDdtUjriWJ26L5Q==
X-Received: by 2002:a17:902:c40b:b0:1a1:8fd4:251 with SMTP id k11-20020a170902c40b00b001a18fd40251mr17313908plk.55.1681164781807;
        Mon, 10 Apr 2023 15:13:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b0019cad2de86bsm5544458plb.156.2023.04.10.15.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:13:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <233780b0-dc7f-aaef-518e-51fe33498cd7@roeck-us.net>
Date:   Mon, 10 Apr 2023 15:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230410073134.488762-1-badhri@google.com>
 <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
 <2023041004-antarctic-hardiness-524e@gregkh>
 <CAPTae5JFC8WUzjrMeiyw7tYfWpsZUQThrrvG_etx7Fb2KP6y6A@mail.gmail.com>
 <b1ac0ab9-e6f3-4301-a231-519752e4a735@roeck-us.net>
 <CAPTae5LbWVc4Bdiwe69cwwxEGfSYvRv=419dUGR1u8n-WUkYAA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
In-Reply-To: <CAPTae5LbWVc4Bdiwe69cwwxEGfSYvRv=419dUGR1u8n-WUkYAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 13:57, Badhri Jagan Sridharan wrote:
> On Mon, Apr 10, 2023 at 10:00 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Apr 10, 2023 at 02:00:08AM -0700, Badhri Jagan Sridharan wrote:
>>> On Mon, Apr 10, 2023 at 1:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Apr 10, 2023 at 01:08:55AM -0700, Badhri Jagan Sridharan wrote:
>>>>> On Mon, Apr 10, 2023 at 12:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrote:
>>>>>>> This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
>>>>>>> logs to be wrapped around. Additionally, when set, does not clear
>>>>>>> the TCPM logs when dumped.
>>>>>>>
>>>>>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>>>>>>> ---
>>>>>>>   drivers/usb/typec/tcpm/Kconfig | 6 ++++++
>>>>>>>   drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
>>>>>>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
>>>>>>> index e6b88ca4a4b9..4dd2b594dfc9 100644
>>>>>>> --- a/drivers/usb/typec/tcpm/Kconfig
>>>>>>> +++ b/drivers/usb/typec/tcpm/Kconfig
>>>>>>> @@ -18,6 +18,12 @@ config TYPEC_TCPCI
>>>>>>>        help
>>>>>>>          Type-C Port Controller driver for TCPCI-compliant controller.
>>>>>>>
>>>>>>> +config TCPM_LOG_WRAPAROUND
>>>>>>> +     bool "Enable TCPM log wraparound"
>>>>>>> +     help
>>>>>>> +       When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
>>>>>>> +       default gets cleared when dumped and does not wraparound when full.
>>>>>>
>>>>>> Kconfig help text needs to be wrapped at the properly width.
>>>>>
>>>>> I assumed that the width is 100 characters, but it looks like it is
>>>>> 80. Will fix it in the next version.
>>>>>>
>>>>>> And you do not provide any hint here as to why this is not the default
>>>>>> option, or why someone would want this.
>>>>>
>>>>> "TCPM logs by default gets cleared when dumped and does not wraparound
>>>>> when full." was intended
>>>>> to convey why someone would want to set this. Perhaps it's not effective.
>>>>>
>>>>> Does the below look better:
>>>>> "TCPM logs by default gets cleared when dumped and does not wraparound
>>>>> when full. This can be overridden by setting this config.
>>>>> When the config is set, TCPM wraps around logs and does not clear the
>>>>> logs when dumped."
>>>>>
>>>>> Also, I could make this default if that's OK with Guenter.
>>>>>
>>>>>>
>>>>>> So, why is this not just the default operation anyway?  Why would you
>>>>>> ever want the logs cleared?
>>>>>
>>>>> I remember Guenter mentioning that he was finding it useful to not
>>>>> wrap around the logs to fix problems
>>>>> during tcpm_register_port (init sequence). IMHO wrapping around the
>>>>> logs helps to triage interoperability
>>>>> issues uncovered during testing. So both approaches have their own advantages.
>>>>
>>>> But as this is a build-time option, what would cause someone to choose
>>>> one over the other, and then when the system is running, they can't
>>>> change them?
>>>
>>> During initial phases of bringup, it makes sense to not wrap around
>>> the logs, but, once bringup is done its most effective to wraparound
>>> so that interop issues reported by the end users can be triaged where
>>> TCPM logs are very effective.
>>
>> Not really, because the problem tends to be the remote device
>> (or at least it used to be), not a driver under development.
> 
> Thanks for clarifying Guenter !
> Right now if we DONT wrap around, once an issue is observed with a
> remote device, the logs have to be cleared(if already full) and then
> the issue has to be reproduced to collect the TCPM logbuffer
> logsagain.
> 
> Having a log available _all_ the time, not just when explicitly
> enabled is still very useful to catch hard to reproduce intertop
> issues.
> 
> Given this would you be OK if I change the logic to wrap around always ?
> 
> IMHO based on what I have seen in the last couple of years, this would
> also cover the boot with accessory connected as if the link gets into
> a reset loop, the sequence after the reset reveals what had gone
> wrong.
> 

I have no strong opinion. As I said, maybe conditions have changed.
When I wrote the code, failure conditions happened all the time, and
reset loops overwrote the log repeatedly. I didn't implement the current
code because I was lazy or something, it was because wrap-around
did not work for me. Again, maybe the situation has changed.
And, to follow-up on Greg's question, maybe switching to tracing
instead of re-implementing it would make sense nowadays. I simply
don't know. I'll accept whatever solution you and Greg can agree on.

Thanks,
Guenter

