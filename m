Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54951625968
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiKKLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:35:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB182D1CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:35:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h14so4217695pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoIY7DKb5p1kzhT5B2FzSv6iW2VGwt91bZbpKjEpyDc=;
        b=p3rDoP1vzMyiRRpiEQt/A//n+YOLwJjuDcx6Ad8cZLYHt3AV2mn6IECAHucxBly8wa
         IwXWelN9jCtYtZE5OvWX+7nu4uJHquce4b3nwUS2IgHAl1KN6c8MnWSVSN5rLDrZBhSZ
         koSlwkqjvWk9CdVR6Nc21VNV34uLjn4X/p+5DzoPcpHol3Z2evfQATkrfjCys+cDrNiQ
         cAsa4NtP+vdaioJUqMPb4yI5U9jqjxrzzAsgO0GiPBBe5aea8YJ9OqmLsp4saCnyeepn
         ig4GJGEK1U51ozSj7kzRRN75VBvItfk6AvIw+T6e4P/ESf7ZDdw2xUFYy+gBsRJlxgZv
         g7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoIY7DKb5p1kzhT5B2FzSv6iW2VGwt91bZbpKjEpyDc=;
        b=nSqFgkHi6pqirv4B3YkQOYKQEetE2ltaDCc2eb5FlDITZtODhPvBQ3p1iiSWk8Nvbk
         gtK3OvdfvwqldZKg9EBlPwyFwT/xEP3sBX1ML1xMqunlrSTXPM6TrGGliURZ0LiPu+D6
         3YzVPKSyMzOX10aGIqmjDfiEs7JkGLHVYMErBkL9BzB+5osk4gplfQB0UNCZHpMYRvqp
         e18G9aM+bui7wX6QtT+NFf3w6hhg128QDsD50ZBntsfIiXK53ilkQC33L0x4T3qUET9s
         rvTCesr2wGQ5yzGQ93ykbnQmaFzm0z3znt56/Pz8jnHMq2d12GeXR38947wCDxH98m9V
         RjMw==
X-Gm-Message-State: ANoB5pmvaaxii/I1b/x0WXOJpGojrm6BwVMsQNo7ZX7PQONMk5K7L0qx
        Caw4m2hK1LQLN1fPAwvtnB5tDsLa5OX1voJ/mqvHhw==
X-Google-Smtp-Source: AA0mqf4l1aJGllrWXMtwrV/h85w3mWa0CRJ72auSdt1G0JNnkGkUQh2Ngu/T9fGBTTwpHSxmeA6cshKZKMSEE2vU6mQ=
X-Received: by 2002:a17:902:c142:b0:188:55f5:972f with SMTP id
 2-20020a170902c14200b0018855f5972fmr2095276plj.148.1668166511266; Fri, 11 Nov
 2022 03:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com> <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
In-Reply-To: <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Nov 2022 12:34:34 +0100
Message-ID: <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com, CLoehle@hyperstone.com,
        vincent.whitchurch@axis.com, bigeasy@linutronix.de,
        s.shtylyov@omp.ru, michael@allwinnertech.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 at 08:59, Wenchao Chen <wenchao.chen666@gmail.com> wrot=
e:
>
> Hi Hunter
> Thank you for your review!
> I'm sorry to reply you so late because I've been too busy lately.
>
> On Fri, Oct 21, 2022 at 11:50 PM Adrian Hunter <adrian.hunter@intel.com> =
wrote:
> >
> > On 21/10/22 10:30, Wenchao Chen wrote:
> > > From: Wenchao Chen <wenchao.chen@unisoc.com>
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] supports the host to turn off FUA.
> > >
> > > About FUA, roughly deal with the following two parts:
> > > 1) FUA(Forced Unit Access):
> > > - The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted=
 from the
> > >   filesystem and will make sure that I/O completion for this request =
is only
> > >   signaled after the data has been committed to non-volatile storage.
> > >
> > > 2) In emmc, FUA is represented as Reliable write. code show as below:
> > > static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_=
req *mqrq,
> > >               int recovery_mode, bool *do_rel_wr_p, bool *do_data_tag=
_p)
> > > {
> > >       ...
> > >       /*
> > >        * Reliable writes are used to implement Forced Unit Access and
> > >        * are supported only on MMCs.
> > >        */
> > >       do_rel_wr =3D (req->cmd_flags & REQ_FUA) &&
> > >                       rq_data_dir(req) =3D=3D WRITE &&
> > >                       (md->flags & MMC_BLK_REL_WR);
> > >       ...
> > > }
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1:  for block
> > > patch#2:  for sdhci-sprd
> > >
> > > Tests
> > > =3D=3D=3D=3D=3D
> > > Ran 'AndroBench' to evaluate the performance:
> >
> > It would be good to have more details e.g.
> > What file system? What block size?  What journal size?
> > What file size? What record size?
> >
>
> What file system?
> F2FS
> What block size?
> Sequential: 32768KB, Random: 4KB
> What file size?
> 64MB
>
> > > 1. fua_disable =3D 1
> > > /sys/block/mmcblk0/queue # cat fua 0
> > > I tested 5 times for each case and output a average speed.
> > >
> > > 1) Sequential read:
> > > Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
> > > Average speed: 265.74MiB/s
> > >
> > > 2) Random read:
> > > Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
> > > Average speed: 98.81MiB/s
> > >
> > > 3) Sequential write:
> > > Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
> > > Average speed: 200.5MiB/s
> > >
> > > 4) Random write:
> > > Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
> > > Average speed: 70.32MiB/s
> > >
> > > 2. fua_disable =3D 0 (default 0)
> > > /sys/block/mmcblk0/queue # cat fua 1
> > > I tested 5 times for each case and output a average speed.
> > >
> > > 1) Sequential read:
> > > Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
> > > Average speed: 257.86MiB/s
> > >
> > > 2) Random read:
> > > Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
> > > Average speed: 100.2MiB/s
> > >
> > > 3) Sequential write:
> > > Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
> > > Average speed: 149.48MiB/s
> > >
> > > 4) Random write:
> > > Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
> > > Average speed: 12.68MiB/s
> >
> > Is every write being sync'ed of just sync at the end?
> >
>
> /*
> * Reliable writes are used to implement Forced Unit Access and
> * are supported only on MMCs.
> */
> do_rel_wr =3D (req->cmd_flags & REQ_FUA) &&
>     rq_data_dir(req) =3D=3D WRITE &&
>     (md->flags & MMC_BLK_REL_WR);
>
> A Reliable Write access shall force the data to be written to the
> nonvolatile storage=E3=80=82
> It will consume more time.

My apologies for side-stepping the discussion.

Yes, REQ_FUA is per definition a write and a flush of the
write-back-cache to non-volatile storage. So, this is indeed the
correct behaviour, even if it consumes more time to complete the
operation.

>
> > >
> > > According to the above data, disable FUA (fua_disable =3D 1) improves=
 the
> > > performance:
> > > 1)Sequential read improved by 3%.
> > > 2)Random read were down 1%.
> >
> > FUA should not affect reads.  If it is, you may want to investigate how=
.
> >
> > > 3)Sequential write improved by 34%.
> > > 4)Random write improved by 454%.
> > > Therefore, it is recommended to support the host to control FUA.
> > >
> > > Reference
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/block/writeback_cache_control.rst
> > > [2] Embedded Multi-Media Card (e=E2=80=A2MMC) Electrical Standard (5.=
1)''
> >
> > You do not seem to have considered data integrity.
> >
> > Regular disks are assumed to provide atomic sector writes.  That is, a =
sector has either the old data or the new data, but not some corrupt mixtur=
e.
> >
> > mmc does not have that assumption, which is presumably why Reliable Wri=
te has been used instead.  Although that idea appears to have been thrown a=
way for devices with no cache by commit 08ebf903af57 ("mmc: core: Fixup sup=
port for writeback-cache for eMMC and SD").
> >
> > File systems can use FUA to mark a successful journal flush.  Whether o=
r not getting a torn sector at that point will corrupt the file system reco=
very is presumably file system specific, and maybe specific to file system =
options e.g. the use of checksums.
> >
> > It may well be that a file system can survive a torn sector at that poi=
nt, or that user space would prefer to take the risk in order to get better=
 performance.  In either of those cases, it is not really a decision for th=
e host controller driver.
> >
>
> Considering the data integrity, we did a random power-down test, and
> the experimental results were good.
>
> FUA can only reduce data loss under abnormal conditions, but cannot
> prevent data loss under abnormal conditions.
>
> I think there should be a balance between FUA and NO FUA, but
> filesystems seem to favor FUA.
>
> FUA brings a drop in random write performance. If enough tests are
> done, NO FUA is acceptable.

Testing this isn't entirely easy. It requires you to hook up
electrical switches to allow you to automate the powering on/off of
the platform(s). Then at each cycle, really make sure to stress test
the data integrity of the flash memory. Is that what the tests did -
or can you elaborate a bit on what was really tested?

In any case, the performance impact boils down to how each eMMC/SD
card internally manages reliable writes vs regular writes. Some
vendors may treat them very similarly, while others do not.

That said, trying to disable REQ_FUA from an mmc host driver is the
wrong approach, as also pointed out by Adrian above. These types of
decisions belong solely in the mmc core layer.

Instead of what the $subject series proposes, I would rather suggest
we discuss (and test) whether it could make sense to disable REQ_FUA -
*if* the eMMC/SD card supports a write-back-cache (REQ_OP_FLUSH) too.
Hence, the mmc core could then announce only REQ_OP_FLUSH.

Kind regards
Uffe
