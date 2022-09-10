Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9959C5B4617
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIJLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIJLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:37:19 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA35A81E;
        Sat, 10 Sep 2022 04:37:15 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 44E6126F009; Sat, 10 Sep 2022 13:37:14 +0200 (CEST)
Date:   Sat, 10 Sep 2022 13:37:14 +0200
From:   Janne Grunau <j@jannau.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] dt-bindings: arm: apple: Add t6001/t6002 Mac
 Studio compatibles
Message-ID: <20220910113714.GC4024@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-5-j@jannau.net>
 <25b42684-1bee-b7f6-a89d-ed0b0ea7428b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b42684-1bee-b7f6-a89d-ed0b0ea7428b@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-10 11:57:34 +0200, Krzysztof Kozlowski wrote:
> On 09/09/2022 15:50, Janne Grunau wrote:
> > This adds the following apple,t6001 platform:
> > 
> > - apple,j375c - Mac Studio (M1 Max, 2022)
> > 
> > And the initial apple,t6002 platform:
> > 
> > - apple,j375d - Mac Studio (M1 Ultra, 2022)
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > 
> >  Documentation/devicetree/bindings/arm/apple.yaml | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> > index 8d93e8a6cc18..b34e56b9dc59 100644
> > --- a/Documentation/devicetree/bindings/arm/apple.yaml
> > +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> > @@ -19,12 +19,14 @@ description: |
> >    - MacBook Air (M1, 2020)
> >    - iMac (24-inch, M1, 2021)
> >  
> > -  And devices based on the "M1 Pro" and "M1 Max" SoCs:
> > +  And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
> >  
> >    - MacBook Pro (14-inch, M1 Pro, 2021)
> >    - MacBook Pro (14-inch, M1 Max, 2021)
> >    - MacBook Pro (16-inch, M1 Pro, 2021)
> >    - MacBook Pro (16-inch, M1 Max, 2021)
> > +  - Mac Studio (M1 Max, 2022)
> > +  - Mac Studio (M1 Ultra, 2022)
> >  
> >    The compatible property should follow this format:
> >  
> > @@ -79,8 +81,15 @@ properties:
> >            - enum:
> >                - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
> >                - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
> > +              - apple,j375c # Mac Studio (M1 Max, 2022)
> >            - const: apple,t6001
> >            - const: apple,arm-platform
> 
> Blank line.

Added. The other entries in this list are not separated by blank lines.  
What would preferred to fix this? A whitespace only patch or can just 
add those additional blank lines in this change?

> > +      - description: Apple M1 Ultra SoC based platforms
> 
> With this:
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,
Janne
