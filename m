Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00D6F4031
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEBJan convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 May 2023 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:30:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311814C2B;
        Tue,  2 May 2023 02:30:38 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ptmL5-0006gj-Ni; Tue, 02 May 2023 11:30:27 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
Date:   Tue, 02 May 2023 11:30:26 +0200
Message-ID: <4763863.6tgchFWduM@diego>
In-Reply-To: <5782501.VdNmn5OnKV@diego>
References: <20230428013738.30735-1-cnsztl@gmail.com>
 <20230428013738.30735-2-cnsztl@gmail.com> <5782501.VdNmn5OnKV@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Mai 2023, 11:28:22 CEST schrieb Heiko Stübner:
> Hi,
> 
> Am Freitag, 28. April 2023, 03:37:37 CEST schrieb Tianling Shen:
> > Lunzn Fastrhino R66S is a high-performance mini router.
> > 
> > Specification:
> > - Rockchip RK3568
> > - 1/2GB LPDDR4 RAM
> > - SD card slot
> > - M.2 Connector
> > - 2x USB 3.0 Port
> > - 2x 2500 Base-T (PCIe, r8125b)
> > - 12v DC Jack
> > 
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  27 +
> >  .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 507 ++++++++++++++++++
> >  3 files changed, 535 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 2d585bbb8f3a..15089a78555a 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -85,6 +85,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > new file mode 100644
> > index 000000000000..fc9e1bdab128
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +
> > +#include "rk3568-fastrhino-r66s.dtsi"
> > +
> > +/ {
> > +	model = "Lunzn FastRhino R66S";
> > +	compatible = "lunzn,fastrhino-r66s", "rockchip,rk3568";
> > +
> > +	aliases {
> > +		mmc0 = &sdmmc0;
> > +	};
> > +};
> > +
> > +&sdmmc0 {
> 
> that whole element seems to be duplicated from rk3568-fastrhino-r66s.dtsi?
> I don't think we need to declare that twice. If something really changes,
> please only declare the new properties when going from dtsi to dts.

Looking at patch3 I see the explanation :-) .

The base dtsi should not contain the &sdmmc0 node, and it should
only be included in the rk3568-fastrhino-r66s.dts, right?


Heiko


