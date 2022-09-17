Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF95BB6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQGml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:42:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD41D0E3;
        Fri, 16 Sep 2022 23:42:36 -0700 (PDT)
Received: from [167.98.135.4] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZRWy-0007CE-Mc; Sat, 17 Sep 2022 08:42:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata variant
Date:   Sat, 17 Sep 2022 08:42:23 +0200
Message-ID: <14722513.tv2OnDr8pf@phil>
In-Reply-To: <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
References: <YySdhiqZgXpl0q/g@lab.hqhome163.com> <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
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

Hi Peter,

Am Samstag, 17. September 2022, 03:40:07 CEST schrieb Peter Geis:
> On Fri, Sep 16, 2022 at 12:06 PM Alessandro Carminati
> <alessandro.carminati@gmail.com> wrote:
> >
> > The Quartz64 board is built upon Rockchip RK3566.
> > Rockchip RK3566 has two combo phys.
> > The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> > ctrl2.
> > The second combo phy is hardwired to the PCIe slot, where for the first,
> > the hardware on the board provides both the USB3 connector and the SATA
> > connector.
> > This DT allows the users to switch the combo phy to the SATA connector.
> 
> Good Evening,
> 
> NACK to this whole series. Neither works correctly in the hardware as
> is,

Just for my understanding for the future, sata not working is that a bug
in the soc or the board?

> and USB3 was decided to be left enabled as the SATA port will be
> removed completely in the next revision.

That is good to know. Thanks for the heads up :-)

Heiko


> > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
> >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 8c843f6fc3cc..1d5dd91d1a34 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > new file mode 100644
> > index 000000000000..8620df7ec01e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "rk3566-quartz64-a.dtsi"
> > +
> > +&sata1 {
> > +       status = "okay";
> > +};
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




