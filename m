Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50496E8A69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjDTGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDTGbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:31:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74064220
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:31:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fbee98814so27628187b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681972269; x=1684564269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+lZScYJNTxSdjIaFO6rSua9y6ktROp8kre5Iy1sq1M=;
        b=AIL/goR1vxia3BkgH87QaIgNuz8aY874MBCR4sprrb3JlaecP3ZCOIUedcluZ4q6ol
         hAVr1O6IwUQD4XvlA0p6cgNxcnHVq9lVZbrN/Rzxv6865n/kt/cpcQUtpPS1XrCgNtoT
         sZnv2jHUedRMv7kQ+7aEl+/zywy0hGTnpHOcog1NxexB8WgbZSaG8bP83j3xUXeNcWSy
         Olne1CsPV8SXA/L8/eDwlHH6fDPQzH9Kt4aW8eM0Fi6LLJgxVvVG7/66OuE4jJ7rBrHe
         JMA/3yQSSqbdUDF8Ouym09E77VRQG5KNlaAXyEigkC8kqI2FvcTb9s8X5FW4TRdQRwO7
         UixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972269; x=1684564269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+lZScYJNTxSdjIaFO6rSua9y6ktROp8kre5Iy1sq1M=;
        b=ir0yKQWeUtAB3OHfGnCGE4LUUu4eyLTtqy1r77F0FcB58Y9dqv4uk+puBojG9mX7an
         QKZz4ODY3vDxG9SnkuHUUnsrAHblB7lNEBloSKQpfLK7/0Epo+Wrjy5UmaZ8/ueu3WhM
         jnVKbyyuie+KxN5goJlBTg3KzCKWoqJdszTeN4w/1lyj2NvJ1TsQhVvIxuzl+RLkHFaJ
         IBfFVELuQV6Y3Hm6RN2OL+8PbIc0xnHubfND78DGFXqDiuPFyZiAnsMA3em3lVDS/3am
         MdvPrvocz1NMrYaNlpI5xCyfFdvihSJj1BPBDu7ZiAhUiVIfPexTF5C10VoBhGzNOBdr
         c1Uw==
X-Gm-Message-State: AAQBX9cf/TFGZdy3GFwe0TkD3TfHHirLU20hb5SQfe0RgXMt2vjypLrY
        tyUZVljXz3Dl+jlOe3KxVutHZc+GmZ11k6yg/zUkYA==
X-Google-Smtp-Source: AKy350b+vMIPlAyo+7flFGO0A3Bkr8psntWRPhZsGGRxl1LHBIkbyQqzaS+DY2fvB3i5aLPBLluu8XWs+nfMjTxSDI8=
X-Received: by 2002:a0d:d146:0:b0:54f:d7f7:9d61 with SMTP id
 t67-20020a0dd146000000b0054fd7f79d61mr75910ywd.14.1681972269116; Wed, 19 Apr
 2023 23:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh> <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
 <2023041308-unvisited-slinky-a56f@gregkh> <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
 <CAMSo37V3vgjzgM_3Toy2HGwVuFcTw9DfVKDnVNaD-j4UJtOPvg@mail.gmail.com> <CAJedcCwow9sTEzZpiqmmcEDZ0XFLauA_tVBTJf5MfpadC1M+cQ@mail.gmail.com>
In-Reply-To: <CAJedcCwow9sTEzZpiqmmcEDZ0XFLauA_tVBTJf5MfpadC1M+cQ@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 20 Apr 2023 14:30:57 +0800
Message-ID: <CAMSo37VxLfqg7UGY8CYAYz8nqoJ12T2mERbKNn67e_+yOD3cXQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zheng

BTW, I just see cancel_delayed_work_sync is used in
the drivers/usb/common/usb-conn-gpio.c usb_conn_remove function.
    https://android.googlesource.com/kernel/common/+/refs/heads/android-mai=
nline/drivers/usb/common/usb-conn-gpio.c#274

I know nothing about the cancel_delayed_work_sync and cancel_work_sync
functions,
just for your information in case cancel_delayed_work_sync might be
better to be used here.

Thanks,
Yongqin Liu
On Tue, 18 Apr 2023 at 21:18, Zheng Hacker <hackerzheng666@gmail.com> wrote=
:
>
> Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=8C 01:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi, Zheng
> >
> > Sorry for the late reply.
> >
> > I tested this change with Android build based on the ACK
> > android-mainline branch.
> > The hisi_hikey_usb module could not be removed with error like this:
> >     console:/ # rmmod -f hisi_hikey_usb
> >     rmmod: failed to unload hisi_hikey_usb: Try again
> >     1|console:/ #
> > Sorry I am not able to reproduce any problem without this commit,
> > but I do not see any problem with this change applied either.
> >
> > If there is any specific things you want to check, please feel free let=
 me know
> >
>
> Hi Yongqin,
>
> Thanks for your testing. I have no more questions about the issue.
>
> Best regards,
> Zheng
>
> > Thanks,
> > Yongqin Liu
> >
> >
> > On Fri, 14 Apr 2023 at 00:46, Zheng Hacker <hackerzheng666@gmail.com> w=
rote:
> > >
> > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=88=
13=E6=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > > > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > > > > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=
=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > Hi, Zheng
> > > > > > > >
> > > > > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@=
gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Friendly ping about the bug.
> > > > > > > >
> > > > > > > > Sorry, wasn't aware of this message before,
> > > > > > > >
> > > > > > > > Could you please help share the instructions to reproduce t=
he problem
> > > > > > > > this change fixes?
> > > > > > > >
> > > > > > >
> > > > > > > Hi Yongqin,
> > > > > > >
> > > > > > > Thanks for your reply. This bug is found by static analysis. =
There is no PoC.
> > > > > > >
> > > > > > > >From my personal experience, triggering race condition bugs =
stably in
> > > > > > > the kernel needs some tricks.
> > > > > > > For example, you can insert some sleep-time code to slow down=
 the
> > > > > > > thread until the related object is freed.
> > > > > > > Besides, you can use gdb to control the time window. Also, th=
ere are
> > > > > > > some other tricks as [1] said.
> > > > > > >
> > > > > > > As for the reproduction, this attack vector requires that the=
 attacker
> > > > > > > can physically access the device.
> > > > > > > When he/she unplugs the usb, the remove function is triggered=
, and if
> > > > > > > the set callback is invoked, there might be a race condition.
> > > > > >
> > > > > > How does the removal of the USB device trigger a platform devic=
e
> > > > > > removal?
> > > > >
> > > > > Sorry I made a mistake. The USB device usually calls disconnect
> > > > > callback when it's unpluged.
> > > >
> > > > Yes, but you are changing the platform device disconnect, not the U=
SB
> > > > device disconnect.
> > > >
> > > > > What I want to express here is When the driver-related device(her=
e
> > > > > it's USB GPIO Hub) was removed, the remove function is triggered.
> > > >
> > > > And is this a patform device on a USB device?  If so, that's a bigg=
er
> > > > problem that we need to fix as that is not allowed.
> > >
> > > No this is not a platform  device on a USB device.
> > >
> > > >
> > > > But in looking at the code, it does not seem to be that at all, thi=
s is
> > > > just a "normal" platform device.  So how can it ever be removed fro=
m the
> > > > system?  (and no, unloading the driver doesn't count, that can neve=
r
> > > > happen on a normal machine.)
> > > >
> > >
> > > Yes, I finally figured out your meaning. I know it's hard to unplug
> > > the platform device
> > > directly. All I want to express is that it's a theoretical method
> > > except  rmmod. I think it's better to fix the bug. But if the
> > > developers think it's practically impossible, I think there's no need
> > > to take further action.
> > >
> > > Sorry for wasting your time and thanks for your explanation.
> > >
> > > Best regards,
> > > Zheng
> > >
> > > > thanks,
> > > >
> > > > greg k-h
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
