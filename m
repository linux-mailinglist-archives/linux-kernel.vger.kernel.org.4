Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA76EB16D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjDUSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDUSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:13:39 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD22127;
        Fri, 21 Apr 2023 11:13:36 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-18807659eddso944783fac.1;
        Fri, 21 Apr 2023 11:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100816; x=1684692816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yprpevMgRlcrrjm7dPQGh38wh58NtQ2HlVgFYleLdi4=;
        b=PUHTtV88jiqMCmYpj6WtZmUuNo+LgsrOE1vdOC0mcImWvqVKVMgKcWXZSRHUwv0uXZ
         BE/59XPHmH5GaczeVM/u86TdY4KhrWY/vFIWlZAdNyKtHwN7xGkvFqB+8RgPU+yeKtDR
         fom1h/JhAXuSpeHobsMANzrsXWlsuR6+2/P4jyaMTBrLSzYXrmnK1z/v8v6Yu4FSF0jR
         rMbObK08QlG4j12PIbzLd1iFBAiergHJJAg4RURUvB8iSpZUqu9tJ3yXuqwYhkz3PPqd
         tU5+6C11geEKwkVJDbSkEGRfyxuCVNmb+4KdLDNTx4OShf5BJ6VJ7755RUirV9uo6wJ7
         hQ+Q==
X-Gm-Message-State: AAQBX9dQpdwbNFsjDrV8aTKkWNl4VuwBhV7dp3vIsujStIEhXpJFRVA+
        FOwkpM8xj1cl3Z3i9HxzpQxiR4Ls5A==
X-Google-Smtp-Source: AKy350YaU8xpOOPU/yxP0F9qjORS+VPOjmwHhQCM7IA5C3ctz8tVdJXdhE/EB2lb5UUe8IFRobvFYg==
X-Received: by 2002:a05:6870:9611:b0:17e:be6c:d338 with SMTP id d17-20020a056870961100b0017ebe6cd338mr3932607oaq.5.1682100815874;
        Fri, 21 Apr 2023 11:13:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b24-20020a056808011800b0038c0cf168afsm1864907oie.7.2023.04.21.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:13:35 -0700 (PDT)
Received: (nullmailer pid 1567839 invoked by uid 1000);
        Fri, 21 Apr 2023 18:13:34 -0000
Date:   Fri, 21 Apr 2023 13:13:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 6/9] dt-bindings: hwmon: Add HPE GXP PSU Support
Message-ID: <20230421181334.GA1566295-robh@kernel.org>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-7-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418152824.110823-7-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:28:21AM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide i2c register information and CPLD register information to the
> driver.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/hwmon/hpe,gxp-psu.yaml           | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
> new file mode 100644
> index 000000000000..60ca0f6ace46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/hpe,gxp-psu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP psu controller
> +
> +maintainers:
> +  - Nicholas Hawkins <nick.hawkins@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-psu
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  hpe,sysreg:

Why is this optional?

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the global status registers shared between each psu
> +      controller instance.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        psu@48 {
> +            compatible = "hpe,gxp-psu";
> +            reg = <0x48>;
> +            hpe,sysreg = <&sysreg_system_controller2>;
> +        };
> +    };
> -- 
> 2.17.1
> 
