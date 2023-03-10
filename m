Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C66B4D84
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCJQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCJQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:47:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793F135976;
        Fri, 10 Mar 2023 08:45:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso5768673pju.0;
        Fri, 10 Mar 2023 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTHw5aQbs0BC28iVisLawe94Twp1MTgKRpX8SDWjibI=;
        b=jC6cbx2edDvdvhoPu7hdCG0CEaTNyFvSnBirIC0hDd3yqpmT+ndhvdQatg7xD9+yUp
         E+TtPemfINtkxEP54T89NvLwMBGNTV0PYA+Bk71T/9R3vdlKy5EViMyD4BRJiCcOYxMP
         QefRUe3jqay4+s85aG/e+NBuWoBG9QwWC6ptfj4GYfRRpFf37uy4Lb+cqB+VnXRYPmn/
         qk9ZIAZ2Qb4QXUXcFXE8K33iCBzDRzNXHGTzxsxW5p6gsA33gi7du91Lt7R6MwuYX5o8
         mf4ntd2gyF+AkSy8vtz714n4y0J6z/RWNLTXfD8kz+8X/BGN8HOXBtjMpjzfRy/6yrHz
         q+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTHw5aQbs0BC28iVisLawe94Twp1MTgKRpX8SDWjibI=;
        b=nnJ6x1hA7ueEmgTguyVYdebwr/oNLCzs4YU68av272aDsKnwpdwnFRS6AxLtMKx9oi
         VlgZEia+hgMZ+nIr+R8MHUhlmRTbchEMemp8P/HN9A6HKSzgfi6vn6dwHfdD/MWfc3TQ
         G/GNpqfNAEtcarlfLGJpHWO8hVt94JBCQVO90TxlBKpaJMWP6CSG14ljBkeQiD+Iq56Q
         R7LjEY6v051XmnR1gL1262KPh6GEsQD4ly5LW0+GiUE+b8/RBG43q7O/VLPEUaB+ZEwt
         18nTsDTLH2PG55K2OHPTPvjYQpKs6oLP1xKkN3THjadRMOw+TRJUExxLpV4WM9ha/EZj
         WaTQ==
X-Gm-Message-State: AO0yUKXwwWDoUrYd2vc2vpk6+shayn2toiDZQxcF/4JNjPf4PytV+uMC
        UlySYTwlhsWFujbILVy3f8m3yWJwyjd+60DoBll2aRZmmH5e/+PhB9g=
X-Google-Smtp-Source: AK7set+rVM1Uy/jR6wwM74wGPvif8E2INIKfLAblPKLZCdQn6KZqC3ouzTFAeawVYzcqA62dt5WdKi7Js2KaPBUp/+Q=
X-Received: by 2002:a17:90a:4f4c:b0:237:203f:1b76 with SMTP id
 w12-20020a17090a4f4c00b00237203f1b76mr9625695pjl.2.1678466731462; Fri, 10 Mar
 2023 08:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20230309193020.374950-1-zyytlz.wz@163.com> <TYBPR01MB53412E8BDBB67C38E0B5E80CD8BA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB53412E8BDBB67C38E0B5E80CD8BA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 11 Mar 2023 00:45:19 +0800
Message-ID: <CAJedcCy3fCLxcPP3a5iSXecX-dpKmsePiJ45HYKfJE2CZXq=6A@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix use after free bug in
 renesas_usb3_remove due to race condition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> =E4=BA=8E2023=E5=B9=B4=
3=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> > From: Zheng Wang, Sent: Friday, March 10, 2023 4:30 AM
> >
> > In renesas_usb3_probe, &usb3->role_work is bound with
> > renesas_usb3_role_work. renesas_usb3_start will be called
> > to start the work.
> >
> > If we remove the module which will call renesas_usb3_remove
> >   to make cleanup, there may be a unfinished work. The possible
> >   sequence is as follows:
>
> Thank you for the patch!
> I think we should remove double spaces like below. (Also "an" unfinished)=
:
>
Thank you for your kind reminder.Will correct in the next version of patch.

> -----
> If we remove the module which will call renesas_usb3_remove
> to make cleanup, there may be an unfinished work. The possible
> sequence is as follows:
> -----
>
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove
> >
> > CPU0                  CPUc1
>
> s/CPUc1/CPU1/
>
>
> >                     |renesas_usb3_role_work
> > renesas_usb3_remove      |
> > usb_role_switch_unregister  |
> > device_unregister   |
> > kfree(sw);        |
> > free usb3->role_sw  |
> >                     |   usb_role_switch_set_role
> >                     |   //use usb3->role_sw
>
> Adding a blank line here is better, I think.

Agree with that :)

>
> > Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of u=
sb role switch")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index bee6bceafc4f..23b5f1706d25 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2658,6 +2658,8 @@ static int renesas_usb3_remove(struct platform_de=
vice *pdev)
> >  {
> >       struct renesas_usb3 *usb3 =3D platform_get_drvdata(pdev);
> >
> > +     cancel_work_sync(&usb3->extcon_work);
>
> IIUC, this work is not related to the issue.
> But, what do you think?
> If so, adding this should be a separate patch with the following Fixes ta=
g:
>
> Fixes: 3b68e7ca3888 ("usb: gadget: udc: renesas_usb3: add extcon support"=
)
>
Yes, I didn't find the uaf part for this work. As I didn't see any
code to cancel this work,
I added it then. I think you are right. In the next version of patch,
we'll only keep the
cancel of related work.

Best regards,
Zheng

>
> > +     cancel_work_sync(&usb3->role_work);
> >       debugfs_remove_recursive(usb3->dentry);
> >       device_remove_file(&pdev->dev, &dev_attr_role);
> >
> > --
> > 2.25.1
>
