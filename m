Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725966E089F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDMIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDMIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:08:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659654228
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:08:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y63so6995435pgd.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681373281; x=1683965281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83F1tjfFHvgT9fzCBaIpX/yc7Lcytfnr4LaCjC62oaI=;
        b=j87Ph7CDab2iyR0s/bOXIE4o6k2T75GCUsVETgWUkJtwo4nu4bJsixiqqnNsGKrJpq
         f/sAahuDNmEh+4FFJiwk0sNWmavB+1KOjpY2PhaFp7H6JwQUd0VabuBqaV5h3S3vKeR/
         KYD0QszcZkHq1KfOUkEEJ5a1kD6iFl3IcEzIQDuia9IpCQuKoK8l6LMaI/SzShclQnJR
         N2Ec5kJT8k/nar6KEfTFP3yR20zXyOioc5Q7ry0cclXmT+wo51fMqqV1Dzm0b8+2XgnG
         3dtMG+SrY5VYjbRXQsYmYEHKX+BKAgZJlVOlQq6feKDMBMQ+OKzSQoapV3OlIwDpiZTV
         hWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681373281; x=1683965281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83F1tjfFHvgT9fzCBaIpX/yc7Lcytfnr4LaCjC62oaI=;
        b=BKHWUMxT45KUE6E7gm0oeV98g9DYAGsZODkvgQ/eBFF0fSMYma70UYqAuSzW+zgQ5/
         AT/28veLVSEWtLY7Azrt8pkt5rxtOqDMmDFx/3gplQHrYtC3wXzsxM/IyYsVl9KfZTHJ
         acD8DxOJ5FL8KdoSHK1mXPNQrFrRImDfksiGQ7Juv01M25uRTt/lo0c4yMX3jEMcbB2j
         MIcnaBgI90GlHlRvY1PfAtNzzpOpiEoYtpAqeBiB6a0J/L1cGIeGf5j2DeWi8cBW0u++
         nSggiO6o+ZW9Z7P+HypjjpobzZYuPxtW9og45ESfASEOaL8Omzsx0NsssU/zJNKO0msC
         Tj7Q==
X-Gm-Message-State: AAQBX9cStDPftWC4ebpChrCxKOT2AqFLDo+oSg+qJQ2LkARYzzdz9YN3
        PhdV1M0r9fcQ1AzB3N934pzDNS/qksWTZC1IL6Y=
X-Google-Smtp-Source: AKy350YokbYq+xEENfm9Q9vx0MO6Q/05KyrBo3y7b3sL33KtuY/LSnMzhmfxUaWy7lDzZnI5ut+noXJCUWkTBHJeDAs=
X-Received: by 2002:a65:6183:0:b0:503:a7:d244 with SMTP id c3-20020a656183000000b0050300a7d244mr244067pgv.9.1681373280810;
 Thu, 13 Apr 2023 01:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
In-Reply-To: <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 16:07:49 +0800
Message-ID: <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
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

Friendly ping about the bug.

Thanks,
Zheng

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=8C 09:01=E5=86=99=E9=81=93=EF=BC=9A
>
> John Stultz <jstultz@google.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 03:57=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Mar 12, 2023 at 7:53=E2=80=AFAM Zheng Wang <zyytlz.wz@163.com> =
wrote:
> > >
> > > In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
> > > and bound &hisi_hikey_usb->work with relay_set_role_switch.
> > > When it calls hub_usb_role_switch_set, it will finally call
> > > schedule_work to start the work.
> > >
> > > When we call hisi_hikey_usb_remove to remove the driver, there
> > > may be a sequence as follows:
> > >
> > > Fix it by finishing the work before cleanup in hisi_hikey_usb_remove.
> > >
> > > CPU0                  CPU1
> > >
> > >                     |relay_set_role_switch
> > > hisi_hikey_usb_remove|
> > >   usb_role_switch_put|
> > >     usb_role_switch_release  |
> > >      kfree(sw)     |
> > >                     | usb_role_switch_set_role
> > >                     |   //use
> > >
> > > Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard=
 USB gpio hub on Hikey960")
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > ---
> > >  drivers/misc/hisi_hikey_usb.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_=
usb.c
> > > index 2165ec35a343..26fc895c4418 100644
> > > --- a/drivers/misc/hisi_hikey_usb.c
> > > +++ b/drivers/misc/hisi_hikey_usb.c
> > > @@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platform_d=
evice *pdev)
> > >  static int  hisi_hikey_usb_remove(struct platform_device *pdev)
> > >  {
> > >         struct hisi_hikey_usb *hisi_hikey_usb =3D platform_get_drvdat=
a(pdev);
> > > +       cancel_work_sync(&hisi_hikey_usb->work);
> > >
> > >         if (hisi_hikey_usb->hub_role_sw) {
> > >                 usb_role_switch_unregister(hisi_hikey_usb->hub_role_s=
w);
> >
> > Looks sane to me.
> > Pulling in Sumit and YongQin as they have hardware and can test with it=
.
> >
> Hi John,
>
> Thanks for your reply. Thank Sumit and YongQin for being willing to
> test the solution with their hardware.
>
> Best regards,
> Zheng
