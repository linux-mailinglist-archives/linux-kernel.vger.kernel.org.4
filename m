Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310F6A9511
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCCKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCCKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:19:08 -0500
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ACD168B0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:19:06 -0800 (PST)
Date:   Fri, 3 Mar 2023 11:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677838744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kW2dzd3rEyl+CD4yLWkK8l1i2WlSV/ZTeNH0M+2hcM=;
        b=DS4XUpMPlzbaKHRnAVpOzr/6GUmjnedAJsaqpX/wb6EhL3t6Fr33Sz2Uzmsh2OpDAYagMr
        Zy8AbU6hmF8dGJaZLw0bUc4fp5EjJl42mF4bIsxVdKJYGWQaQ8vWDhrsznYPnLeJDNmU3+
        j93ojnIj4e3TMysRnxoWACvYytH0HKk=
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
        Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: maxim,max9867: add clocks
 property
Message-ID: <ZAHJlPlLRrz81hmv@g0hl1n.net>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
 <20230302-max9867-v2-2-fd2036d5e825@skidata.com>
 <45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
thanks for the review and quick response!

On Fri, Mar 03, 2023 at 11:09:15AM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2023 11:04, richard.leitner@linux.dev wrote:
> > From: Richard Leitner <richard.leitner@skidata.com>
> > 
> > Add clocks property to require a "mclk" definition for the
> > maxim,max9867 codec.
> 
> But why? You just wrote what the patch does, which is easy to see.
> Commit msgs should explain why you are doing something.

Ok. Will adapt the message in v3.

> 
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> > ---
> >  Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > index 74cd163546ec..6f27029b137d 100644
> > --- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
> > @@ -35,9 +35,13 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  clocks:
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > +  - clocks
> >  
> >  additionalProperties: false
> >  
> > @@ -50,6 +54,13 @@ examples:
> >              compatible = "maxim,max9867";
> >              #sound-dai-cells = <0>;
> >              reg = <0x18>;
> > +            clocks = <&codec_clk>;
> >          };
> >      };
> > +
> > +    codec_clk: clock {
> > +        compatible = "fixed-clock";
> > +        #clock-cells = <0>;
> > +        clock-frequency = <12288000>;
> 
> Drop the node, it's entirely common/regular stuff.

True. I thought it is nessecary for
	"make DT_CHECKER_FLAGS=-m dt_binding_check"
to succeed. But I just learned it in fact isn't.
Thanks for the pointer and that eureka moment 😉.

Will fix that in v3.

> 
> Best regards,
> Krzysztof
> 

regards;rl
