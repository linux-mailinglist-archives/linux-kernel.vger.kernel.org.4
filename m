Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB773344E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbjFPPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbjFPPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C134A30F1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=2e0QfjoUB7j+dIQ8hHxPTkY8BoxRf92/f/giQUbJ0vs=; b=sa
        EUZaDUPhwcM1FR16r4kCzG0FcOVfhxC7RQvDfZUBM4ZrufYlNoGqmtoOg2Q2AJoNGP/tOgtxxvzoG
        g4TIqevD/vCZhOkUKjaNpQvKOhPMFDLaQLkibPYI2KZMBTWPB4C5hIWZ55cyySO+GGljOv/1Q4prU
        b+MSOYAUbQxaZBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qAB3y-00GjMT-Bb; Fri, 16 Jun 2023 17:08:34 +0200
Date:   Fri, 16 Jun 2023 17:08:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <1a183650-ffda-46bf-b2ff-1411c233d372@lunn.ch>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
 <2023061616-sacrifice-mollusk-737f@gregkh>
 <AM9PR04MB8907E5BF0A7F6448B2F7DF6DF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9PR04MB8907E5BF0A7F6448B2F7DF6DF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:28:05AM +0000, Alison Wang wrote:
> On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> > Ethos-U Linux driver is to provide an example of how a rich operating
> > system like Linux can dispatch inferences to an Arm Cortex-M
> > subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
> >
> > Link:
> > https://git/.
> > mlplatform.org%2Fml%2Fethos-u%2Fethos-u-linux-driver-stack.git&data=05
> > %7C01%7Calison.wang%40nxp.com%7C4b1681cd19b9450e832208db6e32709b%7C686
> > ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638224935139578328%7CUnknown%7
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > CI6Mn0%3D%7C3000%7C%7C%7C&sdata=jwhvw5i1Q2M%2FOLID8TsOOnaI9LqD6y%2BMnn
> > jzdvdCXcw%3D&reserved=0
> > Tag: 22.02
> 
> What does "Tag:" mean?
> 
> >
> > Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
> > Signed-off-by: Per Astrand <per.astrand@arm.com>
> > Signed-off-by: Jonny Svärd <jonny.svaerd@arm.com>
> > Signed-off-by: Lior Dekel <Lior.dekel@arm.com>
> > Signed-off-by: Henrik Hoglind <henrik.hoglind@arm.com>
> > Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> 
> If this many people signed off on this, it better be correct :)
> [Alison Wang] The source codes of this patch come from the kernel folder of https://git.mlplatform.org/ml/ethos-u/ethos-u-linux-driver-stack.git, the detailed tag is 22.02.
> So the source codes of this patch are written by Arm guys. The above people are all the authors. I list them all to avoid any missing.

Hi Alison

Maybe you should spend a few days reading email from others on the
list. Notice that netiquette style is used. Lines are wrapped to
around 80. Quoting is done using > etc. You are expected to follow
these guidelines.

Can i suggest you find somebody in NXP to be your mentor and help you
get up to speed with how mainline works. There are plenty of very good
mainline developers in the Ethernet group for example.

	Andrew
