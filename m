Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06F2728E82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjFIDUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbjFIDTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:19:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B1930F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:19:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b2993c9652so308269a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686280763; x=1688872763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD4YPSy4tQn9C5x5+zUZn6e9X1T4rUdNHcpnpttXoIA=;
        b=WzpKdYtXqdD4MQ7psFHTj0bwcj7wv4sNADyuwWxgpw1lTcdIzFm3nNykvRdQzFXueR
         evsbCc/Q45O5j8zmmB5Y2c/gY9CdYDTldDwByBVx26AnT7P4wb+Z5VK5v7hnCCDfCXLq
         fw+75iM6P91E8oauoxvc8IRMiwHNMjZEUEdjSQ3T1N1ItebB9OTxfI6V16dOHa0ofPHW
         5QO7uIJ6rhd7gvcda/9u2b+l3ZIrFkiWxumbn9vwcjZCGB7s0cOmof5wi77H7xt55jHH
         yA4Y5tTr99HkZPYJmnl5sAfwax6TgMAx2rSUR93giMtXSonyt5ea2bcW++DRBcV0jVUC
         RvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280763; x=1688872763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TD4YPSy4tQn9C5x5+zUZn6e9X1T4rUdNHcpnpttXoIA=;
        b=d3NMvYZVSZq+A5s8umr24Og2KFWmGGCczlUL59s8iJIfo+dPOIXuBh1TcchdiG08uQ
         /baSk3DLjmnCfrM5i+7kRJZ+AbXzyZfEDvLFR0k+0V1d0rRrZAZGHDitR8MPs0IZ+mEf
         mp9/lailgiUmM2W85WCj7lkZV5E9BV7leMv9L9pNKY8VgEStyM5RxrlcM5jLOFxOsBkg
         +dxLu75+LIWrG4QNZPEinDElTBmm6JVmg6UkEvL+zJQW0YKOjFzN/CRp9E1SV6kFXxSX
         ccpiNjd0V1S5G3fegCttGU4IuCzrzvHpxUQF6Kb7m89V/ZRo3zrJ4GHhzJ7r60BmEXQv
         mY+Q==
X-Gm-Message-State: AC+VfDwHsXx3qVMCoIRREuLqLNkNhwJgloYxgpEUvLanpJfclgMAx9Qd
        /rI1yafMA3wHJuL9gdDVrnxxLg==
X-Google-Smtp-Source: ACHHUZ6uitpOSR0QrTFAXI2YTiJ4ss0zpjaswY8MGvpF4gLoCopfG9HPzHMXwU7ULgq1qgbr+4S+NQ==
X-Received: by 2002:a05:6359:59a:b0:123:ab5:5654 with SMTP id ee26-20020a056359059a00b001230ab55654mr199602rwb.20.1686280763553;
        Thu, 08 Jun 2023 20:19:23 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d36-20020a634f24000000b0050fa6546a45sm1913854pgb.6.2023.06.08.20.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 20:19:23 -0700 (PDT)
Message-ID: <504c702c-b31a-a9d4-22a0-8a09547d30e5@bytedance.com>
Date:   Fri, 9 Jun 2023 11:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v4 4/4] sched/core: Avoid multiple calling
 update_rq_clock() in unthrottle_offline_cfs_rqs()
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
 <20230608063312.79440-5-jiahao.os@bytedance.com>
 <xm26zg59acky.fsf@google.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <xm26zg59acky.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/9 Benjamin Segall wrote:
> Hao Jia <jiahao.os@bytedance.com> writes:
> 
>> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
>> ------------[ cut here ]------------
>> rq->clock_update_flags & RQCF_UPDATED
>> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
>> update_rq_clock+0xaf/0x180
>> Call Trace:
>>   <TASK>
>>   unthrottle_cfs_rq+0x4b/0x300
>>   rq_offline_fair+0x89/0x90
>>   set_rq_offline.part.118+0x28/0x60
>>   rq_attach_root+0xc4/0xd0
>>   cpu_attach_domain+0x3dc/0x7f0
>>   partition_sched_domains_locked+0x2a5/0x3c0
>>   rebuild_sched_domains_locked+0x477/0x830
>>   rebuild_sched_domains+0x1b/0x30
>>   cpuset_hotplug_workfn+0x2ca/0xc90
>>   ? balance_push+0x56/0xf0
>>   ? _raw_spin_unlock+0x15/0x30
>>   ? finish_task_switch+0x98/0x2f0
>>   ? __switch_to+0x291/0x410
>>   ? __schedule+0x65e/0x1310
>>   process_one_work+0x1bc/0x3d0
>>   worker_thread+0x4c/0x380
>>   ? preempt_count_add+0x92/0xa0
>>   ? rescuer_thread+0x310/0x310
>>   kthread+0xe6/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>
>> The rq clock has been updated before the set_rq_offline()
>> function runs, so we don't need to call update_rq_clock() in
>> unthrottle_offline_cfs_rqs().
> 
> I don't think we do in the path from rq_attach_root (though that's easy
> enough to fix, of course).
> 

Thanks for your review.

Now our fix method is that after applying patch1, we update the rq clock 
before set_rq_offline(). Then use rq_clock_{start, stop}_loop_update to 
avoid updating the rq clock multiple times in unthrottle_cfs_rq().

Do you have any better suggestions?

Thanks,
Hao
