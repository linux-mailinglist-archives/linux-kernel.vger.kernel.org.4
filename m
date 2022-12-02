Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23106406F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiLBMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiLBMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:38:27 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3634862D9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:38:25 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 3so3629072vsq.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpHQC82mnYuGSSmXNbnPG/k0eA2/UTot6BKCSyH04r0=;
        b=OGiGQ3KnajQxzDYURCgWvDeq6WSwDywJc+oMl6PI8zoHs2VBV2cLOIaJK6Hnm7CfTO
         H92PaSIqPFX4hd53s7KST8EGrcqWKeiS04ABzylhDrWqd+ai1Cq6XDsXal9d2NQJwSjW
         Fnk0I2DRlWi9Uz+iVWfm7Tc4gRUOv6wM0IP2GtQkKlWOLnwR1qpDob770vzZH7Gyl3Sy
         SOPsFyTaK3zbjUN2qRhkVVgG+0s5q4PGP7KVK5IqOHjf30aFQI2lBkszqTtPDhEKIEPb
         /aQ9/5p4fgtKWZfZ2JmYMAnRkV5jAVdx6kbA9wM7phTKtoOscZTOsL7KwgRbImuMbXJv
         BgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpHQC82mnYuGSSmXNbnPG/k0eA2/UTot6BKCSyH04r0=;
        b=czmAGe+7jIjtu9iTmpgZG1U7Jq4S2Wuu9bsOFKpcPmd6t1xaOH1A4ZRn6S3pVa2WlH
         Km/3tTVOd5vgpS6JE3l4E2PptEwY5IkpErzqCgzh6XPWevBlGU+w2tO78hPMvs5epkzW
         6Qm1LuRXHUoVp5uWVs3oYzwrFRYV2DZiHfn9DUplWXUmPJce1gHdaK7T3f+7VKZvxv++
         7zeFJr0vuLC81U68nHUxcIXsS9AeDRQzDZEUzhovq0BtS1zZL1e+Yx+ClQbaA9QnS2/T
         m1EG+AF4a+Jn2Acprk0Nmliqy+jO5HGG75KQgAda9FMrXriimE4gGEAbIBzzwODZ0bAn
         oirg==
X-Gm-Message-State: ANoB5pmlr8bW1JDOp0MSuoxbe/XrOBCZAL74cDBveKyOQx1CBilT9qAp
        O1e3NUd3kZPYW6aHwee5KDcpWTzzExiN2xP6j5i7wQ==
X-Google-Smtp-Source: AA0mqf5buBeWavYJ/x/Sbqvg6jCag/SLZnNAWiNrSeDs8FvdmJ7coTZXwlA3LnbwMv/DGwkZiJSA8RcFwndGqWDleko=
X-Received: by 2002:a05:6102:3bcf:b0:3aa:236e:345d with SMTP id
 a15-20020a0561023bcf00b003aa236e345dmr38278019vsv.45.1669984704697; Fri, 02
 Dec 2022 04:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com> <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
 <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com> <c73f7261-ec33-ec88-df3e-a34cf9b8015c@ideasonboard.com>
 <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com> <910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonboard.com>
 <Y4nCnEwqs69QezPn@pendragon.ideasonboard.com> <CAPY8ntAK9yh6ZQkuOrZqUn2GC2=qGaJrcxEjWyGep7KcWvxkhQ@mail.gmail.com>
 <Y4nrPuq0OjWKCzfS@pendragon.ideasonboard.com>
In-Reply-To: <Y4nrPuq0OjWKCzfS@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 2 Dec 2022 12:38:09 +0000
Message-ID: <CAPY8ntB4koO2+uScWhFmXZdpuFCqPebgcWWGv3Yaz_eVC0ML5A@mail.gmail.com>
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Fri, 2 Dec 2022 at 12:10, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Dave,
>
> On Fri, Dec 02, 2022 at 11:23:29AM +0000, Dave Stevenson wrote:
> > On Fri, 2 Dec 2022 at 09:17, Laurent Pinchart wrote:
> > > On Fri, Dec 02, 2022 at 11:57:18AM +0800, Umang Jain wrote:
> > > > On 12/2/22 6:45 AM, Stefan Wahren wrote:
> > > > > Am 30.11.22 um 11:58 schrieb Umang Jain:
> > > > >> On 11/27/22 6:56 AM, Stefan Wahren wrote:
> > > > >>> Am 26.11.22 um 17:26 schrieb Umang Jain:
> > > > >>>> On 11/26/22 8:12 PM, Stefan Wahren wrote:
> > > > >>>>> Am 21.11.22 um 22:47 schrieb Umang Jain:
> > > > >>>>>> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
> > > > >>>>>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
> > > > >>>>>> receiver IP core("Unicam) + the ISP driver found in BCM283x and compatible
> > > > >>>>>> SoCs (namely BCM2711). Unicam is still under active development to work
> > > > >>>>>> with multistream support to get into mainline. Hence only the ISP driver
> > > > >>>>>> will remain the primary area of this series.
> > > > >>>>>
> > > > >>>>> thanks for working on this. But honestly i would prefer that vchiq
> > > > >>>>> comes out of staging before adding more features. As Greg said
> > > > >>>>> some time ago staging is not a place to "dump code and run away".
> > > > >>>>> These new files are in the same bad shape as the rest of vc04
> > > > >>>>> before the clean-up here in staging started.
> > > > >>>>
> > > > >>>> Certainly, I am not here to do that - but I am still learning the ropes.
> > > > >>>
> > > > >>> no problem.
> > > > >>>
> > > > >>>> If the staging issue is becoming a blocker for bcm2835-isp going
> > > > >>>> upstream, I would be happy to help here! Though I must mention that
> > > > >>>> I still have limited visibility so my aim would be to chart out a
> > > > >>>> plan of things needed to be done to get vc04_services out of staging!
> > > > >>>
> > > > >>> The vchiq driver is in staging since 2016, so every step forwards is
> > > > >>> good. Unfortunately all of the low hanging fruits has been gathered.
> > > > >>>
> > > > >>> For me the most important, but not to tricky steps to get vchiq out
> > > > >>> of staging would be:
> > > > >>>
> > > > >>> * Cleanup logging mechanism
> > > > >>>
> > > > >>> * Get rid of custom function return values
> > > > >>>
> > > > >>> There was already an attempt for this [1]
> > > > >>>
> > > > >>> * Get rid of all non essential global structures and create a proper per
> > > > >>> device structure
> > > > >>>
> > > > >>>>> I agree that VCSM is on the TODO list for vchiq, but this driver
> > > > >>>>> is not necessary for making bcm2835-audio & bcm2835-camera leave
> > > > >>>>> staging. It just binds more resources on a new feature.
> > > > >>
> > > > >> bcm2835-camera is the legacy camera stack which probably need to be
> > > > >> dropped from hereon...
> > > > >
> > > > > I don't not know if there any users left, so i would be careful here.
> > > > > Can bcm2835-isp completely replace bcm2835-camera? Sorry, for this
> > > > > dumb question but i'm not expert here.
> > > >
> > > > I am careful too here and probably need Input from RaspberryPi in order
> > > > to proceed to drop it. But from my perspective - bcm2835-camera is _not_
> > > > going out of staging - it'll either sit here (or probably dropped) as
> > > > statied from [1]
> > > >
> > > > ```
> > > > + * There are two camera drivers in the kernel for BCM283x - this one
> > > > + * and bcm2835-camera (currently in staging).
> > > > ```
> > > >
> > > > The bcm2835-camera is meant to be replaced by unicam [1] , but the ISP
> > > > (bcm2835-isp) is meant to be worked with unicam [1]. In fact, I have
> > > > mentioned in my cover the testing of bcm2835-isp happened on top of
> > > > unicam patches.
> > >
> > > To be accurate, the bcm2835-camera driver supports the VC4
> > > firmware-based camera stack. In that setup, the camera sensors (OV5647
> > > or IMX219), CSI-2 receiver (Unicam) and ISP are all controlled by the
> > > firmware, which provides a high-level interface towards the kernel. This
> > > architecture has been replaced by Linux-side control of the camera
> > > sensors (through existing drivers in drivers/media/i2c/), Unicam
> > > (through the driver from [1]) and ISP (through this driver). Moving
> > > control to the Linux side requires complex processing in userspace,
> > > handled by libcamera.
> > >
> > > bcm2835-camera is thus replaced by multiple drivers combined with
> > > libcamera, and that is the camera stack that is shipped by Raspberry Pi
> > > these days. While this may affect some userspace use cases), we will not
> > > work on destaging bcm2835-camera, and as far as I'm aware, nobody else
> > > is planning to do so either. I don't mind much if the driver stays in
> > > staging for some more time, but I'd rather drop it if possible.
> >
> > It would be reasonable to drop it at the point that Libcamera can work
> > to a similar level with at least the following list of applications:
> > - FFmpeg
> > - Gstreamer
> > - Chromium
> > - Firefox
> > - Motion
> > And that still leaves a huge number of existing V4L2 apps out in the cold.
>
> That's exactly the kind of input we were looking for, thanks.

Please note that those are only the 5 major ones that came immediately
to mind as having significant numbers of users. There are obviously
many more V4L2 apps around which currently "just work" if they use the
API correctly.

> GStreamer is already addressed.
>
> Chromium and Firefox will go through PipeWire. There is a working
> implementation in libwebrtc, Kieran may be able to comment on the
> upstreaming state. It will take some time for distributions to switch,
> and I can't predict the time line, but that seems to clearly be the
> direction the Linux desktop is taking.
>
> I haven't looked at FFmpeg yet (maybe someone has ?). It probably makes
> sense to add native libcamera support to FFmpeg, even if PipeWire
> support could also make sense. It could also make sense to expose in the
> libcamera V4L2 compat layer the libv4l2 API functions, as that would
> allow linking FFmpeg (when compiled with CONFIG_LIBV4L2) to libcamera
> instead of libv4l2, but Debian doesn't set CONFIG_LIBV4L2, so this isn't
> an immediate solution to the problem.

Native would be nice in my book, but isn't always as straightforward.

> Same thing for motion, except it has no libv4l2 support. The V4L2 compat
> layer could still be used with LD_PRELOAD, but that's not a great
> solution. Native libcamera support would make more sense (or possibly
> even GStreamer support, I don't know if upstream would accept that).

The main bit missing with the compat layer is controls. AIUI fixing
that isn't a priority.
Things like Motion being used for security purposes need to be able to
set properties like exposure modes in order to achieve usable images
under changing lighting conditions.

> In a side note, how do the above applications work today on Raspberry Pi
> platforms that use a sensor not supported by the legacy camera stack ?

They don't for raw sensors, but do work with USB webcams.
Raspberry Pi have sold camera modules since 2013 (OV5647), with v2
(IMX219) coming along in 2016, and HQ (IMX477) in 2020. Linux has only
had frameworks to sensibly support raw image sensors since libcamera
came on the scene around 2019.

> > Do you wish to make any predictions as to when that would be
> > achievable? Or even when a v1.0 release of libcamera is going to
> > happen?
>
> Now that we have started tagging releases, we've also decided to publish
> a roadmap with the development still needed to stabilize the API. We'll
> likely start working on it this month.
>
> > Dropping anything prior to those points would be rather premature in my book.
>
> Something I forgot to mention is that there should be no issue at all
> keeping bcm2835-camera fully supported in the Raspberry Pi downstream
> kernel for a longer period of time. It's in upstream that I don't think
> it should be destaged, as it's already considered legacy and should be
> phased out. Do you know if there are users of that driver with a
> mainline kernel ?

There are a number of distros that use mainline kernels rather than
our vendor kernel. I don't follow distros in detail, but I believe
both Gentoo and Opensuse fall into that category.
 Any users of the camera module under those will be using the mainline
bcm2835-camera module. I have no stats for who uses those on a Pi.

> > The TODOs on bcm2835-camera are:
> > 1) Zero copy. That comes almost for free as bcm2835-isp already does
> > this, but it does rely on vcsm-cma.
> > The main reason I haven't pushed it is that it then requires
> > reasonable amounts of CMA heap for all the buffers, which until
> > recently haven't been present in the default configurations. With the
> > vc4 DRM driver now being default (at least for the vendor kernel) and
> > also requiring CMA, making the change makes more sense.
> > AFAIK there is no easy way to have one driver choosing between using
> > vb2_vmalloc_memops and vb2_dma_contig_memops at runtime, but I may be
> > wrong.
>
> Some drivers use a module parameter for that, but that's not great.

I had thought of a module parameter, but it becomes yet another
configuration thing to get incorrectly set.
Perhaps Kconfig based on the setting for CMA_SIZE_MBYTES, but that can
be overridden.

  Dave

> > Actually bcm2835_defconfig appears to only allocate a 32MB CMA heap,
> > so perhaps we don't get very far.
> >
> > 2) This isn't workable within the current V4L2 frameworks. The
> > multi-planar V4L2 pixel formats are currently allocated as independent
> > buffers for each plane, whereas the firmware needs a single buffer
> > with (currently) specific offsets for the chroma planes. The
> > V4L2/videobuf2 core changes required to implement that are going to be
> > significant, and have minimal gain.
> > The specific stride handling is already dealt with (set bytesperline
> > appropriately), it's the padding of the height to a multiple of 16
> > before the chroma planes on YUV420 and NV12 formats that require the
> > firmware to do a small amount of repacking. The performance hit is
> > actually minimal anyway.
> >
> > If bcm2835-camera is the only thing holding back vc04_services, then I
> > can have a look at it.
>
> I'll let Umang comment on whether it's holding vc04_services back, but
> my understanding it that we could destage vc04_services while keeping
> bcm2835-camera in staging for the time being. If anyone disagrees with
> that, please let me know.
>
> > > > [1]: https://lore.kernel.org/linux-media/20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com/
> > > >
> > > > >>>>
> > > > >>>> I see two TODO files in vc04_services:
> > > > >>>>     ./bcm2835-camera/TODO
> > > > >>>>     ./interface/TODO
> > > > >>>>
> > > > >>>> One of the bcm2835-camera TODO points to the vc-sm-cma driver
> > > > >>>> itself. So that's address in the series. The other remaining one -
> > > > >>>> I will need to take a deeper look before commenting on it.
> > > > >>>>
> > > > >>>> The main chunk of TODO are in vc04_services/interfaces/TODO. Doing
> > > > >>>> a cursory reading of them suggests that these apply to *all*
> > > > >>>> vc04_services components? Am I right?
> > > > >>>
> > > > >>> Actually these applies just for the interfaces directory. Some of
> > > > >>> them could apply to the services, but this is no priority.
> > > > >>
> > > > >> By no priority, you mean this doesn't affect the criteria required to
> > > > >> ful-fill to get these out of staging?
> > > > >
> > > > > Correct
> > > > >
> > > > >>>> Are these are the specific bits of cleanup you are referring to in
> > > > >>>> your comment?
> > > > >>>
> > > > >>> You mean about bcm2835-isp? There were too many changes to vchiq
> > > > >>> that i don't remember them all. The first that come to my mind was
> > > > >>> those fancy comment sections which is not kernel coding style. It
> > > > >>> has been removed.
> > > > >>
> > > > >> No, I don't mean the bcm2835-isp changes (those are upcoming /
> > > > >> out-of-tree still so...). I mean what are the specific bits / points
> > > > >> that needs to be addressed to get vc04_services out of the staging.
> > > > >
> > > > > These were the points which i mentioned in my last email. They came
> > > > > from interface/TODO.
> > > > >
> > > > >> You have mentioned it above now, so I'll follow up on those.
> > > > >
> > > > > That would be great :)
> > > > >
> > > > >> The many vchiq changes you referred to above comment (that you don't
> > > > >> remember) are from [1] as well or some other series ?
> > > > >
> > > > > Sorry, for the confusing. The many changes i refer were the dozens of
> > > > > clean up patches for vc04_interfaces in mainline staging since the
> > > > > last years. [1] was just a single patch which has been accepted yet.
> > > >
> > > > Ah I see. There are many others that I've to dig out then. Thanks for
> > > > clarifying!
> > > >
> > > > >>> [1] -
> > > > >>> https://lore.kernel.org/linux-staging/20220712181928.17547-1-jslebodn@redhat.com/
> > > > >>>
> > > > >>>>> Unfortuntately i hadn't much time to work on vchiq by myself.
> > > > >>>>>
> > > > >>>>> Just my two cents
> > > > >>>>> Stefan
>
> --
> Regards,
>
> Laurent Pinchart
