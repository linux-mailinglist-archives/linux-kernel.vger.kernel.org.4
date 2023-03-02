Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A127F6A84B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCBO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCBO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:56:53 -0500
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738055042
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:56:35 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:56:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677768983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xxgz5UQd3A33vj8wyykxd/501uILI+WSmew/oO4u+js=;
        b=OIYZVa8xVYW7rLRG5+M8Y5DTCcm6aYWIjQV5dj4jeBysQwow6+hKr6Ay5EwiCLNmjrpHfS
        0J63xuoA0HSbKsvn/WVaBu8df/GaCw+Y80clS9UlprcV2K8HjBr8PDLSY9nC/ZCpEzccWT
        h08p39RfB9vrzEIgtVCzeMYY5ZsOj9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: maxim,max9867: add "mclk" property
Message-ID: <ZAC5Fb/6gGUuIFix@g0hl1n.net>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-2-aa9f7f25db5e@skidata.com>
 <53975f44-83cf-7942-ff2f-727a2d9a0bc3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53975f44-83cf-7942-ff2f-727a2d9a0bc3@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:31:45PM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2023 12:55, richard.leitner@linux.dev wrote:
> > From: Richard Leitner <richard.leitner@skidata.com>
> > 
> > Add clocks and clock-names properties to require a "mclk" definition for
> > the maxim,max9867 codec.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> > ---
> >  Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > index cefa43c3d34e..152340fe9cc7 100644
> > --- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > @@ -35,9 +35,17 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: "mclk"
> 
> Drop entire property, you do not need it for one clock.

Thanks. Will fix that in v2.

> 
> Best regards,
> Krzysztof
> 

regards;rl
