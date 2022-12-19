Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D4650734
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 05:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiLSEjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 23:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSEjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 23:39:12 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B59592
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:39:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d20so11337595edn.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLUZjWcghSAP0Jcw1C/k6kbbyQzYb6OIC4BK30LiWEw=;
        b=P/vBoKQf5XqdFa45bFbzUHUX5rhLqbIrGPk7w5fDus5Cfx8IHPM0XRwWdbbJEJytUR
         SltFGVjrurR6o4shT433ybEXkqOjxM0aLEwzpSE8ZVbf5tSjeNo3ohzitwQtfXg5My2s
         UQ1v9fHzjERiR0+UxUf+YJedIAOpXH/8v/q/WccqyVhFTvIlFPq6f5Y1VLEZKiA2adUJ
         ZsfGABzZ7FFBMhCAgI4dBU0soLw2v4C79ERJU8+1C2RAkP6+KMpZOML26CBchJNk42T2
         AeEOc27CcsI+Fhd31n1VBDw2JMrr0q9Ny+TXL1OsyLzhtgOsB6fwGdtLy61gC5Tx0+6K
         jkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLUZjWcghSAP0Jcw1C/k6kbbyQzYb6OIC4BK30LiWEw=;
        b=W96bpeJ9Mbb0cQb5zbH4+BC3Ux37PkQnw70VMW7DviIM3/JZ1Pf+d1fp1H8+ehNKW/
         rPiuj2HMk5dsKmoLoiyfsvxq+N3BWgDfrsBKis2QOCcaN4O9OO5pVOjNUmGEvyfEHHla
         ApZP4aunA+GuCQUrT/++PxGP2aQqJGxYJDbToaSB0lk7IxHGXfDyhnMzgX0v244Toz+g
         Y4oS/H4e8U4x0xW/xYf4VItUljpRL3U7dEvzfhyGbTURLCihKuL8g4fGHNm33mJMDpCZ
         RaBVCZ0bpAvbhrd+axJ/xNZ2CbJy36qLN4igbX7dG4eGSZCPh9kNk7+u+59CpqcBkOv1
         sTLQ==
X-Gm-Message-State: ANoB5pkC+K3qTGDsCI4yHv3TxxOvqqXL4Seuh1hYZUh4NbG3Jxz36J3F
        QOD9dHcJhc/4uP4e+fihXH0Qft2ukhhMoQH8NvGu
X-Google-Smtp-Source: AA0mqf72rvbmL6gSbaiRROP4StbRyZyY9f5+SBB9OoCNbU7Nf+5ZZ0e+fD3c6XUIYukTkA03I4yfYkiMdoAOUivzzs8=
X-Received: by 2002:a05:6402:230f:b0:46c:dc40:4635 with SMTP id
 l15-20020a056402230f00b0046cdc404635mr17616087eda.358.1671424749327; Sun, 18
 Dec 2022 20:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
In-Reply-To: <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 12:38:58 +0800
Message-ID: <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > This introduces set_irq_affinity callback in
> > vdpa_config_ops so that vdpa device driver can
> > get the interrupt affinity hint from the virtio
> > device driver. The interrupt affinity hint would
> > be needed by the interrupt affinity spreading
> > mechanism.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/virtio/virtio_vdpa.c | 4 ++++
> >  include/linux/vdpa.h         | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index 08084b49e5a1..4731e4616ee0 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> >         const struct vdpa_config_ops *ops = vdpa->config;
> > +       struct irq_affinity default_affd = { 0 };
> >         struct vdpa_callback cb;
> >         int i, err, queue_idx = 0;
> >
> > +       if (ops->set_irq_affinity)
> > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
>
> I wonder if we need to do this in vhost-vDPA.

I don't get why we need to do this in vhost-vDPA? Should this be done in VM?

> Or it's better to have a
> default affinity by the vDPA parent
>

I think both are OK. But the default value should always be zero, so I
put it in a common place.

> (Looking at virtio-pci, it doesn't do something like this).
>

Yes, but we did something like this in the pci layer:
pci_alloc_irq_vectors_affinity().

Thanks,
Yongji
