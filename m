Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE37686B50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjBAQNN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBAQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:12:54 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2D790B8;
        Wed,  1 Feb 2023 08:12:23 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 41C6D4000B;
        Wed,  1 Feb 2023 16:12:19 +0000 (UTC)
Message-ID: <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Feb 2023 17:12:19 +0100
In-Reply-To: <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
         <Y9WGmBc9HG4Tx9gf@eldamar.lan>
         <CAMxBKG1670TFuV3nHP7Yk8s6H+oBF7iiyiB-b=PvKv9hcH22xQ@mail.gmail.com>
         <20230129182441.082f29d0@jic23-huawei>
         <CAMxBKG0tyLSpaDPGBXsJbqgHSG9rH6owtSJsLw_ekmTA3Kyvdw@mail.gmail.com>
         <CAMxBKG3zL_yvw=dHK+Gqd3EHWzvJmiLHVvKnf6UsYbMgcS6nrg@mail.gmail.com>
         <20230130123113.00002c3f@Huawei.com>
         <CAMxBKG3xOEj1gEs9pGzKb+rDjTLPqAq1YOp4bEFas4tQMzGZ+Q@mail.gmail.com>
         <20230130173525.0000418d@huawei.com>
         <CAMxBKG1yKcodDD2kvfwKvpYnPrXmgaOk9rTztRPFzKMCZ5F=tA@mail.gmail.com>
         <20230130194110.256144e7@jic23-huawei>
         <CAMxBKG3S6aJSrO-BAPCAhVpg2qF2kWfRJ9d0n2EmOY=JGNid-A@mail.gmail.com>
         <20230130203110.60c96f37@jic23-huawei>
         <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
         <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
         <20230201102824.00002044@Huawei.com>
         <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/1/23 11:28, Jonathan Cameron wrote:
> > On Wed, 1 Feb 2023 01:40:49 +0000
> > Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
> > 
> > > Hello, all.
> > > 
> > > I've finally reached a conclusion on this, after testing all the
> > > combinations of the patches (with and without reading the acpi
> > > mounting matrix), window managers (wayland, xorg) and the
> > > presence or
> > > not of my custom kernel parms.
> > > 
> > > What works well is the full set of patches with the custom kernel
> > > parms and a new hwdb entry for the sensor:
> > > 
> > > sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
> > >  ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, 1
> > > 
> > > The autorotate then works correctly in wayland and xorg, but for
> > > xorg,
> > > the settings say the screen is "portrait left" when in actual
> > > fact it
> > > is in standard laptop landscape orientation. Wayland does not
> > > have
> > > this problem (I guess because wayland's view of the screen is
> > > straight
> > > from the kernel).
> > > 
> > > Without the hwdb entry, the orientation is 90 degrees out without
> > > using the acpi matrix and 180 degrees out when using it. I could
> > > have
> > > gone either way here with appropriate hwdb entries, but my view
> > > is
> > > that we *should* be using the matrix.
> > 
> > Added Hans de Goede as he has probably run into more of this mess
> > than anyone else.  Hans, any thoughts on if we are doing something
> > wrong on kernel side?  Or is the matrix just wrong *sigh*
> 
> I see below that this laptop has a panel which is mounted 90 degrees
> rotated, that likely explains why the ACPI matrix does not work.
> So the best thing to do here is to just override it with a hwdb
> entries.
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
> handles this special case of 90° rotated screen + ROTM. Or the
> matrix in the ACPI tables could be just wrong...
> 
> > I think 'ROTM' is defined by MS. 
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
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
> > > The only thing that concerns me is the need for custom kernel
> > > parms.
> > > It would be better if there was a way to avoid this, so that the
> > > user
> > > didn't have to mess around with their grub config. Though having
> > > said
> > > that, the sensors fix as we have it doesn't make things worse -
> > > under
> > > currently released kernels the screen always starts up sideways
> > > unless
> > > custom parms are added in grub.
> 
> We actually have a quirk mechanism in the kernel for specifying
> the need for: video=DSI-1:panel_orientation=right_side_up  and this
> will also automatically fix the fbcon orientation, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
> 
> If you submit a patch for this upstream please Cc me.

And if after that change, and copy/pasting the orientation from the
DSDT into hwdb the sensor and screen move in the expected ways, then
maybe stealing the BMC150 driver's
bmc150_apply_bosc0200_acpi_orientation() might be a good idea.

Once exported through "mount_matrix", iio-sensor-proxy should see it
and read it without the need for a hwdb entry.

Cheers
