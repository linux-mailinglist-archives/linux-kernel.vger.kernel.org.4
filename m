Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDF6B6040
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCKTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:34:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445706A1EF;
        Sat, 11 Mar 2023 11:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7A9FB801BB;
        Sat, 11 Mar 2023 19:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA0C4339C;
        Sat, 11 Mar 2023 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678563262;
        bh=9Cg5D5P0O3sCouB1zHM/sNQWl9belH+emswCpqEHalM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHh2Bwh7pY+kkLC6RIVcGtCTSFB7uQ8cCDueRgC5mFc+voDdG5upuQvAVYcCRKudC
         +f54oGBEG9+qSKYWy0k9xCthbSRxe/rovfcECrwhLmjzqo85ZB9KJclUpG3JkFn8Ja
         V/VZS7IV3b1esGpdftMIyvdIdtWLuy3jd3UQtlor9ZTklQFQ3Lc7MfoTMSjaW6btxk
         fGr9DbvKFlXz1jWrN5GmijI7bYgBYZwLjY1KT+QaF+LvybqEwgzyK6iYEwVAVqgfz+
         yghPTki1zrW8vgOdxAVWXhPcAsv1FEkxZ7NtINRUvTapz447BVbs+9NEVzHxOpOLL8
         zB3GH4r1hXPrg==
Date:   Sat, 11 Mar 2023 19:34:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: light: add apds990x binding
Message-ID: <20230311193426.5b1b7e53@jic23-huawei>
In-Reply-To: <20230308090219.12710-2-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
        <20230308090219.12710-2-clamor95@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Mar 2023 11:02:16 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add dt-binding for apds990x ALS/proximity sensor.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/iio/light/avago,apds990x.yaml    | 76 +++++++++++++++++++
I'm not a fan of wild cards. It breaks far too often.  Can we name this
instead after a particular supported part - same for compatible.
I'm not sure what parts are supported by this, but you may want multiple
compatibles.


>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
> new file mode 100644
> index 000000000000..9b47e13f88e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds990x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Avago APDS990x ALS and proximity sensor
> +
> +maintainers:
> +  - Samu Onkalo <samu.p.onkalo@nokia.com>
> +
> +description: |
> +  APDS990x is a combined ambient light and proximity sensor. ALS and
> +  proximity functionality are highly connected. ALS measurement path
> +  must be running while the proximity functionality is enabled.
> +
> +properties:
> +  compatible:
> +    const: avago,apds990x
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vled-supply: true
> +
> +  avago,pdrive:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 32
> +    description: |
> +      Drive value used in configuring control register.

Is this something where there is a reasonable default?
If so I'd prefer it was optional so that the device is easier to
use without needing firmware description.

> +
> +  avago,ppcount:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 32
> +    description: |
> +      Number of pulses used for proximity sensor calibration.
Same for this - if there is a reasonable default it would be good to
have that specified.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt
It would nice to relax the need for an interrupt if the device is still useable
with timeouts etc.  Board folk have a habit of deciding they don't need to wire
up interrupts.  We can relax that a later date though if you prefer not to do
it now.
> +  - vdd-supply
> +  - vled-supply

Whilst true that the supplies need to be connected, that doesn't
mean they need to provided in the device tree binding.  If they are
always powered up I think we can fallback to stub regulators.

> +  - avago,pdrive
> +  - avago,ppcount
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@39 {
> +            compatible = "avago,apds990x";
> +            reg = <0x39>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <82 IRQ_TYPE_EDGE_RISING>;
> +
> +            vdd-supply = <&vdd_3v0_proxi>;
> +            vled-supply = <&vdd_1v8_sen>;
> +
> +            avago,pdrive = <0x00>;
> +            avago,ppcount = <0x03>;
> +        };
> +    };
> +...

