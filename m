Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40668A513
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjBCV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjBCV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:57:27 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE9A9111;
        Fri,  3 Feb 2023 13:57:26 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id r205so5346468oib.9;
        Fri, 03 Feb 2023 13:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2vc3qMIstkTWFHwtw+c6I2ctj9RY4rHLBiXXNGhXcw=;
        b=PaJmYsIMeM0ibY/Bg+cFEkAyJKicwRmLqiyEIjrWC6U6Sb/qNfdt+yY+JGEnoNa/ZL
         tJFaAMxca7KSI0ivKQWZ6NT2dHEb/n3rSZAI7emAvmLScLZ64NrjJd1nwK4L6PdbBOYG
         HSYcalVcbUk/EbPH2Pwz2D44XqmvfDXpn3KGnwDEpGsPyDlK7BK8hfY5gl7NoY5KPOK4
         PkEpW/OglvmKn+dxj9JXph4nAZu3LT5lnvZtzuppc2V39lVniL9NKhMfMOqYSBP1xwEr
         AQ4Tz6AyVV/3PHKwfzQ+0D3q/oMrd+RJWH/nd5/yv88iPe3Bcl2gJkgYT8zWRSD4kef2
         j6LQ==
X-Gm-Message-State: AO0yUKXPDSTs6Vw5T0ELRSJcsW5GKvQoSL2Roc4vt5IxvXC7K3G2oBfE
        ldfwAtMn2Dtmgydp2YOXBA==
X-Google-Smtp-Source: AK7set+wElBYaFN6oCAW8rVJ/iackvGmOusAIRbPlBnuY5f0Rhx+PfVdKYwxURSkvIKDntW3pUrA3w==
X-Received: by 2002:aca:3e57:0:b0:36b:fbdb:eb61 with SMTP id l84-20020aca3e57000000b0036bfbdbeb61mr4792106oia.23.1675461445527;
        Fri, 03 Feb 2023 13:57:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a056808099a00b00378ce4197casm1276811oic.8.2023.02.03.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:57:25 -0800 (PST)
Received: (nullmailer pid 947483 invoked by uid 1000);
        Fri, 03 Feb 2023 21:57:24 -0000
Date:   Fri, 3 Feb 2023 15:57:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, kevin-lu@ti.com, shenghao-ding@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: dt-bindings: Add tas2781 amplifier
Message-ID: <20230203215724.GA938713-robh@kernel.org>
References: <20230203040115.27321-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203040115.27321-1-13916275206@139.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:01:15PM +0800, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v5:
>  - Drop the full stop in the Subject.
>  - Drop the reset-gpios reference to gpio.txt.
>  - Add Changelog.
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 000000000000..8af44792a904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TAS2781 SmartAMP
> +
> +maintainers:
> +  - Shenghao Ding <shenghao-ding@ti.com>
> +  - Kevin Lu <kevin-lu@ti.com>
> +
> +description: |

Don't need '|' unless you need line endings preserved. Wrap lines at 80 
chars.

> +  The TAS2781 is a mono, digital input Class-D audio amplifier
> +  optimized for efficiently driving high peak power into small
> +  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
> +  Smart Amp speaker protection algorithm. The integrated speaker
> +  voltage and current sense provides for real time
> +  monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2781
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      I2C address of the device can be in range from 0x38 to 0x40.

Express as constraints instead:

items:
  minimum: 0x38
  maximum: 0x40

Or was this the range of the slot addresses?

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: |
> +      A GPIO line handling reset of the chip. As the line is active high,
> +      it should be marked GPIO_ACTIVE_HIGH.

The description doesn't add anything. Drop.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,audio-slots:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      I2c address of the device for different audio slots,

I2C

> +      useless in mono case.
> +
> +  ti,broadcast-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Generic i2c address for all the tas2781 devices in

I2C

Be consistent.

> +      purpose of I2C broadcast during the multi-device
> +      writes, useless in mono case.
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c {
> +     /* example with quad support, such as tablet or pad device */
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     quad: codec@38 {
> +       compatible = "ti,tas2781";
> +       reg = <0x38>;
> +       #sound-dai-cells = <1>;
> +       reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH >;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <15>;
> +       ti,audio-slots = < 0x38 /* topleft-channel */
> +                          0x39 /* topright-channel */
> +                          0x3a /* bottomleft-channel */
> +                          0x3b /* bottomright-channel */

Do these vary? Or the slot addresses are fixed and which slots are used 
varies? 

> +                        >;
> +       ti,broadcast-addr = <0x40>;

I tend to think the I2C addresses should all be in 'reg'.

> +     };
> +   };
> +...
> -- 
> 2.34.1
> 
> 
