Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294465BD84D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiISXdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiISXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:33:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FF4F64A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:33:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t14so1504245wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zo4ltCOqvnTRmheIGSQtx2+8j/N9c4MsCQoSZifobiY=;
        b=XxYsJfS9I4u3WvjfJ8LQpuGZtQ78FQTZpF4Po6g58SMUSF6Fn44k9ioE1xDvYN0zvC
         zk6GHbBqA+hFVXCyzCBHcFdxF7txQaUlEQU51SiHbT5qT5oJ7wOy/vCT2fYtRe1R4lXF
         LoBZspappMyt+wvzYhW1/kWIyJm1lk31szvu2l4HVF5XpWbBnmbjaqNimDpYO39nrp8e
         YM5fLKYNI0CzlrAvOv+9ueG2bvqH9TQIy2DTLty7d9Ah+p48Z1hM4fE26ifh0wouojXR
         fv9RPnkXJ5VGsxPfHxkoxtZEKAX5vDeLlc2kdWL34d3L4yBwxwH0wBu90R6vzKig3aDP
         d6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zo4ltCOqvnTRmheIGSQtx2+8j/N9c4MsCQoSZifobiY=;
        b=EcR2MryftJXZ0/3X0c1OTXR5MtD41d+at4s1aO7qyyRNki6xaT/eRtBRdgo4O1lYSl
         ZOxFAh0U1ce9dxYvXXyqHQUcLORj3WlN/bqnZdqdA3p8Pszu7wJjzndK1QU79fGnMvzZ
         Zq16DZRh740FIAVu7vQaKGDpXG+wTfrPmm4FCiaiirtrUy+9F4gD5CzBCOetUKCzYkQf
         j2Rh7Wq64bKw3Bpsz2bltgtUg9q1rVtD+RGjxrt2MwXNHxVfTo4Gr4Ll1Qj6xXa7xhDv
         L4vOjMOXBeUSW7GMqQxl+km0KF3XmqC+stVC0XtnLcCVjCv+IdHlSC/ueXRqeDDmhwqo
         u+Jw==
X-Gm-Message-State: ACrzQf30H9i7xPxPNWbKZ+JX/fsiQoCrIBeqBdVRUcRuRk6uPbKAIgz7
        LiTUAeipxH0L0xBb2/sz5Mznmfx9HFt5rsOPfxeIsw==
X-Google-Smtp-Source: AMsMyM61zot+0K7KevmrJbjGPwZQugwWN++0y3OXLM2V8v5oKdcZe2nsAlItI7mSGEgqYGx02gZQBJIpkTZNB/gbG4E=
X-Received: by 2002:a5d:5611:0:b0:228:e1d2:81d with SMTP id
 l17-20020a5d5611000000b00228e1d2081dmr12193520wrv.210.1663630380280; Mon, 19
 Sep 2022 16:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn> <YyLUGnqtZXn4MjJF@casper.infradead.org>
 <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn> <YyLpls9/t6LKQefS@casper.infradead.org>
 <b52b3f49-ebf5-6f63-da1a-f57711c3f97d@loongson.cn> <YyQ2m9vU/plyBNas@casper.infradead.org>
 <4bd0012e-77ff-9d0d-e295-800471994aeb@loongson.cn>
In-Reply-To: <4bd0012e-77ff-9d0d-e295-800471994aeb@loongson.cn>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 19 Sep 2022 16:32:21 -0700
Message-ID: <CAJD7tkZkPVwQYR1mqZoKQ=kkR96JCUzrpw8o-9vtX3qwdkj-=w@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not kswapd
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 3:20 AM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> Hi Andrew and Matthew,
>
> On 2022/9/16 pm 4:40, Matthew Wilcox wrote:
> > On Fri, Sep 16, 2022 at 08:57:50AM +0800, Hongchen Zhang wrote:
> >> Hi Andrew ,
> >>
> >> On 2022/9/15 pm 5:00, Matthew Wilcox wrote:
> >>> On Thu, Sep 15, 2022 at 04:02:41PM +0800, Hongchen Zhang wrote:
> >>>> Hi Matthew,
> >>>> On 2022/9/15 pm 3:28, Matthew Wilcox wrote:
> >>>>> On Thu, Sep 15, 2022 at 09:19:48AM +0800, Hongchen Zhang wrote:
> >>>>>> [ 3748.453561] INFO: task float_bessel:77920 blocked for more than 120
> >>>>>> seconds.
> >>>>>> [ 3748.460839]       Not tainted 5.15.0-46-generic #49-Ubuntu
> >>>>>> [ 3748.466490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> >>>>>> this message.
> >>>>>> [ 3748.474618] task:float_bessel    state:D stack:    0 pid:77920 ppid:
> >>>>>> 77327 flags:0x00004002
> >>>>>> [ 3748.483358] Call Trace:
> >>>>>> [ 3748.485964]  <TASK>
> >>>>>> [ 3748.488150]  __schedule+0x23d/0x590
> >>>>>> [ 3748.491804]  schedule+0x4e/0xc0
> >>>>>> [ 3748.495038]  rwsem_down_read_slowpath+0x336/0x390
> >>>>>> [ 3748.499886]  ? copy_user_enhanced_fast_string+0xe/0x40
> >>>>>> [ 3748.505181]  down_read+0x43/0xa0
> >>>>>> [ 3748.508518]  do_user_addr_fault+0x41c/0x670
> >>>>>> [ 3748.512799]  exc_page_fault+0x77/0x170
> >>>>>> [ 3748.516673]  asm_exc_page_fault+0x26/0x30
> >>>>>> [ 3748.520824] RIP: 0010:copy_user_enhanced_fast_string+0xe/0x40
> >>>>>> [ 3748.526764] Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f
> >>>>>> 01 ca c3 cc cc cc cc 0f 1f 00 0f 01 cb 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3>
> >>>>>> a4 31 c0 0f 01 ca c3 cc cc cc cc 66 08
> >>>>>> [ 3748.546120] RSP: 0018:ffffaa9248fffb90 EFLAGS: 00050206
> >>>>>> [ 3748.551495] RAX: 00007f99faa1a010 RBX: ffffaa9248fffd88 RCX:
> >>>>>> 0000000000000010
> >>>>>> [ 3748.558828] RDX: 0000000000001000 RSI: ffff9db397ab8ff0 RDI:
> >>>>>> 00007f99faa1a000
> >>>>>> [ 3748.566160] RBP: ffffaa9248fffbf0 R08: ffffcc2fc2965d80 R09:
> >>>>>> 0000000000000014
> >>>>>> [ 3748.573492] R10: 0000000000000000 R11: 0000000000000014 R12:
> >>>>>> 0000000000001000
> >>>>>> [ 3748.580858] R13: 0000000000001000 R14: 0000000000000000 R15:
> >>>>>> ffffaa9248fffd98
> >>>>>> [ 3748.588196]  ? copy_page_to_iter+0x10e/0x400
> >>>>>> [ 3748.592614]  filemap_read+0x174/0x3e0
> >>>>>
> >>>>> Interesting; it wasn't the process itself which triggered the page
> >>>>> fault; the process called read() and the kernel took the page fault to
> >>>>> satisfy the read() call.
> >>>>>
> >>>>>> [ 3748.596354]  ? ima_file_check+0x6a/0xa0
> >>>>>> [ 3748.600301]  generic_file_read_iter+0xe5/0x150
> >>>>>> [ 3748.604884]  ext4_file_read_iter+0x5b/0x190
> >>>>>> [ 3748.609164]  ? aa_file_perm+0x102/0x250
> >>>>>> [ 3748.613125]  new_sync_read+0x10d/0x1a0
> >>>>>> [ 3748.617009]  vfs_read+0x103/0x1a0
> >>>>>> [ 3748.620423]  ksys_read+0x67/0xf0
> >>>>>> [ 3748.623743]  __x64_sys_read+0x19/0x20
> >>>>>> [ 3748.627511]  do_syscall_64+0x59/0xc0
> >>>>>> [ 3748.631203]  ? syscall_exit_to_user_mode+0x27/0x50
> >>>>>> [ 3748.636144]  ? do_syscall_64+0x69/0xc0
> >>>>>> [ 3748.639992]  ? exit_to_user_mode_prepare+0x96/0xb0
> >>>>>> [ 3748.644931]  ? irqentry_exit_to_user_mode+0x9/0x20
> >>>>>> [ 3748.649872]  ? irqentry_exit+0x1d/0x30
> >>>>>> [ 3748.653737]  ? exc_page_fault+0x89/0x170
> >>>>>> [ 3748.657795]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >>>>>> [ 3748.663030] RIP: 0033:0x7f9a852989cc
> >>>>>> [ 3748.666713] RSP: 002b:00007f9a8497dc90 EFLAGS: 00000246 ORIG_RAX:
> >>>>>> 0000000000000000
> >>>>>> [ 3748.674487] RAX: ffffffffffffffda RBX: 00007f9a8497f5c0 RCX:
> >>>>>> 00007f9a852989cc
> >>>>>> [ 3748.681817] RDX: 0000000000027100 RSI: 00007f99faa18010 RDI:
> >>>>>> 0000000000000061
> >>>>>> [ 3748.689150] RBP: 00007f9a8497dd60 R08: 0000000000000000 R09:
> >>>>>> 00007f99faa18010
> >>>>>> [ 3748.696493] R10: 0000000000000000 R11: 0000000000000246 R12:
> >>>>>> 00007f99faa18010
> >>>>>> [ 3748.703841] R13: 00005605e11c406f R14: 0000000000000001 R15:
> >>>>>> 0000000000027100
> >>>>>
> >>>>> ORIG_RAX is 0, which matches sys_read.
> >>>>> RDI is file descriptor 0x61
> >>>>> RSI is plausibly a userspace pointer, 0x7f99faa18010
> >>>>> RDX is the length, 0x27100 or 160kB.
> >>>>>
> >>>>> That all seems reasonable.
> >>>>>
> >>>>> What I really want to know is who is _holding_ the lock.  We stash
> >>>>> a pointer to the task_struct in 'owner', so we could clearly find this
> >>>>> out in the 'blocked for too long' report, and print their stack trace.
> >>>>>
> >>>> As described in the comment for __rwsem_set_reader_owned,it is hard to track
> >>>> read owners.So we could not clearly find out who blocked the process,it was
> >>>> caused by multiple tasks.
> >>>
> >>> Readers don't block readers.  You have a reader here, so it's being
> >>> blocked by a writer.  And that writer's task_struct is stashed in
> >>> rwsem->owner.  It would be nice if we dumped that information
> >>> automatically ... but we don't do that today.  Perhaps you could
> >>> grab that information from a crash dump if you have one.
> >>>
> >>>>> You must have done something like this already in order to deduce that
> >>>>> it was the direct reclaim path that was the problem?
> >>>>>
> >>>> The method we used is to track the direct reclaim using the
> >>>> trace_mm_vmscan_direct_reclaim_{begin,end} interface.When the problem
> >>>> occurred,we could get a very large "nr_reclaimed" which is not a desirable
> >>>> value for process except kswapd.
> >>>
> >>> I disagree.  If a process needs to allocate memory then it should be
> >>> paying the cost of reclaiming that memory itself.  kswapd is a last
> >>> resort to reclaim memory when we have a workload (eg a network router)
> >>> that does its memory allocation primarily in interrupt context.
> >>>
> >> What's your opinion about this scan adjust issue? Is there a better way to
> >> fix this issue?
> >
> > Yes, but we need you to gather more information about what's causing
> > the issue before we can suggest what that is.
> >
> I think the following scenery triggers the scan adjust issue:
> In function shrink_lruvec, we call get_scan_count and get the following
> values:
> targets[LRU_INACTIVE_ANON]=50000
> targets[LRU_ACTIVE_ANON]=50000
> targets[LRU_INACTIVE_FILE]=128
> targets[LRU_ACTIVE_FILE]=129
>
> After the first scan, we get more than nr_to_reclaim pages, but the
> percentage of scanning nr[LRU_INACTIVE_FILE+LRU_ACTIVE_FILE] is 256/257,
>
> Then when we scan adjust, we must scan(possibly reclaim)
> 256*(50000+50000)/257-256=99354 pages, which is too large and would
> waste too many time.
> If it is not kswapd, it is unacceptable to reclaim so many pages.
> So we should limit the number of pages of scan adjust.

IIUC commit 6eb90d649537 ("mm: vmscan: fix extreme overreclaim and
swap floods") that was recently sent by Johannes [1] addresses a
similar issue (reclaiming way beyond nr_to_reclaim when anon vs file
LRU sizes are very different), but in a slightly different scenario.
IIUC with Johannes's patch, scan adjustment is already limited for
scenarios where scan_adjust (aka proportional_reclaim) is not
initialized to true, which would be all cases except global direct
reclaim on DEF_PRIORITY. Is my understanding here correct?

[1] https://lore.kernel.org/lkml/20220802162811.39216-1-hannes@cmpxchg.org/
>
> Thanks
> Hongchen Zhang
>
>
