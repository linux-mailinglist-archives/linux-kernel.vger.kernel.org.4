Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE015F54BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJEMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJEMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:49:06 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5C6A489;
        Wed,  5 Oct 2022 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1664974140; bh=xOLzlsbhoUwuP51oM+e6pJyl+G0gLf7qASwB3qWSqK8=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=SwkinqedY/1RYXhfbIYOLoKqTyexnCtOJI7PuEVUThGfTFzaXRCiMchVZmCH5pNvO
         1IMY4LQxkRrVuR+hqagiTFdqBm2OzYJYvP6twhPrnilQ4r1cfL386DUnb2XaNRUxOn
         Lu1UWvs0XJFmRbgnJTsRr8uXf4v7vDQB/+s0iM8s=
Date:   Wed, 5 Oct 2022 14:49:00 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Message-ID: <20221005124900.o2bghrdtkdrajb4t@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 05, 2022 at 07:42:54AM -0400, Peter Geis wrote:
> On Wed, Oct 5, 2022 at 4:54 AM Ondrej Jirman <megi@xff.cz> wrote:
> >
> 
> Good Morning,
> 
> > I have two Realtek PCIe wifi cards connected over the 4 port PCIe swtich
> > to Quartz64-A. The cards fail to work, when nvme SSD is connected at the
> > same time to the bridge. Without nvme connected, cards work fine. The
> > issue seems to be related to mixed use of devices which make use of I/O
> > ranges and memory ranges.
> >
> > This patch changes I/O, MEM and config mappings so that config and I/O
> > mappings use the 0xf4000000 outbound address space, and MEM range uses
> > the whole 0x300000000 outbound space.
> >
> > This is simialar to how BSP does the mappings.
> 
> This change was very recent in the BSP stuff (Jan 2022):
> https://github.com/rockchip-linux/kernel/commit/cfab7abefc4093daa379fbd90a1e7ac1a484332b
> A few other interesting changes there as well. They added a 32 bit
> window in the lower range and made the entire upper range a 64 bit
> relocatable (why?) and prefetchable window. They also set the viewport
> number to 8. The dt-binding says this is autodetected, but I wonder if
> the value is being detected correctly.

That number in BSP is equivalent in meaning to num-ob-windows in mainline. At
least it's used in identical manner in the code.

> It looks like it is dependent in BSP on a backported change from mainline:
> https://github.com/rockchip-linux/kernel/commit/50a01d3c10a6212f66364575a3c8f66c07f41591
> 
> Can someone weigh in why the dw core has config in the reg node
> instead of ranges?
> 
> >
> > I changed num-ob-windows to value detected by the kernel so if for whatever
> > reason the kernel ever starts respecting this DT property, it would not
> > switch to sharing I/O and CFG spaces via a single iATU mapping for
> > no reason.
> 
> This worries me that this value may be being detected incorrectly,
> they set it to this for a reason. It's not unheard of for Rockchip to
> need to override what they encode in the silicon.

num-ob-windows mainline == viewport-num in BSP for whatever reason. (it's used
to decide whether there are enough windows to share config with I/O or not) So
it's identical to BSP.

kind regards,
	o.

> Very Respectfully,
> Peter Geis
> 
> >
> > This change to the regs/ranges makes the issue go away and both nvme and
> > wifi cards work when connected at the same time to the bridge. I tested
> > the nvme with large amount of reads/writes, both behind the PCIe bridge
> > and when directly connected to Quartz64-A board.
> >
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> > BSP for reference: https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2370
> >
> > v2:
> > - change ranges to use 0x300000000 fully for MEM and make use of
> >   the 0xf4000000 outbound range for IO and config
> > - full retest with/without the switch
> > - if lscpi/dmesg is useful in the future for comparison, see:
> >   https://xff.cz/kernels/random/quartz64a-pcie/
> >
> > I used this script for the tests:
> >
> > #!/bin/bash
> >
> > OUT=/mnt/data
> > n=8
> >
> > test -f /tmp/test.dat || \
> >     dd if=/dev/urandom of=/tmp/test.dat bs=1M count=1024
> > md5sum /tmp/test.dat
> >
> > i=0
> > while test $i -lt $n
> > do
> >     dd if=/tmp/test.dat of=$OUT/test$i.dat bs=4M oflag=direct
> >
> >     i=$(($i+1))
> > done
> >
> > i=0
> > while test $i -lt $n
> > do
> >     dd if=$OUT/test$i.dat bs=4M iflag=direct | md5sum
> >
> >     i=$(($i+1))
> > done
> >
> >
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 319981c3e9f7..99fd9543fc6f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -855,7 +855,8 @@ pcie2x1: pcie@fe260000 {
> >                 compatible = "rockchip,rk3568-pcie";
> >                 reg = <0x3 0xc0000000 0x0 0x00400000>,
> >                       <0x0 0xfe260000 0x0 0x00010000>,
> > -                     <0x3 0x3f000000 0x0 0x01000000>;
> > +                     <0x0 0xf4000000 0x0 0x01f00000>;
> > +
> >                 reg-names = "dbi", "apb", "config";
> >                 interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> >                              <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> > @@ -877,15 +878,15 @@ pcie2x1: pcie@fe260000 {
> >                                 <0 0 0 4 &pcie_intc 3>;
> >                 linux,pci-domain = <0>;
> >                 num-ib-windows = <6>;
> > -               num-ob-windows = <2>;
> > +               num-ob-windows = <8>;
> >                 max-link-speed = <2>;
> >                 msi-map = <0x0 &gic 0x0 0x1000>;
> >                 num-lanes = <1>;
> >                 phys = <&combphy2 PHY_TYPE_PCIE>;
> >                 phy-names = "pcie-phy";
> >                 power-domains = <&power RK3568_PD_PIPE>;
> > -               ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
> > -                         0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
> > +               ranges = <0x01000000 0x0 0x00000000 0x0 0xf5f00000 0x0 0x00100000
> > +                         0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> >                 resets = <&cru SRST_PCIE20_POWERUP>;
> >                 reset-names = "pipe";
> >                 #address-cells = <3>;
> > --
> > 2.37.3
> >
