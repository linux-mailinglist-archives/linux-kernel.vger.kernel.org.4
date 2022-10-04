Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849A5F478B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJDQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJDQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:27:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861213E15
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:27:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso1123304wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=giKaBYNrI5DkDrXYEmrl/g92dNRxGEtIM/YpXaYrn04=;
        b=Zjf4+W9cB4uVXbRQrtQciwmV5lLuWUmpsqHh1KucRHpCnjb9Q38z8nTFouDgTTsAoS
         Qmwcqk0DcDhxZJvJ3SnKqvo5/fcBWf8wCUJ4qV9cRJGxfYXjhPEZvPo1/QNbF9hIx0kg
         IdwBdgZs2OPLuHzPdqq7OQ7DJTVP6Yuh6T72P6QVBOIEqPh5kD1bWXC07/RHDSybF1Cf
         wkW3SuHD00hduF94kvNRptHwCXwL46r9YDfbXzn1+w8qdD9BnO4QveyJKO/GXbkV6Z1E
         tivM6GMZBEGr2fWFdBeJVvbT+PgNDMoNz8QYe4iVNcw+hkMBjJXyhUiksvYPfztDtUW0
         Fkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=giKaBYNrI5DkDrXYEmrl/g92dNRxGEtIM/YpXaYrn04=;
        b=bM+tCohZBRQQBHelTGiZymMOkyITKogNSbgE94Xn5g4aTkmIGnCPwMW86IsNOMh1L3
         gJBj+oHbVRmNauVveqohy3HiIPUEGdOrQwgaHAyrRCss5XI/hyOdR9+EW1EnqRFyxevC
         XltutP+0bpLfIpauQt/v4CBraLyddf3266HHB09DTtVQd5joeggP6XEmbo6kH1bYRuZB
         XGIv8e4X3x4tawOafLCYvnH+RGDuwVrpNIqbg/+eazlZ/jhxkYBHqJ2UD9M2aNrNBSNo
         q3q+bL0JWIz1hnl2Lwbj3pWwurNa1mfHJ9zhSBo/qS3xD6KDERsA5mw29u8TxhEl1hsg
         3TPg==
X-Gm-Message-State: ACrzQf3H0U3BcBQ9cE4SkGyonQjTct9dOC3T1AxkRGgNUcmGsrWUXWZ3
        CIgFpz825WRetssyjHsW0wh8GEAPcGYNhw==
X-Google-Smtp-Source: AMsMyM6FTFEVhKnnu6dOZDb7yoMCZon0DvTeQcnmFvVlUZviM6UyaZiTi5Nn+vE/lFe57fh4famKcg==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id r18-20020a05600c435200b003b484c02006mr392536wme.205.1664900828369;
        Tue, 04 Oct 2022 09:27:08 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id az38-20020a05600c602600b003b4935f04a4sm18745865wmb.5.2022.10.04.09.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 09:27:07 -0700 (PDT)
Message-ID: <42f15689-d1ad-2be8-5fed-8f72d82402dc@linaro.org>
Date:   Tue, 4 Oct 2022 17:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 1/1] Documentation/process: Be more explicit about who
 to mail on patch submission
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
References: <20221004124858.640349-1-bryan.odonoghue@linaro.org>
 <20221004124858.640349-2-bryan.odonoghue@linaro.org>
 <0a154bd0-f380-19ae-00df-5d73c1dc7c8b@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0a154bd0-f380-19ae-00df-5d73c1dc7c8b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 16:17, Akira Yokosawa wrote:
> Hi Bryan,
> 
> I'll be silent on the word choice of "supporter" for the time being. :-)
> 
> On Tue,  4 Oct 2022 13:48:58 +0100, Bryan O'Donoghue wrote:
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
>> supporters. Discussing further on the list the suggestion was made to state
>> that the following are the right addresses to mail:
>>
>> - Maintainers
>> - Supporters
>> - Reviewers
>> - Dedicated lists
>> - LKML as a fallback when there is no dedicated list
>>
>> Add in a two sentences to capture that statement.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   Documentation/process/submitting-patches.rst | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> index be49d8f2601b4..90fda3367a405 100644
>> --- a/Documentation/process/submitting-patches.rst
>> +++ b/Documentation/process/submitting-patches.rst
>> @@ -227,8 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>>   to code that they maintain; look through the MAINTAINERS file and the
>>   source code revision history to see who those maintainers are.  The
>>   script scripts/get_maintainer.pl can be very useful at this step (pass paths to
>> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
>> -maintainer for the subsystem you are working on, Andrew Morton
>> +your patches as arguments to scripts/get_maintainer.pl).  In the output of
>> +get_maintainer.pl the recommendation is to mail every maintainer, supporter,
>> +reviewer and dedicated mailing list. If get_maintainer doesn't indicate a
>> +dedicated mailing list linux-kernel@vger.kernel.org should be included. If you
>> +cannot find a maintainer for the subsystem you are working on, Andrew Morton
>>   (akpm@linux-foundation.org) serves as a maintainer of last resort.
>>   
>>   You should also normally choose at least one mailing list to receive a copy
> 
> Quoting subsequent paragraph:
> 
>    You should also normally choose at least one mailing list to receive a copy
>    of your patch set.  linux-kernel@vger.kernel.org should be used by default
>    for all patches, but the volume on that list has caused a number of
>    developers to tune it out.  Look in the MAINTAINERS file for a
>    subsystem-specific list; your patch will probably get more attention there.
>    Please do not spam unrelated lists, though.
> 
> The paragraph you updated mentions the maintainers (as persons) to
> send patches.
> 
> The subsequent paragraph talks about mailing lists.
> 
> After this patch is applied, they look mostly redundant except for
> an important difference. In your patch, Cc: LKML is recommended only
> when a subsystem-specific list can not be found. In the subsequent
> paragraph, LKML is recommended to be Cc'd by default, in addition
> to subsystem-specific lists. Does my interpretation wrong?

Yes I take your point.

It is probably wiser to drop "dedicated" from the sentence.

> Doesn't the subsequent paragraph (quoted above) work for you?

Not especially. I think it is a super-semantic distinction but, the word 
"normally" implies there is also an abnormal case.

"Always" would be a better world than "normally"

> If it does, you don't need to mention mail lists in your change.
> Otherwise, you also need to tweak/remove the subsequent paragraph.
> 
> Thoughts?

The sentence I'm posting here pertains to the output of 
"get_maintainer". I think there is value in having a concise statement 
to say "take the output of get_maintainer and do X"

I also think having a paragraph that says "you must always send to at 
least one mailing list" is both direct and true.

You are not _required_ to run get_maintainer to submit a patch, it is 
simply _suggested_ so in my view the output of get_maintainer doesn't 
negate the statement that you must mail at least one public mailing list.

---
bod
