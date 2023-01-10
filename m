Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D5664425
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbjAJPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbjAJPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:08:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BED69B27;
        Tue, 10 Jan 2023 07:07:54 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFGE8-0005Pf-AS; Tue, 10 Jan 2023 16:07:48 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jagan Teki <jagan@edgeble.ai>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCHv8 7/7] arm64: dts: rockchip: Add rock-5b board
Date:   Tue, 10 Jan 2023 16:07:46 +0100
Message-ID: <37476486.XM6RcZxFsP@diego>
In-Reply-To: <996e39448350d4f6318f7ff59c6a2ca249fb30a7.camel@collabora.com>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <CA+VMnFxb1P4tP5sef5ME3jCcCq2Y3rD-0bpv1B0TsUZ3RXXuqg@mail.gmail.com> <996e39448350d4f6318f7ff59c6a2ca249fb30a7.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Januar 2023, 15:50:17 CET schrieb Christopher Obbard:
> On Tue, 2023-01-10 at 19:30 +0530, Jagan Teki wrote:
> > On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > > 
> > > From: Christopher Obbard <chris.obbard@collabora.com>
> > > 
> > > Add board file for the RK3588 Rock 5B board. This is a basic
> > > implementation which just brings up the eMMC and UART which is
> > > enough to successfully boot Linux.
> > > 
> > > The ethernet controller is connected via PCIe so support will
> > > come in a follow-up patch.
> > > 
> > > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
> > >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 44
> > > +++++++++++++++++++
> > >  2 files changed, 45 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> > > b/arch/arm64/boot/dts/rockchip/Makefile
> > > index 87a853435142..c5bdd0176ce0 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -83,4 +83,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-
> > > v10.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > new file mode 100644
> > > index 000000000000..d2f1e963ce06
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > @@ -0,0 +1,44 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "rk3588.dtsi"
> > > +
> > > +/ {
> > > +       model = "Radxa ROCK 5 Model B";
> > > +       compatible = "radxa,rock-5b", "rockchip,rk3588";
> > > +
> > > +       aliases {
> > > +               mmc1 = &sdhci;
> > 
> > I think sdhci - emmc has to be mmc0 due to boot priority.
> 
> Hi Jagan,
> 
> We kept eMMC as mmc1 for both ROCK 5 Model A and B to keep
> compatibility with vendor kernel:
> https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L31
> 
> But I am happy to change the alias to mmc0, @Sebastian what do you
> think?

In any case, if you decide to swap things around, please just send a follow
up patch, as I just applied this series :-)


Heiko


