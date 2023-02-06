Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED72F68C928
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBFWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:11:30 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10324490;
        Mon,  6 Feb 2023 14:11:29 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s17so11015453ois.10;
        Mon, 06 Feb 2023 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nljbr3uXVqpZxVEZ42gUDnSq+c+mUDh/a/HJxS6yrAk=;
        b=InkAUd1v/OpD0RVLNnSXKYHOsa3n/Flm6MPd8D1wBEa6ucthHyNxzEE6yFOZabItgM
         K/sIAw3FlipOmgPbZHyqv8QkFlqhAjA0Cr++zg5m8rasse07dc243Fph1jKCRDu8Jvhf
         Gji8/6fUx4e8iCg94tbaNK+y+LeVFimcAplpC9FJufMqsKZJnK9I27D1YQVZn1v/U1/d
         VV+YqDK0Jikwk/Stu0sh8bEaKYGdFmRY1zlsqnJClFBzHnprq03BB3zQIlFeP4RJsGJ3
         dknJnEMHLHhYpoRnwevLw1Iefkj9YWSuJJ3mtPcwA6sJMN9LtB8Jm66C3b/BZfnz/ISX
         bzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nljbr3uXVqpZxVEZ42gUDnSq+c+mUDh/a/HJxS6yrAk=;
        b=hhm9TgWMra6/eKaY9EPSFCJ7dHi5EEuN3jRKEs1sHdBqmKvIKiMEb1vg4/6Z6TVqic
         xgEB4uc0ulI5X8B3TVs0xbzrQsy6O+nOWhvViQTFsQwlSyJCszu+g4D07MLVot5+o1Dv
         GpTtaVFdSojXrjyvvaaIZhX+w2q5/dilkQMUDueh8mPNxXjAGsDbjb9T64PT9R/U/z9Y
         GsQamLoll03d+th6ngp4TlslhmyHNqB8S6Pqv2VuALJATjNA9+uQY0X675BnBUXZXPwI
         wHlp//oIzyLIPF6+buQYDS+S0ZpdHOpGy8X1n/9t4rbB2X09c/FEe6aE+8cUZcT/2pUd
         2ScA==
X-Gm-Message-State: AO0yUKWI5hTPI3aYTnxFezGFA/IF9k+I+WILWHBQyBCsqSEh564TNcZf
        QbnR0pJnHpju+7Cwb5iopWA=
X-Google-Smtp-Source: AK7set++jgeRGm5Ra+LVGtP7Rt+IaGGAdphSxCbr2F9zCDO8yFv54JYGBK7jh3ryslCaQ297Oz+Biw==
X-Received: by 2002:a05:6808:98:b0:378:6da:6d4f with SMTP id s24-20020a056808009800b0037806da6d4fmr137123oic.28.1675721488257;
        Mon, 06 Feb 2023 14:11:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cn1-20020a056830658100b0068bdd6e31a7sm5516942otb.7.2023.02.06.14.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:11:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4d00ad17-3422-5b5f-b0bd-fc511e3eb21c@roeck-us.net>
Date:   Mon, 6 Feb 2023 14:11:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Add hwmon support
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230205205456.2364-1-W_Armin@gmx.de>
 <20230205205456.2364-2-W_Armin@gmx.de>
 <a7d2e011-142d-88b9-2591-cf4508f1b8c5@redhat.com>
 <20230206162303.GA195090@roeck-us.net>
 <08af724c-8c65-db41-ece8-f330f67a3dc2@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <08af724c-8c65-db41-ece8-f330f67a3dc2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 13:19, Armin Wolf wrote:
> Am 06.02.23 um 17:23 schrieb Guenter Roeck:
> 
>> On Mon, Feb 06, 2023 at 03:13:25PM +0100, Hans de Goede wrote:
>>> Hi Armin,
>>>
>>> On 2/5/23 21:54, Armin Wolf wrote:
>>>> Thanks to bugreport 216655 on bugzilla triggered by the
>>>> dell-smm-hwmon driver, the contents of the sensor buffers
>>>> could be almost completely decoded.
>>>> Add an hwmon interface for exposing the fan and thermal
>>>> sensor values. Since the WMI interface can be quite slow
>>>> on some machines, the sensor buffers are cached for 1 second
>>>> to lessen the performance impact.
>>>> The debugfs interface remains in place to aid in reverse-engineering
>>>> of unknown sensor types and the thermal buffer.
>>>>
>>>> Tested-by: Antonín Skala <skala.antonin@gmail.com>
>>>> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> This looks nice and clean to me, thank you:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> I'm going to wait a bit with merging this to see if Guenter
>>> has any remarks. If there are no remarks by next Monday then
>>> I'll merge this for the 6.3 merge window.
>>>
>> I don't have any further remarks. I won't send an Ack, though.
>> I noticed that the empty lines before return statements distract
>> me sufficiently enough that I am not sure about the actual code.
>>
>> Guenter
> 
> I will send a 3rd revision of the patch series to remove those empty lines then.
> Speaking of a 3rd revision, i noticed that jiffies are not updated during suspend,
> so the sensor values might be wrong for a short time when resuming after a long time.
> 
> This can be solved by either usingktime_get_boottime_ns(), which does not stop during suspend, or by
> invalidating the sensor cache upon resume. Which method should be used
> in this case? Armin Wolf
> 

I would suggest to invalidate the sensor cache; that seems less complex.

Guenter

