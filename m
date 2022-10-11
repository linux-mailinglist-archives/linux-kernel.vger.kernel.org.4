Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A85FBB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJKTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:05:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0B88A1E;
        Tue, 11 Oct 2022 12:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A32EEB8162A;
        Tue, 11 Oct 2022 19:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFD0C433D6;
        Tue, 11 Oct 2022 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665515152;
        bh=lA8HVxH8Er792775c7b2bmBxc830NlnM5GgCsTOYHks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LO0t4Vfe0i2latyWK/FVonMg7g1msj84dQ+ijhC0V2dpTfVDM4iOTXwQTKdNz/uuN
         VRZaBssxHRTMZDseKg1+/6uJRhadkGhv56q2BrlPXD9rQNiYfiyXb7FQzxlsO/BQVd
         QDdzBCH6TYF5g+lW56kXW13SknWpl6ywH3tgiWsplZpaqZWeRTHoMAxsbXl5Vw/ydx
         XFgrL6gd0WU9iM2wAuitKRBPhlJnvUv4M+Hp3sCEsZcIe8rmJk5qVhgo7qPrfgQ8eZ
         K9UcWqX4KGDOt3UAvBKjxjprGJV3/bVKMT/R/hKd2F/DPkfh3O18w2l5Z2PPiX5XJc
         k87WePE9BwNeA==
Received: by mail-vk1-f171.google.com with SMTP id e5so7115529vkg.6;
        Tue, 11 Oct 2022 12:05:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ckWLDZUy3jDQTMuVtC0ls3LxBqiRedVimEdK2qqBV4pAHtSuw
        KRA4in6A5yXLAsWBt0/jXl5uvgFWZI2T7PM/mA==
X-Google-Smtp-Source: AMsMyM5H3zqGHE8PRlHKOHMAwzqh7D8ZkbW5K5Q+eh4cP7JlkLwY2IdoTbpAIx6vMrdlK9Fv+pFPkJdxgzOt3IgRlqc=
X-Received: by 2002:a1f:60cd:0:b0:3ae:da42:89d0 with SMTP id
 u196-20020a1f60cd000000b003aeda4289d0mr1844824vkb.15.1665515151438; Tue, 11
 Oct 2022 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com> <20221011104739.53262-2-Naresh.Solanki@9elements.com>
In-Reply-To: <20221011104739.53262-2-Naresh.Solanki@9elements.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Oct 2022 14:05:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmzcM2m6iU_hvy8=a1QP=Xm9HU0U=R_GkO4UxW+Fn=fQ@mail.gmail.com>
Message-ID: <CAL_JsqLmzcM2m6iU_hvy8=a1QP=Xm9HU0U=R_GkO4UxW+Fn=fQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 5:47 AM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> Add common fan properties bindings to a schema.
>
> Bindings for fan controllers can reference the common schema for the
> fan
>
> child nodes:
>
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       allOf:

Don't allOf here.

>         - $ref: fan-common.yaml#
>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..abc8375da646
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license with BSD-2-Clause.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulse-per-revolution:

The already in use property is 'pulses-per-revolution'.

> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32

I assume there's a known set of values various fans have?

> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.

Which driver? I think 'default-rpm' would be a better name.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-frequency:
> +    description:
> +      PWM frequency for fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-polarity-inverse:
> +    description:
> +      PWM polarity for fan.
> +    type: boolean

Both of these properties are handled by the PWM binding already. I
think this should use it even though the PWMs are just connected to
the child nodes. There's always the possibility that someone hooks up
a fan controller PWM to something else besides a fan.

> +
> +  label:
> +    description:
> +      Optional fan label
> +    $ref: /schemas/types.yaml#/definitions/string

Doesn't a fan need power? 'fan-supply' is already in use, so that could be used.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |

Drop the example here as you have it in the max6639 schema.

> +
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan-controller@30 {
> +            compatible = "maxim,max6639";
> +            reg = <0x30>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            fan@0 {
> +                reg = <0>;
> +                label = "CPU0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +
> +            fan@1 {
> +                reg = <1>;
> +                label = "PCIe0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +
> +        };
> +    };
> +
> +...
>
> base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4
> --
> 2.37.3
>
