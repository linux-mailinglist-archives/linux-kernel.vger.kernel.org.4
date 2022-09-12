Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1974F5B5783
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiILJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiILJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:52:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8D4356E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:52:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o2so11756875lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UdUG+yKbunmSUHpUrUpQumUr8NJANbFJ+3qfbg/TGLM=;
        b=d0k/iJ92r+aZizogd9IL3p1SpN1PHqbWNhw2Yx1sYhqy4eC0dI7Mv+LN6DX9LvWtHo
         EEauSA5eXscGfq/KooyaFvJEihHmdnss2vV6g2ZemFqQfa/i+47yDpTXaO7nuVQmJFKQ
         BB8AgzyIqGoQd5kKJWfG5k6FP5poUlHxOGad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UdUG+yKbunmSUHpUrUpQumUr8NJANbFJ+3qfbg/TGLM=;
        b=npzhflGD0UqBReXCbfySfAW7Mo6FnZC2df/pcpco1+HrmLVKfORUPsXnX2k4l4KZQu
         qw1ROH7VAg3Wp/GrS5mAYXFLmbjXGKlN/txtc6hUS7uOub6AwGxrJ0b9trJDuu96fKTo
         aasjUSqXdHhYUcZCDTPNEeq37Vbz5Fpf8H0Om8RZr9ookqIjFQIhQeMvFohMBvu+Qdm2
         a31uziJ1xHBf8Wv7I3To7PKLTkbMztt9WZtySaG0Av5jYfkoKP92z4tptK5kpEaGI8V+
         2jpZo82aLnb2rtcOW7gUf0/jQjZ5486Do+2qJN9E3ek03NMyB7TI+Nx74pgNewShn+LD
         mKIQ==
X-Gm-Message-State: ACgBeo2/8pGKl+Q43xLc+VGk+2MxDNjoWsbaGovE5BOwRI3UYDgDzL39
        BhezC05itjy8nlt7mT7bhokI56h9tGxYBa/1
X-Google-Smtp-Source: AA6agR7U9h0OvewdJITxdnITOsyqZY9wrYa7udcKyDyu4ypPm6hbH0eHWirAkn2iEaRMIK4QAw6hZQ==
X-Received: by 2002:a05:6512:3c92:b0:499:a1ff:d6f3 with SMTP id h18-20020a0565123c9200b00499a1ffd6f3mr3658215lfv.153.1662976375003;
        Mon, 12 Sep 2022 02:52:55 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f3-20020a05651c02c300b0025fdf1af42asm990353ljo.78.2022.09.12.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 02:52:54 -0700 (PDT)
Message-ID: <579b8532-7687-4620-d146-c8ffbbc14097@rasmusvillemoes.dk>
Date:   Mon, 12 Sep 2022 11:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 3/9] compiler_types.h: Add assert_type to catch type
 mis-match while compiling
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, vitor@massaru.org,
        dlatypov@google.com, ndesaulniers@google.com
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
 <Yx3A16ZElKOeJr0o@alfio.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Yx3A16ZElKOeJr0o@alfio.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2022 13.04, Andi Shyti wrote:
> Hi Gwan-gyeong,
> 
> On Fri, Sep 09, 2022 at 07:59:07PM +0900, Gwan-gyeong Mun wrote:
>> It adds assert_type and assert_typable macros to catch type mis-match while
> 
> /Add/It adds/, please use the imperative form.
> 
>> compiling. The existing typecheck() macro outputs build warnings, but the
>> newly added assert_type() macro uses the _Static_assert() keyword (which is
>> introduced in C11) to generate a build break when the types are different
>> and can be used to detect explicit build errors.
>> Unlike the assert_type() macro, assert_typable() macro allows a constant
>> value as the second argument.
>>
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Nirmoy Das <nirmoy.das@intel.com>
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/compiler_types.h | 39 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index 4f2a819fd60a..19cc125918bb 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -294,6 +294,45 @@ struct ftrace_likely_data {
>>  /* Are two types/vars the same type (ignoring qualifiers)? */
>>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>>  
>> +/**
>> + * assert_type - break compile if the first argument's data type and the second
>> + *               argument's data type are not the same
> 
> I would use /aborts compilation/break compile/
> 
>> + *
> 
> nowhere is written that this extra blank line is not needed, but
> just checking the style in compiler_types.h it is not used.
> 
> I personally like the blank line, but standing to the general
> taste, it should be removed also for keeping a coherent style.
> 
>> + * @t1: data type or variable
>> + * @t2: data type or variable
>> + *
>> + * The first and second arguments can be data types or variables or mixed (the
>> + * first argument is the data type and the second argument is variable or vice
>> + * versa). It determines whether the first argument's data type and the second
>> + * argument's data type are the same while compiling, and it breaks compile if
>> + * the two types are not the same.
>> + * See also assert_typable().
>> + */
>> +#define assert_type(t1, t2) _Static_assert(__same_type(t1, t2))
> 
> In C11 _Static_assert is defined as:
> 
>   _Static_assert ( constant-expression , string-literal ) ;
> 
> While
> 
>   _Static_assert ( constant-expression ) ;
> 
> is defined in C17 along with the previous. I think you should add
> the error message as a 'string-literal'.

See how static_assert() is defined in linux/build_bug.h, and let's avoid
using _Static_assert directly. So this should IMO just be

#define assert_same_type(t1, t2) static_assert(__same_type(t1, t2))

(including the naming of the macro; I don't think "assert_type" is a
good name). No need to add an explicit string literal, the name of the
macro and the constant expression itself are plenty to explain what is
being asserted (with the latter being the reason the string was made
optional).

Rasmus
