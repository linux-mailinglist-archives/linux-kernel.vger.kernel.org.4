Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF73718F16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjEaXlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:41:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BB312C;
        Wed, 31 May 2023 16:41:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b015c0508so14996185a.1;
        Wed, 31 May 2023 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685576495; x=1688168495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqUEtiNzQPXNnkJHbjcbvl93ewqKl8vCNCXtX2f/UHQ=;
        b=ZLaL5XjurHw1cP3P7ti1sffNrHCPnfESWQZx0KOpSQDptVtHfkjjBUDMrP4gg+8+TF
         z5NMUxwcsLv4TLrFYHb2eMTiL/Mb7grVYdEPZNJCJtxY/a0s3YXtX+FnqZQM+xu77B7y
         LtCLAdI7kRiqjgNkEpnSEtRticOpT0TRSsuGKjgIt8Xp+3tYK2TCzqia5H2/uFfC2TO0
         79uQOMnMhoKXd03scxrb6w5Pj3xHwDkYWGhS036AnmpkBukIWG20aVo3ywtoDVUvLsai
         s2D2FnAUV3JHL9ouOeSn774K57PdODyYfF/ElT7oHIbrAyJE+ChgubqWADRgU5EZACaE
         dL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576495; x=1688168495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUEtiNzQPXNnkJHbjcbvl93ewqKl8vCNCXtX2f/UHQ=;
        b=K7rjONGBjOoApYBthuPVKH6GQ4Mf9xEq1GIqfH5ZsyQtP3jKxYF5of60qJAWD2zRsy
         03NbKAfwsTC9hROy4tnzhLULCYtLHe/IU74S4E1+5GKyN63UYwkmVNn2ECTYuJLyr09f
         JoGlfc+091ovrYbNVDM3PrkjAnZSBQHxEqOTRyihoAI3o2a9T0t5s8se9UAdZuwUls36
         Tb3XZifQlBqNVbjU2hKlQfQXQxLFAXXXgwXyxf89F82PCb/aEaeXjUFjZBA62SA0ry2L
         blZQ6nqjoaV6UVdFMtE0lqSkUb7IBp0P2YFdvkhW6t9H9MxnaLTVNX9Q42kxnUbtfBQr
         UbcQ==
X-Gm-Message-State: AC+VfDxdVkyODFZopZKPSZSGI4gcWKo4uwc97KwyOgTCpBfDYTUMJQqC
        tiAFp7I0om6Lm7hrZvwot9jp9TVxV90=
X-Google-Smtp-Source: ACHHUZ4lxos4CGogbmpqC3mvvEHI5DbKkQbCUcIpboNTgLki4Pm7TJVmF2SfIUB9pGAWmyik/X+wJQ==
X-Received: by 2002:a05:620a:2489:b0:75b:23a1:3687 with SMTP id i9-20020a05620a248900b0075b23a13687mr9092920qkn.72.1685576494910;
        Wed, 31 May 2023 16:41:34 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f4-20020aa78b04000000b0063d2cd02d69sm3853710pfd.54.2023.05.31.16.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 16:41:33 -0700 (PDT)
Message-ID: <fd7b559e-7694-ef92-529d-4663df9c1cbc@gmail.com>
Date:   Thu, 1 Jun 2023 08:41:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, paulmck@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
 <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
 <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
 <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
 <ZHXvT86FN/7lx/fv@FVFF77S0Q05N>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ZHXvT86FN/7lx/fv@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Keeping documentation folks in CC]

On 2023/05/30 21:42, Mark Rutland wrote:
> Hi Akira,
> 
> On Fri, May 26, 2023 at 07:27:56PM +0900, Akira Yokosawa wrote:
>> I think adding "~" to the substitution pattern added in [1] as follows
>> should do the trick (not well tested):
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 2486689ffc7b..eb70c1fd4e86 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -64,7 +64,7 @@ my $type_constant = '\b``([^\`]+)``\b';
>>  my $type_constant2 = '\%([-_\w]+)';
>>  my $type_func = '(\w+)\(\)';
>>  my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>> -my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>> +my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>>  my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
>>  my $type_env = '(\$\w+)';
> 
> Are you happy to send this as a patch?

I'm afraid I am not at the moment.

The reason being I have never made changes in that 2500 line perl
script.  Please consider the change above as a random suggestion from
someone who don't/can't understand the script fully ...
> 
> I'd like to pick it into this series, so if you're happy to provide your
> Signed-off-by tag here, I'm happy to go write the commit message and so on.

I you happen to know perl well and be confident the change won't have
any side effect, I wouldn't mind if you go forward and make a patch
on your own, maybe with my Suggested-by.  That patch should also have
explicit Cc: tags to Jon and Mauro who are in the SOB chain of commit
ee2aa7590398.

        Thanks, Akira

> 
> Thanks,
> Mark.
> 
>>
>> Thoughts?
>>
>>         Thanks, Akira
>>
>>>
>>>
>>>> [1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")
>>>
>>> thanks.
