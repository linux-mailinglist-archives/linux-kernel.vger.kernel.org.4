Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F1600C65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJQK1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Oct 2022 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJQK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:27:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809150B84;
        Mon, 17 Oct 2022 03:27:00 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrY650rJnz688JN;
        Mon, 17 Oct 2022 18:25:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 17 Oct 2022 12:26:57 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:26:57 +0100
Date:   Mon, 17 Oct 2022 11:26:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support
 more parts
Message-ID: <20221017112656.000038c1@huawei.com>
In-Reply-To: <df784d20-0464-ad08-178a-1639d313489b@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
        <20221014123724.1401011-3-demonsingur@gmail.com>
        <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
        <df784d20-0464-ad08-178a-1639d313489b@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 17 Oct 2022 09:53:40 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 10/17/22 04:59, Krzysztof Kozlowski wrote:
> > On 14/10/2022 08:37, Cosmin Tanislav wrote:  
> >> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >>
> >> Add support for the following parts:
> >>   * LTC2984
> >>   * LTC2986
> >>   * LTM2985
> >>
> >> The LTC2984 is a variant of the LTC2983 with EEPROM.
> >> The LTC2986 is a variant of the LTC2983 with only 10 channels,
> >> EEPROM and support for active analog temperature sensors.
> >> The LTM2985 is software-compatible with the LTC2986.
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Cosmin,

Please take care to keep things polite. Krzysztof is reviewing an
enormous number of bindings and is very helpful indeed. We should
respect his feedback and respond appropriately. Sometimes what is
'obvious' to one person may need a clarifying comment or explanation
for another.

Jonathan


> >> ---
> >>   .../bindings/iio/temperature/adi,ltc2983.yaml | 63 +++++++++++++++++--
> >>   1 file changed, 59 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> >> index 722781aa4697..c33ab524fb64 100644
> >> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> >> @@ -4,19 +4,27 @@
> >>   $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> >>   $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>   
> >> -title: Analog Devices LTC2983 Multi-sensor Temperature system
> >> +title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
> >>   
> >>   maintainers:
> >>     - Nuno Sá <nuno.sa@analog.com>
> >>   
> >>   description: |
> >> -  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
> >> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
> >> +  Temperature Measurement Systems
> >> +
> >>     https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
> >> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
> >> +  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
> >> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
> >>   
> >>   properties:
> >>     compatible:
> >>       enum:
> >>         - adi,ltc2983
> >> +      - adi,ltc2984
> >> +      - adi,ltc2986
> >> +      - adi,ltm2985
> >>   
> >>     reg:
> >>       maxItems: 1
> >> @@ -26,7 +34,7 @@ properties:
> >>   
> >>     adi,mux-delay-config-us:
> >>       description:
> >> -      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
> >> +      The device performs 2 or 3 internal conversion cycles per temperature
> >>         result. Each conversion cycle is performed with different excitation and
> >>         input multiplexer configurations. Prior to each conversion, these
> >>         excitation circuits and input switch configurations are changed and an
> >> @@ -145,7 +153,7 @@ patternProperties:
> >>         adi,three-conversion-cycles:
> >>           description:
> >>             Boolean property which set's three conversion cycles removing
> >> -          parasitic resistance effects between the LTC2983 and the diode.
> >> +          parasitic resistance effects between the device and the diode.
> >>           type: boolean
> >>   
> >>         adi,average-on:
> >> @@ -353,6 +361,41 @@ patternProperties:
> >>           description: Boolean property which set's the adc as single-ended.
> >>           type: boolean
> >>   
> >> +  "^temp@":  
> > 
> > There is already a property for thermocouple. Isn't a thermocouple a
> > temperature sensor? IOW, why new property is needed?
> >   
> This node is needed for active analog temperature sensors.
> It has fewer options than the thermocouple, as it only supports
> a table to map from voltage to temperature and specifying whether
> the measurement is differential or single-ended.
> 
> If you did as much as glimpsed at the datasheet you would have
> understood.
> 
> >> +    type: object
> >> +    description:
> >> +      Represents a channel which is being used as an active analog temperature
> >> +      sensor.
> >> +
> >> +    properties:
> >> +      adi,sensor-type:
> >> +        description:
> >> +          Identifies the sensor as an active analog temperature sensor.
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        const: 31
> >> +
> >> +      adi,single-ended:
> >> +        description: Boolean property which sets the sensor as single-ended.  
> > 
> > Drop "Boolean property which sets" - it's obvious from the type.
> >   
> 
> That's how the rest of the file is written.
> 
> > 
> >   
> >> +        type: boolean
> >> +
> >> +      adi,custom-temp:
> >> +        description:
> >> +          This is a table, where each entry should be a pair of  
> > 
> > "This is a table" - obvious from the type.
> >   
> 
> That's how the rest of the file is written.
> 
> >> +          voltage(mv)-temperature(K). The entries must be given in nv and uK  
> > 
> > mv-K or nv-uK? Confusing...  
> 
> That's how the rest of the file is written.
> 
> The chip uses mv-K, but the binding specifies nv-uK, the driver
> translates it into the appropriate unit.
> 
> >   
> >> +          so that, the original values must be multiplied by 1000000. For
> >> +          more details look at table 71 and 72.  
> > 
> > There is no table 71 in the bindings... It seems you pasted it from
> > somewhere.
> >   
> 
> It's pretty obvious that "Table" in a binding refers to the datasheet.
> But if you meant datasheet, not binding, you're looking at the wrong
> datasheet then.
> Also, that's how the rest of the file is written.
> 
> >> +          Note should be signed, but dtc doesn't currently maintain the
> >> +          sign.  
> > 
> > What do you mean? "Maintain" as allow or keep when building FDT?  What's
> > the problem of using negative numbers here and why it should be part of
> > bindings?
> >   
> 
> You're really clueless, I'll let you figure it out on your own.
> Also, that's how the rest of the file is written.

> 
> >> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
> >> +        minItems: 3
> >> +        maxItems: 64
> >> +        items:
> >> +          minItems: 2
> >> +          maxItems: 2  
> > 
> > Instead describe the items with "description" (and maybe constraints)
> > like here:
> > 
> > https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml#L278
> >   
> 
> That's how the rest of the file is written.
> If you really want to use something different, you can submit a
> patch later and fix the whole binding however you want.
> 
> >> +
> >> +    required:
> >> +      - adi,custom-temp
> >> +
> >>     "^rsense@":
> >>       type: object
> >>       description:
> >> @@ -382,6 +425,18 @@ required:
> >>     - reg
> >>     - interrupts
> >>   
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ltc2983
> >> +              - adi,ltc2984
> >> +    then:
> >> +      patternProperties:
> >> +        "^temp@": false
> >> +
> >>   additionalProperties: false
> >>   
> >>   examples:  
> > 
> > Best regards,
> > Krzysztof
> >   

