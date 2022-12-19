Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC9650739
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 05:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLSE4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 23:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSE4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 23:56:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052CE6144
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:56:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d20so11366662edn.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk7uS310Ur2pWz+RaV0jdkh1kEHOIUEPrNEyZY99uo8=;
        b=3HJUjsymIqbLofCG87ieJrqTuaOmLFbdvUDTZ+mlwQbuWQc5uMy3eWKiI5V1v6fZHb
         aLVT8HHNf59ZFquCw0DyOy/+ABeMDecch2xkcivyfRL4swCnNN/U/gMOieMBuv8KD+Oo
         Yc+0cR3Duv2XK5piAHW7890Xo/Akwsz49KfdT9T5FV1lfEUPyYxNH+h/eq6dCkphpKyU
         /rLV5/4knhK77ewzGa8doUnvISP1o7rWuusYUXbL417r1OMCSzW8vbutAJ+u5p6Qa1Q4
         tFExd6+Q/kjEH0px9kkuakn7M+/viW8j0nlyhd0HQbLIC3B++DmEMzoC8vtHvc4CUKHF
         7kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mk7uS310Ur2pWz+RaV0jdkh1kEHOIUEPrNEyZY99uo8=;
        b=obxPYWDh1YCLwSNv8oDR71GB5Tf6yWJeSYvz5nDvHzslPxU/RBsd8koPCYCSD/mfN7
         UTTnOy9oNzdsva4TpvaMq5AOlegxjZjjr7Acw91cHSMnt8XAl8ONRxFF+qtvr9cqUYIV
         gMPArzh5o/AxK9ktBjkWrEGEPKuv87u5CjxAuNCXToTFAdMUM2Bswg2uuW7pDXrmQ3Yl
         Yjlj2iPzLTVAD1t94obi1A/fLkJCEPQ8j8DcTvLF5id+To5QMjN85g6THPaY++a2VSoE
         28COzlvuNUM16TzdEzQqeS2Yc1kWX0lE06DuW/m8Yj8eDK3G+SRcsnKXBAwX9tSxmDLq
         /Vjg==
X-Gm-Message-State: ANoB5pkZqneOS3ZKu0K8U9W7WHfLjQO511V7AiYw1mQjd65XM6Mh2fWm
        HHqUqdls8THc6zN3uXrp61de8d854vBzz1ri4QjRrNSUZgAN
X-Google-Smtp-Source: AA0mqf5mcOHOOKa0e4ONSqeMBX3vvQGi3YUWIEPQCVoeIZ/fXXnecPROwYZDxo+suoOwKadE56Q3YcZ+glz1S/z82wc=
X-Received: by 2002:a05:6402:230f:b0:46c:dc40:4635 with SMTP id
 l15-20020a056402230f00b0046cdc404635mr17620569eda.358.1671425782200; Sun, 18
 Dec 2022 20:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205085846.741-1-xieyongji@bytedance.com>
 <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
In-Reply-To: <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 12:56:10 +0800
Message-ID: <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
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

On Fri, Dec 16, 2022 at 1:30 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > This brings current interrupt affinity spreading mechanism
> > to vduse device. We will make use of irq_create_affinity_masks()
> > to create an irq callback affinity mask for each virtqueue of
> > vduse device. Then we will choose the CPU which has the lowest
> > number of interrupt allocated in the affinity mask to run the
> > irq callback.
>
> This seems a balance mechanism but it might not be the semantic of the
> affinity or any reason we need to do this? I guess we should use at
> least round-robin in this case.
>

Here we try to follow the pci interrupt management mechanism. In VM
cases, the interrupt should always be triggered to one specific CPU
rather than to each CPU in turn.

> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index d126f3e32a20..90c2896039d9 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/nospec.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/mm.h>
> > +#include <linux/interrupt.h>
> >  #include <uapi/linux/vduse.h>
> >  #include <uapi/linux/vdpa.h>
> >  #include <uapi/linux/virtio_config.h>
> > @@ -58,6 +59,8 @@ struct vduse_virtqueue {
> >         struct work_struct inject;
> >         struct work_struct kick;
> >         int irq_effective_cpu;
> > +       struct cpumask irq_affinity;
> > +       spinlock_t irq_affinity_lock;
>
> Ok, I'd suggest to squash this into patch 5 to make it more easier to
> be reviewed.
>

OK.

> >  };
> >
> >  struct vduse_dev;
> > @@ -123,6 +126,7 @@ struct vduse_control {
> >
> >  static DEFINE_MUTEX(vduse_lock);
> >  static DEFINE_IDR(vduse_idr);
> > +static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
> >
> >  static dev_t vduse_major;
> >  static struct class *vduse_class;
> > @@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> >         return dev->generation;
> >  }
> >
> > +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > +{
> > +       unsigned int cpu, best_cpu;
> > +       unsigned long allocated, allocated_min = UINT_MAX;
> > +
> > +       spin_lock(&vq->irq_affinity_lock);
> > +
> > +       best_cpu = vq->irq_effective_cpu;
> > +       if (best_cpu != -1)
> > +               per_cpu(vduse_allocated_irq, best_cpu) -= 1;
> > +
> > +       for_each_cpu(cpu, &vq->irq_affinity) {
> > +               allocated = per_cpu(vduse_allocated_irq, cpu);
> > +               if (!cpu_online(cpu) || allocated >= allocated_min)
> > +                       continue;
> > +
> > +               best_cpu = cpu;
> > +               allocated_min = allocated;
> > +       }
> > +       vq->irq_effective_cpu = best_cpu;
> > +       per_cpu(vduse_allocated_irq, best_cpu) += 1;
> > +
> > +       spin_unlock(&vq->irq_affinity_lock);
> > +}
> > +
> > +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> > +                                       struct irq_affinity *desc)
> > +{
> > +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > +       struct irq_affinity_desc *affd = NULL;
> > +       int i;
> > +
> > +       affd = irq_create_affinity_masks(dev->vq_num, desc);
> > +       if (!affd)
>
> Let's add a comment on the vdpa config ops to say set_irq_affinity()
> is best effort.
>

OK.

Thanks,
Yongji
