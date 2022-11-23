Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DC63670A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiKWR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiKWR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:29:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4A8E08F;
        Wed, 23 Nov 2022 09:29:05 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHShp6mVZz67dbJ;
        Thu, 24 Nov 2022 01:26:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:29:03 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:29:02 +0000
Date:   Wed, 23 Nov 2022 17:29:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>, <jic23@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Message-ID: <20221123172901.00002918@Huawei.com>
In-Reply-To: <24e8464a-923d-cd0f-c681-fc6ca3a5ad59@linaro.org>
References: <20221118172407.765423-1-ciprian.regus@analog.com>
        <20221118172407.765423-2-ciprian.regus@analog.com>
        <24e8464a-923d-cd0f-c681-fc6ca3a5ad59@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 12:20:39 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 18/11/2022 18:24, Ciprian Regus wrote:
> > Add devicetree bindings documentation for the AD5754 DAC driver.
> > 
> > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> > ---
> >  changes in v3:
> >   - added additionalProperties: false to patternProperties
> >   - dropped status in the example.
> >   - added different values for adi,output-range-microvolt in the example.
> >     Negative values cannot be set since that will create a dt_bindings_check error.
> >  .../bindings/iio/dac/adi,ad5754.yaml          | 181 ++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> > new file mode 100644
> > index 000000000000..de0f6fab82b8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> > @@ -0,0 +1,181 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5754.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5754 DAC
> > +
> > +maintainers:
> > +  - Ciprian Regus <ciprian.regus@analog.com>
> > +
> > +description: |
> > +  Bindings for the AD5754 and other chip variants digital-to-analog
> > +  converters.
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5724_5734_5754.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5722_5732_5752.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5724r_5734r_5754r.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722R_5732R_5752R.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad5722
> > +      - adi,ad5732
> > +      - adi,ad5752
> > +      - adi,ad5724
> > +      - adi,ad5734
> > +      - adi,ad5754  
> 
> Keep the list sorted.
> 
> > +      - adi,ad5722r  
> 
> I would even suggest sorted entirely, so 5722r follows 5722, but I don't
> mind some combo-sorting (logical + alphabetical).

I was curious about this as well, so went digging.

Wonderfully they are grouped by logical set here - with each group of
3 being on a different datasheet (visible datasheet names above),
with associated commonality.

Still I'm fine with whatever ordering makes sense. Maybe it's just easier
to smash them into simple alphabetical order both here and in the driver
and not worry about where the order comes from.

If doing that, make sure you also do it for the sub lists below.

> 
> > +      - adi,ad5732r
> > +      - adi,ad5752r
> > +      - adi,ad5724r
> > +      - adi,ad5734r
> > +      - adi,ad5754r
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 30000000
> > +
> > +  spi-cpol: true
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator to use as an external reference. If this is not provided,
> > +      the internal reference will be used for chips that have this feature.
> > +      The external reference must be 2.5V.
> > +
> > +  clr-gpios:
> > +    description: DAC output clear GPIO (CLR pin). If specified, it will be set
> > +      to high during probe, thus allowing the DAC output to be updated.
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@([0-3])$":  
> 
> No need for ().
> 
> > +    type: object
> > +    additionalProperties: false
> > +    description: Configurations for the DAC channels
> > +
> > +    properties:
> > +      reg:
> > +        description: Channel number
> > +        maxItems: 1
> > +
> > +      adi,output-range-microvolt:
> > +        description: |
> > +          Voltage range of a channel as <minimum, maximum>.
> > +        oneOf:
> > +          - items:
> > +              - const: 0
> > +              - enum: [5000000, 10000000, 10800000]
> > +          - items:
> > +              - const: -5000000
> > +              - const: 5000000
> > +          - items:
> > +              - const: -10000000
> > +              - const: 10000000
> > +          - items:
> > +              - const: -10800000
> > +              - const: 10800000
> > +
> > +    required:
> > +      - reg
> > +      - adi,output-range-microvolt
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad5722
> > +              - adi,ad5732
> > +              - adi,ad5752
> > +              - adi,ad5722r
> > +              - adi,ad5732r
> > +              - adi,ad5752r
> > +    then:
> > +      patternProperties:
> > +        "^channel@([0-3])$":  
> 
> No need for ().
> 
> > +          type: object
> > +          properties:
> > +            reg:
> > +              description: Channel number
> > +              enum: [0, 1]
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad5724
> > +              - adi,ad5734
> > +              - adi,ad5754
> > +              - adi,ad5724r
> > +              - adi,ad5734r
> > +              - adi,ad5754r
> > +    then:
> > +      patternProperties:
> > +        "^channel@([0-3])$":  
> 
> No need for ().
> 
> > +          type: object
> > +          properties:
> > +            reg:
> > +              description: Channel number
> > +              enum: [0, 1, 2, 3]
> > +  
> 
> 
> Best regards,
> Krzysztof
> 

