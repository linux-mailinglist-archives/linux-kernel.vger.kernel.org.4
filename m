Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AB64446F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiLFNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiLFNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:16:54 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19812A43B;
        Tue,  6 Dec 2022 05:16:52 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so17367073fac.2;
        Tue, 06 Dec 2022 05:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaYmjVMKi6m6Kxmr7DWey6okwhtAEvgqHUnlmil0PeU=;
        b=aJAuWUgKlxtZQpr7ZNqmiiJ3iNH1o31YQLXVlgWO4G2JsmUYINi3XLWW9gq6h4tDPo
         5qm/f7VMdBWn5KnURhleVXcFscYqgbu4Kw32um5yXIXbm02wAmEOsrxHxlQTFtkIOSZU
         OF3hpbt69gT5/qCHRqTlxZLitawSJYaP5JdncBWvtt/Cmv7Vo2eduunIR/Rz6qLu5Oo/
         BtLg9rCrZ9dKDlxdPGGgnmSVggOzfWKPRs64oZwxZTfGaDzAtELBFkpjwI3KG8ERPC9q
         comPxapnGMIWHSQn2tTbj++nkpxJYlhAv1QqJSvfj9hlxoT1vUSHy2pLVVr5YZfHan+o
         jizg==
X-Gm-Message-State: ANoB5pnpg57Rw0R4CYHwXYVPbcp73RnX7A8TjNY4FeWHmLC/HDOzmH3e
        GtTYkItWy/hRTzxWPuj8aA==
X-Google-Smtp-Source: AA0mqf7IjwvpdWWrq9Hova2cn9yHixUjZuP8++9Q5X5xu+i8XU+97zxxo9X2IRe6Ssx/TejfniT10A==
X-Received: by 2002:a05:6870:d1cd:b0:143:75da:a5b with SMTP id b13-20020a056870d1cd00b0014375da0a5bmr29655766oac.74.1670332611950;
        Tue, 06 Dec 2022 05:16:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o5-20020acabe05000000b0035173c2fddasm8236054oif.51.2022.12.06.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:16:51 -0800 (PST)
Received: (nullmailer pid 245750 invoked by uid 1000);
        Tue, 06 Dec 2022 13:16:50 -0000
Date:   Tue, 6 Dec 2022 07:16:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: gpio: max7317: add gpio driver bindings
Message-ID: <20221206131650.GA236912-robh@kernel.org>
References: <20221206124456.4159-1-edmund.berenson@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206124456.4159-1-edmund.berenson@emlix.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:44:55PM +0100, Edmund Berenson wrote:
> Add driver bindings for the maxim max7317 spi
> gpio expander.

Bindings are for h/w, not drivers.

s/maxim/Maxim/
s/spi/SPI/

For the subject, no need to say 'bindings' twice:

dt-bindings: gpio: Add Maxim max7317 GPIO expander 

> 
> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/gpio/gpio-max7317.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max7317.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-max7317.yaml b/Documentation/devicetree/bindings/gpio/gpio-max7317.yaml
> new file mode 100644
> index 000000000000..88f1fe02a627
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-max7317.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-max7317.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7317 SPI-Interfaced I/O Expander
> +
> +description: |

Don't need '|'

> +  Bindings for 10-Port Maxim MAX7317 SPI GPIO expanders.
> +
> +properties:
> +  compatible:
> +    const: maxim,max7317
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 10
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false

unevaluatedProperties: false

Or the $ref below doesn't work.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +examples:
> +  - |
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            gpio5: gpio5@0 {

gpio@0 {

> +                    compatible = "maxim,max7317";
> +                    reg = <0>;
> +                    gpio-controller;
> +                    #gpio-cells = <2>;
> +                    spi-max-frequency = <100000>;
> +            };
> +    };
> -- 
> 2.37.4
> 
> 
