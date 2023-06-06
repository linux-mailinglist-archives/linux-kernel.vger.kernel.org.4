Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB6724625
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbjFFOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjFFOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:33:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977591729
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:33:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f505aace48so7880830e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061979; x=1688653979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uOaW7/P2mRHgWTXaClBReuacX2fmrasr4/Dns+wyy0=;
        b=q7/qcxoVb752NHqDstK/BMZ0lbEhIO2jCI+gHaX5SCIFaltxtceJiS1BO88p0edwXl
         tK1qJOHvdEz4/xJM/3xILO0iC/DlpAtkOoilPN0lDpVHCZKOgXuDpV3/PkcFVVxLzbhf
         ycFpG/GDFL10Ha316icwTmyvZu87PdV+nh12oSVA+0YjvTZRKWqPK3Hvsc7El3VJXGDX
         KB4YWBVgBlM5UF8fbuPdN/GjS4Bz/NmYoDH69SZBDQRlWx3m9D19PlxSNJiCUd6hx9g0
         9yBuFd3NIvPOyxqO5L1reGb4Aw+mUrvDBoBAHQraPKsnTmIvLjeztcBmkWAbK+L5fXQZ
         8j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061979; x=1688653979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uOaW7/P2mRHgWTXaClBReuacX2fmrasr4/Dns+wyy0=;
        b=dcCExZHSAvXX8ezz02PZYogvE4+Tvxx8cTPgSsalB1v3gXr6Ae4V646u2Y1ruDA7eN
         Bm1nbSHlco1jISSV+KG9PhWhNfGemkMdeiLVbVLVAUP13kyXI+GOCCtOlq+I8mUBN8Ly
         fl94xIQNG2Htcl44jJNxqEHOxwUfyi88oJYhRzzY5na/CzYSO56Szx26a/FywmDlPD0b
         aY/gXQsiMFiVJbWCZMqg48Kam4eP776LlwQrxQMGHdFcgPrqqzVS9k179FMxS3FnoPaT
         X3n2mwmv/Otv13jINbqaOb2O/Nv9AiTWKj8EWLVoj3/KEmGLLilTR8vs8AqO5SMzwdmC
         9Wpg==
X-Gm-Message-State: AC+VfDzpfhkJ5swNvParuB/B98gOT0nG1oY25ALLLSBfDtKrh63DQlST
        A2I7ki8v+d6TO7Ywk2kOMYSCttLOKlruiyQS0v4=
X-Google-Smtp-Source: ACHHUZ70+/XvUEtR3WFR5fIkuXCom0YsIZ9WUDJVpWEOWVcA5mbOuxqILaLwZ8p6lpd8efMUIGLdPP0S6xGFkHyxxyc=
X-Received: by 2002:a2e:b012:0:b0:2ad:ac93:3c7d with SMTP id
 y18-20020a2eb012000000b002adac933c7dmr1234022ljk.38.1686061978530; Tue, 06
 Jun 2023 07:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
In-Reply-To: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Tue, 6 Jun 2023 22:32:45 +0800
Message-ID: <CADtkEecM61WFyt6qEQnZvgiTdoixLvB-KtKABai83av3O0QuFQ@mail.gmail.com>
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

Hi grimberg, I have read Ming's patch, it seems that MIng fix the case
my patchset missed, Ming mainly fixes the hang when reconnect fails,
my patchset fixes the issue that while processing error_recover or
reconnect(have not reach max retries), user actively remove ctrl(nvme
disconnect),  this will interrupt error_recovery or recoonect, but
ctrl freezed and th request queue quiescing, the new IO or timeouted
IOs cannot continue to process, as a result nvme_remove_namespaces
hang on flush scan_work or blk_mq_freeze_queue_wait, new IO hang or
__bio_queue_enter()=EF=BC=8Cit seems that if the first patch add the next
code, it may cover Ming's case:

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
        nvme_delete_ctrl(ctrl);
+      nvme_ctrl_reconnect_exit(ctrl);
    }
}

Thanls.


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
>
Hi grimberg, I have look MIng's patch, I think we may fix
> Looks the same to me.
