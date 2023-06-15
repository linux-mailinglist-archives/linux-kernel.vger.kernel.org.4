Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD107319FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbjFONai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbjFONa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:30:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7112948;
        Thu, 15 Jun 2023 06:30:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0781FB;
        Thu, 15 Jun 2023 06:31:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920DE3F64C;
        Thu, 15 Jun 2023 06:30:22 -0700 (PDT)
Date:   Thu, 15 Jun 2023 14:30:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
Message-ID: <20230615133020.pomw53jrzehbwahd@bogus>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org>
 <20230615084430.boamsz56kqqi3n6h@bogus>
 <CAPDyKFoiL47wadabh1jcOr4q4uwJm1UyhHHMnmVcys=bBBVcXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoiL47wadabh1jcOr4q4uwJm1UyhHHMnmVcys=bBBVcXQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:39:06AM +0200, Ulf Hansson wrote:
> On Thu, 15 Jun 2023 at 10:44, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> > > The protocol@13 node is describing the performance scaling option for the
> > > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > > performance scaling is in many cases not limited to switching a clock's
> > > frequency.
> > >
> > > Therefore, let's extend the binding so the interface can be modelled as a
> > > generic "performance domain" too. The common way to describe this, is to
> > > use the "power-domain" bindings, so let's use that.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: Conor Dooley <conor+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index 5824c43e9893..cff9d1e4cea1 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -145,8 +145,8 @@ properties:
> > >        '#clock-cells':
> > >          const: 1
> > >
> > > -    required:
> > > -      - '#clock-cells'
> >
> > I am yet to look at the patches, just looked at this binding changes for now.
> >
> > Won't this break compatibility with existing DTBs. IMO, this is strict
> > no no, you can't drop #clock-cells. I wanted to add performance-domains
> > here as alternative but decided to not as I knew you were working on this.
> 
> Thanks for reviewing!
> 
> The point with the suggested change was to allow any kind of
> combination of using #clock-cells and/or #power-domain-cells. Honestly
> I didn't really know how to best express that in the binding, but
> maybe someone can help me out here?
>

Even I don't know exact details, but there are rules like if this
property is present, some other property can't be there or something
on the similar lines. I have vague idea/recollection from my previous
experiments which probably was not needed then and hence I can't just
point to any examples unless I go and search myself.

> I think enforcing #clock-cells to be used is unnecessary. Making it
> optional should not break existing DTBs, right?

Correct. That is what I meant, it is either #clock-cells or
#power-domain-cells

>
> Moreover, currently it seems to be only Juno that uses "protocol@13"
> and the "#clock-cells" (at least by looking at the DTSes in-kernel).

Yes only one that has upstream DTS changes, but for sure it is used on
couple of other platforms. So for we are still far away from deprecate it
but we can eventually once users of it are ready to use new binding.

> So, I wonder if it's really such a big deal to update the DT bindings
> for "protocol@13" at this point, but I may not have the complete
> picture.
>

Yes it does break compatibility. Yes I know Juno is not a production
platform, but associating DT with kernel change makes is hard to switch
to older stable kernel versions without DT change which I really hate as
I will be wondering which SCMI perf is not working with stable kernel few
months down the line. So yes, we are not dropping the support for old
bindings even if it just for Juno(though I am sure it is not the only one).
I have spent time on such silly things when we were in the process of
pushing these bindings initially upstream. I prefer not to repeat that.

--
Regards,
Sudeep
