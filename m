Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA00727534
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjFHCtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHCtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:49:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB861702
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:49:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-970028cfb6cso29156566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 19:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686192543; x=1688784543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHkrGcZeUA5nLnElT5OppB/SvUVbLxcjzF/L7d4jhxU=;
        b=q3ZoFaUfnC42gf1XQsm6W4PVYfVmF5CoxXTjrK52U+VWkobAk5csHTTRPvROo9w0iU
         7gbXqcW7RNJF0bTXvvFw62KdmyXR+oj5nUWq1I3Z52tqS3plczHGqx0l0ZrZ5evt9r6R
         OcyLjPVcHzb2fx8adLi7b6F58RWTuwh2H6yJS5HFUcjKurmG645SX3Z96ZEVMaRflYzw
         FIsK81N49eKvy2ZHtnY6V0SiwzTfbHJviGQ0elTNqOKTjku6nAm+S03IzCDTL1MwOA9M
         NYfygPx9pK5R3ea6Vnz0qq+FThTLg/xPD6WyhZfi4rSQdXXFmc5UmH3MCFX2seRLGUPO
         nDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686192543; x=1688784543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHkrGcZeUA5nLnElT5OppB/SvUVbLxcjzF/L7d4jhxU=;
        b=MafD00+kyKcGGMQSWqRm+JEkD3DKbtzTdasadTSF3YbBCXdvFKPkJUiYzDtXuNBB3O
         Qj9/Oid+RF6cQhretJCjZNJrKRKdwL6IGGxBOLWjj6CHlW8DPKsckNqae8hcPrnc2hGW
         9p7kUwNjk/sRhhihrK+CO9vSRNkS+Kxxg23u1DoOBLT97DLvMdnCta4bmhdbHxJUO14t
         8BTE9gaAZ6Kw4tLYzCl9adFkE6ct216sBRnP8pP8/V3cbL4Z3peSB6sn/hd20E8/QNcB
         DUVKo+JlvRZNm1g7XFmn4GBoyiVY3aks5yxSnwi/rzlr5fhbIZK7V1bNYTSZoR4/mg4O
         EOLg==
X-Gm-Message-State: AC+VfDzJn5UNVhTv+So/1xOEzMP7vb79EkwJ/0gRpZgyjABb8kik/XGT
        R+b/N2xRuHnBcxe5TWb3ZsUdg4QSLTo8Jc2AwzTvOwwP4cM=
X-Google-Smtp-Source: ACHHUZ7EqZMOrhp5IcmZAkMKa9CgiSaBTlgk1lr64SkmXQ9PCUwI59XorwhPeLOqqVknI3oigKx9YazFubONP6kkM9s=
X-Received: by 2002:a17:907:9405:b0:973:940e:a01d with SMTP id
 dk5-20020a170907940500b00973940ea01dmr7585537ejc.67.1686192542597; Wed, 07
 Jun 2023 19:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com> <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
In-Reply-To: <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Thu, 8 Jun 2023 10:48:50 +0800
Message-ID: <CADtkEeds0jCug7F9MymVOdEVBrkSdX6mnLz4kZGCJ7og9JCc7A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=A5=
=E5=91=A8=E5=9B=9B 08:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 07, 2023 at 12:09:17PM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Hi Ming:
> >
> > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hello Chunguang,
> > >
> > > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > >
> > > > We found that nvme_remove_namespaces() may hang in flush_work(&ctrl=
->scan_work)
> > > > while removing ctrl. The root cause may due to the state of ctrl ch=
anged to
> > > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_e=
rror_recovery_work()/
> > > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this tim=
e, ctrl is
> > >
> > > I didn't dig into ctrl state check in these error handler yet, but er=
ror
> > > handling is supposed to provide forward progress for any controller s=
tate.
> > >
> > > Can you explain a bit how switching to DELETING interrupts the above
> > > error handling and breaks the forward progress guarantee?
> >
> > Here we freezed ctrl, if ctrl state has changed to DELETING or
> > DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> > freeze, so nvme_remove_namespaces() hang.
> >
> > static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > {
> >         ...
> >         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> >                 /* state change failure is ok if we started ctrl delete=
 */
> >                 WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
> >                              ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
> >                 return;
> >         }
> >
> >         nvme_tcp_reconnect_or_remove(ctrl);
> > }
> >
> >
> > Another path, we will check ctrl state while reconnecting, if it change=
s to
> > DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
> > queue quiescing (through reset path), as a result Hang occurs.
> >
> > static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > {
> >         /* If we are resetting/deleting then do nothing */
> >         if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> >                 WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> >                         ctrl->state =3D=3D NVME_CTRL_LIVE);
> >                 return;
> >         }
> >         ...
> > }
> >
> > > > freezed and queue is quiescing . Since scan_work may continue to is=
sue IOs to
> > > > load partition table, make it blocked, and lead to nvme_tcp_error_r=
ecovery_work()
> > > > hang in flush_work(&ctrl->scan_work).
> > > >
> > > > After analyzation, we found that there are mainly two case:
> > > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() whil=
e it issue
> > > >    new IO to load partition table.
> > >
> > > Yeah, nvme freeze usage is fragile, and I suggested to move
> > > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > > nvme_tcp_configure_io_queues(), such as the posted change on rdma:
> > >
> > > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nL=
V61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e0=
6b0
> >
> > While drive reconnecting, I think we should freeze ctrl or quiescing qu=
eue,
> > otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> > and the IOs may retry frequently. So I think we may better freeze ctrl
> > while entering
> > error_recovery/reconnect, but need to unfreeze it while exit.
>
> quiescing is always done in error handling, and freeze is actually
> not a must, and it is easier to cause race by calling freeze & unfreeze
> from different contexts.

I think if we donot freeze ctrl, as the IO already submit (just queue
to hctx->dispatch) and may
pending for a long time,  it may trigger new hang task issue, but
freeze ctrl may can avoid these
hang task.

> But yes, unquiesce should have been done after exiting error handling, or
> simply do it in nvme_unquiesce_io_queues().
>
> And the following patch should cover all these hangs:
>
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..83d3818fc60b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>          */
>         nvme_mpath_clear_ctrl_paths(ctrl);
>
> +       /* unquiesce io queues so scan work won't hang */
> +       nvme_unquiesce_io_queues(ctrl);
> +
>         /* prevent racing with ns scanning */
>         flush_work(&ctrl->scan_work);
>
> @@ -4701,10 +4704,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl=
)
>          * removing the namespaces' disks; fail all the queues now to avo=
id
>          * potentially having to clean up the failed sync later.
>          */
> -       if (ctrl->state =3D=3D NVME_CTRL_DEAD) {
> +       if (ctrl->state =3D=3D NVME_CTRL_DEAD)
>                 nvme_mark_namespaces_dead(ctrl);
> -               nvme_unquiesce_io_queues(ctrl);
> -       }
>
>         /* this is a no-op when called from the controller reset handler =
*/
>         nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 492f319ebdf3..5d775b76baca 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev=
, bool shutdown)
>         dead =3D nvme_pci_ctrl_is_dead(dev);
>         if (dev->ctrl.state =3D=3D NVME_CTRL_LIVE ||
>             dev->ctrl.state =3D=3D NVME_CTRL_RESETTING) {
> -               if (pci_is_enabled(pdev))
> -                       nvme_start_freeze(&dev->ctrl);
>                 /*
>                  * Give the controller a chance to complete all entered r=
equests
>                  * if doing a safe shutdown.
>                  */
> -               if (!dead && shutdown)
> +               if (!dead && shutdown & pci_is_enabled(pdev)) {
> +                       nvme_start_freeze(&dev->ctrl);
>                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIME=
OUT);
> +                       nvme_unfreeze(&dev->ctrl);
> +               }
>         }
>
>         nvme_quiesce_io_queues(&dev->ctrl);
> @@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *wor=
k)
>          * controller around but remove all namespaces.
>          */
>         if (dev->online_queues > 1) {
> +               nvme_start_freeze(&dev->ctrl);
>                 nvme_unquiesce_io_queues(&dev->ctrl);
>                 nvme_wait_freeze(&dev->ctrl);
>                 nvme_pci_update_nr_queues(dev);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..354cce8853c1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                 goto out_cleanup_tagset;
>
>         if (!new) {
> +               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_unquiesce_io_queues(&ctrl->ctrl);
>                 if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOU=
T)) {
>                         /*
> @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(&ctrl->ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
> @@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_=
rdma_ctrl *ctrl,
>                 bool remove)
>  {
>         if (ctrl->ctrl.queue_count > 1) {
> -               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_quiesce_io_queues(&ctrl->ctrl);
>                 nvme_sync_io_queues(&ctrl->ctrl);
>                 nvme_rdma_stop_io_queues(ctrl);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..5ae08e9cb16d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1909,6 +1909,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                 goto out_cleanup_connect_q;
>
>         if (!new) {
> +               nvme_start_freeze(ctrl);
>                 nvme_unquiesce_io_queues(ctrl);
>                 if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>                         /*
> @@ -1917,6 +1918,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -2021,7 +2023,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme=
_ctrl *ctrl,
>         if (ctrl->queue_count <=3D 1)
>                 return;
>         nvme_quiesce_admin_queue(ctrl);
> -       nvme_start_freeze(ctrl);
>         nvme_quiesce_io_queues(ctrl);
>         nvme_sync_io_queues(ctrl);
>         nvme_tcp_stop_io_queues(ctrl);
>
>
>
>
> Thanks
> Ming
>
