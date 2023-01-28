Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0256A67F965
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjA1QCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1QCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:02:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460562684A;
        Sat, 28 Jan 2023 08:02:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C4E760C2A;
        Sat, 28 Jan 2023 16:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3876C433EF;
        Sat, 28 Jan 2023 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674921748;
        bh=MEnSVM9h1tfvj22o8Ls43RK2vAq9wORRPqY+/TUQ/ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EKQ2Dfl5334OTddL+pBem88MlleZTLI48FJv9Q061JlY0EQa+RN/MoPXyOJTr/bnF
         9LHRcCbCmb+ZhXvmdpkwPYqxmt34eQtldDaj0AIg0Q90Fl4fOXf9IY10SGmGb2kn1I
         GIg6ZQdsInuHmQhJHasTGGt7aNGyhUCqJE0nMRCkvQpsZKhvZWfDrVA2MdZg2dr9eW
         4pCuoEr1hoJbOTYvDFo6wJelHel4BAQYERqFKuRHuoW4j8Wce2qNmPdTswq8geTUrn
         ZYcR0anHqTzPYuD34hSaETsin4FCIWoZJnCad2bJee9jQjyAEFNggQ+EI8XMSnGSWR
         9WDzZ49OEwF2w==
Date:   Sat, 28 Jan 2023 16:16:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: drop unneeded quotes
Message-ID: <20230128161613.1d321b16@jic23-huawei>
In-Reply-To: <20230124081037.31013-1-krzysztof.kozlowski@linaro.org>
References: <20230124081037.31013-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 09:10:33 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru> # memsensing
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com> # sama5d2-adc
> Reviewed-by: Puranjay Mohan <puranjay12@gmail.com> # tmp117
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com> # ad7292
Hi Krzysztof,

Series applied to the togreg branch of iio.git, initially pushed out
(once build test finishes) as testing for 0-day to poke at.

One trivial comment. It's helpful for any series with more than
one or two patches to have a cover letter even if there isn't much to say
as it provides somewhere for people to give tags for the whole series etc
that b4 will then pick up with out the maintainer having to be careful
that the tag was really meant for the whole series.

Also gives a nice place for me to reply to when saying I picked up the
series :)

Thanks,

Jonathan



> ---
>  .../devicetree/bindings/iio/accel/memsensing,msa311.yaml  | 5 ++---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
>  .../devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml    | 2 +-
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++--
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml          | 4 ++--
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 4 ++--
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml    | 2 +-
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml   | 2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++----
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml         | 2 +-
>  Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml | 2 +-
>  .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml         | 4 ++--
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 2 +-
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml    | 6 +++---
>  17 files changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> index 23528dcaa073..d530ec041fe7 100644
> --- a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> -
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: MEMSensing digital 3-Axis accelerometer
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 75a7184a4735..35ed04350e28 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -61,7 +61,7 @@ required:
>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> -    $ref: "adc.yaml"
> +    $ref: adc.yaml
>      type: object
>      description: |
>        Represents the external channels which are connected to the ADC.
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> index 1bfbeed6f299..7cc4ddc4e9b7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -43,7 +43,7 @@ required:
>  
>  patternProperties:
>    "^channel@[0-7]$":
> -    $ref: "adc.yaml"
> +    $ref: adc.yaml
>      type: object
>      description: |
>        Represents the external channels which are connected to the ADC.
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> index 31f840d59303..4817b840977a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -41,7 +41,7 @@ properties:
>      description: Startup time expressed in ms, it depends on SoC.
>  
>    atmel,trigger-edge-type:
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        One of possible edge types for the ADTRG hardware trigger pin.
>        When the specific edge type is detected, the conversion will
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 77605f17901c..9c57eb13f892 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: AVIA HX711 ADC chip for weight cells
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> index 517e8b1fcb73..b71c951e6d02 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2019-2020 Artur Rojek
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Ingenic JZ47xx ADC controller IIO
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 2c93fb41f172..f7b3fde4115a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/adc/microchip,mcp3911.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3911.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Microchip MCP3911 Dual channel analog front end (ADC)
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> index 8b743742a5f9..ba86c7b7d622 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -69,7 +69,7 @@ required:
>  
>  patternProperties:
>    "^channel@[0-7]$":
> -    $ref: "adc.yaml"
> +    $ref: adc.yaml
>      type: object
>      description: |
>        Represents the external channels which are connected to the ADC.
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 81c87295912c..e27d094cfa05 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -52,7 +52,7 @@ properties:
>    vdd-supply: true
>  
>    samsung,syscon-phandle:
> -    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Phandle to the PMU system controller node (to access the ADC_PHY
>        register on Exynos3250/4x12/5250/5420/5800).
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index 1c340c95df16..995cbf8cefc6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: STMicroelectronics STM32 ADC
>  
> @@ -80,7 +80,7 @@ properties:
>      description:
>        Phandle to system configuration controller. It can be used to control the
>        analog circuitry on stm32mp1.
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>  
>    interrupt-controller: true
>  
> @@ -341,7 +341,7 @@ patternProperties:
>      patternProperties:
>        "^channel@([0-9]|1[0-9])$":
>          type: object
> -        $ref: "adc.yaml"
> +        $ref: adc.yaml
>          description: Represents the external channels which are connected to the ADC.
>  
>          properties:
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> index 55c2c73626f4..890f125d422c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> @@ -77,7 +77,7 @@ required:
>  
>  patternProperties:
>    "^channel@([0-7])$":
> -    $ref: "adc.yaml"
> +    $ref: adc.yaml
>      type: object
>      description: |
>        Represents the external channels which are connected to the ADC.
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> index bdf3bba2d750..32c52f9fe18b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> @@ -41,7 +41,7 @@ required:
>  
>  patternProperties:
>    "^channel@[0-7]$":
> -    $ref: "adc.yaml"
> +    $ref: adc.yaml
>      type: object
>  
>      properties:
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> index 133b0f867992..c9f51d00fa8f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc1660.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/dac/lltc,ltc1660.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Linear Technology Micropower octal 8-Bit and 10-Bit DACs
>  
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> index b1eb77335d05..c9e3be3b5754 100644
> --- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
>  
> diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> index 0f1bf1110122..04045b932bd2 100644
> --- a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/dac/st,stm32-dac.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/dac/st,stm32-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: STMicroelectronics STM32 DAC
>  
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 68b481c63318..decf022335d8 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -63,7 +63,7 @@ properties:
>      description: if defined provides VDD IO power to the sensor.
>  
>    st,drdy-int-pin:
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
>        The pin on the package that will be used to signal data ready
>      enum:
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 347bc16a4671..c4f1c69f9330 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -1,10 +1,10 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> +title: TI TMP117 - Digital temperature sensor with integrated NV memory
>  
>  description: |
>      TI TMP117 - Digital temperature sensor with integrated NV memory that supports

