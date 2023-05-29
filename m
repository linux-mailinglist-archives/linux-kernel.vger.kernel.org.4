Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA1714993
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjE2MmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjE2MmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:42:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C4EB1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:42:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso1132531a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685364126; x=1687956126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiOdIBLVGKvtg/C9FdawapFJuTlHE4wukHl5zvYnmt0=;
        b=KoZjYFt8IeTHfSyrqPFZSa2kBfiEgm88FaOSQiqyWvo4Du1M1T/UCKv3f7q3Y3fRH9
         0hSlqo/xxtsbeeyuXQDZqE8Wwr39mDSe3UWVmA7ETWldwpSmTnVAYGv3eryTSfx4ONG9
         9rbu/LcPqp8kKiYfb2m/3tYvRQTUtJ1ez2CM/rC+N3BtoLZe1elHiPYEBwMIMVYHZ0e5
         WDh2OFMmp6xR7HE6XqmvWhp6lG9HyovzhiopwIZWbI+40xuRAqUUKdJ4QVEY/O1tv7LU
         6j7ioRADhw/XeL+CsgGCY0YESNewpEpv7kqW93HejJ3QGnuozMRLj2fmCu2m1J1TRtiJ
         uRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685364126; x=1687956126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiOdIBLVGKvtg/C9FdawapFJuTlHE4wukHl5zvYnmt0=;
        b=aVR8f0Zz4RYSGLt49gXYqJvAvQYVmTM8sc5H39rJZLjxZBOl0Umtmfh1ECgDaaqr05
         +hyEw+CeWvsKsTMgmN1xsJDJcnyA92o/1uA3+PtlqkRn+/Q7zCKrtRtBaYAl0NDOeHBq
         XpLrwAAmc1coDRX20TmjI/MDLvLmtPc5dxIp1GzZi/JF9p8UPM2UIWWSHZJP9o6YXFsf
         rN47JT1+YvEG3AjF5eZOFEceRxu5/x1BruLhO0g8HeguO5BNnIuCjbltEWrk1yg78Biz
         ntHCe0aqzeoldzTOrZazBQiYX5Vt+aRJbfk1eVVLnUFNmHYoG9J99hxV2PGvbMJlE551
         tppA==
X-Gm-Message-State: AC+VfDwPG+t07lYWvLhryRhedSowArHIpe6MySgUzG75cmYQSFuGY0aB
        uSf4ktblcQ0GLuVLGnValRRZZVI90fxbq5q0
X-Google-Smtp-Source: ACHHUZ5oKbIWcicO0Um2gUZ+e2poTfUAHet7wZPuLSCWfe9wgyKiSyhvz1qDtwgG5laJtek2WuJYsw==
X-Received: by 2002:a17:90a:2b0a:b0:255:6c22:5ccb with SMTP id x10-20020a17090a2b0a00b002556c225ccbmr9976113pjc.7.1685364126144;
        Mon, 29 May 2023 05:42:06 -0700 (PDT)
Received: from [192.168.50.227] ([116.80.41.155])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090ace0500b00253305f36c4sm3841935pju.18.2023.05.29.05.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 05:42:05 -0700 (PDT)
Message-ID: <6ad8c3c7-a3e0-1a52-5a10-6b535b1ed7d3@gmail.com>
Date:   Mon, 29 May 2023 20:41:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: fix args passed to
 trace_f2fs_lookup_end
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <2bb05623-9438-3b68-6ac8-4294f9676ff6@kernel.org>
 <20230529041337.36741-1-bo.wu@vivo.com>
 <0c15c662-903c-3504-d502-72f0a3b70cbf@kernel.org>
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <0c15c662-903c-3504-d502-72f0a3b70cbf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/29 18:18, Chao Yu wrote:
> On 2023/5/29 12:13, Wu Bo wrote:
>> On Sat, May 27, 2023 at 09:01:41AM +0800, Chao Yu wrote:
>>> On 2023/5/27 1:21, Jaegeuk Kim wrote:
>>>> On 05/24, Wu Bo wrote:
>>>>> The NULL return of 'd_splice_alias' dosen't mean error.
>>>>>
>>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>>> ---
>>>>>    fs/f2fs/namei.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>>> index 77a71276ecb1..e5a3e39ce90c 100644
>>>>> --- a/fs/f2fs/namei.c
>>>>> +++ b/fs/f2fs/namei.c
>>>>> @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode 
>>>>> *dir, struct dentry *dentry,
>>>>>    #endif
>>>>>        new = c(inode, dentry);
>>>>>        err = PTR_ERR_OR_ZERO(new);
>>>>> -    trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>>>>> +    trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
>>>>
>>>> Shouldn't give an error pointer to the dentry field.
>>>>
>>>> How about just giving the err?
>>>>
>>>> -       err = PTR_ERR_OR_ZERO(new);
>>>> -       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
>>>> +       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));
>>>
>>> static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
>>> {
>>>     if (IS_ERR(ptr))
>>>         return PTR_ERR(ptr);
>>>     else
>>>         return 0;
>>> }
>>>
>>> For below two cases, PTR_ERR_OR_ZERO(new) will return zero:
>>> a) f2fs_lookup found existed dentry
>>> b) f2fs_lookup didn't find existed dentry (-ENOENT case)
>>>
>>> So in below commit, I passed -ENOENT to tracepoint for case b), so 
>>> we can
>>> distinguish result of f2fs_lookup in tracepoint, actually, -ENOENT 
>>> is expected
>>> value when we create a new file/directory.
>>>
>>> Commit 84597b1f9b05 ("f2fs: fix wrong value of tracepoint parameter")
>> I can see this commit is try to distinguish the dentry not existed case.
>> But a normal case which dentry is exactly found will also go through
>> 'd_splice_alias', and its return is also NULL. This makes the 
>> tracepoint always
>> print 'err:-2' like the following:
>>        ls-11676   [004] .... 329281.943118: f2fs_lookup_end: dev = 
>> (254,39), pino = 4451, name:Alarms, ino:7093, err:-2
>>        ls-11676   [004] .... 329281.943145: f2fs_lookup_end: dev = 
>> (254,39), pino = 4451, name:Notifications, ino:7094, err:-2
>>        ls-11676   [004] .... 329281.943172: f2fs_lookup_end: dev = 
>> (254,39), pino = 4451, name:Pictures, ino:7095, err:-2
>> Even these lookup are acctually successful, this is a bit strange.
>
> Ah, I misunderstand return value's meaning of .lookup.
>
> So, how about this? it only update err if d_splice_alias() returns a 
> negative
> value?
>
> if (IS_ERR(new))
>     err = PTR_ERR(new);
> trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
>
> Thanks,
>
Yes, this will be better.

>>>
>>>>
>>>>
>>>>>        return new;
>>>>>    out_iput:
>>>>>        iput(inode);
>>>>> -- 
>>>>> 2.35.3
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
