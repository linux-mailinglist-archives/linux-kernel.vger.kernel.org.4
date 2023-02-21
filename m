Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A569E192
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjBUNoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjBUNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:44:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64C65B6;
        Tue, 21 Feb 2023 05:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E7DDCE19E6;
        Tue, 21 Feb 2023 13:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B7EC433D2;
        Tue, 21 Feb 2023 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676987046;
        bh=GzTJZs4LkVCiRQZTfYHn1K5tMQfcfIKi4fqDp/wozwM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WDct35pXKMDFI/inzGiFPLZoCif0IrzusYonBXqlrN6LumxQx0q0lmsfLI18trZiw
         SH+mrcESPiUGz2bMvUQR/dGobex9EesYDALvAzXXQYFWxXen1EBYnGTiPJfz/P9ffq
         Ee5nBNNEFk25spv1B07LI+0H22O0p0b3jtwFFC3JLLEDUMn9MokOAFVM3+RpLRmatG
         FUDzZ5UHydkFgktVmR751zUgzGGKKtvMwtFaPpJMRZbOrD5gl7GRhDZYfpZcfpzTMu
         GpyGr6F2GeTX37FL4WB1y8We0D1dPW5dci/sHp/0jhxhH5K3/Bm2LAywyzqFimcgKI
         DT6udz5i30bUQ==
Message-ID: <c38afa67-d24f-0390-f18a-81bee15b7eca@kernel.org>
Date:   Tue, 21 Feb 2023 14:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Content-Language: en-US
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220123232.413029-1-marius.cristea@microchip.com>
 <20230220123232.413029-2-marius.cristea@microchip.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230220123232.413029-2-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 13:32, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>

Subject: drop second/last, redundant "dt-bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> This is the device tree schema for iio driver for
> Microchip PAC193X series of Power Monitors with Accumulator.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Use imperative - also for subject.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.


> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac193x.yaml   | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> new file mode 100644
> index 000000000000..e4ea560991e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac193x.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac193x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC193X Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1934
> +      - microchip,pac1933
> +      - microchip,pac1932
> +      - microchip,pac1931

Maybe order these numerically (ascending)?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,samp-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sampling rate for all device's channels.

What are the units? rate is usually in hz, which should be expressed in
unit suffix (property name)

> +    enum: [8, 64, 256, 1024]
> +    default: 1024
> +
> +required:

required goes after all properties, so after patternProperties

> +  - compatible
> +  - reg
> +  - microchip,samp-rate
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:
> +  "^channel([1-4])@[1-4]+$":

Why first reg-pattern ([1-4])? For what do you need it?

> +    $ref: "adc.yaml"

Drop quotes

> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +          It can have up to 4 channels, numbered from 1 to 4.
> +        items:
> +          - minimum: 1
> +            maximum: 4
> +
> +      microchip,uohms-shunt-res:

Not a correct unit suffix. Use standard properties:
git grep shunt -- Documentation/devicetree/


> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Value in micro Ohms of the shunt resistor connected between
> +          the SENSE+ and SENSE- inputs, across which the current is measured. Value
> +          is needed to compute the scaling of the measured current.
> +
> +      microchip,rail-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Name of the monitored power rail.

Why do you need it? Why this is a property of DT? Aren't you now
duplicating label?

> +
> +      microchip,bi-directional:
> +        description: Whether the channel is bi-directional.

Describe here what is a "bi-directional" channel for ADC... Maybe it is
obvious, maybe not. For me it is not and none of other devices have it.

> +        type: boolean
> +
> +    required:
> +      - reg
> +      - microchip,uohms-shunt-res
> +      - microchip,rail-name
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pac193x: pac193x@10 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "microchip,pac1934";
> +            reg = <0x10>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            microchip,samp-rate = <64>;
> +
> +            channel1@1 {

1@1 is for sure not generic...



Best regards,
Krzysztof

