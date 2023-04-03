Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796F16D40D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDCJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDCJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:39:27 -0400
Received: from pi.fatal.se (andreasfatal-1-pt.tunnel.tserv3.fmt2.ipv6.he.net [IPv6:2001:470:1f04:f16::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC2484C2B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:38:22 -0700 (PDT)
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 25A062A1A3; Mon,  3 Apr 2023 11:38:12 +0200 (CEST)
Date:   Mon, 3 Apr 2023 11:38:12 +0200
From:   Andreas Henriksson <andreas@fatal.se>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Jun Li <jun.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Message-ID: <20230403093812.rjj2wkusajsx5mwi@fatal.se>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
 <20230330143813.teid36w24a4esjsx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330143813.teid36w24a4esjsx@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco Felsch,

On Thu, Mar 30, 2023 at 04:38:13PM +0200, Marco Felsch wrote:
> Hi,
> 
> On 23-03-27, Andreas Henriksson wrote:
[...]
> > / {
> >     gpio-sbu-mux {
> >         compatible = "gpio-sbu-mux";
[...]
> I didn't tested it but at the moment I don't see the problem with my
> patch. 

As Jun Li helpfully explained my patch is not correct, so don't bother.

I don't have a problem with your patch, was just trying to share
what I had done.

I've since learned that the board I'll be working on will not even have
SS, so I will not pursue SBU. I'll most likely use your patches instead
as they seem simpler than what I did and should fully meet my needs for
an usb port that works in both host and device mode.

Not that it matters, but +1 from me on applying your patches.
(If people are hesitant to do it because of lack of SS, then maybe
that could be adressed by adding a comment setting the expectations?)

> Sure the ID pin is not connected but if I understood it correctly
> (please correct me) the tcpc will handle the orientation. I can set the
> mode to device from user-space which worked. I didn't verified the
> SuperSpeed mode nor the host mode since I don't have a USB-C flash
> drive.
> 
> Without the patch the port is just unused albeit the port is really
> useful for bootloaders like barebox to provide a usbgadget/fastboot
> device to flash the system.
> 
> Regards,
>   Marco

Regards,
Andreas Henriksson
