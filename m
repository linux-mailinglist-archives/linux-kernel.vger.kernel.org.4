Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12A730B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjFNW6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFNW6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:58:03 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B8211D;
        Wed, 14 Jun 2023 15:58:02 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-340b48c180bso3445365ab.0;
        Wed, 14 Jun 2023 15:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686783482; x=1689375482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLGM39FLWeHazKbyQ5qG1ef0mVobIExKkf/G6dZDYYk=;
        b=H8Lzr+iFAzjw5EJ/iz3jIAx3KTj+IG/VB9DMmsQdsp/9fGtS/FnE53FRVRol3xZseG
         6u/OwzNEwBXtKGEQMJuJduGvLanZB/WrSwBBI62/Cx6ZDGwZZjxyMlR1nEIt87p992AZ
         Ovf9SdhUYqvGWE5U3YyrDDOVgdcWde+ep+svGMc6vafzsjPckiaw09ghvC19Ye7bCGj1
         cn9h1I6EbOPcoQhM2xxbeUNi9z/mTt43jEd4xWBUaR+zAyrdt/ySeSRUb6VVm7hNGcFA
         gHsUC1aAYVzvicYvuUlBmWeuEiijLb6XawBpRdINtNKyu6nPlxYSDs8MIqCkD/7M3D4g
         tf1g==
X-Gm-Message-State: AC+VfDyV+WUxQHX05SYc3sJz4dABAIThkqQZYEhAUrTPj7L+Xb6h2yUM
        jTVUH4UnimzQGxBiLgjQ6Q==
X-Google-Smtp-Source: ACHHUZ4k17CCU/Cdgkvy8zZd1iBM9okPT7i/UNDIJhF1Nh6e59EfqO7f9Vf5PDbEGaNZhJDBaJyQ1w==
X-Received: by 2002:a92:c992:0:b0:337:a0d8:cdf9 with SMTP id y18-20020a92c992000000b00337a0d8cdf9mr16280943iln.28.1686783482112;
        Wed, 14 Jun 2023 15:58:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k11-20020a02cccb000000b004065707eb2bsm5292604jaq.42.2023.06.14.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 15:58:01 -0700 (PDT)
Received: (nullmailer pid 3018539 invoked by uid 1000);
        Wed, 14 Jun 2023 22:57:59 -0000
Date:   Wed, 14 Jun 2023 16:57:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add Nuvoton NCT7362Y binding
Message-ID: <20230614225759.GA3003701-robh@kernel.org>
References: <20230607101827.8544-4-zev@bewilderbeest.net>
 <20230607101827.8544-5-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607101827.8544-5-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:18:29AM -0700, Zev Weiss wrote:
> This binding describes the NCT7362Y, a 16-channel fan/GPIO controller.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/hwmon/nuvoton,nct7362.yaml       | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
> new file mode 100644
> index 000000000000..630dcce7a14c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7362.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7362Y fan controller
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +description: |
> +  The Nuvoton NCT7362Y is an I2C fan controller with 16 pins that can
> +  be independently configured for PWM, fan tach, or GPIO
> +  functionality.  Each pin's functionality is represented by a child
> +  node.
> +
> +  The datasheet is not publicly available but can be requested from
> +  Nuvoton via their web site.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7362
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
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 16
> +
> +patternProperties:
> +  "^tach@([1-8]|1[0-7])$":

Unit-addresses are hex typically.

Why do you need a child node for tach. Is that a separate h/w block.

> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: The pin number.
> +
> +      nuvoton,pulses-per-revolution:

This is a property of the fan attached and belongs in a fan node 
describing the fan(s) properties. Until a common binding exists, further 
fan controller bindings are going to be rejected.

The furthest attempt was here[1]. And there's the Aspeed effort[2] which 
keeps ignoring our feedback. Please work together on these.

Rob

[1] https://lore.kernel.org/all/20221121122932.2493174-2-Naresh.Solanki@9elements.com/ 
[2] https://lore.kernel.org/all/20230608021839.12769-1-billy_tsai@aspeedtech.com/
