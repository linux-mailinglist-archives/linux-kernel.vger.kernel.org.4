Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034E4642423
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiLEIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLEIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:09:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FE812768;
        Mon,  5 Dec 2022 00:09:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3385BCE0E6F;
        Mon,  5 Dec 2022 08:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7DDC433D6;
        Mon,  5 Dec 2022 08:09:26 +0000 (UTC)
Message-ID: <71443a0d-9ca2-c3a0-8ac1-1fb98e4e74b3@xs4all.nl>
Date:   Mon, 5 Dec 2022 09:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 7/9] media: dt-bindings: cec-gpio: convert to DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
 <20221204182908.138910-7-krzysztof.kozlowski@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221204182908.138910-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2022 19:29, Krzysztof Kozlowski wrote:
> Convert HDMI CEC GPIO bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  .../devicetree/bindings/media/cec-gpio.txt    | 42 -----------
>  .../bindings/media/cec/cec-gpio.yaml          | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 74 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cec-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/cec-gpio.txt b/Documentation/devicetree/bindings/media/cec-gpio.txt
> deleted file mode 100644
> index 47e8d73d32a3..000000000000
> --- a/Documentation/devicetree/bindings/media/cec-gpio.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -* HDMI CEC GPIO driver
> -
> -The HDMI CEC GPIO module supports CEC implementations where the CEC line
> -is hooked up to a pull-up GPIO line and - optionally - the HPD line is
> -hooked up to another GPIO line.
> -
> -Please note: the maximum voltage for the CEC line is 3.63V, for the HPD and
> -5V lines it is 5.3V. So you may need some sort of level conversion circuitry
> -when connecting them to a GPIO line.
> -
> -Required properties:
> -  - compatible: value must be "cec-gpio".
> -  - cec-gpios: gpio that the CEC line is connected to. The line should be
> -    tagged as open drain.
> -
> -If the CEC line is associated with an HDMI receiver/transmitter, then the
> -following property is also required:
> -
> -  - hdmi-phandle - phandle to the HDMI controller, see also cec.txt.
> -
> -If the CEC line is not associated with an HDMI receiver/transmitter, then
> -the following property is optional and can be used for debugging HPD changes:
> -
> -  - hpd-gpios: gpio that the HPD line is connected to.
> -
> -This property is optional and can be used for debugging changes on the 5V line:
> -
> -  - v5-gpios: gpio that the 5V line is connected to.
> -
> -Example for the Raspberry Pi 3 where the CEC line is connected to
> -pin 26 aka BCM7 aka CE1 on the GPIO pin header, the HPD line is
> -connected to pin 11 aka BCM17 and the 5V line is connected to pin
> -15 aka BCM22 (some level shifter is needed for the HPD and 5V lines!):
> -
> -#include <dt-bindings/gpio/gpio.h>
> -
> -cec-gpio {
> -	compatible = "cec-gpio";
> -	cec-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> -	hpd-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> -	v5-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> new file mode 100644
> index 000000000000..19169d58316a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> @@ -0,0 +1,73 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cec/cec-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDMI CEC GPIO
> +
> +maintainers:
> +  - Hans Verkuil <hverkuil-cisco@xs4all.nl>
> +
> +description: |
> +  The HDMI CEC GPIO module supports CEC implementations where the CEC line is
> +  hooked up to a pull-up GPIO line and - optionally - the HPD line is hooked up
> +  to another GPIO line.
> +
> +  Please note:: the maximum voltage for the CEC line is 3.63V, for the HPD and
> +  5V lines it is 5.3V. So you may need some sort of level conversion
> +  circuitry when connecting them to a GPIO line.
> +
> +properties:
> +  compatible:
> +    const: cec-gpio
> +
> +  cec-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO that the CEC line is connected to. The line should be tagged as open
> +      drain.
> +
> +  hpd-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO that the HPD line is connected to.  Used for debugging HPD changes
> +      when the CEC line is not associated with an HDMI receiver/transmitter.
> +
> +  v5-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO that the 5V line is connected to.  Used for debugging changes on the
> +      5V line.
> +
> +required:
> +  - compatible
> +  - cec-gpios
> +
> +allOf:
> +  - $ref: cec-common.yaml#
> +  - if:
> +      required:
> +        - hdmi-phandle
> +    then:
> +      properties:
> +        hpd-gpios: false
> +
> +  - if:
> +      required:
> +        - hpd-gpios
> +    then:
> +      properties:
> +        hdmi-phandle: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    cec {
> +        compatible = "cec-gpio";
> +        cec-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        hpd-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +        v5-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05acbaecef52..197351d3bb57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4848,7 +4848,7 @@ L:	linux-media@vger.kernel.org
>  S:	Supported
>  W:	http://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/cec-gpio.txt
> +F:	Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
>  F:	drivers/media/cec/platform/cec-gpio/
>  
>  CELL BROADBAND ENGINE ARCHITECTURE

