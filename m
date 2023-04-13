Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35856E0BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjDMKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDMKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:55:47 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCC1FF5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:55:46 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id n203so3049438ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681383345; x=1683975345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f63QrK43XLAGHxwPs7pbyGXABSXOEiiygSrStfQWR3w=;
        b=PvCmyfQi2PB9TWPdBz4qyWOyb1JpH1Kb+uq0wHqNrvKmZ6DgsDrwQaCFrvXm9SH8J+
         sy0DCRolE0Mies47uvMEBEJVA1QwsNL0P2zEM8aLHN7rXFDaFQQOiekeLIXa5nlNASOb
         cvvhboo7SBYYg2KHMDA49wRrHupIMKYtxpuCsXbAca23uF2PXDUGjfydnZHyTiWLq+BH
         v4YsLsGjALXuFRMq7OMlS/a0YP4cIQZK6NVGe34DeW/veXYDhuvsGOlzScDVbdDLIi31
         DCmzqBlCTxKvrx/P5rWK5h+RLfbl9BhiqZ1w8qiCMtVYmXY2wsnaSuQKFWC/mNxQWTDr
         ukfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681383345; x=1683975345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f63QrK43XLAGHxwPs7pbyGXABSXOEiiygSrStfQWR3w=;
        b=bDS5IqSS63L+2SqpyzuaO3FyXOIQ3uzcIX4prvQS/899VFsJQkjiP28tsWBvLwGRDB
         6+7+2HtgY0/AdpNn74mqMBoZRR/aUhm5y9D5nfUwiQYc+8HxGW7y6KWOVtL+HswyAOjW
         kbNSzlC00bqIJNh/ZGLLmeiBIjOhPsKKq7yO7fy23jBycXRRHC04vHEeV1HLZKYt/alc
         butvuq05tZY+qCq398bSCf4HPzSzqNIgLd3BKrOduI6TNytwGxUnmrTFNdNTdFdekOlN
         CeaUqFNvfz3hGGs+w2l+wS1wyUaCaBZ4PcLDYWoD7S4f0otjJ0YOzZ2rxGjr4pl0kgrI
         vcKw==
X-Gm-Message-State: AAQBX9cXW/jrh+M7N9yxP/f+5i1mvcYnBbPvxAIffAXnOMzU36cF5P4N
        boRUW75okhiUhn8ThvWJB2692IOijlWxDnWWU5mb1Q==
X-Google-Smtp-Source: AKy350YZzo+I/tVibIzVpunKjBUatiTbbXl4qfys2VgP4SOXlR9o9XA8jqBBapGsotgRClgOfNHkhi7is1LNbpUFQbI=
X-Received: by 2002:a25:dad5:0:b0:b8e:de89:35a2 with SMTP id
 n204-20020a25dad5000000b00b8ede8935a2mr1123517ybf.1.1681383345313; Thu, 13
 Apr 2023 03:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com> <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
In-Reply-To: <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 13 Apr 2023 18:55:34 +0800
Message-ID: <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     John Stultz <jstultz@google.com>, Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zheng

On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.com> wrote=
:
>
> Friendly ping about the bug.

Sorry, wasn't aware of this message before,

Could you please help share the instructions to reproduce the problem
this change fixes?

Thanks,
Yongqin Liu
> Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=BA=8C 09:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > John Stultz <jstultz@google.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 03:57=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sun, Mar 12, 2023 at 7:53=E2=80=AFAM Zheng Wang <zyytlz.wz@163.com=
> wrote:
> > > >
> > > > In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
> > > > and bound &hisi_hikey_usb->work with relay_set_role_switch.
> > > > When it calls hub_usb_role_switch_set, it will finally call
> > > > schedule_work to start the work.
> > > >
> > > > When we call hisi_hikey_usb_remove to remove the driver, there
> > > > may be a sequence as follows:
> > > >
> > > > Fix it by finishing the work before cleanup in hisi_hikey_usb_remov=
e.
> > > >
> > > > CPU0                  CPU1
> > > >
> > > >                     |relay_set_role_switch
> > > > hisi_hikey_usb_remove|
> > > >   usb_role_switch_put|
> > > >     usb_role_switch_release  |
> > > >      kfree(sw)     |
> > > >                     | usb_role_switch_set_role
> > > >                     |   //use
> > > >
> > > > Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboa=
rd USB gpio hub on Hikey960")
> > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > ---
> > > >  drivers/misc/hisi_hikey_usb.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hike=
y_usb.c
> > > > index 2165ec35a343..26fc895c4418 100644
> > > > --- a/drivers/misc/hisi_hikey_usb.c
> > > > +++ b/drivers/misc/hisi_hikey_usb.c
> > > > @@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platform=
_device *pdev)
> > > >  static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> > > >  {
> > > >         struct hisi_hikey_usb *hisi_hikey_usb =3D platform_get_drvd=
ata(pdev);
> > > > +       cancel_work_sync(&hisi_hikey_usb->work);
> > > >
> > > >         if (hisi_hikey_usb->hub_role_sw) {
> > > >                 usb_role_switch_unregister(hisi_hikey_usb->hub_role=
_sw);
> > >
> > > Looks sane to me.
> > > Pulling in Sumit and YongQin as they have hardware and can test with =
it.
> > >
> > Hi John,
> >
> > Thanks for your reply. Thank Sumit and YongQin for being willing to
> > test the solution with their hardware.
> >
> > Best regards,
> > Zheng



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
