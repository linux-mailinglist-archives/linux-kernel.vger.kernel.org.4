Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6268ACD2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBDWP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBDWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:15:54 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D91554E;
        Sat,  4 Feb 2023 14:15:52 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id bd15so6037411pfb.8;
        Sat, 04 Feb 2023 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Oh4b+sp+nHg7iJL2ILpdBdJt2yd6ZGmwaWeEY5o8k=;
        b=A83y7NkmjRCHUM9jC3TK6+QFitiHGgtKTorwpcXPmH5rVKeKuUBG90rq69iyl1PigW
         j+/UHX2i0NjpMz61BCYFjtCRU/C2jBqAs7bHAeGdvJwH4Y2mv2D3DP4VkQrtU4lpYAHX
         OybOqL26v4Y2Y6jSg8MptkYgpvvTeQQGQffnHvYmyvt9XNkvvI49VH7TBcl834lTqTdH
         xaYszNK3tse6jBTKdrUkAnwNxQi761gXGPdXOPUwqoyTOx+kdOLrBpoxl/kutKkEq+1N
         m2ec7fTFBPMtpTI5JqAdDso0ZCqto+sg7u2hNzJQtJXS91AG5FKFncSjRBs3nkfHI+lf
         jX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Oh4b+sp+nHg7iJL2ILpdBdJt2yd6ZGmwaWeEY5o8k=;
        b=YXXOLIWr2lVfwh5DjNW61CQLHgrFKL/tWknfOBWez6Vb326eA0r7aD8EEWzU1iojwa
         CS81BeO9U2Qh9jmmAEniUHeyalTOLhIIuuXxG1xk4k7auJ4uKMMxQ7Um2vCQClreM3w+
         OMNvi7Odv/vKF2ybPF9fBwSWxG2/5HRaDRRFSr6U/stADcKl6Kk0GpkG2aOHB2+FXb7v
         FEjFx9edOdjtPUDNbqpzmT/9C+dSpMGzE9H4C+ZtWnXc40OjhK+QHUNkySSoiiSCwz9h
         n3dDPi1SrN7ikmqnpPUT4tvoRN0l+HO5R6OhOcYpvZ3NilbaYylm15TRCtFREerZx5Nn
         uh/A==
X-Gm-Message-State: AO0yUKXQEuVHlsPHSrCjStIkaDU0VywYYe6IZcd0ibDkgauT3gldPij+
        FWwZi0eFH9E9t4nUczx2OWKAQF1nbwtk8i7J4QU=
X-Google-Smtp-Source: AK7set+RhSq8gafatBETqJ6kFVYB0s+RVVFRdu0knbqN9RxEZyvK9JxL7n4CIkjepVGto/YafIRaUUATTA5KazItB54=
X-Received: by 2002:a63:e16:0:b0:4f7:4c1e:92c3 with SMTP id
 d22-20020a630e16000000b004f74c1e92c3mr736078pgl.123.1675548952048; Sat, 04
 Feb 2023 14:15:52 -0800 (PST)
MIME-Version: 1.0
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230130123113.00002c3f@Huawei.com> <CAMxBKG3xOEj1gEs9pGzKb+rDjTLPqAq1YOp4bEFas4tQMzGZ+Q@mail.gmail.com>
 <20230130173525.0000418d@huawei.com> <CAMxBKG1yKcodDD2kvfwKvpYnPrXmgaOk9rTztRPFzKMCZ5F=tA@mail.gmail.com>
 <20230130194110.256144e7@jic23-huawei> <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
 <20230130203110.60c96f37@jic23-huawei> <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com> <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
 <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
 <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com> <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
 <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com> <f256b437-7495-1115-7eea-619b6e241e02@redhat.com>
In-Reply-To: <f256b437-7495-1115-7eea-619b6e241e02@redhat.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Sat, 4 Feb 2023 22:15:39 +0000
Message-ID: <CAMxBKG1AAaN7zuwS-ukTEYRm2hC=AcejWbWJSmucHcXS+=-Jfg@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
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

Yes, I understand that.

What I mean is that the matrix read from the DSDT by Jonathan's
amended driver is

 0 -1  0
 1  0  0
 0  0  1

and the (correct) matrix created with my new hwdb entry is

 0  1  0
-1  0  0
 0  0  1

which is the algebraic transposition (ie reflection in the diagonal)
of the DSDT one.

In other words, though the DST matrix is wrong, it is wrong in a
specific way - the rows should be the columns, and vv. I was just
wondering if this was a DSDT bug that might have been seen elsewhere
before.

BTW, there is another matrix in the DSTD, but I can't find the
associated HID (10EC5280) anywhere (Linux sysfs or Windows Powershell
system data extract). It's not a correct matrix, though - could it be
just a bit of redundant code in the DST?

Darrell

On Sat, 4 Feb 2023 at 21:31, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/4/23 18:09, Darrell Kavanagh wrote:
> > I've just noticed that the working mount matrix that I added to my
> > hwdb is the matrix retrieved from the ACPI ROTM call in the amended
> > driver, transposed.
>
> An other word for the mount matrix would be a rotation matrix,
> since it defines how the physical sensor is mounted on the PCB
> in a rotated fashion compared to its standard orientation.
>
> The x, y, z axis relationship underling of course does
> not change by the rotation, so yes all mount matrices
> are a transposition of the standard:
>
> 1, 0, 0 : 0, 1, 0 : 0, 0, 1
>
> matrix, that is expected. Where that to not be the case
> then there would be a bug in the accelerometer driver itself
> where the driver itself is swapping or inverting axis.
>
> Regards,
>
> Hans
>
>
>
>
> > On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
> > <darrell.kavanagh@gmail.com> wrote:
> >>
> >> Finally got a 6.2.0-rc6 kernel built and installed, with the following
> >> patch, and everything is working as expected.
> >>
> >> Moving on now to look at Bastien's suggestion.
> >>
> >> Thanks,
> >> Darrell
> >>
> >> diff --git a/kernel/drm_panel_orientation_quirks.c
> >> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >> index 3659f04..590bb7b 100644
> >> --- a/kernel/drm_panel_orientation_quirks.c
> >> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirk=
s.c
> >> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_dat=
a[] =3D {
> >>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
> >> D330-10IGM"),
> >>                 },
> >>                 .driver_data =3D (void *)&lcd1200x1920_rightside_up,
> >> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> >> +               .matches =3D {
> >> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3=
 10IGL5"),
> >> +               },
> >> +               .driver_data =3D (void *)&lcd1200x1920_rightside_up,
> >>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
> >>                 .matches =3D {
> >>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>
> >> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> wrote=
:
> >>>
> >>> Hi,
> >>>
> >>> On 2/1/23 18:50, Darrell Kavanagh wrote:
> >>>> Thank you. I don't have anything that could be called a big machine.
> >>>> The fastest processor I have access to is a Core m3-8100Y - that's i=
n
> >>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
> >>>> officially in Google's VM. I also have an ancient gen 2 core i5-2410=
M
> >>>> machine which is slower than the m3 in theory, but that has 6GB of
> >>>> memory.
> >>>>
> >>>> Is the kernel build more processor or memory bound?
> >>>
> >>> It is mostly processor bound, esp. wtih something like make -j4,
> >>> make -j16 will start taking some RAM, but with make -j4 I expect you
> >>> to be fully CPU bound.
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wrot=
e:
> >>>>>
> >>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 2/1/23 11:28, Jonathan Cameron wrote:
> >>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
> >>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>
> >>>>>>>> Hello, all.
> >>>>>>>>
> >>>>>>>> I've finally reached a conclusion on this, after testing all the
> >>>>>>>> combinations of the patches (with and without reading the acpi
> >>>>>>>> mounting matrix), window managers (wayland, xorg) and the
> >>>>>>>> presence or
> >>>>>>>> not of my custom kernel parms.
> >>>>>>>>
> >>>>>>>> What works well is the full set of patches with the custom kerne=
l
> >>>>>>>> parms and a new hwdb entry for the sensor:
> >>>>>>>>
> >>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> >>>>>>>>  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> >>>>>>>>
> >>>>>>>> The autorotate then works correctly in wayland and xorg, but for
> >>>>>>>> xorg,
> >>>>>>>> the settings say the screen is "portrait left" when in actual
> >>>>>>>> fact it
> >>>>>>>> is in standard laptop landscape orientation. Wayland does not
> >>>>>>>> have
> >>>>>>>> this problem (I guess because wayland's view of the screen is
> >>>>>>>> straight
> >>>>>>>> from the kernel).
> >>>>>>>>
> >>>>>>>> Without the hwdb entry, the orientation is 90 degrees out withou=
t
> >>>>>>>> using the acpi matrix and 180 degrees out when using it. I could
> >>>>>>>> have
> >>>>>>>> gone either way here with appropriate hwdb entries, but my view
> >>>>>>>> is
> >>>>>>>> that we *should* be using the matrix.
> >>>>>>>
> >>>>>>> Added Hans de Goede as he has probably run into more of this mess
> >>>>>>> than anyone else.  Hans, any thoughts on if we are doing somethin=
g
> >>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
> >>>>>>
> >>>>>> I see below that this laptop has a panel which is mounted 90 degre=
es
> >>>>>> rotated, that likely explains why the ACPI matrix does not work.
> >>>>>> So the best thing to do here is to just override it with a hwdb
> >>>>>> entries.
> >>>>>>
> >>>>>> IIRC there are already 1 or 2 other hwdb entries which actually
> >>>>>> override the ACPI provided matrix because of similar issues.
> >>>>>>
> >>>>>> Linux userspace expects the matrix in this case to be set so that
> >>>>>> it causes e.g. gnome's auto-rotation to put the image upright
> >>>>>> even with older gnome versions / mate / xfce which don't know abou=
t
> >>>>>> the panel being mounted 90 degrees.
> >>>>>>
> >>>>>> So e.g. "monitor-sensor" will report left-side-up or right-side-up
> >>>>>> while the device is actually in normal clamshell mode with the
> >>>>>> display up-right.
> >>>>>>
> >>>>>> This reporting of left-side-up or right-side-up is actually "corre=
ct"
> >>>>>> looking from the native LCD panel orientation and as mentioned is
> >>>>>> done for backward compatibility. This is documented here:
> >>>>>>
> >>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb=
#L54
> >>>>>>
> >>>>>> The way we are handling this is likely incompatible with how Windo=
ws
> >>>>>> handles this special case of 90=C2=B0 rotated screen + ROTM. Or th=
e
> >>>>>> matrix in the ACPI tables could be just wrong...
> >>>>>>
> >>>>>>> I think 'ROTM' is defined by MS.
> >>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/sensor=
s/sensors-acpi-entries
> >>>>>>
> >>>>>> Right and as such it would be good if we can still add support to
> >>>>>> it to the sensor driver in question. Because the ROTM info usually
> >>>>>> is correct and avoids the need for adding more and more hwdb entri=
es.
> >>>>>>
> >>>>>> Note there already is existing support in some other sensor driver=
s.
> >>>>>>
> >>>>>> So we probably need to factor out some helper code for this and sh=
are
> >>>>>> that between sensor drivers.
> >>>>>>
> >>>>>>
> >>>>>>>> The only thing that concerns me is the need for custom kernel
> >>>>>>>> parms.
> >>>>>>>> It would be better if there was a way to avoid this, so that the
> >>>>>>>> user
> >>>>>>>> didn't have to mess around with their grub config. Though having
> >>>>>>>> said
> >>>>>>>> that, the sensors fix as we have it doesn't make things worse -
> >>>>>>>> under
> >>>>>>>> currently released kernels the screen always starts up sideways
> >>>>>>>> unless
> >>>>>>>> custom parms are added in grub.
> >>>>>>
> >>>>>> We actually have a quirk mechanism in the kernel for specifying
> >>>>>> the need for: video=3DDSI-1:panel_orientation=3Dright_side_up  and=
 this
> >>>>>> will also automatically fix the fbcon orientation, see:
> >>>>>>
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >>>>>>
> >>>>>> If you submit a patch for this upstream please Cc me.
> >>>>>
> >>>>> And if after that change, and copy/pasting the orientation from the
> >>>>> DSDT into hwdb the sensor and screen move in the expected ways, the=
n
> >>>>> maybe stealing the BMC150 driver's
> >>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
> >>>>>
> >>>>> Once exported through "mount_matrix", iio-sensor-proxy should see i=
t
> >>>>> and read it without the need for a hwdb entry.
> >>>>>
> >>>>> Cheers
> >>>>
> >>>
> >
>
