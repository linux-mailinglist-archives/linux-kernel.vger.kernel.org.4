Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3B5B6553
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIMCDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIMCDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BF225298;
        Mon, 12 Sep 2022 19:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FD47612E1;
        Tue, 13 Sep 2022 02:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B31BC433C1;
        Tue, 13 Sep 2022 02:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663034609;
        bh=dAg3FZ9zu3IH+ISvygDYxRdgqtmYTOxxK0xZvwzsjFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KewjEPEOJz4TyYv1p3rKYGZmT8zfkngZMS5S/fbreu/5YOvUiHrh9jxOwE55r7wWD
         iE2Kc3N+YtHp1ux0Y2+aaLKvkjhaeBAVaSkRMxgRECdXM1ImDOKgwnmxQxiV3khSAn
         xZ6/p64aPCNTXX2niNrE3HtuYtn3I7P+mCJs5ErXtvRk45FCF5DA7vgpljANnaD4TO
         CxXMFPqqEDbOT9GVs0xTI0Ojy/w6Zw5T5RQCmzU9U34jQn+7YdtLzHErJQI0hrVhdx
         TwYbYHOulETuC8kCuVbSvzJs8W9Zux2t1QVo0C+JoDQZFfgfmSj0edLAARizaM2vVf
         2agfYJoP1wsag==
Date:   Tue, 13 Sep 2022 10:03:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Olof Johansson <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Message-ID: <20220913020323.GD1728671@dragon>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
 <20220817202538.21493-2-leoyang.li@nxp.com>
 <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
 <AM0PR04MB6289B28243FCBA64CAD110B98F449@AM0PR04MB6289.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6289B28243FCBA64CAD110B98F449@AM0PR04MB6289.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 08:25:39PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Olof Johansson <olof@lixom.net>
> > Sent: Monday, September 12, 2022 2:05 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: shawnguo@kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Z.Q. Hou <zhiqiang.hou@nxp.com>
> > Subject: Re: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
> > rev2 silicon
> > 
> > Hi,
> > 
> > On Wed, Aug 17, 2022 at 1:26 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > The original dts was created based on the non-production rev1 silicon
> > > which was only used for evaluation.  Update the PCIe nodes to align
> > > with the different controller used in production rev2 silicon.
> > 
> > How can I confirm what version of silicon I have on a system?
> > 
> > My non-evaluation commercially purchased system (HoneyComb LX2K) has:
> > 
> > # cat /sys/bus/soc/devices/soc0/revision
> > 1.0
> 
> This is different from the information I got.  If there is still active Rev1.0 system in use, I would agree that we probably need to create a new device tree for the rev2 silicon.  Thanks for the information.

Dropped both patches.

Shawn
