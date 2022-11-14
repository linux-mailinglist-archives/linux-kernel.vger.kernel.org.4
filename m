Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5EB628390
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiKNPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiKNPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:12:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EFB7F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:12:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so10469931pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/0liD4zfDdUwy8XG2a2Y/qRgR4CN54ZKUBk4lToHno=;
        b=riU8FvWGPfAZqyj8WmPJvGzPQ68RHcW8+D48NwSgZ3lNAnI2AXpGhtHVf3bl6q+qZ9
         pbhT1osj/KzHcAgUo3UPhTPY+czk+QfGN190xCV7kRBhB1/yAJpiYZOwf/LMv+Xi/cwp
         WGJ2a1qhdA+ztabSdiNTnN9ZJFJF4npNykY/RWPvvkhMeSXFCO9HSAkD536ubLp41xwy
         MO2VuanYlZE3CMyuc9Cg2XRIiZ7Ga0L/+i6AFFYP4N/yBB04zjtXkL8kOsIKYL2/d6n7
         +yiWi7psl/h2Wjs4VuexYYEpW+T1uEb6l8MoZi4/YJ0oVcv0BdpGGYgDEGssuM7/kCro
         aA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e/0liD4zfDdUwy8XG2a2Y/qRgR4CN54ZKUBk4lToHno=;
        b=M3dtwb44NvWIa+7FS3cz4cUFWF+XiQBU3nTlTExL164X4MWH/hzlxsdhUyRz9rKKT4
         ZIKm6Je8XMjow+ELSUXBaY1ENLfEUmAr1xhYOzlSBTHWBDCGZrwdoVsuawBrIaSw2sYt
         TidfO8M+NOF9O9fSwV9MTRV7IeGQCSJftMTplvg5fSQWKBW5tmCMofQWUNt7FsHGWO2j
         NxmZOlfa2s/kwQ40bU7JOV4DDGmyMIih1YxLxB1Y32zvdDG0+n/bKBmM47uM6kwiND6A
         69AQ582pM74huSuI3GIUDMzN0L8q8/NS+53cNFrlUoUP/Ux3Vx+mZXqObJ0RaEjWyBiB
         U+zg==
X-Gm-Message-State: ANoB5plI0GqLuk2RoE1gSZHV/sJ/9QRSw4bBopi94fvuW+aK7qAFWf9H
        6tIOuiq/G5Wt4ewa+7J2Mp+LZQ==
X-Google-Smtp-Source: AA0mqf5deRRQMkg46X2uMf/zlBQAB+/Exhx4ssc553jIiUej9t4Dih0k5QiaoT6krFeU5qMYoAQI5Q==
X-Received: by 2002:a63:d143:0:b0:45c:5a74:9a92 with SMTP id c3-20020a63d143000000b0045c5a749a92mr12351490pgj.473.1668438726461;
        Mon, 14 Nov 2022 07:12:06 -0800 (PST)
Received: from [10.68.76.92] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7100210pfu.10.2022.11.14.07.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:12:05 -0800 (PST)
Message-ID: <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
Date:   Mon, 14 Nov 2022 23:12:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
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

Sorry,michal. I dont know if my expression is accurate.
> 
> We shouldn't really rely on mmap_sem for this IMO. 

  Yes, We should rely on mmap_sem for vma->vm_policy,but not for
  process context policy(task->mempolicy).

> There is alloc_lock
> (aka task lock) that makes sure the policy is stable so that caller can
> atomically take a reference and hold on the policy. And we do not do
> that consistently and this should be fixed.

I saw some explanations in the doc("numa_memory_policy.rst") and
comments(mempolcy.h) why not use locks and reference in page
allocation:

In process context there is no locking because only the process accesses
its own state.

During run-time "usage" of the policy, we attempt to minimize atomic
operations on the reference count, as this can lead to cache lines
bouncing between cpus and NUMA nodes.  "Usage" here means one of
the following:
1) querying of the policy, either by the task itself [using
the get_mempolicy() API discussed below] or by another task using
the /proc/<pid>/numa_maps interface.

2) examination of the policy to determine the policy mode and
associated node or node lists, if any, for page allocation.
This is considered a "hot path".  Note that for MPOL_BIND, the
"usage" extends across the entire allocation process, which may
sleep during page reclaimation, because the BIND policy nodemask
is used, by reference, to filter ineligible nodes.

> E.g. just looking at some
> random places like allowed_mems_nr (relying on get_task_policy) is
> completely lockless and some paths (like fadvise) do not use any of the
> explicit (alloc_lock) or implicit (mmap_lock) locking. That means that
> the task_work based approach cannot really work in this case, right?

The task_work based approach (mpol_put_async()) allows mempolicy release
to be transferred from the pidfd_set_mempolicy() context to the
target process context.The old mempolicy droped by pidfd_set_mempolicy()
will be freed by task_work(mpol_free_async) whenever the target task
exit to user mode. At this point task->mempolicy will not be used,
thus avoiding race conditions.

pidfd process context:
void mpol_put_async()
{.....
         init_task_work(&p->w.cb_head, "mpol_free_async");
         if (!task_work_add(task, &p->w.cb_head, TWA_SIGNAL_NO_IPI))
                 return;}

target task:
/* there is no lock and mempolicy may about to be freed by
  * pidfd_set_mempolicy().
  */
pol = get_task_policy()
page = __alloc_pages(..pol)
.....
exit_to_user_mode
	task_work_run()
	/* It's safe to free old mempolicy
  	* dropped by pidfd_set_mempolicy() at this time.*/
		mpol_free_async()

> Playing more tricks will not really help long term. So while your patch
> tries to workaround the current state of the art I do not think we
> really want that. As stated previously, I would much rather see proper
> reference counting instead. I thought we have agreed this would be the
> first approach unless the resulting performance is really bad. Have you
> concluded that to be the case? I do not see any numbers or notes in the
> changelog.

I have tried it, but I found that using task_work to release the
old policy on the target process can solve the problem, but I'm
not sure. My expression may not be very clear, Looking forward to
your reply.

Thanks.


