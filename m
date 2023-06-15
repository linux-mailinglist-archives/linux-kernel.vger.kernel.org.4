Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967B731341
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbjFOJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFOJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:11:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B92212C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:11:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bc405d9682cso1531515276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686820275; x=1689412275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQPLMyR4pKq4IPm2+bhCecPp0fIioHDXW0A5vWxMnNM=;
        b=TDChaGtQXK3DyxbLvJwl+OZ2YXx05CLUWvVyLhBHVuLJjFRwfdmfwm4PbibuKEQzVI
         zU3zmqorXPXshAUJgPSCw4aHTGOOzUcnIzdde8QAEt4TLbiJFPOxrUu15gEXigLiEep3
         qx8aHB6PgkcxelOgcGOR3yWfYJ6cpftV4Rk6rFvJPkeGOH6h+SZbUUhFWCJ4OpicHkuS
         RYR4oGsX0NxdpoXSz/gOWj/lFezgtAPCLTwp1IvOskQuu0ugNK7XpFJkfj+rYKQUYaA9
         tZwiyuPilGQJNkFbMAWXn1DdlxFuXKysvmrG6zvX0zLJQsY7IVBL3E+047etzA+4pjQi
         SMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820275; x=1689412275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQPLMyR4pKq4IPm2+bhCecPp0fIioHDXW0A5vWxMnNM=;
        b=S/NXtQfELwPzqswfi/VbvveXJj+QqbNgn9jP9QhUiYFgsijkBiE4Wd7fZeiI6WMylv
         3HMrKTD/7uNZvpzSb7Nmp4kriSPhMSVO6QNZnQYhl33UCNiWIkVWaCxra6Re+9628vQh
         5Ul2wYTTs9HMRonj5HyvZnp4Urtrc1nevj9Bx0WaRByxVA83bvHMi7d8GeLNyd0zNKJ3
         hVKQLyvDoK/XHLS32EihwPnaLJZFdQyt6C+B3FKa294TDJ0FP6YYQWMftJyoyNYpjXxu
         4EjfqhrlwkkwQtJQ35FVzYXHBuq2EZj6+1P31Ck+hArCl8ITwiH6lDofqQ0jV3gBtz8B
         utpg==
X-Gm-Message-State: AC+VfDzIxUVwhrPUBubPm5xHvbNEg9Qu4gHdinSQzxXkNgskoJhcRgbW
        58hUPBQcHNhaM39S/5gQB6hnVV4CAtAq/rTPFylVew==
X-Google-Smtp-Source: ACHHUZ7f5dssORqprATgmGMqMIzMYmVOhRrynA3S5iWIDXdxas0J0q2dH8bKuTq5gk5bBg+8ARmaLAGavyy7fvNeYNk=
X-Received: by 2002:a25:ae10:0:b0:ba7:99dc:908f with SMTP id
 a16-20020a25ae10000000b00ba799dc908fmr4095705ybj.27.1686820275299; Thu, 15
 Jun 2023 02:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org> <20230614230044.GA3019052-robh@kernel.org>
In-Reply-To: <20230614230044.GA3019052-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Jun 2023 11:10:38 +0200
Message-ID: <CAPDyKFoDQ12yUB-3f_V222kcUivP_NUcvcM+8s7CraLaBy7tBQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 01:00, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> > The protocol@13 node is describing the performance scaling option for the
> > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > performance scaling is in many cases not limited to switching a clock's
> > frequency.
> >
> > Therefore, let's extend the binding so the interface can be modelled as a
> > generic "performance domain" too. The common way to describe this, is to
> > use the "power-domain" bindings, so let's use that.
>
> What's wrong with the performance-domain binding?

In my opinion I think the performance-domain binding is superfluous.
We already have plenty of power-domains that do performance scaling
too - and they stick with the power-domain binding, as it's
sufficient.

That said, I would rather follow the defacto standard that has been
used for many years in the kernel. Do you have a preference that we
should stick to?

Kind regards
Uffe

>
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 5824c43e9893..cff9d1e4cea1 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -145,8 +145,8 @@ properties:
> >        '#clock-cells':
> >          const: 1
> >
> > -    required:
> > -      - '#clock-cells'
> > +      '#power-domain-cells':
> > +        const: 1
> >
> >    protocol@14:
> >      $ref: '#/$defs/protocol-node'
> > --
> > 2.34.1
> >
