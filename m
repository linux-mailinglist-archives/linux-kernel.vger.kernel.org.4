Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895C624AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKJTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:31:09 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0152228A;
        Thu, 10 Nov 2022 11:31:08 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13b23e29e36so3235687fac.8;
        Thu, 10 Nov 2022 11:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbf6I3VckrQCC7hSKLsVUD0gImYqojfbkHrsMs7jXfE=;
        b=EKr+DKwaDVKF84hGY+mbF632Tq3XDXDXVB7R+F2SUUahi8Y5Z7xxJJrurLeGPxn31L
         SmNdCYAK5FYoUw3kqzHhwfJGZoi2F47lLPuGXacGJSR82Hhxl5uIBs3458fzQPbouPV8
         HnqbdJPEw73hXKcgVNqdopwd7gNosErw7NHZxoBN1LxkBhrAteLMoCoPXdzMSMKd/yzI
         0iLMM8ygG5SXhVlZcrqJU7mB/q7922a1Jfli+AyAcqFa2S/ruDlbYKUzJcApVLPWY4f2
         SRn120SgcOjkopOi1JtTONN74AnZvGjinT4GTV9CY3NSBp9833gl+sDX/wCEobCPWC75
         E1oQ==
X-Gm-Message-State: ACrzQf3ZnpnW9ydqkBSrC4MEUv0XxBDhXkxlpOQfheCZPkyvaSK5HI+M
        NwZnfQrH9pQndoTST8gUM8UdK+29/g==
X-Google-Smtp-Source: AMsMyM4uWnD7gNNBGmff+/RJ1tj0X2d0N4xYeV7Qc3LrN/VhEhrJejG3uGPhsaEiB40x/jun3dEA8w==
X-Received: by 2002:a05:6870:b017:b0:13d:5532:d00a with SMTP id y23-20020a056870b01700b0013d5532d00amr1912864oae.71.1668108667437;
        Thu, 10 Nov 2022 11:31:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a056870468b00b0010d7242b623sm248602oap.21.2022.11.10.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:31:06 -0800 (PST)
Received: (nullmailer pid 856960 invoked by uid 1000);
        Thu, 10 Nov 2022 19:31:08 -0000
Date:   Thu, 10 Nov 2022 13:31:08 -0600
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
Subject: Re: [PATCH v3 4/6] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
Message-ID: <20221110193108.GA854032-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-5-miquel.raynal@bootlin.com>
 <20221110134918.GB3436769-robh@kernel.org>
 <20221110183855.05ced2a0@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110183855.05ced2a0@xps-13>
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

On Thu, Nov 10, 2022 at 06:38:55PM +0100, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Thu, 10 Nov 2022 07:49:18 -0600:
> 
> > On Fri, Nov 04, 2022 at 05:38:31PM +0100, Miquel Raynal wrote:
> > > From: Michael Walle <michael@walle.cc>
> > > 
> > > Add a schema for the NVMEM layout on Kontron's sl28 boards.
> > > 
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 60 +++++++++++++++++++
> > >  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
> > >  2 files changed, 63 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> > > new file mode 100644
> > > index 000000000000..44088c8b4153
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
> > > +
> > > +maintainers:
> > > +  - Michael Walle <michael@walle.cc>
> > > +
> > > +description:
> > > +  The vital product data (VPD) of the sl28 boards contains a serial
> > > +  number and a base MAC address. The actual MAC addresses for the
> > > +  on-board ethernet devices are derived from this base MAC address by
> > > +  adding an offset.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: kontron,sl28-vpd
> > > +
> > > +  serial-number:
> > > +    type: object
> > > +    description: The board's serial number
> > > +
> > > +  base-mac-address:
> > > +    type: object
> > > +    description:
> > > +      Base MAC address for all on-module network interfaces. The first
> > > +      argument of the phandle will be treated as an offset.
> > > +
> > > +    properties:
> > > +      "#nvmem-cell-cells":
> > > +        const: 1
> > > +
> > > +    additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +      otp-1 {
> > > +          compatible = "user-otp";
> > > +
> > > +          nvmem-layout {
> > > +              compatible = "kontron,sl28-vpd";
> > > +
> > > +              serial_number: serial-number {
> > > +              };
> > > +
> > > +              base_mac_address: base-mac-address {
> > > +                  #nvmem-cell-cells = <1>;
> > > +              };
> > > +          };
> > > +      };
> > > +
> > > +...
> > > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > index ecc7c37cbc1f..f64ea2fa362d 100644
> > > --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> > > @@ -17,6 +17,9 @@ description: |
> > >    define and might require dynamic reading of the NVMEM device in order to
> > >    perform their parsing. The nvmem-layout container is here to describe these.
> > >  
> > > +oneOf:
> > > +  - $ref: kontron,sl28-vpd.yaml  
> > 
> > This is the other way around from how we normally structure things. 
> > Normally, the specific schema would reference the common/base schema. 
> > This works, though you will be applying the schema twice. Once here and 
> > then by matching on compatible string. Not a big deal as that happens 
> > fairly often, but a 'select: false' in kontron,sl28-vpd.yaml would 
> > prevent that. This way does more to enforce the overall structure of 
> > nodes.
> 
> Oh right, I knew about the "select: false" thing, but I forgot it in
> the two layouts.
> 
> > The one downside I see with it this way is nvmem-layout can't ever have 
> > common properties defined without listing them in each layout schema.
> 
> Oh that's right, actually I solved it in the mtd dt-binding series with:
> 
> partitions.yaml:
> 
> 	oneOf:
> 	  - $ref: <parser>.yaml
> 
> 	generic-property:
> 	  $ref: something
> 	  min/max...: foo
> 
> <parser>.yaml:
> 	generic-property: true
> 
> But in this case, are the constraints provided by partitions.yaml on
> "generic-property" actually still enforced?

Yes, they are. 

Rob
