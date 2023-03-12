Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437096B6AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCLUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCLUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:13:23 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88161CF69
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:13:17 -0700 (PDT)
X-KPN-MessageId: 4c305afe-c112-11ed-884e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 4c305afe-c112-11ed-884e-005056999439;
        Sun, 12 Mar 2023 21:13:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:mime-version:subject:to:from:message-id:date;
        bh=eq4/RejKetv4oRumsad6iDb0d6JTA210K3HkngpS+AM=;
        b=sqfHh1xxNcC0OiQVKwFh8rwUgPOaGITCz3QUmngS+Lw8SrhTpnyMgs/uH5jZ/CaVxecIOxSt5Z0SP
         3QH9FJw0PvizL8WOg02rgGyxpNEcl8PRjgzHw1PjQd+hplp/ukP97JYzAH7R4rdPEyfUiTnr8MnBOK
         7oP89s+Zy98lZi4Wbtindb7P5k3qdR2mTuPIyRfks0aUpcFbThQLxZ2sMHPHCEJzw5cMscDcahAKO5
         Igv0Ikb1eYmtbneHtN36wUZeK6IgIUMCCNNR+iFSYB1AIaJqrVKO1zFamOtrhyBbvrIMlG0mK5Om9B
         emi2zePyamMyMJEgaLK5KdFN5sNV8yw==
X-KPN-MID: 33|8c6t8yeLRvpWHqc0Dyb2Y0iCZ1JvChoyYc0XxOyLWdGApVuncqYJ0acZlY/D5SK
 jrZwwxIpSri0ziQnrHNEswA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|z67+uQqzs6xWcvhjNj3GzdEVWCsZ2ZMddtEVYbmFHKPp+6gk0V5VpEuvBA+eQBW
 ngAgvombeOboB/eJnGrIIlw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 50faf9bc-c112-11ed-a8eb-005056998788;
        Sun, 12 Mar 2023 21:13:13 +0100 (CET)
Date:   Sun, 12 Mar 2023 21:13:12 +0100
Message-Id: <87y1o1buef.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     pgwipeout@gmail.com, megi@xff.cz, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael.riesch@wolfvision.net,
        frattaroli.nicolas@gmail.com, s.hauer@pengutronix.de,
        frank-w@public-files.de, ezequiel@vanguardiasur.com.ar,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <34c3daf3-88f8-0dc2-026b-95ca075195b4@arm.com> (message from
        Robin Murphy on Tue, 25 Oct 2022 11:29:12 +0100)
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core>
 <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
 <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
 <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl>
 <5a8f9934-1959-7962-d575-e3c2f5bc6ade@arm.com>
 <CAMdYzYrXp1kgdRpBmnfiFrXcdkk6_oWozpywgCYbNo_MU+8+=A@mail.gmail.com> <34c3daf3-88f8-0dc2-026b-95ca075195b4@arm.com>
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

> Date: Tue, 25 Oct 2022 11:29:12 +0100
> From: Robin Murphy <robin.murphy@arm.com>

Reviving this old thread as rk3566 support in mainline U-Boot is
getting usable which prompted me to look at the PCIe address map
issues again.

> On 2022-10-24 21:16, Peter Geis wrote:
> > On Mon, Oct 24, 2022 at 7:05 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-10-22 18:24, Mark Kettenis wrote:
> >>>> From: Peter Geis <pgwipeout@gmail.com>
> >>>> Date: Sat, 22 Oct 2022 08:19:57 -0400
> >>>
> >>> Hello Peter,
> >>>
> >>>> On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >>>>>
> >>>>>> Date: Fri, 21 Oct 2022 21:32:48 +0200
> >>>>>> From: Ondřej Jirman <megi@xff.cz>
> >>>>>>
> >>>>>> On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> >>>>>>> On Fri, Oct 21, 2022 at 11:39 AM Ondřej Jirman <megi@xff.cz> wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> >>>>>>>>> Good Morning Heiko,
> >>>>>>>>>
> >>>>>>>>> Apologies for just getting to this, I'm still in the middle of moving
> >>>>>>>>> and just got my lab set back up.
> >>>>>>>>>
> >>>>>>>>> I've tested this patch series and it leads to the same regression with
> >>>>>>>>> NVMe drives. A loop of md5sum on two identical 4GB random files
> >>>>>>>>> produces the following results:
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>>>> fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> >>>>>>>>> 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> >>>>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> >>>>>>>>> 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> >>>>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> >>>>>>>>> b9637505bf88ed725f6d03deb7065dab  test-rand.img
> >>>>>>>>> f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> >>>>>>>>>
> >>>>>>>>> Before this patch series:
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>>>>
> >>>>>>>>> Though I do love where this patch is going and would like to see if it
> >>>>>>>>> can be made to work, in its current form it does not.
> >>>>>>>>
> >>>>>>>> Thanks for the test. Can you please also test v1? Also please share lspci -vvv
> >>>>>>>> of your nvme drive, so that we can see allocated address ranges, etc.
> >>>>>>>
> >>>>>>> Good catch, with your patch as is, the following issue crops up:
> >>>>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=16K]
> >>>>>>> Region 2: I/O ports at 1000 [disabled] [size=256]
> >>>>>>>
> >>>>>>> However, with a simple fix, we can get this:
> >>>>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=16K]
> >>>>>>> Region 2: I/O ports at 1000 [virtual] [size=256]
> >>>>>>>
> >>>>>>> and with it a working NVMe drive.
> >>>>>>>
> >>>>>>> Change the following range:
> >>>>>>> 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> >>>>>>> to
> >>>>>>> 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
> >>>>>>
> >>>>>> I've already tried this, but this unfrotunately breaks the wifi cards.
> >>>>>> (those only use the I/O space) Maybe because I/O and memory address spaces
> >>>>>> now overlap, I don't know. That's why I used the 1GiB offset for memory
> >>>>>> space.
> >>>>>
> >>>>> Meanwhile, I have an NVMe drive that only works if mmio is completely
> >>>>> untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
> >>>>> Motion SM2260 controller.
> >>>>>
> >>>>> So for me, a working configuration has the following "ranges":
> >>>>>
> >>>>> ranges = <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
> >>>>>            <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
> >>>>>            <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;
> >>>>>
> >>>>> This also needs changes to the "reg" propery:
> >>>>>
> >>>>> reg = <0x3 0xc0000000 0x0 0x00400000>,
> >>>>>         <0x0 0xfe260000 0x0 0x00010000>,
> >>>>>         <0x3 0x00000000 0x0 0x10000000>;
> >>>>
> >>>> Now this is interesting. I've been reading up on PCIe ranges and what
> >>>> is necessary for things to work properly, and I found this interesting
> >>>> article from ARM:
> >>>> https://developer.arm.com/documentation/102337/0000/Programmers-model/Memory-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions
> >>>>
> >>>> TLDR: We need a low region (below 4g) and a high region.
> >>>
> >>> Well, that description applies to a specific ARM reference design.
> >>> And it appears that the PCIe-RC used in that reference design does not
> >>> support address translation.
> >>
> >> Indeed, that's not an "interesting article", it's just documentation for
> >> some other system that isn't this one. In fact it's a system that
> >> strictly doesn't even *have* PCIe; the reference designs are not
> >> complete SoCs, and all that is being described there is the interconnect
> >> address map for the parts which are in place ready for a customer to
> >> stitch their choice of PCIe implementation to.
> >>
> >> The equivalent for RK3568 is that you *do* have "low" and "high" PCIe
> >> windows at 0xfx000000 and 0x3xxx00000 respectively in the system
> >> interconnect address map. How the PCIe controllers choose to relate
> >> those system MMIO addresses to those to PCI Memory, I/O and Config space
> >> addresses is another matter entirely.
> > 
> > Unfortunately we are working with insufficient documentation and
> > without the detailed understanding of a system integrator here. I'm
> > fully aware that the Neoverse N2 is not the rk3568, however
> > significant chunks of the rk3568 are based on ARM IP. Looking at how
> > ARM expects things to work by comparing their reference documents to
> > the hardware we have on hand is helpful in determining what we are
> > lacking.
> > 
> > The specific portions of the documentation that I found useful are not
> > the memory maps, but the generic descriptions of expected PCIe
> > regions. Combining those with other reference documents (unfortunately
> > most x86 based, but we have the unfortunate reality that PCIe has a
> > lot of x86isms to deal with) is quite enlightening.
> 
> OK, but you're looking at the wrong place for that. The only actual 
> relevant reference would be rule PCI_MM_06 in the BSA[1], which says 
> that PCI memory space should not be translated relative to the system 
> address map. It is hopefully obvious that 32-bit devices need 32-bit PCI 
> mem space to assign to their BARs, thus it falls out that if there is no 
> translation, that requires a 32-bit window in system address space too.
> 
> That is of course speaking of a BSA-compliant system. Vendors are still 
> free to not care about BSA and do whatever the heck they want.
> 
> Thanks,
> Robin.
> 
> [1] https://developer.arm.com/documentation/den0094/latest/
> 
> > I've been pinging
> > various representatives of the IP and implementation on the mailing
> > list about these issues for about a year now with no responses from
> > the Designware folk. You have been pretty one of the only individuals
> > with the level of knowledge we need to respond and I thank you for
> > that.
> > 
> > Based on what I've read I suspect that at least one of the two
> > following statements is true:
> > a. Mark is correct that translation is broken in Rockchip's
> > implementation (unknown if this is a SoC or a driver issue)

It seems translation isn't actually broken.  At least I got it to work
with a slight twist.  What seems to be happening is that reads (and
writes?) to the first 64 MB of the PCIe memory address space
(0x00000000-0x03ffffff) don't make it out to the PCIe device.  I
suspect they are somehow claimed by the RC, maybe because the BAR for
the root complex isn't properly disabled.

If I change the PCIe bus addess of the mmio window from 0x00000000 to
0x40000000 like so:

    ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
              0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x3ef00000>;

my NVMe drive seems to work just fine.  I picked 0x40000000 here
because it is nicely aligned on a 1GB boundary, which matches the size
of the region.  Diff against a recent linux-next at the end of this
mail.

So what I think is happening is that Linux is allocating resources
from the top of the region.  So only if you have a more complicated
PCIe hierarchy it ends up allocating from the low 64 MB and runs into
the issue.  OpenBSD on the other hand allocates from the bottom, which
pretty much guarantees that I hit the issue.

Now this could be a driver bug.  As far as I can tell BAR0/1 is
properly disabled, but maybe there is some additional bit that we need
to set.  But I don't think there are any downsides of my workaround.
We can still provide a ~1GB mmio range; it just starts at 0x40000000
instead of 0x00000000.

Maybe somebody can test this on Linux?

> > b. We do in fact require IO and Config to be 32 bit addressable to be
> > fully compatible.
> > 
> > These issues are compounded in rk3588 where we have much smaller
> > regions in the 32bit space for PCIe, so a definite answer on the true
> > requirements and limitations would be quite helpful.
> > 
> > As always, thank you for your time,
> > Peter

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index eed0059a68b8..218e51f41852 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -983,7 +983,7 @@ pcie2x1: pcie@fe260000 {
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
 		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+			  0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x3ef00000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
