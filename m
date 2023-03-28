Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505D6CC576
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjC1PO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC1POI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:14:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638F10257
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:13:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1phAyU-00013x-BO; Tue, 28 Mar 2023 17:11:02 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1phAyS-0007PR-P8; Tue, 28 Mar 2023 17:11:00 +0200
Date:   Tue, 28 Mar 2023 17:11:00 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        Markus.Niebel@ew.tq-group.com,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        paul.elder@ideasonboard.com, gerg@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, djakov@kernel.org, shawnguo@kernel.org,
        l.stach@pengutronix.de
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Message-ID: <20230328151100.msl46qupstwplkgw@pengutronix.de>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org>
 <2678294.mvXUDI8C0e@steina-w>
 <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
 <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
 <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
 <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
 <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
 <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
 <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 23-03-29, Greg Ungerer wrote:
> Hi Marco,

...

> > I forgot to ask: Does your i.MX8MP have a VPU? There are i.MX8MP devices
> > (don't know the name) which don't have support for certain IPs. If this
> 
> The hardware platform I have is using the MIMX8ML4CVNKZAB "i.MX 8M Plus QuadLite"
> (https://www.nxp.com/part/MIMX8ML4CVNKZAB#/) which does not have the hardware
> video encode/decoder module (like the "i.MX 8M Plus Quad" parts).

and that's the problem :) You need to update your bootloader to a
version which support disabling the VPU nodes else you will always see
the errors.

> > is the case the bootloader will fixup your devicetree by disable the
> > corresponding nodes, we call this feature-controller:
> > 
> > https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mp.dtsi
> > 
> > As you can see the imx8mp.dtsi is missing the feature bits for the VPU
> > but you can check the i.mx8mm.dtsi. Here you can see that barebox will
> > check the availability of the vpu:
> > 
> > https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mm.dtsi
> 
> Ok, thanks, I'll take a look.

Patches are welcome if you use barebox :)

Regards,
  Marco
