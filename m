Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE7674361
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjASUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjASUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:14:38 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E6951A1;
        Thu, 19 Jan 2023 12:14:33 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E94845FD0B;
        Thu, 19 Jan 2023 23:14:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1674159269;
        bh=aaR9evVc2lGAxgc1j/OH4BgiwZu8Sx2LjYz7IF3WmyE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=IVx6sMXPad9O6kUyupdXBr38dNNjeS2a9tD41LuD4fjg0SBi+eegOpmcl4idROZi8
         Fj0ju5drKSGyEfmAIiRaxvRXYE9dUXnRl7iNpZDNJRsSWmmL1TqghFQ0DXGso8uxjP
         jaCeVZRxvavFnXcGDusMsMHMMQKsQ+F7+KvXvZdUFbf9FHGzDtOzmJzfFeHBZ5K+rL
         WhBddfYAXt817R0Yos21SaAuqpgqim/9KGZnlzx7r6buXEjO4rOSKRCZ+rJ23MOSwa
         mrfYbzZ4VXevWpK0F4sDEHuBG1avsWWHVFIZtYkMpbAfmNWAkXfkZmhYwzNBQm47Np
         QM1+cGt7qWMfg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 19 Jan 2023 23:14:14 +0300 (MSK)
Date:   Thu, 19 Jan 2023 23:14:14 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
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
        Oleksij Rempel <linux@rempel-privat.de>,
        <kernel@pengutronix.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
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
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 1/5] dt-bindings: iio: drop unneeded quotes
Message-ID: <20230119201414.2gt2lw2qozm7vyjh@CAB-WSD-L081021>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/01/19 16:54:00 #20783955
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for the patch!
I'm okay with changes to memsensing,msa311.yaml schema.

On Wed, Jan 18, 2023 at 07:44:09PM +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

[...]

-- 
Thank you,
Dmitry
