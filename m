Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759F62CCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiKPVec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiKPVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:34:28 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC86357;
        Wed, 16 Nov 2022 13:34:27 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-141ca09c2fbso12087684fac.6;
        Wed, 16 Nov 2022 13:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+ZlzYkuplMRebsJi5OrPD/kH9CmKl9L472+dM2aG/g=;
        b=HOkPKXFCmpHaRoxQf/YenfwMI/rXoDJmFrgUlev2FsFIEcdH6e042ly+8pZSguNHmB
         dzL3ukhVmldNiWSQ7K/glTx3OOyE59FqVDB6YnXxkVrKQX+kNyZ1ur0HOgOOxLYG+Lt8
         92+gZbCw02uBV+rly2rToc338gTL+vgEliw3LqvMg3Zl9RaYYRk6E3vCKniVywPw31Oc
         W7roybP69ZbvelZmDkFBAcE/5Ezt1wcpyzzm7pGp0z91QY+9FX24RKzNrDtoyWqVys2T
         KurdAWuaGn7lSUIa939iTwJCoDZGogh9WMFXOuG0m9g7f6JdiZ/YGDtcqb0Mae+CQ/Bx
         BAkA==
X-Gm-Message-State: ANoB5pkjZpAjsXZqwk6sUuFAGdCFeC8jeuKVc95mNjxf3Qw1coBXqApk
        hi1rFsq38yHebcmwKggjpwpGs3zMMw==
X-Google-Smtp-Source: AA0mqf6yap4g4QRYz0VqY0hN7kwbG6t72SavFayAaeKZWeRGWfUEoIBnSYQiDO/rm8BEannLJ4ZRpA==
X-Received: by 2002:a05:6870:7d1c:b0:13a:eee0:199a with SMTP id os28-20020a0568707d1c00b0013aeee0199amr2808726oab.61.1668634467061;
        Wed, 16 Nov 2022 13:34:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a056830110600b0066d12f2441esm7043142otq.27.2022.11.16.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:34:26 -0800 (PST)
Received: (nullmailer pid 996763 invoked by uid 1000);
        Wed, 16 Nov 2022 21:34:28 -0000
Date:   Wed, 16 Nov 2022 15:34:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Message-ID: <20221116213428.GA965204-robh@kernel.org>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
 <20221115110932.637091-2-Naresh.Solanki@9elements.com>
 <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
 <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:00:44AM +0530, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On 15-11-2022 07:34 pm, Krzysztof Kozlowski wrote:
> > On 15/11/2022 12:09, Naresh Solanki wrote:
> > > From: Marcello Sylvester Bauer <sylv@sylv.io>
> > > 
> > > The MAX597x is a hot swap controller with configurable fault protection.
> > > It also has 10bit ADC for current & voltage measurements.
> > > 
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > >   .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
> > >   1 file changed, 154 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > new file mode 100644
> > > index 000000000000..edf0c23db4ca
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > @@ -0,0 +1,154 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Regulator for MAX5970 smart switch from Maxim Integrated.
> > > +
> > > +maintainers:
> > > +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> > > +
> > > +description: |
> > > +  The smart switch provides no output regulation, but independent fault protection
> > > +  and voltage and current sensing.
> > > +  Programming is done through I2C bus.
> > > +
> > > +  Datasheets:
> > > +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> > > +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - maxim,max5970
> > > +      - maxim,max5978
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  leds:
> > > +    type: object
> > > +    description:
> > > +      Properties for four LEDS.
> > > +
> > > +    properties:
> > > +      "#address-cells":
> > > +        const: 1
> > > +
> > > +      "#size-cells":
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      "^led@[0-3]$":
> > > +        $ref: /schemas/leds/common.yaml#
> > > +        type: object
> > > +
> > > +    additionalProperties: false
> > > +
> > > +  vss1-supply:
> > > +    description: Supply of the first channel.
> > > +
> > > +  vss2-supply:
> > > +    description: Supply of the second channel.
> > > +
> > > +  regulators:
> > > +    type: object
> > > +    description:
> > > +      Properties for both regulators. Also set value for shunt resistor used.
> > 
> > You should explain not the syntax,  but what part of hardware this nodes
> > represents. Therefore "Also set value" does not fit at all. Hardware
> > sets value?
> You mean something like: Properties for power switch
> > 
> > I looked at datasheets to figure it out but they do not refer to any
> > configurable regulator, LDO nor "sw0/sw1/sw2". Therefore I have no clue
> > what to expect here...
> Yes this is for power switch part of max5970/8
> > 
> > > +
> > > +    patternProperties:
> > > +      "^sw[0-1]$":
> > > +        $ref: /schemas/regulator/regulator.yaml#
> > > +        type: object
> > > +        properties:
> > > +          shunt-resistor-micro-ohms:
> > > +            description: |
> > > +              The value of current sense resistor in microohms.
> > > +
> > > +        required:
> > > +          - shunt-resistor-micro-ohms
> > > +
> > > +      unevaluatedProperties: false
> > 
> > I don't think it has proper indentation. Did you test the binding?
> Definitely tested the bindings before I push the patch.

This kind of error was checked for 'properties', but not 
'patternProperties'. Now fixed.

Rob
