Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5E6D7D82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbjDENQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjDENQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89361E7A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EB9628F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE671C433D2;
        Wed,  5 Apr 2023 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680700604;
        bh=fKUuw9gW9/x9L0Vo9NhNeOr4f0JKSotdNhqzYqerBHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efc3gNA+SyVNEIqCPohQlb6VFkjcFfGi7g8lT0QchOArXzJcRUGQmNbooTJjH3B2J
         3EBPVbYAydWFbPPVrqgmr8wC2DBN5h3Z7A0hjKTXyiQbKuBED2rYHJne2tDhhO0rJB
         2FjNF+wt0bqUdpwXGosQC1AtH9aOmCNbCx4JGqSB3umRLLL2OIp3PmTxxWEFRKStvW
         QeExIvvbicz/H2RETL5ckN+tIBix8HRmK3G0YgSePdjWXpq+ViirRsCNcfvWZkGSgl
         uj9wd+FGq9IdXtEZ9w87uCp4lW4AhZbNuhSDDjw3cn/HDOR2cdyULLb3eRPtBMmI2x
         m/oCGW4xOKh4g==
Date:   Wed, 5 Apr 2023 21:16:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, Jun Li <jun.li@nxp.com>,
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
Message-ID: <20230405131637.GB11367@dragon>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
 <20230330143813.teid36w24a4esjsx@pengutronix.de>
 <20230403093812.rjj2wkusajsx5mwi@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403093812.rjj2wkusajsx5mwi@fatal.se>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:38:12AM +0200, Andreas Henriksson wrote:
> Hello Marco Felsch,
> 
> On Thu, Mar 30, 2023 at 04:38:13PM +0200, Marco Felsch wrote:
> > Hi,
> > 
> > On 23-03-27, Andreas Henriksson wrote:
> [...]
> > > / {
> > >     gpio-sbu-mux {
> > >         compatible = "gpio-sbu-mux";
> [...]
> > I didn't tested it but at the moment I don't see the problem with my
> > patch. 
> 
> As Jun Li helpfully explained my patch is not correct, so don't bother.
> 
> I don't have a problem with your patch, was just trying to share
> what I had done.
> 
> I've since learned that the board I'll be working on will not even have
> SS, so I will not pursue SBU. I'll most likely use your patches instead
> as they seem simpler than what I did and should fully meet my needs for
> an usb port that works in both host and device mode.
> 
> Not that it matters, but +1 from me on applying your patches.
> (If people are hesitant to do it because of lack of SS, then maybe
> that could be adressed by adding a comment setting the expectations?)

Marco,

Could you update the patch to mention a bit about Super-Speed support
as discussed here?

Shawn
