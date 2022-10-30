Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536B61275E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 05:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3Ezl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ3Ezd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 00:55:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D07221E21;
        Sat, 29 Oct 2022 21:55:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso5202079otn.0;
        Sat, 29 Oct 2022 21:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sfpuJmtqs6zMYwE03/AjygLRDSLqQw/jFF2Sdl1I7U=;
        b=OA71th6ZTAU/fk/AXbet3ULpOcipbM7y59cXdEZ7KglP1JE6QtwM5TU+ISpU/Re7bb
         JQoiMcFRPOCyDTiaadm3N/zDwksTrOSM03wMwNWfY/zcE15FgkacTjZVQZLUAZdhzyLA
         4XiMF5LHdqBNowPpB5md5yB9Ro6qFblxVOOTeMyJ/AA4MHxxJ8QW8ovKNPc3sgJ89Kae
         SEtGjW9tLG8spcWRmEk4+Mzh71bm6vP51CADyzh4uEYNJ9SAyP/KHMEndXK4fM0FxEzo
         FHLE6Mv7W1xgsb2VBb/cBS52cI2yZ3JsEqF3VtfP4tg34nRXrpX6fmoZPMMEH7NhXeft
         AioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sfpuJmtqs6zMYwE03/AjygLRDSLqQw/jFF2Sdl1I7U=;
        b=3IxDUqok5PnIS4QKPfN0cKVG1PwUnBZOqz5qzb2fUkzRgunt+/bcASUCckrYAY1jaA
         Sy1c+2Zaq4sZJCOOiJuVUQ/twiZBG2ddcLjpnPIlIvSHoK2KSDAyRj3YrV86ZVY5KR2t
         Udq9mBssbnXjU57vu8PWBDoJ1RBDrFiVCKGFPwPq1xtzq7dMe7sxNJ5CfIYcXysulrqI
         Y4wSU0sEHyN2zsDy8phaqMYpAtK1ZUCBLdJCf/r9LQltfxhKK2/m1eA3fF+hqlzRVhJL
         EIXTuRlauQIXKv5vnQPfZqT2C16qR9Xv93HdcYUtEeH6SkFnYaOiRLLhEm5ZEqEcwfD7
         jEJA==
X-Gm-Message-State: ACrzQf3uxN+0uuDP3tW4u8e6W7Yq5c8HQiXA3iGCEInJGl0sRDE/I7do
        W4rM76tqiBgBVdm3BQRrXeo+bbf7MT4=
X-Google-Smtp-Source: AMsMyM49ekDrrDaAO01eattiXVMqyqdte/fWJ867p1ZlZ4qxfvybLQ3TfJTpesl2DPlIjfcXGvyVlg==
X-Received: by 2002:a9d:6496:0:b0:66c:4c59:8443 with SMTP id g22-20020a9d6496000000b0066c4c598443mr157410otl.347.1667105732282;
        Sat, 29 Oct 2022 21:55:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v4-20020a056808004400b00354efb5be11sm1139522oic.15.2022.10.29.21.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 21:55:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9afef4dc-29a8-2f8a-84b3-897dc3b887aa@roeck-us.net>
Date:   Sat, 29 Oct 2022 21:55:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
 <20221029142551.GA3222119@roeck-us.net> <Y12o+Hk2qsIsDQUo@google.com>
 <086d381d-bc6f-7dd3-35b6-d05afe742b9e@roeck-us.net>
 <Y13+pV6ga5DqXyQF@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
In-Reply-To: <Y13+pV6ga5DqXyQF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 21:33, Dmitry Torokhov wrote:
> On Sat, Oct 29, 2022 at 04:02:56PM -0700, Guenter Roeck wrote:
>> On 10/29/22 15:28, Dmitry Torokhov wrote:
>>> On Sat, Oct 29, 2022 at 07:25:51AM -0700, Guenter Roeck wrote:
>>>> On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
>>>>> When the data structure is only referred by pointer, compiler may not need
>>>>> to see the contents of the data type. Thus, we may replace header inclusions
>>>>> by respective forward declarations.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> ---
>>>>>    include/linux/input/matrix_keypad.h | 5 +++--
>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
>>>>> index 9476768c3b90..b8d8d69eba29 100644
>>>>> --- a/include/linux/input/matrix_keypad.h
>>>>> +++ b/include/linux/input/matrix_keypad.h
>>>>> @@ -3,8 +3,9 @@
>>>>>    #define _MATRIX_KEYPAD_H
>>>>>    #include <linux/types.h>
>>>>> -#include <linux/input.h>
>>>>
>>>> Possibly, but may other drivers rely on those includes.
>>>> This results in widespread build failures such as
>>>>
>>>> Building arm:allmodconfig ... failed
>>>> --------------
>>>> Error log:
>>>> In file included from include/linux/input/samsung-keypad.h:12,
>>>>                    from arch/arm/mach-s3c/keypad.h:12,
>>>>                    from arch/arm/mach-s3c/mach-crag6410.c:57:
>>>> arch/arm/mach-s3c/mach-crag6410.c:183:19: error: 'KEY_VOLUMEUP' undeclared here
>>>
>>> I fixed this particular instance, hopefully it is one of the very
>>> last of them...
>>>
>>
>> Sorry, I didn't bother listing all of them. There is at least one more.
>>
>> Error log:
>> arch/arm/mach-pxa/spitz.c:410:11: error: 'EV_PWR' undeclared here (not in a function)
>>    410 |   .type = EV_PWR,
>>        |           ^~~~~~
>>
>> with arm:pxa_defconfig.
> 
> Ah, I see. Arnd is trying to delete bunch of PXA code, so I'll pull the
> header change until after he merges his, and hopefully spitz will be
> gone.
> 
> Do you have more examples by chance?
> 

No, but no guarantees - there are various other build failures in -next,
and I may have missed some.

Guenter

