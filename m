Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7676521AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiLTNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLTNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:47:24 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0A63EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:47:22 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id 97so2864676uam.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVeLoqXHDdEY++spzbSQ8fZ7YOLAGM87RhDMbRiu33A=;
        b=KW0xW2q4x7FcPnfxpIRPrG6OkKXU9/l9h3qoqF+vxfBML6QrMYgS2EWenpj1SP3af8
         78GnZhAphPt/kFXETy+P9ARj9JIX/jUo9tkrz0GRb3MV3f7pi0QYd3c2s9o678PZ1eBI
         PsttecEwu1JW2rfdwfwBKLc5qpyvZLVk5MraAddGa3+Wk7Ougwtq8eglAvtWnrpNUCUS
         KfiA3b0098QEhleJoUAcLCg0A9ewkiDdNhMxcr2MZujXBCRdEi6uqWjrvvqHtxElk+9A
         s3YnQFOBY6XC5nZ0obv8Zvyrk+jcpeEO3dInfKjKWLxy5v0FF72ViSGo/wc5jElJcJq6
         cnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVeLoqXHDdEY++spzbSQ8fZ7YOLAGM87RhDMbRiu33A=;
        b=pntR3THrlSZoUismlspJJdE2rRhVRRmuWynQZjokdoDzZQl9r1R6uoAeZqpdHVprZ5
         jr+Z09BQiWS+A4MPNYldgt6xYONy7NlxpdTO4VDdT7FSh9FR/5RfuE4s7NwS1JT0GjBS
         WjMLhoT/tVbpExBwN0JE7naS4BOxG/QotyAl69IZNlNgbzOFLTgumbVHVX+hGdbwTeZP
         e3gYe3TR5DHTfUyncMJEKFM65XYccihOlHjLf6hayqK8w7rxM8+49c43rxzd5ba5AM6j
         UH+stJoJWH5QwpkwTtvGtAASmh/hf5htTeLYj2cR+l0DuWGEgVuJIKbVRmu4iGbBBmFl
         UUtw==
X-Gm-Message-State: ANoB5pmB2SbB+FmjS7x+1AiqV2CH0LZ73orxdjkREKELqQHyuiUABo6K
        Ish3SsFOisTZGJdvyJcMr8s3fRgoH+JhRP/cxsf4Tw==
X-Google-Smtp-Source: AA0mqf6W5zpDKROjnMl3GTjIXaJn/aDyyirurkunUdso7ifE6KFYTLQyFvO/n1jCPAVwyJOIhMU88JPNhp0PxlfMVBc=
X-Received: by 2002:ab0:77c1:0:b0:418:620e:6794 with SMTP id
 y1-20020ab077c1000000b00418620e6794mr58514960uar.59.1671544041123; Tue, 20
 Dec 2022 05:47:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
 <1671532079.1159124-1-xuanzhuo@linux.alibaba.com> <20221220054938-mutt-send-email-mst@kernel.org>
 <CGME20221220131747eucas1p1411947fee7d65825ccedad8f8a12a4df@eucas1p1.samsung.com>
 <206f30df-4833-3909-2d01-472fcfa2baa6@samsung.com> <20221220082606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221220082606-mutt-send-email-mst@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Dec 2022 19:17:09 +0530
Message-ID: <CA+G9fYtaKquTs-pz2Lc2bgDiQw5d2nFKK1kGwFR2WWDBKNbRkQ@mail.gmail.com>
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org, dmitry.fomichev@wdc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 at 18:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 20, 2022 at 02:17:45PM +0100, Marek Szyprowski wrote:
> > On 20.12.2022 11:54, Michael S. Tsirkin wrote:
> > > On Tue, Dec 20, 2022 at 06:27:59PM +0800, Xuan Zhuo wrote:
> > >> On Tue, 20 Dec 2022 14:51:54 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >>> The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
> > >>> It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
> > >>>
> > >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >>>
> > >>> <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > >>> <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
> > >>> (Debian clang version 16.0.0
> > >>> (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
> > >>> 16.0.0) #1 SMP PREEMPT @1671498176
> > >>> <5>[    0.000000] random: crng init done
> > >>> <6>[    0.000000] Machine model: linux,dummy-virt
> > >>> ....
> > >>> <6>[    3.571098] loop: module loaded
> > >>> <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
> > >>> <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
> > >>> blocks (1.44 GB/1.34 GiB)
> > >>> <4>[    3.581234] ------------[ cut here ]------------
> > >>> <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
> > >>> <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP

<Trim>

> > > Testing this fixup now:

Thanks for providing a quick fix.

> > > commit f9503d0fd839b59e0f48b00c20635437c41420ed
> > > Author: Michael S. Tsirkin <mst@redhat.com>
> > > Date:   Tue Dec 20 05:53:41 2022 -0500
> > >
> > >      fixup! virtio-blk: add support for zoned block devices
> >
> > I also confirm that this patch fixes the issue with broken virtio block
> > device observed on QEMU arm/arm64 'virt' machines and linux
> > next-20221220. Thanks for the fix!
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> Merged the fix already so I'm not sure I can add this tag.
> If I rebase before pull request I will, thanks!

[Sorry for delayed reply]

> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index ff49052e26f7..d8cdaeb51d1c 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -775,6 +775,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
> > >     return ret;
> > >   }
> > >
> > > +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> > > +{
> > > +   return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
> > > +}
> > >   #else
> > >
> > >   /*
> > > @@ -790,6 +794,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
> > >   {
> > >     return -EOPNOTSUPP;
> > >   }
> > > +
> > > +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> > > +{
> > > +   return false;
> > > +}
> > >   #endif /* CONFIG_BLK_DEV_ZONED */
> > >
> > >   /* return id (s/n) string for *disk to *id_str
> > > @@ -1576,11 +1585,11 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >             else
> > >                     q->limits.discard_granularity = blk_size;
> > >     }
> > >
> > >     virtblk_update_capacity(vblk, false);
> > >     virtio_device_ready(vdev);
> > >
> > > -   if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> > > +   if (virtblk_has_zoned_feature(vdev)) {
> > >             err = virtblk_probe_zoned_device(vdev, vblk, q);
> > >             if (err)
> > >                     goto out_cleanup_disk;
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland


--
Linaro LKFT
https://lkft.linaro.org
