Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E869C682E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAaNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjAaNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:35:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050DC659B;
        Tue, 31 Jan 2023 05:35:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so6638291pjb.4;
        Tue, 31 Jan 2023 05:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3VDX6Unby9wNpNu+DyetD3ZE0Iy3m0jHHmyeV0OMQo=;
        b=melDFK00x680o3phD/Z4UPwDVnlrFXhdmXpdZEzsU83p+AI63n+JPd4OPDq6el714z
         0UfmPXCi9iJg8y2HRVLyaYXkbcwSUQ/Pf4cq2Z8RQXn5oYMacdydl19IdGBgesJzDWMK
         Beh2s1iPlsbmAYeP8rWNWL6uzw4N3N6A3QDWQ19kArFdkr07yY66ipk2xZu5hSnxKcxL
         IGaOM6TjIj0igCPQnfhCe2SYnodoRbAJwkwiP3wDCOnJYnLq81uN5PjDEE2yuvhDTi84
         M9L2EA/di9thiV3ebgi7KfNyix70glfzH6UsSGI/iGfKormXwgwfZx3QaTIA9wk1i+pd
         432w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3VDX6Unby9wNpNu+DyetD3ZE0Iy3m0jHHmyeV0OMQo=;
        b=T8HrnNlUxdMRg9i1PCouWHRWPrg6+qHHSGh1Fz7JKf4k6vwQgSGq+4e1BA5MNFbAGM
         wIf3OsaS2kiksIia4re2g1kVq6Q3dux8kJjWUTG8uWORlqBZ8ma/s6VZVrVkSBQ/kMNJ
         /g3TTTOpP3guE9uy//Meaq0WrrWgAtppobrQxwBW4r5HL5m5+VikU6U/8BIy2jsKuA9n
         QrOiuHNUCleqWpIBwAV5bFLiim95SOZFMKDRGSOMLh8PVZ0Vv+dJ8RCNXfEpDtTQuwAE
         16cZu8dHfyzuGkAJjCkke5R114vDUdwJgjnK19JwHQWED4OF0jLdMHbxw8ufeB7ouhF8
         YoEA==
X-Gm-Message-State: AFqh2kqHW/72v5YIOVBhSFF6Ow6GAeIxapsopGjVKbR9R6pk2pZDixpB
        UTKFGSV2cOSGzPj8+XFeX3UU+o4mygEsYE0XXSw=
X-Google-Smtp-Source: AMrXdXtSA8pemhehMmqhL+fBa7gq72LgrPFCXlUDM+W3LXQq9AOxypU3m5QSih1TRAu1EEUJB5pb2zTOM/OHdKeObq8=
X-Received: by 2002:a17:90a:138a:b0:22b:ba09:cb1a with SMTP id
 i10-20020a17090a138a00b0022bba09cb1amr5476268pja.188.1675172102303; Tue, 31
 Jan 2023 05:35:02 -0800 (PST)
MIME-Version: 1.0
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <Y9WGmBc9HG4Tx9gf@eldamar.lan> <CAMxBKG1670TFuV3nHP7Yk8s6H+oBF7iiyiB-b=PvKv9hcH22xQ@mail.gmail.com>
 <20230129182441.082f29d0@jic23-huawei> <CAMxBKG0tyLSpaDPGBXsJbqgHSG9rH6owtSJsLw_ekmTA3Kyvdw@mail.gmail.com>
 <CAMxBKG3zL_yvw=dHK+Gqd3EHWzvJmiLHVvKnf6UsYbMgcS6nrg@mail.gmail.com>
 <20230130123113.00002c3f@Huawei.com> <CAMxBKG3xOEj1gEs9pGzKb+rDjTLPqAq1YOp4bEFas4tQMzGZ+Q@mail.gmail.com>
 <20230130173525.0000418d@huawei.com> <CAMxBKG1yKcodDD2kvfwKvpYnPrXmgaOk9rTztRPFzKMCZ5F=tA@mail.gmail.com>
 <20230130194110.256144e7@jic23-huawei> <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
 <20230130203110.60c96f37@jic23-huawei>
In-Reply-To: <20230130203110.60c96f37@jic23-huawei>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Tue, 31 Jan 2023 13:34:49 +0000
Message-ID: <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick update on testing: I'm finding what look like
interactions between the kernel parm
video=DSI-1:panel_orientation=right_side_up and the sensor, which also
seem to differ depending on whether I'm in an X or Wayland session.
I'm documenting the effects of the various combinations and will post
my results when complete.

Thanks,
Darrell





On Mon, 30 Jan 2023 at 20:17, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 30 Jan 2023 20:02:31 +0000
> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
>
> > Thanks. To be clear, before I changed the grub command line, the
> > system always booted up "sideways", even when the sensor was not being
> > detected. This was true for everything, not just Gnome, except grub
> > itself.
> >
> > I added:
> >
> > GRUB_CMDLINE_LINUX_DEFAULT="fbcon=rotate:1
> > video=DSI-1:panel_orientation=right_side_up quiet splash"
> >
> > This fixed the orientation for pre-splash boot messages, the splash
> > screen and the desktop environment. But not, for example (as I saw
> > after adding my own module signing key for testing your fixes), the
> > MOK validation screens.
> >
> > Does this make sense?
> >
> > Does what you are proposing act at a lower level than changing the
> > systemd hwdb orientation matrix?
>
> I'm not sure on the userspace side of things, but intent is that
> it will provide the orientation data to any users - though only after
> the kernel boots and software needs to be aware of it.  Give it a go,
> and if not Bastien (IIRC wrote iio-sensor-proxy) may be able to advise.
>
> For Bastien - patches for kernel side are:
> https://lore.kernel.org/linux-iio/20230130201018.981024-1-jic23@kernel.org/T/#t
>
> Darrell is going to test them after back porting to 6.1.
> With the first patch he gets the right result in gnome but we weren't
> picking up the rotation matrix at that point (ROTM in ACPI).
>
> Thanks,
>
> Jonathan
>
> >
> > Thanks,
> > Darrell
> >
> > On Mon, 30 Jan 2023 at 19:27, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 30 Jan 2023 18:32:02 +0000
> > > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > >
> > > > On Mon, 30 Jan 2023 at 17:35, Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > > That certainly looks like suitable matrix.
> > > > >
> > > > > If we are lucky it matches the handling in bmc150-accel-core.c for an identically
> > > > > named method.  That is going to swap the x and y axis which is I'd have thought would
> > > > > be rather bad if what you have is currently working well.
> > > > >
> > > >
> > > > Actually, that would be good, because at present I have to rotate 90
> > > > degrees in my grub command line.
> > > :)
> > >
> > > I'll see if I can roll a suitable patch.
> > >
> > > Jonathan
> > >
> > > >
> > > > Darrell
> > > >
> > > > > >             }
> > > > > >
> > > > > >             Method (PRIM, 0, NotSerialized)
> > > > > >             {
> > > > > >                 Name (RBUF, Buffer (One)
> > > > > >                 {
> > > > > >                      0x01                                             // .
> > > > > >                 })
> > > > > >                 Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.PRIM.RBUF */
> > > > > >             }
> > > > > >
> > > > > >             Method (_STA, 0, NotSerialized)  // _STA: Status
> > > > > >             {
> > > > > >                 If ((GAVT == 0x6A))
> > > > > >                 {
> > > > > >                     Return (0x0F)
> > > > > >                 }
> > > > > >                 Else
> > > > > >                 {
> > > > > >                     Return (Zero)
> > > > > >                 }
> > > > > >             }
> > > > > >
> > > > > >             Method (CALS, 1, NotSerialized)
> > > > > >             {
> > > > > >                 Local0 = Arg0
> > > > > >                 If (((Local0 == Zero) || (Local0 == Ones)))
> > > > > >                 {
> > > > > >                     Local0 = BAC1 /* \BAC1 */
> > > > > >                     Return (Local0)
> > > > > >                 }
> > > > > >                 Else
> > > > > >                 {
> > > > > >                     BAC1 = Local0
> > > > > >                     BACS = Local0
> > > > > >                     BSCA (0xB0)
> > > > > >                 }
> > > > > >             }
> > > > > >         }
> > > > > >     }
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Darrell
> > > > > >
> > > > > > On Mon, 30 Jan 2023 at 12:31, Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > > >
> > > > > > > On Mon, 30 Jan 2023 03:37:23 +0000
> > > > > > > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > > > > > >
> > > > > > > > Forwarding because original html messages were rejected by the server...
> > > > > > > >
> > > > > > > > ---------- Forwarded message ---------
> > > > > > > > From: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> > > > > > > > Date: Mon, 30 Jan 2023 at 02:52
> > > > > > > > Subject: Re: Bug#1029850: linux: Driver not loaded for ST
> > > > > > > > Microelectronics LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
> > > > > > > > To: Jonathan Cameron <jic23@kernel.org>
> > > > > > > > Cc: <lorenzo@kernel.org>, <lars@metafoo.de>,
> > > > > > > > <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
> > > > > > > > <carnil@debian.org>
> > > > > > > >
> > > > > > > >
> > > > > > > > Hi Jonathan,
> > > > > > > >
> > > > > > > > Thank you. The driver has evolved quite a bit in 6.2 (I read somewhere
> > > > > > > > that 6.2 includes some i2c enhancements), but I adapted your changes
> > > > > > > > to fit my Debian 6.1 kernel and it works. Two IIO devices are created
> > > > > > > > in sysfs, iio-sensor-proxy.service starts up and automatic screen
> > > > > > > > rotation in Gnome just works.
> > > > > > > >
> > > > > > > > To get the modules to load on boot, I made a small change to your code
> > > > > > > > in st_lsm6dsx_i2c to add the acpi alias to modules.alias:
> > > > > > > >
> > > > > > > > adding a null element to st_lsm6dsx_i2c_acpi_match:
> > > > > > > >     static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
> > > > > > > >          { "SMO8B30", ST_LSM6DS3TRC_ID, },
> > > > > > > >          { },
> > > > > > > >     };
> > > > > > > > then:
> > > > > > > >    MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
> > > > > > >
> > > > > > > doh! That was indeed sloppy of me to miss even for an untested hack.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > dmesg shows:
> > > > > > > >
> > > > > > > > [ 7366.120208] st_lsm6dsx_i2c i2c-SMO8B30:00: supply vdd not found,
> > > > > > > > using dummy regulator
> > > > > > > > [ 7366.120260] st_lsm6dsx_i2c i2c-SMO8B30:00: supply vddio not found,
> > > > > > > > using dummy regulator
> > > > > > > > [ 7366.650839] st_lsm6dsx_i2c i2c-SMO8B30:00: mounting matrix not
> > > > > > > > found: using identity...
> > > > > > > >
> > > > > > > > Is this a problem?
> > > > > > >
> > > > > > > Those are all fine. For regulators that's expected on ACPI and should
> > > > > > > be harmless as it's up to the firmware to manage power (in DT it may
> > > > > > > be up to the kernel).
> > > > > > > For the mounting matrix, there is often something in ACPI DSDT
> > > > > > > (non standard though).  Could you
> > > > > > > cat /sys/firmware/acpi/tables/DSDT > ~/dsdt
> > > > > > > then run through iasl from acpitools
> > > > > > > iasl -d ~/dsdt
> > > > > > > and find the bit related to this device.
> > > > > > >
> > > > > > > If you can then share that there may be a _DSM or similar in there that
> > > > > > > is effectively the mounting matrix.  If we are lucky it will look like
> > > > > > > some existing versions we have code to handle and can add that support
> > > > > > > as well.
> > > > > > >
> > > > > > > Either way - I'll spin a formal patch with your fixes above and we can
> > > > > > > get this upstream for future kernels.  Mounting matrix can follow
> > > > > > > later if needed.
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Jonathan
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks again.
> > > > > > > >
> > > > > > > > Darrell
> > > > > > > >
> > > > > > > >
> > > > > > > > On Sun, 29 Jan 2023 at 18:10, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, 29 Jan 2023 17:03:51 +0000
> > > > > > > > > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > I raised this bug in Debian, and have been asked to raise it upstream and
> > > > > > > > > > was given your addresses to do so. Will this email be OK, or should I raise
> > > > > > > > > > it in a bug tracking system somewhere?
> > > > > > > > >
> > > > > > > > > Email is the right option.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Many thanks,
> > > > > > > > > > Darrell
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ---------- Forwarded message ---------
> > > > > > > > > > From: Salvatore Bonaccorso <carnil@debian.org>
> > > > > > > > > > Date: Sat, 28 Jan 2023 at 20:33
> > > > > > > > > > Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
> > > > > > > > > > LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
> > > > > > > > > > To: Darrell Kavanagh <darrell.kavanagh@gmail.com>, <1029850@bugs.debian.org>
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Hi Darrell,
> > > > > > > > > >
> > > > > > > > > > On Sat, Jan 28, 2023 at 08:13:16PM +0000, Darrell Kavanagh wrote:
> > > > > > > > > > > Package: src:linux
> > > > > > > > > > > Version: 6.1.4-1
> > > > > > > > > > > Severity: normal
> > > > > > > > > > > File: linux
> > > > > > > > > > > X-Debbugs-Cc: darrell.kavanagh@gmail.com
> > > > > > > > > > >
> > > > > > > > > > > Dear Maintainer,
> > > > > > > > > > >
> > > > > > > > > > > This is a convertable touchscreen tablet/laptop. The rotation sensor
> > > > > > > > > > device
> > > > > > > > > > > ST Microelectronics LSM6DS3TR-C does not work. It is detected via ACPI
> > > > > > > > > > and the
> > > > > > > > > > > sysfs trees are created at
> > > > > > > > > > devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-SMO8B30:00
> > > > > > > > > > > and devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:3c/SMO8B30:00 with
> > > > > > > > > > > symlinks bus/acpi/devices/SMO8B30:00 and bus/i2c/devices/i2c-SMO8B30:00,
> > > > > > > > > > but
> > > > > > > > > > > no driver is loaded.
> > > > > > > > >
> > > > > > > > > At least this is using the ST PNP ID which is better than average
> > > > > > > > > (long story!)
> > > > > > > > >
> > > > > > > > > The driver in question (ultimately drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > > > > > > > > does not currently have an ACPI support.  It should be straight forwards
> > > > > > > > > to add though the driver first needs converting to use
> > > > > > > > > device_get_match_data() with appropriate fallback so that it will match on
> > > > > > > > > ACPI, OF or original spi_device_id tables
> > > > > > > > >
> > > > > > > > > Completely untested but something like the following
> > > > > > > > > (the offset in the enum is needed to allow us to tell if we got a result when
> > > > > > > > > calling device_get_match_data() as it returns NULL on failure IIRC)
> > > > > > > > >
> > > > > > > > > I'm not sure how sucessful the driver will be at finding any interrupts etc, but
> > > > > > > > > it may get you basic functionality.
> > > > > > > > >
> > > > > > > > > Good luck and others more familiar with the driver may well tell me what I forgot
> > > > > > > > > when hacking the below ;)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > > > > > > index 499fcf8875b4..2617ce236ddc 100644
> > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > > > > > > @@ -39,7 +39,7 @@
> > > > > > > > >  #define ST_ISM330IS_DEV_NAME   "ism330is"
> > > > > > > > >
> > > > > > > > >  enum st_lsm6dsx_hw_id {
> > > > > > > > > -       ST_LSM6DS3_ID,
> > > > > > > > > +       ST_LSM6DS3_ID = 1,
> > > > > > > > >         ST_LSM6DS3H_ID,
> > > > > > > > >         ST_LSM6DSL_ID,
> > > > > > > > >         ST_LSM6DSM_ID,
> > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > > > > > > > > index df5f60925260..ecfceb2fb3db 100644
> > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > > > > > > > > @@ -23,10 +23,15 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
> > > > > > > > >
> > > > > > > > >  static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
> > > > > > > > >  {
> > > > > > > > > -       const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > > > > > > > > -       int hw_id = id->driver_data;
> > > > > > > > > +       int hw_id;
> > > > > > > > >         struct regmap *regmap;
> > > > > > > > >
> > > > > > > > > +       hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
> > > > > > > > > +       if (!hw_id)
> > > > > > > > > +               hw_id = i2c_client_get_device_id(client)->driver_data;
> > > > > > > > > +       if (!hw_id)
> > > > > > > > > +               return -EINVAL;
> > > > > > > > > +
> > > > > > > > >         regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
> > > > > > > > >         if (IS_ERR(regmap)) {
> > > > > > > > >                 dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
> > > > > > > > > @@ -129,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
> > > > > > > > >  };
> > > > > > > > >  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> > > > > > > > >
> > > > > > > > > +static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
> > > > > > > > > +       { "SMO8B30", ST_LSM6DS3TRC_ID, },
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
> > > > > > > > >         { ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> > > > > > > > >         { ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
> > > > > > > > > @@ -161,6 +170,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
> > > > > > > > >                 .name = "st_lsm6dsx_i2c",
> > > > > > > > >                 .pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
> > > > > > > > >                 .of_match_table = st_lsm6dsx_i2c_of_match,
> > > > > > > > > +               .acpi_match_table = st_lsm6dsx_i2c_acpi_match,
> > > > > > > > >         },
> > > > > > > > >         .probe_new = st_lsm6dsx_i2c_probe,
> > > > > > > > >         .id_table = st_lsm6dsx_i2c_id_table,
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The device is identifying itself to the kernel with PNP id SMO8B30:
> > > > > > > > > > > physical_node:
> > > > > > > > > > >       modalias=acpi:SMO8B30:SMO8B30:
> > > > > > > > > > >       name=SMO8B30:00
> > > > > > > > > > >       uevent=MODALIAS=acpi:SMO8B30:SMO8B30:
> > > > > > > > > > >       waiting_for_supplier=0
> > > > > > > > > > > firmware_node:
> > > > > > > > > > >       hid=SMO8B30
> > > > > > > > > > >       modalias=acpi:SMO8B30:SMO8B30:
> > > > > > > > > > >       path=\_SB_.PCI0.I2C5.DEV_
> > > > > > > > > > >       status=15
> > > > > > > > > > >       uevent=MODALIAS=acpi:SMO8B30:SMO8B30:
> > > > > > > > > > >       uid=0
> > > > > > > > > > >
> > > > > > > > > > > The kernel module for the appropriate driver (st_lsm6dsx_i2c) is not
> > > > > > > > > > loaded on boot.
> > > > > > > > > > > Modprobing it does not associate it with the device, as I would expect as
> > > > > > > > > > > the module does not provide an alias for the above acpi/pnp id.
> > > > > > > > > >
> > > > > > > > > > Can you report this issue upstream? Gues to reach out are according to
> > > > > > > > > > get_maintainers.pl script:
> > > > > > > > > >
> > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> (maintainer:ST LSM6DSx IMU IIO DRIVER)
> > > > > > > > > > Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS)
> > > > > > > > > > Lars-Peter Clausen <lars@metafoo.de> (reviewer:IIO SUBSYSTEM AND DRIVERS)
> > > > > > > > > > linux-iio@vger.kernel.org (open list:ST LSM6DSx IMU IIO DRIVER)
> > > > > > > > > > linux-kernel@vger.kernel.org (open list)
> > > > > > > > > >
> > > > > > > > > > Please keep us in the loop.
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Salvatore
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>
