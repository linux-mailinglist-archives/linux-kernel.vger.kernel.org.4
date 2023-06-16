Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5BF733062
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbjFPLtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbjFPLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:49:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F92D60
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:49:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-570282233ceso7062027b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686916143; x=1689508143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uBENnlCBnEhufAnVuw+D3JGJ02jgGoa7hpaAB7hRNak=;
        b=xzNmgz7PTzYm+ZtJ4D0RC//YrnsN/UzT4jWuMkskjfXV8kRGJLcq8hh3bu5IeeY9Hg
         3/v3d9r1To28I8ZzYRXT12NDhnifOmUI780kmtUgnSD6sdtV8b2uaikUITa3CB978jzP
         KysSc6zpnNYgfHDriFA9L/RKS1YY8jk1XtCJrDWyee/IeDHlBtWDqd+GlEsGxe78lMVa
         NrAubJe5TCeCl/NUJ+yap/jO5UmvXzI0m1uziPlkVdVSS4HyxJX7GFfiHT7kHBx/bZV6
         coIOeDPP3LjeW1sygZOms271LwZoyIHy3ppsuvmTKZCeRmYNb39ERXVhryck0WwDMUYQ
         lpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916143; x=1689508143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBENnlCBnEhufAnVuw+D3JGJ02jgGoa7hpaAB7hRNak=;
        b=jH36dS4gx6gb37v90eKIUTep87HkHyb6uAf5ftyxcRCfOdhOfti9waN2rFNtT626Lu
         3Z80OEsWSd+KTWwroARvCTFyS63/mkI188Z77Oz1awVZr+xqsyRzPc5w5hw44fXYjJ08
         MV84BM/6zZAwAM8EPZO673VB6xG2/PdtXtrQeSM0ZpUUN/i1MkY3j/xp7IxTLoHD/Q97
         rVQROHK8uq3P93kJfCGjfY0gOH0hvTI/BQ0j7vNrQiwAHCF5ZMdmY3pWEECsVnBUTrZi
         6NSAsYvvlnnLO7qsRWcZQceJ+e6EWXt6Bio5L4ikMAx171N5rYFIi9FlVwpRqyOKrd7R
         LB1g==
X-Gm-Message-State: AC+VfDxAjN4CraUnqrYm2xkG8+rJUPNe789X0Pb8e0Odt9EXkyvZLOMO
        aSsqzK6QUvaUnfM/dRm/ZSF7ylnop4elkki8Is7RHA==
X-Google-Smtp-Source: ACHHUZ4wzr+01cdOuLafOhfNu3jhsS6jDdtPFQ6Ei5279VT+EIup/mDYSg4VKWw0E5ijIwT9qylQc9gkSW0cVwiQaec=
X-Received: by 2002:a0d:fe86:0:b0:570:48db:890 with SMTP id
 o128-20020a0dfe86000000b0057048db0890mr1409278ywf.6.1686916143226; Fri, 16
 Jun 2023 04:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org> <20230615084430.boamsz56kqqi3n6h@bogus>
 <CAPDyKFoiL47wadabh1jcOr4q4uwJm1UyhHHMnmVcys=bBBVcXQ@mail.gmail.com> <20230615133020.pomw53jrzehbwahd@bogus>
In-Reply-To: <20230615133020.pomw53jrzehbwahd@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Jun 2023 13:48:27 +0200
Message-ID: <CAPDyKFoWcyznGM7EYkuhSAB+6nNBvsPt77o5B3hyL06pwiFYMA@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 15:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jun 15, 2023 at 11:39:06AM +0200, Ulf Hansson wrote:
> > On Thu, 15 Jun 2023 at 10:44, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> > > > The protocol@13 node is describing the performance scaling option for the
> > > > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > > > performance scaling is in many cases not limited to switching a clock's
> > > > frequency.
> > > >
> > > > Therefore, let's extend the binding so the interface can be modelled as a
> > > > generic "performance domain" too. The common way to describe this, is to
> > > > use the "power-domain" bindings, so let's use that.
> > > >
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > > Cc: Conor Dooley <conor+dt@kernel.org>
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > index 5824c43e9893..cff9d1e4cea1 100644
> > > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > @@ -145,8 +145,8 @@ properties:
> > > >        '#clock-cells':
> > > >          const: 1
> > > >
> > > > -    required:
> > > > -      - '#clock-cells'
> > >
> > > I am yet to look at the patches, just looked at this binding changes for now.
> > >
> > > Won't this break compatibility with existing DTBs. IMO, this is strict
> > > no no, you can't drop #clock-cells. I wanted to add performance-domains
> > > here as alternative but decided to not as I knew you were working on this.
> >
> > Thanks for reviewing!
> >
> > The point with the suggested change was to allow any kind of
> > combination of using #clock-cells and/or #power-domain-cells. Honestly
> > I didn't really know how to best express that in the binding, but
> > maybe someone can help me out here?
> >
>
> Even I don't know exact details, but there are rules like if this
> property is present, some other property can't be there or something
> on the similar lines. I have vague idea/recollection from my previous
> experiments which probably was not needed then and hence I can't just
> point to any examples unless I go and search myself.

I will figure it out, np!

>
> > I think enforcing #clock-cells to be used is unnecessary. Making it
> > optional should not break existing DTBs, right?
>
> Correct. That is what I meant, it is either #clock-cells or
> #power-domain-cells

Should we allow both? Or maybe that is just confusing?

In either case, I am converting the scmi cpufreq driver to cope with
using #power-domain-cells too, as that is useful regardless I think.
However, that's a separate series on top of $subject series.

>
> >
> > Moreover, currently it seems to be only Juno that uses "protocol@13"
> > and the "#clock-cells" (at least by looking at the DTSes in-kernel).
>
> Yes only one that has upstream DTS changes, but for sure it is used on
> couple of other platforms. So for we are still far away from deprecate it
> but we can eventually once users of it are ready to use new binding.

Okay, let's discuss when to deprecate it, but let's do that later on.

>
> > So, I wonder if it's really such a big deal to update the DT bindings
> > for "protocol@13" at this point, but I may not have the complete
> > picture.
> >
>
> Yes it does break compatibility. Yes I know Juno is not a production
> platform, but associating DT with kernel change makes is hard to switch
> to older stable kernel versions without DT change which I really hate as
> I will be wondering which SCMI perf is not working with stable kernel few
> months down the line. So yes, we are not dropping the support for old
> bindings even if it just for Juno(though I am sure it is not the only one).
> I have spent time on such silly things when we were in the process of
> pushing these bindings initially upstream. I prefer not to repeat that.

Okay, thanks for sharing the information. Let's simply follow the
regular path of how we deal with deprecating DT bindings then.

Kind regards
Uffe
