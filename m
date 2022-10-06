Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829085F607F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJFFNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJFFNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:13:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294689AFC;
        Wed,  5 Oct 2022 22:13:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 10so1067655lfy.5;
        Wed, 05 Oct 2022 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv8rhj0If1d1/L7dIvfgPXrN7Riy4f4o+27fykGhtio=;
        b=mAFpNed3JIrjaSs/2LK8SNtFFUJDkrGWRlt4TjQBH4WgbYAx4wzGRWR5BWa4Ksro8R
         yKiI1qHps2CElNbxPHO+ydW5vil2xmivg2SSYHpvud8T5b+LMOKMfIq0DOAHlSMb71MC
         XL13GM1JasTiaJk1W7704YHpK1yW7BNPxftGMyeU8a+qMkZt8oIiCzqK7qY4z0MlVB1W
         nl7Uy/7z+T0GCyaSaN2S70OQV/rjeyMPrAqOGs4KhXklj8ghy3tgmocGSWKUAqefdgys
         t6zV1dal/TrbaWx0VnwjXQ+xaAmlwbh3s8CHaylHr09aKNp0wxrQjgtyFNSsIzyYVqp8
         KmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv8rhj0If1d1/L7dIvfgPXrN7Riy4f4o+27fykGhtio=;
        b=31LLqVzc8FFYIeh67T4khh0i65U11lLsLetE3825bsr2l7Z/k2Y9NwSqrTsK3SN7i+
         KFBBIfZuyUqe8ueBJKzkAZece/TkZe1V+STl93ml9TQzWIkgAYQ69Sc5ohLcUFkE4YMz
         tLmoP/yJ23YergcwwMqvSNcEVsJ02RMFiygnf3c7CXmPpTYfUCu7GK1hF+OzlJ7bkrL3
         QxisRXrDg3k8j8+sjU/w+soQ1b5B0aa/WpmdJYlMNgxMOcrzYMNZHJxvxh9QytyxuXfj
         /Luc5QSJO+c2WOQtSF/1hA6Nf1VC7FmSHoyjPbLGItE/yyWZD/faBtW4shLFAZ0zp155
         Gjtw==
X-Gm-Message-State: ACrzQf08WS6XQc+kTgmVF+cMxEX0b6skMJ+Pr7/RKKXCNO1fTjRPg4tF
        QNuu3EiqoChENlzcEnu+JLxb/lztbo0=
X-Google-Smtp-Source: AMsMyM6SrWCqTY5R2h4MelaNqZ4aTg1f9dxFJOG1T2JexuF4wbxN38vY+UALU2FmDdgLRrsUxBKs0w==
X-Received: by 2002:a05:6512:2150:b0:4a2:2f09:9629 with SMTP id s16-20020a056512215000b004a22f099629mr1259595lfr.198.1665033220420;
        Wed, 05 Oct 2022 22:13:40 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b004a27bb1ad62sm11385lfb.205.2022.10.05.22.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 22:13:40 -0700 (PDT)
Date:   Thu, 6 Oct 2022 08:13:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: Convert IDT 89HPESx to DT schema
Message-ID: <20221006051338.wmanvzj7dflqb64y@mobilestation>
References: <20221005212631.122145-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005212631.122145-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:26:31PM -0500, Rob Herring wrote:
> Convert the IDT 89HPESx device binding to DT schema format.
> 
> "onsemi,24c64" was not a documented compatible string, so update the
> example to "atmel,24c64". It's not clear what's in use here as no
> upstream dts files have the eeprom child node.

HW manual claims the 24c32, 24c64, 24c128, 24c256, 24c512 serial
EEPROMs can be used to save the IDT 89HPESx switch firmware. So there
is no any particular EEPROM-vendor requirement. Onsemi-version of one
was just in-use on the platform for which the driver was originally
created.

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Serge, Okay with dual licensing?

Ok. Thanks for the conversion.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  .../devicetree/bindings/misc/idt,89hpesx.yaml | 72 +++++++++++++++++++
>  .../devicetree/bindings/misc/idt_89hpesx.txt  | 44 ------------
>  2 files changed, 72 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/misc/idt_89hpesx.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml b/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
> new file mode 100644
> index 000000000000..452236e79354
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/idt,89hpesx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EEPROM / CSR SMBus-slave interface of IDT 89HPESx devices
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        pattern: '^idt,89hpes'
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - pattern: '^idt,89hpes(8nt2|12nt3|12n3a?|24n3a?|(12|24)t3g2|4t4g2|10t4g2|[56]t5|8t5a?)$'
> +      - pattern: '^idt,89hpes(6t6g2|16t7|(24t6|32t8|48t12|16t4a?)(g2)?)$'
> +      - pattern: '^idt,89hpes(24nt6a|32nt8[ab]|12nt12|16nt16|24nt24|32nt24[ab])g2$'
> +      - pattern: '^idt,89hpes((32h8|48h12a?|22h16|34h16|64h16a?)(g2)?|16h16)$'
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +  
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^eeprom@':
> +    $ref: /schemas/eeprom/at24.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        description: Only a subset of devices are supported
> +        pattern: ',24c(32|64|128|256|512)$'
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        idt@74 {
> +            compatible = "idt,89hpes32nt8ag2";
> +            reg = <0x74>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            eeprom@50 {
> +                compatible = "atmel,24c64";
> +                reg = <0x50>;
> +                read-only;
> +            };
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/misc/idt_89hpesx.txt b/Documentation/devicetree/bindings/misc/idt_89hpesx.txt
> deleted file mode 100644
> index b9093b79ab7d..000000000000
> --- a/Documentation/devicetree/bindings/misc/idt_89hpesx.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -EEPROM / CSR SMBus-slave interface of IDT 89HPESx devices
> -
> -Required properties:
> -  - compatible : should be "<manufacturer>,<type>"
> -		 Basically there is only one manufacturer: idt, but some
> -		 compatible devices may be produced in future. Following devices
> -		 are supported: 89hpes8nt2, 89hpes12nt3, 89hpes24nt6ag2,
> -		 89hpes32nt8ag2, 89hpes32nt8bg2, 89hpes12nt12g2, 89hpes16nt16g2,
> -		 89hpes24nt24g2, 89hpes32nt24ag2, 89hpes32nt24bg2;
> -		 89hpes12n3, 89hpes12n3a, 89hpes24n3, 89hpes24n3a;
> -		 89hpes32h8, 89hpes32h8g2, 89hpes48h12, 89hpes48h12g2,
> -		 89hpes48h12ag2, 89hpes16h16, 89hpes22h16, 89hpes22h16g2,
> -		 89hpes34h16, 89hpes34h16g2, 89hpes64h16, 89hpes64h16g2,
> -		 89hpes64h16ag2;
> -		 89hpes12t3g2, 89hpes24t3g2, 89hpes16t4, 89hpes4t4g2,
> -		 89hpes10t4g2, 89hpes16t4g2, 89hpes16t4ag2, 89hpes5t5,
> -		 89hpes6t5, 89hpes8t5, 89hpes8t5a, 89hpes24t6, 89hpes6t6g2,
> -		 89hpes24t6g2, 89hpes16t7, 89hpes32t8, 89hpes32t8g2,
> -		 89hpes48t12, 89hpes48t12g2.
> -  - reg :	 I2C address of the IDT 89HPESx device.
> -
> -Optionally there can be EEPROM-compatible subnode:
> -  - compatible:  There are five EEPROM devices supported: 24c32, 24c64, 24c128,
> -		 24c256 and 24c512 differed by size.
> -  - reg:         Custom address of EEPROM device (If not specified IDT 89HPESx
> -    (optional)	 device will try to communicate with EEPROM sited by default
> -		 address - 0x50)
> -  - read-only :	 Parameterless property disables writes to the EEPROM
> -    (optional)
> -
> -Example:
> -	idt@60 {
> -		compatible = "idt,89hpes32nt8ag2";
> -		reg = <0x74>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		eeprom@50 {
> -			compatible = "onsemi,24c64";
> -			reg = <0x50>;
> -			read-only;
> -		};
> -	};
> -
> -- 
> 2.35.1
> 
