Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3786E1F58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDNJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDNJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:34:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3E86AC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:33:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso1897451a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681464808; x=1684056808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHN1gQDjY4S7UK02JvUJ41xmr2lektes0JLeJkU1rmY=;
        b=eS+FfMR5eLUy8hW0OWBLjlZ8rb4Snz52zUC4iqsjJvjbQ+cOV88d7RBvYxNvB0mXG7
         9tKw1BaXXEnfO28KXXjwJihxE0ej96eXzNwEc9SftMUJnAMgfWJW6YLgQ+Imp+2Dv8VC
         jSQS6vADWl5pJpFIsEW3hR4RvcFPoGVwvNmZ3QVczM2J70wIbWJGz8vJcLsjqsX5/FOq
         dfwAUhUJ6yRTTwqrvCCdxh45RF0JbaAmEP7ykEoe7FjiD8xTTwZnFpI0Y54GYHQq0nZ2
         7ve16WYN2CMWhVucdUrM0tW2ZpPmAt0wr+dPWKJcmOC1y/HKV4QoucyV4HB2cGi1wzu3
         SJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464808; x=1684056808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHN1gQDjY4S7UK02JvUJ41xmr2lektes0JLeJkU1rmY=;
        b=CkY1mtHF/4ZCB2JgUo+jvsI/LpFtRa/0yLz3k5AGdPfVq5OhxIH0c6VCjDNVHC1x1I
         rXpT0Oj7187lHFo0d6+XOcyI+RvG6Wx475Eo+gG7uhHVyExbCJq3jUP5KMWS1dIK/x/o
         WNPfqg4aDkfd6juv7mzIPVfakOP79OhdDOIrY6RpEZE6i+xVbp1XjCBR81/123rI8561
         swWKCk+NOpRBjz5fV6ZEeZtE0zC4wWwkqZlxN/wO9lt6wB/lbtxcgEGJkbtzLvQvaz3W
         QnRMZdjzhXTyEBt3eAsLwm7oTzI21QgEkH5ejLFQ1UZuq882SrIWpOQ7xQFvcUfHkcR7
         WAbg==
X-Gm-Message-State: AAQBX9dXn1t/q1aeSoirLHO7PkjONbw9sTjkOCn0d+r+EaCqetjpza3H
        TQG62cBn/koBfTfx6yRcy6u2qA8cJFkrxjlzF9O31//z8s4ABnDqgkEGWbF18/Y=
X-Google-Smtp-Source: AKy350ZvWUkNQwQeAL2xW3kOGBp+LzHs4fYa/6XgqUehBjySQ3QiSe8d+DUaWaeu7XEr7YGBtJ6MsCLH5/BgZ0XNw2I=
X-Received: by 2002:a50:9eca:0:b0:506:34d8:c710 with SMTP id
 a68-20020a509eca000000b0050634d8c710mr2756598edf.3.1681464808018; Fri, 14 Apr
 2023 02:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
In-Reply-To: <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
From:   Li Feng <fengli@smartx.com>
Date:   Fri, 14 Apr 2023 17:35:23 +0800
Message-ID: <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu affinity
To:     Hannes Reinecke <hare@suse.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, lifeng1519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 4:36=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/13/23 15:29, Li Feng wrote:
> > The default worker affinity policy is using all online cpus, e.g. from =
0
> > to N-1. However, some cpus are busy for other jobs, then the nvme-tcp w=
ill
> > have a bad performance.
> >
> > This patch adds a module parameter to set the cpu affinity for the nvme=
-tcp
> > socket worker threads.  The parameter is a comma separated list of CPU
> > numbers.  The list is parsed and the resulting cpumask is used to set t=
he
> > affinity of the socket worker threads.  If the list is empty or the
> > parsing fails, the default affinity is used.
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >
> > V2 - Fix missing static reported by lkp
> >
> >   drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 49c9e7bc9116..47748de5159b 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -31,6 +31,18 @@ static int so_priority;
> >   module_param(so_priority, int, 0644);
> >   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
> >
> > +/* Support for specifying the CPU affinity for the nvme-tcp socket wor=
ker
> > + * threads.  This is a comma separated list of CPU numbers.  The list =
is
> > + * parsed and the resulting cpumask is used to set the affinity of the
> > + * socket worker threads.  If the list is empty or the parsing fails, =
the
> > + * default affinity is used.
> > + */
> > +static char *cpu_affinity_list;
> > +module_param(cpu_affinity_list, charp, 0644);
> > +MODULE_PARM_DESC(cpu_affinity_list, "nvme tcp socket worker cpu affini=
ty list");
> > +
> > +static struct cpumask cpu_affinity_mask;
> > +
> >   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >   /* lockdep can detect a circular dependency of the form
> >    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> > @@ -1483,6 +1495,41 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_=
queue *queue)
> >                         ctrl->io_queues[HCTX_TYPE_POLL];
> >   }
> >
> > +static ssize_t update_cpu_affinity(const char *buf)
> > +{
> > +     cpumask_var_t new_value;
> > +     cpumask_var_t dst_value;
> > +     int err =3D 0;
> > +
> > +     if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
> > +     err =3D bitmap_parselist(buf, cpumask_bits(new_value), nr_cpumask=
_bits);
> > +     if (err)
> > +             goto free_new_cpumask;
> > +
> > +     if (!zalloc_cpumask_var(&dst_value, GFP_KERNEL)) {
> > +             err =3D -ENOMEM;
> > +             goto free_new_cpumask;
> > +     }
> > +
> > +     /*
> > +      * If the new_value does not have any intersection with the cpu_o=
nline_mask,
> > +      * the dst_value will be empty, then keep the cpu_affinity_mask a=
s cpu_online_mask.
> > +      */
> > +     if (cpumask_and(dst_value, new_value, cpu_online_mask))
> > +             cpu_affinity_mask =3D *dst_value;
> > +
> > +     free_cpumask_var(dst_value);
> > +
> > +free_new_cpumask:
> > +     free_cpumask_var(new_value);
> > +     if (err)
> > +             pr_err("failed to update cpu affinity mask, bad affinity =
list [%s], err %d\n",
> > +                     buf, err);
> > +     return err;
> > +}
> > +
> >   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
> >   {
> >       struct nvme_tcp_ctrl *ctrl =3D queue->ctrl;
> > @@ -1496,7 +1543,12 @@ static void nvme_tcp_set_queue_io_cpu(struct nvm=
e_tcp_queue *queue)
> >       else if (nvme_tcp_poll_queue(queue))
> >               n =3D qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
> >                               ctrl->io_queues[HCTX_TYPE_READ] - 1;
> > -     queue->io_cpu =3D cpumask_next_wrap(n - 1, cpu_online_mask, -1, f=
alse);
> > +
> > +     if (!cpu_affinity_list || update_cpu_affinity(cpu_affinity_list) =
!=3D 0) {
> > +             // Set the default cpu_affinity_mask to cpu_online_mask
> > +             cpu_affinity_mask =3D *cpu_online_mask;
> > +     }
> > +     queue->io_cpu =3D cpumask_next_wrap(n - 1, &cpu_affinity_mask, -1=
, false);
> >   }
> >
> >   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>
> I am not in favour of this.
> NVMe-over-Fabrics has _virtual_ queues, which really have no
> relationship to the underlying hardware.
> So trying to be clever here by tacking queues to CPUs sort of works if
> you have one subsystem to talk to, but if you have several where each
> exposes a _different_ number of queues you end up with a quite
> suboptimal setting (ie you rely on the resulting cpu sets to overlap,
> but there is no guarantee that they do).

Thanks for your comment.
The current io-queues/cpu map method is not optimal.
It is stupid, and just starts from 0 to the last CPU, which is not configur=
able.

> Rather leave it to the hardware to sort things out, and rely on the
> blk-mq CPU mapping to get I/O aligned to CPUs.
>
> Cheers,
>
> Hannes
>
The nvme-tcp currently doesn't support a *clever* method to bind the
io-queue and cpu,
it's decided at the allocation and doesn't have a method to change it.
E.g. One subsystem's first io queue binds to CPU0, the next io queue
binds to CPU1, and
if the NIC is located on the other NUMA node 2(CPU24 - CPU36), and
binds the fio to NUMA node 2,
the nvme-tcp will still have poor performance,so how should I tune the
performance?
I have to change the nic irq affinity, but it will hurt other numa
node2 application's performance.
We should maximize one subsystem performance, then maximize multiple
subsystems performance.

This patch gives a chance to adapt the nic and cpu load.
Before and after patch, on my aarch64 server with 4 numa nodes, the
256k read throughput ups
from 1GB/s to 1.4GB/s.

Thanks.
