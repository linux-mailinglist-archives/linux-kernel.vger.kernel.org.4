Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8767A5B623A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiILUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiILUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:32:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410C491C1;
        Mon, 12 Sep 2022 13:32:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g23so2641290qtu.2;
        Mon, 12 Sep 2022 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ak18MshwY5Ellami6mArUG9tdrgWOmpzvJ37jVCJT+I=;
        b=kPbT7g9rnCoCnMIYdM1bRd6JYDOSYuR3bH2eAsv+0bojSjBWcs+/zTztK6hQakX9Qr
         +0Ut76l09BltjJM9DuDq/rkxXivP6IfTQGjIZvYXxoFUqIO7Bd5mbKoynAWCMqbwEHtN
         zK1BAEAf8hiKRB14oiiMIOMK4Ip9/u5+BZyC/Ztw0apDyKkF5Vf44AMshWe2IfO/sWXP
         x0sSmRbO0xaZ/9eVjmBxOeUVkkbQoqBoBG4hLQWadEIwfu2WLyo8C5Hwax2FlxomeNqg
         V7zAEvoR3JalyLc5/BEBCvkHVc5cQlQUeu8db3zbF1c6vmFnrUjqUTBmK3qjVL8i5cZr
         tANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ak18MshwY5Ellami6mArUG9tdrgWOmpzvJ37jVCJT+I=;
        b=Mrpf8EOQDQ9FifC/WQ+LpNc6NOs/zk9O7tryQ3rZPxqrp3Zk9elrlrsDoeOelXYEFi
         Jlt12L595js84pn5SxaSxn7sGmKUbw0PAGO1OvQOEeNhI+YHMzwSxOf4Owe6A3Qi1uy2
         OEq3Vf1HxQo39EJGEf0XTjXowzjibT51aEAGzPfL3/qvbXZRQ3bjy7JVT1UI/MiMToOa
         yClBI05Uquc9a0lI2eadMbrs0F1N+9bCsUVkSSeGK41yGSVPeYukHhGjTkEoFo4L2HGB
         ENfkRkPtDMqPmDZv7cJkqqreuOA4AUuk2qsEpuDwGs8ZCHdNO1OrOsK2N0bWMcEOSCA5
         VmQA==
X-Gm-Message-State: ACgBeo3c4r61BhE4brQprnkMfGrKLr8CFjwtdSJMXnMeh74uOsqoSJ2D
        uF14NnjHKfoAPd/dm7k7Ot9aHEYq4jA=
X-Google-Smtp-Source: AA6agR6yF3sOOtMvFhrpST7frBaH5o2SmbfUJbaOLOVZIceA8/NFP93Ook06/LDJ6t9ep9DmIhFemg==
X-Received: by 2002:ac8:7f48:0:b0:35b:bac4:c472 with SMTP id g8-20020ac87f48000000b0035bbac4c472mr2708992qtk.442.1663014752496;
        Mon, 12 Sep 2022 13:32:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:216d:1a77:16d6:2f68? ([2600:1700:2442:6db0:216d:1a77:16d6:2f68])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87156000000b0033a5048464fsm5042440qtp.11.2022.09.12.13.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 13:32:32 -0700 (PDT)
Message-ID: <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
Date:   Mon, 12 Sep 2022 15:32:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220912170524.GX4320@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 12:05, Daniel Walker wrote:
> On Mon, Sep 12, 2022 at 01:45:40AM -0500, Frank Rowand wrote:
>> On 9/8/22 12:55, Frank Rowand wrote:
>>> On 9/7/22 19:35, Daniel Walker wrote:
>>>> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
>>>>> On 9/7/22 18:07, Daniel Walker wrote:
>>>>>> This warning message shows by default on the vast majority of overlays
>>>>>> applied. Despite the text identifying this as a warning it is marked
>>>>>> with the loglevel for error. At Cisco we filter the loglevels to only
>>>>>> show error messages. We end up seeing this message but it's not really
>>>>>> an error.
>>>>>>
>>>>>> For this reason it makes sense to demote the message to the warning
>>>>>> loglevel.
>>>>>>
>>>>>> Cc: xe-linux-external@cisco.com
>>>>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
>>>>>> ---
>>>>>>  drivers/of/overlay.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>>>> index bd8ff4df723d..4ae276ed9a65 100644
>>>>>> --- a/drivers/of/overlay.c
>>>>>> +++ b/drivers/of/overlay.c
>>>>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>>>>  	}
>>>>>>  
>>>>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>>>>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>>>>  		       target->np, new_prop->name);
>>>>>>  
>>>>>>  	if (ret) {
>>>>>
>>>>> NACK
>>>>>
>>>>> This is showing a real problem with the overlay.
>>>>
>>>> What's the real problem ?
>>>>
>>>> Daniel
>>>
>>> A memory leak when the overlay is removed.
>>>
>>> I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
>>> more information about this.  If you don't see a patch by tomorrow, feel free to
>>> ping me.
>>>
>>> -Frank
>>
>> The good news is that your question prodded me to start improving the in kernel documentation
>> of overlays.  The promised patch is a rough start at:
>>
>>    https://lore.kernel.org/all/20220912062615.3727029-1-frowand.list@gmail.com/
>>
>> The bad news is that what I wrote doesn't explain the memory leak in any more detail.
>> If an overlay adds a property to a node in the base device tree then the memory
>> allocated to do the add will not be freed when the overlay is removed.  Since it is
>> possible to add and remove overlays multiple times, the ensuing size of the memory
>> leak is potentially unbounded.
> 
> Isn't this only a problem if you remove the overlay?

Yes, but we don't know if the overlay will be removed.  And I will not accept a
change that suppresses the message if there is no expectation to remove the
overlay.

> 
> if the dt fixup driver does have the ability to remove the overlay doesn't it
> have responsibility to free the memory? Or is it impossible to free the memory?

It is difficult due to architectural issues.  Reference counting occurs at the node
level, and not at the property level.  So memory related to properties is freed
when the corresponding overlay node reference count leads to the node being freed.

> 
> Daniel

