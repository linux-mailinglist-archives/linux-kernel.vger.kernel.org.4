Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E55FD33B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJMC1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJMC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:27:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED1115408
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:27:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so419285pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gKYRZDDM90Di93CvJKt2gp7x873nH3xFGWEnv5tNnk=;
        b=idd+IDgFuT97y5XHKYyQdT2D1mbNkr0iIBw5OjhnEaH4fcxjb6PJcHbvWq8dFxvfYM
         E6PYnyZDRzvMarYaY9mAm0X2Wks+9IX+tEYpvnhPFPDMsmR7tkj6m4e5f/7aDJy5VKMo
         cdnk9Brj4dPk5aJ5NJ+R55CnjQPTk7lmSo/6KIcWpTTYGOux3U3htRJclqX73rtk12rf
         VXmpz6oL5IAk/s68rG0Ed8BSIX2+1FoDitVE3fNbQqauqXxE9KQlIQZmIBaXJ5xgr2LI
         +n01UInQHME/GVow9d+pqzyjoAbGkEOQvjRaB673uJfbpa/ksDH1FOfH3/t8RZCeVp/M
         NjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gKYRZDDM90Di93CvJKt2gp7x873nH3xFGWEnv5tNnk=;
        b=jmed3p9W8ejqGYGdyLibORJRk0sEcRvtypL2BpomFF6oV+Xkh5/gctOAxh8xoRXRwV
         5C8kjbB8RvTBBkS2715OYwTO9uYcYUP04Ul7HqiRCL8GutuMMbWEHqhk7E/hvJBujhBZ
         2ulmrPNu0MhcVNwSZQwSS9hmFVFP+nZuGpvovTumZD/1ptvYp53cuLF6C+IKgFU8VmBo
         XBOtJTWWKhu3kGEsJ5Y8jVj3EJdUPN8TqdCeIOeNzZMKy7vO0/evtVjnY7My5XfRU3SD
         1MQDMGddfZ/1kl+vaOPYXD88Xb/vo9TDUmaNmIjWV+fFtOiWswAmn+uroDrquJfPGPvK
         tfpQ==
X-Gm-Message-State: ACrzQf3SEc34OE8jV3Sa8KMGFKU6dnpd3c19ez/mJEGdB1H/RgnOdwSG
        EVwrmQEwBtdIryIA3I9ZC8KZeQ==
X-Google-Smtp-Source: AMsMyM7KPCJeeqJDtF19rxNp6rJSIbjdUQUoSJbXW7zXW/LF9FLidVM+yKS+2bmlJn3pw1+GTVJ/vQ==
X-Received: by 2002:a63:20f:0:b0:43c:1ef6:ebd6 with SMTP id 15-20020a63020f000000b0043c1ef6ebd6mr28190029pgc.217.1665628057933;
        Wed, 12 Oct 2022 19:27:37 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090a170c00b00206023cbcc7sm2046281pjd.15.2022.10.12.19.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 19:27:37 -0700 (PDT)
Message-ID: <ae81b620-e9c8-563a-8c54-2235164624dc@bytedance.com>
Date:   Thu, 13 Oct 2022 10:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] bpf/btf: Fix is_int_ptr()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20221012125815.76120-1-zhouchengming@bytedance.com>
 <1e01ab5a-c171-0b7a-751a-9ba7da4cd5dd@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <1e01ab5a-c171-0b7a-751a-9ba7da4cd5dd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 08:50, Martin KaFai Lau wrote:
> On 10/12/22 5:58 AM, Chengming Zhou wrote:
>> When tracing a kernel function with arg type is u32*, btf_ctx_access()
>> would report error: arg2 type INT is not a struct.
>>
>> The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
>> in tracing programs") added support for int pointer, but don't skip
>> modifiers before checking it's type. This patch fixes it.
> 
> A selftest is needed.  You can refer to the selftest added in the patch set [0] of the commit bb6728d75611.
> 
> This belongs to bpf-next.  Please tag it as bpf-next and also v2 in the next revision:
> Documentation/bpf/bpf_devel_QA.rst  (Q: How do I indicate which tree....)
> 
> [0]: https://lore.kernel.org/bpf/20211208193245.172141-2-jolsa@kernel.org/

Thanks for these helpful references, will do.

> 
>>
>> Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>   kernel/bpf/btf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index eba603cec2c5..2b343c42ed10 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5316,8 +5316,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>>       /* t comes in already as a pointer */
>>       t = btf_type_by_id(btf, t->type);
>>   -    /* allow const */
>> -    if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
>> +    /* skip modifiers */
>> +    while (btf_type_is_modifier(t))
> 
> There is btf_type_skip_modifiers() that should be useful here.

Ok, will change to use this.

> 
>>           t = btf_type_by_id(btf, t->type);
>>         return btf_type_is_int(t);
> 
