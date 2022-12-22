Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD254653E37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiLVKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:25:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7A17E18;
        Thu, 22 Dec 2022 02:25:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2022361A4D;
        Thu, 22 Dec 2022 10:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84004C433D2;
        Thu, 22 Dec 2022 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671704703;
        bh=HjWsEui9j49BqsSquLS1N64hkFZnyG+wvor5Mw3io4g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EVwCaOLSGrczB2AB53z9KEZJGsQGAIMS367LMi+ZJrwt4o7mwRmZZrs+CWzeN78xr
         XU9zTTrX/hiZyCXJjOx9aUMfEn5G7mi7xQ/IG05UXQq/2c3jyal8W1cBtn6g+zjbLS
         NDi9ENra7WjrcnSQsEw6dZLRJJGnaxwFJDKKMEk90UG4TVB2mm34Bm7PUsxv8luurI
         WN/ATociYxOM3L9OAVuR16WzbVgR5PBkV8v5fBNDCkUU+DG5nArGGaF+6B7/hpNL+9
         pu/TgZzwVfKAOfc+7S2VUdkdYmvVUkYWYwcUoo2fT1/CAW9rMFXUZ/xHeINezqPS22
         Q/ZU+m4hDl3iA==
Message-ID: <d55cae92-0c4f-f957-4c7b-bdf7b9b6006a@kernel.org>
Date:   Thu, 22 Dec 2022 11:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 2/7] dt-bindings: bus: add STM32 System Bus
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-3-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-3-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 18:30, Gatien Chevallier wrote:
> Document STM32 System Bus. This bus is intended to control firewall
> access for the peripherals connected to it.
> 
> Signed-off-by: Loic PALLARDY <loic.pallardy@st.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> ---
>  .../devicetree/bindings/bus/st,sys-bus.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,sys-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/st,sys-bus.yaml b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
> new file mode 100644
> index 000000000000..9c0e86612695
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/stm32,sys-bus.yaml
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:  STM32 System Bus

Only one space.

> +
> +description: |
> +  The STM32 System Bus is an internal bus to which some internal peripherals
> +  are connected. STM32 System Bus integrates a firewall controlling access to each
> +  device. This bus prevents non-accessible devices to be probed.
> +
> +  To see which peripherals are securable, please check the SoC reference manual.
> +
> +maintainers:
> +  - Gatien Chevallier <gatien.chevallier@foss.st.com>
> +
> +allOf:
> +  - $ref: /schemas/feature-controllers/feature-domain-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32mp13-sys-bus
> +      - st,stm32mp15-sys-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  '#feature-domain-cells':

Use consistent quotes, either ' or "

> +    minItems: 1

No. Cells must be const. This does not match cells at all...

> +
> +  ranges: true
> +
> +  feature-domain-controller: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    description: Devices attached to system bus
> +    type: object
> +    properties:
> +      feature-domains:
> +        $ref: /schemas/feature-controllers/feature-domain-controller.yaml#/properties/feature-domains

maxItems

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - feature-domain-controller
> +  - '#feature-domain-cells'
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // In this example,
> +    // - the foo1 device refers to etzpc as his domain controller.
> +    // - same goes for foo2.
> +    // Access rights are verified before creating devices.
> +
> +    etzpc: etzpc@5c007000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "st,stm32mp15-sys-bus";
> +        reg = <0x5c007000 0x400>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        feature-domain-controller;
> +        #feature-domain-cells = <1>;
> +
> +        foo1: foo@1000000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +          reg = <0x0 0x1000000>;

Missing compatible, missing proper device name. Don't use fake names,
but describe real case.

> +          feature-domains = <&etzpc 0>;
> +        };
> +
> +        foo2: foo@2000000 {
> +          reg = <0x0 0x2000000>;
> +          feature-domains = <&etzpc 0>;
> +        };
> +    };

Best regards,
Krzysztof

