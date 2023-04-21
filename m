Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51D6EA1C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjDUCp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDUCp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:45:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27A3AB9;
        Thu, 20 Apr 2023 19:45:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2471214cdd3so1196335a91.1;
        Thu, 20 Apr 2023 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045125; x=1684637125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tu49XwhGv33lPvtk6nTHalIfbxdRzY4KyqRvME1FkQ=;
        b=RSg60eFsjqJbR6h5WJWSkunjv19/TKuPn8VT+rpSER9+IG6/O9gQrEAis3SQ/oHhZW
         Z1dS7xFyTkmocwu+mz2MXZSY1ychYO9+2j9XyScZf26KDN5fQCprIn+CKtT9552jSvz2
         /8hoBfvP3FxaEXWv23+/kqcRCDGlUvN5DQtQUFEup2oTr7naStjr4KcNxmRSfNtIiwtK
         0L6uiEyPefZOKjqK8CZBgcBeQZvGSrLtAdEJdODWy59zQV6tOFqbkF5glKylfGoK+E+u
         uxNnDqLfkj9Bpi9/4dYYppD9F4wjFZzII+DBqlJ6bgzihva3YedASgxlLxk8Y7B5wN02
         2QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045125; x=1684637125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tu49XwhGv33lPvtk6nTHalIfbxdRzY4KyqRvME1FkQ=;
        b=lSLtb6SnLKrY9ju2kLiGG8EukmU1aHsZfopADEbcqMt2J/2rwEUUkePabWOwr1j+Ss
         E7yUsSF0DpELj2G/ntzAPteAB/n7LxFq1rzsoqNAhBP2zwbZP/H7NOv97d1IibPxPqnn
         iCy0xdonT8MOMdvYeVzhI5r52E8FX5CD2oqfF1n7PwbtXI0plP/Uu6BXF4oUvjdHkFIC
         zV/c3NyFwU/sDtN0ozpS3Dk3IA02csZaHRWhdT2Lscv1YfrKE43A2ni0Yyrs9Uw++PDs
         pl7VxDNvGsfHTvwk2bL/Qr33yjn3IiTwxE1B/y6cnV4jLH9Ckx1+kazkbrV2fRsEpZw1
         hhuQ==
X-Gm-Message-State: AAQBX9cT2a2rdBKMZ2J2Cmh1EzKDearRJjWxu4iXiR8qdVzvKj5l8fR9
        AnKLsQ0hqhcRynT09+wm9itch3cB+rFsIqNS0InbKt5yc5ICFwLE
X-Google-Smtp-Source: AKy350bfSyi8/kUt8vTMGUkTnsj1BdCideZQq63vyLkvUnje3VmHMl2yy1zRz4u2m2uehWIH0bVz5ec9wjJpGuj9ylw=
X-Received: by 2002:a17:90b:1007:b0:244:9385:807f with SMTP id
 gm7-20020a17090b100700b002449385807fmr3465643pjb.44.1682045125217; Thu, 20
 Apr 2023 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230413033422.28003-1-zyytlz.wz@163.com> <CO6PR18MB44192610DCB3FB2975FDF253D8639@CO6PR18MB4419.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44192610DCB3FB2975FDF253D8639@CO6PR18MB4419.namprd18.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 21 Apr 2023 10:45:12 +0800
Message-ID: <CAJedcCwQ6rbgd0sAye5owMPmcd1bd4ZagWnG0JigE+y42_zGEg@mail.gmail.com>
Subject: Re: [EXT] [PATCH v2] scsi: qedi: Fix use after free bug in
 qedi_remove due to race condition
To:     Manish Rangankar <mrangankar@marvell.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Rangankar <mrangankar@marvell.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=882=
0=E6=97=A5=E5=91=A8=E5=9B=9B 13:49=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Zheng Wang <zyytlz.wz@163.com>
> > Sent: Thursday, April 13, 2023 9:04 AM
> > To: Nilesh Javali <njavali@marvell.com>
> > Cc: Manish Rangankar <mrangankar@marvell.com>; GR-QLogic-Storage-
> > Upstream <GR-QLogic-Storage-Upstream@marvell.com>;
> > jejb@linux.ibm.com; martin.petersen@oracle.com; linux-
> > scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > hackerzheng666@gmail.com; 1395428693sheep@gmail.com;
> > alex000young@gmail.com; Zheng Wang <zyytlz.wz@163.com>
> > Subject: [EXT] [PATCH v2] scsi: qedi: Fix use after free bug in qedi_re=
move
> > due to race condition
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> > with qedi_recovery_handler and bound &qedi->board_disable_work with
> > qedi_board_disable_work.
> >
> > When it calls qedi_schedule_recovery_handler, it will finally call
> > schedule_delayed_work to start the work.
> >
> > When we call qedi_remove to remove the driver, there may be a sequence
> > as follows:
> >
> > Fix it by finishing the work before cleanup in qedi_remove.
> >
> > CPU0                  CPU1
> >
> >                      |qedi_recovery_handler
> > qedi_remove          |
> >   __qedi_remove      |
> > iscsi_host_free      |
> > scsi_host_put        |
> > //free shost         |
> >                      |iscsi_host_for_each_session
> >                      |//use qedi->shost
> >
> > Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v2:
> > - remove unnecessary comment suggested by Mike Christie and cancel the
> > work after qedi_ops->stop and qedi_ops->ll2->stop which ensure there is=
 no
> > more work suggested by Manish Rangankar
> > ---
> >  drivers/scsi/qedi/qedi_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_mai=
n.c
> > index f2ee49756df8..45d359554182 100644
> > --- a/drivers/scsi/qedi/qedi_main.c
> > +++ b/drivers/scsi/qedi/qedi_main.c
> > @@ -2450,6 +2450,9 @@ static void __qedi_remove(struct pci_dev *pdev,
> > int mode)
> >               qedi_ops->ll2->stop(qedi->cdev);
> >       }
> >
> > +     cancel_delayed_work_sync(&qedi->recovery_work);
> > +     cancel_delayed_work_sync(&qedi->board_disable_work);
> > +
> >       qedi_free_iscsi_pf_param(qedi);
> >
> >       rval =3D qedi_ops->common->update_drv_state(qedi->cdev, false);
> > --
> > 2.25.1
>
> Thanks,
>
> Acked-by: Manish Rangankar <mrangankar@marvell.com>
>

Thanks for your review.

Best regards,
Zheng
