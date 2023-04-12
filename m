Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C056E0083
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDLVKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:10:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921715249
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:09:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xi5so32227199ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1681333798; x=1683925798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/kMT9mr+25HY+RsVOy9xcwPUFiyIdNsJI3BZxlExUE=;
        b=H763iIwxW4lmkk7sCENm5pBjdC5KL8xsC+GYAVjcCkvKd7wCwcYBFh6iKuUn1tbyRd
         kbOBXuqZ3yEtSX2OD6h+V8OVLoYiwdn58wsVD8EcqOJFgEyzBzGudY99gZtNUTmQ1J9H
         HPvbjwc4m4hbTfnDSGB3CA7KjhZ6SwE39TMQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333798; x=1683925798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/kMT9mr+25HY+RsVOy9xcwPUFiyIdNsJI3BZxlExUE=;
        b=Jgk8nzKEOv5/yQy4y5dZ46svi81NhQwtIt4ovmgIuG0kOzXqSJ7q+34/vCkuOgbXJr
         GsXsWA+7D0ehXcHrRNR7mS3WJyrPEmGUPdQadZq1y+qZ+zLeSoqSjbFJvWf8DSA635lq
         fldyUWPaBr8sTwh5MPV1UlYFaUkSMtbghTkqqqRyCUgirGaOFuh1K3FANFiuTUVvmeZS
         FgyTyuQxCojiSDpY1uKqSvDcKqW/Q8SemZAfQCbyiKyHPoyg01dQ8yQiPFuYM/RWgULt
         aWcouXbf8c87kLB2DjAPdqCn5airtVRtxf9fNMkL2qJPn+zTXtgF5+wcQj+6LsH59JJN
         myvA==
X-Gm-Message-State: AAQBX9coulqhPs6XonNKqRic7QRimBDFDIm0YvdQvWo7Wi3FaMt2XmCO
        MayH6eaPSElaIpcfftnnLRwsDlhrD/ouwZ0rCzc=
X-Google-Smtp-Source: AKy350a9oAACjSFYzXlojxbqMxQgaf0qbcPEGU/4kteamkBR1EcRccGhVPXfswVzUWfa1EZzUzzAjA==
X-Received: by 2002:a17:906:d7bc:b0:94a:6625:5971 with SMTP id pk28-20020a170906d7bc00b0094a66255971mr236925ejb.33.1681333798032;
        Wed, 12 Apr 2023 14:09:58 -0700 (PDT)
Received: from [192.168.1.128] ([80.208.70.1])
        by smtp.gmail.com with ESMTPSA id jg21-20020a170907971500b0094a0b64a121sm6100780ejc.45.2023.04.12.14.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:09:57 -0700 (PDT)
Message-ID: <31abaa2d-f93b-e2df-4605-04c276ea7397@rasmusvillemoes.dk>
Date:   Wed, 12 Apr 2023 23:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] kernel.h: Split out COUNT_ARGS() and CONCATENATE()
Content-Language: en-US, da
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230411102454.85898-1-andriy.shevchenko@linux.intel.com>
 <20230411152119.c9bb83a8566e37f6d8dbc590@linux-foundation.org>
 <ZDaqi1jE0Fkg5BSp@smile.fi.intel.com>
 <20230412115531.17bb1aed232952c79aba0f2a@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230412115531.17bb1aed232952c79aba0f2a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 20.55, Andrew Morton wrote:
> On Wed, 12 Apr 2023 15:56:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Tue, Apr 11, 2023 at 03:21:19PM -0700, Andrew Morton wrote:
>>> On Tue, 11 Apr 2023 13:24:54 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>>> kernel.h is being used as a dump for all kinds of stuff for a long time.
>>>> The COUNT_ARGS() and CONCATENATE() macros may be used in some places
>>>> without need of the full kernel.h dependency train with it.
>>>>
>>>> Here is the attempt on cleaning it up by splitting out these macros().
>>>>
>>>> --- a/include/linux/kernel.h
>>>> +++ b/include/linux/kernel.h
>>>> @@ -13,6 +13,7 @@
>>>>  
>>>>  #include <linux/stdarg.h>
>>>>  #include <linux/align.h>
>>>> +#include <linux/args.h>
>>>
>>> A more energetic patch would have included args.h into each file which
>>> calls COUNT_ARGS() and CONCATENATE(), and not included args.h into
>>> kernel.h.  And that appears to be very easy - only bpf uses these things?
>>>
>>> In fact these macros are so weird and ugly I'd be inclined to move them
>>> into some bpf header so we don't have to see them again.  No
>>> args.h, which might avoid encouraging others to use them.
>>
>> We have more users than one 
> 
> I cant find any?

True, git grep COUNT_ARGS doesn't find anything other than the
bpf_probe.h user.

>> and a couple of users that reimplement this macro
>> under different names.
>>
> Where are these?

Amusingly, bpf have at least

tools/lib/bpf/bpf_core_read.h:#define ___narg(...) ___nth(_,
##__VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
tools/lib/bpf/bpf_helpers.h:    ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10,
9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
tools/lib/bpf/bpf_tracing.h:#define ___bpf_narg(...) ___bpf_nth(_,
##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

OK, so that's under tools/, but we really should be able to make a
cpp-tricks-header that's usable by the kernel itself as well as tools.

There's also

include/linux/arm-smccc.h:      ___count_args(__VA_ARGS__, 7, 6, 5, 4,
3, 2, 1, 0)
arch/x86/include/asm/rmwcc.h:#define RMWcc_ARGS(X...) __RMWcc_ARGS(,
##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

and some efi_nargs that seems a little more elaborate (though I doubt
they couldn't just make do with the standard macro).

There's probably even more, this is just what grepping for a typical
implementation showed.

> What the heck does it do

It counts the number of arguments given to a variadic macro.

> and why is it so ugly

Because cpp.

> and why isn't it documented.  Shudder.

Yeah, some comments on how it works and its limitation(s) would probably
be in order.

Rasmus

