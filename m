Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BB6206FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiKHCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKHCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:50:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3613EAF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 18:50:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l6so12547298pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 18:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84cIphS2bXhrRJZQWLyQXtMBU55oPJKmrBuUZ1dDmC0=;
        b=fEIF77RmAljzW1hDRJ8YpGA9Ad+WRA7AjpvZ/ZE+uABsOPhekmLo9ke/5qzTFw98/+
         GkMhDYjeQMDCnlCWWihZNkHajJO7eFMG81mUFB5ESmzl7XacIc95Vixjh0TLNEQ15D0f
         Ui+f+i9VB60WTozjXIlFgeRu9XfWMHDWcl+Ex1uTk9Rw74FXDMdt85mciahL5YptOmG1
         5r1Lvc9Y244KX1eM93LMwDw8sRt61zn5RwXQuUIigHZPmR4AaXY0Ch9Z94OiHP2vFzsP
         Pt/sKkz8PsGidvIBtjAIfZlx8L/tv+gKvS3I9It6TjnBOgjWRNm8jaAnDlrmK8ZUCF2/
         99yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84cIphS2bXhrRJZQWLyQXtMBU55oPJKmrBuUZ1dDmC0=;
        b=Z2JPXkF+dIQL2n+z9YS899lEXkIVoneCC74ajNwd7hBo5xDF3t65IV/J7fQUqCBbRT
         FbO8cAxsHBuPSKp4SULlOGPiyxYSvmD55ktV00q3nPQPxLuQvOjuIQmhmHMRVvFXilZY
         +kM2DD01o22biaVQDh9/i+2+5Dkh6YEAvtBZJm8sf6JUUIlmaTPPwWD7xMf/7E6kD6le
         W2luolurZhccgm6ef7UmF2Ytceje7EB9wF8cICBFiwJPVh8KYQeZkAhBZp+d/USAHCbr
         0lHE3NVrUC8IS8UHYJKAorSYPlJw+4luOp+AAdlTvIISm+N617y9uBLB82ldRBpEN6Pc
         aVCg==
X-Gm-Message-State: ACrzQf0LrS5wctb+ui12BuNq2i2f0FMJ1rFsh+TjscXtVolFWXAffhnU
        rUMA/nTGq8/ll2Hs6sbp+r54M/injaMmEA==
X-Google-Smtp-Source: AMsMyM6IbmGd0O7OglqrnNHXonbrO4kMAZRT1nulXoqyAqaURpsxm8L3viVn5vVJnprUAuyKWTvbXA==
X-Received: by 2002:a17:90b:1212:b0:213:a3a4:4d97 with SMTP id gl18-20020a17090b121200b00213a3a44d97mr53402409pjb.225.1667875808042;
        Mon, 07 Nov 2022 18:50:08 -0800 (PST)
Received: from [10.251.254.250] ([71.18.255.6])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b00186a2444a43sm5641245pls.27.2022.11.07.18.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 18:50:07 -0800 (PST)
Message-ID: <04372a53-b101-dd98-1daa-5391d2d9b09f@bytedance.com>
Date:   Tue, 8 Nov 2022 10:50:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] kretprobe events missing on 2-core KVM guest
Content-Language: en-US
To:     Solar Designer <solar@openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org,
        mattwu@163.com, Adam Zabrocki <pi3@pi3.com.pl>
References: <20221025100117.18667-1-wuqiang.matt@bytedance.com>
 <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
 <20221107133628.GA31649@openwall.com>
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <20221107133628.GA31649@openwall.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/7 21:36, Solar Designer wrote:
> On Wed, Oct 26, 2022 at 12:33:15AM +0900, Masami Hiramatsu wrote:
>> On Tue, 25 Oct 2022 18:01:17 +0800
>> wuqiang <wuqiang.matt@bytedance.com> wrote:
>>
>>> Default value of maxactive is set as num_possible_cpus() for nonpreemptable
>>> systems. For a 2-core system, only 2 kretprobe instances would be allocated
>>> in default, then these 2 instances for execve kretprobe are very likely to
>>> be used up with a pipelined command.
>>>
>>> This patch increases the minimum of maxactive to 10.
>>
>> This looks reasonable to me.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reasonable yes, but:
> 
> Is 10 enough?  How exactly do those instances get used up without
> preemption?  Perhaps because execve can sleep?  If so, perhaps we should
> use the same logic without preemption that we do with preemption?  So
> maybe just make this line unconditional? -
> 
> 		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());

I agree to make it unconditional, though it could cost a bit more memory.

Here's my testcase: a shell script was added to crontab, and the content of
the script is:

   #!/bin/sh
   do_something_with_magic `tr -dc a-z < /dev/urandom | head -c 10`

cron will trigger a series of program executions (4 times every hour). Then
we noticed events loss after 3-4 hours of testings.

The issue is caused by a burst of series of execve requests. The best number
of instances could be different case by case, and should be the user's duty
to decide, but num_possible_cpus() as a default value is inadequate. For my
testcase, 8 is enough as verified, and 10 is chosen to keep it identical.

The handling of execve syscall can be suspended or voluntarily yield up cpu
due to i/o or memory resources and then a new execve gets its time slice to
start. It could be worse for scenarios of resource throttling or routines
that are heavier than execve (though rare as I think).

> Also, the behavior was documented in Documentation/trace/kprobes.rst, so
> perhaps that file should be updated at the same time with the code.

Right, will update in next version.

>>> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
>>> ---
>>>   kernel/kprobes.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>> index 3220b0a2fb4a..b781dee3f552 100644
>>> --- a/kernel/kprobes.c
>>> +++ b/kernel/kprobes.c
>>> @@ -2211,7 +2211,7 @@ int register_kretprobe(struct kretprobe *rp)
>>>   #ifdef CONFIG_PREEMPTION
>>>   		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
>>>   #else
>>> -		rp->maxactive = num_possible_cpus();
>>> +		rp->maxactive = max_t(unsigned int, 10, num_possible_cpus());
>>>   #endif
>>>   	}
>>>   #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>>> -- 
>>> 2.34.1
>>>
>>
>>
>> -- 
>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks,
> 
> Alexander

Best regards,
wuqiang

