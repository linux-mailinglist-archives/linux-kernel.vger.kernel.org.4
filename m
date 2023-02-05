Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93C68B046
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBEOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:22:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBCF8688;
        Sun,  5 Feb 2023 06:22:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58D9EB80B22;
        Sun,  5 Feb 2023 14:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3EC433EF;
        Sun,  5 Feb 2023 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675606940;
        bh=VrD60Z21fGYl4IdFa1Noga6tFkVr1Rd2Ast8ua1iiTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAvsm2iSgTjJi5w+NLZ1PYktK6QLNcp5nnPAURvmFXY8FY/ckHxhKPVGNLqKva17i
         CY9yFd0WHIVEGejqWm4I3refguqpI1OlAv6mH59v6N4RBBaIkFCeH+bGO/8+xTrSey
         GrVeWRVz6u3IUKV8gqpLcpBbrH5A05quSq18PB62b0u6Hm7YvzPsEXQw13cRhXVfO3
         QAmtMuLVmofWknwvMkKz7B6XBSm741RsfMOHtLmJRsqaUKPEj/mNH3S2JM8AWGE7Kx
         a33tjn3ihi2HEB3pHeE76uSVsDvWdDkfGQ427FYMl9chcuiS6h0LcgkXNvsDA2Sgx3
         IFXsdSPi8RnLQ==
Date:   Sun, 5 Feb 2023 14:36:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darrell Kavanagh <darrell.kavanagh@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
Message-ID: <20230205143621.47f3de9a@jic23-huawei>
In-Reply-To: <9bd76c94-0705-38e5-baf5-32be31652156@redhat.com>
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
        <20230130194110.256144e7@jic23-huawei>
        <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
        <20230130203110.60c96f37@jic23-huawei>
        <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
        <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
        <20230201102824.00002044@Huawei.com>
        <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
        <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
        <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
        <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com>
        <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
        <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
        <f256b437-7495-1115-7eea-619b6e241e02@redhat.com>
        <CAMxBKG1AAaN7zuwS-ukTEYRm2hC=AcejWbWJSmucHcXS+=-Jfg@mail.gmail.com>
        <9bd76c94-0705-38e5-baf5-32be31652156@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2023 09:50:51 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>=20
> On 2/4/23 23:15, Darrell Kavanagh wrote:
> > Yes, I understand that.
> >=20
> > What I mean is that the matrix read from the DSDT by Jonathan's
> > amended driver is
> >=20
> >  0 -1  0
> >  1  0  0
> >  0  0  1
> >=20
> > and the (correct) matrix created with my new hwdb entry is
> >=20
> >  0  1  0
> > -1  0  0
> >  0  0  1

May be concidence, but I think that's the inverse of the one we are reading
from ROTM - so represents the transform in the other direction.

The way ROTM is defined is that first row represents the direction of
the x axis in device coordinates - so it's the transform from sensor
to device space.

I wonder if the hwdb matrix is defined from world space to sensor?  Seems
unlikely.=20

The IIO ABI docs describe mount matrix as being what you apply to data to
tranform into device space (oh for a diagram in the docs).  Anyhow my readi=
ng
is that matches with ROTM definition but maybe I'm reading that wrong...

For extra annoyance, the ROTM matrix on this device isn't a rotation matrix.
It's flipping the handedness of the sensor.  Determinant isn't -1 which it
should be.  I guess the sensor itself might have an axis backwards from
windows convention though *sigh*  I think windows uses left handed conventi=
on
and looks like sensor is using right handed (which I think is what Android =
and
similar use).

> >=20
> > which is the algebraic transposition (ie reflection in the diagonal)
> > of the DSDT one.
> >=20
> > In other words, though the DST matrix is wrong, it is wrong in a
> > specific way - the rows should be the columns, and vv. I was just
> > wondering if this was a DSDT bug that might have been seen elsewhere
> > before. =20
>=20
> No this does not ring a bell, but the x and y axis being swapped
> does seem related to the LCD panel being 90=C2=B0 rotated.
>=20
> > BTW, there is another matrix in the DSTD, but I can't find the
> > associated HID (10EC5280) anywhere (Linux sysfs or Windows Powershell
> > system data extract). It's not a correct matrix, though - could it be
> > just a bit of redundant code in the DST? =20
>=20
> Yes that is likely there often is a bunch of dead stuff DSDT leftover
> from other device models.
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
> >=20
> > Darrell
> >=20
> > On Sat, 4 Feb 2023 at 21:31, Hans de Goede <hdegoede@redhat.com> wrote:=
 =20
> >>
> >> Hi,
> >>
> >> On 2/4/23 18:09, Darrell Kavanagh wrote: =20
> >>> I've just noticed that the working mount matrix that I added to my
> >>> hwdb is the matrix retrieved from the ACPI ROTM call in the amended
> >>> driver, transposed. =20
> >>
> >> An other word for the mount matrix would be a rotation matrix,
> >> since it defines how the physical sensor is mounted on the PCB
> >> in a rotated fashion compared to its standard orientation.
> >>
> >> The x, y, z axis relationship underling of course does
> >> not change by the rotation, so yes all mount matrices
> >> are a transposition of the standard:
> >>
> >> 1, 0, 0 : 0, 1, 0 : 0, 0, 1
> >>
> >> matrix, that is expected. Where that to not be the case
> >> then there would be a bug in the accelerometer driver itself
> >> where the driver itself is swapping or inverting axis.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >> =20
> >>> On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
> >>> <darrell.kavanagh@gmail.com> wrote: =20
> >>>>
> >>>> Finally got a 6.2.0-rc6 kernel built and installed, with the followi=
ng
> >>>> patch, and everything is working as expected.
> >>>>
> >>>> Moving on now to look at Bastien's suggestion.
> >>>>
> >>>> Thanks,
> >>>> Darrell
> >>>>
> >>>> diff --git a/kernel/drm_panel_orientation_quirks.c
> >>>> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >>>> index 3659f04..590bb7b 100644
> >>>> --- a/kernel/drm_panel_orientation_quirks.c
> >>>> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_qui=
rks.c
> >>>> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_d=
ata[] =3D {
> >>>>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideap=
ad
> >>>> D330-10IGM"),
> >>>>                 },
> >>>>                 .driver_data =3D (void *)&lcd1200x1920_rightside_up,
> >>>> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> >>>> +               .matches =3D {
> >>>> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>>> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet=
 3 10IGL5"),
> >>>> +               },
> >>>> +               .driver_data =3D (void *)&lcd1200x1920_rightside_up,
> >>>>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
> >>>>                 .matches =3D {
> >>>>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>>>
> >>>> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> wro=
te: =20
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 2/1/23 18:50, Darrell Kavanagh wrote: =20
> >>>>>> Thank you. I don't have anything that could be called a big machin=
e.
> >>>>>> The fastest processor I have access to is a Core m3-8100Y - that's=
 in
> >>>>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
> >>>>>> officially in Google's VM. I also have an ancient gen 2 core i5-24=
10M
> >>>>>> machine which is slower than the m3 in theory, but that has 6GB of
> >>>>>> memory.
> >>>>>>
> >>>>>> Is the kernel build more processor or memory bound? =20
> >>>>>
> >>>>> It is mostly processor bound, esp. wtih something like make -j4,
> >>>>> make -j16 will start taking some RAM, but with make -j4 I expect you
> >>>>> to be fully CPU bound.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Hans
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> =20
> >>>>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wr=
ote: =20
> >>>>>>>
> >>>>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote: =20
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On 2/1/23 11:28, Jonathan Cameron wrote: =20
> >>>>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
> >>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>>> =20
> >>>>>>>>>> Hello, all.
> >>>>>>>>>>
> >>>>>>>>>> I've finally reached a conclusion on this, after testing all t=
he
> >>>>>>>>>> combinations of the patches (with and without reading the acpi
> >>>>>>>>>> mounting matrix), window managers (wayland, xorg) and the
> >>>>>>>>>> presence or
> >>>>>>>>>> not of my custom kernel parms.
> >>>>>>>>>>
> >>>>>>>>>> What works well is the full set of patches with the custom ker=
nel
> >>>>>>>>>> parms and a new hwdb entry for the sensor:
> >>>>>>>>>>
> >>>>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> >>>>>>>>>>  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> >>>>>>>>>>
> >>>>>>>>>> The autorotate then works correctly in wayland and xorg, but f=
or
> >>>>>>>>>> xorg,
> >>>>>>>>>> the settings say the screen is "portrait left" when in actual
> >>>>>>>>>> fact it
> >>>>>>>>>> is in standard laptop landscape orientation. Wayland does not
> >>>>>>>>>> have
> >>>>>>>>>> this problem (I guess because wayland's view of the screen is
> >>>>>>>>>> straight
> >>>>>>>>>> from the kernel).
> >>>>>>>>>>
> >>>>>>>>>> Without the hwdb entry, the orientation is 90 degrees out with=
out
> >>>>>>>>>> using the acpi matrix and 180 degrees out when using it. I cou=
ld
> >>>>>>>>>> have
> >>>>>>>>>> gone either way here with appropriate hwdb entries, but my view
> >>>>>>>>>> is
> >>>>>>>>>> that we *should* be using the matrix. =20
> >>>>>>>>>
> >>>>>>>>> Added Hans de Goede as he has probably run into more of this me=
ss
> >>>>>>>>> than anyone else.  Hans, any thoughts on if we are doing someth=
ing
> >>>>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh* =20
> >>>>>>>>
> >>>>>>>> I see below that this laptop has a panel which is mounted 90 deg=
rees
> >>>>>>>> rotated, that likely explains why the ACPI matrix does not work.
> >>>>>>>> So the best thing to do here is to just override it with a hwdb
> >>>>>>>> entries.
> >>>>>>>>
> >>>>>>>> IIRC there are already 1 or 2 other hwdb entries which actually
> >>>>>>>> override the ACPI provided matrix because of similar issues.
> >>>>>>>>
> >>>>>>>> Linux userspace expects the matrix in this case to be set so that
> >>>>>>>> it causes e.g. gnome's auto-rotation to put the image upright
> >>>>>>>> even with older gnome versions / mate / xfce which don't know ab=
out
> >>>>>>>> the panel being mounted 90 degrees.
> >>>>>>>>
> >>>>>>>> So e.g. "monitor-sensor" will report left-side-up or right-side-=
up
> >>>>>>>> while the device is actually in normal clamshell mode with the
> >>>>>>>> display up-right.
> >>>>>>>>
> >>>>>>>> This reporting of left-side-up or right-side-up is actually "cor=
rect"
> >>>>>>>> looking from the native LCD panel orientation and as mentioned is
> >>>>>>>> done for backward compatibility. This is documented here:
> >>>>>>>>
> >>>>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hw=
db#L54
> >>>>>>>>
> >>>>>>>> The way we are handling this is likely incompatible with how Win=
dows
> >>>>>>>> handles this special case of 90=C2=B0 rotated screen + ROTM. Or =
the
> >>>>>>>> matrix in the ACPI tables could be just wrong...
> >>>>>>>> =20
> >>>>>>>>> I think 'ROTM' is defined by MS.
> >>>>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/sens=
ors/sensors-acpi-entries =20
> >>>>>>>>
> >>>>>>>> Right and as such it would be good if we can still add support to
> >>>>>>>> it to the sensor driver in question. Because the ROTM info usual=
ly
> >>>>>>>> is correct and avoids the need for adding more and more hwdb ent=
ries.
> >>>>>>>>
> >>>>>>>> Note there already is existing support in some other sensor driv=
ers.
> >>>>>>>>
> >>>>>>>> So we probably need to factor out some helper code for this and =
share
> >>>>>>>> that between sensor drivers.
> >>>>>>>>
> >>>>>>>> =20
> >>>>>>>>>> The only thing that concerns me is the need for custom kernel
> >>>>>>>>>> parms.
> >>>>>>>>>> It would be better if there was a way to avoid this, so that t=
he
> >>>>>>>>>> user
> >>>>>>>>>> didn't have to mess around with their grub config. Though havi=
ng
> >>>>>>>>>> said
> >>>>>>>>>> that, the sensors fix as we have it doesn't make things worse -
> >>>>>>>>>> under
> >>>>>>>>>> currently released kernels the screen always starts up sideways
> >>>>>>>>>> unless
> >>>>>>>>>> custom parms are added in grub. =20
> >>>>>>>>
> >>>>>>>> We actually have a quirk mechanism in the kernel for specifying
> >>>>>>>> the need for: video=3DDSI-1:panel_orientation=3Dright_side_up  a=
nd this
> >>>>>>>> will also automatically fix the fbcon orientation, see:
> >>>>>>>>
> >>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >>>>>>>>
> >>>>>>>> If you submit a patch for this upstream please Cc me. =20
> >>>>>>>
> >>>>>>> And if after that change, and copy/pasting the orientation from t=
he
> >>>>>>> DSDT into hwdb the sensor and screen move in the expected ways, t=
hen
> >>>>>>> maybe stealing the BMC150 driver's
> >>>>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
> >>>>>>>
> >>>>>>> Once exported through "mount_matrix", iio-sensor-proxy should see=
 it
> >>>>>>> and read it without the need for a hwdb entry.
> >>>>>>>
> >>>>>>> Cheers =20
> >>>>>> =20
> >>>>> =20
> >>> =20
> >> =20
> >  =20
>=20

