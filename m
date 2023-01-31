Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C766829A1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAaJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAaJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:54:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA95B9D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:54:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pMnLO-0000Lh-C7; Tue, 31 Jan 2023 10:54:26 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pMnLM-0004mS-V0; Tue, 31 Jan 2023 10:54:24 +0100
Date:   Tue, 31 Jan 2023 10:54:24 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: update usb compatible string
Message-ID: <20230131095424.vlj4z4qci4722gy7@pengutronix.de>
References: <20230131091140.3696808-1-peng.fan@oss.nxp.com>
 <20230131092455.2s63zr6d56v2u6ka@pengutronix.de>
 <DU0PR04MB941741A921F3953E165BB45F88D09@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941741A921F3953E165BB45F88D09@DU0PR04MB9417.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-31, Peng Fan wrote:
> > Subject: Re: [PATCH] arm64: dts: imx8mq: update usb compatible string
> > 
> > Hi,
> > 
> > On 23-01-31, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There is no fsl,imx8mq-dwc3 binding doc, no driver use this compatible
> > > string. Drop it.
> > 
> > please don't. I'm not aware of the driver state but the compatibles are there
> > for _possible_ quirk handling, so the driver can add a match on demand.
> 
> NXP downstream also not has driver use this compatible string, and pass
> several GA releases.

This shouldn't be an argument, because there is no bug at the moment
doesn't mean that there is one. Also the compatible may used by other
projects using this device tree too.

> People could add it back when it is needed together with binding doc.

Nope since a DTB is firmware which is updated relativ rare. The kernel
instead is updated more often. So please instead of removing it add
support to the dt-bindings doc.

Regards,
  Marco


> Thanks,
> Peng.
> 
> > 
> > Regards,
> >   Marco
> > 
> > 
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index d59156fdee0b..d308f94a7c52 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -1431,7 +1431,7 @@ gpu: gpu@38000000 {
> > >  		};
> > >
> > >  		usb_dwc3_0: usb@38100000 {
> > > -			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
> > > +			compatible = "snps,dwc3";
> > >  			reg = <0x38100000 0x10000>;
> > >  			clocks = <&clk IMX8MQ_CLK_USB1_CTRL_ROOT>,
> > >  			         <&clk IMX8MQ_CLK_USB_CORE_REF>, @@ -
> > 1463,7 +1463,7 @@
> > > usb3_phy0: usb-phy@381f0040 {
> > >  		};
> > >
> > >  		usb_dwc3_1: usb@38200000 {
> > > -			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
> > > +			compatible = "snps,dwc3";
> > >  			reg = <0x38200000 0x10000>;
> > >  			clocks = <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>,
> > >  			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
> > > --
> > > 2.37.1
> > >
> > >
> > >
> 
