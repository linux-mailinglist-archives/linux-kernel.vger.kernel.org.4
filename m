Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2968B216
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBEWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:05:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36033199E8;
        Sun,  5 Feb 2023 14:05:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n2so7138834pfo.3;
        Sun, 05 Feb 2023 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HfuYLk3JpOkX3MazufR+JMHxpDrYyTDAbT4XXyBFlk=;
        b=SaBo0/yodgBlN/LYxfqGySes6TB8in3tY/qdw9Sf5Gb9ENc1FHrZhJR7dPml+BYVf2
         4OFVe8G4DqJOGrq91OcR9nYi7fft5aRikh/TzujPjqjKn43VlUNQxjTRBQpVKTzkyW+l
         yPHpSjdS7l2LQziBrOZt3oCYNAjWxghzN+oz0XzzPyyUAhLuWiCezpa+5fLXPLdXwvMK
         13DVnso1KNw1uhyfyJ45uoDxNm2zadFFkIAY1G+eNbD4adAyqKn/DjdBQqeMo1HzlCtO
         L+iYMaZOsDGFsanislYF7JF5LfhCr8mHjAoDcRF9bBoJfcDgmW/fB8rC71XDQ5BEUMGN
         thoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HfuYLk3JpOkX3MazufR+JMHxpDrYyTDAbT4XXyBFlk=;
        b=bYwevBXI45zL/8xXBWkGT1IFWOJXB6D3x+davNVkESh+PdQOGPWv1gga9fJAsfBiKH
         4FUJtOwng11l8bIsuH7qkeJ6zdfPwlRpW/3HRQiru1+nHR1A9LPdplCv+yk8aIupeznv
         q8Q8HFMVHNDMykl3LlhXXcJ6iTJpNFL2wPIiRyk6ZZK9WkAWyQ/YogfKfLFAv1Z0aWHM
         P8+VGNZ9ynMAE1YM0nJ6n3W/EVqTu8OHhIwg+57C31jiuMOWXaRTnlbrfgbRP9evcT2b
         vF0N+eWST2emi3fHkP1udOTZ5sejkQmbzVyXqPogMsMdwnjxkAGKmBdZifnBqX9pEqHE
         o38w==
X-Gm-Message-State: AO0yUKVZJdbNyuAF4CeaFo9fJcPN/sR69ZP9t3T12RzAXTA/kxDElKV5
        T/Mdk/V13ecAlvs4YY1pkE8q48jhsuZM9o+wyOY=
X-Google-Smtp-Source: AK7set/qIM4i932qtFHTF8rmJLTr991gz2dI4QC/ArSiK1gjXniHa5FkxztF661Em7wFVW3stSUfOJ+4J4THUUIIM/I=
X-Received: by 2002:a05:6a00:1797:b0:593:b655:d058 with SMTP id
 s23-20020a056a00179700b00593b655d058mr3920933pfg.3.1675634750396; Sun, 05 Feb
 2023 14:05:50 -0800 (PST)
MIME-Version: 1.0
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230130203110.60c96f37@jic23-huawei> <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com> <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
 <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
 <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com> <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
 <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
 <f256b437-7495-1115-7eea-619b6e241e02@redhat.com> <CAMxBKG1AAaN7zuwS-ukTEYRm2hC=AcejWbWJSmucHcXS+=-Jfg@mail.gmail.com>
 <9bd76c94-0705-38e5-baf5-32be31652156@redhat.com> <20230205143621.47f3de9a@jic23-huawei>
 <CAMxBKG3-f5+j+=5mXQccBkWfa3cwUTY=mSb8n88A1e0rXk8cnQ@mail.gmail.com> <75729823-e50e-7a44-7271-a1b5bce489ec@redhat.com>
In-Reply-To: <75729823-e50e-7a44-7271-a1b5bce489ec@redhat.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Sun, 5 Feb 2023 22:05:38 +0000
Message-ID: <CAMxBKG1dexffMOY_qqGHnU2_A6rwMiyNc_n8TOXdry29NmCF1w@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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

OK, pull request has been submitted.
https://github.com/systemd/systemd/pull/26317

On Sun, 5 Feb 2023 at 18:06, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/5/23 17:06, Darrell Kavanagh wrote:
> > So does this mean that the least worst (only?) option is to get my
> > hwdb mount matrix entry added to systemd? I can raise a bug as
> > suggested in hwdb.d/60-sensor.hwdb if so.
>
> Yes you should add a hwdb entry for this, note just submitting
> a pull-req with the fix is better then filing an issue for this.
>
> Regards,
>
> Hans
>
>
>
> > On Sun, 5 Feb 2023 at 14:22, Jonathan Cameron <jic23@kernel.org> wrote:
> >>
> >> On Sun, 5 Feb 2023 09:50:51 +0100
> >> Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >>> Hi,
> >>>
> >>> On 2/4/23 23:15, Darrell Kavanagh wrote:
> >>>> Yes, I understand that.
> >>>>
> >>>> What I mean is that the matrix read from the DSDT by Jonathan's
> >>>> amended driver is
> >>>>
> >>>>  0 -1  0
> >>>>  1  0  0
> >>>>  0  0  1
> >>>>
> >>>> and the (correct) matrix created with my new hwdb entry is
> >>>>
> >>>>  0  1  0
> >>>> -1  0  0
> >>>>  0  0  1
> >>
> >> May be concidence, but I think that's the inverse of the one we are re=
ading
> >> from ROTM - so represents the transform in the other direction.
> >>
> >> The way ROTM is defined is that first row represents the direction of
> >> the x axis in device coordinates - so it's the transform from sensor
> >> to device space.
> >>
> >> I wonder if the hwdb matrix is defined from world space to sensor?  Se=
ems
> >> unlikely.
> >>
> >> The IIO ABI docs describe mount matrix as being what you apply to data=
 to
> >> tranform into device space (oh for a diagram in the docs).  Anyhow my =
reading
> >> is that matches with ROTM definition but maybe I'm reading that wrong.=
..
> >>
> >> For extra annoyance, the ROTM matrix on this device isn't a rotation m=
atrix.
> >> It's flipping the handedness of the sensor.  Determinant isn't -1 whic=
h it
> >> should be.  I guess the sensor itself might have an axis backwards fro=
m
> >> windows convention though *sigh*  I think windows uses left handed con=
vention
> >> and looks like sensor is using right handed (which I think is what And=
roid and
> >> similar use).
> >>
> >>>>
> >>>> which is the algebraic transposition (ie reflection in the diagonal)
> >>>> of the DSDT one.
> >>>>
> >>>> In other words, though the DST matrix is wrong, it is wrong in a
> >>>> specific way - the rows should be the columns, and vv. I was just
> >>>> wondering if this was a DSDT bug that might have been seen elsewhere
> >>>> before.
> >>>
> >>> No this does not ring a bell, but the x and y axis being swapped
> >>> does seem related to the LCD panel being 90=C2=B0 rotated.
> >>>
> >>>> BTW, there is another matrix in the DSTD, but I can't find the
> >>>> associated HID (10EC5280) anywhere (Linux sysfs or Windows Powershel=
l
> >>>> system data extract). It's not a correct matrix, though - could it b=
e
> >>>> just a bit of redundant code in the DST?
> >>>
> >>> Yes that is likely there often is a bunch of dead stuff DSDT leftover
> >>> from other device models.
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>>
> >>>> Darrell
> >>>>
> >>>> On Sat, 4 Feb 2023 at 21:31, Hans de Goede <hdegoede@redhat.com> wro=
te:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 2/4/23 18:09, Darrell Kavanagh wrote:
> >>>>>> I've just noticed that the working mount matrix that I added to my
> >>>>>> hwdb is the matrix retrieved from the ACPI ROTM call in the amende=
d
> >>>>>> driver, transposed.
> >>>>>
> >>>>> An other word for the mount matrix would be a rotation matrix,
> >>>>> since it defines how the physical sensor is mounted on the PCB
> >>>>> in a rotated fashion compared to its standard orientation.
> >>>>>
> >>>>> The x, y, z axis relationship underling of course does
> >>>>> not change by the rotation, so yes all mount matrices
> >>>>> are a transposition of the standard:
> >>>>>
> >>>>> 1, 0, 0 : 0, 1, 0 : 0, 0, 1
> >>>>>
> >>>>> matrix, that is expected. Where that to not be the case
> >>>>> then there would be a bug in the accelerometer driver itself
> >>>>> where the driver itself is swapping or inverting axis.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Hans
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>> On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
> >>>>>> <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Finally got a 6.2.0-rc6 kernel built and installed, with the foll=
owing
> >>>>>>> patch, and everything is working as expected.
> >>>>>>>
> >>>>>>> Moving on now to look at Bastien's suggestion.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Darrell
> >>>>>>>
> >>>>>>> diff --git a/kernel/drm_panel_orientation_quirks.c
> >>>>>>> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quir=
ks.c
> >>>>>>> index 3659f04..590bb7b 100644
> >>>>>>> --- a/kernel/drm_panel_orientation_quirks.c
> >>>>>>> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_=
quirks.c
> >>>>>>> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientatio=
n_data[] =3D {
> >>>>>>>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo id=
eapad
> >>>>>>> D330-10IGM"),
> >>>>>>>                 },
> >>>>>>>                 .driver_data =3D (void *)&lcd1200x1920_rightside_=
up,
> >>>>>>> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> >>>>>>> +               .matches =3D {
> >>>>>>> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>>>>>> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad D=
uet 3 10IGL5"),
> >>>>>>> +               },
> >>>>>>> +               .driver_data =3D (void *)&lcd1200x1920_rightside_=
up,
> >>>>>>>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
> >>>>>>>                 .matches =3D {
> >>>>>>>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>>>>>>
> >>>>>>> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> =
wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On 2/1/23 18:50, Darrell Kavanagh wrote:
> >>>>>>>>> Thank you. I don't have anything that could be called a big mac=
hine.
> >>>>>>>>> The fastest processor I have access to is a Core m3-8100Y - tha=
t's in
> >>>>>>>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
> >>>>>>>>> officially in Google's VM. I also have an ancient gen 2 core i5=
-2410M
> >>>>>>>>> machine which is slower than the m3 in theory, but that has 6GB=
 of
> >>>>>>>>> memory.
> >>>>>>>>>
> >>>>>>>>> Is the kernel build more processor or memory bound?
> >>>>>>>>
> >>>>>>>> It is mostly processor bound, esp. wtih something like make -j4,
> >>>>>>>> make -j16 will start taking some RAM, but with make -j4 I expect=
 you
> >>>>>>>> to be fully CPU bound.
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>>
> >>>>>>>> Hans
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net>=
 wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> On 2/1/23 11:28, Jonathan Cameron wrote:
> >>>>>>>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
> >>>>>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Hello, all.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I've finally reached a conclusion on this, after testing al=
l the
> >>>>>>>>>>>>> combinations of the patches (with and without reading the a=
cpi
> >>>>>>>>>>>>> mounting matrix), window managers (wayland, xorg) and the
> >>>>>>>>>>>>> presence or
> >>>>>>>>>>>>> not of my custom kernel parms.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> What works well is the full set of patches with the custom =
kernel
> >>>>>>>>>>>>> parms and a new hwdb entry for the sensor:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> >>>>>>>>>>>>>  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The autorotate then works correctly in wayland and xorg, bu=
t for
> >>>>>>>>>>>>> xorg,
> >>>>>>>>>>>>> the settings say the screen is "portrait left" when in actu=
al
> >>>>>>>>>>>>> fact it
> >>>>>>>>>>>>> is in standard laptop landscape orientation. Wayland does n=
ot
> >>>>>>>>>>>>> have
> >>>>>>>>>>>>> this problem (I guess because wayland's view of the screen =
is
> >>>>>>>>>>>>> straight
> >>>>>>>>>>>>> from the kernel).
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Without the hwdb entry, the orientation is 90 degrees out w=
ithout
> >>>>>>>>>>>>> using the acpi matrix and 180 degrees out when using it. I =
could
> >>>>>>>>>>>>> have
> >>>>>>>>>>>>> gone either way here with appropriate hwdb entries, but my =
view
> >>>>>>>>>>>>> is
> >>>>>>>>>>>>> that we *should* be using the matrix.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Added Hans de Goede as he has probably run into more of this=
 mess
> >>>>>>>>>>>> than anyone else.  Hans, any thoughts on if we are doing som=
ething
> >>>>>>>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
> >>>>>>>>>>>
> >>>>>>>>>>> I see below that this laptop has a panel which is mounted 90 =
degrees
> >>>>>>>>>>> rotated, that likely explains why the ACPI matrix does not wo=
rk.
> >>>>>>>>>>> So the best thing to do here is to just override it with a hw=
db
> >>>>>>>>>>> entries.
> >>>>>>>>>>>
> >>>>>>>>>>> IIRC there are already 1 or 2 other hwdb entries which actual=
ly
> >>>>>>>>>>> override the ACPI provided matrix because of similar issues.
> >>>>>>>>>>>
> >>>>>>>>>>> Linux userspace expects the matrix in this case to be set so =
that
> >>>>>>>>>>> it causes e.g. gnome's auto-rotation to put the image upright
> >>>>>>>>>>> even with older gnome versions / mate / xfce which don't know=
 about
> >>>>>>>>>>> the panel being mounted 90 degrees.
> >>>>>>>>>>>
> >>>>>>>>>>> So e.g. "monitor-sensor" will report left-side-up or right-si=
de-up
> >>>>>>>>>>> while the device is actually in normal clamshell mode with th=
e
> >>>>>>>>>>> display up-right.
> >>>>>>>>>>>
> >>>>>>>>>>> This reporting of left-side-up or right-side-up is actually "=
correct"
> >>>>>>>>>>> looking from the native LCD panel orientation and as mentione=
d is
> >>>>>>>>>>> done for backward compatibility. This is documented here:
> >>>>>>>>>>>
> >>>>>>>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor=
.hwdb#L54
> >>>>>>>>>>>
> >>>>>>>>>>> The way we are handling this is likely incompatible with how =
Windows
> >>>>>>>>>>> handles this special case of 90=C2=B0 rotated screen + ROTM. =
Or the
> >>>>>>>>>>> matrix in the ACPI tables could be just wrong...
> >>>>>>>>>>>
> >>>>>>>>>>>> I think 'ROTM' is defined by MS.
> >>>>>>>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/s=
ensors/sensors-acpi-entries
> >>>>>>>>>>>
> >>>>>>>>>>> Right and as such it would be good if we can still add suppor=
t to
> >>>>>>>>>>> it to the sensor driver in question. Because the ROTM info us=
ually
> >>>>>>>>>>> is correct and avoids the need for adding more and more hwdb =
entries.
> >>>>>>>>>>>
> >>>>>>>>>>> Note there already is existing support in some other sensor d=
rivers.
> >>>>>>>>>>>
> >>>>>>>>>>> So we probably need to factor out some helper code for this a=
nd share
> >>>>>>>>>>> that between sensor drivers.
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>> The only thing that concerns me is the need for custom kern=
el
> >>>>>>>>>>>>> parms.
> >>>>>>>>>>>>> It would be better if there was a way to avoid this, so tha=
t the
> >>>>>>>>>>>>> user
> >>>>>>>>>>>>> didn't have to mess around with their grub config. Though h=
aving
> >>>>>>>>>>>>> said
> >>>>>>>>>>>>> that, the sensors fix as we have it doesn't make things wor=
se -
> >>>>>>>>>>>>> under
> >>>>>>>>>>>>> currently released kernels the screen always starts up side=
ways
> >>>>>>>>>>>>> unless
> >>>>>>>>>>>>> custom parms are added in grub.
> >>>>>>>>>>>
> >>>>>>>>>>> We actually have a quirk mechanism in the kernel for specifyi=
ng
> >>>>>>>>>>> the need for: video=3DDSI-1:panel_orientation=3Dright_side_up=
  and this
> >>>>>>>>>>> will also automatically fix the fbcon orientation, see:
> >>>>>>>>>>>
> >>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >>>>>>>>>>>
> >>>>>>>>>>> If you submit a patch for this upstream please Cc me.
> >>>>>>>>>>
> >>>>>>>>>> And if after that change, and copy/pasting the orientation fro=
m the
> >>>>>>>>>> DSDT into hwdb the sensor and screen move in the expected ways=
, then
> >>>>>>>>>> maybe stealing the BMC150 driver's
> >>>>>>>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
> >>>>>>>>>>
> >>>>>>>>>> Once exported through "mount_matrix", iio-sensor-proxy should =
see it
> >>>>>>>>>> and read it without the need for a hwdb entry.
> >>>>>>>>>>
> >>>>>>>>>> Cheers
> >>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>
