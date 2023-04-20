Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0E6E8C53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjDTILF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjDTILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D2173A;
        Thu, 20 Apr 2023 01:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94573645CB;
        Thu, 20 Apr 2023 08:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371AC433D2;
        Thu, 20 Apr 2023 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681978262;
        bh=cRkJJtkBCNc6QMnaPnruYpRLA9mN0/qvOe5piHP2PL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwyuRbNTuY014OIygJWopqNWMjjzNCDieFS4GhXJ2NSLsERU+0C9VWL2CWYisnvjb
         R0Djg8vlgNA6K+bSAsN1QAztj87ny2HdQkF3o14W2QbblQUdKKMV0sFP3AIACuKpOh
         n1c8YZX7x9fW2TdV06CoYnVQo8Rr6CKHZjLrBx68=
Date:   Thu, 20 Apr 2023 10:10:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <ZEDzkhtUiUxQ0V4d@kroah.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com>
 <20230405130649.GA11367@dragon>
 <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230406014013.GJ11367@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406014013.GJ11367@dragon>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:40:13AM +0800, Shawn Guo wrote:
> On Thu, Apr 06, 2023 at 01:18:43AM +0000, Peng Fan wrote:
> > Hi Shawn,
> > 
> > > Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
> > > 
> > > On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Per binding doc, update the compatible
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > 
> > > ARM: dts: imx7ulp: ...
> > > 
> > > Fixed it up and applied all DTS patches.
> > [Peng Fan] 
> > 
> > Thanks for the fix. But I think Greg already applied the patchset.
> 
> Okay, I will drop them from my tree, but ...
> 
> Greg,
> 
> May I suggest a couple of things on the future process?
> 
> - Could you leave i.MX DTS patches to me, so that we can avoid potential
>   merge conflicts?

How am I supposed to know this?  Our tools take the whole patch series,
not individual ones.  If someone wants patches to go through different
trees, then they need to submit them as different patch series,
otherwise it makes no sense.

> - Would you update your patch robot to reply the applying message to all
>   recipients, so that everyone knows the status?

Can't really do that, it only responds to those that are on the patch
signed-off-by list itself, as the other cc: metadata is gone after the
patch is applied.

thanks,

greg k-h
