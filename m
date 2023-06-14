Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E4730AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjFNWqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:46:13 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3271FC3;
        Wed, 14 Jun 2023 15:46:09 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-34051bd5b6aso502935ab.1;
        Wed, 14 Jun 2023 15:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686782769; x=1689374769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzFbvoIJ4t4Nns2Tzp9MXVAK+Y2iKf78oAJPq6tM7i0=;
        b=lE2eWTkQpMwAy7k80mLkMOg8mC56Ruuf+yQ0fIgRmLCN49rWqlw1Q/WlmXNVV5QRNc
         4+yIml8zvuMrAgyZxcW9+lgMRfGoaEy6uCD30ivnat3oWX8VGMNYCLqp4oOuVqYTYnu1
         9Ypa2putJsS6w8jUGoe9k6pEdGNtgXt2l332MSPTqHbIJnbGnaQhjyjG7Psj+pGKjdJA
         xkoC5BQhV6/RacCIjLWohf64VQvR5Rqbf4VoLmlf3b0HsPkkSlA9K3QxyZrEjyviXjqR
         imLUjJtNkFHtRUpXCqfQVZwnFldmmBeD6QlKz+Cd9RXzNnDxDw8htBZoaxoEZ+/RmCUk
         Dxmw==
X-Gm-Message-State: AC+VfDxyw42jH4WtmWsDF2G1U2NTh61CmVWcwDZl1Bo8myweFDbFcfYn
        DlWi2QWJPzvxiGz6sisy/Q==
X-Google-Smtp-Source: ACHHUZ4vaIybEI80mWCKFbfdo6sDF5nVXQOHHmgAYr/oglK5WKoWospk26BObaNayqqpbT0oI+V27A==
X-Received: by 2002:a05:6e02:218f:b0:33e:747c:4ebb with SMTP id j15-20020a056e02218f00b0033e747c4ebbmr2353324ila.6.1686782769111;
        Wed, 14 Jun 2023 15:46:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d20-20020a02a494000000b0042312dc690csm124319jam.132.2023.06.14.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 15:46:08 -0700 (PDT)
Received: (nullmailer pid 3003004 invoked by uid 1000);
        Wed, 14 Jun 2023 22:46:05 -0000
Date:   Wed, 14 Jun 2023 16:46:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH 05/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Message-ID: <20230614224605.GB2990941-robh@kernel.org>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
 <20230606231252.94838-6-william.zhang@broadcom.com>
 <20230607101452.4c265d7e@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607101452.4c265d7e@xps-13>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:14:52AM +0200, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:45 -0700:
> 
> > Use new compatiable brcm,nand-bcmbca to support BCMBCA broadband
> > product. The old compatible string is still kept in the driver so old
> > dtb can still work.
> > 
> > Add brcm,nand-use-wp property to have an option for disabling this
> > feature on broadband board design that does not use write protection.
> > Add brcm,nand-ecc-use-strap to get ecc setting from board strap for
> > broadband board designs because they do not specify ecc setting in dts
> > but rather using the strap setting.
> > 
> > Remove the requirement of interrupts and interrupt-names properties to
> > reflect the driver code.
> > 
> > This patch also includes a few minor fixes to the BCM63xx compatibles
> > and add myself to the list of maintainers.
> > 
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > ---
> > 
> >  .../bindings/mtd/brcm,brcmnand.yaml           | 64 +++++++++++++------
> >  1 file changed, 43 insertions(+), 21 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > index 1571024aa119..1fe1c166a9db 100644
> > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
> >  maintainers:
> >    - Brian Norris <computersforpeace@gmail.com>
> >    - Kamal Dasu <kdasu.kdev@gmail.com>
> > +  - William Zhang <william.zhang@broadcom.com>
> >  
> >  description: |
> >    The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
> > @@ -18,9 +19,10 @@ description: |
> >    supports basic PROGRAM and READ functions, among other features.
> >  
> >    This controller was originally designed for STB SoCs (BCM7xxx) but is now
> > -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
> > -  iProc/Cygnus. Its history includes several similar (but not fully register
> > -  compatible) versions.
> > +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
> > +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
> > +  Its history includes several similar (but not fully register compatible)
> > +  versions.
> >  
> >    -- Additional SoC-specific NAND controller properties --
> >  
> > @@ -53,9 +55,9 @@ properties:
> >                - brcm,brcmnand-v7.2
> >                - brcm,brcmnand-v7.3
> >            - const: brcm,brcmnand
> > -      - description: BCM63138 SoC-specific NAND controller
> > +      - description: BCMBCA SoC-specific NAND controller
> >          items:
> > -          - const: brcm,nand-bcm63138
> > +          - const: brcm,nand-bcmbca
> >            - enum:
> >                - brcm,brcmnand-v7.0
> >                - brcm,brcmnand-v7.1
> > @@ -65,11 +67,15 @@ properties:
> >            - const: brcm,nand-iproc
> >            - const: brcm,brcmnand-v6.1
> >            - const: brcm,brcmnand
> > -      - description: BCM63168 SoC-specific NAND controller
> > +      - description: BCM63xx SoC-specific NAND controller
> >          items:
> > -          - const: brcm,nand-bcm63168
> > -          - const: brcm,nand-bcm6368
> > -          - const: brcm,brcmnand-v4.0
> > +          - enum:
> > +              - brcm,nand-bcm63168
> > +              - brcm,nand-bcm6368
> > +          - enum:
> > +              - brcm,brcmnand-v2.1
> > +              - brcm,brcmnand-v2.2
> > +              - brcm,brcmnand-v4.0
> >            - const: brcm,brcmnand
> >  
> >    reg:
> > @@ -111,6 +117,19 @@ properties:
> >        earlier versions of this core that include WP
> >      type: boolean
> >  
> > +  brcm,nand-use-wp:
> > +    description:
> > +      Use this integer to indicate if board design uses
> > +      controller's write protection feature and connects its
> > +      NAND_WPb pin to nand chip's WP_L pin. Driver defaults to
> > +      use this feature when this property does not exist.
> > +      Set to 0 if WP pins are not connected and feature is not
> > +      used. Set to 1 if WP pins are connected and feature is used.
> > +      Set to 2 if WP pins are connected but disable this feature
> > +      through driver that sets controller to output high on NAND_WPb.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> 
> Perhaps strings would be welcome. I'll let binding maintainers say what
> they think of it.

1 is redundant as it is the same as not present. Seems like a 
'brcm,disable-wp' boolean would suffice here.

Rob
