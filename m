Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61132608ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJVRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:24:07 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E36D579
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:24:04 -0700 (PDT)
X-KPN-MessageId: 45002d7b-522e-11ed-a5a6-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 45002d7b-522e-11ed-a5a6-005056abbe64;
        Sat, 22 Oct 2022 19:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:mime-version:subject:to:from:message-id:date;
        bh=Yk3WUwgEXK/ftbG/+TOQNLtsRfxptaKVoLAodR6ZxAU=;
        b=G5BsWBd5kIf4L4Hdxgrq+qNrg7jGOsbxyVWMMD0WQ7qbuQsrIWkCBMMT/9wu/ERcC3eXeCDULcMsH
         qvOsgELiG1eyPhrRldSAd1KaW5ADwmGZIPBfX74GcOid+yTuYLV8V8p3nsC2YDJo7JLcwMhIm2wOWI
         CiVEgbXgxvZ4E5gxoSu/WvQY9Rs6QYkvUXCY9injNRB3sgxrnr+UNWTclvKWrUgijz/Ak+2B2B84XW
         xXB6xYmmI3ejNDP42PErPPkud6Zb1GS6BcWpwO9h3D2MflMFhroiUw1e5JHiFYB08Ds39/emUUMqBZ
         RNdQSbK0Fj9uhDr8i+MIbbmb3lifc7A==
X-KPN-MID: 33|vG+2ueq/oE9yyoa89hwPsV6b5YeYfdQhP8lmv9lDeIx321BK/u4DhJJX9OXQrzt
 2xHMNdJfp+IciCIFHKvXD96G5/K3c5Imwge+xZHhPOqM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|p3JDS1kRY3wRJANn5/DaZ5R6BHUf3ejl+FOnZaZVslPu7+FIf1QxMxSrM6R90X0
 hsdPB7WZ0j20BgjINqAVPiQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 5193f0b2-522e-11ed-929c-005056ab1411;
        Sat, 22 Oct 2022 19:24:01 +0200 (CEST)
Date:   Sat, 22 Oct 2022 19:24:00 +0200
Message-Id: <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     megi@xff.cz, heiko@sntech.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, frattaroli.nicolas@gmail.com,
        s.hauer@pengutronix.de, frank-w@public-files.de,
        ezequiel@vanguardiasur.com.ar, yifeng.zhao@rock-chips.com,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
        (message from Peter Geis on Sat, 22 Oct 2022 08:19:57 -0400)
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
References: <20221005085439.740992-1-megi@xff.cz> <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core> <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core> <87edv0sxup.fsf@bloch.sibelius.xs4all.nl> <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peter Geis <pgwipeout@gmail.com>
> Date: Sat, 22 Oct 2022 08:19:57 -0400

Hello Peter,

> On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Fri, 21 Oct 2022 21:32:48 +0200
> > > From: Ondřej Jirman <megi@xff.cz>
> > >
> > > On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> > > > On Fri, Oct 21, 2022 at 11:39 AM Ondřej Jirman <megi@xff.cz> wrote:
> > > > >
> > > > > On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> > > > > > Good Morning Heiko,
> > > > > >
> > > > > > Apologies for just getting to this, I'm still in the middle of moving
> > > > > > and just got my lab set back up.
> > > > > >
> > > > > > I've tested this patch series and it leads to the same regression with
> > > > > > NVMe drives. A loop of md5sum on two identical 4GB random files
> > > > > > produces the following results:
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > > fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> > > > > > 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> > > > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > > > 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> > > > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > > > b9637505bf88ed725f6d03deb7065dab  test-rand.img
> > > > > > f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> > > > > >
> > > > > > Before this patch series:
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > > >
> > > > > > Though I do love where this patch is going and would like to see if it
> > > > > > can be made to work, in its current form it does not.
> > > > >
> > > > > Thanks for the test. Can you please also test v1? Also please share lspci -vvv
> > > > > of your nvme drive, so that we can see allocated address ranges, etc.
> > > >
> > > > Good catch, with your patch as is, the following issue crops up:
> > > > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=16K]
> > > > Region 2: I/O ports at 1000 [disabled] [size=256]
> > > >
> > > > However, with a simple fix, we can get this:
> > > > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=16K]
> > > > Region 2: I/O ports at 1000 [virtual] [size=256]
> > > >
> > > > and with it a working NVMe drive.
> > > >
> > > > Change the following range:
> > > > 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> > > > to
> > > > 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
> > >
> > > I've already tried this, but this unfrotunately breaks the wifi cards.
> > > (those only use the I/O space) Maybe because I/O and memory address spaces
> > > now overlap, I don't know. That's why I used the 1GiB offset for memory
> > > space.
> >
> > Meanwhile, I have an NVMe drive that only works if mmio is completely
> > untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
> > Motion SM2260 controller.
> >
> > So for me, a working configuration has the following "ranges":
> >
> > ranges = <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
> >          <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
> >          <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;
> >
> > This also needs changes to the "reg" propery:
> >
> > reg = <0x3 0xc0000000 0x0 0x00400000>,
> >       <0x0 0xfe260000 0x0 0x00010000>,
> >       <0x3 0x00000000 0x0 0x10000000>;
> 
> Now this is interesting. I've been reading up on PCIe ranges and what
> is necessary for things to work properly, and I found this interesting
> article from ARM:
> https://developer.arm.com/documentation/102337/0000/Programmers-model/Memory-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions
> 
> TLDR: We need a low region (below 4g) and a high region.

Well, that description applies to a specific ARM reference design.
And it appears that the PCIe-RC used in that reference design does not
support address translation.

The Synopsys DesignWare PCIe-RC implementation used on the RockChip
RK35xx SoCs does support address translation.  But some of the results
we're seeing suggests that this feature is subtly broken for the
RockChip implementation.

> >From other articles I've gleaned that the config / io should probably
> also be in the low range. As such I believe the other patch that was
> sent to me may be the correct way to go. If both of you would try the
> following reg / ranges:
> 
> reg = <0x3 0xc0000000 0x0 0x00400000>,
>       <0x0 0xfe260000 0x0 0x00010000>,
>       <0x0 0xf4000000 0x0 0x00100000>;
> 
> ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
> <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
> <0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;

So that matches the configuration used by RockChip in their downstream
kernel and u-boot:

  https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2382

That probably means this config has received testing in the wild.

I tried this configuration on my board during my earlier experiments,
and it works.

One downside of this configuration is that it uses 32-bit IO
addresses.  Support for 32-bit IO address is not universal since the
x86 INB and OUTB instructions only support a 16-bit address space.
But if translation is indeed broken for IO in the same way as MMIO,
that might be the best you can do.

> > Now admittedly, this is with OpenBSD running on EDK2 UEFI firmware
> > from
> >
> >   https://github.com/jaredmcneill/quartz64_uefi
> >
> > that I modified to pass through the device tree and modify the ranges
> > as above.  But the way my OpenBSD driver sets up the address
> > translation windows matches what the mainline Linux driver does.
> >
> > I picked the ranges above to match the EDK2 configuration.  But it is
> > a setup that maximizes the 32-bit mmio window.
> >
> > Cheers,
> >
> > Mark
> >
> > > > I still haven't tested this with other cards yet, and another patch
> > > > that does similar work I've tested successfully as well with NVMe
> > > > drives. I'll have to get back to you on the results of greater
> > > > testing.
> > > >
> > > > Very Respectfully,
> > > > Peter Geis
> > > >
> > > > >
> > > > > kind regards,
> > > > >         o.
> > > > >
> > > > > > Very Respectfully,
> > > > > > Peter Geis
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
