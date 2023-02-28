Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7566A60C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB1UxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjB1UxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:53:17 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43E129
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:53:13 -0800 (PST)
X-KPN-MessageId: e59fbc5a-b7a9-11ed-afdd-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id e59fbc5a-b7a9-11ed-afdd-005056abad63;
        Tue, 28 Feb 2023 21:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=fudN8ArySQL4WxjTN7QCK9yq0lwyu6+8SisGWmyX75Q=;
        b=m0ZY7+3tWMyJ6mV02HESHr2l1pOW5Ed2enycOSfnmV68NXwwPvx7n9SY1s3xRXdYdOjYL7Dv/5yrv
         IhOeKbwTQIp72Feoe0LUy3d29YrgAvnEZBqhQ/dlBpN6hr9KPwU7blmQa5NvrTpZsPJvY8kAEv2+vB
         NzMiglvb/olKTnwU2wUOiGZEreeC85bnHBRdVOJfHs7SPJX8+2snqtE2gIM9F71Vk2oAKLP+OqsyP8
         +aeVRILBb2ua33Nqj4D6gZN5G25yhofl0WKz66g7r5ty9dXV8K8bpV0JAs3av9Qb7jotSDD42iVvtv
         LYTRJP3kGQmaiQY13/JhbDYVU2mkOjQ==
X-KPN-MID: 33|qw/opIog0L/9cUv1FdHJALWLJ+GSjGOJs5JQpYZ1ewEddOVHknQ7JqPBIPb5etM
 nyGMcY1SMzXWUySHwK25A7xcOIn3ik4pRV0KxPF4B7Hg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TyyRfy9x8DGtrDcN80aGHcz+FyBiGyfilCur4PWFuaPgwVH2U9q9D9JZDF365RQ
 5+Y79MNe1fW0b87u+FQle2A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id e836b37c-b7a9-11ed-ab4c-005056ab7447;
        Tue, 28 Feb 2023 21:53:10 +0100 (CET)
Date:   Tue, 28 Feb 2023 21:53:09 +0100
Message-Id: <87wn41qzpm.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, fnkl.kernel@gmail.com, alyssa@rosenzweig.io,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, asahi@lists.linux.dev,
        rydberg@bitmath.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1874e194-5210-460b-3e8f-0f48962f8a47@marcan.st> (message from
        Hector Martin on Tue, 28 Feb 2023 11:58:28 +0900)
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
 <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
 <e6c7eb27-1b60-4894-a623-28ca3bccdea5@app.fastmail.com> <1874e194-5210-460b-3e8f-0f48962f8a47@marcan.st>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 28 Feb 2023 11:58:28 +0900
> From: Hector Martin <marcan@marcan.st>
> 
> On 24/02/2023 20.08, Sven Peter wrote:
> > Hi,
> > 
> > 
> > On Fri, Feb 24, 2023, at 12:04, Sasha Finkelstein wrote:
> >> On Fri, 24 Feb 2023 at 11:55, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >>
> >>> What is the motivation for including the firmware name in the device
> >>> tree rather than constructing it in the driver like what is done for
> >>> the broadcom wireless?
> >> There is no way to identify the device subtype before the firmware is
> >> uploaded, and so i need some way of figuring out which firmware to use.
> > 
> > Some Broadcom bluetooth boards use the compatible of the root node (see
> > btbcm_get_board_name in drivers/bluetooth/btbcm.c) which would be "apple,jXXX"
> > for Apple Silicon. I believe the Broadcom WiFi driver has similar logic as well
> > which marcan had to extend to instead of "brcm,board-type" because different
> > WiFi boards can me matched to different Apple Silicon boards. I don't think
> > that's the case for this touchscreen though.
> 
> The reason why the brcmfmac stuff needs to construct the firmware name
> itself is that parts of it come from the OTP contents, so there is no
> way to know from the bootloader what the right firmware is.

The name of the "nvram" file is constructed as well, and that uses the
compatible of the machine (the root of the device tree).  I suppose
what is special in that case is that several files are tried so a
single 'firmware-name" property wouldn't cut it.

> That is not the case here, so it makes perfect sense to specify the
> firmware with `firmware-name` (which is a standard DT property).

It certainly provides the flexibility to cater for all potential
nonsense names Apple comes up with for future hardware.

> As for the layout, both bare names and paths are in common use:
> 
> qcom/sm8450-qrd.dts:    firmware-name = "qcom/sm8450/slpi.mbn";
> ti/k3-am64-main.dtsi:   firmware-name = "am64-main-r5f0_0-fw";
> 
> ... but the bare names in particular, judging by some Google searches,
> are *actually* mapped to bare files in /lib/firmware anyway. So the
> firmware-name property contains the firmware path in the linux-firmware
> standard hierarchy, in every case.

Well, I think the device tree should not be tied to a particular OS
and therefore not be tied to things like linux-firmware.

> I already did the same thing for the touchpad on M2s (which requires
> analogous Z2 firmware passed to it, just in a different format):
> 
> dts/apple/t8112-j413.dts: firmware-name = "apple/tpmtfw-j413.bin";
> 
> Why is having a directory a problem for OpenBSD? Regardless of how
> firmware is handled behind the scenes, it seems logical to organize it
> by vendor somehow. It seems to me that gratuitously diverging from the
> standard firmware hierarchy is only going to cause trouble for OpenBSD.
> Obviously it's fine to store it somewhere other than /lib/firmware or
> use a completely unrelated mechanism other than files, but why does the
> *organization* of the firmware have to diverge? There can only be one DT
> binding, so we need to agree on a way of specifying firmwares that works
> cross-OS, and I don't see why "apple/foo.bin" couldn't be made to work
> for everyone in some way or another.

We organize the firmware by driver.  And driver names in *BSD differ
from Linux since there are different constraints.  The firmware is
organized by driver because we have separate firmware packages for
each driver that get installed as-needed by a tool that matches on the
driver name.

Rather than have the device tree dictate the layout of the firmware
files, I think it would be better to have the OS driver prepend the
directory to match the convention of the OS in question.  This is what
we typically do in OpenBSD.

Now I did indeed forget about the "dockchannel" touchpad firmware that
I already handle in OpenBSD.  That means I could handle the touchbar
firmware in the same way.  But that is mostly because these firmwares
are non-distributable, so we don't have firmware packages for them.
Instead we rely on the Asahi installer to make the firmware available
on the EFI partition and the OpenBSD installer to move the firmware in
place on the root filesystem.

So this isn't a big issue.

Cheers,

Mark
