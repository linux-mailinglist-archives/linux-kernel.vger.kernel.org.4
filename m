Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6806B6B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjCLUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCLUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:55:25 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 13:55:23 PDT
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D89426CE4;
        Sun, 12 Mar 2023 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1678654018; bh=4pAmK4fjzhlvGfLZZeoG0S8kt9yvbPZjFMDbTBvuG5c=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=hz7WEffQeoM0FZrUA3yvItW06R8I5igc8EssiUE1F6jhHOu60ao66v/+fzWBsbrWa
         17ty6RaNGsyeTedg4Pekjj9NLeZpwrOWNLfgRuCuKw1SYH5YuFI/bPpRZ3d9ISs8od
         ws8cP160dVEJR3rfp+g8A+wlHA+i0OM1darR1GYI=
Date:   Sun, 12 Mar 2023 21:46:58 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Robin Murphy <robin.murphy@arm.com>, pgwipeout@gmail.com,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, frattaroli.nicolas@gmail.com,
        s.hauer@pengutronix.de, frank-w@public-files.de,
        ezequiel@vanguardiasur.com.ar, yifeng.zhao@rock-chips.com,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Message-ID: <20230312204658.qibiabohxwv2mn5i@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Robin Murphy <robin.murphy@arm.com>, pgwipeout@gmail.com,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, frattaroli.nicolas@gmail.com,
        s.hauer@pengutronix.de, frank-w@public-files.de,
        ezequiel@vanguardiasur.com.ar, yifeng.zhao@rock-chips.com,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core>
 <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
 <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
 <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl>
 <5a8f9934-1959-7962-d575-e3c2f5bc6ade@arm.com>
 <CAMdYzYrXp1kgdRpBmnfiFrXcdkk6_oWozpywgCYbNo_MU+8+=A@mail.gmail.com>
 <34c3daf3-88f8-0dc2-026b-95ca075195b4@arm.com>
 <87y1o1buef.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1o1buef.fsf@bloch.sibelius.xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 12, 2023 at 09:13:12PM +0100, Mark Kettenis wrote:
> [...]
>
> It seems translation isn't actually broken.  At least I got it to work
> with a slight twist.  What seems to be happening is that reads (and
> writes?) to the first 64 MB of the PCIe memory address space
> (0x00000000-0x03ffffff) don't make it out to the PCIe device.  I
> suspect they are somehow claimed by the RC, maybe because the BAR for
> the root complex isn't properly disabled.
> 
> If I change the PCIe bus addess of the mmio window from 0x00000000 to
> 0x40000000 like so:
> 
>     ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
>               0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x3ef00000>;
> 
> my NVMe drive seems to work just fine.  I picked 0x40000000 here
> because it is nicely aligned on a 1GB boundary, which matches the size
> of the region.  Diff against a recent linux-next at the end of this
> mail.
> 
> So what I think is happening is that Linux is allocating resources
> from the top of the region.  So only if you have a more complicated
> PCIe hierarchy it ends up allocating from the low 64 MB and runs into
> the issue.  OpenBSD on the other hand allocates from the bottom, which
> pretty much guarantees that I hit the issue.
> 
> Now this could be a driver bug.  As far as I can tell BAR0/1 is
> properly disabled, but maybe there is some additional bit that we need
> to set.  But I don't think there are any downsides of my workaround.
> We can still provide a ~1GB mmio range; it just starts at 0x40000000
> instead of 0x00000000.
> 
> Maybe somebody can test this on Linux?

There were other discussions and patches posted, and further testing happened
since this discussion (just by looking at the dates...).

The result was: 
https://lore.kernel.org/lkml/20221112114125.1637543-1-aholmes@omnom.net/
https://lore.kernel.org/lkml/20221112114125.1637543-2-aholmes@omnom.net/

The changes for pcie2x1 in that patch make PCIe work on Linux under many
different device combinations, incl. with various combinations of devices
behind PCIe switch, etc.

That patch includes your change, too.

(The patch is not correct for pcie3, see discussion.)

kind regards,
	o.

> > > b. We do in fact require IO and Config to be 32 bit addressable to be
> > > fully compatible.
> > > 
> > > These issues are compounded in rk3588 where we have much smaller
> > > regions in the 32bit space for PCIe, so a definite answer on the true
> > > requirements and limitations would be quite helpful.
> > > 
> > > As always, thank you for your time,
> > > Peter
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index eed0059a68b8..218e51f41852 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -983,7 +983,7 @@ pcie2x1: pcie@fe260000 {
>  		phy-names = "pcie-phy";
>  		power-domains = <&power RK3568_PD_PIPE>;
>  		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
> -			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
> +			  0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x3ef00000>;
>  		resets = <&cru SRST_PCIE20_POWERUP>;
>  		reset-names = "pipe";
>  		#address-cells = <3>;
