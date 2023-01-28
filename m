Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408167F8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjA1OxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjA1OxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:53:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D16EAC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:53:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a3so725158wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4hr2a6QoZckkkd3I1VdLoDHT5EpCP/gC7jEobixPQ=;
        b=CK10gCAneREe4LwxuyGor9E6kIp5Gd/vfc+HVyCaZ6qIHuZ+zcWkE/6RhiSo4zz0Ks
         cowtCAr3QeCuAN2s1Jg0v0aee9Ka/G8YrupyPKFE1/Bm4oRwPuPgu/9i6hf6bz+6wYuF
         7DcBap3/a5xaXlT7YlLU/Ftrhm0H7vyIMHXhCPInG9IKFCLxEnc7231sPlyMCI9ASyXg
         WceIv5hwmXEM0bfvBglCk3evBzCww192FQkiwkk30voOQ4AtYBsWWgeNoJkufm1LQfg9
         299Ycqk+dUwxD64itvV1+4tqspALoetjbA9vGhFaYKVKtgkbXJ2+fB2w3f7wp4uRaXff
         0Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4hr2a6QoZckkkd3I1VdLoDHT5EpCP/gC7jEobixPQ=;
        b=UYcQsCH5dVIW27zpKyXBw6SDgdHTvKoI/gzyeiX9oE/zYrMdO49xgyv3deuV04N4h0
         yjLwYVy8hRxITA+fDgO5YePdYIbPXysJE/Y93pk3Vs/Nh95lF0saPVzHx0LrOF05NMTL
         bcTMEK3kUc7AMXcfqUeSBEz4D2d5v3hB3/aQs4zhTSi7jbS9llLnFhEm6w5zyFsVV1qY
         RQp0zCsGv1TnwZry1Sec5io4KksxQwSoayTrmp59IQlq0Z75dqJ5nE7jv2ecp6D+Rljp
         1l8Nk2hDZJdE5o0INrQYVnvKwOdFJuDJe0TzFquQOU1L6iqTgDh3AIhXz59N5ndmpS2S
         VCvQ==
X-Gm-Message-State: AO0yUKWW7o7ThgNuWzxaMkaOm9xikSXnvw7vwyaarPjQdnVeCURZkqQt
        hjJVJD6BkMoHYpnMKK+Q8neCzFR/fug=
X-Google-Smtp-Source: AK7set8tNozXDz3zeGpE5OvItwlomIeGLR3M7FEWXrn26WhtXxkOmon3jk7VcGku1v+l78GwVa4eow==
X-Received: by 2002:a5d:4612:0:b0:2bf:d411:a500 with SMTP id t18-20020a5d4612000000b002bfd411a500mr4520106wrq.70.1674917598658;
        Sat, 28 Jan 2023 06:53:18 -0800 (PST)
Received: from [192.168.8.100] (94.196.83.65.threembb.co.uk. [94.196.83.65])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002be505ab59asm6839313wra.97.2023.01.28.06.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 06:53:18 -0800 (PST)
Message-ID: <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
Date:   Sat, 28 Jan 2023 14:49:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
To:     Pengfei Xu <pengfei.xu@intel.com>, linux-kernel@vger.kernel.org
Cc:     heng.su@intel.com, axboe@kernel.dk
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 08:44, Pengfei Xu wrote:
> Hi Pavel Begunkov and kernel expert,
> 
> Greeting!
> 
> There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
> on Sapphire Rapids server.

Thanks for the report, we'll take a look

> 
> INFO: task kworker/u4:2:32 blocked for more than 147 seconds.
> [  300.212512]       Not tainted 6.2.0-rc5-2241ab53cbb5 #1
> [  300.213087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.213921] task:kworker/u4:2    state:D stack:0     pid:32    ppid:2      flags:0x00004000
> [  300.214849] Workqueue: events_unbound io_ring_exit_work
> [  300.215506] Call Trace:
> [  300.215789]  <TASK>
> [  300.216051]  __schedule+0x385/0xb00
> [  300.216467]  ? write_comp_data+0x2f/0x90
> [  300.216949]  ? wait_for_completion+0x7b/0x180
> [  300.217445]  schedule+0x5b/0xe0
> [  300.217836]  schedule_timeout+0x561/0x650
> [  300.218301]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.218816]  ? wait_for_completion+0x7b/0x180
> [  300.219341]  ? __this_cpu_preempt_check+0x20/0x30
> [  300.219893]  ? lockdep_hardirqs_on+0x8a/0x110
> [  300.220384]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.220881]  ? wait_for_completion+0x9e/0x180
> [  300.221382]  ? trace_hardirqs_on+0x3f/0x100
> [  300.221868]  ? wait_for_completion+0x7b/0x180
> [  300.222379]  wait_for_completion+0xa6/0x180
> [  300.222897]  io_ring_exit_work+0x2f7/0x747
> [  300.223383]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  300.223947]  process_one_work+0x3b1/0x960
> [  300.224446]  worker_thread+0x52/0x660
> [  300.224884]  ? __pfx_worker_thread+0x10/0x10
> [  300.225376]  kthread+0x161/0x1a0
> [  300.225782]  ? __pfx_kthread+0x10/0x10
> [  300.226225]  ret_from_fork+0x29/0x50
> [  300.226688]  </TASK>
> [  300.227791]
> [  300.227791] Showing all locks held in the system:
> [  300.228501] 1 lock held by rcu_tasks_kthre/11:
> [  300.229003]  #0: ffffffff83d617b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.230098] 1 lock held by rcu_tasks_rude_/12:
> [  300.230601]  #0: ffffffff83d61530 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.231733] 1 lock held by rcu_tasks_trace/13:
> [  300.232244]  #0: ffffffff83d61270 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.233377] 1 lock held by khungtaskd/29:
> [  300.233842]  #0: ffffffff83d621c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x27/0x18c
> [  300.234866] 2 locks held by kworker/u4:2/32:
> [  300.235351]  #0: ff11000006045d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2ff/0x960
> [  300.236502]  #1: ffa0000000117e60 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x303/0x960
> [  300.237696]
> [  300.237882] =============================================
> [  300.237882]
> 
> Bisected and found the first bad commit is:
> eebd2e37e662617a6b8041db75205f0a262ce870
> io_uring: don't take task ring-file notes
> 
> But after reverted above commit eebd2e37e on top of v6.2-rc5 kernel and made
> the kernel failed. So it's just the suspected commit for above problem.
> 
> Syzkaller reproduced code, bisect info, kconfig and v6.2-rc5 dmesg are in
> attached.
> 
> All detailed info is in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/230124_055801_io_ring_exit_work
> 
> I hope it's helpful.
> 
> Thanks!
> BR.

-- 
Pavel Begunkov
