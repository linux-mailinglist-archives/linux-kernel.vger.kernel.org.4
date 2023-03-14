Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7146B9123
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCNLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCNLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:08:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C22911C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:07:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so6459463pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678792053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5M1DBlPFQKNPA8pa3BKKPfvgZNjQEcGkRad3D+XbU=;
        b=FHcLDDbkk9I35ygxiufT+m09fqRJ1UdOPx+YDsUFdkKb4xhVYFxiK2Zb5th7+JqQZX
         RDBc9hJBYDYoLITSzF/Cn3DxypZGjtaKmhUoiimqSXO0NCpepHFJeK4mLoEMPnqIyq6Y
         bB0SwOehMwEurTQ7k/b8MhI3GFzz2I7DSpplF+qa0tXxxHJYcRTMpejpHLG9rHk3mfGn
         EDiqTIl4cqQvf+6eiVHYCvr/hgoJAtSFShuUgjk48mGUSACszNiPt01m2R1VUcTLh+ur
         kOMRtuCx9+UNPfF+rQtj2zq4DEPQPT0iZKw3BBQaujhnSUfWYT9u8pgFlOLADP0bxyBp
         GO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tj5M1DBlPFQKNPA8pa3BKKPfvgZNjQEcGkRad3D+XbU=;
        b=rsVjzWT4gzhqJZ9Iqx60+Sh5HgVBuL8V9codIoFuFtbZ2+1xSZxGObIUMjc1fYCmiD
         eplgoYT3vK6NsUsmdHn0lloI9BkXDLnsOw9mTmZxPVjSvOIeJ3dOu+tohvNYyJLyFEyN
         P6NB9cMqjTb2y4fVY1BrfrrqCdI6x4MNFOPBbxwdxLrXOKuhea0OUThNntdHxEpt8SPo
         whW7pl7gA3kUZ0eq5Uv9VWYqeP0IpbalrkxYx6HxF7lscbEqC3s1Yz3ISGrDTfqccOtS
         OUheK0zXc7gzYzISYS/jeu4qme6RmEiSlXyzYAdxZHdNLIaXT7oWjixrTFIgvtyk+BkW
         lC+A==
X-Gm-Message-State: AO0yUKVrrAD4LZWkAb2YJiCxcPigxDfpS5fHZSDXt3slO775bbwNgNeF
        u/5Nvl5C8zRkWPO6a++YwUk5Gg==
X-Google-Smtp-Source: AK7set+jwD1nbF5/u/u36amtxCpZSNYc594uix3nPJP5+kNWShsxUOpAfZ7kkXfkNo1NCTEkRzkcXg==
X-Received: by 2002:a17:902:8c94:b0:1a0:4be0:94a9 with SMTP id t20-20020a1709028c9400b001a04be094a9mr5169648plo.48.1678792052847;
        Tue, 14 Mar 2023 04:07:32 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id ku7-20020a170903288700b00189ac5a2340sm1514893plb.124.2023.03.14.04.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:07:32 -0700 (PDT)
Message-ID: <3654a73e-6817-4247-73b8-4604efe4a309@shopee.com>
Date:   Tue, 14 Mar 2023 19:07:27 +0800
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
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZBBJZx3Em9L9/3jn@dhcp22.suse.cz>
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



On 2023/3/14 18:16, Michal Hocko wrote:
> On Tue 14-03-23 18:07:42, Haifeng Xu wrote:
>>
>>
>> On 2023/3/14 17:19, Michal Hocko wrote:
>>> On Tue 14-03-23 09:11:36, Haifeng Xu wrote:
>>>> If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
>>>> to kill all processes in the memcg. When scanning tasks in memcg, maybe
>>>> the provided task is marked as oom victim. Also, some tasks are likely
>>>> to release their address space. There is no need to kill the exiting tasks.
>>>
>>> This doesn't state any actual problem. Could you be more specific? Is
>>> this a bug fix, a behavior change or an optimization?
>>
>>
>> 1) oom_kill_process() has inovked __oom_kill_process() to kill the selected victim, but it will be scanned
>> in mem_cgroup_scan_tasks(). It's pointless to kill the victim twice. 
> 
> Why does that matter though? The purpose of task_will_free_mem in
> oom_kill_process is different. It would bail out from a potentially
> noisy OOM report when the selected oom victim is expected to terminate
> soon. __oom_kill_process called for the whole memcg doesn't aim at
> avoiding any oom victims. It merely sends a kill signal too all of them.
> 

except sending kill signals, __oom_kill_process() will do some other work, such as print messeages, traversal all 
all user processes sharing mm which holds RCU section and so on. So if skip the victim, we don't need those work again
and it won't affect the original mechanism. All oom victims are still get killed. 

>> 2) for those exiting processes, reaping them directly is also a faster way to free memory compare with invoking
>> __oom_kill_process().
> 
> Is it? What if the terminating task is blocked on lock? Async oom
> reaping might release those resources in that case.

Yes, the reaping process is asynchronous. I mean we don't need the work mentioned above any more.
"reaping them directly" here is that joining the task in oom reaper queue.
