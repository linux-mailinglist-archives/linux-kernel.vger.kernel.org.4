Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41356E4F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDQRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDQRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:31:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC237902E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:31:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-552fb3c2bb7so17536587b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681752694; x=1684344694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AmmSDrsQHdnhufQ9cCGYdxSLK6ckhPta0CA+BQUdMg=;
        b=Vgq2uPR7sumT6O4mlILxLag5gF6XWWQWaawnnlkxvXW7T7iHpuwqV4Di5iVALdndHz
         J1r91xq2rJkKfhEHoxqKFApZpP/wH2CKbp+CgnRELeYurJrr/4xogi96drJePWgREzWZ
         8E6a5a2Inkj2x0uRY0L5t0/lMuW7jiJtFypGCpwamd0wBz1lKHIIOMTxWT6gL6OjhOkn
         aD3S1It9V4xem0z0DME1ADMpd0sQLQlvyA8QQ2C5KCz8M5oSl18x9BmNeQLH7nzBzGNZ
         E+9RSXy6CFt989wGmJPrSl028qvmU8SzidvFxbxIPV1BZCl5yw89H+dsNvh3WuUQwqRN
         gE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752694; x=1684344694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AmmSDrsQHdnhufQ9cCGYdxSLK6ckhPta0CA+BQUdMg=;
        b=GwRRMCLnAYHVRDVSxw1zTgauptAdk8K4OfF/s33UUoVu1+RvHvlqQmQZRtOcfmQvdu
         kGT29TNh1lcHr6SQrX5m4fAcxRZ6xY6SSp6TBQ0ummeemYmZ2Q2wQQO7EBW6KmEhRa7j
         odBAvLPS2jktJNUirBheeiQcwY/4iI0UFCI4mNv3er2XQ+0fzHs/7JUKMZHFnlbF0h0T
         o8AnhrXuDf5WzvpZz4iAvM42RhqXaDp5BBRcIrRpGQ+BtTEq71mOwmfQFZoEmbwB2Vdq
         XfnScD0c8vQZ3vfPmV6IoHKOrL5uKv0azxZJD2T3xn8G11M9cgi3lCzloSDKlugBN6G+
         Y59Q==
X-Gm-Message-State: AAQBX9fh5+86jD+bDbDpytfSCS1qrS61U1875vQT/ljR9Q8XdszPQdZm
        Ufq7BhK5+9WRA18sWY8VPWT9ZXKbzd94hHCCN1BSIg==
X-Google-Smtp-Source: AKy350bMo2Rbb94Y3xd/fzP8VtuLhBaocbaNIqc2eri7slSpPRTQ4jHbTCOpY6sLucUPqJtZ2mHNmdfSXyu34tnWURg=
X-Received: by 2002:a81:b621:0:b0:54c:bf7:1853 with SMTP id
 u33-20020a81b621000000b0054c0bf71853mr10417013ywh.6.1681752694033; Mon, 17
 Apr 2023 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com> <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
 <2023041308-nerd-dry-98a6@gregkh> <CAJedcCyeM2a79i0=ffKwdKfnQayo7svhTTEth2ka6K9np0Ztiw@mail.gmail.com>
 <2023041308-unvisited-slinky-a56f@gregkh> <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
In-Reply-To: <CAJedcCxzGbUSj0nh4xYp8P2zhYSM31CGi2fGE+9VJt7mkg6h4g@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Tue, 18 Apr 2023 01:31:20 +0800
Message-ID: <CAMSo37V3vgjzgM_3Toy2HGwVuFcTw9DfVKDnVNaD-j4UJtOPvg@mail.gmail.com>
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

Sorry for the late reply.

I tested this change with Android build based on the ACK
android-mainline branch.
The hisi_hikey_usb module could not be removed with error like this:
    console:/ # rmmod -f hisi_hikey_usb
    rmmod: failed to unload hisi_hikey_usb: Try again
    1|console:/ #
Sorry I am not able to reproduce any problem without this commit,
but I do not see any problem with this change applied either.

If there is any specific things you want to check, please feel free let me =
know

Thanks,
Yongqin Liu


On Fri, 14 Apr 2023 at 00:46, Zheng Hacker <hackerzheng666@gmail.com> wrote=
:
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 23:56=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Apr 13, 2023 at 11:35:17PM +0800, Zheng Hacker wrote:
> > > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=88=
13=E6=97=A5=E5=91=A8=E5=9B=9B 20:48=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> > > > > Yongqin Liu <yongqin.liu@linaro.org> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hi, Zheng
> > > > > >
> > > > > > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > Friendly ping about the bug.
> > > > > >
> > > > > > Sorry, wasn't aware of this message before,
> > > > > >
> > > > > > Could you please help share the instructions to reproduce the p=
roblem
> > > > > > this change fixes?
> > > > > >
> > > > >
> > > > > Hi Yongqin,
> > > > >
> > > > > Thanks for your reply. This bug is found by static analysis. Ther=
e is no PoC.
> > > > >
> > > > > >From my personal experience, triggering race condition bugs stab=
ly in
> > > > > the kernel needs some tricks.
> > > > > For example, you can insert some sleep-time code to slow down the
> > > > > thread until the related object is freed.
> > > > > Besides, you can use gdb to control the time window. Also, there =
are
> > > > > some other tricks as [1] said.
> > > > >
> > > > > As for the reproduction, this attack vector requires that the att=
acker
> > > > > can physically access the device.
> > > > > When he/she unplugs the usb, the remove function is triggered, an=
d if
> > > > > the set callback is invoked, there might be a race condition.
> > > >
> > > > How does the removal of the USB device trigger a platform device
> > > > removal?
> > >
> > > Sorry I made a mistake. The USB device usually calls disconnect
> > > callback when it's unpluged.
> >
> > Yes, but you are changing the platform device disconnect, not the USB
> > device disconnect.
> >
> > > What I want to express here is When the driver-related device(here
> > > it's USB GPIO Hub) was removed, the remove function is triggered.
> >
> > And is this a patform device on a USB device?  If so, that's a bigger
> > problem that we need to fix as that is not allowed.
>
> No this is not a platform  device on a USB device.
>
> >
> > But in looking at the code, it does not seem to be that at all, this is
> > just a "normal" platform device.  So how can it ever be removed from th=
e
> > system?  (and no, unloading the driver doesn't count, that can never
> > happen on a normal machine.)
> >
>
> Yes, I finally figured out your meaning. I know it's hard to unplug
> the platform device
> directly. All I want to express is that it's a theoretical method
> except  rmmod. I think it's better to fix the bug. But if the
> developers think it's practically impossible, I think there's no need
> to take further action.
>
> Sorry for wasting your time and thanks for your explanation.
>
> Best regards,
> Zheng
>
> > thanks,
> >
> > greg k-h



--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
