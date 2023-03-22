Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB56C4533
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:40:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72A3B862
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:40:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ew6so6626730edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679474406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VATGD7GI/K7nnbh24Aj4cpyFROPumfPlPU22BMb//fQ=;
        b=qD646JnCokHor6uxt5eWJROhUtFxaG5ozyYi5OkUCXyitFXXrp6brgAKDzEm1tSN6w
         0EdeQbL4Xi+ZPh1MVF4TqxbicDZNAz0Q8cBZIe4l55RfcoeR7lMwJ+B1L6aSJHsY2DpK
         yDwsuwVJIc6BQiqpsl1575W1Xm24x8q6o1Hxv6mkUjgsNW/W72QvVv6Aye+e8ckFAvpV
         kB4slvagx9tuwqBvp6aBJFcUaLeiEvMokMoV9zf0DrkEGjUkvuOb/h0SQ22PjW5XD9T1
         PHbAmkjKNMGGeNZ1Ka+2ago7GJDgLIP1a6BG4/oeN7QCbmhyT7Wtq3Ir+8yuUH238QHF
         l3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VATGD7GI/K7nnbh24Aj4cpyFROPumfPlPU22BMb//fQ=;
        b=hiezc9Iz66ifBxi+C5o4bxiBqOzviXZ7JxCSjkR8nvylmLlkSD8hURyiYvCMpgYYR+
         BBld3GjonEd3icmeusqp1fIrCqMXazZ18LZTL+Cji/Pk/LNP1AyfOcVqRoEWpZm8VjXx
         U78jBtGxI0VrW+J4nOXNuS4RQcfe5qtR8chO0w3YEQWHabOAYUh/+KyhHX8ZUyZD8N4l
         KbYvkcFL7tnhW4OJjg36axSwsDdAEaGNPdM1gMkIgM3qL6MEO1w/098c8rBqh20vYWBd
         ZT/tlrc9/87Zx1UHOTN7jzwvdXB19YhOqFlvQUcvLGUSLGH+XNUofTqB9cY8qd1hREN0
         v2JA==
X-Gm-Message-State: AO0yUKWzw8zaPoLKV3pNooODgUejd1RnBvrP7RbGmXiZhvM8XqdW/HKQ
        +0whHvAARmoxGY7FnE4x9HfQyCPduy432WunTzQ=
X-Google-Smtp-Source: AK7set9wgc1EQ1S3PVMTGeHC/sc0D/Uw8tFaE3UKTl6G8+Yo613plq5JXL50+Xzcw0tv2EJb71EIEQ==
X-Received: by 2002:a17:906:720f:b0:8f2:62a9:6159 with SMTP id m15-20020a170906720f00b008f262a96159mr5367862ejk.2.1679474406384;
        Wed, 22 Mar 2023 01:40:06 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm7246922edj.91.2023.03.22.01.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:40:05 -0700 (PDT)
Message-ID: <1853ef42-7d04-be93-a728-5092a734275f@linaro.org>
Date:   Wed, 22 Mar 2023 08:40:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] misc: fastrpc: Fix a Use after-free-bug by race condition
Content-Language: en-US
To:     sangsup lee <k1rh4.lee@gmail.com>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230216014120.3110-1-k1rh4.lee@gmail.com>
 <9bfef283-e2ac-b2ba-386c-6833e9cb1283@linaro.org>
 <CAJkuJRjKszq75M_QttFSO+zVixqfNjHBeajZFa8r0x+wnE6xiA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAJkuJRjKszq75M_QttFSO+zVixqfNjHBeajZFa8r0x+wnE6xiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2023 01:59, sangsup lee wrote:
> Sounds great.
> 
> Thank you for your recommendation.
> The patch code that you recommend is clear and simple.
> Please patch this.
> 
> Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
> ---

Please follow kernel patch submission guidelines, any changes to code 
should be send as new version of patch.

Have a look at Documentation/process/submitting-patches.rst for more 
information.

thanks,
Srini
>   drivers/misc/fastrpc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..aa1cf0e9f4ed 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file
> *file, unsigned int cmd,
>                  err = fastrpc_req_mmap(fl, argp);
>                  break;
>          case FASTRPC_IOCTL_MUNMAP:
> +               mutex_lock(&fl->mutex);
>                  err = fastrpc_req_munmap(fl, argp);
> +               mutex_unlock(&fl->mutex);
>                  break;
>          case FASTRPC_IOCTL_MEM_MAP:
>                  err = fastrpc_req_mem_map(fl, argp);
> --
> 2.25.1
> 
> 
> 2023년 3월 21일 (화) 오후 6:27, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org>님이 작성:
>>
>> Thanks Sangsup for reporting the issue and sharing the patch,
>>
>> Sorry, for some reason I missed this patch.
>>
>> On 16/02/2023 01:41, Sangsup Lee wrote:
>>> This patch adds mutex_lock for fixing an Use-after-free bug.
>>> fastrpc_req_munmap_impl can be called concurrently in multi-threded environments.
>>> The buf which is allocated by list_for_each_safe can be used after another thread frees it.
>>>
>> Commit log can be improved here to something like:
>>
>> fastrcp_munmap takes two steps to unmap the memory, first to find a
>> matching fastrpc buf in the list and second is to send request to DSP to
>> unmap it.
>> There is a potentially window of race between these two operations,
>> which can lead to user-after-free.
>>
>> Fix this by adding locking around this two operations.
>>
>>> Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
>>> ---
>>>    drivers/misc/fastrpc.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 5310606113fe..c4b5fa4a50a6 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -1806,10 +1806,12 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>>        struct fastrpc_buf *buf = NULL, *iter, *b;
>>>        struct fastrpc_req_munmap req;
>>>        struct device *dev = fl->sctx->dev;
>>> +     int err;
>>>
>>>        if (copy_from_user(&req, argp, sizeof(req)))
>>>                return -EFAULT;
>>>
>>> +     mutex_lock(&fl->mutex);
>>>        spin_lock(&fl->lock);
>>>        list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>>>                if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
>>> @@ -1822,10 +1824,13 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>>        if (!buf) {
>>>                dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
>>>                        req.vaddrout, req.size);
>>> +             mutex_unlock(&fl->mutex);
>>>                return -EINVAL;
>>>        }
>>>
>>> -     return fastrpc_req_munmap_impl(fl, buf);
>>> +     err = fastrpc_req_munmap_impl(fl, buf);
>>> +     mutex_unlock(&fl->mutex);
>>> +     return err;
>>
>> How about moving the locking to ioctl:
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index a701132638cf..2f217071a6c3 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -2087,7 +2087,9 @@ static long fastrpc_device_ioctl(struct file
>> *file, unsigned int cmd,
>>                   err = fastrpc_req_mmap(fl, argp);
>>                   break;
>>           case FASTRPC_IOCTL_MUNMAP:
>> +               mutex_lock(&fl->mutex);
>>                   err = fastrpc_req_munmap(fl, argp);
>> +               mutex_unlock(&fl->mutex);
>>                   break;
>>           case FASTRPC_IOCTL_MEM_MAP:
>>                   err = fastrpc_req_mem_map(fl, argp);
>>
>>
>> thanks,
>> srini
>>>    }
>>>
>>>    static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
