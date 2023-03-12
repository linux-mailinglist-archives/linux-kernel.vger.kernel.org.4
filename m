Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CFD6B66DA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCLNoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCLNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:44:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6E0298F2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:43:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay8so1011271wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678628632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdTS0oXcqOPShopOCv9dsbnq2ZuDXh8kuvCrXKP9vNg=;
        b=PwlIKtLggba+ofgRaiD/18TchGLzFtem23w7SepKAbL9dwz7sZIiu1CpcK1k0f8RyO
         RxlVw2boDEGQUljuvYbVlw8AOkjoJp6BoqI2ztd5YBojuDTnhHlUu8XcMbTgejUZt3xc
         p6fnB/1B63Fri+hrMd2h0Iy9xVRk7PRlZ6OK3/LGVh+PLmST/T8Cn29YDUQRymgtOeSL
         EG+RgaPUE6G7zUrrNOeR+ktAqBG3k/7SORL8W/LIfgtn1A20E+UmY7Avg8ltWCOoWspW
         6xnKsxxF0Op4iv941dSFEJt2tcyf0d8t9L+MpK4oxWiooMDclBtVPqkcW58aXrFPEkql
         szUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdTS0oXcqOPShopOCv9dsbnq2ZuDXh8kuvCrXKP9vNg=;
        b=x8ISf6Z2iBojkm4ODnugPiYN0MrjeaGxK1ldUxg2F/FzvG1x/yIx52yyoVsMmlDWS9
         FW2A0l/meSGRQgQzg/dFSzHeM7cDAV7ZP0ksa44xrSGWoQzifdAZZ/+4phk1ZMIB/Z+I
         AmJ+QpPJFk1UkDV0Y/HzprtnPhwhsFA1ydjzfeATGa0VtrDbqdcFrYB+rCT1bSkCziX1
         cEP5Tq+aXDT6jVoatXtAVlp+CFcGwe0ktpRtDwFbpK/zF1vTkJJNVbX1RPjT3oWhvaJk
         qxAMeNFXeOIvr/nLhRmtoTlgLucUPqv4JzBzy7Y/07TjgTp/x0jBg+4lNTAtypaTk7IG
         u5WQ==
X-Gm-Message-State: AO0yUKU04aggX9HTjQNfaAuknBcVgPkgp73/2njZBMMVvNVMd+cSvQbw
        b2CCD3fwxATGgSb48M/yzLs=
X-Google-Smtp-Source: AK7set/kMMY5aSTbCT8WnZwJTg7gtojOqzvxlmr7YrgwkOG0dQTnJA13ODG3EYY1AHeDmJPKSbYQXA==
X-Received: by 2002:a05:600c:4e90:b0:3df:fcbd:3159 with SMTP id f16-20020a05600c4e9000b003dffcbd3159mr6059972wmq.3.1678628631752;
        Sun, 12 Mar 2023 06:43:51 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c4fc100b003e2096da239sm6615732wmq.7.2023.03.12.06.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:43:51 -0700 (PDT)
Message-ID: <f6e87327-856d-7bfe-bbc8-65ac490a2868@gmail.com>
Date:   Sun, 12 Mar 2023 15:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, outreachy@lists.linux.dev
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
 <e34f96c7-eee0-6dd6-7662-ffbf04034e27@ieee.org>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <e34f96c7-eee0-6dd6-7662-ffbf04034e27@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١١‏/٣‏/٢٠٢٣ ٢١:١٠, Alex Elder wrote:
> On 3/11/23 7:59 AM, Menna Mahmoud wrote:
>> " ERROR: Macros with multiple statements should be enclosed in a do -
>> while loop"
>>
>> Reported by checkpath.
>
> This is also not an issue that should be "fixed."
>
> If you look at where that macro is expanded, you see
> that its purpose is simply to reduce the possibility
> of some errors by enclosing some much-duplicated code
> in this macro.  The expansion is at the top level of
> the source file, so a "do...while" loop ends up being
> an error.
>
> When looking at the output of checkpatch, assume it's
> giving you clues about problems that one *might* like to
> fix.  Its suggestions are most often reasonable, but in
> some cases (like this one) it's just not smart enough
> to recognize the problem that comes from following its
> advice.
>
> Make sure you understand exactly what happens when
> you make a change.  That means understanding the
> code, and then it means ensuring that the fix passes
> at least a compile test, and if possible an actual
> execution test.
>
>                     -Alex


I see, Thanks Alex for explaining. I will check the code before making 
any change.

Menna


>
>>
>> do loop with the conditional expression set to a constant
>> value of zero (0).This creates a loop that
>> will execute exactly one time.This is a coding idiom that
>> allows a multi-line macro to be used anywhere
>> that a single statement can be used.
>>
>> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
>> fix checkpath error
>>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/loopback.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/loopback.c 
>> b/drivers/staging/greybus/loopback.c
>> index 1a61fce98056..e86d50638cb5 100644
>> --- a/drivers/staging/greybus/loopback.c
>> +++ b/drivers/staging/greybus/loopback.c
>> @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device 
>> *dev,        \
>>   }                                    \
>>   static DEVICE_ATTR_RO(name##_avg)
>>   -#define gb_loopback_stats_attrs(field)                \
>> -    gb_loopback_ro_stats_attr(field, min, u);        \
>> -    gb_loopback_ro_stats_attr(field, max, u);        \
>> -    gb_loopback_ro_avg_attr(field)
>> +#define gb_loopback_stats_attrs(field)                    \
>> +    do { \
>> +        gb_loopback_ro_stats_attr(field, min, u);        \
>> +        gb_loopback_ro_stats_attr(field, max, u);        \
>> +        gb_loopback_ro_avg_attr(field);                \
>> +    } while (0)
>>     #define gb_loopback_attr(field, type)                    \
>>   static ssize_t field##_show(struct device *dev, \
>
