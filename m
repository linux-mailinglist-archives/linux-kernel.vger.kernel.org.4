Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8B6F4E59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjECBHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81E26A9;
        Tue,  2 May 2023 18:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3113562966;
        Wed,  3 May 2023 01:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACDDC433D2;
        Wed,  3 May 2023 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683076064;
        bh=+6ESEH6CNCFUK2sfZ53/501y8pCQiTuc2ZPOHQUN9TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPWnDg2ss0E738YSakcizL8/x844h+J3IdVyUhVwgX+Ls6Cqzht4oG1/cShxmYM/L
         JNYTGudEDbmJH4hvky/CVwtYCNL5x8GBfKk+HYiAJxwTnsJFSdQm13kwzLnhpQ0ZyM
         XbM2kEZDAyYpn1ONvjlId/KMhBzpvqRVDdtM0x0Bzxejae3qMLoUF8c2CeJvtxc/AA
         FxHc0dG1FfgbN/EhtTDtwQqcsKLxhJKH6k+/5ItLCkIW9OJKwx+BgiSYm9SA6FKjd+
         yMwXUbYDkWJhZvFMEzeuubGYQz+45DFUF73gChV7FRS6HCorRo0BvvMo+NWR+vdDne
         vtYuxWqLAPiMw==
Date:   Wed, 3 May 2023 09:07:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
Message-ID: <20230503010731.GA31464@dragon>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com>
 <20230405130649.GA11367@dragon>
 <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230406014013.GJ11367@dragon>
 <ZEDzkhtUiUxQ0V4d@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDzkhtUiUxQ0V4d@kroah.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:10:58AM +0200, Greg KH wrote:
> On Thu, Apr 06, 2023 at 09:40:13AM +0800, Shawn Guo wrote:
> > On Thu, Apr 06, 2023 at 01:18:43AM +0000, Peng Fan wrote:
> > > Hi Shawn,
> > > 
> > > > Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
> > > > 
> > > > On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Per binding doc, update the compatible
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > ARM: dts: imx7ulp: ...
> > > > 
> > > > Fixed it up and applied all DTS patches.
> > > [Peng Fan] 
> > > 
> > > Thanks for the fix. But I think Greg already applied the patchset.
> > 
> > Okay, I will drop them from my tree, but ...
> > 
> > Greg,
> > 
> > May I suggest a couple of things on the future process?
> > 
> > - Could you leave i.MX DTS patches to me, so that we can avoid potential
> >   merge conflicts?
> 
> How am I supposed to know this?

Aren't we using patch prefix to tell the target subsystem?

> Our tools take the whole patch series,
> not individual ones.  If someone wants patches to go through different
> trees, then they need to submit them as different patch series,
> otherwise it makes no sense.

It's a quite common practice that people send a series containing
multiple patches targeting different subsystems, as that's what
reviewers have been asking for sake of completeness.  So we are asking
for two opposite things from what I can see.

Shawn
