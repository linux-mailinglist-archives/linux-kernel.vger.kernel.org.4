Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBA654F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLWKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiLWKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:37:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB9D7B7F3;
        Fri, 23 Dec 2022 02:37:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA391FB;
        Fri, 23 Dec 2022 02:38:13 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84DD53FA32;
        Fri, 23 Dec 2022 02:37:31 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:37:25 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: firmware: arm,scmi: Add support for
 syspower protocol
Message-ID: <Y6WE1zQAxYYn6Ahz@e120937-lin>
References: <20221222183823.518856-1-cristian.marussi@arm.com>
 <20221222183823.518856-5-cristian.marussi@arm.com>
 <3d89e135-c8e4-ede4-950f-03900a660822@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d89e135-c8e4-ede4-950f-03900a660822@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:11:27AM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2022 19:38, Cristian Marussi wrote:
> > Add new SCMI Syspower protocol bindings definitions and example.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Got lost in translation probably...from txt to yaml
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 

Hi Krzysztof,

thanks for the feedback and sorry I posted with an incomplete Cc list.

> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 1c0388da6721..f3dd77a470dd 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -111,6 +111,12 @@ properties:
> >      required:
> >        - '#power-domain-cells'
> >  
> > +  protocol@12:
> > +    type: object
> > +    properties:
> > +      reg:
> > +        const: 0x12
> > +
> 
> Why? It did not got lost, it's already covered by pattern. If you refer
> to particular warning, please paste it in commit msg. Otherwise it looks
> incorrect.
> 

Yes indeed, but as a matter of fact it seemed to me that we used to add an
entry and an example for all the currently published standard SCMI protocols,
even though already covered by the patternProp (which covers also any
custom-vendor protocol in the wild) and not sporting any additional
custom properties (see protocol@18), but maybe this is just a unneeded wrong
habit adding only cruft to the bindings.

If you think it does not add any value I can happily drop this, or
limiting the addition just to the example (and/or drop equally the unneeded
protocol@18 node too in this case).

Thanks,
Cristian

