Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0E686991
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjBAPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjBAPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:06:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268636FD00;
        Wed,  1 Feb 2023 07:04:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o13so17567300pjg.2;
        Wed, 01 Feb 2023 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcBpTvcOLwxCH/QCuxKJBBv/pUt7XpnbgoWYn5WBgrk=;
        b=IRtmfiUovy92Kek1ifytmnSidwLVppReL4c6zoMA5XmnXRiE8jJaorVam4ETuvrMfI
         Jv6N/0epg6oPM0huk7QKdS0/zO+sSIih7ZIxH97lH1JLVukDhJCUHdLClB9Ov61QkCP5
         kBKq8FsFaQ6bCYEoNxAi1uE/p4dy6McpnsLJbj1IAbGL5Bww+2WzP6yq4cLB6x2t82Eu
         znbZqfv5QxpvP9kCaMPnUfqXGDhiRBE8RMSWVFdkWYRimclyrd6aPLF/iW0zNxgTbdhv
         T8e58V99g4KdR1C+PtKnZZpJXk8YdEe4hRhmfsUkapFWHCQfHY9/P8XSGfMmGIZo31Of
         pT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcBpTvcOLwxCH/QCuxKJBBv/pUt7XpnbgoWYn5WBgrk=;
        b=KdRvIwz5Ce8vNLks88ySKJRiF5v2jVDywYhT5rFtFTM6kxGe167Br7oSjX/yd4QFBu
         /G7crotf8wkZyDpeGmZjaEKO2OED5xvwmTVySPYX2jyh4PUqG/DFDoyP1tMde/1wGRUC
         CaKGPcdHH1wTJ1+PlH2jnDWuulZFQa3JEd46jD1EeQH+WuBGOToiNwxEHfOqkdMNOBtq
         k9sqq5hTTakCzcR4O9UOUnSfQFbKaPMbX1l5zZk4RvsChZRyYF81UwpvFKlXUzbp+Jt9
         8mgd5sF56o0Ca7gyBcohUS4q8QACbd65wrAZXzIwNBsaCCUq0xG6MDEDBsDtpk4Dv1YZ
         V42w==
X-Gm-Message-State: AO0yUKVaP//NQvVW8CRYK7ywHBJEUJhe24QJ+oNVFoUUo+UdehKDJOO6
        yLD7TXjVgWEbS+R5hby705GK6GQyRAG3CGBn04k=
X-Google-Smtp-Source: AK7set8NtbHquTvOZDlOqKffonw+GNZ4iW9dVXy2NOgQwcnBi/Hb3sWZKq07UC1xHb83DnuQ+jECcJt6Gqa7Ymvry6E=
X-Received: by 2002:a17:902:eccb:b0:194:6253:d685 with SMTP id
 a11-20020a170902eccb00b001946253d685mr723352plh.3.1675263816719; Wed, 01 Feb
 2023 07:03:36 -0800 (PST)
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
In-Reply-To: <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Wed, 1 Feb 2023 15:03:24 +0000
Message-ID: <CAMxBKG1CdsD=Bq-4=EqLQfsb9h+H_47AGEn4Jxygpr9cAq238A@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
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

Thanks for the info, Hans. I was hoping there'd be something like
that. Compiling the whole kernel on this little machine will be
interesting, though...

On Wed, 1 Feb 2023 at 11:01, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/1/23 11:28, Jonathan Cameron wrote:
> > On Wed, 1 Feb 2023 01:40:49 +0000
> > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >
> >> Hello, all.
> >>
> >> I've finally reached a conclusion on this, after testing all the
> >> combinations of the patches (with and without reading the acpi
> >> mounting matrix), window managers (wayland, xorg) and the presence or
> >> not of my custom kernel parms.
> >>
> >> What works well is the full set of patches with the custom kernel
> >> parms and a new hwdb entry for the sensor:
> >>
> >> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> >>  ACCEL_MOUNT_MATRIX=3D0, 1, 0; -1, 0, 0; 0, 0, 1
> >>
> >> The autorotate then works correctly in wayland and xorg, but for xorg,
> >> the settings say the screen is "portrait left" when in actual fact it
> >> is in standard laptop landscape orientation. Wayland does not have
> >> this problem (I guess because wayland's view of the screen is straight
> >> from the kernel).
> >>
> >> Without the hwdb entry, the orientation is 90 degrees out without
> >> using the acpi matrix and 180 degrees out when using it. I could have
> >> gone either way here with appropriate hwdb entries, but my view is
> >> that we *should* be using the matrix.
> >
> > Added Hans de Goede as he has probably run into more of this mess
> > than anyone else.  Hans, any thoughts on if we are doing something
> > wrong on kernel side?  Or is the matrix just wrong *sigh*
>
> I see below that this laptop has a panel which is mounted 90 degrees
> rotated, that likely explains why the ACPI matrix does not work.
> So the best thing to do here is to just override it with a hwdb entries.
>
> IIRC there are already 1 or 2 other hwdb entries which actually
> override the ACPI provided matrix because of similar issues.
>
> Linux userspace expects the matrix in this case to be set so that
> it causes e.g. gnome's auto-rotation to put the image upright
> even with older gnome versions / mate / xfce which don't know about
> the panel being mounted 90 degrees.
>
> So e.g. "monitor-sensor" will report left-side-up or right-side-up
> while the device is actually in normal clamshell mode with the
> display up-right.
>
> This reporting of left-side-up or right-side-up is actually "correct"
> looking from the native LCD panel orientation and as mentioned is
> done for backward compatibility. This is documented here:
>
> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb#L54
>
> The way we are handling this is likely incompatible with how Windows
> handles this special case of 90=C2=B0 rotated screen + ROTM. Or the
> matrix in the ACPI tables could be just wrong...
>
> > I think 'ROTM' is defined by MS.
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sens=
ors-acpi-entries
>
> Right and as such it would be good if we can still add support to
> it to the sensor driver in question. Because the ROTM info usually
> is correct and avoids the need for adding more and more hwdb entries.
>
> Note there already is existing support in some other sensor drivers.
>
> So we probably need to factor out some helper code for this and share
> that between sensor drivers.
>
>
> >> The only thing that concerns me is the need for custom kernel parms.
> >> It would be better if there was a way to avoid this, so that the user
> >> didn't have to mess around with their grub config. Though having said
> >> that, the sensors fix as we have it doesn't make things worse - under
> >> currently released kernels the screen always starts up sideways unless
> >> custom parms are added in grub.
>
> We actually have a quirk mechanism in the kernel for specifying
> the need for: video=3DDSI-1:panel_orientation=3Dright_side_up  and this
> will also automatically fix the fbcon orientation, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/gpu/drm/drm_panel_orientation_quirks.c
>
> If you submit a patch for this upstream please Cc me.
>
> Regards,
>
> Hans
>
>
>
>
>
>
> >>> On Mon, 30 Jan 2023 at 20:17, Jonathan Cameron <jic23@kernel.org> wro=
te:
> >>>>
> >>>> On Mon, 30 Jan 2023 20:02:31 +0000
> >>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>
> >>>>> Thanks. To be clear, before I changed the grub command line, the
> >>>>> system always booted up "sideways", even when the sensor was not be=
ing
> >>>>> detected. This was true for everything, not just Gnome, except grub
> >>>>> itself.
> >>>>>
> >>>>> I added:
> >>>>>
> >>>>> GRUB_CMDLINE_LINUX_DEFAULT=3D"fbcon=3Drotate:1
> >>>>> video=3DDSI-1:panel_orientation=3Dright_side_up quiet splash"
> >>>>>
> >>>>> This fixed the orientation for pre-splash boot messages, the splash
> >>>>> screen and the desktop environment. But not, for example (as I saw
> >>>>> after adding my own module signing key for testing your fixes), the
> >>>>> MOK validation screens.
> >>>>>
> >>>>> Does this make sense?
> >>>>>
> >>>>> Does what you are proposing act at a lower level than changing the
> >>>>> systemd hwdb orientation matrix?
> >>>>
> >>>> I'm not sure on the userspace side of things, but intent is that
> >>>> it will provide the orientation data to any users - though only afte=
r
> >>>> the kernel boots and software needs to be aware of it.  Give it a go=
,
> >>>> and if not Bastien (IIRC wrote iio-sensor-proxy) may be able to advi=
se.
> >>>>
> >>>> For Bastien - patches for kernel side are:
> >>>> https://lore.kernel.org/linux-iio/20230130201018.981024-1-jic23@kern=
el.org/T/#t
> >>>>
> >>>> Darrell is going to test them after back porting to 6.1.
> >>>> With the first patch he gets the right result in gnome but we weren'=
t
> >>>> picking up the rotation matrix at that point (ROTM in ACPI).
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Darrell
> >>>>>
> >>>>> On Mon, 30 Jan 2023 at 19:27, Jonathan Cameron <jic23@kernel.org> w=
rote:
> >>>>>>
> >>>>>> On Mon, 30 Jan 2023 18:32:02 +0000
> >>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>
> >>>>>>> On Mon, 30 Jan 2023 at 17:35, Jonathan Cameron
> >>>>>>> <Jonathan.Cameron@huawei.com> wrote:
> >>>>>>>
> >>>>>>>> That certainly looks like suitable matrix.
> >>>>>>>>
> >>>>>>>> If we are lucky it matches the handling in bmc150-accel-core.c f=
or an identically
> >>>>>>>> named method.  That is going to swap the x and y axis which is I=
'd have thought would
> >>>>>>>> be rather bad if what you have is currently working well.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Actually, that would be good, because at present I have to rotate=
 90
> >>>>>>> degrees in my grub command line.
> >>>>>> :)
> >>>>>>
> >>>>>> I'll see if I can roll a suitable patch.
> >>>>>>
> >>>>>> Jonathan
> >>>>>>
> >>>>>>>
> >>>>>>> Darrell
> >>>>>>>
> >>>>>>>>>             }
> >>>>>>>>>
> >>>>>>>>>             Method (PRIM, 0, NotSerialized)
> >>>>>>>>>             {
> >>>>>>>>>                 Name (RBUF, Buffer (One)
> >>>>>>>>>                 {
> >>>>>>>>>                      0x01                                      =
       // .
> >>>>>>>>>                 })
> >>>>>>>>>                 Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.PRIM.RBUF=
 */
> >>>>>>>>>             }
> >>>>>>>>>
> >>>>>>>>>             Method (_STA, 0, NotSerialized)  // _STA: Status
> >>>>>>>>>             {
> >>>>>>>>>                 If ((GAVT =3D=3D 0x6A))
> >>>>>>>>>                 {
> >>>>>>>>>                     Return (0x0F)
> >>>>>>>>>                 }
> >>>>>>>>>                 Else
> >>>>>>>>>                 {
> >>>>>>>>>                     Return (Zero)
> >>>>>>>>>                 }
> >>>>>>>>>             }
> >>>>>>>>>
> >>>>>>>>>             Method (CALS, 1, NotSerialized)
> >>>>>>>>>             {
> >>>>>>>>>                 Local0 =3D Arg0
> >>>>>>>>>                 If (((Local0 =3D=3D Zero) || (Local0 =3D=3D One=
s)))
> >>>>>>>>>                 {
> >>>>>>>>>                     Local0 =3D BAC1 /* \BAC1 */
> >>>>>>>>>                     Return (Local0)
> >>>>>>>>>                 }
> >>>>>>>>>                 Else
> >>>>>>>>>                 {
> >>>>>>>>>                     BAC1 =3D Local0
> >>>>>>>>>                     BACS =3D Local0
> >>>>>>>>>                     BSCA (0xB0)
> >>>>>>>>>                 }
> >>>>>>>>>             }
> >>>>>>>>>         }
> >>>>>>>>>     }
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Darrell
> >>>>>>>>>
> >>>>>>>>> On Mon, 30 Jan 2023 at 12:31, Jonathan Cameron
> >>>>>>>>> <Jonathan.Cameron@huawei.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Mon, 30 Jan 2023 03:37:23 +0000
> >>>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>> Forwarding because original html messages were rejected by th=
e server...
> >>>>>>>>>>>
> >>>>>>>>>>> ---------- Forwarded message ---------
> >>>>>>>>>>> From: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> >>>>>>>>>>> Date: Mon, 30 Jan 2023 at 02:52
> >>>>>>>>>>> Subject: Re: Bug#1029850: linux: Driver not loaded for ST
> >>>>>>>>>>> Microelectronics LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8=
B30:)
> >>>>>>>>>>> To: Jonathan Cameron <jic23@kernel.org>
> >>>>>>>>>>> Cc: <lorenzo@kernel.org>, <lars@metafoo.de>,
> >>>>>>>>>>> <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
> >>>>>>>>>>> <carnil@debian.org>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Hi Jonathan,
> >>>>>>>>>>>
> >>>>>>>>>>> Thank you. The driver has evolved quite a bit in 6.2 (I read =
somewhere
> >>>>>>>>>>> that 6.2 includes some i2c enhancements), but I adapted your =
changes
> >>>>>>>>>>> to fit my Debian 6.1 kernel and it works. Two IIO devices are=
 created
> >>>>>>>>>>> in sysfs, iio-sensor-proxy.service starts up and automatic sc=
reen
> >>>>>>>>>>> rotation in Gnome just works.
> >>>>>>>>>>>
> >>>>>>>>>>> To get the modules to load on boot, I made a small change to =
your code
> >>>>>>>>>>> in st_lsm6dsx_i2c to add the acpi alias to modules.alias:
> >>>>>>>>>>>
> >>>>>>>>>>> adding a null element to st_lsm6dsx_i2c_acpi_match:
> >>>>>>>>>>>     static const struct acpi_device_id st_lsm6dsx_i2c_acpi_ma=
tch[] =3D {
> >>>>>>>>>>>          { "SMO8B30", ST_LSM6DS3TRC_ID, },
> >>>>>>>>>>>          { },
> >>>>>>>>>>>     };
> >>>>>>>>>>> then:
> >>>>>>>>>>>    MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
> >>>>>>>>>>
> >>>>>>>>>> doh! That was indeed sloppy of me to miss even for an untested=
 hack.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> dmesg shows:
> >>>>>>>>>>>
> >>>>>>>>>>> [ 7366.120208] st_lsm6dsx_i2c i2c-SMO8B30:00: supply vdd not =
found,
> >>>>>>>>>>> using dummy regulator
> >>>>>>>>>>> [ 7366.120260] st_lsm6dsx_i2c i2c-SMO8B30:00: supply vddio no=
t found,
> >>>>>>>>>>> using dummy regulator
> >>>>>>>>>>> [ 7366.650839] st_lsm6dsx_i2c i2c-SMO8B30:00: mounting matrix=
 not
> >>>>>>>>>>> found: using identity...
> >>>>>>>>>>>
> >>>>>>>>>>> Is this a problem?
> >>>>>>>>>>
> >>>>>>>>>> Those are all fine. For regulators that's expected on ACPI and=
 should
> >>>>>>>>>> be harmless as it's up to the firmware to manage power (in DT =
it may
> >>>>>>>>>> be up to the kernel).
> >>>>>>>>>> For the mounting matrix, there is often something in ACPI DSDT
> >>>>>>>>>> (non standard though).  Could you
> >>>>>>>>>> cat /sys/firmware/acpi/tables/DSDT > ~/dsdt
> >>>>>>>>>> then run through iasl from acpitools
> >>>>>>>>>> iasl -d ~/dsdt
> >>>>>>>>>> and find the bit related to this device.
> >>>>>>>>>>
> >>>>>>>>>> If you can then share that there may be a _DSM or similar in t=
here that
> >>>>>>>>>> is effectively the mounting matrix.  If we are lucky it will l=
ook like
> >>>>>>>>>> some existing versions we have code to handle and can add that=
 support
> >>>>>>>>>> as well.
> >>>>>>>>>>
> >>>>>>>>>> Either way - I'll spin a formal patch with your fixes above an=
d we can
> >>>>>>>>>> get this upstream for future kernels.  Mounting matrix can fol=
low
> >>>>>>>>>> later if needed.
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>>
> >>>>>>>>>> Jonathan
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks again.
> >>>>>>>>>>>
> >>>>>>>>>>> Darrell
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On Sun, 29 Jan 2023 at 18:10, Jonathan Cameron <jic23@kernel.=
org> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Sun, 29 Jan 2023 17:03:51 +0000
> >>>>>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I raised this bug in Debian, and have been asked to raise i=
t upstream and
> >>>>>>>>>>>>> was given your addresses to do so. Will this email be OK, o=
r should I raise
> >>>>>>>>>>>>> it in a bug tracking system somewhere?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Email is the right option.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Many thanks,
> >>>>>>>>>>>>> Darrell
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ---------- Forwarded message ---------
> >>>>>>>>>>>>> From: Salvatore Bonaccorso <carnil@debian.org>
> >>>>>>>>>>>>> Date: Sat, 28 Jan 2023 at 20:33
> >>>>>>>>>>>>> Subject: Re: Bug#1029850: linux: Driver not loaded for ST M=
icroelectronics
> >>>>>>>>>>>>> LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
> >>>>>>>>>>>>> To: Darrell Kavanagh <darrell.kavanagh@gmail.com>, <1029850=
@bugs.debian.org>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Hi Darrell,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Sat, Jan 28, 2023 at 08:13:16PM +0000, Darrell Kavanagh =
wrote:
> >>>>>>>>>>>>>> Package: src:linux
> >>>>>>>>>>>>>> Version: 6.1.4-1
> >>>>>>>>>>>>>> Severity: normal
> >>>>>>>>>>>>>> File: linux
> >>>>>>>>>>>>>> X-Debbugs-Cc: darrell.kavanagh@gmail.com
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Dear Maintainer,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This is a convertable touchscreen tablet/laptop. The rotat=
ion sensor
> >>>>>>>>>>>>> device
> >>>>>>>>>>>>>> ST Microelectronics LSM6DS3TR-C does not work. It is detec=
ted via ACPI
> >>>>>>>>>>>>> and the
> >>>>>>>>>>>>>> sysfs trees are created at
> >>>>>>>>>>>>> devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-=
SMO8B30:00
> >>>>>>>>>>>>>> and devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:3c/S=
MO8B30:00 with
> >>>>>>>>>>>>>> symlinks bus/acpi/devices/SMO8B30:00 and bus/i2c/devices/i=
2c-SMO8B30:00,
> >>>>>>>>>>>>> but
> >>>>>>>>>>>>>> no driver is loaded.
> >>>>>>>>>>>>
> >>>>>>>>>>>> At least this is using the ST PNP ID which is better than av=
erage
> >>>>>>>>>>>> (long story!)
> >>>>>>>>>>>>
> >>>>>>>>>>>> The driver in question (ultimately drivers/iio/imu/st_lsm6ds=
x/st_lsm6dsx_i2c.c
> >>>>>>>>>>>> does not currently have an ACPI support.  It should be strai=
ght forwards
> >>>>>>>>>>>> to add though the driver first needs converting to use
> >>>>>>>>>>>> device_get_match_data() with appropriate fallback so that it=
 will match on
> >>>>>>>>>>>> ACPI, OF or original spi_device_id tables
> >>>>>>>>>>>>
> >>>>>>>>>>>> Completely untested but something like the following
> >>>>>>>>>>>> (the offset in the enum is needed to allow us to tell if we =
got a result when
> >>>>>>>>>>>> calling device_get_match_data() as it returns NULL on failur=
e IIRC)
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm not sure how sucessful the driver will be at finding any=
 interrupts etc, but
> >>>>>>>>>>>> it may get you basic functionality.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Good luck and others more familiar with the driver may well =
tell me what I forgot
> >>>>>>>>>>>> when hacking the below ;)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>>>>>>>>>> index 499fcf8875b4..2617ce236ddc 100644
> >>>>>>>>>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>>>>>>>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> >>>>>>>>>>>> @@ -39,7 +39,7 @@
> >>>>>>>>>>>>  #define ST_ISM330IS_DEV_NAME   "ism330is"
> >>>>>>>>>>>>
> >>>>>>>>>>>>  enum st_lsm6dsx_hw_id {
> >>>>>>>>>>>> -       ST_LSM6DS3_ID,
> >>>>>>>>>>>> +       ST_LSM6DS3_ID =3D 1,
> >>>>>>>>>>>>         ST_LSM6DS3H_ID,
> >>>>>>>>>>>>         ST_LSM6DSL_ID,
> >>>>>>>>>>>>         ST_LSM6DSM_ID,
> >>>>>>>>>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/d=
rivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> >>>>>>>>>>>> index df5f60925260..ecfceb2fb3db 100644
> >>>>>>>>>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> >>>>>>>>>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> >>>>>>>>>>>> @@ -23,10 +23,15 @@ static const struct regmap_config st_lsm=
6dsx_i2c_regmap_config =3D {
> >>>>>>>>>>>>
> >>>>>>>>>>>>  static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
> >>>>>>>>>>>>  {
> >>>>>>>>>>>> -       const struct i2c_device_id *id =3D i2c_client_get_de=
vice_id(client);
> >>>>>>>>>>>> -       int hw_id =3D id->driver_data;
> >>>>>>>>>>>> +       int hw_id;
> >>>>>>>>>>>>         struct regmap *regmap;
> >>>>>>>>>>>>
> >>>>>>>>>>>> +       hw_id =3D (kernel_ulong_t)device_get_match_data(&cli=
ent->dev);
> >>>>>>>>>>>> +       if (!hw_id)
> >>>>>>>>>>>> +               hw_id =3D i2c_client_get_device_id(client)->=
driver_data;
> >>>>>>>>>>>> +       if (!hw_id)
> >>>>>>>>>>>> +               return -EINVAL;
> >>>>>>>>>>>> +
> >>>>>>>>>>>>         regmap =3D devm_regmap_init_i2c(client, &st_lsm6dsx_=
i2c_regmap_config);
> >>>>>>>>>>>>         if (IS_ERR(regmap)) {
> >>>>>>>>>>>>                 dev_err(&client->dev, "Failed to register i2=
c regmap %ld\n", PTR_ERR(regmap));
> >>>>>>>>>>>> @@ -129,6 +134,10 @@ static const struct of_device_id st_lsm=
6dsx_i2c_of_match[] =3D {
> >>>>>>>>>>>>  };
> >>>>>>>>>>>>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static const struct acpi_device_id st_lsm6dsx_i2c_acpi_matc=
h[] =3D {
> >>>>>>>>>>>> +       { "SMO8B30", ST_LSM6DS3TRC_ID, },
> >>>>>>>>>>>> +};
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[]=
 =3D {
> >>>>>>>>>>>>         { ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> >>>>>>>>>>>>         { ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
> >>>>>>>>>>>> @@ -161,6 +170,7 @@ static struct i2c_driver st_lsm6dsx_driv=
er =3D {
> >>>>>>>>>>>>                 .name =3D "st_lsm6dsx_i2c",
> >>>>>>>>>>>>                 .pm =3D pm_sleep_ptr(&st_lsm6dsx_pm_ops),
> >>>>>>>>>>>>                 .of_match_table =3D st_lsm6dsx_i2c_of_match,
> >>>>>>>>>>>> +               .acpi_match_table =3D st_lsm6dsx_i2c_acpi_ma=
tch,
> >>>>>>>>>>>>         },
> >>>>>>>>>>>>         .probe_new =3D st_lsm6dsx_i2c_probe,
> >>>>>>>>>>>>         .id_table =3D st_lsm6dsx_i2c_id_table,
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The device is identifying itself to the kernel with PNP id=
 SMO8B30:
> >>>>>>>>>>>>>> physical_node:
> >>>>>>>>>>>>>>       modalias=3Dacpi:SMO8B30:SMO8B30:
> >>>>>>>>>>>>>>       name=3DSMO8B30:00
> >>>>>>>>>>>>>>       uevent=3DMODALIAS=3Dacpi:SMO8B30:SMO8B30:
> >>>>>>>>>>>>>>       waiting_for_supplier=3D0
> >>>>>>>>>>>>>> firmware_node:
> >>>>>>>>>>>>>>       hid=3DSMO8B30
> >>>>>>>>>>>>>>       modalias=3Dacpi:SMO8B30:SMO8B30:
> >>>>>>>>>>>>>>       path=3D\_SB_.PCI0.I2C5.DEV_
> >>>>>>>>>>>>>>       status=3D15
> >>>>>>>>>>>>>>       uevent=3DMODALIAS=3Dacpi:SMO8B30:SMO8B30:
> >>>>>>>>>>>>>>       uid=3D0
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The kernel module for the appropriate driver (st_lsm6dsx_i=
2c) is not
> >>>>>>>>>>>>> loaded on boot.
> >>>>>>>>>>>>>> Modprobing it does not associate it with the device, as I =
would expect as
> >>>>>>>>>>>>>> the module does not provide an alias for the above acpi/pn=
p id.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Can you report this issue upstream? Gues to reach out are a=
ccording to
> >>>>>>>>>>>>> get_maintainers.pl script:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Lorenzo Bianconi <lorenzo@kernel.org> (maintainer:ST LSM6DS=
x IMU IIO DRIVER)
> >>>>>>>>>>>>> Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYST=
EM AND DRIVERS)
> >>>>>>>>>>>>> Lars-Peter Clausen <lars@metafoo.de> (reviewer:IIO SUBSYSTE=
M AND DRIVERS)
> >>>>>>>>>>>>> linux-iio@vger.kernel.org (open list:ST LSM6DSx IMU IIO DRI=
VER)
> >>>>>>>>>>>>> linux-kernel@vger.kernel.org (open list)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Please keep us in the loop.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Regards,
> >>>>>>>>>>>>> Salvatore
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >
>
