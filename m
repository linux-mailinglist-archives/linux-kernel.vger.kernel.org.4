Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1B608D24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJVMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJVMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:20:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7563D1F;
        Sat, 22 Oct 2022 05:20:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so8726450wrt.11;
        Sat, 22 Oct 2022 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqgQmpthFtTKMqinrF6XH8lDGi0vzOcHTbCq+06suV8=;
        b=XYsOqslHc6NB/IZUEoGoi6//b5rrjvV+2ZXq08K6CfW2wDN2jLqQxqdEbXhHLHqkVR
         HUsOWkz5Oih7hTLO/sMyGeuuW6NtpMSSxK7lNwT0V9IjZduTcSV53hV/d30gOG/5Wez5
         +EwFg38ucmAH60wvhugz4gV9+l0Fy17HEe28GSbYE98jRidroXcYK0eSmSOXDTKFtx/i
         L2w/8B8thwK/bYWxHyR15mTLhJ8fFGvEN6GLGnJe8M6vvQPCbeF5xlZF1fZa4nE1+BSo
         6K4r9yMfRro7s6mB2dO7DKIHjlrAxF0/QZmrKYbBPIlgOvr0Y2C0+XIRZts/MFqL8zEh
         bwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqgQmpthFtTKMqinrF6XH8lDGi0vzOcHTbCq+06suV8=;
        b=zMbxZv5wiDBenG5EglKQAGVO6d8uhJ3qdhlvG+JA4K9JVsa4scMsjtMQD+AELu7DM+
         3WqM1hjQ5H/qQEFPB7MRGGec/ut5t7bq7Dd7fj312Sv01JXMb3txTt94lqBj3fWfDZUo
         vpr6t5V1vUHVEEIjxeWqqyQkecdC0iYWQkWpgs1mMXMTsSc9TFtjGaiDLu1l9QKUcBSk
         dTgz/c1ikuq+iZMwneUC2SlbxicmJ+Bo9Oc7DSzvb3B6mC2g7OTr4wUP/gyqXVLzNRcf
         rsm2U8qHYTXh3e9oR4BXExwwMXsJBiyGEvlkqSpXQBEzyIkX/WTkfewu7auOtR7Cb/3f
         +PXw==
X-Gm-Message-State: ACrzQf2rp4sbkVSjUDRUFS9MPkvLc8aV8wQ6oEmFQoB2EE1ntvUyiy1d
        ZPRa3DYK/GVP/e6Yp0FMkbehi3pOY/2Xn7Hkal4=
X-Google-Smtp-Source: AMsMyM7aEBBWfrqZ6s3SgA9CgPBVd+S3cBD8nocD48HeBNF1UcEzyFY++aYpR2vMTpBrY/NFqSqUL/WjhFGOkIKcJIY=
X-Received: by 2002:a5d:42c6:0:b0:235:1b3a:8d2e with SMTP id
 t6-20020a5d42c6000000b002351b3a8d2emr9784028wrr.689.1666441209297; Sat, 22
 Oct 2022 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221005085439.740992-1-megi@xff.cz> <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core> <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core> <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 22 Oct 2022 08:19:57 -0400
Message-ID: <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael.riesch@wolfvision.net,
        frattaroli.nicolas@gmail.com, s.hauer@pengutronix.de,
        frank-w@public-files.de, ezequiel@vanguardiasur.com.ar,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl> wro=
te:
>
> > Date: Fri, 21 Oct 2022 21:32:48 +0200
> > From: Ond=C5=99ej Jirman <megi@xff.cz>
> >
> > On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> > > On Fri, Oct 21, 2022 at 11:39 AM Ond=C5=99ej Jirman <megi@xff.cz> wro=
te:
> > > >
> > > > On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> > > > > Good Morning Heiko,
> > > > >
> > > > > Apologies for just getting to this, I'm still in the middle of mo=
ving
> > > > > and just got my lab set back up.
> > > > >
> > > > > I've tested this patch series and it leads to the same regression=
 with
> > > > > NVMe drives. A loop of md5sum on two identical 4GB random files
> > > > > produces the following results:
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> > > > > 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> > > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > > 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> > > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > > b9637505bf88ed725f6d03deb7065dab  test-rand.img
> > > > > f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> > > > >
> > > > > Before this patch series:
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > >
> > > > > Though I do love where this patch is going and would like to see =
if it
> > > > > can be made to work, in its current form it does not.
> > > >
> > > > Thanks for the test. Can you please also test v1? Also please share=
 lspci -vvv
> > > > of your nvme drive, so that we can see allocated address ranges, et=
c.
> > >
> > > Good catch, with your patch as is, the following issue crops up:
> > > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=3D16K]
> > > Region 2: I/O ports at 1000 [disabled] [size=3D256]
> > >
> > > However, with a simple fix, we can get this:
> > > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [s=
ize=3D16K]
> > > Region 2: I/O ports at 1000 [virtual] [size=3D256]
> > >
> > > and with it a working NVMe drive.
> > >
> > > Change the following range:
> > > 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> > > to
> > > 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
> >
> > I've already tried this, but this unfrotunately breaks the wifi cards.
> > (those only use the I/O space) Maybe because I/O and memory address spa=
ces
> > now overlap, I don't know. That's why I used the 1GiB offset for memory
> > space.
>
> Meanwhile, I have an NVMe drive that only works if mmio is completely
> untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
> Motion SM2260 controller.
>
> So for me, a working configuration has the following "ranges":
>
> ranges =3D <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
>          <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
>          <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;
>
> This also needs changes to the "reg" propery:
>
> reg =3D <0x3 0xc0000000 0x0 0x00400000>,
>       <0x0 0xfe260000 0x0 0x00010000>,
>       <0x3 0x00000000 0x0 0x10000000>;

Now this is interesting. I've been reading up on PCIe ranges and what
is necessary for things to work properly, and I found this interesting
article from ARM:
https://developer.arm.com/documentation/102337/0000/Programmers-model/Memor=
y-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions

TLDR: We need a low region (below 4g) and a high region.

From other articles I've gleaned that the config / io should probably
also be in the low range. As such I believe the other patch that was
sent to me may be the correct way to go. If both of you would try the
following reg / ranges:

reg =3D <0x3 0xc0000000 0x0 0x00400000>,
      <0x0 0xfe260000 0x0 0x00010000>,
      <0x0 0xf4000000 0x0 0x00100000>;

ranges =3D <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
<0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
<0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;

Very Respectfully,
Peter Geis

>
> Now admittedly, this is with OpenBSD running on EDK2 UEFI firmware
> from
>
>   https://github.com/jaredmcneill/quartz64_uefi
>
> that I modified to pass through the device tree and modify the ranges
> as above.  But the way my OpenBSD driver sets up the address
> translation windows matches what the mainline Linux driver does.
>
> I picked the ranges above to match the EDK2 configuration.  But it is
> a setup that maximizes the 32-bit mmio window.
>
> Cheers,
>
> Mark
>
> > > I still haven't tested this with other cards yet, and another patch
> > > that does similar work I've tested successfully as well with NVMe
> > > drives. I'll have to get back to you on the results of greater
> > > testing.
> > >
> > > Very Respectfully,
> > > Peter Geis
> > >
> > > >
> > > > kind regards,
> > > >         o.
> > > >
> > > > > Very Respectfully,
> > > > > Peter Geis
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
