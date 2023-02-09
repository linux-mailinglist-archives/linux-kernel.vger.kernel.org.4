Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9369101B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBISMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBISM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:12:26 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EF5EBC8;
        Thu,  9 Feb 2023 10:12:06 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16a7f5b6882so3591361fac.10;
        Thu, 09 Feb 2023 10:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6XnIAiAClL5oAiPclHzd+Qs8gc/SNlQ6u+IiIFu1NM=;
        b=jLTyJAAcBsK29xziUvesmAsWyNMvjCG1GSSFGch1OOExtCYl3z1lJ0kMHDLUq4i2aD
         WWIjn9w27v4edDliJiu6ZStXqcQPgT2ygYagPwDTqTzOrTztiMYOf0CMkc7x1jsICTHX
         YwOqsWcHehdUuWpers/wayd3ZM04pDfwT44c2X41+ffg8CDQzfjfQO5CyWqfbW8boB7I
         EEiUUAMmQjilxABBj4Y3KHCKERo+4rTXA1IAZGa+roCBE6eLXajVi+sP3ln/myfni2ON
         1/D4o9YLPzDbRSxubjWsPVYX9YLcE62VNse2hZOFg7BqIHODuIQZqK/+S/KYIKUxRbXc
         w2og==
X-Gm-Message-State: AO0yUKXIa9PP388aTgc5Eo9U7jbPv+F6G+z9fIJ2wiDAS94fknAi6tUJ
        STxlJbE/nXPqyvU6hqnZ3g==
X-Google-Smtp-Source: AK7set8RezWLgO8rJBbJEYH7HXlrkAborpT0Rbl7VhLs+8Jkmk2Zcuf8wsK3c7crwWe+tqDB/W2o0A==
X-Received: by 2002:a05:6870:e0cf:b0:163:3b10:d366 with SMTP id a15-20020a056870e0cf00b001633b10d366mr6740835oab.47.1675966309737;
        Thu, 09 Feb 2023 10:11:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v35-20020a056870956300b0016a9f1616b0sm998708oal.5.2023.02.09.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:11:49 -0800 (PST)
Received: (nullmailer pid 584278 invoked by uid 1000);
        Thu, 09 Feb 2023 18:11:48 -0000
Date:   Thu, 9 Feb 2023 12:11:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, airlied@gmail.com,
        tomeu.vizoso@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        steven.price@arm.com, linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: gpu: mali-bifrost: Don't allow
 sram-supply by default
Message-ID: <20230209181148.GA575482-robh@kernel.org>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-2-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Gm=Onu2RK+skLgN4Kzo9yP1n5Zb48oQNkQ019838QeEQ@mail.gmail.com>
 <0faf89cb-4709-17c9-0d67-da7ef2ddb7e6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faf89cb-4709-17c9-0d67-da7ef2ddb7e6@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:15:33AM +0100, AngeloGioacchino Del Regno wrote:
> Il 09/02/23 03:50, Chen-Yu Tsai ha scritto:
> > On Wed, Feb 8, 2023 at 6:37 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > The sram-supply is MediaTek-specific, it is and will ever be used
> > > only for the mediatek,mt8183-mali compatible due to the addition of
> > > the mediatek-regulator-coupler driver: change the binding to add
> > > this supply when mediatek,mt8183-mali is present as a compatible
> > > instead of disabling it when not present.
> > > 
> > > This is done in preparation for adding new bindings for other
> > > MediaTek SoCs, such as MT8192 and others.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > index 78964c140b46..69212f3b1328 100644
> > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > > @@ -57,8 +57,6 @@ properties:
> > > 
> > >     mali-supply: true
> > > 
> > > -  sram-supply: true
> > > -
> > 
> > Have you tried actually validating the device trees against this?
> > Based on my previous tests this gives out errors.
> 
> I did... and I didn't get any complaint... but perhaps something went wrong
> on my side?
> 
> I mean, I can retry just to be sure.

You should need unevaluatedProperties instead of additionalProperties 
for this to work. The latter cannot 'see' into an if/then schema.

But really we want the default top level to allow this and then disallow 
it in an if/then schema.

Rob
