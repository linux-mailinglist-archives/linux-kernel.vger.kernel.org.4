Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E966F093B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbjD0QKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0QKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:10:52 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09F35BB;
        Thu, 27 Apr 2023 09:10:51 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-18f16a2c329so5328206fac.0;
        Thu, 27 Apr 2023 09:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611850; x=1685203850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zb4UIqURY+BWTS3e9vX+YTZaBHbEmn0Eg9W3zLRlAs=;
        b=TVTe8fmkiSObNpKmCb48LRQ9XR6DmHlGNVO4hqQMq3XJZ7mWKBt2P0fKIrwa9oSFzw
         cySYBtWNR5Ijg90pOuguNvuALh4mHVfCApFzPcz+9wETK5L6fxoBzUVSFVquGNtEQIYU
         mFEz39VyB/Ur08g++kXD6J0C6bSyKgaNf4aHXmaAeP48zr2aHehtLUKHXxJgXBqXaW/N
         KqkSOiE76Im9RFVY5CUZZoy29C7OJp4Lpp0cl8ti3DscbQcUH/RV7ImaZvnvVWK1RtvE
         iUgVJ68WGA5F0/SgsR6ZJSXFyfIdxPhMW16SjxdDV/WTEZxmKfRcUU6A6Q4soo272Xk0
         ifyA==
X-Gm-Message-State: AC+VfDwiGBoWL6aWm+Vq06D3ByvVkCGjEJk/qZ9Zr6FKeN36N7mzoDvZ
        kvRFJlNV83voEH57XHTfHA==
X-Google-Smtp-Source: ACHHUZ69Sq4w3EraVz3yG/3YjM+ceN2r9AONaP5KgtunTytLs//j63DXjClPMLRDUmHDfuI/a8cy3w==
X-Received: by 2002:a05:6830:201a:b0:6a7:bced:411e with SMTP id e26-20020a056830201a00b006a7bced411emr1138804otp.3.1682611850271;
        Thu, 27 Apr 2023 09:10:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i15-20020a9d624f000000b0069fb8bfb4f3sm8056756otk.77.2023.04.27.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:10:49 -0700 (PDT)
Received: (nullmailer pid 3112114 invoked by uid 1000);
        Thu, 27 Apr 2023 16:10:49 -0000
Date:   Thu, 27 Apr 2023 11:10:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: Add STMPE YAML DT schema
Message-ID: <20230427161049.GA3107476-robh@kernel.org>
References: <20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org>
 <20230426-stmpe-dt-bindings-v2-1-2f85a1fffcda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426-stmpe-dt-bindings-v2-1-2f85a1fffcda@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 01:21:38PM +0200, Linus Walleij wrote:
> This adds a schema for the STMPE GPIO that while it is used a
> lot in the kernel tree is anyway missing its bindings.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - New patch split off from the MFD patch.
> ---
>  .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml
> new file mode 100644
> index 000000000000..6e991ebbdf77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectonics Port Expander (STMPE) GPIO Block
> +
> +description: STMicroelectronics Port Expander (STMPE) is a series of slow
> +  bus controllers for various expanded peripherals such as GPIO, keypad,
> +  touchscreen, ADC, PWM or rotator. It can contain one or several different
> +  peripherals connected to SPI or I2C. These bindings pertain to the
> +  GPIO portions of these expanders.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: st,stmpe-gpio
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  interrupt-controller: true
> +
> +  st,norequest-mask:
> +    description: A bitmask of GPIO lines that cannot be requested because for
> +      for example not being connected to anything on the system
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +patternProperties:
> +  "^.+-hog(-[0-9]+)?$":
> +    type: object
> +
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios

All you need for hog nodes is:

"^.+-hog(-[0-9]+)?$":
  type: object
  required:
    - gpio-hog

The presence of 'gpio-hog' causes the hog schema to be applied.

Rob
