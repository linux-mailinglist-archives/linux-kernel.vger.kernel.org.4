Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEFA6E65AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjDRNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDRNSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:18:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6801113F90
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:18:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5144043d9d1so2030466a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681823904; x=1684415904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY3H0W2+yGUzRgmNYp2BkoKOa+V40Y6M2DaohWXcmZc=;
        b=OYSWgnnR3fS66p99KdwyGJ5aJ+WMh+j6yqM5Ps3Lk4FjD59cbRrqJRwTJCWXshnrZb
         QIo+1Z/Zm/NE4t8hjZsOmvujQkQ/T6KaY+kkdsQ/AYGZR4IJZilIyRJN90FTqPlHvwzZ
         6DYTAv+RTiNgTQTEBL/INUYEPz++67VOyDiSd5ku3Qz+AUip+dIkVgEDBMQOHFaAowZ5
         1QCLuJyeB6rSMuPICbl2f8zeRpAQOTeo0r1+6E1huF/cSioQv+e5RjcuXLE81F0bpdK5
         uDK1S+sDY13+rbbgi/3cW04eKRj0zOZF0Tig74DDKF5TqUV3ApkzAHdKrl7iYSFHSX+Z
         eAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823904; x=1684415904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY3H0W2+yGUzRgmNYp2BkoKOa+V40Y6M2DaohWXcmZc=;
        b=IxfKILSCI1tXMQicluFAfq4C8tCHEAD+y8C3MorkH6AraFS3z1iGwHhqCFdUvuaktu
         sQUMuTCqnT4oRN3OaILpTK3WzV22z9DlXCsx+xAzLhjLzdwnT8yccaZIuZgwfCfQMBdf
         9UcQ1wkZFVR/7GVjNCk46poOO3DRO2NPaoqNJp6afpSWHTsiXG40cnHKFFKGzf2XzWEX
         LPT7oub81PFkCvlBw2Yu+Hi+PRSzevEzK1MDauefsLENSjB8l7MpMf+znyL4SXP+/HYO
         TdNQ0c6pDOAYw3V1f36lsRR/dEtst3UUOilO3x5nZz9JEAc9+w8ghkY72g67R/aueN2g
         ZQGA==
X-Gm-Message-State: AAQBX9f/oOdM8L2RuyiB3bH7fDfuIwrFyCZO94g3ZT/wZO12Mz94awPD
        WvvZSM25AGqRq8jpn63eALlX8yyq5v/gD9ZABGU=
X-Google-Smtp-Source: AKy350Yi01vddmY2TYAhPaO8MVbnocFKSLapmfGjb3odpIaJueF5ZMSXNZHsLn1vyLNXl/zhm1HMiXcJ0C/bdK2gzZU=
X-Received: by 2002:a63:384f:0:b0:513:faf5:e430 with SMTP id
 h15-20020a63384f000000b00513faf5e430mr616050pgn.9.1681823903726; Tue, 18 Apr
 2023 06:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh> <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
 <2023041308-unvisited-slinky-a56f@gregkh> <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
 <CAMSo37V3vgjzgM_3Toy2HGwVuFcTw9DfVKDnVNaD-j4UJtOPvg@mail.gmail.com>
In-Reply-To: <CAMSo37V3vgjzgM_3Toy2HGwVuFcTw9DfVKDnVNaD-j4UJtOPvg@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 18 Apr 2023 21:18:13 +0800
Message-ID: <CAJedcCwow9sTEzZpiqmmcEDZ0XFLauA_tVBTJf5MfpadC1M+cQ@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C 01:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, Zheng
>
> Sorry for the late reply.
>
> I tested this change with Android build based on the ACK
> android-mainline branch.
> The hisi_hikey_usb module could not be removed with error like this:
>     console:/ # rmmod -f hisi_hikey_usb
>     rmmod: failed to unload hisi_hikey_usb: Try again
>     1|console:/ #
> Sorry I am not able to reproduce any problem without this commit,
> but I do not see any problem with this change applied either.
>
> If there is any specific things you want to check, please feel free let m=
e know
>

Hi Yongqin,

Thanks for your testing. I have no more questions about the issue.

Best regards,
Zheng

> Thanks,
> Yongqin Liu
>
>
> On Fri, 14 Apr 2023 at 00:46, Zheng Hacker <hackerzheng666@gmail.com> wro=
te:
> >
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > > > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > Hi, Zheng
> > > > > > >
> > > > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Friendly ping about the bug.
> > > > > > >
> > > > > > > Sorry, wasn't aware of this message before,
> > > > > > >
> > > > > > > Could you please help share the instructions to reproduce the=
 problem
> > > > > > > this change fixes?
> > > > > > >
> > > > > >
> > > > > > Hi Yongqin,
> > > > > >
> > > > > > Thanks for your reply. This bug is found by static analysis. Th=
ere is no PoC.
> > > > > >
> > > > > > >From my personal experience, triggering race condition bugs st=
ably in
> > > > > > the kernel needs some tricks.
> > > > > > For example, you can insert some sleep-time code to slow down t=
he
> > > > > > thread until the related object is freed.
> > > > > > Besides, you can use gdb to control the time window. Also, ther=
e are
> > > > > > some other tricks as [1] said.
> > > > > >
> > > > > > As for the reproduction, this attack vector requires that the a=
ttacker
> > > > > > can physically access the device.
> > > > > > When he/she unplugs the usb, the remove function is triggered, =
and if
> > > > > > the set callback is invoked, there might be a race condition.
> > > > >
> > > > > How does the removal of the USB device trigger a platform device
> > > > > removal?
> > > >
> > > > Sorry I made a mistake. The USB device usually calls disconnect
> > > > callback when it's unpluged.
> > >
> > > Yes, but you are changing the platform device disconnect, not the USB
> > > device disconnect.
> > >
> > > > What I want to express here is When the driver-related device(here
> > > > it's USB GPIO Hub) was removed, the remove function is triggered.
> > >
> > > And is this a patform device on a USB device?  If so, that's a bigger
> > > problem that we need to fix as that is not allowed.
> >
> > No this is not a platform  device on a USB device.
> >
> > >
> > > But in looking at the code, it does not seem to be that at all, this =
is
> > > just a "normal" platform device.  So how can it ever be removed from =
the
> > > system?  (and no, unloading the driver doesn't count, that can never
> > > happen on a normal machine.)
> > >
> >
> > Yes, I finally figured out your meaning. I know it's hard to unplug
> > the platform device
> > directly. All I want to express is that it's a theoretical method
> > except  rmmod. I think it's better to fix the bug. But if the
> > developers think it's practically impossible, I think there's no need
> > to take further action.
> >
> > Sorry for wasting your time and thanks for your explanation.
> >
> > Best regards,
> > Zheng
> >
> > > thanks,
> > >
> > > greg k-h
>
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android
