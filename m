Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D9F6A8441
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCBOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCBOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:35:01 -0500
X-Greylist: delayed 6528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 06:34:44 PST
Received: from out-43.mta0.migadu.com (out-43.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360201117B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:34:44 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677767681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekEV5MAm7E6bjxp2q4ldu7Xx50sJODF+lRB04Y8cTWY=;
        b=YfxbP5WynmZcy/mSFqeS8QHrrfDbdj3xuSCY7Nbir/eL0wkrwMT1QYZLcNGOc2pLv4ipFE
        S00O9ppI7M8mC88e/oRAJsh7AhkuEd2tuJYR1l1vYYERKoYqHHEu8tnKE9g6F4plFuduMC
        jdKeqFfVfCr1e7TYwJ7FUuygQPCVQtI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ladislav Michl <ladis@linux-mips.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        devicetree@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
Message-ID: <ZACz/C/lMh/WsyrB@g0hl1n.net>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
 <167775917220.270950.1253335215666674705.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167775917220.270950.1253335215666674705.robh@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:05:02AM -0600, Rob Herring wrote:
> 
> On Thu, 02 Mar 2023 12:55:01 +0100, richard.leitner@linux.dev wrote:
> > From: Richard Leitner <richard.leitner@skidata.com>
> > 
> > Convert from max9867.txt to maxim,max9867.yaml and add missing
> > '#sound-dai-cells' property.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> > ---
> >  .../devicetree/bindings/sound/max9867.txt          | 17 --------
> >  .../devicetree/bindings/sound/maxim,max9867.yaml   | 51 ++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 17 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Thank you for the pointer, Rob!

Will fix those in v2 and from now on run 'make DT_CHECKER_FLAGS=-m
dt_binding_check' before sending any patches 😉

regards;rl

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/maxim,max9867.yaml: 'oneOf' conditional failed, one must be fixed:
> 	'unevaluatedProperties' is a required property
> 	'additionalProperties' is a required property
> 	hint: Either unevaluatedProperties or additionalProperties must be present
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> ./Documentation/devicetree/bindings/sound/maxim,max9867.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/sound/maxim,max9867.yaml#
> Error: Documentation/devicetree/bindings/sound/maxim,max9867.example.dts:18.9-13 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/sound/maxim,max9867.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230302-max9867-v1-1-aa9f7f25db5e@skidata.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
