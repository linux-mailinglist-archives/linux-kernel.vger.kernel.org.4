Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66526B875C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCNBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCNBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:01:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B99225B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:01:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d22so1789556pgw.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678755718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDAUFRWppxbziLj8a2J/onSBdVNguaNnvt0aZpfAsXo=;
        b=EPCFj+67jFOISx4mmZ/GqTV3k8SqB3EDXHtkqcOiBhUbKjrmkixzlD9uwqXSobf166
         8vB+IYKaIhBYZX5VqqHeBp/z5SANkBbYCWmxadipm4aZOkHMYHPNtdkqlNOL56gxGztt
         eUQ5QiNl47BCDyq+IaVsyskvPGz97c97kIhNeAPClTPImjuSpZ9B8KDwuJto5L7vGZjQ
         fi1w3sX0pDqL2kvifPI083dplZXPhNfBWKrkjoRxLOxsoUMKSoIFvaa7XmZR6iLcPwyV
         PvYn1umuCN6HSbRWUX2cT050pIGrEdCioxL+pBK5MFsTNI7hN++5dZwtmVVzj48zCiuP
         ayiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678755718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDAUFRWppxbziLj8a2J/onSBdVNguaNnvt0aZpfAsXo=;
        b=nbv6sPO4HXH/eFQZ3JeAj4XXrPbjkGUHnLhqdM2GePlPG5NmYSyP0MNwS1czSKERHU
         Om0wwWKAxXHPENPUkuhrtXxUlzcRzOahA7jcAQkf453P9dIIg8HXbn9lmxCIUTSaRBOL
         Icxa0h0tq49WmsOzv1y7LUtUEeIQn1DmbZg6AvCo60k2LlpvnBGUCKoHbJlz2TmtImnr
         D/R0+oOmPmh2NZKQpg9+My8jB2dIcZs6nf1CbBvcphq7hIIZriZ0+k+VZnPoMCnJ/mnL
         qQtw5MEUqB3QIANIezzyPBg85gdyak9I54oPIJZsZsQk1hR0tvY9OAJxYS6ihvhR42y1
         UCgg==
X-Gm-Message-State: AO0yUKU7oQi5wAnRYdWThbUfSBliGg1aw8diGOc9epUhKZM1eQlV4mQq
        PfItQHp0KlYA9RYycXJsNA5KhNFP/FtdZcbM32c=
X-Google-Smtp-Source: AK7set+NiAuhAQhJaBxoqeGLYS3vXEef9x+/0ebcSTG5olw4138qgBsTorVBFvDxfVbwwdpXPYyhkShnuJBfxmBnAuw=
X-Received: by 2002:a62:8484:0:b0:5a9:d579:6902 with SMTP id
 k126-20020a628484000000b005a9d5796902mr4274847pfd.0.1678755718201; Mon, 13
 Mar 2023 18:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
In-Reply-To: <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 14 Mar 2023 09:01:46 +0800
Message-ID: <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     John Stultz <jstultz@google.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>
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

John Stultz <jstultz@google.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 03:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 12, 2023 at 7:53=E2=80=AFAM Zheng Wang <zyytlz.wz@163.com> wr=
ote:
> >
> > In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
> > and bound &hisi_hikey_usb->work with relay_set_role_switch.
> > When it calls hub_usb_role_switch_set, it will finally call
> > schedule_work to start the work.
> >
> > When we call hisi_hikey_usb_remove to remove the driver, there
> > may be a sequence as follows:
> >
> > Fix it by finishing the work before cleanup in hisi_hikey_usb_remove.
> >
> > CPU0                  CPU1
> >
> >                     |relay_set_role_switch
> > hisi_hikey_usb_remove|
> >   usb_role_switch_put|
> >     usb_role_switch_release  |
> >      kfree(sw)     |
> >                     | usb_role_switch_set_role
> >                     |   //use
> >
> > Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard U=
SB gpio hub on Hikey960")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/misc/hisi_hikey_usb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_us=
b.c
> > index 2165ec35a343..26fc895c4418 100644
> > --- a/drivers/misc/hisi_hikey_usb.c
> > +++ b/drivers/misc/hisi_hikey_usb.c
> > @@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platform_dev=
ice *pdev)
> >  static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> >  {
> >         struct hisi_hikey_usb *hisi_hikey_usb =3D platform_get_drvdata(=
pdev);
> > +       cancel_work_sync(&hisi_hikey_usb->work);
> >
> >         if (hisi_hikey_usb->hub_role_sw) {
> >                 usb_role_switch_unregister(hisi_hikey_usb->hub_role_sw)=
;
>
> Looks sane to me.
> Pulling in Sumit and YongQin as they have hardware and can test with it.
>
Hi John,

Thanks for your reply. Thank Sumit and YongQin for being willing to
test the solution with their hardware.

Best regards,
Zheng
