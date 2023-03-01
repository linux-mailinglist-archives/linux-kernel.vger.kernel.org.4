Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E26A7278
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCASA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCASAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:00:54 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5614A1C0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:00:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay18so8507341pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677693652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxa4Rc8VDy76gmqulD4S2n6Ky3HQX/rxECqpNQ72Q1g=;
        b=a4azZg2hjyeXI7ITrQhBbiclO6nNciuwO5C8nQYvqf7R6IzPY9FpSIYiuLFJqdD3d2
         BL+kBDKfss2JgT7ZeLgjCwpVFwMuGeyhh4EgepGLlveQxbyOnoFnSn27V3+N5pR2NlQO
         /28FXozzhArcK9cH3j01FLE4kwISsF4tcWyf9Qaf1y90Zm9M4R96mFeWKZqJuEceAvQt
         gRtYmMJvxT1I5YUPgHyUDHG3xvcWaCgbgVqPh5vNCWv+xXcQLV84hZsPyoVXUDLTHNBV
         vVFVaqtUxdcaeow7XYivshIwmf09d6cLB8JpKZAXBqHHjwbJOt53XWeSOypv6nTI3wI4
         ijTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bxa4Rc8VDy76gmqulD4S2n6Ky3HQX/rxECqpNQ72Q1g=;
        b=ubEr6GpX6M3I4bvhJXemgZ/6osZXE55o9c7lfrmR1ChxgCN0m4Jf2qY3OWhCi9GkQA
         85v6d2PW/PMXfzWPdqK9yy6AmL49HlCp+nQBnX0cwDS2kgPNBFGTzi1q1rhgb8/dSL8t
         f+SV6QrYt2FdnQ8J0mGKOsB0AyyDewx/bXK8mZtn0XF4eHITb2i9cYCTdxlOisRw1+VB
         GOrjrBqLQAQCEEHA94tgHAsePOPtykP87JEQ7MwkzMbSFdz1HG1EFzKgWswL74qMNpwf
         VyGU+7xJpfkwgxd+OQAcRR0vA6/4k8Vuoh/fNK4Ez0LVFvPm0VDkJpniSmbY/DbBr8Vj
         BuVw==
X-Gm-Message-State: AO0yUKXxwtb3N1tTMXj6Y1Tugg3bc7Msa3HvD2uhutglcQl0mJFsxOJN
        D6nYgYeN6XaSDG42a21mqNz3pu7IPiA+TWpIujil1w==
X-Google-Smtp-Source: AK7set9D4YmqfTQ2PJTcTQcHcEX2tKIcnua6TEVm5hhkXaWy09mFFbMEWWIG/yEbdH6B/4tStF8kNOZUtFdFyGDw0TE=
X-Received: by 2002:a05:6a00:be1:b0:5e9:57b1:5bda with SMTP id
 x33-20020a056a000be100b005e957b15bdamr2717455pfu.3.1677693651506; Wed, 01 Mar
 2023 10:00:51 -0800 (PST)
MIME-Version: 1.0
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
 <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
 <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com> <f13906c0-1a0c-dfa4-dcd3-96ebc82aabd8@gmail.com>
 <CAGETcx-0EKYBL_fQbZSUra3LrzOnV4LABUBZ_jEBmW3sdUzZPA@mail.gmail.com> <465a444d-3edb-e6ae-3505-59be9f7509c2@i2se.com>
In-Reply-To: <465a444d-3edb-e6ae-3505-59be9f7509c2@i2se.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Mar 2023 10:00:14 -0800
Message-ID: <CAGETcx9uwHdttLt6trTSTgag2uwrB=hEqnVcyN=Up1wqrwu7Sw@mail.gmail.com>
Subject: Re: Raspberry Pi 4B: Failed to create device link with soc:firmware:gpio
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 8:57=E2=80=AFAM Stefan Wahren <stefan.wahren@i2se.co=
m> wrote:
>
> Hi Saravana,
>
> Am 01.03.23 um 08:49 schrieb Saravana Kannan:
> > On Sun, Feb 26, 2023 at 11:14=E2=80=AFAM Florian Fainelli <f.fainelli@g=
mail.com> wrote:
> >>
> >>
> >> On 2/25/2023 5:58 PM, Florian Fainelli wrote:
> >>>
> >>> On 2/25/2023 4:01 PM, Saravana Kannan wrote:
> >>>> On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli
> >>>> <f.fainelli@gmail.com> wrote:
> >>>>> Hi Saravana,
> >>>>>
> >>>>> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the follo=
wing
> >>>>> for the "extended GPIO" provider:
> >>>>>
> >>>>> [    5.969855] uart-pl011 fe201000.serial: Failed to create device =
link
> >>>>> with soc:firmware:gpio
> >>>> Outside of this error, is it actually breaking anything?
> >>> There is just this warning, there does not appear to be a functional =
issue.
> >>>
> >>>> Also, can you
> >>>> pull in this patch and tell me what it says? I want to know what the
> >>>> flags are.
> >>>> https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@googl=
e.com/
> >> Pulling in this patch results in the following being printed:
> >>
> >> [   14.866835] uart-pl011 fe201000.serial: Failed to create device lin=
k
> >> (0x180) with soc:firmware:gpio
> > I spent at least 2 hours looking at the logs and the DT files and I'm
> > still kinda lost.
> >
> > The 0x180 means it's a DL_FLAG_INFERRED | DL_FLAG_SYNC_STATE_ONLY.
> > That's just fw_devlink trying to create a "proxy" link where an
> > ancestor of a consumer (can be several levels above consumer) creates
> > a SYNC_STATE_ONLY link to the supplier while we wait for the consumer
> > device to get added. This prevents sync_state() from being called too
> > early on the supplier.
> >
> > There are so many includes in the dts/dtsi files that my head is
> > spinning. I finally found out where the soc:firmware:gpio device was
> > coming from (after confusing myself with gpio@7e200000 for a bit) and
> > where fe201000.serial was coming from. I still couldn't figure out how
> > the address got mapped to fe201000 in fe201000.serial -- that
> > generally means the parent has some address offset, but I don't see
> > that in DT (but it is not important for this discussion, so we can
> > ignore that).
> This is uart0 which is at first defined in bcm283x.dtsi. On the
> Raspberry Pi 4 this UART is connected to the Bluetooth IC. On Linux
> probing of the serial communication via DT is done via serial device bus
> (see bcm283x-rpi-wifi-bt.dtsi).

Sigh... this is the connection I needed.

> > Anyway, I see no supplier-consumer link between serial@7e201000 (or
> > any of its zero descendants) and soc:firmware:gpio (which is the node
> > expgpio:). So I'm very confused why we might even try to create this
> > sync state only device link between these two.
> >
> > There are actually two times where we try to create such a link:
> >
> > First attempt that actually succeeds -- but I have no idea why we even =
do this:
> > [    0.100047] device:
> > 'platform:soc:firmware:gpio--amba:fe201000.serial': device_add
> > [    0.100232] amba fe201000.serial: Linked as a sync state only
> > consumer to soc:firmware:gpio
>
> I assume the link is established by raspberry,firmware-gpio which
> provides the necessary BT shutdown-gpios defined in bcm2711-rpi-4-b.dts.
> Seems to me that the problem is, that necessary underlying firmware
> driver is probed "too late":
>
> [ 15.456506] raspberrypi-firmware soc:firmware: Attached to firmware
> from 2020-02-12T12:36:21
>
> Hope this helps a little bit

Definitely! Thanks!

Florian, don't bother with the rest of my debug request. I think I
know what's going on. I'll come back if I need more help.

-Saravana

>
> > the "amba" prefix tells us a driver hasn't been bound to fe201000.seria=
l yet.
> >
> > Second attempt is the one that fails.
> > [   15.516166] uart-pl011 fe201000.serial: Failed to create device
> > link (0x180) with soc:firmware:gpio
> > The uart-pl011 tells us that the driver has bound to fe201000.serial.
> >
> > And it fails because of this sensible check I had put up a while ago
> > inside device_link_add():
> >          /*
> >           * SYNC_STATE_ONLY links are useless once a consumer device
> > has probed.
> >           * So, only create it if the consumer hasn't probed yet.
> >           */
> >          if (flags & DL_FLAG_SYNC_STATE_ONLY &&
> >              consumer->links.status !=3D DL_DEV_NO_DRIVER &&
> >              consumer->links.status !=3D DL_DEV_PROBING) {
> >                  link =3D NULL;
> >                  goto out;
> >          }
> >
> > So the real question is still to figure out why fw_devlink is trying
> > to create this device link.
> >
> > So to debug this further the following would help a lot:
> > 1. Pull the dtb from the device and then decompile it and provide me
> > the result. This way, I can be sure I'm not missing something and
> > don't have to dig through all the includes -- I forgot the exact
> > commands for it, but it's been shared in LKML before. Let me know if
> > you need me to dig this up.
> >
> > 2. I think a stack backtrace when these two device link attempts are
> > made might help me figure out why they are being created. To get these
> > backtraces, can you do the following please?
> > a. Put a WARN_ON() inside device_add() for when the device name matches=
:
> > platform:soc:firmware:gpio--amba:fe201000.serial
> > b. Put a WARN_ON(1) where we print "Failed to create device link..."
> >
> > Feel free to dig more into 2a and 2b if you find that the stack trace
> > doesn't tell much -- one problem with the stack trace is that it
> > doesn't show the params being passed to
> > __fw_devlink_link_to_consumers() and __fw_devlink_link_to_suppliers()
> >
> > Thanks,
> > Saravana
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
