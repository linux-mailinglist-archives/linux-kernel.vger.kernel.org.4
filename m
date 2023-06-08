Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72F07275DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjFHDkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFHDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:39:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F2326AB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:39:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f805551a19so981631cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686195569; x=1688787569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvtGe+47bQaQV8brBLmNwnumVany/JnICTxUNCusye0=;
        b=J65mhKmDzbLJbBnIRnqiuaaqadLBTovoBsSmppOCs2lltGkoL+ca38+UuosfJrHo+X
         aum8iksSgOf9WzvZGVp5bzCBnwnYzzIuo+aTxhN+ZdlUTkOZ2JrKD8+DPFULwXEKpWkT
         Cqjp64BwdglaVgMmKeTq2Hal8w1gpzEgW3l/GCS2GS/suK/82V1kjycHKdZR+tpgMf1a
         s1i/+DE2ohpgAeVh/mqcAK1W9ob8CceFBtb2C1hUCvID0BOSkDIqyhgT7LJEmNxHQlzB
         9d5T87S27x4aWfKqovv6ws+buo1N3ntSN59FwEatChjC++Su/ZMrpBNIkMaxdIlOd/9P
         YGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686195569; x=1688787569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvtGe+47bQaQV8brBLmNwnumVany/JnICTxUNCusye0=;
        b=Yzi24vwB4x8cR83tY3S10vmxAb9WajeA1RqtDU8JAhZDTRlNvS3nOcE+5hGCwr9dWT
         3i2LTB5BJYtwEh8DsGs/Hde5Zbw82xs7TjEEqIBYG8EK3yqMen9g3q61WK6oC+AX3utk
         GqgA0OAXLKw4GF5UGoW54+Yj1gRmmpPIfkvT9zM+TzchMjvx0jGbQCQ/3vNMONjyc+BV
         CoEx6G/ubTJ97QCFt/tVhgstixD/VLc2C6bP3cW32VYYZknQr1XZjbiHbumclOQm0xrY
         ZGEUGG8i+lotMoOAYpiwW/NmMcO61WZOwz1gyCfAWtcXvW3VYhPlqCaeeBXCrYVE0f7C
         7+SQ==
X-Gm-Message-State: AC+VfDxxqTfvVQDAD0re63QT3JE6pic00RMI68b3dxJHnCyUOtDkkml1
        OANCgB7FB8HuWrUk6gtHmqUE2A==
X-Google-Smtp-Source: ACHHUZ7/oM6oXW9uifA0GKweKEIcqiKoiqNo1XWxhdtGPeucV6PjfQ1N+nJe2D8iucOwcT/tAcLkzQ==
X-Received: by 2002:ac8:5a11:0:b0:3f6:e3aa:a61f with SMTP id n17-20020ac85a11000000b003f6e3aaa61fmr6035006qta.19.1686195568988;
        Wed, 07 Jun 2023 20:39:28 -0700 (PDT)
Received: from [10.71.57.173] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001affb590696sm236480plg.216.2023.06.07.20.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:39:28 -0700 (PDT)
Message-ID: <c902419b-e265-75ff-1275-338dbfd69cda@bytedance.com>
Date:   Thu, 8 Jun 2023 11:39:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval
 without checking kernel retval
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
 <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
 <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
 <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
 <CAKH8qBtxNuwvawZ3v1-eK0RovPHu5AtYpays29TjxE2s-2RHpQ@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CAKH8qBtxNuwvawZ3v1-eK0RovPHu5AtYpays29TjxE2s-2RHpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/6/7 01:04, Stanislav Fomichev 写道:
> On Mon, Jun 5, 2023 at 8:20 PM Feng Zhou <zhoufeng.zf@bytedance.com> wrote:
>>
>> 在 2023/6/1 23:50, Martin KaFai Lau 写道:
>>> On 5/31/23 11:05 PM, Feng Zhou wrote:
>>>> 在 2023/6/1 13:37, Martin KaFai Lau 写道:
>>>>> On 5/31/23 7:49 PM, Feng zhou wrote:
>>>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>>
>>>>>> Remove the judgment on retval and pass bpf ctx by default. The
>>>>>> advantage of this is that it is more flexible. Bpf getsockopt can
>>>>>> support the new optname without using the module to call the
>>>>>> nf_register_sockopt to register.
>>>>>>
>>>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>> ---
>>>>>>    kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>>>>>    1 file changed, 13 insertions(+), 22 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>>>> index 5b2741aa0d9b..ebad5442d8bb 100644
>>>>>> --- a/kernel/bpf/cgroup.c
>>>>>> +++ b/kernel/bpf/cgroup.c
>>>>>> @@ -1896,30 +1896,21 @@ int
>>>>>> __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>>>>        if (max_optlen < 0)
>>>>>>            return max_optlen;
>>>>>> -    if (!retval) {
>>>>>> -        /* If kernel getsockopt finished successfully,
>>>>>> -         * copy whatever was returned to the user back
>>>>>> -         * into our temporary buffer. Set optlen to the
>>>>>> -         * one that kernel returned as well to let
>>>>>> -         * BPF programs inspect the value.
>>>>>> -         */
>>>>>> -
>>>>>> -        if (get_user(ctx.optlen, optlen)) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> +    if (get_user(ctx.optlen, optlen)) {
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>> +    }
>>>>>> -        if (ctx.optlen < 0) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> -        orig_optlen = ctx.optlen;
>>>>>> +    if (ctx.optlen < 0) {
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>> +    }
>>>>>> +    orig_optlen = ctx.optlen;
>>>>>> -        if (copy_from_user(ctx.optval, optval,
>>>>>> -                   min(ctx.optlen, max_optlen)) != 0) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> +    if (copy_from_user(ctx.optval, optval,
>>>>>> +                min(ctx.optlen, max_optlen)) != 0) {
>>>>> What is in optval that is useful to copy from if the kernel didn't
>>>>> handle the optname?
>>>>
>>>> For example, if the user customizes a new optname, it will not be
>>>> processed if the kernel does not support it. Then the data stored in
>>>> optval is the data put
>>>
>>>
>>>
>>>> by the user. If this part can be seen by bpf prog, the user can
>>>> implement processing logic of the custom optname through bpf prog.
>>>
>>> This part does not make sense. It is a (get)sockopt. Why the bpf prog
>>> should expect anything useful in the original __user optval? Other than
>>> unnecessary copy for other common cases, it looks like a bad api, so
>>> consider it a NAK.
>>>
>>>>
>>>>>
>>>>> and there is no selftest also.
>>>>>
>>>>
>>>> Yes, if remove this restriction, everyone thinks it's ok, I'll add it
>>>> in the next version.
>>>>
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>>        }
>>>>>>        lock_sock(sk);
>>>>>
>>>>
>>>
>>
>> According to my understanding, users will have such requirements,
>> customize an optname, which is not available in the kernel. All logic is
>> completed in bpf prog, and bpf prog needs to obtain the user data passed
>> in by the system call, and then return the data required by the user
>> according to this data.
>>
>> For optname not in the kernel, the error code is
>> #define ENOPROTOOPT 92/* Protocol not available */
>> Whether to consider the way of judging with error codes,
>> If (! retval | | retval == -ENOPROTOOPT)
> 
> I'm also failing to see what you're trying to do here. You can already
> implement custom optnames via getsockopt, so what's missing?
> If you need to pass some data from the userspace to the hook, then
> setsockopt hook will serve you better.
> getsockopt is about reading something from the kernel/bpf; ignoring
> initial user buffer value is somewhat implied here.

Thanks, you reminded me that can pass data to bpf prog by setsockopt.


