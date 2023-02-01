Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F2686AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjBAPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjBAPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:54:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C27518B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:53:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so17717814wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVI+WjxLWZXJ1wGZa2pnw9bYE11Qq8MHJWAofdW/QaY=;
        b=bJ1QZvuTlGpxk8GBxsDXTPh7bskxLriB1ZpsrZOLTJEWH2bigjjgKgBn4chCcsPBFq
         Y0j5JIDSXjP7CTj59347UPLTfdslnSUbcLUdkfsxcFmVrOJ2uZPZuaObQDlLAnJtXehK
         FK+8BRLwA6ffNt2JeGtMBnz1pHPoMiNZnrciWbdtbNK3zXROOEe8wFK4GYcbHAx9bvIw
         GbdtIhRDvlWMhq+0BMNADcMt2XVKWxsBXJfJjONIuQS8P4VtqeEQy8991vuUuZlbosDA
         YAv3ffBzkeCuV02plLslEMUIPTKoxZfKPOMaC55vZwSaTEYbnnlO3WhM0hXZ50xJKqit
         XIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVI+WjxLWZXJ1wGZa2pnw9bYE11Qq8MHJWAofdW/QaY=;
        b=lufbcYkuPwZarYdePei8RtbfAVDge9oEIivQELQuiEG+iO5niYthVrECvPxx7SP8Fy
         FKzAx1lXGWgN9lontOZpd79ZzVu3pxp29iDpa+gvNcnsquN39r/CEdr7ah3YSGyxREXg
         /6syFgmpf/LpbDfD/rFuHSHm6uBlIHynF9iiO0wovvLg9ZW+dS1gAZW7IWkfn5Xjs0te
         Vz+VeXb1OPR5zLCO2qCa9fMdIDRoiYsH7ePqP/5mA8H47elRJoPUBgEOKrAZq1/IjpOK
         CgGBJZCQhtgvQ9q5d51JXcZMHRkk+76N7k6owlkdTYT2wTQPksIegSoHK+K7KEAY/mUS
         Yc6g==
X-Gm-Message-State: AO0yUKVqBt07OVFwdqRv16Mt63PWojVNerXrKZBVQskoOyZmn6grpvbi
        V1zkCNPH4QJpAlAiGkMMFOLFS4Nvbpg=
X-Google-Smtp-Source: AK7set8HZ6TKL6u0tqc4Q69cvFDKcLumwFbu6kL81T98GtY8ewLg+v8Z+zS+U7TQLkxZ6KRwkjeigg==
X-Received: by 2002:adf:fcd2:0:b0:2bf:bdbd:25c1 with SMTP id f18-20020adffcd2000000b002bfbdbd25c1mr6035451wrs.26.1675266818742;
        Wed, 01 Feb 2023 07:53:38 -0800 (PST)
Received: from [192.168.8.100] (94.197.108.135.threembb.co.uk. [94.197.108.135])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d4d4b000000b00289bdda07b7sm17383159wru.92.2023.02.01.07.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:53:38 -0800 (PST)
Message-ID: <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
Date:   Wed, 1 Feb 2023 15:52:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
To:     Pengfei Xu <pengfei.xu@intel.com>, linux-kernel@vger.kernel.org
Cc:     heng.su@intel.com, axboe@kernel.dk
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
 <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
Content-Language: en-US
In-Reply-To: <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 14:49, Pavel Begunkov wrote:
> On 1/28/23 08:44, Pengfei Xu wrote:
>> Hi Pavel Begunkov and kernel expert,
>>
>> Greeting!
>>
>> There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
>> on Sapphire Rapids server.
> 
> Thanks for the report, we'll take a look

Not reproducible for me. Apparently, the repro creates a normal ring
and immediately closes it, then io_ring_exit_work() hangs waiting to
the task to execute task_work.

It reminds me a bug we had before when the task was being stopped
for debugging blocking task_work. Maybe some signal interaction, or
vm and/or syz magic specific.

>> INFO: task kworker/u4:2:32 blocked for more than 147 seconds.
>> [  300.212512]       Not tainted 6.2.0-rc5-2241ab53cbb5 #1
>> [  300.213087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  300.213921] task:kworker/u4:2    state:D stack:0     pid:32    ppid:2      flags:0x00004000
>> [  300.214849] Workqueue: events_unbound io_ring_exit_work
>> [  300.215506] Call Trace:
>> [  300.215789]  <TASK>
>> [  300.216051]  __schedule+0x385/0xb00
>> [  300.216467]  ? write_comp_data+0x2f/0x90
>> [  300.216949]  ? wait_for_completion+0x7b/0x180
>> [  300.217445]  schedule+0x5b/0xe0
>> [  300.217836]  schedule_timeout+0x561/0x650
>> [  300.218301]  ? _raw_spin_unlock_irq+0x2b/0x60
>> [  300.218816]  ? wait_for_completion+0x7b/0x180
>> [  300.219341]  ? __this_cpu_preempt_check+0x20/0x30
>> [  300.219893]  ? lockdep_hardirqs_on+0x8a/0x110
>> [  300.220384]  ? _raw_spin_unlock_irq+0x2b/0x60
>> [  300.220881]  ? wait_for_completion+0x9e/0x180
>> [  300.221382]  ? trace_hardirqs_on+0x3f/0x100
>> [  300.221868]  ? wait_for_completion+0x7b/0x180
>> [  300.222379]  wait_for_completion+0xa6/0x180
>> [  300.222897]  io_ring_exit_work+0x2f7/0x747
>> [  300.223383]  ? __pfx_io_tctx_exit_cb+0x10/0x10
>> [  300.223947]  process_one_work+0x3b1/0x960
>> [  300.224446]  worker_thread+0x52/0x660
>> [  300.224884]  ? __pfx_worker_thread+0x10/0x10
>> [  300.225376]  kthread+0x161/0x1a0
>> [  300.225782]  ? __pfx_kthread+0x10/0x10
>> [  300.226225]  ret_from_fork+0x29/0x50
>> [  300.226688]  </TASK>
>> [  300.227791]
>> [  300.227791] Showing all locks held in the system:
>> [  300.228501] 1 lock held by rcu_tasks_kthre/11:
>> [  300.229003]  #0: ffffffff83d617b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
>> [  300.230098] 1 lock held by rcu_tasks_rude_/12:
>> [  300.230601]  #0: ffffffff83d61530 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
>> [  300.231733] 1 lock held by rcu_tasks_trace/13:
>> [  300.232244]  #0: ffffffff83d61270 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
>> [  300.233377] 1 lock held by khungtaskd/29:
>> [  300.233842]  #0: ffffffff83d621c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x27/0x18c
>> [  300.234866] 2 locks held by kworker/u4:2/32:
>> [  300.235351]  #0: ff11000006045d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2ff/0x960
>> [  300.236502]  #1: ffa0000000117e60 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x303/0x960
>> [  300.237696]
>> [  300.237882] =============================================
>> [  300.237882]
>>
>> Bisected and found the first bad commit is:
>> eebd2e37e662617a6b8041db75205f0a262ce870
>> io_uring: don't take task ring-file notes
>>
>> But after reverted above commit eebd2e37e on top of v6.2-rc5 kernel and made
>> the kernel failed. So it's just the suspected commit for above problem.
>>
>> Syzkaller reproduced code, bisect info, kconfig and v6.2-rc5 dmesg are in
>> attached.
>>
>> All detailed info is in link:
>> https://github.com/xupengfe/syzkaller_logs/tree/main/230124_055801_io_ring_exit_work
>>
>> I hope it's helpful.
>>
>> Thanks!
>> BR.
> 

-- 
Pavel Begunkov
