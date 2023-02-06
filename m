Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0B68C718
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBFTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:55:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1E2820C;
        Mon,  6 Feb 2023 11:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6DA3B815FB;
        Mon,  6 Feb 2023 19:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A80DC433D2;
        Mon,  6 Feb 2023 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675713316;
        bh=x0oD17S0/1CLJnGLH9iD1hxf62OiooTTKy/Q2s56BYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sG6C/2gzWM3tYvIrJb8I23pi42ElybXEGbJ7080xrsz5NXdUbbZxw6RpYYkXayqUq
         Q7/GInr0VJTw6MflBTmrfTVXPL2hYRfUnRb+JVeluhz73VgMk19KQRPIQxDFJ1SxWa
         1IB+qBRluFfm78oEpWtfBAbF5LckGoHz/GIdCZ1HOPs8MMfH+1b0un2LLL1G9Tmmdg
         6co+ZS8gqfyr9nUGl8scxNfnWOjOqdi/XsHpx5RKmWsUdDh8/gvP4DZeBfQNzqLvq6
         u9CmsA3ZTuqizVKNY0l8PxP9E87fp6b4K0T+Tyf5C3XFUkpFTNKEiW3bQCclACBP7s
         6a5KFO3jSALMw==
Received: by mail-vs1-f43.google.com with SMTP id y8so13959878vsq.0;
        Mon, 06 Feb 2023 11:55:16 -0800 (PST)
X-Gm-Message-State: AO0yUKU9MTkb/juvt3EFSwX0y7RmsBhF9qPnaYrA9KvcCzLxs79q4dsc
        7GJsyl4ZZPvatOp5mp7e8Cd4naTQOrTH+xEgrA==
X-Google-Smtp-Source: AK7set93aZD9DhXMsr+HrpYTVLyOGOiqhromt8iBj7FIL5vA7u7EXhitVPK4xRog/7IQcegYFqSmO370ISv83kjze/g=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr191202vsc.53.1675713315265; Mon, 06 Feb
 2023 11:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20230206153325.43692-1-sunrockers8@gmail.com>
In-Reply-To: <20230206153325.43692-1-sunrockers8@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Feb 2023 13:55:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoH2EdWxZc115HpGLmqQ3Wu8q3MS85NiqGKu57Y1o6dA@mail.gmail.com>
Message-ID: <CAL_JsqJoH2EdWxZc115HpGLmqQ3Wu8q3MS85NiqGKu57Y1o6dA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller :
 convert the binding document to yaml
To:     Vijaya Anand <sunrockers8@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 9:35 AM Vijaya Anand <sunrockers8@gmail.com> wrote:
>
>     Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
>     from txt to yaml so one could validate dt-entries correctly and any future additions can go
>     into yaml format. The options for compatability described according to the example given.

Missing DCO (Signed-off-by). checkpatch.pl will tell this for you.

> ---
>  .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
>  .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
>
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> deleted file mode 100644
> index d62c783d1d5e..000000000000
> --- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* ASPEED AST2400 and AST2500 coprocessor interrupt controller
> -
> -This file describes the bindings for the interrupt controller present
> -in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> -ColdFire coprocessor.
> -
> -It is not a normal interrupt controller and it would be rather
> -inconvenient to create an interrupt tree for it as it somewhat shares
> -some of the same sources as the main ARM interrupt controller but with
> -different numbers.
> -
> -The AST2500 supports a SW generated interrupt
> -
> -Required properties:
> -- reg: address and length of the register for the device.
> -- compatible: "aspeed,cvic" and one of:
> -               "aspeed,ast2400-cvic"
> -             or
> -               "aspeed,ast2500-cvic"
> -
> -- valid-sources: One cell, bitmap of supported sources for the implementation
> -
> -Optional properties;
> -- copro-sw-interrupts: List of interrupt numbers that can be used as
> -                      SW interrupts from the ARM to the coprocessor.
> -                      (AST2500 only)
> -
> -Example:
> -
> -       cvic: copro-interrupt-controller@1e6c2000 {
> -               compatible = "aspeed,ast2500-cvic";
> -               valid-sources = <0xffffffff>;
> -               copro-sw-interrupts = <1>;
> -               reg = <0x1e6c2000 0x80>;
> -       };
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> new file mode 100644
> index 000000000000..bbff0418fa2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/aspeed,cvic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400 and AST2500 coprocessor interrupt controller
> +
> +maintainers:
> +  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
> +  - Rob Herring <robh@kernel.org>

Should be someone that has and cares about Aspeed h/w, not me.

> +
> +description: |
> +  This file describes the bindings for the interrupt controller present
> +  in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> +  ColdFire coprocessor.
> +
> +  It is not a normal interrupt controller and it would be rather
> +  inconvenient to create an interrupt tree for it as it somewhat shares
> +  some of the same sources as the main ARM interrupt controller but with
> +  different numbers.
> +
> +  The AST2500 supports a SW generated interruptThe Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> +  which provides high-throughput LDPC and Turbo Code implementations.
> +  The LDPC decode & encode functionality is capable of covering a range of
> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +  principally covers codes used by LTE. The FEC Engine offers significant
> +  power and area savings versus implementations done in the FPGA fabric.
> +
> +properties:
> +
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-cvic
> +      - aspeed,ast2500-cvic
> +
> +  reg:
> +    maxItems: 1
> +    description: address and length of the register for the device.

Drop generic descriptions.

> +
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: One cell, bitmap of supported sources for the implementation

Drop 'one cell'. The type says that.

> +
> +  copro-sw-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Is there a range of number of entries and/or values for entries. If
so, add constraints.

> +    description: |

Don't need '|' if no formatting to maintain.

> +                  List of interrupt numbers that can be used as
> +                  SW interrupts from the ARM to the coprocessor.
> +                  (AST2500 only)
> +
> +required:
> +  - compatible
> +  - reg
> +  - valid-sources
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cvic: copro-interrupt-controller@1e6c2000
> +    {
> +        compatible = "aspeed,ast2500-cvic";
> +        valid-sources = <0xffffffff>;
> +        copro-sw-interrupts = <1>;
> +        reg = <0x1e6c2000 0x80>;
> +    };
> --
> 2.37.1 (Apple Git-137.1)
>
