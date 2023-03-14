Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890806B9644
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjCNNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCNNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:31:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD463B3E7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x37so4448193pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678800489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqWxNNgiyjRPvW1SVzhFefJbYTcfrMJLvZh3UARCdLs=;
        b=UfZWX/tF8Y5bvfKzueyw8I/F+3lDY6MCLy3PTrPJEnQ9ih7wHAh0JvHvsmBmLoII1h
         /WqcdSll/fh6vlVszSoAm+wMN0bdSynJY5vrlCKNJkIx1oopwdo2LocLoRPAxihE+kCU
         WfWj3ABzwy9IyKv34ud7y66RJTtCbFB4VeBQXnaaNA+sH6eQKCrDWbatvL+SHfvDYaxY
         bDG4aG6mZsG8DSeS/cSsKSWdZZvMKcRoHi7Oz3YzItZSGkAgGoQS1sGE+89mKA//IDBj
         dNnI+JLzRoVUGr/Pxvesd4BxqFy0iZJboZDjoGWv5GghekIXNG2MnB4gM3i5JWjR73D5
         Yz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqWxNNgiyjRPvW1SVzhFefJbYTcfrMJLvZh3UARCdLs=;
        b=vaq94+mEN4DT6W603lL3Wp6bU5JuxHPSbyyKTtf2WBDLUaE9emK1EI58ggIvPjnxCt
         s0ipi1P1R7SQvDcNl6m0aRhSBdpuFUVHf3bMMxN/Ah92PeFjFWhpMlNCDsrt2KwaOpbY
         ICHKWasncVkM0FPrdhlpD10rfKr/07XY7oNXSV3oVB/qsqOTfp8f1B9tgHV/D2iu3Ey4
         pvAJmuxfM0hjSyV02V7TpnQ0BYfadjhePyl2pqENA22qMSTFjfPdqHUumYUviuVET3la
         prpy3oWNwEbmL5LNZ988RJVxeF5nPfV5gYdjAnrVY9xP56M5GEmKPMCdEjEHJZgC8Inz
         5t2A==
X-Gm-Message-State: AO0yUKURobn2iXI8SsewYQd40aVZzjSy2+Bgq5ovw3etx5EeUbPJon6m
        zBqyUCSG5hwOgiWL+hjOM9+BcQ==
X-Google-Smtp-Source: AK7set9QVNa6eB8xyRHYwZh6rcWLH1QYqyeeNvAA/or+hRErflrv3scAopJ25spNQbrIR9iwHLylkw==
X-Received: by 2002:a62:3301:0:b0:625:6e00:210d with SMTP id z1-20020a623301000000b006256e00210dmr1451867pfz.21.1678800488713;
        Tue, 14 Mar 2023 06:28:08 -0700 (PDT)
Received: from [10.54.29.37] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 14-20020aa7914e000000b00622e01989cbsm1645680pfi.176.2023.03.14.06.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 06:28:08 -0700 (PDT)
Message-ID: <43717dc3-b8c8-651a-3d61-019c9752a110@shopee.com>
Date:   Tue, 14 Mar 2023 21:27:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND] mm/oom_kill: don't kill exiting tasks in
 oom_kill_memcg_member
To:     Michal Hocko <mhocko@suse.com>
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230314091136.264878-1-haifeng.xu@shopee.com>
 <ZBA8NlwBTprShO3e@dhcp22.suse.cz>
 <f774cfeb-9524-5fd7-fe2d-e6c2a58684e2@shopee.com>
 <ZBBJZx3Em9L9/3jn@dhcp22.suse.cz>
 <3654a73e-6817-4247-73b8-4604efe4a309@shopee.com>
 <ZBBh9IN3Cvq89WO5@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZBBh9IN3Cvq89WO5@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/14 20:00, Michal Hocko wrote:
> On Tue 14-03-23 19:07:27, Haifeng Xu wrote:
>>
>>
>> On 2023/3/14 18:16, Michal Hocko wrote:
>>> On Tue 14-03-23 18:07:42, Haifeng Xu wrote:
>>>>
>>>>
>>>> On 2023/3/14 17:19, Michal Hocko wrote:
>>>>> On Tue 14-03-23 09:11:36, Haifeng Xu wrote:
>>>>>> If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
>>>>>> to kill all processes in the memcg. When scanning tasks in memcg, maybe
>>>>>> the provided task is marked as oom victim. Also, some tasks are likely
>>>>>> to release their address space. There is no need to kill the exiting tasks.
>>>>>
>>>>> This doesn't state any actual problem. Could you be more specific? Is
>>>>> this a bug fix, a behavior change or an optimization?
>>>>
>>>>
>>>> 1) oom_kill_process() has inovked __oom_kill_process() to kill the selected victim, but it will be scanned
>>>> in mem_cgroup_scan_tasks(). It's pointless to kill the victim twice. 
>>>
>>> Why does that matter though? The purpose of task_will_free_mem in
>>> oom_kill_process is different. It would bail out from a potentially
>>> noisy OOM report when the selected oom victim is expected to terminate
>>> soon. __oom_kill_process called for the whole memcg doesn't aim at
>>> avoiding any oom victims. It merely sends a kill signal too all of them.
>>>
>>
>> except sending kill signals, __oom_kill_process() will do some other work, such as print messeages, traversal all 
>> all user processes sharing mm which holds RCU section and so on. So if skip the victim, we don't need those work again
>> and it won't affect the original mechanism. All oom victims are still get killed. 
> 
> mm sharing among processes is a very rare thing but do not forget that
> task_will_free_mem needs to do the same thing for the same reason.

For the victim, __oom_kill_process() traversals all processes in the system whether there some other tasks sharing mm or not.
If skip it, this work can be dropped.

> 
>>>> 2) for those exiting processes, reaping them directly is also a faster way to free memory compare with invoking
>>>> __oom_kill_process().
>>>
>>> Is it? What if the terminating task is blocked on lock? Async oom
>>> reaping might release those resources in that case.
>>
>> Yes, the reaping process is asynchronous. I mean we don't need the work mentioned above any more.
>> "reaping them directly" here is that joining the task in oom reaper queue.
> 
> I do not follow.
> 
> In any case I still do not see any actual justification for the change
> other than "we can do it and it might turn out less expensive". This
> alone is not sufficient, just be explicit, because oom is hardly a fast
> path to optimize every single cpu cycle for. So unless you see an actual
> real life problem that would be behaving much better or even fixed then
> I am not convinced this is a worthwhile change to have.
> 

we can also see two same messages("Memory cgroup out of memory: Killed process ***")about the victim.
This seems a little confusing. If skip the victim, only one message was printed.

