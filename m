Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F66FB30B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjEHOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:36:06 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C8D1;
        Mon,  8 May 2023 07:36:02 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 1F0EC202F9;
        Mon,  8 May 2023 16:35:58 +0200 (CEST)
Date:   Mon, 8 May 2023 16:35:56 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jun Li <jun.li@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <ZFkIzIkJRVxiNSwk@francesco-nb.int.toradex.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
 <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230505120618.2f4cf22c@booty>
 <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
 <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
 <PA4PR04MB9640C09FDDDD4C29804C05BB89719@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9640C09FDDDD4C29804C05BB89719@PA4PR04MB9640.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:53:07AM +0000, Jun Li wrote:
> > -----Original Message-----
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Monday, May 8, 2023 7:17 PM
> > To: Jun Li <jun.li@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Luca Ceresoli
> > <luca.ceresoli@bootlin.com>; devicetree@vger.kernel.org;
> > festevam@gmail.com; gregkh@linuxfoundation.org; kernel@pengutronix.de;
> > linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > robh+dt@kernel.org; s.hauer@pengutronix.de; shawnguo@kernel.org;
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>; Xu Yang <xu.yang_2@nxp.com>
> > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
> > 
> > On Sat, May 06, 2023 at 09:02:39AM +0000, Jun Li wrote:
> > > > -----Original Message-----
> > > > From: Francesco Dolcini <francesco@dolcini.it>
> > > > Sent: Friday, May 5, 2023 7:00 PM
> > > > To: Luca Ceresoli <luca.ceresoli@bootlin.com>; Jun Li <jun.li@nxp.com>
> > > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> > devicetree@vger.kernel.org;
> > > > festevam@gmail.com; gregkh@linuxfoundation.org;
> > kernel@pengutronix.de;
> > > > linux-arm-kernel@lists.infradead.org; dl-linux-imx
> > <linux-imx@nxp.com>;
> > > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > > > peter.chen@nxp.com; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > > shawnguo@kernel.org; Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org>;
> > > > Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
> > runtime-pm
> > > >
> > > > On Fri, May 05, 2023 at 12:06:18PM +0200, Luca Ceresoli wrote:
> > > > > On Fri, 5 May 2023 09:49:16 +0000
> > > > > Jun Li <jun.li@nxp.com> wrote:
> > > > > > Is your board design similar like Francesco's as below?
> > > > >
> > > > > Possibly, but I'm afraid I can't say: I am using the Toradex Colibri
> > > > > i.MX6ULL SoM, whose schematics are not public.
> > > >
> > > > I can confirm that it's the same.
> > >
> > > Thanks Francesco for the confirmation, had a check with design team,
> > > there is no status bit which can be used to judge the VDD_USB_CAP is
> > > powered or not, so we have to add a board level dts property to tell
> > > this usb phy driver to bypass MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS.
> > >
> > > Before send a formal patch, I want to confirm this should work for your
> > > HW design, like below simple hack:
> > 
> > Thanks Li Jun, I tested it with v6.3.1 kernel and it's all good.
> > I would be happy to test the patch as soon as you send it.
> > 
> > 
> > With that said I had another issue that I assume is unrelated.
> > In addition to the USB Host port, we have an additional OTG one. This
> > interface has the same circuit WRT to the VBUS, however in this case
> > it's possible to read the VBUS using extcon, e.g. a standard GPIO input.
> > 
> > With that setup, while doing a role switch, I had a couple of time this
> > error:
> > 
> > [  187.310421] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> > [  192.351452] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in OTGSC
> > 
> > that was recovered only doing an additional transition.
> > 
> > More complete logs here:
> > 
> > [  184.997619] usb 2-1: USB disconnect, device number 9
> > [  185.019620] ci_hdrc ci_hdrc.0: remove, state 1
> > [  185.024271] usb usb2: USB disconnect, device number 1
> > [  185.334975] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> > [  185.353857] ci_hdrc ci_hdrc.0: EHCI Host Controller
> > [  185.389670] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number
> > 2
> > [  185.470170] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> > [  185.476097] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002,
> > bcdDevice= 6.01
> > [  185.484527] usb usb2: New USB device strings: Mfr=3, Product=2,
> > SerialNumber=1
> > [  185.491811] usb usb2: Product: EHCI Host Controller
> > [  185.496704] usb usb2: Manufacturer: Linux 6.1.22-6.2.0+git.3b29299e5f60
> > ehci_hcd
> > [  185.504148] usb usb2: SerialNumber: ci_hdrc.0
> > [  185.531121] hub 2-0:1.0: USB hub found
> > [  185.542636] hub 2-0:1.0: 1 port detected
> > [  185.556586] mxs_phy 20c9000.usbphy: vbus is not valid
> > [  187.271684] ci_hdrc ci_hdrc.0: remove, state 4
> > [  187.276281] usb usb2: USB disconnect, device number 1
> > [  187.310421] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> > [  192.351452] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in OTGSC
> 
> I have 2 questions:
> 1. Can your OTG port work fine in device/gadget mode if you did not
>    do usb role switch?(e.g. the OTG port *never* switch to host mode
>    after system boot).

It works fine when started as device, never switching to host.

The switch to host and back to device is also working, but not in a
reliable way.

When not working doing a second tries always work.

> 2. Please show me your dts file node of your USB OTG port, I want to
>    Know how you config your OTG port. 

The DTS file is arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dts.

Just walk the dtsi includes till arch/arm/boot/dts/imx6ull-colibri.dtsi
and it's &usbotg1 node there.

Thanks
Francesco

