Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E672624AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKJTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiKJTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:47:54 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EAF48745;
        Thu, 10 Nov 2022 11:47:51 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id l127so2919906oia.8;
        Thu, 10 Nov 2022 11:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR7PfBBFXWDgtvphoa+N+o9kNLkWkh1L6J2nsVFNmro=;
        b=bQ7R2EizhCM6gbu/dutXSlpnb3pbNkPVmlPzTXrW61SjX1q1/+h1wJ09daX92jCYbm
         thC4YIj8f/AVHm+PaiAfr3n5OHWcZhy0qA15Fz2KwA/M7GbvybBm/uJR29ZJ303Xb8RY
         wn8hbC26xwaCZ+us2Dp+5kWXqVwkMBffz7Zq6eMb77Uaqw86wU91MAvw6tE+xAfVR9jw
         JHhK+s+/qFGCmzWuk9Ih0nWRJSDvGDXiraNaXD0ZGchWDl8usz+LkisTnPjFe41k5DQq
         +2/uEp47Pawwl8eLmYCAtsCJiYWdf+6QW+n2msc1ci6mufokT8iTVjesSUG8ZxeGxz6t
         GuBg==
X-Gm-Message-State: ACrzQf3fUD9EBxFrujqlrdQqZAp9YzEP3WyhMMHGthqmaGflAwJkfe+s
        9yIGn0btbMndB2xl04JG8A==
X-Google-Smtp-Source: AMsMyM6GPwYFNPOBXDM9hOL43OVVF9gvfKUaZhlla0pgFwsh9Ntq2K2j6reFq/Pw6b8dJrnwB3GM4Q==
X-Received: by 2002:a05:6808:200c:b0:35a:c6c:b8a7 with SMTP id q12-20020a056808200c00b0035a0c6cb8a7mr2022198oiw.275.1668109670832;
        Thu, 10 Nov 2022 11:47:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a9d7983000000b0063b24357269sm229980otm.13.2022.11.10.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:47:50 -0800 (PST)
Received: (nullmailer pid 878705 invoked by uid 1000);
        Thu, 10 Nov 2022 19:47:52 -0000
Date:   Thu, 10 Nov 2022 13:47:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: nvmem: add YAML schema for the ONIE
 tlv layout
Message-ID: <20221110194752.GB854032-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-7-miquel.raynal@bootlin.com>
 <20221110040055.GA3436769-robh@kernel.org>
 <20221110095034.7a80163a@xps-13>
 <20221110140545.GA221642-robh@kernel.org>
 <20221110184334.1cb531f6@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110184334.1cb531f6@xps-13>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:43:34PM +0100, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Thu, 10 Nov 2022 08:05:45 -0600:
> 
> > On Thu, Nov 10, 2022 at 09:50:34AM +0100, Miquel Raynal wrote:
> > > Hi Rob,
> > > 
> > > robh@kernel.org wrote on Wed, 9 Nov 2022 22:00:55 -0600:
> > >   
> > > > On Fri, Nov 04, 2022 at 05:38:33PM +0100, Miquel Raynal wrote:  
> > > > > Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
> > > > > compatible networking device.
> > > > > 
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
> > > > >  .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
> > > > >  2 files changed, 116 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > > > index f64ea2fa362d..8512ee538c4c 100644
> > > > > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > > > @@ -19,6 +19,7 @@ description: |
> > > > >  
> > > > >  oneOf:
> > > > >    - $ref: kontron,sl28-vpd.yaml
> > > > > +  - $ref: onie,tlv-layout.yaml
> > > > >  
> > > > >  properties:
> > > > >    compatible: true
> > > > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..1d91277324ac
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > > > @@ -0,0 +1,115 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: NVMEM layout of the ONIE tlv table
> > > > > +
> > > > > +maintainers:
> > > > > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > +
> > > > > +description:
> > > > > +  Modern networking hardware implementing the Open Compute Project ONIE
> > > > > +  infrastructure shall provide a non-volatile memory with a table whose the
> > > > > +  content is well specified and gives many information about the manufacturer
> > > > > +  (name, country of manufacture, etc) as well as device caracteristics (serial
> > > > > +  number, hardware version, mac addresses, etc). The underlaying device type
> > > > > +  (flash, EEPROM,...) is not specified. The exact location of each value is also
> > > > > +  dynamic and should be discovered at run time because it depends on the
> > > > > +  parameters the manufacturer decided to embed.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: onie,tlv-layout
> > > > > +
> > > > > +  product-name: true    
> > > > 
> > > > This is a node? If so, you need:
> > > > 
> > > > type: object
> > > > additionalProperties: false  
> > > 
> > > I thought referencing a schema under a property would be enough?
> > > 
> > > Indeed in nvmem.yaml we create the property nvmem-layout and make it
> > > reference nvmem-layout.yaml. Then, in nvmem-layout.yaml:
> > > 
> > > 	 oneOf:
> > > 	  - $ref: kontron,sl28-vpd.yaml
> > > 	  - $ref: onie,tlv-layout.yaml
> > > 
> > > we reference the different layouts that may apply (very much like what
> > > you proposed to list the mtd partition parsers, if I got it right).
> > > 
> > > Isn't it enough?  
> > 
> > No. It is enough to allow the property, but nothing defines what it must 
> > be (a node) and what the node contains in the case of empty nodes. Try 
> > adding 'product-name = "foo";' and it won't warn.
> 
> There was a misunderstanding on my side. I thought your comment was
> about the nvmem-layout node. Actually you were commenting about all the
> sub-nodes defining nvmem-cells inside, so I'm fully aligned with your
> response.
> 
> However, if I understood it correctly, you basically said that:
> 
> 	property:
> 	  $ref: foo.yaml
> 
> is not the same as:
> 
> 	property:
> 	  type: object
> 	  $ref: foo.yaml
> 
> If that's the case, then should we consider dropping this patch (which
> you agreed with in the first place)?

From a json-schema standpoint, they may not be the same. You can't know 
without knowing what's in foo.yaml. They are the same only if foo.yaml 
contains 'type: object'. It does for us because the tools will add 
'type: object' to the top-level of every schema file.


properties:
  property:
    properties:
      foo: {}

These would all pass validation with the above:

property;
property = "bar";

More generally, json-schema's behavior is if a keyword doesn't apply for 
an instance, just silently ignore it. So while 'properties' keyword only 
makes sense on an object or maxItems on an array, json-schema doesn't 
care. The dtschema tools do a bit to counteract that.

Rob
