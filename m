Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0A62F3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiKRLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbiKRLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:40:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDF922F2;
        Fri, 18 Nov 2022 03:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C7D62477;
        Fri, 18 Nov 2022 11:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE23EC433C1;
        Fri, 18 Nov 2022 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668771598;
        bh=UyIeX4juBfKya0K1/HX+JueHL5NQPp5TQEvklryvzNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJ4tDZoV5W9JF8PAOclsTT5ToNGkLexs/PwJkqmZreR0EdACw7YVGMVOyCnnb4VVz
         TcKQEvM3E7lLx8t3TMP5LqFERmYh1ATjVPsYsYUCsiTq6NEL/UrlPGPsvaRlEmdfY8
         a6yPjVm8ivWZWZ+4crk39YrZTUZk8i+UbH78Q1B04Ua6HVKJLwjD5X9Sia95tafMnY
         LC+PC27gbYrIZhUbPWKJTTPxOXzoIsdMsV/527ys1K2yODCwhZLumIRn36bsg/C8AS
         9BYtKLaxyGyhc0oms5RPDgutUJP8SsdICdZuUDrRYBUeTYV/wTjLnqz9phuzmE5z/e
         5sz9kMlYWeFMA==
Date:   Fri, 18 Nov 2022 11:39:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Message-ID: <Y3dvCPP1g0LzzHFO@spud>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com>
 <Y3duiJguYE6VrVLP@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3duiJguYE6VrVLP@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:37:50AM +0000, Conor Dooley wrote:
> On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > This cache controller is also used on the StarFive JH7110 SoC.
> 
> "... and configured identically to that of the FU740"?
> Anyways,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Actually, after looking at the next patch - why can you not fall back to
the fu740 one since you appear to have the same configuration as it?

> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../devicetree/bindings/riscv/sifive,ccache0.yaml          | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> > index bf3f07421f7e..262d1d49ce25 100644
> > --- a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> > @@ -25,6 +25,7 @@ select:
> >            - sifive,ccache0
> >            - sifive,fu540-c000-ccache
> >            - sifive,fu740-c000-ccache
> > +          - starfive,jh7110-ccache
> >  
> >    required:
> >      - compatible
> > @@ -37,6 +38,7 @@ properties:
> >                - sifive,ccache0
> >                - sifive,fu540-c000-ccache
> >                - sifive,fu740-c000-ccache
> > +              - starfive,jh7110-ccache
> >            - const: cache
> >        - items:
> >            - const: microchip,mpfs-ccache
> > @@ -86,6 +88,7 @@ allOf:
> >              enum:
> >                - sifive,fu740-c000-ccache
> >                - microchip,mpfs-ccache
> > +              - starfive,jh7110-ccache
> >  
> >      then:
> >        properties:
> > @@ -105,7 +108,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: sifive,fu740-c000-ccache
> > +            enum:
> > +              - sifive,fu740-c000-ccache
> > +              - starfive,jh7110-ccache
> >  
> >      then:
> >        properties:
> > -- 
> > 2.38.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
