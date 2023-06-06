Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674E72469C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjFFOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbjFFOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:44:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DE2733
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:43:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so69414781fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062513; x=1688654513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRRXihsQZ7hXptz6zIQPKX5/ezfKwpTeMZXJF+R0lMc=;
        b=aLdrJUnQxYz54XJXHApzQL5HaXQRvjf3J/xoszv4xcWvU0XcxTVNLiBqTMXEZBKXP/
         z18k51ZDY2A2luOoTFPy0LYnU7pAxD28BwN4MT0tGksRNya5xgva0hALXPFNg//bezp1
         VA7J+7qlbh6e86w0xisVFSGVbfkCslHl44WCixh5iXPRx2tGhv5VFbOWVLwf5OXma6o5
         kLr5cIioKGFr5ZxXWL2n2gjgtoJ4n1k1ewxlIqj0LiN2fzZDti7pxJJZmi1oiMui4+oJ
         KDrzgMeXUpmhdT4Kt8HaDipwxlapNBP8V2wQ3F7HbznStlHbpwgA3Tl1b6O9uKKz3VgL
         +9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062513; x=1688654513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRRXihsQZ7hXptz6zIQPKX5/ezfKwpTeMZXJF+R0lMc=;
        b=L+L+2fWKBLjnhSkPhGN0zsuXB9BZ+jgys6MdUZt7GSwXMCOVNPRxILvVFb1lO8zVyO
         V/AFEVTJQoB9H04sEaPwdSQIcy4ypL9E+elZoRZYEFjgGI3Q9FEYryW/Q3kO+zgTeNhc
         yksiPCB4yozkcev72eA3rnPWJniKr6yTm+pHwHun4IP3I7gRjA8Hq3Kx8kGICNMQhDXG
         IT0aWpOPXZLVrdVHMQMd/e5ekrHpMLD5c0PHDAEakzO9aSMYfcADMp5IMPWhB9oQdNT0
         NW9WFLYY6n8uQrRiExnyflKhdmS56kDOZqRdO4dryZUve3u0meh8ZYlMyAfWTmg1uGOw
         9NqQ==
X-Gm-Message-State: AC+VfDxInboufPoEOKcqwgnM2UpCP2KYlO38PppAzjE6fVykcxsYsbAR
        /DAKTbkPNeEfuvZe/wpDL2N1nbm/xTiDghHlysA=
X-Google-Smtp-Source: ACHHUZ6X+cN8bK7pPRP6jsPHCEmTTkCTYspANqVovzkPC5fkUXHp9GIxkhTC0RMntjLBMC5dgfPZdO5YXxs3nWXNNxE=
X-Received: by 2002:a2e:2407:0:b0:2ac:8486:e318 with SMTP id
 k7-20020a2e2407000000b002ac8486e318mr1164755ljk.35.1686062513044; Tue, 06 Jun
 2023 07:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
In-Reply-To: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Tue, 6 Jun 2023 22:41:42 +0800
Message-ID: <CADtkEefBGmNeO_zvXcbfJTP5TpEvowtAwx4=f_5tO=W56krW-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
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

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C 07:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->sc=
an_work)
> > while removing ctrl. The root cause may due to the state of ctrl change=
d to
> > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error=
_recovery_work()/
> > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, c=
trl is
> > freezed and queue is quiescing . Since scan_work may continue to issue =
IOs to
> > load partition table, make it blocked, and lead to nvme_tcp_error_recov=
ery_work()
> > hang in flush_work(&ctrl->scan_work).
> >
> > After analyzation, we found that there are mainly two case:
> > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it=
 issue
> >     new IO to load partition table.
> > 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dis=
patch
> >     queue, leading scan_work waiting for IO completion.
>
> Hey, can you please look at the discussion with Mings' proposal in
> "nvme: add nvme_delete_dead_ctrl for avoiding io deadlock" ?

Hi grimberg:

I have read Ming's patch, it seems that MIng fixed the case my patchset mis=
sed,
Ming  fixes the hang occur while reconnect fails(reach max retries), my pat=
chset
fixes the issue that while driver processing error_recover or reconnect(hav=
e not
reach max retries), user actively remove ctrl(nvme disconnect),  this
will interrupt
error_recovery or reconnect, but ctrl is  freezed and request queue is
quiescing,
so the new IO or timeouted IOs(requeue to hctx->dispatch_list) cannot conti=
nue
to process, as a result, nvme_remove_namespaces hang on flush scan_work or
blk_mq_freeze_queue_wait, new IO hang on __bio_queue_enter(), it seems that
if the first patch of my patchset add the next code, it may cover Ming's ca=
se:

static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
{
    /* If we are resetting/deleting then do nothing */
    if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
        WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
        ctrl->state =3D=3D NVME_CTRL_LIVE);
        return;
    }

    if (nvmf_should_reconnect(ctrl)) {
        dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
            ctrl->opts->reconnect_delay);
        queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
            ctrl->opts->reconnect_delay * HZ);
    } else {
        dev_info(ctrl->device, "Removing controller...\n");
+      nvme_ctrl_reconnect_exit(ctrl);
        nvme_delete_ctrl(ctrl);
    }
}

Thanks.

> Looks the same to me.
