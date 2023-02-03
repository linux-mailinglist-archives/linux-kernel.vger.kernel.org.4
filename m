Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2F68A5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBCWPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjBCWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:14:46 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52FAFA54;
        Fri,  3 Feb 2023 14:13:49 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-16a19aa2ddbso358163fac.4;
        Fri, 03 Feb 2023 14:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw6PdFuIKHRtNujVdzDiLXE+QWd5QhNLUNrYUFzLxWI=;
        b=d9M36FBuGgXPJq+f9+5Gr61p4k/lpA326lPPaMv2PiLDZP2Uosaxo1hl9UOw3VV2s0
         7a3An/AfKKTzefa97UVkkuM+AH14z39pvDX2AHBN3oGRV2Z94nBNS5eAuXcuDedBho0k
         yFb14qgXUFNBmZRZDGYRAtFVd3bdOawtaq+mVFCH0ZqtGnWfhg2sZGMsUmd/cDw3lsz1
         bbETp5L8C1DGhIpW4kHCuUiw25JruYsckzuHD6EuXZ/cSOCUU8Z8blCUEx/CLe9wfTOV
         rc7NWOHMIgm0dnz9xAFuu9asooQ4s+UTxp8Ooryi16WIlmSw8mTDzM3HR/TK7JIeoZ53
         O96w==
X-Gm-Message-State: AO0yUKXnxOJqORzxSwqFPZtbAs/IItDXqFM19q8JXcqzXv5aKwlR9gvJ
        PXIhreYIfM32ZD5kvUGwgw==
X-Google-Smtp-Source: AK7set+FUHHTZB3BEZz2tOg2sXyUbAQ0yGNVCYMUkcQxtdquZlVLxAI6lNIJ6COfA7ceDlJ/QUpg5A==
X-Received: by 2002:a05:6870:2192:b0:169:de47:db82 with SMTP id l18-20020a056870219200b00169de47db82mr4237685oae.24.1675462125484;
        Fri, 03 Feb 2023 14:08:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j22-20020a056870531600b00160323101efsm1264189oan.42.2023.02.03.14.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:08:45 -0800 (PST)
Received: (nullmailer pid 962653 invoked by uid 1000);
        Fri, 03 Feb 2023 22:08:44 -0000
Date:   Fri, 3 Feb 2023 16:08:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add the Renesas X9250
 potentiometers
Message-ID: <20230203220844.GA955510-robh@kernel.org>
References: <20230203111422.142479-1-herve.codina@bootlin.com>
 <20230203111422.142479-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203111422.142479-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:14:20PM +0100, Herve Codina wrote:
> The Renesas X9250 is a quad digitally controlled potentiometers.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/renesas,x9250.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,x9250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,x9250.yaml b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
> new file mode 100644
> index 000000000000..ad29ef465a18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/renesas,x9250.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/renesas,x9250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas X9250 quad potentiometers
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  The Renesas X9250 is a quad digitally controlled potentiometers.

...is a chip with quad...

> +
> +  In the audio path, it can be present on amplifiers designs and it can be used
> +  in ALSA as an auxiliary audio device to control these amplifiers.

ALSA? Linux details should not be in bindings.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: renesas,x9250
> +
> +  reg:
> +    description:
> +      SPI device address.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +patternProperties:
> +  "^renesas,cmd[0-3]-invert$":
> +    description:
> +      The related command is inverted meaning that the minimum command value
> +      set the wiper to Rh and the maximum command value set the wiper to Rl.
> +      Without this property, the minimum command value set the wiper to Rl and
> +      the maximum to Rh.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        x9250@0 {
> +            compatible = "renesas,x9250";
> +            reg = <0>;
> +            spi-max-frequency = <2000000>;
> +            renesas,cmd3-invert;
> +        };
> +    };
> -- 
> 2.39.0
> 
