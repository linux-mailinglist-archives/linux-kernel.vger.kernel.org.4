Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C064A64B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiLLRxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiLLRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:52:38 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068F1409E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:52:35 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y3so2171676ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbdQlONAF3F5tE8sTJVSPYNxwq82LlNJlRxKJhZeRSk=;
        b=BVjhFVJE0GkqiD0W9BupRfp+/6CtfFOAEvalRIwgyds/szdM7Ho1LGyPQuKZ+1RHxs
         xvc8lZmdLKuqEltla0cZ6e+RVJexsbM91uSHVZngnkLsThW6u6CAD45fS8RA9cXtgdam
         gWDr/YasFT90pBuaJqoE1QT1i9JCQWBrYaVNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbdQlONAF3F5tE8sTJVSPYNxwq82LlNJlRxKJhZeRSk=;
        b=pLQMKu+AHQIZmFIhlv+B7XmxGvZOp/hA+IHKbmn0FcWu0RzKkBGWDmIDEyKmUK2Xlg
         B+mKlqZvSYHTfjso8hfpMxipMMv8G0YIHzVm/4/FnSWain1Z93/Dl3bADI9wzTU0n4Su
         e5ozX8ZARL6rWAusdSResYOtVQyuD8LGcqOtnXyK46LPCOFFx8VfuKUVtTuVjzf0Kppe
         jhyFa/PJDntya3YjLKBM0RxfYJqSXXoWevzOLRFQSKAyAZ+mFVj8iEig8HlU1Ub1hall
         c2Rnk/GC4zV7ozDQPK29wqvatjAX6iuqT7zl9P5ik7GE/UGP5QMAHPP+0F7dmUV7OBkO
         X+XA==
X-Gm-Message-State: ANoB5pmAqr+j8KXEhY3xPzpb2XAtq4R4XpVH2TAX8zHQrPbSimdiSrpI
        Q1lbfk5e2agmXTOT5elEzEShvw==
X-Google-Smtp-Source: AA0mqf4yUaDhjfDRh3Hs4pGOieTP1vSSnFf1NDSsDJvQ6BDUPpd2JcPOpWioDhZqNBPoatf4gHtNtQ==
X-Received: by 2002:a05:6e02:1a27:b0:304:b2dc:4274 with SMTP id g7-20020a056e021a2700b00304b2dc4274mr1102837ile.3.1670867555255;
        Mon, 12 Dec 2022 09:52:35 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n23-20020a027157000000b003712c881d67sm108802jaf.164.2022.12.12.09.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 09:52:34 -0800 (PST)
Message-ID: <8e82905f-8bdf-05de-2e6a-d8b896d75910@linuxfoundation.org>
Date:   Mon, 12 Dec 2022 10:52:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221208135327.01364529@canb.auug.org.au>
 <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 12/8/22 13:10, John Johansen wrote:
> On 12/7/22 18:53, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>
>>    security/apparmor/policy_unpack.c
>>
>> between commits:
>>
>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
>> (and probably others)
>>
>> from the apparmor tree and commit:
>>
>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>
>> from the kunit-next tree.
>>
>> This is somewhat of a mess ... pity there is not a shared branch (or
>> better routing if the patches).
>>
> sorry, there was a miscommunication/misunderstanding, probably all on me, I
> thought the kunit stuff that is conflicting here was going to merge next
> cycle.
> 

Sorry for not noticing David isn't on the cc - added David now. What's the
best way to resolve this?

>> I fixed it up (hopefully - see below) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>>
>> I also had to add this patch:
>>
> this needs to be modified to build if kunit is not enabled, basically
> the defines need to move up outside the #if IS_ENABLED(CONFIG_KUNIT)
> 
> ie.
> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
> index 8fdf8f703bd0..dcf7d1bbf96b 100644
> --- a/security/apparmor/include/policy_unpack.h
> +++ b/security/apparmor/include/policy_unpack.h
> @@ -165,6 +165,11 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
>           kref_put(&data->count, aa_loaddata_kref);
>   }
> 
> +#define tri int
> +#define TRI_TRUE 1
> +#define TRI_NONE 0
> +#define TRI_FALSE -1
> +
>   #if IS_ENABLED(CONFIG_KUNIT)
>   bool aa_inbounds(struct aa_ext *e, size_t size);
>   size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk);
> @@ -173,11 +178,6 @@ bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
>   bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
>   bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
> 
> -#define tri int
> -#define TRI_TRUE 1
> -#define TRI_NONE 0
> -#define TRI_FALSE -1
> -
>   tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
>   size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
>   int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
> 
> 
> feel free to apply that to your patch and then add my
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Thu, 8 Dec 2022 13:47:43 +1100
>> Subject: [PATCH] fixup for "apparmor: make unpack_array return a trianary value"
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>   security/apparmor/include/policy_unpack.h | 8 +++++++-
>>   security/apparmor/policy_unpack.c         | 5 -----
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
>> index 940da8a33e0c..8fdf8f703bd0 100644
>> --- a/security/apparmor/include/policy_unpack.h
>> +++ b/security/apparmor/include/policy_unpack.h
>> @@ -172,7 +172,13 @@ bool aa_unpack_X(struct aa_ext *e, enum aa_code code);
>>   bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
>>   bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
>>   bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
>> -size_t aa_unpack_array(struct aa_ext *e, const char *name);
>> +
>> +#define tri int
>> +#define TRI_TRUE 1
>> +#define TRI_NONE 0
>> +#define TRI_FALSE -1
>> +
>> +tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
>>   size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
>>   int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
>>   int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name);
>> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
>> index 6513545dad5e..173d832fc4ee 100644
>> --- a/security/apparmor/policy_unpack.c
>> +++ b/security/apparmor/policy_unpack.c
>> @@ -30,11 +30,6 @@
>>   #include "include/policy_unpack.h"
>>   #include "include/policy_compat.h"
>> -#define tri int
>> -#define TRI_TRUE 1
>> -#define TRI_NONE 0
>> -#define TRI_FALSE -1
>> -
>>   /* audit callback for unpack fields */
>>   static void audit_cb(struct audit_buffer *ab, void *va)
>>   {
> 

thanks,
-- Shuah
