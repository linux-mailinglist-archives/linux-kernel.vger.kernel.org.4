Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414D719356
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFAGhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjFAGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:37:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D511F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:37:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so813170a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601425; x=1688193425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7apC6RKuTStfFjQecRNb/tnXIPfhOLZC1qqLZZRTG0I=;
        b=GOJR4HzFPq6VgPn/aBhYq/5f9RGVd7Jy+mRzng3iO7OtsLHxeBBH8PmNs+gr21mqwE
         AvnMsUtZaQgYGsZLv4a3UAnryvW7q87tOKZGLs12mbVbJT4S37SpIsVIPCqywT4iaAFH
         6mMN+rnWLe5dV3OGTdq8nYnjP2As2UIducPoz5ZuSrX1ywooYpO6SU3/Xe65HJGIav5c
         sx3YqxoZRBG+BHoKMHwYNpC85XwvTM8KdcBp/w2n8EBOyAOgPviY964n78c/2ugAm31M
         0oETQqrsYEWfUAfuvJXUXHJaPyl5geQDK6N8N4jSr3fiwUAa08JUVF4N2zXo98Qc7OBX
         RVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601425; x=1688193425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7apC6RKuTStfFjQecRNb/tnXIPfhOLZC1qqLZZRTG0I=;
        b=kOwgiKcqVblIExGP5z9x4DnLYG+9igAiuingSQrF+7sbbzQ2CaqtzfvO7gnkDMSehE
         ta0dE4Glt0Gjn112iKINCTkc/0RwGZ/HY5iViSemfsFAgUuZbQ5X3zXffh/VQLTnhPVM
         krV1FLVNjj7To2VkWMgL45Q7LrEeIni8kC1Jd3ne0hbthvPPQpCLD5bcM5V0ggwEs72A
         AmelnsQ7lvqqW3/W1dhXZerO9gLIPn0VceSlWdfs7UKAvAadTepKIwElMgJB0jbFKUVe
         PrIrkZ3gPIyxt/7o2i9LLzIdx3vUTpO1JLjBpB6Bgeqy+8FuIG5/zJw6nmZP6a+HlQ98
         x1Rw==
X-Gm-Message-State: AC+VfDwt2i4NRLs4E4JGSBfAtGRuHZ65t1V3ntOxDFFoUXtPyp8QNXnZ
        xWKl8LNWXYgNfAC74MxVy6DgmA==
X-Google-Smtp-Source: ACHHUZ7TgW4b+WDB9013cvDhBkOTEymi8GYhxlfczaoWkrf4omlIKcn3X7XrakfmoqofY5rP51amYw==
X-Received: by 2002:aa7:dad0:0:b0:514:9239:49f2 with SMTP id x16-20020aa7dad0000000b00514923949f2mr4780384eds.37.1685601425483;
        Wed, 31 May 2023 23:37:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l26-20020aa7c31a000000b0050dab547fc6sm6681914edq.74.2023.05.31.23.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:37:05 -0700 (PDT)
Message-ID: <1c70bb0a-e682-0917-c464-4748a292e90f@linaro.org>
Date:   Thu, 1 Jun 2023 08:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 02/43] dt-bindings: soc: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-3-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-3-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:33, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

You already sent v1. This patchset is attached to the previous thread
making it more complicated for me to process. This buries it deep in the
mailbox and might interfere with applying entire sets.

Is this the next version, so v3? You already had at least two versions
before, so this cannot be v1.

> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - fixed compatible - now it specifies three boards
>     	- ts7250
>     	- bk3
>     	- edb9302
>     - fixed identation in example
>     - dropped labels
> 
>  .../devicetree/bindings/arm/ep93xx.yaml       | 107 ++++++++++++++++++
>  .../dt-bindings/clock/cirrus,ep93xx-clock.h   |  53 +++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ep93xx.yaml
>  create mode 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/ep93xx.yaml b/Documentation/devicetree/bindings/arm/ep93xx.yaml
> new file mode 100644
> index 000000000000..bcf9754d0763
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ep93xx.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ep93xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx device tree bindings

No improvements.

> +
> +description: |+

no improvements. Do not need '|+' unless you need to preserve formatting.


> +  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: The TS-7250 is a compact, full-featured Single Board Computer (SBC)
> +          based upon the Cirrus EP9302 ARM9 CPU
> +        items:
> +          - const: technologic,ts7250
> +          - const: cirrus,ep9301
> +
> +      - description: The Liebherr BK3 is a derivate from ts7250 board
> +        items:
> +          - const: liebherr,bk3
> +          - const: cirrus,ep9301
> +
> +      - description: EDB302 is an evaluation board by Cirrus Logic,
> +          based on a Cirrus Logic EP9302 CPU
> +        items:
> +          - const: cirrus,edb9302
> +          - const: cirrus,ep9301
> +
> +  soc:
> +    type: object
> +    patternProperties:
> +      "^.*syscon@80930000$":
> +        type: object
> +        properties:
> +          compatible:
> +            items:
> +              - const: cirrus,ep9301-syscon
> +              - const: syscon
> +              - const: simple-mfd
> +          ep9301-reboot:
> +            type: object
> +            properties:
> +              compatible:
> +                const: cirrus,ep9301-reboot
> +        required:
> +          - compatible
> +          - reg
> +          - ep9301-reboot
> +
> +      "^.*timer@80810000$":
> +        type: object
> +        properties:
> +          compatible:
> +            const: cirrus,ep9301-timer
> +
> +    required:
> +      - syscon@80930000
> +      - timer@80810000

I don't understand what are you putting here. Why addresses are in
bindings (they should not be), why some nodes are documented in
top-level compatible. Drop all this.

Open existing files and look how it is done there.

> +
> +required:
> +  - compatible
> +  - soc> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +      compatible = "technologic,ts7250", "cirrus,ep9301";
> +      model = "TS-7250 SBC";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        compatible = "simple-bus";
> +
> +        syscon@80930000 {
> +          compatible = "cirrus,ep9301-syscon",
> +                        "syscon", "simple-mfd";
> +          reg = <0x80930000 0x1000>;
> +
> +          ep9301-reboot {
> +            compatible = "cirrus,ep9301-reboot";
> +          };
> +        };
> +
> +        timer@80810000 {
> +          compatible = "cirrus,ep9301-timer";
> +          reg = <0x80810000 0x100>;
> +          interrupt-parent = <&vic1>;
> +          interrupts = <19>;
> +        };
> +      };
> +    };

Drop all this. There is no existing binding like that.

> +
> +...
> diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h b/include/dt-bindings/clock/cirrus,ep93xx-clock.h

Not related to top level compatible.

> new file mode 100644
> index 000000000000..6a8cf33d811b
> --- /dev/null
> +++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

> +#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +
> +#define EP93XX_CLK_XTALI	0
> +


Best regards,
Krzysztof

