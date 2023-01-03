Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED165C93F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjACWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjACWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:14:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5FF71;
        Tue,  3 Jan 2023 14:14:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r130so28258934oih.2;
        Tue, 03 Jan 2023 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1IksS8NxxXXZYII/OPwlDewaxwz5V+ENNWWsENNd3U=;
        b=ejJpFhOUTCkKi7QY8QrTP7v0x6Gg8ffP257/zLnvfmXki/CzK0hKkK4Y+BoVV5493a
         nHI5xUgKyIYKNDH5+YXeiZzU2J3xVmDc1KArcBMoqWrKplB5immB8R5HqjRS2aNubiIL
         WHuwIQHuTiZouMVC3U0tvyTmhToR8tRvU6VPw+3j48PAcKAmxaI0ATSMRN/dAWv+jnvv
         RsyHFSm6w8hzTxFMy33FjvnCtnRYEb1GBvKMyFqnpsBT2EwyeGOmbZ/m+OYXoxRUIDNT
         3jxxOnmfUQkWZmDKklHCuLgtI31FkbWia8urHZ0IYl7xMEay9sZjKnEUPQ6fMCO2s58n
         P28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1IksS8NxxXXZYII/OPwlDewaxwz5V+ENNWWsENNd3U=;
        b=BZPG+tDcBt4OTT6ZAUDjgYFDeSFxid0XXSXOMeqBJtNcjePHaicDvglCDAqlF3Zap4
         9myaCl3W+9vDp9ckQxKrqmq/f4OhziUTJ24hCc051OCCJ+dxiscbqyT126fqaDU5heBw
         c/h23ZWuj3dkhpX9X7vEQURUxWkHhYY8qQuCTM5lNCvIr7gQNc4UkkhlU/sDh6xY0VwH
         7wtVIk+WsRckJJJcOoqsmw6a8HswPF+1opNR9pMLnRwNH8EvpcSFxu/Cl8Cy087sprvN
         NVP4kOO/dkU6t0vyy7/eECB+r5y/4sa9AfWDhLQAjqXxt4/4AvH09REchbzqBwQk4Nsz
         tYZw==
X-Gm-Message-State: AFqh2kr0LWi/IWBO8ANaAbNuj4oJ8C8H1Q0g+hb5vyCAb40ZOSKEG0Lb
        RJ5zTnqArNPSFKE5hmOoub0=
X-Google-Smtp-Source: AMrXdXsj1u6ooXmWsaBlvs9AC+gDm/4awnmYnYB9Um0hPJ/NuIZvtGDq5unbn7E3nvgUDUAR/6uz1w==
X-Received: by 2002:a05:6808:6d4:b0:363:a6c3:8dd3 with SMTP id m20-20020a05680806d400b00363a6c38dd3mr7133019oih.44.1672784047526;
        Tue, 03 Jan 2023 14:14:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n67-20020acabd46000000b0035b451d80afsm13468032oif.58.2023.01.03.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 14:14:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 14:14:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: hwmon: Add starfive,jh71x0-temp
Message-ID: <20230103221405.GA217696@roeck-us.net>
References: <20230103013145.9570-1-hal.feng@starfivetech.com>
 <20230103013145.9570-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103013145.9570-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:31:42AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the temperature sensor on the StarFive JH7100 and
> JH7110 SoCs.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

The previous version of this bindings document (v3, 
https://patchwork.kernel.org/project/linux-hwmon/patch/20210726171802.1052716-2-kernel@esmil.dk/
had been reviewed by Rob Herring. Even though this version is named differently
(starfive,jh71x0-temp.yaml instead of starfive,jh7100-temp.yaml), the old version
should be referenced, and there should be a change log.

Guenter

> ---
>  .../bindings/hwmon/starfive,jh71x0-temp.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> new file mode 100644
> index 000000000000..2600881e2cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/starfive,jh71x0-temp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH71x0 Temperature Sensor
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +description: |
> +  StarFive Technology Co. JH71x0 embedded temperature sensor
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7100-temp
> +      - starfive,jh7110-temp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: "sense"
> +      - const: "bus"
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: "sense"
> +      - const: "bus"
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7100.h>
> +    #include <dt-bindings/reset/starfive-jh7100.h>
> +
> +    tmon@124a0000 {
> +        compatible = "starfive,jh7100-temp";
> +        reg = <0x124a0000 0x10000>;
> +        clocks = <&clkgen JH7100_CLK_TEMP_SENSE>,
> +                 <&clkgen JH7100_CLK_TEMP_APB>;
> +        clock-names = "sense", "bus";
> +        #thermal-sensor-cells = <0>;
> +        interrupts = <122>;
> +        resets = <&rstgen JH7100_RSTN_TEMP_SENSE>,
> +                 <&rstgen JH7100_RSTN_TEMP_APB>;
> +        reset-names = "sense", "bus";
> +    };
