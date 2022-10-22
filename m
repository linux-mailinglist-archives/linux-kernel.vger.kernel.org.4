Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAA608DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJVOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJVOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:36:27 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F865556;
        Sat, 22 Oct 2022 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1666449381; bh=QHnisue+a4NbTS3VD29KWTu7jusrGBVQbF4NMY/LeQM=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=Y76hjUf2L+vq1MWgVF83JKOnMeQiwpvGbQV6c66Uq4ayI6/eR154WfLFabS+bQVfM
         C4HDNXVn49PLhac3y2Vyj6CDfj4D3V3u5kn97+bUEXWDaLA7ZXNxvN7VJ6KJkTYW5D
         ZO00ypl+SQXelrb92hU55f92hOUkMmpM0+fElPmQ=
Date:   Sat, 22 Oct 2022 16:36:20 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael.riesch@wolfvision.net,
        frattaroli.nicolas@gmail.com, s.hauer@pengutronix.de,
        frank-w@public-files.de, ezequiel@vanguardiasur.com.ar,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Message-ID: <20221022143620.nolfuw7bnztgy5ju@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michael.riesch@wolfvision.net,
        frattaroli.nicolas@gmail.com, s.hauer@pengutronix.de,
        frank-w@public-files.de, ezequiel@vanguardiasur.com.ar,
        yifeng.zhao@rock-chips.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core>
 <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core>
 <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
 <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 08:19:57AM -0400, Peter Geis wrote:
> On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> [...]
> 
> Now this is interesting. I've been reading up on PCIe ranges and what
> is necessary for things to work properly, and I found this interesting
> article from ARM:
> https://developer.arm.com/documentation/102337/0000/Programmers-model/Memory-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions

Thanks for the research and the link. :)

> TLDR: We need a low region (below 4g) and a high region.
> 
> From other articles I've gleaned that the config / io should probably
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

Tested, and it works. 

One thing to note though is that this results in Linux allocating address space
for all my devices in the 32-bit range, so while it works for me, the address
space above 0x3_0000_0000 was not tested in my experiments, yet.

I'll try this with some other pcie devices, too, after I get my other quartz64
+ pcie bridge setup to work. Hopefully some combo of them will hit the 64-bit
MEM range.

See:

00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3568 Remote Signal Processor (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
	I/O behind bridge: 1000-2fff [size=8K] [16-bit]
	Memory behind bridge: f4200000-f44fffff [size=3M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Expansion ROM at f4500000 [virtual] [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
	Capabilities: [70] Express Root Port (Slot-), MSI 00
	Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Secondary PCI Express
	Capabilities: [160] L1 PM Substates
	Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
lspci: Unable to load libkmod resources: error -2

01:00.0 PCI bridge: ASMedia Technology Inc. ASM1184e 4-Port PCIe x1 Gen2 Packet Switch (prog-if 00 [Normal decode])
	Subsystem: ASMedia Technology Inc. Device 118f
	Flags: bus master, fast devsel, latency 0, IRQ 69
	Bus: primary=01, secondary=02, subordinate=06, sec-latency=0
	I/O behind bridge: 1000-2fff [size=8K] [16-bit]
	Memory behind bridge: f4200000-f44fffff [size=3M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Upstream Port, MSI 00
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 118f
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Capabilities: [300] Vendor Specific Information: ID=0000 Rev=0 Len=c00 <?>
	Kernel driver in use: pcieport

02:01.0 PCI bridge: ASMedia Technology Inc. ASM1184e 4-Port PCIe x1 Gen2 Packet Switch (prog-if 00 [Normal decode])
	Subsystem: ASMedia Technology Inc. Device 118f
	Flags: bus master, fast devsel, latency 0, IRQ 70
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: f4200000-f42fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Downstream Port (Slot+), MSI 00
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 118f
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Kernel driver in use: pcieport

02:03.0 PCI bridge: ASMedia Technology Inc. ASM1184e 4-Port PCIe x1 Gen2 Packet Switch (prog-if 00 [Normal decode])
	Subsystem: ASMedia Technology Inc. Device 118f
	Flags: bus master, fast devsel, latency 0, IRQ 71
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 1000-1fff [size=4K] [16-bit]
	Memory behind bridge: f4300000-f43fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Downstream Port (Slot+), MSI 00
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 118f
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Kernel driver in use: pcieport

02:05.0 PCI bridge: ASMedia Technology Inc. ASM1184e 4-Port PCIe x1 Gen2 Packet Switch (prog-if 00 [Normal decode])
	Subsystem: ASMedia Technology Inc. Device 118f
	Flags: bus master, fast devsel, latency 0, IRQ 72
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: [disabled] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Downstream Port (Slot+), MSI 00
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 118f
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Kernel driver in use: pcieport

02:07.0 PCI bridge: ASMedia Technology Inc. ASM1184e 4-Port PCIe x1 Gen2 Packet Switch (prog-if 00 [Normal decode])
	Subsystem: ASMedia Technology Inc. Device 118f
	Flags: bus master, fast devsel, latency 0, IRQ 73
	Bus: primary=02, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
	Memory behind bridge: f4400000-f44fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Downstream Port (Slot+), MSI 00
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 118f
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Kernel driver in use: pcieport

03:00.0 Non-Volatile memory controller: Phison Electronics Corporation PS5013 E13 NVMe Controller (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Phison Electronics Corporation PS5013 E13 NVMe Controller
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Memory at f4200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
	Capabilities: [e0] MSI: Enable- Count=1/8 Maskable+ 64bit+
	Capabilities: [f8] Power Management version 3
	Capabilities: [100] Latency Tolerance Reporting
	Capabilities: [110] L1 PM Substates
	Capabilities: [200] Advanced Error Reporting
	Capabilities: [300] Secondary PCI Express
	Kernel driver in use: nvme

04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
	Subsystem: Hewlett-Packard Company Device 85f7
	Flags: bus master, fast devsel, latency 0, IRQ 75
	I/O ports at 1000 [size=256]
	Memory at f4300000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-22-01
	Capabilities: [158] Latency Tolerance Reporting
	Capabilities: [160] L1 PM Substates
	Kernel driver in use: rtw_8822ce

06:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852AE 802.11ax PCIe Wireless Network Adapter
	Subsystem: Hewlett-Packard Company Device 88e1
	Flags: bus master, fast devsel, latency 0, IRQ 76
	I/O ports at 2000 [size=256]
	Memory at f4400000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-88-52-01
	Capabilities: [158] Latency Tolerance Reporting
	Capabilities: [160] L1 PM Substates
	Kernel driver in use: rtw89_8852ae

kind regards,
	o.


> Very Respectfully,
> Peter Geis
> 
> >
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
