Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CFC6B5D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCKOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:54:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BAA256
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:54:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so5204811wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678546474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmHWUjlzHy2uq6jgsY9kZteuN3pTbKb2ImH/1jCF6eQ=;
        b=LuURsCpZIINQtFwtZK+glZ+15xCNMYJZRgAuwTxksczmt7cTvU0Q7IQJ5rCUBix3qT
         uOva/zkx6kJEyeX+pAzSc2sSERls0OLmfnyrgkgiy0oXQUYuVovxkbjOZxxGoya9I8rj
         5fSm+sCSkkvDO4uSluV35M9l+PQ6IMKlx/c3b5anbcrgU28SvJIbrxpUx5xW6KXNFWRv
         eabrNhI1as/QJcZu0QUL8EkTQxbaj8zoLbW+YGpzxy6iaQdMoQTVJktKt3lIaS9pWnTz
         5UE7FxZRiojOT2jbPtgYjWUaCB75M/mkYrcm6P2p9FgDWT7W3a7j22djkiDJZ2Jenyab
         l1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678546474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmHWUjlzHy2uq6jgsY9kZteuN3pTbKb2ImH/1jCF6eQ=;
        b=ROdASMkA2imhoqSlX8HopYg32uKrlK4ASigneSMdkkaZoGwY0vDP9AH+AXPC2nXTgE
         YHDHDDjTPeGnHcH7d+fS0I4pNX66HcFxAx20NIij71/BYZhQzWThU56E9BAh9PbKIAGL
         p1NIsM3CPnCpum7fWG1LqgPB8TnMTOAoLa9feJ36PQZeVzApDVo5KeGqnUYlVvZtByxS
         vZc4KK4k+BCcx61lK6N1QkKBXDS9LpYAi06dUdhOR/+drFGE1FzrGOs8EDI83ldXCMPP
         3GtTuY8mItj/dDnN3CYYqLH/IwxShpVIc86BvZTIsQVyOBDuLGUqhbgGFbwiOCfMgxXB
         132A==
X-Gm-Message-State: AO0yUKVxXCraLmDd3OfJzN84UTDz1hA7j0B4twylzgs+JtN+eCbF+IJ2
        W/e5ezT5YQHEZ2Xijj6t5es=
X-Google-Smtp-Source: AK7set90czPe22mXRrMADvmQVUGpzqxCAePGoxPQnobgXgkhJKiobmxLyCSsg/wO+NYFohLbFNaELg==
X-Received: by 2002:a05:600c:19d3:b0:3eb:5d17:8ddc with SMTP id u19-20020a05600c19d300b003eb5d178ddcmr5991322wmq.18.1678546474349;
        Sat, 11 Mar 2023 06:54:34 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003eb2e33f327sm4017105wmo.2.2023.03.11.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:54:33 -0800 (PST)
Message-ID: <7a2a8cb7-7e4b-9cef-7fea-1e3ece48194b@gmail.com>
Date:   Sat, 11 Mar 2023 16:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303111532220.2802@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303111532220.2802@hadrien>
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


On ١١‏/٣‏/٢٠٢٣ ١٦:٣٦, Julia Lawall wrote:
> Menna,
>
> There is a typo in the subject line.
>
> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>
>> " ERROR: Macros with multiple statements should be enclosed in a do -
>> while loop"
>>
>> Reported by checkpath.
>>
>> do loop with the conditional expression set to a constant
>> value of zero (0).This creates a loop that
>> will execute exactly one time.This is a coding idiom that
>> allows a multi-line macro to be used anywhere
>> that a single statement can be used.
>>
>> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
>> fix checkpath error
> The log message should focus on what is done and why.  The checkpatch
> warning text and the fact that the problem was detected using checkpatch
> is useful, but less, so it should come last, not first.
>
> Here, what is done is to enclose a sequence of statements in a macro
> definition in a do-while loop with a test expression 0.
>
> The reason why is to make it safe to use the sequence anywhere a single
> statement can be used.
>
> A period at the end of a sentence should be followed by some whitespace
> before starting the next sentence.
>
> julia


got it, thank you.


Menna

>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/loopback.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
>> index 1a61fce98056..e86d50638cb5 100644
>> --- a/drivers/staging/greybus/loopback.c
>> +++ b/drivers/staging/greybus/loopback.c
>> @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
>>   }									\
>>   static DEVICE_ATTR_RO(name##_avg)
>>
>> -#define gb_loopback_stats_attrs(field)				\
>> -	gb_loopback_ro_stats_attr(field, min, u);		\
>> -	gb_loopback_ro_stats_attr(field, max, u);		\
>> -	gb_loopback_ro_avg_attr(field)
>> +#define gb_loopback_stats_attrs(field)					\
>> +	do { \
>> +		gb_loopback_ro_stats_attr(field, min, u);		\
>> +		gb_loopback_ro_stats_attr(field, max, u);		\
>> +		gb_loopback_ro_avg_attr(field);				\
>> +	} while (0)
>>
>>   #define gb_loopback_attr(field, type)					\
>>   static ssize_t field##_show(struct device *dev,				\
>> --
>> 2.34.1
>>
>>
>>
