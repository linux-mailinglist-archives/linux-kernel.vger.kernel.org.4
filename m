Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778206CB4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjC1Deg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjC1DeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:34:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EEF198D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:33:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id cu12so7035016pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679974391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir5V99A0zsoCPWi1/drgb88gCMu5kFYUe4/CApNWsb4=;
        b=XxiHgCaoFSAe4B3bizN+ChgnY7ZwVOlPR49xr4wvd+fJxiVH9mnF3uGMZreQzk61cq
         OxlxgfsoDcqlDGqOwjOZ4FAyedoUw+llfBhOXIhLTKXIicVGX//KC01hRAtkAaf4czn4
         2E8tMksWE9JA7L1BTnwFf/tLdtvXK7D0PXTEp3n5ASXcegpbA8YYzKBA1jn6RhhU2gto
         s8SwgDAbAgrnaFJ8dMcsq6oDpOZp0Om9Ft1/ifMMmQyVIgaWOezW8P1ojwCxMuGDQ1nt
         LOI/OPVKMD2oJTcpyDwGjHxzf4oNKK74KCh+/gGkV03AA4krAKn+zj0n1Il6jn40Ocje
         4tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir5V99A0zsoCPWi1/drgb88gCMu5kFYUe4/CApNWsb4=;
        b=SdqIr9tjczzlY/4lqgRDU3CBwEdZfWlCY2VeA/neDPD7WZ95rfk83eNsLzhV8G8nLQ
         NyJvbZ1AIgXFypAN4nk1KBv5W2UlocYhAGKAnAcT1EisjcpEgm2pWD47TQiP4MY/vwQY
         JIMXSLpA8PFtU3zeRyDLZx7xt6USMdPprjbggzyx/J5V9Rk9NmXimXVG7yuzxm6txPWN
         p0yz+TiHABsh6AMDZDwGQRd4wCimUYyehiIDSMC9b2bIzEfFDbGbe0Q5f8Qfc9apmwjl
         iQeJ0Wzit0g49fGtEWgLSa4c10r5yQzJ5zTNtxGdfulvfiOa8jHwXMwFusUI0BqN4TVS
         lOHw==
X-Gm-Message-State: AAQBX9dfMcsatM4tu/CYixtKBSPlhzWP9dH87J1vfY9MA7qKp+OdBoSy
        tcoDawBQgxxARP7PCSUYT4+CzjQvCe14b0Z2+sQ5
X-Google-Smtp-Source: AKy350bn7ijoZFAjoqvuKlFfISkywXvdbbqt2f7GLfAU6t2tg/VAOo0P1PT/MZM3CF/iMQltGoeVogRNojJjbTEIS9A=
X-Received: by 2002:a63:6784:0:b0:4f1:cd3a:3e83 with SMTP id
 b126-20020a636784000000b004f1cd3a3e83mr3821811pgc.3.1679974391319; Mon, 27
 Mar 2023 20:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com> <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
In-Reply-To: <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 28 Mar 2023 11:33:00 +0800
Message-ID: <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 28, 2023 at 11:03=E2=80=AFAM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> >
> > On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > To support interrupt affinity spreading mechanism,
> > > > this makes use of group_cpus_evenly() to create
> > > > an irq callback affinity mask for each virtqueue
> > > > of vdpa device. Then we will unify set_vq_affinity
> > > > callback to pass the affinity to the vdpa device driver.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > > Thinking hard of all the logics, I think I've found something interes=
ting.
> > >
> > > Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
> > > pass irq_affinity to transport specific find_vqs().  This seems a
> > > layer violation since driver has no knowledge of
> > >
> > > 1) whether or not the callback is based on an IRQ
> > > 2) whether or not the device is a PCI or not (the details are hided b=
y
> > > the transport driver)
> > > 3) how many vectors could be used by a device
> > >
> > > This means the driver can't actually pass a real affinity masks so th=
e
> > > commit passes a zero irq affinity structure as a hint in fact, so the
> > > PCI layer can build a default affinity based that groups cpus evenly
> > > based on the number of MSI-X vectors (the core logic is the
> > > group_cpus_evenly). I think we should fix this by replacing the
> > > irq_affinity structure with
> > >
> > > 1) a boolean like auto_cb_spreading
> > >
> > > or
> > >
> > > 2) queue to cpu mapping
> > >
> >
> > But only the driver knows which queues are used in the control path
> > which don't need the automatic irq affinity assignment.
>
> Is this knowledge awarded by the transport driver now?
>

This knowledge is awarded by the device driver rather than the transport dr=
iver.

E.g. virtio-scsi uses:

    struct irq_affinity desc =3D { .pre_vectors =3D 2 }; // vq0 is control
queue, vq1 is event queue

> E.g virtio-blk uses:
>
>         struct irq_affinity desc =3D { 0, };
>
> Atleast we can tell the transport driver which vq requires automatic
> irq affinity.
>

I think that is what the current implementation does.

> > So I think the
> > irq_affinity structure can only be created by device drivers and
> > passed to the virtio-pci/virtio-vdpa driver.
>
> This could be not easy since the driver doesn't even know how many
> interrupts will be used by the transport driver, so it can't built the
> actual affinity structure.
>

The actual affinity mask is built by the transport driver, device
driver only passes a hint on which queues don't need the automatic irq
affinity assignment.

Thanks,
Yongji
