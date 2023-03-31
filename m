Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0316D6D179B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCaGlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCaGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0420F11162;
        Thu, 30 Mar 2023 23:41:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 11FAB8027;
        Fri, 31 Mar 2023 06:41:09 +0000 (UTC)
Date:   Fri, 31 Mar 2023 09:41:07 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230331064107.GU7501@atomide.com>
References: <20230329222246.3292766-1-andreas@kemnade.info>
 <20230330113918.GS7501@atomide.com>
 <20230330181506.4d5fcf51@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330181506.4d5fcf51@aktux>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230330 16:15]:
> On Thu, 30 Mar 2023 14:39:18 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [230329 22:22]:
> > > From: Andrew Davis <afd@ti.com>
> > > 
> > > Convert omap.txt to yaml.
> > >  Documentation/devicetree/bindings/arm/ti.yaml | 157 ++++++++++++++++++
> > >  1 file changed, 157 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml  
> > 
> > Great, can we also drop the old txt file or is more changes needed before
> > we can do that?
> >
> we have still 
> - ti,hwmods: list of hwmod names (ascii strings), that comes from the OMAP
>   HW documentation, attached to a device. Must contain at least
>   one hwmod.
> 
> Optional properties:
> - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
>   during suspend.
> - ti,no-reset-on-init: When present, the module should not be reset at init
> - ti,no-idle-on-init: When present, the module should not be idled at init
> - ti,no-idle: When present, the module is never allowed to idle.

These are documented in the ti-sysc.yaml for the current SoCs, but not for
the legacy SoC still using ti,hwmods.

> These optional properties are not in the root node but in subnodes.
> From my guts feeling this belongs in a separate file and should
> be somehow dealed with in a second step.

Agreed.

> So how to proceed?

How about just rename the hwmods related parts of omap.txt to something like
ti-hwmods.txt?

> BTW: I think this file then also belongs into
> OMAP2+ SUPPORT section of MAINTAINERS

Yeah that helps for receiving related emails :)

Regards,

Tony
