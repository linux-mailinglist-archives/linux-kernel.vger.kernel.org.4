Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409876B886B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:21:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362994398;
        Mon, 13 Mar 2023 19:21:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d13so3905517pjh.0;
        Mon, 13 Mar 2023 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678760457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ST7BmhpUErrCUi1sZY3qnuAjeR4ra1iiKxITwUUQZI=;
        b=WegDDcDl3ufBdzCjBrmxzX9oSV5CfGDhhmWPVxQ2DM/kICWM9+SfQapGG6AJK+OO4y
         NMNnmL7fD8CdRpZyaJU6I7XDrV1GJ+JzDdiG98VDPiDCdPU4ZlHOlCnL3oa+p6RiR062
         SWeCVQotN7nkoGF7vACxMUD71oAItMCTYNvRAw5E8f5BN2ionUEgsL+y9k98qSVOH6EJ
         s2Z/dYQkEp8VyPuT1ejv4VkBZ/V6al9HB/XAREGHGgy8Dfq3IaQDHUDrX/8yyrHWUqPY
         SGtSEJ6PllYTHUr+FhzT7hIho/YmwgNEyY1GhQq5pc3l4Fdo0z3LtAycTzQOqIo43ELv
         BGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678760457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ST7BmhpUErrCUi1sZY3qnuAjeR4ra1iiKxITwUUQZI=;
        b=uVGR5eP+LRhpj/3PwW9V0ANbPHiSzv3FoWWPY55IMfOWRW+GjthtUAVWeqRnNDGKuS
         IJ9V109/c3vMyvAEHywzuAPHtQ5DcZVuo2vMLKHVk8s0LO5tN+oRKU/4lawUg8CiWMNw
         VVuNazrjTZ+YwqwQBS9WnQ+DfxkJCVzNMzDy7uvL2XUWOQgM4b7UNON5QS7kFbKdce4s
         n3mswK9pcdCZqa9rlIN5LC56QSVqqK2YhZEQanMGcHxhlTnmfAO7Z+0T+DSeNPD1OE6L
         kPJINT6rBeqTNIs8QwmeE+WpI6w9kiuWlJoVQoay3P7g3M3HsmaLKrmElIT/7Ogp8z37
         lkNg==
X-Gm-Message-State: AO0yUKXY78SomAuXHgYMAC/vC5f3nJmzHGCKP5MrrNPSn73uLWYDTTsY
        TCuE1Ohwcf7fYKkISFOl3yi/ESGJJAZNDnOJmnU=
X-Google-Smtp-Source: AK7set8U3T4GAZvW/h12U9i6ZNMDVSpJPoMgpRrhOnH1FgejkfulYfQ4FxBPN53EWGlIM36RStwznRkDuxxNsxFZ+zk=
X-Received: by 2002:a17:903:334d:b0:1a0:52f1:8ea7 with SMTP id
 ka13-20020a170903334d00b001a052f18ea7mr1616209plb.12.1678760457488; Mon, 13
 Mar 2023 19:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230313165128.3763626-1-zyytlz.wz@163.com> <TYBPR01MB5341E0C84FA76CBA8A534B6DD8BE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341E0C84FA76CBA8A534B6DD8BE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 14 Mar 2023 10:20:45 +0800
Message-ID: <CAJedcCyM_cszcstJ4BNVfLdUwDnN1Gv851fqSBw0Ng5DqK7k-w@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
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
3=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 08:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> > From: Zheng Wang, Sent: Tuesday, March 14, 2023 1:51 AM
> > Subject: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free =
bug in renesas_usb3_remove due to race condition
> >
> > In renesas_usb3_probe, &usb3->role_work is bound with
> > renesas_usb3_role_work. renesas_usb3_start will be called
> > to start the work.
> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove
> >
> > CPU0                  CPU1
> >
> >                     |renesas_usb3_role_work
> > renesas_usb3_remove |
> > usb_role_switch_unregister  |
> > device_unregister   |
> > kfree(sw)          |
> > free usb3->role_sw  |
> >                     |   usb_role_switch_set_role
> >                     |   //use usb3->role_sw
> >
> > Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of u=
sb role switch")
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> JFYI, but IIUC,
> - In general, my Reviewed-by is described here, not top of your Signed-of=
f-by.
> - Also, you don't need to submit such this patch. If you would like to su=
bmit
>   such a patch for some reason (ping or so on), incrementing patch versio=
n is
>   better because original v3 [1] doesn't have my Reviewed-by tag.
>
> [1]
> https://lore.kernel.org/all/20230313094852.3344288-1-zyytlz.wz@163.com/
>

Dear Yoshihir,

Thanks for your advice. I am not familiar with the submission rules, thanks=
 for
your kind reminder. I'll keep that in mind in the future. Have a good day :=
)

Best regards,
Zheng

> Best regards,
> Yoshihiro Shimoda
>
> > ---
> > v3:
> > - modify the commit message to make it clearer suggested by Yoshihiro S=
himoda
> > v2:
> > - fix typo, use clearer commit message and only cancel the UAF-related =
work suggested by Yoshihiro Shimoda
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index bee6bceafc4f..a301af66bd91 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_de=
vice *pdev)
> >       debugfs_remove_recursive(usb3->dentry);
> >       device_remove_file(&pdev->dev, &dev_attr_role);
> >
> > +     cancel_work_sync(&usb3->role_work);
> >       usb_role_switch_unregister(usb3->role_sw);
> >
> >       usb_del_gadget_udc(&usb3->gadget);
> > --
> > 2.25.1
>
