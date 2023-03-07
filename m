Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69496AE17A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCGNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjCGNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:55:01 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A147680;
        Tue,  7 Mar 2023 05:54:58 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id w23so14295559qtn.6;
        Tue, 07 Mar 2023 05:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBuvwas5rakj2aP+tfufeJWmOAoxKZkeTAO/lqCOX7Y=;
        b=7HJvcClAIyA+e+zYbahKa6RFX54g3JSGOlqkgYLSI6y6Yj17qPOEzqfbGWOHQwFdBr
         UUKWXjCcegPNpff774L1y8Q6l87GLbzmjmd2Q0b+dSK6eqKyqjPcudkCQR7w+JqDX0OM
         DxK45P7tCluYboRY2vACdfdMhw0HB409rmjgZ+xRUB+KlPpYkR5mFXxvd8BqwaG1cbfj
         ylt+IoWZR/OMwrGCKTv9H+0SkvX9PrSk5ipbGEEDPLEjAJhWRH8jgoitEF+Yoti/+a0m
         bPz9ZiVnv1VqzcRbdCfqWPX83zik3fCLSSQVcjQmPsaXcR9MRmE7NZ2GnBnsJMWR43uj
         7PuA==
X-Gm-Message-State: AO0yUKVQzjMpYzF+bfrrHfO1M/AWPGdTl9AmBpA6wkPaK1Pt0bMYHyCp
        qdlnZJpwFHpmSZYlPYL3Qi3t+RcQXsZd
X-Google-Smtp-Source: AK7set9zEQJsORvw11+R68g/FTC6hxiSU4XxzVnHwBl7f39BIrqhsnQ4o9WNyTK3wtztOi5cj/ArOg==
X-Received: by 2002:ac8:5cc5:0:b0:3bf:c849:4971 with SMTP id s5-20020ac85cc5000000b003bfc8494971mr22049332qta.62.1678197297693;
        Tue, 07 Mar 2023 05:54:57 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8082:8c7f:9efe:1ea4:c2ba:e845])
        by smtp.gmail.com with ESMTPSA id 69-20020a370548000000b007426f115a4esm9572273qkf.129.2023.03.07.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:54:57 -0800 (PST)
Received: (nullmailer pid 45537 invoked by uid 1000);
        Tue, 07 Mar 2023 13:54:54 -0000
Date:   Tue, 7 Mar 2023 07:54:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: gpio: add fcs,fxl6408-gpio binding
 document
Message-ID: <20230307135454.GA40797-robh@kernel.org>
References: <20230306083446.41082-1-francesco@dolcini.it>
 <20230306083446.41082-2-francesco@dolcini.it>
 <95d5b97c-ccdc-cede-a6d7-8cc64086d62d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d5b97c-ccdc-cede-a6d7-8cc64086d62d@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:41:50AM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2023 09:34, Francesco Dolcini wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > Add binding document for Fairchild FXL6408 GPIO expander.
> 
> Subject: drop second/last, redundant "binding document". The
> "dt-bindings" prefix is already stating that these are bindings.
> 
> > 
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Missing SoB.
> 
> > ---
> >  .../bindings/gpio/fcs,fxl6408-gpio.yaml       | 73 +++++++++++++++++++

Also, match the compatible string here dropping '-gpio'.

> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> > new file mode 100644
> > index 000000000000..ccf946040d00
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/fcs,fxl6408-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: FXL6408 GPIO driver
> 
> If "driver" means Linux driver, then drop.
> 
> Fairchild FXL6408 GPIO Expander
> 
> > +
> > +maintainers:
> > +  - Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > +
> > +description: |
> > +  Driver for Fairchild FXL6408 GPIO expander
> 
> This is not a driver. Drop entire description as it is duplicating title
> or add here something useful.
> 
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fcs,fxl6408
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +  gpio-line-names:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +patternProperties:
> > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> 
> >From here....
> 
> > +    type: object
> > +    properties:
> > +      gpio-hog: true
> > +      gpios: true
> > +      input: true
> > +      output-high: true
> > +      output-low: true
> > +      line-name: true
> > +
> > +    required:
> > +      - gpio-hog
> > +      - gpios
> > +
> > +    additionalProperties: false
> 
> To here, all this can be simpler:
> 
>   "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
>     required:
>       - gpio-hog
> 
> which selects gpio hog schema.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        gpio_expander_43: gpio-expander@43 {
> > +            compatible = "fcs,fxl6408";
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +            reg = <0x43>;
> > +            gpio-line-names = "Wi-Fi_W_DISABLE", "Wi-Fi_WKUP_WLAN",
> > +              "PWR_EN_+V3.3_WiFi_N", "PCIe_REF_CLK_EN",
> 
> Align with previous line/entries.
> 
> > +              "USB_RESET_N", "USB_BYPASS_N", "Wi-Fi_PDn",
> > +              "Wi-Fi_WKUP_BT";
> > +        };
> > +    };
> 
> Best regards,
> Krzysztof
> 
