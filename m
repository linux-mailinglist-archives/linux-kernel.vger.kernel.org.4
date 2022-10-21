Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B260805B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJUUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJUUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:53:56 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 13:53:53 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB129308A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:53:53 -0700 (PDT)
X-KPN-MessageId: 5141e0bc-5182-11ed-8a67-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 5141e0bc-5182-11ed-8a67-005056ab378f;
        Fri, 21 Oct 2022 22:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:mime-version:subject:to:from:message-id:date;
        bh=gN+fxEN+sI/NM9jJbo91XIBZLZT4vKCHuLcB2qD6MVo=;
        b=Ljpjv8U02EhEC/Cz3VWqjtUs0I3JGdXrIPYpjKWBzgrolb9eUn4nZSlJDkC1xsMAULRnNW9pUokbp
         V0+epNxT/HDMJFo2Stmp3vubE0Cp+hk4QNeQCE7nUBMyqjUpHk++bDMqyHC/WenjTGGQYrlfVE7908
         t4dnCoG6q/LYEyXLKFzJ6/ydKqzVN3Mo8RXlhIH05UpbJjxNHaurP99XKbkTW1JAMeFgX56PMsaon5
         /8C9IBXWccJbS2dvf8yd6lTT3VVnNnk8gG0rLM2iJzCWFJdNxywp9ctjEoNoK8GYdfYKsbScacy0QZ
         C2j7BY7dsGeZRrceOdDK6g3a3oavI/Q==
X-KPN-MID: 33|KlB70Ow8e96GD2fMt7pjAYIBoWqSpfAbAfU198rm/0dSwdliylQpIf89vYH9kJQ
 PsedXMVchG7vhOHMu5WNMSmoH6qZ1UmnP/k40eKTp7+Q=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7Wl3ZcTNWw2GmmE/SSdk6KmExqOyZVnkzGrB/DxcaNPfmnKDOzIAIZH02OVXhfp
 iFSSApn31rti9KrDH2FuZvA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 5140ca99-5182-11ed-b5e8-005056abf0db;
        Fri, 21 Oct 2022 22:52:47 +0200 (CEST)
Date:   Fri, 21 Oct 2022 22:52:46 +0200
Message-Id: <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     megi@xff.cz, pgwipeout@gmail.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael.riesch@wolfvision.net,
        frattaroli.nicolas@gmail.com, s.hauer@pengutronix.de,
        frank-w@public-files.de, ezequiel@vanguardiasur.com.ar,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221021193248.2he6amnj7knk4biu@core> (message from
 =?utf-8?Q?Ond=C5=99ej?=
        Jirman on Fri, 21 Oct 2022 21:32:48 +0200)
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core>
 <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com> <20221021193248.2he6amnj7knk4biu@core>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 21 Oct 2022 21:32:48 +0200
> From: Ondřej Jirman <megi@xff.cz>
> 
> On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> > On Fri, Oct 21, 2022 at 11:39 AM Ondřej Jirman <megi@xff.cz> wrote:
> > >
> > > On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> > > > Good Morning Heiko,
> > > >
> > > > Apologies for just getting to this, I'm still in the middle of moving
> > > > and just got my lab set back up.
> > > >
> > > > I've tested this patch series and it leads to the same regression with
> > > > NVMe drives. A loop of md5sum on two identical 4GB random files
> > > > produces the following results:
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> > > > 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> > > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > > b9637505bf88ed725f6d03deb7065dab  test-rand.img
> > > > f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> > > >
> > > > Before this patch series:
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > >
> > > > Though I do love where this patch is going and would like to see if it
> > > > can be made to work, in its current form it does not.
> > >
> > > Thanks for the test. Can you please also test v1? Also please share lspci -vvv
> > > of your nvme drive, so that we can see allocated address ranges, etc.
> > 
> > Good catch, with your patch as is, the following issue crops up:
> > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=16K]
> > Region 2: I/O ports at 1000 [disabled] [size=256]
> > 
> > However, with a simple fix, we can get this:
> > Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=16K]
> > Region 2: I/O ports at 1000 [virtual] [size=256]
> > 
> > and with it a working NVMe drive.
> > 
> > Change the following range:
> > 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> > to
> > 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
> 
> I've already tried this, but this unfrotunately breaks the wifi cards.
> (those only use the I/O space) Maybe because I/O and memory address spaces
> now overlap, I don't know. That's why I used the 1GiB offset for memory
> space.

Meanwhile, I have an NVMe drive that only works if mmio is completely
untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
Motion SM2260 controller.

So for me, a working configuration has the following "ranges":

ranges = <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
         <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
         <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;

This also needs changes to the "reg" propery:

reg = <0x3 0xc0000000 0x0 0x00400000>,
      <0x0 0xfe260000 0x0 0x00010000>,
      <0x3 0x00000000 0x0 0x10000000>;

Now admittedly, this is with OpenBSD running on EDK2 UEFI firmware
from

  https://github.com/jaredmcneill/quartz64_uefi

that I modified to pass through the device tree and modify the ranges
as above.  But the way my OpenBSD driver sets up the address
translation windows matches what the mainline Linux driver does.

I picked the ranges above to match the EDK2 configuration.  But it is
a setup that maximizes the 32-bit mmio window.

Cheers,

Mark

> > I still haven't tested this with other cards yet, and another patch
> > that does similar work I've tested successfully as well with NVMe
> > drives. I'll have to get back to you on the results of greater
> > testing.
> > 
> > Very Respectfully,
> > Peter Geis
> > 
> > >
> > > kind regards,
> > >         o.
> > >
> > > > Very Respectfully,
> > > > Peter Geis
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
