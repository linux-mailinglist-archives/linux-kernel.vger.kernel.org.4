Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF06E1D22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDNH1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:27:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD85598;
        Fri, 14 Apr 2023 00:27:46 -0700 (PDT)
Received: from localhost ([31.220.118.10]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhlXE-1qIAwk0mzA-00dmP8; Fri, 14 Apr 2023 09:27:30 +0200
Date:   Fri, 14 Apr 2023 09:27:29 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Message-ID: <ZDkAYZV9z6cKCZQo@arbad>
References: <20230401185717.1b971617@jic23-huawei>
 <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org>
X-Provags-ID: V03:K1:9bByc2/Vv78HO6SCY14ArSj2OgJdGpsVQD+YvlmuJV70NcKh5g1
 5feRyxelQggg0IStorXBSyXJiqkPsMVjgY+M9wNiIfxv5Z7CLeTtrzAd/Zl4mutuzpMahAh
 ChF5O/lG/DpnFoXUIIbi18KcHV4G4LC7Lg/0htwHKO8/BVgmQxKeWdxQn6VeXE2qYmV68U5
 tiaPaPDiFkowEMica0NeQ==
UI-OutboundReport: notjunk:1;M01:P0:EvaFxQY3prM=;A1KkZ9f6gBjD/LlKX7nFAzyO9kc
 yp3xmnl7HIwSYpaWeV/isHVZXMejfEZOjc3QUMsGXf1HWRKfMtqhPMP8YAe4ZwbRPXUgnylsw
 g32reJ7RC0q5r2IdYQTSKxQ79ncahzT2UY3WRfWXBVzQCNd4cqqN9wROqR8WWNS4LN2c9yQH+
 MM6t0DuyOkDfA67pnaSfTVnVLYUyyLbTSbVMxkxrnJ7INrH3tF5l8pEgcQKgK4ipsLeWrP291
 v4/9kggRtf4MPNRSh9+hEX1TSwoILqc0VAmDBRk1DJsR9LAu4fzjE59gCJvp63umMs88sVd5q
 LnzSuyJ754IpXJR8W/43Oo0lx3dWjxz8keyQthGyD4jKXa1dVpTazt6yIvmiTkIl/w8Z3/B1w
 noPpTXXaV9i69subRWSFNiYlqN10b5nSP1vnLwgGK9k77z5D2xPSDMSdGl8iqIW84D8FRBxe0
 0eLeQf2Shnt0GzhZ55VsrUFC7b2pT0PkSBM2UQwSOjDni3Xv2iJu2SCpVuIMi9pNJD/p9gYCR
 I3ldxYMrjfHZ74JpLYsMNeBqkLptsugwsy4+rOL/Wsqo7EhjUsFswUd6ixBeut2AP+OpLL2ng
 7brpjkelIQ8/SP+sXQllbP07s60vq8nvTcEzcAj8I4mGne0QvkymY+M38tcvi84entEVm01BX
 c1lgl2lCNnnr2NUvHnjhSLRT9976z47m1LVVuQiKjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> schrieb am Sa, 01. Apr 11:42:
> On 01/04/2023 11:09, Andreas Klinger wrote:
> > Honeywell mpr is a pressure sensor family. There are many different
> > types with different pressure ranges. The range needs to be set up in
> > the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
> > introduced.
> > 
> > Add dt-bindings.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > new file mode 100644
> > index 000000000000..d6fad6f841cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Honeywell mpr pressure sensor
> > +
> > +maintainers:
> > +  - Andreas Klinger <ak@it-klinger.de>
> > +
> > +description: |
> > +  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C
> 
> Doesn't look wrapped according to Linux coding style (see Coding style).
> 
> > +  interface is implemented.
> > +
> > +  There are many subtypes with different pressure ranges available. Therefore the minimum and
> > +  maximum pressure values of the specific sensor needs to be specified in Pascal.
> > +
> > +  Specifications about the devices can be found at:
> > +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
> > +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
> > +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> 
> Lines are not continued, so drop \
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: honeywell,mpr
> 
> You need device specific compatible, not some generic one. Rename also
> then the filename (should match the compatible).
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Optional GPIO for resetting the device. If not present the device is not resetted.
> 
> Are you sure it is wrapped properly?
> 
> > +    maxItems: 1
> > +
> > +  honeywell,pmin:
> > +    description:
> > +      Minimum pressure value the sensor can measure in pascal.
> 
> Use standard unit suffix:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

There are only kilopascal as standard unit suffix. But with kilopascal as
integer the accuracy of the driver is very rough. Therefore I would like to use
pascal. E. g.:

honeywell,pmin-pascal

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  honeywell,pmax:
> > +    description:
> > +      Maximum pressure value the sensor can measure in pascal.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Same.
> 
> Why these values are suitable for DT?

Technically from the software perspective the sensors are identical with the
only difference of having different pressure ranges, measurement units and
transfer functions.

If we omit the pressure values and transfer function we'll need 96 compatibles
and also 96 I2C ids.

But there are also custom sensor types. For covering them we'll need another
compatible and just for this case the pressure values and transfer function.

> Does it depend on type of sensor (thus it is implied from compatible) or on
> system setup?

For the standard types it can be derived from the type of sensor but for the
custom types it's not possible.

So sum up it'll look like this:

standard types:
96 compatibles, e. g. "honeywell,mpr-0025pa-a"

custom types:
1 compatible: "honeywell,mpr-custom"
honeywell,pmin-pascal
honeywell,pmax-pascal
honeywell,transfer-function


Best regards,

Andreas

