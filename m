Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAD6EAE33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjDUPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDUPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:42:38 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC247DA3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:42:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f8e81c3f3so27211557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682091756; x=1684683756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YYnTvOUl141Bl0aSW1AxS/wSyb5U+MiBsimwD6L7e0=;
        b=n71Y+8TRkA8LzSVHS46jnFv7Q80QpO7QrsX6INuCKK4RCjNIa4+nhMpNBIOVkZf1o6
         Bz7HqTzsX6S4KeWrOOfSPg6S23n6bfzIieI9T/znlXFmJep6mpBeE7qpk0sl1Ygohzi5
         pfXp7Gci1ypytoqc2IDJhaOtfgwb0L2TBy9LyfGwzblZTrp+4xj/bW0VaSGa7bf3fTew
         bnzXXnXyUUA7gzMY7kDeVjTyNa3jkbWD1SQAR+Eo76W/QiMZNtKcWRNfmoKZ91s/SbVI
         UpvsU6198hNkxfPcvbZUYUn4hUS3em2TygjMXwybi+A6Vq8XPJb/0iiasbJ4SmBx9uUf
         mo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091756; x=1684683756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YYnTvOUl141Bl0aSW1AxS/wSyb5U+MiBsimwD6L7e0=;
        b=Xtq3wbKHay7h2AZOEbHtfkwH2m8SQcIiNO0RKyUz8QJcCoc5dgyVM8/5TM3FJj39Na
         DXFvUpWPLkQEEbU6eH+CUfsjtOrpY3EIkfgJSt3X8r0Z8KL1ffBfSI0aKcfUjQKAndd/
         +fjgiphWf6Tmm6oZz+F6zNpdVUl63nknrr6x4a3GEu8/YXT/Tx0CmIQcwePCOSe72+wG
         HFN4fHTwpobKi2xA/jUYSh5Hzljznb9K0xc1IuR8SSl3ooZ4ODlPgutp6Sc2UfgWFfj6
         I/wVEJMvbOp2BPlbRFzO6d+JOuAGajst64F5CHxrvYk9VyAS9NCkAu9sKIiHSfRYNaFi
         +bzg==
X-Gm-Message-State: AAQBX9eesWlSc4ai00cCC7Xs+rireLI1kp71wzu1Y+P5igjBGUF9xw6D
        adYq5Wysjgq95ezIUNh4UrKzf8XL3ZRv9qR/Go94kw==
X-Google-Smtp-Source: AKy350YK1uVK+dANNwhl/UfAZ+sCEq4bnC9OAumBDYqWZ006Ouvxt7Eoqj3GP7jT1JgACpw3XiEOdgKD3l7ZzNyj5zU=
X-Received: by 2002:a0d:d882:0:b0:54f:b874:116f with SMTP id
 a124-20020a0dd882000000b0054fb874116fmr2190110ywe.7.1682091756351; Fri, 21
 Apr 2023 08:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh> <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
 <2023041308-unvisited-slinky-a56f@gregkh> <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
 <CAMSo37V3vgjzgM_3Toy2HGwVuFcTw9DfVKDnVNaD-j4UJtOPvg@mail.gmail.com>
 <CAJedcCwow9sTEzZpiqmmcEDZ0XFLauA_tVBTJf5MfpadC1M+cQ@mail.gmail.com>
 <CAMSo37VxLfqg7UGY8CYAYz8nqoJ12T2mERbKNn67e_+yOD3cXQ@mail.gmail.com> <CAJedcCxQAarCMKWsqa9nL-obRGaspcvcOVfx3d8KOZuK7VxbKg@mail.gmail.com>
In-Reply-To: <CAJedcCxQAarCMKWsqa9nL-obRGaspcvcOVfx3d8KOZuK7VxbKg@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Fri, 21 Apr 2023 23:42:24 +0800
Message-ID: <CAMSo37Vse=gVqC_2LU44YzOepXpy909kSDSQjebb0zyk-b27kg@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Zheng

Thanks for the explanation!
BTW, from what I tested, I am OK to have this change merged.

Thanks,
Yongqin Liu
On Fri, 21 Apr 2023 at 10:35, Zheng Hacker <hackerzheng666@gmail.com> wrote=
:
>
> Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 14:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi, Zheng
> >
> > BTW, I just see cancel_delayed_work_sync is used in
> > the drivers/usb/common/usb-conn-gpio.c usb_conn_remove function.
> >     https://android.googlesource.com/kernel/common/+/refs/heads/android=
-mainline/drivers/usb/common/usb-conn-gpio.c#274
> >
> > I know nothing about the cancel_delayed_work_sync and cancel_work_sync
> > functions,
> > just for your information in case cancel_delayed_work_sync might be
> > better to be used here.
> >
>
> HI Yongqin,
>
> Thanks for your kind reminder. The cancel_delayed_work_sync is used
> with INIT_DELAYED_WORK and queue_delayed_work.
> This is used to start a work after some time while schedule_work means
> start it immediately.
>
> In this case, the &hisi_hikey_usb->work is initialized with INIT_WORK
> and scheduled with schedule_work. So I think we'd better use
> cancel_work_sync here. I'm also not so familiar with the code. If
> there's something wrong with it, please feel free to let me know.
>
> Best regards,
> Zheng
>
>
> > Thanks,
> > Yongqin Liu
> > On Tue, 18 Apr 2023 at 21:18, Zheng Hacker <hackerzheng666@gmail.com> w=
rote:
> > >
> > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=88=
18=E6=97=A5=E5=91=A8=E4=BA=8C 01:31=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Hi, Zheng
> > > >
> > > > Sorry for the late reply.
> > > >
> > > > I tested this change with Android build based on the ACK
> > > > android-mainline branch.
> > > > The hisi_hikey_usb module could not be removed with error like this=
:
> > > >     console:/ # rmmod -f hisi_hikey_usb
> > > >     rmmod: failed to unload hisi_hikey_usb: Try again
> > > >     1|console:/ #
> > > > Sorry I am not able to reproduce any problem without this commit,
> > > > but I do not see any problem with this change applied either.
> > > >
> > > > If there is any specific things you want to check, please feel free=
 let me know
> > > >
> > >
> > > Hi Yongqin,
> > >
> > > Thanks for your testing. I have no more questions about the issue.
> > >
> > > Best regards,
> > > Zheng
> > >
> > > > Thanks,
> > > > Yongqin Liu
> > > >
> > > >
> > > > On Fri, 14 Apr 2023 at 00:46, Zheng Hacker <hackerzheng666@gmail.co=
m> wrote:
> > > > >
> > > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > > > > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=
=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrot=
e:
> > > > > > > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=
=B44=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > Hi, Zheng
> > > > > > > > > >
> > > > > > > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng=
666@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Friendly ping about the bug.
> > > > > > > > > >
> > > > > > > > > > Sorry, wasn't aware of this message before,
> > > > > > > > > >
> > > > > > > > > > Could you please help share the instructions to reprodu=
ce the problem
> > > > > > > > > > this change fixes?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hi Yongqin,
> > > > > > > > >
> > > > > > > > > Thanks for your reply. This bug is found by static analys=
is. There is no PoC.
> > > > > > > > >
> > > > > > > > > >From my personal experience, triggering race condition b=
ugs stably in
> > > > > > > > > the kernel needs some tricks.
> > > > > > > > > For example, you can insert some sleep-time code to slow =
down the
> > > > > > > > > thread until the related object is freed.
> > > > > > > > > Besides, you can use gdb to control the time window. Also=
, there are
> > > > > > > > > some other tricks as [1] said.
> > > > > > > > >
> > > > > > > > > As for the reproduction, this attack vector requires that=
 the attacker
> > > > > > > > > can physically access the device.
> > > > > > > > > When he/she unplugs the usb, the remove function is trigg=
ered, and if
> > > > > > > > > the set callback is invoked, there might be a race condit=
ion.
> > > > > > > >
> > > > > > > > How does the removal of the USB device trigger a platform d=
evice
> > > > > > > > removal?
> > > > > > >
> > > > > > > Sorry I made a mistake. The USB device usually calls disconne=
ct
> > > > > > > callback when it's unpluged.
> > > > > >
> > > > > > Yes, but you are changing the platform device disconnect, not t=
he USB
> > > > > > device disconnect.
> > > > > >
> > > > > > > What I want to express here is When the driver-related device=
(here
> > > > > > > it's USB GPIO Hub) was removed, the remove function is trigge=
red.
> > > > > >
> > > > > > And is this a patform device on a USB device?  If so, that's a =
bigger
> > > > > > problem that we need to fix as that is not allowed.
> > > > >
> > > > > No this is not a platform  device on a USB device.
> > > > >
> > > > > >
> > > > > > But in looking at the code, it does not seem to be that at all,=
 this is
> > > > > > just a "normal" platform device.  So how can it ever be removed=
 from the
> > > > > > system?  (and no, unloading the driver doesn't count, that can =
never
> > > > > > happen on a normal machine.)
> > > > > >
> > > > >
> > > > > Yes, I finally figured out your meaning. I know it's hard to unpl=
ug
> > > > > the platform device
> > > > > directly. All I want to express is that it's a theoretical method
> > > > > except  rmmod. I think it's better to fix the bug. But if the
> > > > > developers think it's practically impossible, I think there's no =
need
> > > > > to take further action.
> > > > >
> > > > > Sorry for wasting your time and thanks for your explanation.
> > > > >
> > > > > Best regards,
> > > > > Zheng
> > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > >
> > > >
> > > >
> > > > --
> > > > Best Regards,
> > > > Yongqin Liu
> > > > ---------------------------------------------------------------
> > > > #mailing list
> > > > linaro-android@lists.linaro.org
> > > > http://lists.linaro.org/mailman/listinfo/linaro-android
> >
> >
> >
> > --
> > Best Regards,
> > Yongqin Liu
> > ---------------------------------------------------------------
> > #mailing list
> > linaro-android@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-android



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
