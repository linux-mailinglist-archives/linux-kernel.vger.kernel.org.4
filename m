Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AD6D8CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjDFBk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDFBkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4465A9;
        Wed,  5 Apr 2023 18:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2896422A;
        Thu,  6 Apr 2023 01:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B69C433EF;
        Thu,  6 Apr 2023 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680745221;
        bh=JOshdqDasYx+VJ9V4GEhYO25QyIsnPmsnfB8panfAZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRab9knx16g2wEazV2BAeeL26/fwLPN3rb/U/M93+PQoH24dIOo15JCtXr0ZH9ybh
         70hfkNPrOWIZ3ioL8dPn6xFNnaFty/CHumTz7MbOiv1i9fRF5Q2haiaKZqV2ms7GqU
         8mK+2cLG2DONyrJdVgFIsxNtgR7bWZDhsfLxTFIctNjxjY/buU7MDlnTt6aVD8xlO1
         T0BM0t97S2p/uKDRm1OswRuHNhEokUlahg3tBjAR6QY5k+QYfJjZJuVSDbDDTHourR
         cFcaDXtrX0caNJXc9ycCr28uBnSHQML0puryKskL3ZDvxD+6H4uhEjkayrmf27kiH9
         1Gc/rZhHbpclw==
Date:   Thu, 6 Apr 2023 09:40:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>, gregkh@linuxfoundation.org
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
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
Message-ID: <20230406014013.GJ11367@dragon>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com>
 <20230405130649.GA11367@dragon>
 <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:18:43AM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
> > 
> > On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Per binding doc, update the compatible
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > ARM: dts: imx7ulp: ...
> > 
> > Fixed it up and applied all DTS patches.
> [Peng Fan] 
> 
> Thanks for the fix. But I think Greg already applied the patchset.

Okay, I will drop them from my tree, but ...

Greg,

May I suggest a couple of things on the future process?

- Could you leave i.MX DTS patches to me, so that we can avoid potential
  merge conflicts?

- Would you update your patch robot to reply the applying message to all
  recipients, so that everyone knows the status?

Shawn
