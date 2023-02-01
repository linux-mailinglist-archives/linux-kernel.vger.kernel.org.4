Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0C686D67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBARul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBARui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:50:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105AB451;
        Wed,  1 Feb 2023 09:50:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id pj3so5202110pjb.1;
        Wed, 01 Feb 2023 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmdfYs/Apl355h/40Fx5iiANfdkirpnGZD8/2Zxo3WQ=;
        b=SA05Phsb78zDeWC86dfrbhdedB4Tq02RYUC427daOUmcL5AqVr3+Bq6eIP6V3hxmO+
         aWe/hRFi6DpqS81U3GTXBuPuCG9Sxe5PilyyqBOkAChVjjU+e89ZTSfyegHmGKiqp0lq
         pYqVVa93DX/66tkxb8vdTFVBAFboM44swiiPqoDXhZegbmjlZBBQca90SUXXjb4SM5n/
         glo1Vwq0TY3YyqE3eMOPlXtfoZd4QPYVCWy+80BIJpvAR5kKm0zMe0MeJuvXImjmCgRI
         kJ8esbtk7V4w6Mbmodpqv1ubhCNTgb7fjhepNqdkRPDdaITzn59JMkNtfknfTTW6ihQ3
         owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmdfYs/Apl355h/40Fx5iiANfdkirpnGZD8/2Zxo3WQ=;
        b=MFx8NDhcVBNftr+e3YrhRKqjSz94HSqL09hEf2owmTnaxg+R55FXOdZZlKP20PX/HK
         yd/LbG2rHx/M8dbq339WM8oBuUYzUo7ygZ4XYDNwpftTYNLggbOz7yjfz8g8wVRZucRT
         Q1oc5wvQmHq6mIjFz/UW45FaSuSVgCOQLOhx14U7Uo2HO23S4aGy8tDMWWQhF67H4j92
         RQOjkcLghJAkoLrBZVl+aWNJOBzk5KLJMfHjwsHrY3FLIJUoTnfEoU+m++2609/HipF7
         DYKWtKEA6paLs6lULk+/anpUE2nSefovr1NT41FwluvKnTD0Qf/6cp+j4evGNt8FzopL
         VhrA==
X-Gm-Message-State: AO0yUKUZB8h93jqQuQKOs9vCLOxgo/vxr3mdQOx5J7U8LHuPBtQF2Ve2
        7lzoscXyqe99US/eXirHVPKW+2mp670C0HLSMmQ=
X-Google-Smtp-Source: AK7set+LEGdp2gzAkxQBMqO46Pvt9YKx7VzUnnpoFHwASGWaKPZZnH8CaEF/DUGxdAHza3R97U6lhv2Km98LeHuwAgA=
X-Received: by 2002:a17:90a:3806:b0:22c:649:ce3c with SMTP id
 w6-20020a17090a380600b0022c0649ce3cmr585762pjb.95.1675273836516; Wed, 01 Feb
 2023 09:50:36 -0800 (PST)
MIME-Version: 1.0
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <Y9WGmBc9HG4Tx9gf@eldamar.lan> <CAMxBKG1670TFuV3nHP7Yk8s6H+oBF7iiyiB-b=PvKv9hcH22xQ@mail.gmail.com>
 <20230129182441.082f29d0@jic23-huawei> <CAMxBKG0tyLSpaDPGBXsJbqgHSG9rH6owtSJsLw_ekmTA3Kyvdw@mail.gmail.com>
 <CAMxBKG3zL_yvw=dHK+Gqd3EHWzvJmiLHVvKnf6UsYbMgcS6nrg@mail.gmail.com>
 <20230130123113.00002c3f@Huawei.com> <CAMxBKG3xOEj1gEs9pGzKb+rDjTLPqAq1YOp4bEFas4tQMzGZ+Q@mail.gmail.com>
 <20230130173525.0000418d@huawei.com> <CAMxBKG1yKcodDD2kvfwKvpYnPrXmgaOk9rTztRPFzKMCZ5F=tA@mail.gmail.com>
 <20230130194110.256144e7@jic23-huawei> <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
 <20230130203110.60c96f37@jic23-huawei> <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com> <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
In-Reply-To: <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Wed, 1 Feb 2023 17:50:24 +0000
Message-ID: <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I don't have anything that could be called a big machine.
The fastest processor I have access to is a Core m3-8100Y - that's in
a Chromebook with 4GB memory - it can run Linux in a chroot or
officially in Google's VM. I also have an ancient gen 2 core i5-2410M
machine which is slower than the m3 in theory, but that has 6GB of
memory.

Is the kernel build more processor or memory bound?

Thanks,
Darrell

On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
> > Hi,
> >
> > On 2/1/23 11:28, Jonathan Cameron wrote:
> > > On Wed, 1 Feb 2023 01:40:49 +0000
> > > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > >
> > > > Hello, all.
> > > >
> > > > I've finally reached a conclusion on this, after testing all the
> > > > combinations of the patches (with and without reading the acpi
> > > > mounting matrix), window managers (wayland, xorg) and the
> > > > presence or
> > > > not of my custom kernel parms.
> > > >
> > > > What works well is the full set of patches with the custom kernel
> > > > parms and a new hwdb entry for the sensor:
> > > >
> > > > sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> > > >  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> > > >
> > > > The autorotate then works correctly in wayland and xorg, but for
> > > > xorg,
> > > > the settings say the screen is "portrait left" when in actual
> > > > fact it
> > > > is in standard laptop landscape orientation. Wayland does not
> > > > have
> > > > this problem (I guess because wayland's view of the screen is
> > > > straight
> > > > from the kernel).
> > > >
> > > > Without the hwdb entry, the orientation is 90 degrees out without
> > > > using the acpi matrix and 180 degrees out when using it. I could
> > > > have
> > > > gone either way here with appropriate hwdb entries, but my view
> > > > is
> > > > that we *should* be using the matrix.
> > >
> > > Added Hans de Goede as he has probably run into more of this mess
> > > than anyone else.  Hans, any thoughts on if we are doing something
> > > wrong on kernel side?  Or is the matrix just wrong *sigh*
> >
> > I see below that this laptop has a panel which is mounted 90 degrees
> > rotated, that likely explains why the ACPI matrix does not work.
> > So the best thing to do here is to just override it with a hwdb
> > entries.
> >
> > IIRC there are already 1 or 2 other hwdb entries which actually
> > override the ACPI provided matrix because of similar issues.
> >
> > Linux userspace expects the matrix in this case to be set so that
> > it causes e.g. gnome's auto-rotation to put the image upright
> > even with older gnome versions / mate / xfce which don't know about
> > the panel being mounted 90 degrees.
> >
> > So e.g. "monitor-sensor" will report left-side-up or right-side-up
> > while the device is actually in normal clamshell mode with the
> > display up-right.
> >
> > This reporting of left-side-up or right-side-up is actually "correct"
> > looking from the native LCD panel orientation and as mentioned is
> > done for backward compatibility. This is documented here:
> >
> > https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb#L54
> >
> > The way we are handling this is likely incompatible with how Windows
> > handles this special case of 90=C2=B0 rotated screen + ROTM. Or the
> > matrix in the ACPI tables could be just wrong...
> >
> > > I think 'ROTM' is defined by MS.
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/se=
nsors-acpi-entries
> >
> > Right and as such it would be good if we can still add support to
> > it to the sensor driver in question. Because the ROTM info usually
> > is correct and avoids the need for adding more and more hwdb entries.
> >
> > Note there already is existing support in some other sensor drivers.
> >
> > So we probably need to factor out some helper code for this and share
> > that between sensor drivers.
> >
> >
> > > > The only thing that concerns me is the need for custom kernel
> > > > parms.
> > > > It would be better if there was a way to avoid this, so that the
> > > > user
> > > > didn't have to mess around with their grub config. Though having
> > > > said
> > > > that, the sensors fix as we have it doesn't make things worse -
> > > > under
> > > > currently released kernels the screen always starts up sideways
> > > > unless
> > > > custom parms are added in grub.
> >
> > We actually have a quirk mechanism in the kernel for specifying
> > the need for: video=3DDSI-1:panel_orientation=3Dright_side_up  and this
> > will also automatically fix the fbcon orientation, see:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >
> > If you submit a patch for this upstream please Cc me.
>
> And if after that change, and copy/pasting the orientation from the
> DSDT into hwdb the sensor and screen move in the expected ways, then
> maybe stealing the BMC150 driver's
> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
>
> Once exported through "mount_matrix", iio-sensor-proxy should see it
> and read it without the need for a hwdb entry.
>
> Cheers
