Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8A6EA579
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjDUIBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDUIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:01:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D87DA8;
        Fri, 21 Apr 2023 01:01:45 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3854820016;
        Fri, 21 Apr 2023 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682064104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lM3Fj3ldpENpDTMFM4FKFvcZdMUplwub02ZZyDtBwog=;
        b=m0LWHe8vih8+9CLvQ0PSRBwL/UFRo+rf2S9bDH9N1jeWb+oubiGWY9AM15rkH9nDTE2TRe
        0Y+PkYvBj3QOgd398D108Uidyphnbh5EicuIWalX091IyqJvjgdpTIfLylQ29New8Evk1G
        34p8QCQ+2qIh0pViLAhD2l3G3RaLDBQaDx0YmbzEi47yuSdLkaLo7N7odvcqbyadhgTisH
        8Py3jjhTFY7DsVAq0Bru6ChgdbjgDn8J7ypG2TsU3/F0ZkEwKyF8yBjJ6RJXvBPuC8OB0I
        xphiLQb8rXlG8A1wYHCz/ElwA9gCtWVaxn8tLDlMOCSLaH5/zmKJzAxOulid+Q==
Date:   Fri, 21 Apr 2023 10:01:41 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Message-ID: <20230421100141.2ad95eb7@bootlin.com>
In-Reply-To: <7d3d614f-b0e8-5d65-da9d-4ed7a7ba5e35@linaro.org>
References: <20230420121320.252884-1-herve.codina@bootlin.com>
        <20230420121320.252884-2-herve.codina@bootlin.com>
        <7d3d614f-b0e8-5d65-da9d-4ed7a7ba5e35@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 21 Apr 2023 09:32:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/04/2023 14:13, Herve Codina wrote:
> > The Renesas X9250 is a quad digitally controlled potentiometers.
> >   
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description:
> > +  The Renesas X9250 integrates four digitally controlled potentiometers.
> > +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> > +  X9250U has a 50 kOhms total resistance.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> > +  - $ref: /schemas/iio/iio.yaml
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,x9250t
> > +      - renesas,x9250u
> > +
> > +  reg:
> > +    description:
> > +      SPI device address.  
> 
> SPI bus does not have device addresses, AFAIR. Drop description.

Indeed, SPI has chip-select.
I will drop the description

> 
> > +    maxItems: 1
> > +
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#io-channel-cells'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        x9250@0 {  
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Will be change to potentiometer@0

> 
> > +            compatible = "renesas,x9250t";
> > +            reg = <0>;
> > +            spi-max-frequency = <2000000>;
> > +            #io-channel-cells = <1>;
> > +        };
> > +    };  
> 
> Best regards,
> Krzysztof
> 

The modifications will be present on v3 as v2 was already sent.

Thanks for the review,
Hervé

