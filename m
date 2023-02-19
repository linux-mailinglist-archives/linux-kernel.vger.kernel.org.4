Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62F69C051
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBSNWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:22:12 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7D10AA3;
        Sun, 19 Feb 2023 05:22:10 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id D1D5A26F7B6; Sun, 19 Feb 2023 14:22:08 +0100 (CET)
Date:   Sun, 19 Feb 2023 14:22:08 +0100
From:   Janne Grunau <j@jannau.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] arm64: dts: apple: t8112: Initial t8112 (M2)
 device trees
Message-ID: <20230219132208.GA32724@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-16-22926a283d92@jannau.net>
 <8303bbae-2f98-49fb-8fd6-550ecb272bae@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8303bbae-2f98-49fb-8fd6-550ecb272bae@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-19 13:36:22 +0100, Sven Peter wrote:
> Hi,
> 
> 
> On Tue, Feb 14, 2023, at 12:03, Janne Grunau wrote:
> > From: Hector Martin <marcan@marcan.st>
> >
> > This adds device trees for the following devices:
> >  - Macbook Air (M2, 2022)
> >  - Macbook Pro 13" (M2, 2022)
> >  - Mac mini (M2, 2023)
> >
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > Co-developed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  arch/arm64/boot/dts/apple/Makefile        |    3 +
> >  arch/arm64/boot/dts/apple/t8112-j413.dts  |   63 ++
> >  arch/arm64/boot/dts/apple/t8112-j473.dts  |   54 ++
> >  arch/arm64/boot/dts/apple/t8112-j493.dts  |   52 ++
> >  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
> >  arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/apple/t8112.dtsi      |  912 +++++++++++++++++++++++
> >  7 files changed, 2306 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/apple/Makefile 
> > b/arch/arm64/boot/dts/apple/Makefile
> > index 5a7506ff5ea3..aec5e29cdfb7 100644
> > --- a/arch/arm64/boot/dts/apple/Makefile
> > +++ b/arch/arm64/boot/dts/apple/Makefile
> > @@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
> > diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts 
> > b/arch/arm64/boot/dts/apple/t8112-j413.dts
> > new file mode 100644
> > index 000000000000..9e758edeaa82
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple MacBook Air (M2, 2022)
> > + *
> > + * target-type: J413
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "t8112.dtsi"
> > +#include "t8112-jxxx.dtsi"
> > +
> > +/ {
> > +	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
> > +	model = "Apple MacBook Air (13-inch, M2, 2022)";
> > +
> > +	aliases {
> > +		bluetooth0 = &bluetooth0;
> > +		wifi0 = &wifi0;
> > +	};
> > +};
> > +
> > +/*
> > + * Force the bus number assignments so that we can declare some of the
> > + * on-board devices and properties that are populated by the bootloader
> > + * (such as MAC addresses).
> > + */
> > +&port00 {
> > +	bus-range = <1 1>;
> > +	wifi0: wifi@0,0 {
> > +		compatible = "pci14e4,4433";
> 
> I'm not sure how these pci compatibles are usually handled. Do they have to
> be added to the dt-bindings Documentation as well or is it fine to just have them
> here since they're not really used to match anything?

I suppose they have to be added (at least for dtb validation) but 
"pci14e4,4433" is already in net/wireless/brcm,bcm4329-fmac.yaml.  Added 
via e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties 
& chips").

Janne
