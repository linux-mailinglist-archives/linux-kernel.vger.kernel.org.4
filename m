Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A036F5B60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjECPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjECPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:38:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603026E95
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:38:34 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puEYk-00074M-Mi; Wed, 03 May 2023 17:38:26 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puEYi-0003Zl-Jy; Wed, 03 May 2023 17:38:24 +0200
Date:   Wed, 3 May 2023 17:38:24 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andreas Henriksson <andreas@fatal.se>, Jun Li <jun.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Message-ID: <20230503153824.57clwmz7lw5g4aif@pengutronix.de>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
 <20230330143813.teid36w24a4esjsx@pengutronix.de>
 <20230403093812.rjj2wkusajsx5mwi@fatal.se>
 <20230405131637.GB11367@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405131637.GB11367@dragon>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas, Shawn,

On 23-04-05, Shawn Guo wrote:
> On Mon, Apr 03, 2023 at 11:38:12AM +0200, Andreas Henriksson wrote:
> > Hello Marco Felsch,
> > 
> > On Thu, Mar 30, 2023 at 04:38:13PM +0200, Marco Felsch wrote:
> > > Hi,
> > > 
> > > On 23-03-27, Andreas Henriksson wrote:
> > [...]
> > > > / {
> > > >     gpio-sbu-mux {
> > > >         compatible = "gpio-sbu-mux";
> > [...]
> > > I didn't tested it but at the moment I don't see the problem with my
> > > patch. 
> > 
> > As Jun Li helpfully explained my patch is not correct, so don't bother.
> > 
> > I don't have a problem with your patch, was just trying to share
> > what I had done.

Thanks for sharing :)

> > I've since learned that the board I'll be working on will not even have
> > SS, so I will not pursue SBU. I'll most likely use your patches instead
> > as they seem simpler than what I did and should fully meet my needs for
> > an usb port that works in both host and device mode.
> > 
> > Not that it matters, but +1 from me on applying your patches.
> > (If people are hesitant to do it because of lack of SS, then maybe
> > that could be adressed by adding a comment setting the expectations?)
> 
> Marco,
> 
> Could you update the patch to mention a bit about Super-Speed support
> as discussed here?

Yes I will update the patch accordingly.

Regards,
  Marco
