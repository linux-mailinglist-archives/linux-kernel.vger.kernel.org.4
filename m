Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4335B461B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIJLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:43:28 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F341476FF;
        Sat, 10 Sep 2022 04:43:26 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 056FB26F009; Sat, 10 Sep 2022 13:43:24 +0200 (CEST)
Date:   Sat, 10 Sep 2022 13:43:24 +0200
From:   Janne Grunau <j@jannau.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/10] dt-bindings: apple,aic: Fix required item
 "apple,fiq-index" in affinity description
Message-ID: <20220910114324.GD4024@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-2-j@jannau.net>
 <874jxfqzvj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jxfqzvj.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-10 11:37:20 +0100, Marc Zyngier wrote:
> On Fri, 09 Sep 2022 14:50:54 +0100,
> Janne Grunau <j@jannau.net> wrote:
> > 
> > Fixes: dba07ad11384 ("dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts")
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > 
> >  .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > index 85c85b694217..e18107eafe7c 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > @@ -96,7 +96,7 @@ properties:
> >                Documentation/devicetree/bindings/arm/cpus.yaml).
> >  
> >          required:
> > -          - fiq-index
> > +          - apple,fiq-index
> >            - cpus
> >  
> >  required:
> 
> With a commit message added,

I've added

| The required list used "fiq-index" instead of "apple,fiq-index"
| described as property and used in the dts. Add the missing "apple,"
| prefix.

as commit description.

> Acked-by: Marc Zyngier <maz@kernel.org>

Thanks,
Janne
