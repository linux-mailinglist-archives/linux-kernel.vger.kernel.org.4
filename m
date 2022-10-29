Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFD612658
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ2XDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2XDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 19:03:00 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B7739A;
        Sat, 29 Oct 2022 16:02:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y67so9709367oiy.1;
        Sat, 29 Oct 2022 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mf5ySJI//PO0oeNWRzQ4DWs3ZWqSUDcz0CoIWTuwqEw=;
        b=J7O/M8yFPqBgZxXEFTI2MY9rI5Y/6iPLrH0G3sF+S/vXXCryK4453NDNOup97yRtQQ
         IJJygWT+gHXMVgdiW3GsQI61dM2ufX5eTsswVmYDNA8wizp6z5JuUuUfUKAHeo8GVCYP
         Zx20P4KasFdj7clj6J2IffdmLtS3qoE9GuRpieyVHxd3dNXAx39OPXiApChDsiojf+Nx
         QyLQyaOS7S3zZf+ea3Om5+LZJcJmuGyKzk5oi6BvKFLj9pQ+q922ts7nYBzp/+9rCGWl
         vZqXtlt7ZYS4WYkR1Pe7OKQRgHmCQBi/LhDRlZygkme0ugEDsjbkVTfH9og1YSlFoIMn
         Q6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mf5ySJI//PO0oeNWRzQ4DWs3ZWqSUDcz0CoIWTuwqEw=;
        b=rueaL3aZRj/lzyTxU1Cn+kFVzrlygmdAMJtIxpJDTOn6brVWol3g9rWmw3xCsAjs1v
         HW31NaEps/5S+5BrF8pQZZRYSaurkx6l3Qp9jXfOuFniOnkl3fgvIP5H9fGkLpsX82N+
         n2TWPbNmeYTidZw1tQ3zan87GIMtAY0gdYn0epGq61MfdFp/918QyHWj3IJloOftvqBa
         0c+5kFgcLdCOBdHeAArN6bEwAr1t7UNo9lS7uBmjFXOT89kPSdkdQ9Shg2nsDJWt4cn0
         R+ICvdlzjQgVcTTiu7a07argnXTp3x9vkruon/XNFZcD+8paaYT3jpAXprYXYT3JDiZ3
         NYPw==
X-Gm-Message-State: ACrzQf2YYBdrA86kuXcE+ToF+z5nvtJVBInn0dMQbSx8StSAQRXayxmi
        kACA8QPhsPX/CCFquDhcNzA=
X-Google-Smtp-Source: AMsMyM6Gtp+Gx7ZNtNrLYnfflrhf/1/oyYT179rItWKq+HgJy3iBjkkaITHwe2jfvKkJFSbg37iQ0g==
X-Received: by 2002:a05:6808:2105:b0:359:e810:e4d3 with SMTP id r5-20020a056808210500b00359e810e4d3mr2201401oiw.194.1667084578283;
        Sat, 29 Oct 2022 16:02:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17-20020a056808029100b0035493cbd9absm916997oic.21.2022.10.29.16.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 16:02:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <086d381d-bc6f-7dd3-35b6-d05afe742b9e@roeck-us.net>
Date:   Sat, 29 Oct 2022 16:02:56 -0700
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
In-Reply-To: <Y12o+Hk2qsIsDQUo@google.com>
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

On 10/29/22 15:28, Dmitry Torokhov wrote:
> On Sat, Oct 29, 2022 at 07:25:51AM -0700, Guenter Roeck wrote:
>> On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
>>> When the data structure is only referred by pointer, compiler may not need
>>> to see the contents of the data type. Thus, we may replace header inclusions
>>> by respective forward declarations.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>   include/linux/input/matrix_keypad.h | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
>>> index 9476768c3b90..b8d8d69eba29 100644
>>> --- a/include/linux/input/matrix_keypad.h
>>> +++ b/include/linux/input/matrix_keypad.h
>>> @@ -3,8 +3,9 @@
>>>   #define _MATRIX_KEYPAD_H
>>>   
>>>   #include <linux/types.h>
>>> -#include <linux/input.h>
>>
>> Possibly, but may other drivers rely on those includes.
>> This results in widespread build failures such as
>>
>> Building arm:allmodconfig ... failed
>> --------------
>> Error log:
>> In file included from include/linux/input/samsung-keypad.h:12,
>>                   from arch/arm/mach-s3c/keypad.h:12,
>>                   from arch/arm/mach-s3c/mach-crag6410.c:57:
>> arch/arm/mach-s3c/mach-crag6410.c:183:19: error: 'KEY_VOLUMEUP' undeclared here
> 
> I fixed this particular instance, hopefully it is one of the very
> last of them...
> 

Sorry, I didn't bother listing all of them. There is at least one more.

Error log:
arch/arm/mach-pxa/spitz.c:410:11: error: 'EV_PWR' undeclared here (not in a function)
   410 |   .type = EV_PWR,
       |           ^~~~~~

with arm:pxa_defconfig.

Guenter

