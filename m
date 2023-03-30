Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1A6CF911
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjC3CQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3CQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:16:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E446B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:16:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h11so15697710lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680142562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtgc8H66e/eBsAwlgPMTsl3jdeSANqq4C7cxYJodiTQ=;
        b=g6cUVpR186hbMppXVGOMxes+kpKCF9XhHdINbvtoXVg1+gVzJLucgrskclYeTSLy47
         RVS/9TVUvFZ7BEf/0EX5TGT1VfS9E5vkU2eYkw1rDV7C4YDlqMcp0RQkBLEPQ/5FnJU8
         f3ve/YVwC2aCQvTnjhBX/fK+e4LVw32hJQKBAc5p1uwn7x1xeDINH/ecgw2bkzledDvu
         vCwfberKfR1v2TZvhSGNSVyFfyHo7rort4he8/uYyezF0YJtnsaZ2s2QeRT8TzARjL8s
         mMm4UsvCj8WsvWxEsutf68pIw9AL0izd9+2C5NhzSfU+nVe3l3RMwSGkt6xEz7xe5Fij
         zfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680142562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtgc8H66e/eBsAwlgPMTsl3jdeSANqq4C7cxYJodiTQ=;
        b=7DIg3sEq7QBktcDv00wqjqB3/hqBklmZnU3oK5n350t2ryrNFz9Km3kDiIb+dgyS5+
         o4Z8zSvxiPAPRF7x2cWA6fFZqEfN6KBPg8QBA8uC6OmSCMu+AHEMuNWGH1j+6S6nPqE1
         mkvrEYzn3v2uSACELfz7mCgVb0FMKCpkpbSdITrbJyUCp0xuwb3iwK+CLTtFh3Sjer9k
         AKzmwNJ/CuO+8CZwFYHbOH5ChUezZW3T8N7BQv5+iNE364KEMNGifEiTi+QuPBeFp2et
         hTpsQHzR0s/yFIMvA8N/MnNI62lcvQqPCIPPrGB7Hq6NcC+eFHMlKNeqwE3svun/18xK
         sn6Q==
X-Gm-Message-State: AAQBX9euiztklpcKsapJwnnze9VKHtYowuRFnssKqjDD5SKeZVXXtTzn
        sLvfMLcBQJR2/Zmva1kWnrq8I7evx8acqn+j25P03ZUkPzqmMVeSfoo=
X-Google-Smtp-Source: AKy350amXLyR9ZmfPWIjG2BbTYmkWEsNkPevbbYMd69+i2rehoQ84uIVavVURCQvW75xxq5AOUkbcZykH7PNqyxQmW8=
X-Received: by 2002:ac2:5a5c:0:b0:4ea:fc8f:7852 with SMTP id
 r28-20020ac25a5c000000b004eafc8f7852mr6304258lfn.12.1680142561830; Wed, 29
 Mar 2023 19:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230329102300.61000-1-huangjie.albert@bytedance.com> <20230329123959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230329123959-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 30 Mar 2023 10:15:50 +0800
Message-ID: <CABKxMyPc54yyFnajxkMypnDibL6Je7RFyvUyPxypomF=2-GkEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4] virtio_ring: interrupt disable flag
 updated to vq even with event_triggered is set
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 00:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 29, 2023 at 06:23:00PM +0800, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt=
,
> > the vq->event_triggered will be set to true. It will no longer be set t=
o
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
> >
> > If we disable the napi_tx, it will only be called when the tx ring
> > buffer is relatively small.
> >
> > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT =
or
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx.This bring more interruptions.
> >
> > To summarize:
> > 1) event_triggered was set to true in vring_interrupt()
> > 2) after this nothing will happen for virtqueue_disable_cb() so
> >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> >    then it tries to publish new event
> >
> > To fix:
> > update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to=
 vq
> > when we call virtqueue_disable_cb even the event_triggered is set to tr=
ue.
> >
> > Tested with iperf:
> > iperf3 tcp stream:
> > vm1 -----------------> vm2
> > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > there are many tx interrupts in vm2.
> > but without event_triggered there are just a few tx interrupts.
> >
> > v2->v3:
> > -update the interrupt disable flag even with the event_triggered is set=
,
> > -instead of checking whether event_triggered is set in
> > -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which ha=
ve
> > -not called virtqueue_{enable/disable}_cb to miss notifications.
> >
> > v3->v4:
> > -remove change for
> > -"if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DISABL=
E)"
> > -in virtqueue_disable_cb_packed
> >
> > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Can you confirm you tested 9p and it still works fine?
>

Yes, I tested it in my local environment. After applying this patch,
9p works fine.

Thanks.
> > ---
> >  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index cbeeea1b0439..ec7ab8e04846 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virt=
queue *_vq)
> >
> >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> >               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
> > +
> > +             /*
> > +              * If device triggered an event already it won't trigger =
one again:
> > +              * no need to disable.
> > +              */
> > +             if (vq->event_triggered)
> > +                     return;
> > +
> >               if (vq->event)
> >                       /* TODO: this is a hack. Figure out a cleaner val=
ue to write. */
> >                       vring_used_event(&vq->split.vring) =3D 0x0;
> > @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct v=
irtqueue *_vq)
> >
> >       if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DI=
SABLE) {
> >               vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG=
_DISABLE;
> > +
> > +             /*
> > +              * If device triggered an event already it won't trigger =
one again:
> > +              * no need to disable.
> > +              */
> > +             if (vq->event_triggered)
> > +                     return;
> > +
> >               vq->packed.vring.driver->flags =3D
> >                       cpu_to_le16(vq->packed.event_flags_shadow);
> >       }
> > @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     /* If device triggered an event already it won't trigger one agai=
n:
> > -      * no need to disable.
> > -      */
> > -     if (vq->event_triggered)
> > -             return;
> > -
> >       if (vq->packed_ring)
> >               virtqueue_disable_cb_packed(_vq);
> >       else
> > --
> > 2.20.1
>
