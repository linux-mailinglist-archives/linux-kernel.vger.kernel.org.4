Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B36243CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKJOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:05:49 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CE6BDCF;
        Thu, 10 Nov 2022 06:05:45 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so1151018otb.8;
        Thu, 10 Nov 2022 06:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOZURf1rNwc3a/P6g5eCp63zwBi6WOS8mU3DMBFslXc=;
        b=EGOEoe5/BZMCp84suTQ4pJJYpot4y2SZJFpnYauCIxtY8zxC/nIR6ZxYcdQlzLrFqN
         ++uEQtxVu5tAlC3mR8JureWLs96ZUmL5hACgRxQfUyyBCAOjPjnEHn66NTbJisaVa0fv
         HthW34tKQqaBvifjgzXDJGRF0cYvLHi0Tb+Fy1itdGv9lAJFQytjQtRatenh2jAGLv77
         cj5qFAqdjFICJ2x/PlLFmM5Y7k+jHgEYlBR9YjGaZkZvz0U6ixXTIRlGOUscbBmyLtQw
         gkmqdf5o6It1I67DwFswsrZ3+ZHUKDHx0PkMYEkY7kOq/yT4FdIs0/zODnU1RDRLFrFG
         IwcA==
X-Gm-Message-State: ACrzQf1vLipuf3jIm6S0xT0AAZsysqhJRqXM2HW3FFiQkqsSr01EbJ/Q
        E3J8ggt5ppK+NHcG1FzuFg==
X-Google-Smtp-Source: AMsMyM7riFDmy8iAvwWMHq5A9Ozuew2LUgztFrHrpOF9ybb5AN+vyazkFQqfB5NU1iVCZF+AE+FCWg==
X-Received: by 2002:a05:6830:4113:b0:66c:3b12:82ab with SMTP id w19-20020a056830411300b0066c3b1282abmr31196465ott.172.1668089144035;
        Thu, 10 Nov 2022 06:05:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g81-20020a9d12d7000000b0066c44b4f2d6sm6534981otg.43.2022.11.10.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:05:43 -0800 (PST)
Received: (nullmailer pid 240905 invoked by uid 1000);
        Thu, 10 Nov 2022 14:05:45 -0000
Date:   Thu, 10 Nov 2022 08:05:45 -0600
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
Message-ID: <20221110140545.GA221642-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-7-miquel.raynal@bootlin.com>
 <20221110040055.GA3436769-robh@kernel.org>
 <20221110095034.7a80163a@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110095034.7a80163a@xps-13>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:50:34AM +0100, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Wed, 9 Nov 2022 22:00:55 -0600:
> 
> > On Fri, Nov 04, 2022 at 05:38:33PM +0100, Miquel Raynal wrote:
> > > Add a schema for the ONIE tlv NVMEM layout that can be found on any ONIE
> > > compatible networking device.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
> > >  .../nvmem/layouts/onie,tlv-layout.yaml        | 115 ++++++++++++++++++
> > >  2 files changed, 116 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > index f64ea2fa362d..8512ee538c4c 100644
> > > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > @@ -19,6 +19,7 @@ description: |
> > >  
> > >  oneOf:
> > >    - $ref: kontron,sl28-vpd.yaml
> > > +  - $ref: onie,tlv-layout.yaml
> > >  
> > >  properties:
> > >    compatible: true
> > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > new file mode 100644
> > > index 000000000000..1d91277324ac
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/nvmem/layouts/onie,tlv-layout.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVMEM layout of the ONIE tlv table
> > > +
> > > +maintainers:
> > > +  - Miquel Raynal <miquel.raynal@bootlin.com>
> > > +
> > > +description:
> > > +  Modern networking hardware implementing the Open Compute Project ONIE
> > > +  infrastructure shall provide a non-volatile memory with a table whose the
> > > +  content is well specified and gives many information about the manufacturer
> > > +  (name, country of manufacture, etc) as well as device caracteristics (serial
> > > +  number, hardware version, mac addresses, etc). The underlaying device type
> > > +  (flash, EEPROM,...) is not specified. The exact location of each value is also
> > > +  dynamic and should be discovered at run time because it depends on the
> > > +  parameters the manufacturer decided to embed.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: onie,tlv-layout
> > > +
> > > +  product-name: true  
> > 
> > This is a node? If so, you need:
> > 
> > type: object
> > additionalProperties: false
> 
> I thought referencing a schema under a property would be enough?
> 
> Indeed in nvmem.yaml we create the property nvmem-layout and make it
> reference nvmem-layout.yaml. Then, in nvmem-layout.yaml:
> 
> 	 oneOf:
> 	  - $ref: kontron,sl28-vpd.yaml
> 	  - $ref: onie,tlv-layout.yaml
> 
> we reference the different layouts that may apply (very much like what
> you proposed to list the mtd partition parsers, if I got it right).
> 
> Isn't it enough?

No. It is enough to allow the property, but nothing defines what it must 
be (a node) and what the node contains in the case of empty nodes. Try 
adding 'product-name = "foo";' and it won't warn.

Rob
