Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4772BA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjFLI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjFLIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:25:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46E3A8D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:24:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f624daccd1so4420269e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686558272; x=1689150272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60WZl3oZ6fBs/Ceeo8bIk6EIYy4B+YbGCr8o/YA86ok=;
        b=ZAZk5udz3/I69mJI4du0tzVMDiEgIsYyMoCvR0k04ygDEwkRYCChMo27W5frEIIYjI
         ci6bRt8IUBIgONURrdqaChEFdvzcGgZdeMjRb2K2ES6KJ40J4LW2dSRqoDqCu/Z6onUw
         OC0Zr9HSxV+NisOUSoKKjITFfzY15hURsDAdg4vZ6YyG9+GoCGghaJJ3hynQPBiL0Jcp
         AzyNSV2Hu1ok/xk4+mYKkqJ0+SW+qUDce9tLUBkVhFYtpbnm5lTcYcDSAXua1rmoVSWJ
         qbnM4641hQNVsewMvlUl/X6GxdCQEKhR2o7F3T23gTyjJ5idTOSfpq9JaysVxZarytSQ
         9mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558272; x=1689150272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60WZl3oZ6fBs/Ceeo8bIk6EIYy4B+YbGCr8o/YA86ok=;
        b=kgcjWCfZGEhaNlCq3qWb3Ijfw2fhUEkwsHMiVasLDABoort+68Q0DYQzDxI/klKLD0
         VH45qfpwlw9BV8HqwcjWzceXIkK3kgTsxwylp0XCGEszMQHZP/E+mH6G/Poe4TACIqnK
         bfEozs8LzqYokPBCofW2Er5oJPd9Weje1bAkjd8LSz2G25EzWrNE5IIkpTC8rLtdKntE
         G4+1XTSy5ez8QPL9toJMnnc5AuVZHM2u3kOQNi2QID9kI7dRE22OpIyPV472lIfUrAeD
         iffzXmBKbDXjj8dc39DOZhOEhrcCN6+45HYA5tOSKfuMBoiz+3GQGRSwjrme/LCC+GxD
         hqVA==
X-Gm-Message-State: AC+VfDzjr40ikB4+0doAuEcIWVUQkbnoOGzTZcaXrXQ/biDdIgIo2FC9
        cyC7qTlyk3/htH/2SpAb+gXNUfdUnkVWXKZhlehSGoMLIAM=
X-Google-Smtp-Source: ACHHUZ4CdBnTB+Vhy4XJXj9InjjeF/dLWBaEWexLgZIQJN0wifT9hvDMXtyNxyE0zfy2pXLu1iCHUf+Dso9sL/dqMCg=
X-Received: by 2002:a19:5619:0:b0:4f3:83d6:f22c with SMTP id
 k25-20020a195619000000b004f383d6f22cmr3403785lfb.66.1686558271608; Mon, 12
 Jun 2023 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com> <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
In-Reply-To: <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Mon, 12 Jun 2023 16:24:20 +0800
Message-ID: <CADtkEef69h+Asg+J_EeOkZhmPBtnTnV2EaytfCifxjo41TW-=w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=B8=80 09:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jun 11, 2023 at 11:11:06AM +0300, Sagi Grimberg wrote:
> >
> > > > Hi Ming:
> > > >
> > > > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hello Chunguang,
> > > > >
> > > > > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > > > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > > > >
> > > > > > We found that nvme_remove_namespaces() may hang in flush_work(&=
ctrl->scan_work)
> > > > > > while removing ctrl. The root cause may due to the state of ctr=
l changed to
> > > > > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_t=
cp_error_recovery_work()/
> > > > > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this=
 time, ctrl is
> > > > >
> > > > > I didn't dig into ctrl state check in these error handler yet, bu=
t error
> > > > > handling is supposed to provide forward progress for any controll=
er state.
> > > > >
> > > > > Can you explain a bit how switching to DELETING interrupts the ab=
ove
> > > > > error handling and breaks the forward progress guarantee?
> > > >
> > > > Here we freezed ctrl, if ctrl state has changed to DELETING or
> > > > DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> > > > freeze, so nvme_remove_namespaces() hang.
> > > >
> > > > static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > > > {
> > > >          ...
> > > >          if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> > > >                  /* state change failure is ok if we started ctrl d=
elete */
> > > >                  WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &=
&
> > > >                               ctrl->state !=3D NVME_CTRL_DELETING_N=
OIO);
> > > >                  return;
> > > >          }
> > > >
> > > >          nvme_tcp_reconnect_or_remove(ctrl);
> > > > }
> > > >
> > > >
> > > > Another path, we will check ctrl state while reconnecting, if it ch=
anges to
> > > > DELETING or DELETING_NIO, we will break up and lease ctrl freeze an=
d
> > > > queue quiescing (through reset path), as a result Hang occurs.
> > > >
> > > > static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > > > {
> > > >          /* If we are resetting/deleting then do nothing */
> > > >          if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> > > >                  WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> > > >                          ctrl->state =3D=3D NVME_CTRL_LIVE);
> > > >                  return;
> > > >          }
> > > >          ...
> > > > }
> > > >
> > > > > > freezed and queue is quiescing . Since scan_work may continue t=
o issue IOs to
> > > > > > load partition table, make it blocked, and lead to nvme_tcp_err=
or_recovery_work()
> > > > > > hang in flush_work(&ctrl->scan_work).
> > > > > >
> > > > > > After analyzation, we found that there are mainly two case:
> > > > > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() =
while it issue
> > > > > >     new IO to load partition table.
> > > > >
> > > > > Yeah, nvme freeze usage is fragile, and I suggested to move
> > > > > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > > > > nvme_tcp_configure_io_queues(), such as the posted change on rdma=
:
> > > > >
> > > > > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAc=
b6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf75=
82e06b0
> > > >
> > > > While drive reconnecting, I think we should freeze ctrl or quiescin=
g queue,
> > > > otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> > > > and the IOs may retry frequently. So I think we may better freeze c=
trl
> > > > while entering
> > > > error_recovery/reconnect, but need to unfreeze it while exit.
> > >
> > > quiescing is always done in error handling, and freeze is actually
> > > not a must, and it is easier to cause race by calling freeze & unfree=
ze
> > > from different contexts.
> > >
> > > But yes, unquiesce should have been done after exiting error handling=
, or
> > > simply do it in nvme_unquiesce_io_queues().
> > >
> > > And the following patch should cover all these hangs:
> > >
> >
> > Ming, are you sending a formal patchset for this?
>
> Not yet, will do it.

Hi Ming:

Please cc me, thx.

> >
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 3ec38e2b9173..83d3818fc60b 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *c=
trl)
> > >      */
> > >     nvme_mpath_clear_ctrl_paths(ctrl);
> > > +   /* unquiesce io queues so scan work won't hang */
> > > +   nvme_unquiesce_io_queues(ctrl);
> >
> > What guarantees that the queues won't be quiesced right after this
> > by the transport?
>
> Please see nvme_change_ctrl_state(), if controller state is in
> DELETING, new NVME_CTRL_RESETTING/NVME_CTRL_CONNECTING can be entered
> any more.
>
> >
> > I'm still unclear why this affects the scan_work?
>
> As Chunguang mentioned, if error recover is terminated by nvme deletion,
> the controller can be kept in quiesced state, then in-queue IOs can'tu
> move on, meantime new error recovery can't be started successfully becaus=
e
> controller state is NVME_CTRL_DELETING, so any pending IOs(include those
> from scan context) can't be completed.
>
>
>
>
> Thanks,
> Ming
>
