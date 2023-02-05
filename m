Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD068B0D8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBEQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:06:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228451C7C5;
        Sun,  5 Feb 2023 08:06:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so13115269pjq.0;
        Sun, 05 Feb 2023 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysWomD5z8y/vzRKrmleFRkYaV0eBQ5zUmTeYiD3u0WM=;
        b=pTv4bAMMys0wsTFrjSiJPbtiX9SYuGCklT6LYLvLveQsGhpsOmlSZB5KnVGAd8cMhT
         zx5KrJb+d3tDW8dJEgqO9lNqQIf+97yassE451165xkkxzYe+9f6FrMzbcJZtkYTvhx/
         5eCRhFxBMYFvaTAEsFTnQm0C4bM8vP1tkmno+raA54B2oG1fWpM8SP6mbRb7A8vb9POs
         epTYnMmF40l4BN1/mnO0mRRV+j3fpFUfcWY/kfnU6BzMLzp41RFqpEQLYjbjGVJpidtt
         2B+QcrORpH9uKIocMkYuQOZj890NWbknxRRtTg8crFmsHab2IndbZjpAQKloewXUaCfV
         UNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysWomD5z8y/vzRKrmleFRkYaV0eBQ5zUmTeYiD3u0WM=;
        b=q3ixkZlDEIxESHm/DN9bl7p7FqkpNBjr54HhdKF9MsbrZtPyrS6tdLtZH/tY5WhJIR
         K4IuKx8C8ZgXPDjitraQC41A2Kvw6Qfv2oj50xL1RlRmcrjeXd2B2YKQtbFRVcxNuvkY
         3h1UwrIKvxB6GGnXmUix+kBTwVIDMxXpBCFsS8Goij9mlUunCrYFt6IQ6AD4F3FPMaEK
         vLuOlrdAxk/sYpenEqpdO9rXJRHSkM5/JDHkko01n5IUcASclsTlpxkEy/f+Y6lLXlm8
         ytX4B5RC1gI6AVQQtGwpnz/sLuj198KuMqR1CWHznX/YqdDv2qf4VIyWTtIDT0jBwEZm
         SmTg==
X-Gm-Message-State: AO0yUKU3zZFi8upQbG8B0w1nsj+3OcFmnIU6a+AwbiIL6kzXj/8nneeR
        GKuq3id68TPFpsmhAbhNb8kzOmlJVyo08WeuJlQ=
X-Google-Smtp-Source: AK7set94UE/kbCTQ6px2u8/VOAOyXBu1BwgKxC5ml9Xjh1SWZsVVzBjf3ZGAGrAkmSg1pZVNxydImdY2+dF/sxwLym0=
X-Received: by 2002:a17:90a:4b8e:b0:230:7bea:e795 with SMTP id
 i14-20020a17090a4b8e00b002307beae795mr1434258pjh.90.1675613182242; Sun, 05
 Feb 2023 08:06:22 -0800 (PST)
MIME-Version: 1.0
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230130194110.256144e7@jic23-huawei> <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
 <20230130203110.60c96f37@jic23-huawei> <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com> <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
 <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
 <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com> <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
 <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
 <f256b437-7495-1115-7eea-619b6e241e02@redhat.com> <CAMxBKG1AAaN7zuwS-ukTEYRm2hC=AcejWbWJSmucHcXS+=-Jfg@mail.gmail.com>
 <9bd76c94-0705-38e5-baf5-32be31652156@redhat.com> <20230205143621.47f3de9a@jic23-huawei>
In-Reply-To: <20230205143621.47f3de9a@jic23-huawei>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Sun, 5 Feb 2023 16:06:10 +0000
Message-ID: <CAMxBKG3-f5+j+=5mXQccBkWfa3cwUTY=mSb8n88A1e0rXk8cnQ@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

So does this mean that the least worst (only?) option is to get my
hwdb mount matrix entry added to systemd? I can raise a bug as
suggested in hwdb.d/60-sensor.hwdb if so.

Darrell

On Sun, 5 Feb 2023 at 14:22, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 5 Feb 2023 09:50:51 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
>
> > Hi,
> >
> > On 2/4/23 23:15, Darrell Kavanagh wrote:
> > > Yes, I understand that.
> > >
> > > What I mean is that the matrix read from the DSDT by Jonathan's
> > > amended driver is
> > >
> > >  0 -1  0
> > >  1  0  0
> > >  0  0  1
> > >
> > > and the (correct) matrix created with my new hwdb entry is
> > >
> > >  0  1  0
> > > -1  0  0
> > >  0  0  1
>
> May be concidence, but I think that's the inverse of the one we are readi=
ng
> from ROTM - so represents the transform in the other direction.
>
> The way ROTM is defined is that first row represents the direction of
> the x axis in device coordinates - so it's the transform from sensor
> to device space.
>
> I wonder if the hwdb matrix is defined from world space to sensor?  Seems
> unlikely.
>
> The IIO ABI docs describe mount matrix as being what you apply to data to
> tranform into device space (oh for a diagram in the docs).  Anyhow my rea=
ding
> is that matches with ROTM definition but maybe I'm reading that wrong...
>
> For extra annoyance, the ROTM matrix on this device isn't a rotation matr=
ix.
> It's flipping the handedness of the sensor.  Determinant isn't -1 which i=
t
> should be.  I guess the sensor itself might have an axis backwards from
> windows convention though *sigh*  I think windows uses left handed conven=
tion
> and looks like sensor is using right handed (which I think is what Androi=
d and
> similar use).
>
> > >
> > > which is the algebraic transposition (ie reflection in the diagonal)
> > > of the DSDT one.
> > >
> > > In other words, though the DST matrix is wrong, it is wrong in a
> > > specific way - the rows should be the columns, and vv. I was just
> > > wondering if this was a DSDT bug that might have been seen elsewhere
> > > before.
> >
> > No this does not ring a bell, but the x and y axis being swapped
> > does seem related to the LCD panel being 90=C2=B0 rotated.
> >
> > > BTW, there is another matrix in the DSTD, but I can't find the
> > > associated HID (10EC5280) anywhere (Linux sysfs or Windows Powershell
> > > system data extract). It's not a correct matrix, though - could it be
> > > just a bit of redundant code in the DST?
> >
> > Yes that is likely there often is a bunch of dead stuff DSDT leftover
> > from other device models.
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> >
> >
> > >
> > > Darrell
> > >
> > > On Sat, 4 Feb 2023 at 21:31, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> > >>
> > >> Hi,
> > >>
> > >> On 2/4/23 18:09, Darrell Kavanagh wrote:
> > >>> I've just noticed that the working mount matrix that I added to my
> > >>> hwdb is the matrix retrieved from the ACPI ROTM call in the amended
> > >>> driver, transposed.
> > >>
> > >> An other word for the mount matrix would be a rotation matrix,
> > >> since it defines how the physical sensor is mounted on the PCB
> > >> in a rotated fashion compared to its standard orientation.
> > >>
> > >> The x, y, z axis relationship underling of course does
> > >> not change by the rotation, so yes all mount matrices
> > >> are a transposition of the standard:
> > >>
> > >> 1, 0, 0 : 0, 1, 0 : 0, 0, 1
> > >>
> > >> matrix, that is expected. Where that to not be the case
> > >> then there would be a bug in the accelerometer driver itself
> > >> where the driver itself is swapping or inverting axis.
> > >>
> > >> Regards,
> > >>
> > >> Hans
> > >>
> > >>
> > >>
> > >>
> > >>> On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
> > >>> <darrell.kavanagh@gmail.com> wrote:
> > >>>>
> > >>>> Finally got a 6.2.0-rc6 kernel built and installed, with the follo=
wing
> > >>>> patch, and everything is working as expected.
> > >>>>
> > >>>> Moving on now to look at Bastien's suggestion.
> > >>>>
> > >>>> Thanks,
> > >>>> Darrell
> > >>>>
> > >>>> diff --git a/kernel/drm_panel_orientation_quirks.c
> > >>>> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirk=
s.c
> > >>>> index 3659f04..590bb7b 100644
> > >>>> --- a/kernel/drm_panel_orientation_quirks.c
> > >>>> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_q=
uirks.c
> > >>>> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation=
_data[] =3D {
> > >>>>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ide=
apad
> > >>>> D330-10IGM"),
> > >>>>                 },
> > >>>>                 .driver_data =3D (void *)&lcd1200x1920_rightside_u=
p,
> > >>>> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> > >>>> +               .matches =3D {
> > >>>> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > >>>> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Du=
et 3 10IGL5"),
> > >>>> +               },
> > >>>> +               .driver_data =3D (void *)&lcd1200x1920_rightside_u=
p,
> > >>>>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
> > >>>>                 .matches =3D {
> > >>>>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > >>>>
> > >>>> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> w=
rote:
> > >>>>>
> > >>>>> Hi,
> > >>>>>
> > >>>>> On 2/1/23 18:50, Darrell Kavanagh wrote:
> > >>>>>> Thank you. I don't have anything that could be called a big mach=
ine.
> > >>>>>> The fastest processor I have access to is a Core m3-8100Y - that=
's in
> > >>>>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
> > >>>>>> officially in Google's VM. I also have an ancient gen 2 core i5-=
2410M
> > >>>>>> machine which is slower than the m3 in theory, but that has 6GB =
of
> > >>>>>> memory.
> > >>>>>>
> > >>>>>> Is the kernel build more processor or memory bound?
> > >>>>>
> > >>>>> It is mostly processor bound, esp. wtih something like make -j4,
> > >>>>> make -j16 will start taking some RAM, but with make -j4 I expect =
you
> > >>>>> to be fully CPU bound.
> > >>>>>
> > >>>>> Regards,
> > >>>>>
> > >>>>> Hans
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> =
wrote:
> > >>>>>>>
> > >>>>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
> > >>>>>>>> Hi,
> > >>>>>>>>
> > >>>>>>>> On 2/1/23 11:28, Jonathan Cameron wrote:
> > >>>>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
> > >>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > >>>>>>>>>
> > >>>>>>>>>> Hello, all.
> > >>>>>>>>>>
> > >>>>>>>>>> I've finally reached a conclusion on this, after testing all=
 the
> > >>>>>>>>>> combinations of the patches (with and without reading the ac=
pi
> > >>>>>>>>>> mounting matrix), window managers (wayland, xorg) and the
> > >>>>>>>>>> presence or
> > >>>>>>>>>> not of my custom kernel parms.
> > >>>>>>>>>>
> > >>>>>>>>>> What works well is the full set of patches with the custom k=
ernel
> > >>>>>>>>>> parms and a new hwdb entry for the sensor:
> > >>>>>>>>>>
> > >>>>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> > >>>>>>>>>>  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> > >>>>>>>>>>
> > >>>>>>>>>> The autorotate then works correctly in wayland and xorg, but=
 for
> > >>>>>>>>>> xorg,
> > >>>>>>>>>> the settings say the screen is "portrait left" when in actua=
l
> > >>>>>>>>>> fact it
> > >>>>>>>>>> is in standard laptop landscape orientation. Wayland does no=
t
> > >>>>>>>>>> have
> > >>>>>>>>>> this problem (I guess because wayland's view of the screen i=
s
> > >>>>>>>>>> straight
> > >>>>>>>>>> from the kernel).
> > >>>>>>>>>>
> > >>>>>>>>>> Without the hwdb entry, the orientation is 90 degrees out wi=
thout
> > >>>>>>>>>> using the acpi matrix and 180 degrees out when using it. I c=
ould
> > >>>>>>>>>> have
> > >>>>>>>>>> gone either way here with appropriate hwdb entries, but my v=
iew
> > >>>>>>>>>> is
> > >>>>>>>>>> that we *should* be using the matrix.
> > >>>>>>>>>
> > >>>>>>>>> Added Hans de Goede as he has probably run into more of this =
mess
> > >>>>>>>>> than anyone else.  Hans, any thoughts on if we are doing some=
thing
> > >>>>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
> > >>>>>>>>
> > >>>>>>>> I see below that this laptop has a panel which is mounted 90 d=
egrees
> > >>>>>>>> rotated, that likely explains why the ACPI matrix does not wor=
k.
> > >>>>>>>> So the best thing to do here is to just override it with a hwd=
b
> > >>>>>>>> entries.
> > >>>>>>>>
> > >>>>>>>> IIRC there are already 1 or 2 other hwdb entries which actuall=
y
> > >>>>>>>> override the ACPI provided matrix because of similar issues.
> > >>>>>>>>
> > >>>>>>>> Linux userspace expects the matrix in this case to be set so t=
hat
> > >>>>>>>> it causes e.g. gnome's auto-rotation to put the image upright
> > >>>>>>>> even with older gnome versions / mate / xfce which don't know =
about
> > >>>>>>>> the panel being mounted 90 degrees.
> > >>>>>>>>
> > >>>>>>>> So e.g. "monitor-sensor" will report left-side-up or right-sid=
e-up
> > >>>>>>>> while the device is actually in normal clamshell mode with the
> > >>>>>>>> display up-right.
> > >>>>>>>>
> > >>>>>>>> This reporting of left-side-up or right-side-up is actually "c=
orrect"
> > >>>>>>>> looking from the native LCD panel orientation and as mentioned=
 is
> > >>>>>>>> done for backward compatibility. This is documented here:
> > >>>>>>>>
> > >>>>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.=
hwdb#L54
> > >>>>>>>>
> > >>>>>>>> The way we are handling this is likely incompatible with how W=
indows
> > >>>>>>>> handles this special case of 90=C2=B0 rotated screen + ROTM. O=
r the
> > >>>>>>>> matrix in the ACPI tables could be just wrong...
> > >>>>>>>>
> > >>>>>>>>> I think 'ROTM' is defined by MS.
> > >>>>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/se=
nsors/sensors-acpi-entries
> > >>>>>>>>
> > >>>>>>>> Right and as such it would be good if we can still add support=
 to
> > >>>>>>>> it to the sensor driver in question. Because the ROTM info usu=
ally
> > >>>>>>>> is correct and avoids the need for adding more and more hwdb e=
ntries.
> > >>>>>>>>
> > >>>>>>>> Note there already is existing support in some other sensor dr=
ivers.
> > >>>>>>>>
> > >>>>>>>> So we probably need to factor out some helper code for this an=
d share
> > >>>>>>>> that between sensor drivers.
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>>> The only thing that concerns me is the need for custom kerne=
l
> > >>>>>>>>>> parms.
> > >>>>>>>>>> It would be better if there was a way to avoid this, so that=
 the
> > >>>>>>>>>> user
> > >>>>>>>>>> didn't have to mess around with their grub config. Though ha=
ving
> > >>>>>>>>>> said
> > >>>>>>>>>> that, the sensors fix as we have it doesn't make things wors=
e -
> > >>>>>>>>>> under
> > >>>>>>>>>> currently released kernels the screen always starts up sidew=
ays
> > >>>>>>>>>> unless
> > >>>>>>>>>> custom parms are added in grub.
> > >>>>>>>>
> > >>>>>>>> We actually have a quirk mechanism in the kernel for specifyin=
g
> > >>>>>>>> the need for: video=3DDSI-1:panel_orientation=3Dright_side_up =
 and this
> > >>>>>>>> will also automatically fix the fbcon orientation, see:
> > >>>>>>>>
> > >>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > >>>>>>>>
> > >>>>>>>> If you submit a patch for this upstream please Cc me.
> > >>>>>>>
> > >>>>>>> And if after that change, and copy/pasting the orientation from=
 the
> > >>>>>>> DSDT into hwdb the sensor and screen move in the expected ways,=
 then
> > >>>>>>> maybe stealing the BMC150 driver's
> > >>>>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
> > >>>>>>>
> > >>>>>>> Once exported through "mount_matrix", iio-sensor-proxy should s=
ee it
> > >>>>>>> and read it without the need for a hwdb entry.
> > >>>>>>>
> > >>>>>>> Cheers
> > >>>>>>
> > >>>>>
> > >>>
> > >>
> > >
> >
>
