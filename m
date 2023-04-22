Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC22B6EBA90
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDVRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:09:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553C2114
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:09:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51b661097bfso2447917a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682183378; x=1684775378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk2042zfNAUEsSfOk/Grl8pMqFin7l2KkxbaVxctjkE=;
        b=dFbCw366hsVpu6+RVxsTm6f0iw+Ajze0I2LLToOn3MhBIqcCUgQQ++JaE1q9vKrqyj
         TaHniYHmRWwts4uYpktfYSgCqi7296zfu2AnRSVNUZlIhsJTpTR5v17OhfSojkqTJHOI
         DUMWWa27HvvQ7hxgYexV2CSKQ86lGWuf+na8dWSCj3YW7O1G+8awy8wB2d1xOBefmNPs
         EKcuDGCO7qzedMmqEFQwVG5V0cOZzcbeRSQCqqGVDGENEl/vX18NJj/EOufCnxP1Yvr7
         pQ0yMjcd0VqtwThn8HKYVzxHCdzcptjgviEPorGqbUJf2kd8B8wqeZr75s8lMY/rllKB
         RzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682183378; x=1684775378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk2042zfNAUEsSfOk/Grl8pMqFin7l2KkxbaVxctjkE=;
        b=ZCSd55OC3wkS986pISSBEaM8V7uVlUhEDUXrl7noxg40FyYuHCZ7OExvSt3SHeU6p9
         Z0gA8Yr/i4/WW9T1c9vKbXglhxkPZvnQ5hxJt6O3G8lvZmMXiaQ5GcFEraCM3hPzG3fW
         BOXDHBHfabp9OIT1t9nuGsTDEX1L8v2Ejgj7oCbmnduwMzM9T8HM/J4MhNtoAyVN9kfQ
         p4XxHDx9MMWJdI5dIc4e4K1nkiKPfnTlb0cP6hdFVxWUuzVM3jEt641MNN9PhaKum4NV
         2KOVKeur5IPhVUnk78MccswKKuEhk8RzUUwD/pxnvKO2AVS8DpnG3QL4kMnTtNreQfNx
         yIkw==
X-Gm-Message-State: AAQBX9fm1qU5wIyhgtfRMiGiAwvuHXz9/WFbk3wCUIhqZsaiBDelYdNM
        ns3nyH1x0EXrw7hByJWHcyz8ryYPt/neECjoQ5k=
X-Google-Smtp-Source: AKy350YjxgXrepsX7lYd1L9ayIvBQKGCZjEnSYSlZwD/uY2WUxJu4my15n2n8bp1FJHnkdrQQh49KjzMoKAgy52YUIY=
X-Received: by 2002:a17:90a:398c:b0:23f:58a2:7d86 with SMTP id
 z12-20020a17090a398c00b0023f58a27d86mr9055879pjb.10.1682183377949; Sat, 22
 Apr 2023 10:09:37 -0700 (PDT)
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
 <CAMSo37VxLfqg7UGY8CYAYz8nqoJ12T2mERbKNn67e_+yOD3cXQ@mail.gmail.com>
 <CAJedcCxQAarCMKWsqa9nL-obRGaspcvcOVfx3d8KOZuK7VxbKg@mail.gmail.com> <CAMSo37Vse=gVqC_2LU44YzOepXpy909kSDSQjebb0zyk-b27kg@mail.gmail.com>
In-Reply-To: <CAMSo37Vse=gVqC_2LU44YzOepXpy909kSDSQjebb0zyk-b27kg@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 23 Apr 2023 01:09:26 +0800
Message-ID: <CAJedcCzThMhmysk7GTmTQ2gN6tdQLcqfxi4FXTNHzcX48a9ycg@mail.gmail.com>
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

Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=94 23:42=E5=86=99=E9=81=93=EF=BC=9A
>
> HI, Zheng
>
> Thanks for the explanation!
> BTW, from what I tested, I am OK to have this change merged.
>

Hi Yongqin,

Thanks for your testing and review.

Best regards,
Zheng

> Thanks,
> Yongqin Liu
> On Fri, 21 Apr 2023 at 10:35, Zheng Hacker <hackerzheng666@gmail.com> wro=
te:
> >
> > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 14:31=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi, Zheng
> > >
> > > BTW, I just see cancel_delayed_work_sync is used in
> > > the drivers/usb/common/usb-conn-gpio.c usb_conn_remove function.
> > >     https://android.googlesource.com/kernel/common/+/refs/heads/andro=
id-mainline/drivers/usb/common/usb-conn-gpio.c#274
> > >
> > > I know nothing about the cancel_delayed_work_sync and cancel_work_syn=
c
> > > functions,
> > > just for your information in case cancel_delayed_work_sync might be
> > > better to be used here.
> > >
> >
> > HI Yongqin,
> >
> > Thanks for your kind reminder. The cancel_delayed_work_sync is used
> > with INIT_DELAYED_WORK and queue_delayed_work.
> > This is used to start a work after some time while schedule_work means
> > start it immediately.
> >
> > In this case, the &hisi_hikey_usb->work is initialized with INIT_WORK
> > and scheduled with schedule_work. So I think we'd better use
> > cancel_work_sync here. I'm also not so familiar with the code. If
> > there's something wrong with it, please feel free to let me know.
> >
> > Best regards,
> > Zheng
> >
> >
> > > Thanks,
> > > Yongqin Liu
> > > On Tue, 18 Apr 2023 at 21:18, Zheng Hacker <hackerzheng666@gmail.com>=
 wrote:
> > > >
> > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=BA=8C 01:31=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi, Zheng
> > > > >
> > > > > Sorry for the late reply.
> > > > >
> > > > > I tested this change with Android build based on the ACK
> > > > > android-mainline branch.
> > > > > The hisi_hikey_usb module could not be removed with error like th=
is:
> > > > >     console:/ # rmmod -f hisi_hikey_usb
> > > > >     rmmod: failed to unload hisi_hikey_usb: Try again
> > > > >     1|console:/ #
> > > > > Sorry I am not able to reproduce any problem without this commit,
> > > > > but I do not see any problem with this change applied either.
> > > > >
> > > > > If there is any specific things you want to check, please feel fr=
ee let me know
> > > > >
> > > >
> > > > Hi Yongqin,
> > > >
> > > > Thanks for your testing. I have no more questions about the issue.
> > > >
> > > > Best regards,
> > > > Zheng
> > > >
> > > > > Thanks,
> > > > > Yongqin Liu
> > > > >
> > > > >
> > > > > On Fri, 14 Apr 2023 at 00:46, Zheng Hacker <hackerzheng666@gmail.=
com> wrote:
> > > > > >
> > > > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > > > > > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wr=
ote:
> > > > > > > > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=
=B9=B44=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > > > >
> > > > > > > > > > > Hi, Zheng
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzhe=
ng666@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Friendly ping about the bug.
> > > > > > > > > > >
> > > > > > > > > > > Sorry, wasn't aware of this message before,
> > > > > > > > > > >
> > > > > > > > > > > Could you please help share the instructions to repro=
duce the problem
> > > > > > > > > > > this change fixes?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Hi Yongqin,
> > > > > > > > > >
> > > > > > > > > > Thanks for your reply. This bug is found by static anal=
ysis. There is no PoC.
> > > > > > > > > >
> > > > > > > > > > >From my personal experience, triggering race condition=
 bugs stably in
> > > > > > > > > > the kernel needs some tricks.
> > > > > > > > > > For example, you can insert some sleep-time code to slo=
w down the
> > > > > > > > > > thread until the related object is freed.
> > > > > > > > > > Besides, you can use gdb to control the time window. Al=
so, there are
> > > > > > > > > > some other tricks as [1] said.
> > > > > > > > > >
> > > > > > > > > > As for the reproduction, this attack vector requires th=
at the attacker
> > > > > > > > > > can physically access the device.
> > > > > > > > > > When he/she unplugs the usb, the remove function is tri=
ggered, and if
> > > > > > > > > > the set callback is invoked, there might be a race cond=
ition.
> > > > > > > > >
> > > > > > > > > How does the removal of the USB device trigger a platform=
 device
> > > > > > > > > removal?
> > > > > > > >
> > > > > > > > Sorry I made a mistake. The USB device usually calls discon=
nect
> > > > > > > > callback when it's unpluged.
> > > > > > >
> > > > > > > Yes, but you are changing the platform device disconnect, not=
 the USB
> > > > > > > device disconnect.
> > > > > > >
> > > > > > > > What I want to express here is When the driver-related devi=
ce(here
> > > > > > > > it's USB GPIO Hub) was removed, the remove function is trig=
gered.
> > > > > > >
> > > > > > > And is this a patform device on a USB device?  If so, that's =
a bigger
> > > > > > > problem that we need to fix as that is not allowed.
> > > > > >
> > > > > > No this is not a platform  device on a USB device.
> > > > > >
> > > > > > >
> > > > > > > But in looking at the code, it does not seem to be that at al=
l, this is
> > > > > > > just a "normal" platform device.  So how can it ever be remov=
ed from the
> > > > > > > system?  (and no, unloading the driver doesn't count, that ca=
n never
> > > > > > > happen on a normal machine.)
> > > > > > >
> > > > > >
> > > > > > Yes, I finally figured out your meaning. I know it's hard to un=
plug
> > > > > > the platform device
> > > > > > directly. All I want to express is that it's a theoretical meth=
od
> > > > > > except  rmmod. I think it's better to fix the bug. But if the
> > > > > > developers think it's practically impossible, I think there's n=
o need
> > > > > > to take further action.
> > > > > >
> > > > > > Sorry for wasting your time and thanks for your explanation.
> > > > > >
> > > > > > Best regards,
> > > > > > Zheng
> > > > > >
> > > > > > > thanks,
> > > > > > >
> > > > > > > greg k-h
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards,
> > > > > Yongqin Liu
> > > > > ---------------------------------------------------------------
> > > > > #mailing list
> > > > > linaro-android@lists.linaro.org
> > > > > http://lists.linaro.org/mailman/listinfo/linaro-android
> > >
> > >
> > >
> > > --
> > > Best Regards,
> > > Yongqin Liu
> > > ---------------------------------------------------------------
> > > #mailing list
> > > linaro-android@lists.linaro.org
> > > http://lists.linaro.org/mailman/listinfo/linaro-android
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
