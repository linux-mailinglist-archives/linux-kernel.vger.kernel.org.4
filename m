Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA862A096
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiKORoD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 12:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKORn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:43:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC9F65;
        Tue, 15 Nov 2022 09:43:58 -0800 (PST)
Received: from frapeml100007.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBYQ524BCz687Rd;
        Wed, 16 Nov 2022 01:41:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:43:56 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 17:43:56 +0000
Date:   Tue, 15 Nov 2022 17:43:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Message-ID: <20221115174355.00004a01@Huawei.com>
In-Reply-To: <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
        <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 15 Nov 2022 08:37:17 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Add bindings documentation file for TI TMAG5273.
> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
>  .../iio/magnetometer/ti,tmag5273.yaml         | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> new file mode 100644
> index 000000000000..2f5b0a4d2f40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/ti,tmag5273.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
> +
> +maintainers:
> +  - Gerald Loacker <gerald.loacker@wolfvision.net>
> +
> +description:
> +  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
> +  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
> +  The device has an integrated temperature sensor available. The TMAG5273
> +  can be configured through the I2C interface to enable any combination of
> +  magnetic axes and temperature measurements. An integrated angle calculation
> +  engine (CORDIC) provides full 360° angular position information for both
> +  on-axis and off-axis angle measurement topologies. The angle calculation is
> +  performed using two user-selected magnetic axes.
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'

What Krzysztof said on this ;)

> +
> +  compatible:
> +    const: ti,tmag5273
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  ti,angle-enable:
> +    description:
> +      Enables angle measurement in the selected plane.
> +      0 = OFF
> +      1 = X-Y (default)
> +      2 = Y-Z
> +      3 = X-Z

This feels like something we should be configuring at runtime rather that
DT, or is it driven by board design or similar?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +
> +  vcc-supply:
> +    description:
> +      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
> +      typically 3.3 V.
> +

The dt binding should attempt to describe the hardware, not what we happen
to support in the driver so far. So I'd expect to also see an interrupt.
That way if someone ships a dts file today, and we enable it sometime in the
future they will be ready for it.

> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply

Ah. This is presumably as side effect of having the driver set the voltage.
Normally we only need to 'require' a supply if we need to read it's voltage
(for scaling on ADCs and similar). That's not the case here so I wouldn't
expect to see it.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c-0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@35 {
> +            compatible = "ti,tmag5273";
> +            reg = <0x35>;
> +            #io-channel-cells = <1>;
> +            ti,angle-enable = <3>;
> +            vcc-supply = <&vcc3v3>;
> +        };
> +    };
> +...


