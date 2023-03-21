Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC46C3981
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCUSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:48:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD041303C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:47:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so63552480ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679424467;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl5X5MqC7bg3NRfVzqVtG44I2e1+8u3vC+PcI2uKURk=;
        b=qvYsEFYV6EIvC+aAFzJQiIcWWiiIl1XRtBQcUHRtgt/jyZ2G5NtSA1F7WB3dWsn7yO
         4BUt3Qdx63hygN4iaXi0SdEckFpPTZy7IDESo7rxLK9NSrf0fFkXwE2yQq7iVQalaWeh
         B5ShgdAuoK4lQ1yXbTuz5/aNMn8JCFmgOgnjhjx0/N1gVoXl2FbZGPj7/eEe342hjd3D
         jw8hSggkAc6a8MS7ATRhV/pFtwakwYkm5f30/kgxEymJ8/NlAnmneHM7rqQxvN++UMLn
         ElX92b41c/EencvYrCXTaXxUWVfIuqD67QwWA0wlm0kRx6C2tizNZELt/HxIlTmeAtfu
         BSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424467;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kl5X5MqC7bg3NRfVzqVtG44I2e1+8u3vC+PcI2uKURk=;
        b=vLeZD4KpC0ejgTY9VG2t8d5NLOn8r7x+9g+5a4MbxJi6tdNH9HvQDFu60J0jauTKp3
         ilkIkgpkOYP/J6A4/RsxOJk/l1pu7NQFKwBMhZVk5XlKBveNHQJXXDJ1CAlROB3XciHe
         jWFH/CYGngMM6mjiSq77RSBRqNGEZHcZ35xdT5zjpxQnumn4uInZVALlwWStd8DAdORv
         diBLXACF27EeNmPszOKZeSqRfco62CG4OdBtfcL4NbEfGROghxIJBhd44PMpECuTtZxD
         Vk2AQCA11VnrtnZF4VQvJ8kMaMKHOmC82BdxZ1wCi8Q+9CG57WH7ORinUu86Ep2wpkE9
         wY4Q==
X-Gm-Message-State: AO0yUKVLqNDPe4lBgQeBtkeL8VCzkBT47dRDY6l2G8xdSqTY6Xxijp62
        X78Ie2TgCeoAae6ESfsIN70=
X-Google-Smtp-Source: AK7set//tAW2ndcJsKnbOhL6XexFtRCFertSQ5uWqN2uLR0aJNvpf33Ek5E0k2WVsr60Fw2LEc1C+w==
X-Received: by 2002:a17:906:5847:b0:92b:f8ce:4e75 with SMTP id h7-20020a170906584700b0092bf8ce4e75mr4087292ejs.72.1679424466718;
        Tue, 21 Mar 2023 11:47:46 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:67fe:537e:316f:d8a? ([2a02:908:1256:79a0:67fe:537e:316f:d8a])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm3486032ejc.100.2023.03.21.11.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:47:46 -0700 (PDT)
Message-ID: <66bb5e3a-c62b-d529-5c9b-f9d29bd51809@gmail.com>
Date:   Tue, 21 Mar 2023 19:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: BUG: KASAN: slab-use-after-free in
 drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Grodzovsky, Andrey" <andrey.grodzovsky@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMMzsYsMbFoX+ThrjVwq9DLnWiNhappxtmA=NAzPHYVMQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsMMzsYsMbFoX+ThrjVwq9DLnWiNhappxtmA=NAzPHYVMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Am 20.03.23 um 13:05 schrieb Mikhail Gavrilov:
> Hi,
> after enabling KASAN literally I was bombarded with messages about
> slab-use-after-free in drm_sched_get_cleanup_job.

mhm, interesting.

> All messages has similar backtrace:
> [ 1138.492091] ==================================================================
> [ 1138.492104] BUG: KASAN: slab-use-after-free in
> drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
> [ 1138.492120] Read of size 8 at addr ffff88815adf04c0 by task sdma1/749
>
> [ 1138.492130] CPU: 29 PID: 749 Comm: sdma1 Tainted: G        W    L
>   -------  ---  6.3.0-0.rc2.20230317git38e04b3e4240.27.fc39.x86_64+debug
> #1
> [ 1138.492136] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4601 02/02/2023
> [ 1138.492141] Call Trace:
> [ 1138.492145]  <TASK>
> [ 1138.492150]  dump_stack_lvl+0x72/0xc0
> [ 1138.492159]  print_report+0xcf/0x670
> [ 1138.492169]  ? drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
> [ 1138.492181]  ? drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
> [ 1138.492193]  kasan_report+0xa4/0xe0
> [ 1138.492200]  ? drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
> [ 1138.492215]  drm_sched_get_cleanup_job+0x47b/0x5c0 [gpu_sched]
> [ 1138.492229]  drm_sched_main+0x643/0x990 [gpu_sched]
> [ 1138.492245]  ? __pfx_drm_sched_main+0x10/0x10 [gpu_sched]
> [ 1138.492259]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1138.492269]  ? __kthread_parkme+0xc1/0x1f0
> [ 1138.492277]  ? __pfx_drm_sched_main+0x10/0x10 [gpu_sched]
> [ 1138.492288]  kthread+0x29e/0x340
> [ 1138.492294]  ? __pfx_kthread+0x10/0x10
> [ 1138.492301]  ret_from_fork+0x2c/0x50
> [ 1138.492314]  </TASK>
>
> [ 1138.492320] Allocated by task 10867:
> [ 1138.492323]  kasan_save_stack+0x2f/0x50
> [ 1138.492329]  kasan_set_track+0x21/0x30
> [ 1138.492334]  __kasan_kmalloc+0x8b/0x90
> [ 1138.492339]  amdgpu_driver_open_kms+0x10b/0x5a0 [amdgpu]
> [ 1138.493112]  drm_file_alloc+0x46e/0x880
> [ 1138.493120]  drm_open_helper+0x161/0x460
> [ 1138.493126]  drm_open+0x1e7/0x5c0
> [ 1138.493131]  drm_stub_open+0x24d/0x400
> [ 1138.493138]  chrdev_open+0x215/0x620
> [ 1138.493144]  do_dentry_open+0x5f1/0x1000
> [ 1138.493149]  path_openat+0x1b3d/0x28a0
> [ 1138.493156]  do_filp_open+0x1bd/0x400
> [ 1138.493161]  do_sys_openat2+0x140/0x420
> [ 1138.493167]  __x64_sys_openat+0x11f/0x1d0
> [ 1138.493173]  do_syscall_64+0x5b/0x80
> [ 1138.493179]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> [ 1138.493189] Freed by task 10867:
> [ 1138.493193]  kasan_save_stack+0x2f/0x50
> [ 1138.493199]  kasan_set_track+0x21/0x30
> [ 1138.493205]  kasan_save_free_info+0x2a/0x50
> [ 1138.493210]  __kasan_slab_free+0x107/0x1a0
> [ 1138.493216]  slab_free_freelist_hook+0x11e/0x1d0
> [ 1138.493221]  __kmem_cache_free+0xbc/0x2e0
> [ 1138.493227]  amdgpu_driver_postclose_kms+0x582/0x8d0 [amdgpu]
> [ 1138.493963]  drm_file_free.part.0+0x638/0xb70
> [ 1138.493969]  drm_release+0x1ea/0x470
> [ 1138.493975]  __fput+0x213/0x9e0
> [ 1138.493981]  task_work_run+0x11b/0x200
> [ 1138.493987]  exit_to_user_mode_prepare+0x23a/0x260
> [ 1138.493994]  syscall_exit_to_user_mode+0x16/0x50
> [ 1138.494001]  do_syscall_64+0x67/0x80
> [ 1138.494006]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> [ 1138.494015] The buggy address belongs to the object at ffff88815adf0000
>                  which belongs to the cache kmalloc-4k of size 4096
> [ 1138.494021] The buggy address is located 1216 bytes inside of
>                  freed 4096-byte region [ffff88815adf0000, ffff88815adf1000)
>
> [ 1138.494030] The buggy address belongs to the physical page:
> [ 1138.494034] page:0000000017cd5a82 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x15adf0
> [ 1138.494041] head:0000000017cd5a82 order:3 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [ 1138.494046] flags:
> 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [ 1138.494055] raw: 0017ffffc0010200 ffff88810004d040 dead000000000122
> 0000000000000000
> [ 1138.494061] raw: 0000000000000000 0000000000040004 00000001ffffffff
> 0000000000000000
> [ 1138.494065] page dumped because: kasan: bad access detected
>
> [ 1138.494071] Memory state around the buggy address:
> [ 1138.494076]  ffff88815adf0380: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 1138.494080]  ffff88815adf0400: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 1138.494084] >ffff88815adf0480: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 1138.494088]                                            ^
> [ 1138.494092]  ffff88815adf0500: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 1138.494095]  ffff88815adf0580: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 1138.494099] ==================================================================
> [ 1138.494140] Disabling lock debugging due to kernel taint
>
> First thing I checked RAM for sure that it is definitely not a
> hardware problem. I started investigating which application triggered
> this message. I started to notice that it usually happens when any
> game starts in the steam client. So I came to the culprit of the
> problem is the compilation of shaders. For reproduction we should have
> a kernel with enabled KASAN and a steam client. After allowing
> background processing of Vulkan shaders the issue happens.
> Unfortunately it does not happen immediately as you may expect.
> I record four screencasts and uploaded them on to youtube [1-4] for
> proving that definitely processing of Vulkan shaders  culprit here but
> this may happens after some time.
>
> [1] https://youtu.be/hFuWlGTbetg
> [2] https://youtu.be/TAOqoYUYA5Q
> [3] https://youtu.be/9SZNXWhwAZs
> [4] https://youtu.be/W9gtYyL-2pg
>
> I do not know which information would be also useful. Please ask me.
>
> I attached a full kernel log and config if someone would be interested
> to see it.

That looks like a reference counting issue to me.

I'm going to take a look, but we have already fixed one of those recently.

Probably best that you try this on drm-fixes, just to double check that 
this isn't the same issue.

Thanks,
Christian.
