Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603F7192F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjFAGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFAGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:06:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E969F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:05:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b0201d9a9eso4302105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685599539; x=1688191539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/lIb62bgMbP4e/zPofOhlyDZgPMCQyADbXeoDyIi8c=;
        b=PArR2lh/P5dohb7UE2FbUsB3+ndYM7MuICjFy8EwJHT4xmxq0NT0tUeoWw55dEYljQ
         RSpE3F6tcdpjLkxfvR6ntwrMG2t0engCXMTJOquLUXDRvFm0m2Jpdug4ZFluDM4LbLzx
         sbw3XfV7aMJNJUtmulpu8XiSavIWbjTc1Cw8Sum+LDebH6P9amcP7zMmqoYfNlQBq6Kg
         44u8IeUv8Z6jY9RpKLKS0sbN6FI9YLATE/oMA56RnWDEDENk0r8pdOrppiUHSRhHM2Kg
         e5ZASUuTz5NP20mQ4WX+xuzdycbmqqKJ5BwIhzIn/xwORIn/RTOfx+ocsLlin+Xa/Ebj
         L8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599539; x=1688191539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/lIb62bgMbP4e/zPofOhlyDZgPMCQyADbXeoDyIi8c=;
        b=jDx+1pPVg43pvToGA89zpgIwOjDHW9orNVYwNrGDRAQDq0L1ochRJEV5NCQ9iQ3sXJ
         QlCE/xCCjtqMt36+wCSKlp4wZueyKMsVSjsukyWXp/TdiZ6mCt8MCL7WLZn5SwT1QDnp
         F87v2ffgjm1QKFS/P/NZj6c+h3FzbNMsM3ZP1ihbOIHPr8GNUFF6NlpqjBeKj1CN4nKA
         UlvWLInFOHUIdLpGUaEiv4kCpsKJnhZHumDgzdbBnBqXkGbN0Q5Fq8YmSMsIbz3UuZUq
         OPmHIrlWXhuuLresDMUnxuNV7KHnUVFBykvFbgCN0zCracGI35nJsqcaEosRiSlshsRq
         ruHg==
X-Gm-Message-State: AC+VfDyp9SeO0GJDdZTpcA8m3Uii0MTCZgBdmo2DxzemYB3HvIHDea6j
        TQWQCSiKMzO11pGh5YIjSjAf+/S6eIxnJpd2Fxg=
X-Google-Smtp-Source: ACHHUZ7S9UnbjFCAvnVC5VyrHgbmzTHAaJsUa6kpXQdgHvzEPnQM9gBYarxQfF8/hH/dcocIPnJQWQ==
X-Received: by 2002:a17:903:2447:b0:1af:ac49:e048 with SMTP id l7-20020a170903244700b001afac49e048mr1049198pls.25.1685599538890;
        Wed, 31 May 2023 23:05:38 -0700 (PDT)
Received: from [10.71.57.173] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001ac84f5559csm2464746plg.126.2023.05.31.23.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:05:38 -0700 (PDT)
Message-ID: <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
Date:   Thu, 1 Jun 2023 14:05:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/6/1 13:37, Martin KaFai Lau 写道:
> On 5/31/23 7:49 PM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Remove the judgment on retval and pass bpf ctx by default. The
>> advantage of this is that it is more flexible. Bpf getsockopt can
>> support the new optname without using the module to call the
>> nf_register_sockopt to register.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 5b2741aa0d9b..ebad5442d8bb 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct 
>> sock *sk, int level,
>>       if (max_optlen < 0)
>>           return max_optlen;
>> -    if (!retval) {
>> -        /* If kernel getsockopt finished successfully,
>> -         * copy whatever was returned to the user back
>> -         * into our temporary buffer. Set optlen to the
>> -         * one that kernel returned as well to let
>> -         * BPF programs inspect the value.
>> -         */
>> -
>> -        if (get_user(ctx.optlen, optlen)) {
>> -            ret = -EFAULT;
>> -            goto out;
>> -        }
>> +    if (get_user(ctx.optlen, optlen)) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> -        if (ctx.optlen < 0) {
>> -            ret = -EFAULT;
>> -            goto out;
>> -        }
>> -        orig_optlen = ctx.optlen;
>> +    if (ctx.optlen < 0) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> +    orig_optlen = ctx.optlen;
>> -        if (copy_from_user(ctx.optval, optval,
>> -                   min(ctx.optlen, max_optlen)) != 0) {
>> -            ret = -EFAULT;
>> -            goto out;
>> -        }
>> +    if (copy_from_user(ctx.optval, optval,
>> +                min(ctx.optlen, max_optlen)) != 0) {
> What is in optval that is useful to copy from if the kernel didn't 
> handle the optname?

For example, if the user customizes a new optname, it will not be 
processed if the kernel does not support it. Then the data stored in 
optval is the data put by the user. If this part can be seen by bpf 
prog, the user can implement processing logic of the custom optname 
through bpf prog.

> 
> and there is no selftest also.
> 

Yes, if remove this restriction, everyone thinks it's ok, I'll add it in 
the next version.

>> +        ret = -EFAULT;
>> +        goto out;
>>       }
>>       lock_sock(sk);
> 

