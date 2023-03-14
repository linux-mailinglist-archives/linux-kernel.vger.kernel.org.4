Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D576B962E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCNN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjCNN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:27:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474D1351C;
        Tue, 14 Mar 2023 06:25:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v21so6455790ple.9;
        Tue, 14 Mar 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678800318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyvhYehpeRfb9AP6vCMFo3dvMbNupDfwlDmri9F9bbA=;
        b=bwv9wesUmgXY6fC4ncQ9XBImT0rgJniyEaPpMDLanDrxgj4Kpotl0lfDvQPGuwf1Zt
         kacWzT3VLOOqdJ+m2qyNGR7c9mkVK1qqhVuO2njrF6g2jndXcyh2ZXeoudsIzl9rdudB
         OLCtXtzVZjUoTSH8V7HQ1TNy5utnIHWYUCrpe6C5z9X47x+1LJ/0hnzjzLQr+RIzob1L
         nlkUEAwzHip0Z4rfQRTpNd3rjeh1G2prkw5hmtpODIAYLhK3DTjKcGFiA6+jVIqZoJpc
         r2MouqIzrkkCReDjbEdqrAHvsOzDLwDIEWZc0fvOv/BGoi/lzS8XKxbngPn3/0d1zCfj
         dzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyvhYehpeRfb9AP6vCMFo3dvMbNupDfwlDmri9F9bbA=;
        b=OGsy92ZDD5Hsiu7C33Eqm/+CXqGJPgt2VXyCVLtFlamkgeO//gkFra0qdtclrUprvR
         b/1wwvvamFqOzd813Vm63Mc3uTwNAqgbHvgrJtl3D/YWCcduVt+EZUTrWNp1IHxcCzK8
         rBPTJGZ/UNDMpPf1fo3GrSSCNzp8Qib+UfnzEaAJ8kVwKdLMpkXW7koAntpRcOPzDbn1
         /avYPsi+fpDsju6cySu7tUtaS+OvwO1boIM7z5ysuIz1Xb/tBj8nwSvgZ6FCkxBj4nJY
         DQ6I4KcSNX/1P0ABldNYBMJ7ROoz/J+fC82ViXweP/vmgfUhs9z2gQjJvwf7HwmNVdxd
         R3mw==
X-Gm-Message-State: AO0yUKWdnuZl4Ei9x2QDpgn7lQiougWpg2ZlSKApUW7l6h3GVRjgq2nT
        t1Bngt8U6gY4hxWgbG2Krh/Y0XHIG/0hI9n58VA=
X-Google-Smtp-Source: AK7set88CMQ57RlAibdExv9CkBt258UFDkdCpde450Pr1sl081IJ5NjE9s9y48aftdFchax6B0pqWub/y7afiN5rJNQ=
X-Received: by 2002:a17:902:f985:b0:19f:2802:dabb with SMTP id
 ky5-20020a170902f98500b0019f2802dabbmr3979299plb.12.1678800318488; Tue, 14
 Mar 2023 06:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <37c158cb-f527-34f5-2482-cae138bc8b07@molgen.mpg.de> <efb8d47b-ab9b-bdb9-ee2f-fb1be66343b1@molgen.mpg.de>
 <55e30408-ac63-965f-769f-18be5fd5885c@molgen.mpg.de> <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
 <30576384-682c-c021-ff16-bebed8251365@molgen.mpg.de> <cdc0b03c-db53-35bc-2f75-93bbca0363b5@molgen.mpg.de>
 <bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de> <c3390ab0-d038-f1c3-5544-67ae9c8408b1@cloud.ionos.com>
 <a27c5a64-62bf-592c-e547-1e8e904e3c97@molgen.mpg.de> <6c7008df-942e-13b1-2e70-a058e96ab0e9@cloud.ionos.com>
 <12f09162-c92f-8fbb-8382-cba6188bfb29@molgen.mpg.de> <6757d55d-ada8-9b7e-b7fd-2071fe905466@cloud.ionos.com>
 <93d8d623-8aec-ad91-490c-a414c4926fb2@molgen.mpg.de> <0bb7c8d8-6b96-ce70-c5ee-ba414de10561@cloud.ionos.com>
 <e271e183-20e9-8ca2-83eb-225d4d7ab5db@molgen.mpg.de> <1cdfceb6-f39b-70e1-3018-ea14dbe257d9@cloud.ionos.com>
 <7733de01-d1b0-e56f-db6a-137a752f7236@molgen.mpg.de> <d92922af-f411-fc53-219f-154de855cd13@cloud.ionos.com>
In-Reply-To: <d92922af-f411-fc53-219f-154de855cd13@cloud.ionos.com>
From:   Marc Smith <msmith626@gmail.com>
Date:   Tue, 14 Mar 2023 09:25:07 -0400
Message-ID: <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com>
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle" transition
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi Donald,
>
> On 2/8/21 19:41, Donald Buczek wrote:
> > Dear Guoqing,
> >
> > On 08.02.21 15:53, Guoqing Jiang wrote:
> >>
> >>
> >> On 2/8/21 12:38, Donald Buczek wrote:
> >>>> 5. maybe don't hold reconfig_mutex when try to unregister
> >>>> sync_thread, like this.
> >>>>
> >>>>          /* resync has finished, collect result */
> >>>>          mddev_unlock(mddev);
> >>>>          md_unregister_thread(&mddev->sync_thread);
> >>>>          mddev_lock(mddev);
> >>>
> >>> As above: While we wait for the sync thread to terminate, wouldn't it
> >>> be a problem, if another user space operation takes the mutex?
> >>
> >> I don't think other places can be blocked while hold mutex, otherwise
> >> these places can cause potential deadlock. Please try above two lines
> >> change. And perhaps others have better idea.
> >
> > Yes, this works. No deadlock after >11000 seconds,
> >
> > (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265,
> > 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>
> Great. I will send a formal patch with your reported-by and tested-by.
>
> Thanks,
> Guoqing

I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
of the patches that supposedly resolve this were applied to the stable
kernels, however, one was omitted due to a regression:
md: don't unregister sync_thread with reconfig_mutex held (upstream
commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)

I don't see any follow-up on the thread from June 8th 2022 asking for
this patch to be dropped from all stable kernels since it caused a
regression.

The patch doesn't appear to be present in the current mainline kernel
(6.3-rc2) either. So I assume this issue is still present there, or it
was resolved differently and I just can't find the commit/patch.

I can induce the issue by using Donald's script above which will
eventually result in hangs:
...
147948.504621] INFO: task md_test_2.sh:68033 blocked for more than 122 seco=
nds.
[147948.504624]       Tainted: P           OE     5.4.229-esos.prod #1
[147948.504624] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[147948.504625] md_test_2.sh    D    0 68033      1 0x00000004
[147948.504627] Call Trace:
[147948.504634]  __schedule+0x4ab/0x4f3
[147948.504637]  ? usleep_range+0x7a/0x7a
[147948.504638]  schedule+0x67/0x81
[147948.504639]  schedule_timeout+0x2c/0xe5
[147948.504643]  ? do_raw_spin_lock+0x2b/0x52
[147948.504644]  __wait_for_common+0xc4/0x13a
[147948.504647]  ? wake_up_q+0x40/0x40
[147948.504649]  kthread_stop+0x9a/0x117
[147948.504653]  md_unregister_thread+0x43/0x4d
[147948.504655]  md_reap_sync_thread+0x1c/0x1d5
[147948.504657]  action_store+0xc9/0x284
[147948.504658]  md_attr_store+0x9f/0xb8
[147948.504661]  kernfs_fop_write+0x10a/0x14c
[147948.504664]  vfs_write+0xa0/0xdd
[147948.504666]  ksys_write+0x71/0xba
[147948.504668]  do_syscall_64+0x52/0x60
[147948.504671]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
...
[147948.504748] INFO: task md120_resync:135315 blocked for more than
122 seconds.
[147948.504749]       Tainted: P           OE     5.4.229-esos.prod #1
[147948.504749] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[147948.504749] md120_resync    D    0 135315      2 0x80004000
[147948.504750] Call Trace:
[147948.504752]  __schedule+0x4ab/0x4f3
[147948.504754]  ? printk+0x53/0x6a
[147948.504755]  schedule+0x67/0x81
[147948.504756]  md_do_sync+0xae7/0xdd9
[147948.504758]  ? remove_wait_queue+0x41/0x41
[147948.504759]  md_thread+0x128/0x151
[147948.504761]  ? _raw_spin_lock_irqsave+0x31/0x5d
[147948.504762]  ? md_start_sync+0xdc/0xdc
[147948.504763]  kthread+0xe4/0xe9
[147948.504764]  ? kthread_flush_worker+0x70/0x70
[147948.504765]  ret_from_fork+0x35/0x40
...

This happens on 'raid6' MD RAID arrays that initially have sync_action=3D=
=3Dresync.

Any guidance would be greatly appreciated.

--Marc
