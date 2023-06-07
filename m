Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7CB7252B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjFGEK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbjFGEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:10:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157F1FF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:09:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977cc662f62so551909266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686110969; x=1688702969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTLqOAtTyMXFuGGrm+2NknWfH2oQLCgaA0ayHism+pI=;
        b=mzVP8+inwt5KjgNmamFzI+zx93ehVJtCgfO5vQrg3VpQUFHVpzWHUXn9b3s7yHaJVD
         Si44j26k57IC5MvopnD8eshr1seAITXYiE6e+25eHeEf5qHyPVIhmSkylWYPDIpZb7sl
         adv4rOS5l4kGo7B0Fr9hxxF+/eaV6wv6V5d/+S79W4S5/VkEIW793Yu6szEoW6jDK+4K
         VTL/cgkU5eILx8cHcl/INoFKdHroIx4QpFUL937SJr9/2B8IfP10vsAv2G+uN/YxBKAo
         dOvNpUUlptYF/cZwsc3I+V3TApq2B/IrnRj+qFLuVKvKow1wEYrSmAdHUzwUr5uZDFwB
         MAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686110969; x=1688702969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLqOAtTyMXFuGGrm+2NknWfH2oQLCgaA0ayHism+pI=;
        b=dSvi8htvXQqIlj2GWeslB6h4rdATBDxoL25JBlm56OlBW6VKTgtXupWHT1DmHHKpeD
         ngyz2216U8EnRKkjgFnHObA/TZ+UM+fTfQ6bV5ib1BXfI+BOjfDwkLmb8MIGp/1VU9zc
         XnLFw0sz+/wDKUImC2bno97JCA1cqju9Bk+nvkgey5v/n++80Y7ZyPWmPcDD82teM0xY
         oXf8HggXOPY/szrk56hjm9lnshXzw/b3aqOkTxZE2wktkBikKlYHZFQZ+LKhNtq7QVhn
         P9aK8oeAoL+ZwC2WunShUsHmmL528WSlSA6OzCHQCxoFUkktr4/8/arwVuL0PV7HZ4O8
         jdnA==
X-Gm-Message-State: AC+VfDzbNJB++BXGlk7rs/oFrNwNO8nORfSTc03Ri+Df6mlHTOt2dgJb
        IO4na7ZJB8GkrmRYiOnmAtA+ndZz7uEc9GR2TLno7HldkoEfAAul
X-Google-Smtp-Source: ACHHUZ4ckeQmi5O2OoWT3LP3pgwIjwZ/HCOtXPfkpP8BBHj1ayd1p3rwi7GC+cagHQ3Ua591PPiSFLYqTr7qNvgnsCE=
X-Received: by 2002:a17:907:7e84:b0:978:6489:f9f with SMTP id
 qb4-20020a1709077e8400b0097864890f9fmr4359074ejc.52.1686110969440; Tue, 06
 Jun 2023 21:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
In-Reply-To: <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
From:   =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date:   Wed, 7 Jun 2023 12:09:17 +0800
Message-ID: <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming:

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Chunguang,
>
> On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
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
>
> I didn't dig into ctrl state check in these error handler yet, but error
> handling is supposed to provide forward progress for any controller state=
.
>
> Can you explain a bit how switching to DELETING interrupts the above
> error handling and breaks the forward progress guarantee?

Here we freezed ctrl, if ctrl state has changed to DELETING or
DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
freeze, so nvme_remove_namespaces() hang.

static void nvme_tcp_error_recovery_work(struct work_struct *work)
{
        ...
        if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
                /* state change failure is ok if we started ctrl delete */
                WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
                             ctrl->state !=3D NVME_CTRL_DELETING_NOIO);
                return;
        }

        nvme_tcp_reconnect_or_remove(ctrl);
}


Another path, we will check ctrl state while reconnecting, if it changes to
DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
queue quiescing (through reset path), as a result Hang occurs.

static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
{
        /* If we are resetting/deleting then do nothing */
        if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
                WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
                        ctrl->state =3D=3D NVME_CTRL_LIVE);
                return;
        }
        ...
}

> > freezed and queue is quiescing . Since scan_work may continue to issue =
IOs to
> > load partition table, make it blocked, and lead to nvme_tcp_error_recov=
ery_work()
> > hang in flush_work(&ctrl->scan_work).
> >
> > After analyzation, we found that there are mainly two case:
> > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it=
 issue
> >    new IO to load partition table.
>
> Yeah, nvme freeze usage is fragile, and I suggested to move
> nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> nvme_tcp_configure_io_queues(), such as the posted change on rdma:
>
> https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61u=
OGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0

While drive reconnecting, I think we should freeze ctrl or quiescing queue,
otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
and the IOs may retry frequently. So I think we may better freeze ctrl
while entering
error_recovery/reconnect, but need to unfreeze it while exit.


> > 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dis=
patch
> >    queue, leading scan_work waiting for IO completion.
>
> That still looks one problem in related error handling code, which is
> supposed to recover and unquiesce queue finally.

If I have not misunderstood that is what this patchset does.

Thanks.
>
> Thanks,
> Ming
>
