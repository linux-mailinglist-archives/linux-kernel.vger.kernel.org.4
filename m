Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604ED6C8113
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCXPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjCXPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:21:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923613D5C;
        Fri, 24 Mar 2023 08:21:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso5407127pjb.0;
        Fri, 24 Mar 2023 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679671282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuNSBy6vfFDe28dNRfX4SB+2S6cCkmFLQ9UkLH9oJas=;
        b=SJEzPH6GvQz6+WQY4BW9AX5dwFdAl/ZJkoJXElxyABCW1+/4hkHvUKDrwS0xkxoQcS
         aTyvpDBa4duQG3lbOWprm/MSyF9yKsPE1YVeGWuxzxuM8lpLGov/qkXiRAWqnoz9nxCK
         nKZZKqdP3uuJ3R2XLjAFZVuAmoh8z0hxbZhlUE/JAeMlcJElGl/iNIn0ObgipG5zIROD
         orWNjLguakkU9CM6VSFSOejapFjV8TVbr8ZslRwWHh9aS2pEhN+VI+qiGMwqcKnwTE5B
         aDNE0Rz30lVzEBK69E5kPVO5m1a9Dyn/HzHy7c7j/DEM4Zj6NlgEl9YHUtkuwbaE0KF5
         L1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679671282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuNSBy6vfFDe28dNRfX4SB+2S6cCkmFLQ9UkLH9oJas=;
        b=TyRRjAh+yIT0wawYEmiOf0olE1k9NFbWZ0Cp5nz5CGl1ylF05IdJW36/PJaXRYyB+Q
         MrFZX6ugJlZyDx+nmcG8OA0WWA4GJD/oFm6Au46pLNcLpLFCxOJaZpr3YL74lHmCQ5uo
         +9XTJO5i2ZP8tNNOAJQV2O9L0mgu0l2KcEq4rGVcHG5RmkwSR49SvIeTS23sJ1vtlxmY
         78PjwRwMgGXmBzkvCzpZPYcMWJzVnluTE1nKu4MoxOBh0sY00prKJ3RCQ9bUQup9YE6I
         sU9PLvlnV06RULjqh57imbvAwhzxNbe51KagdUXOoiUM+f1IfzjzxUzLBf60l/Iw77Cf
         wt5A==
X-Gm-Message-State: AAQBX9e5aO4wAD6FAEFCavzTICQ8VJ0FuIcXpZlTP+NeWvmDvYplJYvK
        sdUctddgO16byuuuS3dLvKZsDKDubQ/Hzty+8uE=
X-Google-Smtp-Source: AKy350apRZVKRldeUfMtQzstR+ipp+PqDrH9j3UA7h11zbpM2D7WsRhHH8Um9MNbelje5a1bCxt58vdoDxql9Zbz1vw=
X-Received: by 2002:a17:902:768b:b0:1a1:f0ad:8622 with SMTP id
 m11-20020a170902768b00b001a1f0ad8622mr985496pll.12.1679671282323; Fri, 24 Mar
 2023 08:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230318081303.792969-1-zyytlz.wz@163.com> <bce4f9d8-e4b9-39e6-4534-34b7dc7d43ac@oracle.com>
 <CAJedcCx9s9HSbJEEb_RUmW7yjSMkYaoXhuH9qrqYo1smpL=iJw@mail.gmail.com> <CO6PR18MB44199B7F8AABE14ED404CF61D8879@CO6PR18MB4419.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44199B7F8AABE14ED404CF61D8879@CO6PR18MB4419.namprd18.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 24 Mar 2023 23:21:09 +0800
Message-ID: <CAJedcCwgiLiLx7Uz6a3z67XQrOAUBHmfMvr1fenEnQ8MfmMtWg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH RESEND] scsi: qedi: Fix use after free bug in
 qedi_remove due to race condition
To:     Manish Rangankar <mrangankar@marvell.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Rangankar <mrangankar@marvell.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=882=
3=E6=97=A5=E5=91=A8=E5=9B=9B 18:17=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Zheng Hacker <hackerzheng666@gmail.com>
> > Sent: Thursday, March 23, 2023 9:15 AM
> > To: Mike Christie <michael.christie@oracle.com>
> > Cc: Zheng Wang <zyytlz.wz@163.com>; Nilesh Javali <njavali@marvell.com>=
;
> > Manish Rangankar <mrangankar@marvell.com>; GR-QLogic-Storage-
> > Upstream <GR-QLogic-Storage-Upstream@marvell.com>;
> > jejb@linux.ibm.com; martin.petersen@oracle.com; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > 1395428693sheep@gmail.com; alex000young@gmail.com
> > Subject: [EXT] Re: [PATCH RESEND] scsi: qedi: Fix use after free bug in
> > qedi_remove due to race condition
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > Mike Christie <michael.christie@oracle.com> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 00:11=E5=86=99
> > =E9=81=93=EF=BC=9A
> > >
> > > On 3/18/23 3:13 AM, Zheng Wang wrote:
> > > > In qedi_probe, it calls __qedi_probe, which bound
> > > > &qedi->recovery_work with qedi_recovery_handler and bound
> > > > &qedi->board_disable_work with qedi_board_disable_work.
> > > >
> > > > When it calls qedi_schedule_recovery_handler, it will finally call
> > > > schedule_delayed_work to start the work.
> > > >
> > > > When we call qedi_remove to remove the driver, there may be a
> > > > sequence as follows:
> > > >
> > > > Fix it by finishing the work before cleanup in qedi_remove.
> > > >
> > > > CPU0                  CPU1
> > > >
> > > >                      |qedi_recovery_handler
> > > > qedi_remove          |
> > > >   __qedi_remove      |
> > > > iscsi_host_free      |
> > > > scsi_host_put        |
> > > > //free shost         |
> > > >                      |iscsi_host_for_each_session
> > > >                      |//use qedi->shost
> > > >
> > > > Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > ---
> > > >  drivers/scsi/qedi/qedi_main.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/scsi/qedi/qedi_main.c
> > > > b/drivers/scsi/qedi/qedi_main.c index f2ee49756df8..25223f6f5344
> > > > 100644
> > > > --- a/drivers/scsi/qedi/qedi_main.c
> > > > +++ b/drivers/scsi/qedi/qedi_main.c
> > > > @@ -2414,6 +2414,10 @@ static void __qedi_remove(struct pci_dev
> > *pdev, int mode)
> > > >       int rval;
> > > >       u16 retry =3D 10;
> > > >
> > > > +     /*cancel work*/
> > >
> > > This comment is not needed. The name of the functions you are calling
> > > have "cancel" and "work" in them so we know. If you want to add a
> > > comment explain why the cancel calls are needed here.
> > >
> >
> > Hi,
> >
> > Sorry for my late reply and thanks for your advice. Will remove it in t=
he next
> > version of patch.
> >
> > >
> > > > +     cancel_delayed_work_sync(&qedi->recovery_work);
> > > > +     cancel_delayed_work_sync(&qedi->board_disable_work);
> > >
> > >
> > > How do you know after you have called cancel_delayed_work_sync that
> > > schedule_recovery_handler or schedule_hw_err_handler can't be called?
> > > I don't know the qed driver well, but it looks like you could have
> > > operations still running, so after you cancel here one of those ops
> > > could lead to them scheduling the work again.
> > >
> >
> > Sorry I didn't know how to make sure there's no more schedule. But I do
> > think this is important. Maybe there're someone else who can give us ad=
vice.
> >
> > Best regards,
> > Zheng
> > >
>
> Best place to call cancel_delayed_work_sync is after qedi_ops->stop(qedi-=
>cdev) and
> qedi_ops->ll2->stop(qedi->cdev);, after these qed calls firmware will not=
 post any events to qedi driver.
>

Sorry for my late reply. Will apply that in next version.

Best reagrds,
Zheng

> Thanks,
> Manish
>
