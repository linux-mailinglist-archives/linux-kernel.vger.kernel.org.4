Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22967BD61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjAYUv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjAYUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:51:27 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978B40C1;
        Wed, 25 Jan 2023 12:51:25 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id j10-20020a4aa64a000000b004f9b746ee29so18717oom.0;
        Wed, 25 Jan 2023 12:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQVbrWoYnMKf9JjUe24dYiZOp19PTF28N+xF766er1I=;
        b=is5FE5RRd5tP/SB5eq56uPYVpi2DN3TexFfLCfeH6TA2kMdnK0UCi0yVXpKXoznQK6
         rn0s9sIiOw6NmZi5kKZGabQ5ZoOcaUIigKJn74xYaFcPNvpAT3eYrvLT1DY1uW0hxLLw
         hdnMT9wbheqHcqFCWnUFiPjWuIpBHC+Sz6yHfGK+QcnwzOXVm3cDqTymF2n81w70LiEB
         64uDVv71fykzvM07prKhK5c8RXaIoffyUF0LWfjFiMRdK4dV97XmpmXmz1XxZoYPSG5S
         kCxekshZhIIBKI1zxLOU8KTUEmIlbyIzFkdPWCUImau0uCRg7K99++7hsThze2fTnSyu
         TcsQ==
X-Gm-Message-State: AFqh2kpBPSL5AUfosyZeXAi4/n5i0Mn1aFqMt5tzHNtWSft8zZ9otQaI
        FqQTUAKnfAiwkbyX4DRjbQ==
X-Google-Smtp-Source: AMrXdXuHZrt3eV7Y8DZ6YQRziy5K5qbzuO8mzRSDv9R6GU+YzrFaJNGEeGfUFsf8fKj3usfMkowC/Q==
X-Received: by 2002:a4a:9445:0:b0:4fc:251b:a716 with SMTP id j5-20020a4a9445000000b004fc251ba716mr12197115ooi.2.1674679884608;
        Wed, 25 Jan 2023 12:51:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a4a984e000000b004fca8a11c61sm2336115ooi.3.2023.01.25.12.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:51:24 -0800 (PST)
Received: (nullmailer pid 2878538 invoked by uid 1000);
        Wed, 25 Jan 2023 20:51:23 -0000
Date:   Wed, 25 Jan 2023 14:51:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Message-ID: <20230125205123.GA2864330-robh@kernel.org>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-3-william.zhang@broadcom.com>
 <abedd2e8-3c7e-f347-06af-99f2e5a2412b@linaro.org>
 <ee4727e1-5705-edb0-c724-2ae4d4d1a8e2@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4727e1-5705-edb0-c724-2ae4d4d1a8e2@broadcom.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 11:23:52AM -0800, William Zhang wrote:
> 
> 
> On 01/24/2023 11:35 PM, Krzysztof Kozlowski wrote:
> > On 24/01/2023 23:12, William Zhang wrote:
> > > The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
> > > controller. Add new compatible strings to differentiate the old and new
> > > controller while keeping MIPS based chip with the old compatible. Update
> > > property requirements for these two revisions of the controller.  Also
> > > add myself and Kursad as the maintainers.
> > > 
> > > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > > 
> > > ---
> > > 
> > > Changes in v2:
> > > - Update new compatible string to follow Broadcom convention <chip
> > > specific compatible>, <version of the IP>, <fallback>
> > > - Add reg-names min/maxItem constraints to be consistent with reg
> > > property
> > > - Make interrupts required property
> > > - Remove double quote from spi-controller.yaml reference
> > > - Remove brcm,use-cs-workaround flag
> > > - Update the example with new compatile and interrupts property
> > > - Update commit message
> > > 
> > >   .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 106 +++++++++++++++++-
> > >   1 file changed, 101 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> > > index d1a0c9adee7a..d39604654c9e 100644
> > > --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> > > @@ -4,20 +4,73 @@
> > >   $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
> > >   $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > -title: Broadcom BCM6328 High Speed SPI controller
> > > +title: Broadcom Broadband SoC High Speed SPI controller
> > >   maintainers:
> > > +
> > 
> > This is a friendly reminder during the review process.
> > 
> > It seems my previous comments were not fully addressed. Maybe my
> > feedback got lost between the quotes, maybe you just forgot to apply it.
> > Please go back to the previous discussion and either implement all
> > requested changes or keep discussing them.
> > 
> > Thank you.
> > 
> Yeah I forgot to remove the blank line after maintainers tag.  Also
> regarding the explanation of dummy cs workaround flag,  we decided to remove
> it as it is not necessary after discussion internally and with SPI
> maintainer Mark. Let me know if I missed anything else.
> 
> > > +  - William Zhang <william.zhang@broadcom.com>
> > > +  - Kursad Oney <kursad.oney@broadcom.com>
> > >     - Jonas Gorski <jonas.gorski@gmail.com>
> > > -allOf:
> > > -  - $ref: spi-controller.yaml#
> > 
> > In your previous patch, put it already in desired place (after
> > "required:"), so you will not have to shuffle it.
> > 
> Will update the previous patch in v3
> 
> > > +description: |
> > > +  Broadcom Broadband SoC supports High Speed SPI master controller since the
> > > +  early MIPS based chips such as BCM6328 and BCM63268.  This initial rev 1.0
> > > +  controller was carried over to recent ARM based chips, such as BCM63138,
> > > +  BCM4908 and BCM6858. The old MIPS based chip should continue to use the
> > > +  brcm,bcm6328-hsspi compatible string. The recent ARM based chip is required to
> > > +  use the brcm,bcmbca-hsspi-v1.0 as part of its compatible string list as
> > > +  defined below to match the specific chip along with ip revision info.
> > > +
> > > +  This rev 1.0 controller has a limitation that can not keep the chip select line
> > > +  active between the SPI transfers within the same SPI message. This can
> > > +  terminate the transaction to some SPI devices prematurely. The issue can be
> > > +  worked around by either the controller's prepend mode or using the dummy chip
> > > +  select workaround. Driver automatically picks the suitable mode based on
> > > +  transfer type so it is transparent to the user.
> > > +
> > > +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
> > > +  controller rev 1.1 that add the capability to allow the driver to control chip
> > > +  select explicitly. This solves the issue in the old controller.
> > >   properties:
> > >     compatible:
> > > -    const: brcm,bcm6328-hsspi
> > > +    oneOf:
> > > +      - const: brcm,bcm6328-hsspi
> > > +      - items:
> > > +          - enum:
> > > +              - brcm,bcm47622-hsspi
> > > +              - brcm,bcm4908-hsspi
> > > +              - brcm,bcm63138-hsspi
> > > +              - brcm,bcm63146-hsspi
> > > +              - brcm,bcm63148-hsspi
> > > +              - brcm,bcm63158-hsspi
> > > +              - brcm,bcm63178-hsspi
> > > +              - brcm,bcm6846-hsspi
> > > +              - brcm,bcm6856-hsspi
> > > +              - brcm,bcm6858-hsspi
> > > +              - brcm,bcm6878-hsspi
> > > +          - const: brcm,bcmbca-hsspi-v1.0
> > > +          - const: brcm,bcmbca-hsspi
> > 
> > Why do you need "brcm,bcmbca-hsspi"? Nothing binds to it, so it's
> > useless and very generic.
> > 
> This was from Florian's suggestion and Broadcom's convention. See [1] and
> you are okay with that [2].  I added the rev compatible and you were not
> objecting it finally if I understand you correctly.

Can you have a driver that only understands what 'brcm,bcmbca-hsspi' is 
work on all h/w that includes the compatible string? It doesn't seem 
like it since v1.1 is a completely new driver. Therefore 
'brcm,bcmbca-hsspi' is pretty much useless.

Really, your 'generic' fallback for v1.0 should be 'brcm,bcm6328-hsspi' 
because that is the one the OS already supports. I don't know why folks 
get so hung up on saying new SoC block is compatible with old SoC's 
block.

The rule on using version numbers is they must correspond to something. 
FPGA soft IP with released versions is a good example. I always suspect 
a v1 or v1.0 is made up by the binding author.

Rob

