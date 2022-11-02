Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA5616F92
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKBVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:20:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DC2AC2;
        Wed,  2 Nov 2022 14:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0181B82414;
        Wed,  2 Nov 2022 21:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE094C433D6;
        Wed,  2 Nov 2022 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667424046;
        bh=KxWz09Mvgj/5WrZqHX/ZJD0h7CGdGaqF4QLtpeE4PTM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hmjrThd9b+U48YarjtbPQgNvQPaXO3csUaryEvW1rX1Wf6Ay3okr7i9PXfoE8h9Tz
         AK9PVVHOHgBKR8drHHOuFPl+gqwU1QCDBtJuCl52LVwowXn7iG8QelhqZhEw1fZOuX
         RcIPOjUJ+aNC9WpdMc3N1XuAIhwtkOyyDqljF3bRq5GWETjXXbKVNaPOkeszZmnbIo
         0F24hB/MNzGDwU12kraZltbVt96tpFN+sjTdpbK0OFgzyDhGo6QKURmu69t6M14rkP
         NP0YUM/BOeqlyt6yQ/b7Dk/Z6zIZYxDVwl3G4U4Jx16K9B/g9ehrgEPXbrEUTy+Hn7
         x1FntsOBTqVeA==
Message-ID: <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
Date:   Wed, 2 Nov 2022 17:20:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221031103809.20225-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 06:38, Billy Tsai wrote:
> Unlike the old design that the register setting of the TACH should based

Drop full stop in subject. Drop redundant, second "bindings" in subject.

> on the configure of the PWM. In ast26xx, the dependency between pwm and
> tach controller is eliminated and becomes a separate hardware block. They
> only shared the same base address, source clock and reset.
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> bindings which should be the child-node of pwm-tach device.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 48 ++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++++

Split per subsystem. And Cc necessary people...

>  3 files changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..838200fae30e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    const: default

These should not be needed.

> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties:

Instead patternProperties and put them above "required:"

> +  type: object
> +  properties:
> +    reg:
> +      description:
> +        The tach channel used for this node.
> +      maxItems: 1
> +
> +  required:
> +    - reg

additionalProperties on this level of indentation.

> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..1eaf6fab2752
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller Device Tree Bindings

Drop "Device Tree Bindings"


> +
> +description: |
> +  The PWM Tach controller is represented as a multi-function device which
> +  includes:
> +    PWM
> +    Tach
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-pwm-tach
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +patternProperties:
> +  "^pwm(@[0-9a-f]+)?$":
> +    $ref: ../pwm/aspeed,ast2600-pwm.yaml

Full path, so: /schemas/pwm/aspeed,ast2600-pwm.yaml

Why unit addresses are optional?

> +
> +  "^tach(@[0-9a-f]+)?$":
> +    $ref: ../hwmon/aspeed,ast2600-tach.yaml

Ditto

Why unit addresses are optional?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    pwm_tach: pwm_tach@1e610000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

No underscores in node names.

> +      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +
> +      pwm: pwm {
> +        compatible = "aspeed,ast2600-pwm";
> +        #address-cells = <1>;
> +        #size-cells = <0>;

No need for address/size cells. No children.

> +        #pwm-cells = <3>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pwm0_default>;
> +      };
> +
> +      tach: tach {
> +        compatible = "aspeed,ast2600-tach";
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Ditto.

> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_tach0_default>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..f501f8a769df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed PWM controller can support upto 16 PWM outputs.

s/can support/supports/
s/upto/up to/

> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +

Missing $ref to pwm.yaml

> +properties:
> +  compatible:


Below, same comments apply.

This is incomplete review.

Best regards,
Krzysztof

