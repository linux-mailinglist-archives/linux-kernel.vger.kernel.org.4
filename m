Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4015F0FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiI3QTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiI3QS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:18:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110D1C9360
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:18:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so7605754wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I8BWwdhYEn7/qIlbcvOOkF/y7TGYQLT8oEQk9gkHecU=;
        b=waOwZCLgdPug3puEvaaVQU3ajMPlViy8hgN8321+/oHVEauxuhhZ89DXsCfPDZNYcG
         NQ3OefSydOpobJkm9HKe8vYIXTKeBQ1mmRYVX2zT+bOL0HeF5C4k5X8EzR9lCoDZCm0/
         Lv8j7hz/YWmGHN9WxGoYSIZK2gJYZBVy/TOTYoDcY2eueKx5vaDySkbddxy9uorS1vkv
         4tAG/2eQxyNvUaqjzaU6+VyhO9UXbP0d0YVpTZvKt50HlqnsUxWlb9g4NgyU8+/GtsjT
         eVl1rGTLjTReh5dmSDbHkRzvb+77xRoQeLg3EN39Py81YaV8V4bjeAELh3vmzVlWsU2j
         juMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I8BWwdhYEn7/qIlbcvOOkF/y7TGYQLT8oEQk9gkHecU=;
        b=MOExGTnbWa8cPYzOlAO19vVykDHzl8o+qQnWZg4ZR4L9TQr83NKah/2PgpiKabuhiU
         6oi1lAt8UGCHdhwcoPvDNUAqmR22ubzxmSxB24WJrm/UlGBzukb5ovFV6Q9ov0TOK5Yx
         Hdf+O0EQZQ+iSZqIh9FGE9RbKRbA2hBUm1xB3V56w/XnNg3VdEGf2aUP7etn9qTkmZLX
         5hlwGpOm6H2Ccme40zVkhA2A0/XvvO5r2Rw754tyKjDcHpOm18wuP7knAYUPLDoNbP56
         gBXNeShudyAw599htmPs1rdNqEZSfPMDFd7+psTp0s0ynWQvesat9JTgSk2xe3y3bBjA
         a0Vw==
X-Gm-Message-State: ACrzQf241QYXeMp+x4XRjVP9lm8+rqIJ4AExlx1oAq72VlX9WSYTS8WK
        lo8ZsMiodH2yJNg5fiVhiRKh8g==
X-Google-Smtp-Source: AMsMyM42t4IWxaxMuF3HUBf7zS3n9w3vLxiKs4HtcZaHRzU1occTqTXgVB4VqXKZWxINnB3cxUgl/g==
X-Received: by 2002:a5d:6508:0:b0:22e:1af4:57f9 with SMTP id x8-20020a5d6508000000b0022e1af457f9mr495775wru.539.1664554734861;
        Fri, 30 Sep 2022 09:18:54 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bc8ce000000b003a541d893desm2375443wml.38.2022.09.30.09.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:18:53 -0700 (PDT)
Message-ID: <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
Date:   Fri, 30 Sep 2022 17:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, tytso@mit.edu
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 15:47, Akira Yokosawa wrote:
> Hi,
> 
> On Fri, 30 Sep 2022 07:46:29 +0100, Bryan O'Donoghue wrote:
>> Recently when submitting a yaml change I found that I had omitted the
>> maintainer whose tree the change needed to go through.
>>
>> The reason for that is the path in MAINTAINERS is marked as Supported not
>> Maintained. Reading MAINTAINERS we see quote:
>>
>>             Supported:   Someone is actually paid to look after this.
>>             Maintained:  Someone actually looks after it.
>>
>> The current submitting-patches.rst only says to mail maintainers though not
>> supporters. When we run scripts/get_maintainer.pl anybody who is denoted a
>> paid maintainer will appear as a supporter.
> 
> So the root cause of your confusion was you couldn't figure out
> the fact that "supporter" in the output of get_maintainver.pl means
> "maintainer of a supported subsystem", wasn't it?
> 
> I guess all you need would be just a short notice along the lines of:
> 
>      "supporter" in the output from get_maintainer.pl means "maintainer
>      of a supported subsystem".
> 
> No?

We discussed that a bit earlier.

https://lore.kernel.org/lkml/20220928003006.230103-1-bryan.odonoghue@linaro.org/T/#u
https://lkml.org/lkml/2022/9/28/1394
https://lkml.org/lkml/2022/9/28/1511
https://lkml.org/lkml/2022/9/29/188

I think its fair to say the consensus so far is to leave the 
get_maintainer.pl output as is.

>>
>> Add text to state that every mail address returned by get_maintainer.pl
>> --nogit-fallback should be included when submitting a patch, giving an
>> example of the same.>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   Documentation/process/submitting-patches.rst | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index be49d8f2601b4..18a1f52e0563a 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -227,9 +227,15 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>>   to code that they maintain; look through the MAINTAINERS file and the
>>   source code revision history to see who those maintainers are.  The
>>   script scripts/get_maintainer.pl can be very useful at this step (pass paths to
>> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
>> -maintainer for the subsystem you are working on, Andrew Morton
>> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
>> +your patches as arguments to scripts/get_maintainer.pl).  You should mail every
>> +email address returned by `scripts/get_maintainer.pl --nogit-fallback` when
>> +submitting a patch.
>> +For example::
>> +
>> +    $ scripts/get_maintainer.pl --nogit-fallback -f submitting-patches.rst
>> +    Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
>> +    linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>> +    linux-kernel@vger.kernel.org (open list)
> 
> This example has a number of issues...
> 
>   1) The command line doesn't work when run under the top of kernel tree.

Well I didn't want to exceed 80 characters but I have no problem make it 
top level explicit

>   2) The -f flag contradicts the instruction above:
>      (pass paths to your *patches* as arguments to scripts/get_maintainer.pl).

I'm not sure I follow how it contradicts but, I will read it again.

>   3) There can be cases where --git-fallback (default) is useful.

Can you elaborate what your thinking is on that. I'm happy to try to 
include it in the instructions we give.

>   4) The output can change any time.

What does this mean ? The output won't change for a given patch you are 
trying to send.

Do you mean the output of get_maintainer.pl can change ?

It could but, how does that negate the value of documenting what it does 
right now ?

>   5) There is no point in using Jon's actual name and email address.

Sure, I see your point. I'll use a fake email.


> Why not just add a short notice I mentioned above as a first step?

Please see above.

---
bod
