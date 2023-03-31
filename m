Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112986D1F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCaLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:37:19 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428AD171F;
        Fri, 31 Mar 2023 04:37:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3E7548027;
        Fri, 31 Mar 2023 11:37:16 +0000 (UTC)
Date:   Fri, 31 Mar 2023 14:37:14 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230331113714.GV7501@atomide.com>
References: <20230329222246.3292766-1-andreas@kemnade.info>
 <20230330113918.GS7501@atomide.com>
 <20230330181506.4d5fcf51@aktux>
 <191c96d2-e51a-550e-16d9-0403e4528885@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191c96d2-e51a-550e-16d9-0403e4528885@linaro.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [230331 09:43]:
> On 30/03/2023 18:15, Andreas Kemnade wrote:
> > On Thu, 30 Mar 2023 14:39:18 +0300
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> >> * Andreas Kemnade <andreas@kemnade.info> [230329 22:22]:
> >>> From: Andrew Davis <afd@ti.com>
> >>>
> >>> Convert omap.txt to yaml.
> >>>  Documentation/devicetree/bindings/arm/ti.yaml | 157 ++++++++++++++++++
> >>>  1 file changed, 157 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml  
> >>
> >> Great, can we also drop the old txt file or is more changes needed before
> >> we can do that?
> >>
> > we have still 
> > - ti,hwmods: list of hwmod names (ascii strings), that comes from the OMAP
> >   HW documentation, attached to a device. Must contain at least
> >   one hwmod.
> > 
> > Optional properties:
> > - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
> >   during suspend.
> > - ti,no-reset-on-init: When present, the module should not be reset at init
> > - ti,no-idle-on-init: When present, the module should not be idled at init
> > - ti,no-idle: When present, the module is never allowed to idle.
> > 
> > These optional properties are not in the root node but in subnodes.
> > From my guts feeling this belongs in a separate file and should
> > be somehow dealed with in a second step.
> > 
> > So how to proceed?
> 
> Any compatible converted to DT Schema should be removed from TXT. It
> does not mean entire TXT has to be removed if it contains other pieces.

Sounds good to me.

Tony
