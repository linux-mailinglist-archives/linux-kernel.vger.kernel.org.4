Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9E6CD45F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjC2ITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjC2ITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:19:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBA4C04
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:17:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q16so19066885lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZeSEMAezPQcLb1lLJsGn1oGXvY3H1ZgCakhIROmykM=;
        b=j4kJH9oqit1djyWk9BnRKF6szJ4tbZ2O6LwCWfkgnFVO3tW+Qk4/1f2mELIMvD8GlD
         FkkTBb9HS6aXi/Hab6gCv/TYQuG352A8bLkyOzjiAeCMvR36HUcJBslLn/4GioBbcEPO
         opWhhcl+Ryj9ed569sIRq2kpHQSs4FIt8pjn5JK4AmdJ/3lk83drQCVsMlOzZVzXoosU
         a7jPTJP5JrB3pSQwxoQmS94C3IED5XWWpnoS5nGQ46+Mf8nQZNsneXkKXSKBaidU2chj
         aa66vXtvvu+Ou0XkEY03Qa340Kz+5x4Hdxp+TDv8ah41wzeTxQb+/kVCp/TQkan4jq2Z
         uNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZeSEMAezPQcLb1lLJsGn1oGXvY3H1ZgCakhIROmykM=;
        b=yAG3G631VZW2zRe7mA9HmPY2Gj1UK++T9km1EPy9yroKBncV0JMPZlci1iXNBqYlk1
         HvLCBiopP4rowytBMCqW860XbM3qpw3rhZyD9umAIXaEoKZE82lBCGtEPRMApjmtPW3m
         /tYB+Goc4JZCOJc0sX7rPBluJYNvZQ+VNSRDS+V5LTtIKT09096XEYU3DLS5pIzbtc8U
         LjDl5UUDIZksSc5kpIGgd4T116d7z22muNQjLdAKRmfBg6fbrAIVgJUeaiSJjy+okNJt
         hgzenISKD64Si44G5NCxI3cRqupYJptBbx0duJ2hxEcSfLs9+/zAWK313LSyVvzJ7ELl
         Bp2A==
X-Gm-Message-State: AAQBX9euZ/0leGPGsUc6OZA/kapEUWqGOb5zogmOxAf3pDUuHqgRXcDK
        lFIXDnenNCOZLriB8VcAAXo4iA==
X-Google-Smtp-Source: AKy350Z+3FsH4vJkmVHkYStFz/CgCVfA5zD1ravlknUErM3ZBYmshboFIYZSfaWclera6eFJM08tew==
X-Received: by 2002:a19:a40a:0:b0:4eb:982:adf with SMTP id q10-20020a19a40a000000b004eb09820adfmr3325108lfc.26.1680077856930;
        Wed, 29 Mar 2023 01:17:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5370655lfo.111.2023.03.29.01.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:17:36 -0700 (PDT)
Message-ID: <96bbb16a-1748-c0cb-0fc6-90804eab01c1@linaro.org>
Date:   Wed, 29 Mar 2023 10:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for
 ma35d1 IP reset control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-5-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-5-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the reset controller and reset references in the dts.
> Add documentation to describe nuvoton ma35d1 reset driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  44 +++++++
>  .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>  create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> new file mode 100644
> index 000000000000..342717257e5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Reset Controller
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in MA35D1 SoC.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # system reset controller node:
> +  - |
> +
> +    system-management@40460000 {
> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> +        reg = <0x40460000 0x200>;
> +
> +        reset-controller {
> +            compatible = "nuvoton,ma35d1-reset";
> +            #reset-cells = <1>;

You do not take any resources here, thus this should be rather part of
the parent node.

> +        };
> +    };
> +...
> +
> diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
> new file mode 100644
> index 000000000000..f3088bc0afec
> --- /dev/null
> +++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */

Weird license, why 2.0+?

You already got here comment about license in previous version of this
patch.


> +/*
> + * Copyright (C) 2023 Nuvoton Technologies.
> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
> + *
> + * Device Tree binding constants for MA35D1 reset controller.
> + */
> +
> +#ifndef __DT_BINDINGS_RESET_MA35D1_H
> +#define __DT_BINDINGS_RESET_MA35D1_H
> +
> +#define MA35D1_RESET_CHIP	0
> +#define MA35D1_RESET_CA35CR0	1
> +#define MA35D1_RESET_CA35CR1	2
> +#define MA35D1_RESET_CM4	3
> +#define MA35D1_RESET_PDMA0	4
> +#define MA35D1_RESET_PDMA1	5
> +#define MA35D1_RESET_PDMA2	6
> +#define MA35D1_RESET_PDMA3	7
> +#define MA35D1_RESET_DISP	9
> +#define MA35D1_RESET_VCAP0	10
> +#define MA35D1_RESET_VCAP1	11
> +#define MA35D1_RESET_GFX	12
> +#define MA35D1_RESET_VDEC	13
> +#define MA35D1_RESET_WHC0	14
> +#define MA35D1_RESET_WHC1	15
> +#define MA35D1_RESET_GMAC0	16
> +#define MA35D1_RESET_GMAC1	17
> +#define MA35D1_RESET_HWSEM	18
> +#define MA35D1_RESET_EBI	19
> +#define MA35D1_RESET_HSUSBH0	20
> +#define MA35D1_RESET_HSUSBH1	21
> +#define MA35D1_RESET_HSUSBD	22
> +#define MA35D1_RESET_USBHL	23
> +#define MA35D1_RESET_SDH0	24
> +#define MA35D1_RESET_SDH1	25
> +#define MA35D1_RESET_NAND	26
> +#define MA35D1_RESET_GPIO	27
> +#define MA35D1_RESET_MCTLP	28
> +#define MA35D1_RESET_MCTLC	29
> +#define MA35D1_RESET_DDRPUB	30
> +#define MA35D1_RESET_TMR0	34
> +#define MA35D1_RESET_TMR1	35
> +#define MA35D1_RESET_TMR2	36
> +#define MA35D1_RESET_TMR3	37
> +#define MA35D1_RESET_I2C0	40
> +#define MA35D1_RESET_I2C1	41
> +#define MA35D1_RESET_I2C2	42
> +#define MA35D1_RESET_I2C3	43
> +#define MA35D1_RESET_QSPI0	44
> +#define MA35D1_RESET_SPI0	45
> +#define MA35D1_RESET_SPI1	46
> +#define MA35D1_RESET_SPI2	47
> +#define MA35D1_RESET_UART0	48
> +#define MA35D1_RESET_UART1	49
> +#define MA35D1_RESET_UART2	50
> +#define MA35D1_RESET_UAER3	51
> +#define MA35D1_RESET_UART4	52
> +#define MA35D1_RESET_UART5	53
> +#define MA35D1_RESET_UART6	54
> +#define MA35D1_RESET_UART7	55
> +#define MA35D1_RESET_CANFD0	56
> +#define MA35D1_RESET_CANFD1	57
> +#define MA35D1_RESET_EADC0	60

Why do you have gaps here? These should be IDs, not register offsets.

Best regards,
Krzysztof

