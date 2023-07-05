Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52D748B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjGER7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGER7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86BE70
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CB3616A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E225C433C7;
        Wed,  5 Jul 2023 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688579938;
        bh=/4NJBC7nCuz/v6FRdCQv4Fx4keLpeEtW5UQGOCJt/uY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gzvdw6oUzJvpRCywPVoC3S1KnQktli97BOTkw8QAc6kMbl75cKOi0Sm7KaehaWIfz
         WyZMP1G8VsZGveeMHpapWIg3t3vTPcE0ASw7z/2T7yJaDz8WZWZA0NT+XMUUkJyb6L
         BOjRV/DoZy8H9V9Oe7KtWnHUHDxFuoOPuO90/xSh0dcnIc9LhrXny+C3XyO0Esy725
         2WdNxw0pc2DO/YdXgoJVz9fex0XBIs6HY5sNBtQjyMzuxC4Sblm3hxMlaknjDBh4IT
         MC8zHYrWXhXG4EjrvHv8Oap2QKUeCubbif//JcTCD7aACi9Jp6G27Gwa0biVUaieHF
         r8MsWfL9Ed1Gw==
Message-ID: <d3308334-aa91-f265-2469-8a6fbc727798@kernel.org>
Date:   Wed, 5 Jul 2023 19:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     alina_yu@richtek.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cy_huang@richtek.com
References: <cover.1688569987.git.alina_yu@richtek.com>
 <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <341af3996c430549243365bb8204d33a15a482be.1688569987.git.alina_yu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 17:27, alina_yu@richtek.com wrote:
> From: alinayu <alina_yu@richtek.com>
> 
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Limited review follows.

> 
> Signed-off-by: alinayu <alina_yu@richtek.com>
> ---
>  .../regulator/richtek,rtq2208-regulator.yaml       | 228 +++++++++++++++++++++
>  1 file changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> new file mode 100644
> index 0000000..2a060ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml

Filename like compatible.

> @@ -0,0 +1,228 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rtq2208-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RTQ2208 SubPMIC Regulator
> +
> +maintainers:
> +  - Alina Yu <alina_yu@richtek.com>
> +
> +description: |
> +  The RTQ2208 is a highly integrated multi-configurable power converter that
> +  offers functional safety embedded dual multi-configurable synchronous buck
> +  converters and two LDOs.
> +
> +  Bucks support "regulator-allowed-modes" and "regulator-mode". The former defines the permitted
> +  swiching operation in normal mode; the latter defines the operation in suspend to RAM mode.
> +
> +  No matter the RTQ2208 is configured in normal or suspend to RAM mode, there are two switching
> +  operation modes for all buck rails, automic power saving mode (Auto mode) and forced continious
> +  conduction mode (FCCM).
> +
> +  The meaning of modes is defined in the datasheet which is avaliabe in below link

You have several typos here and before. Please run spellcheck.

> +  and their meaning is::
> +    0 - Auto mode for power saving, which reducing the switching frequency at light load condition
> +    to maintain high frequency.
> +    1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
> +
> +  Datasheet will be available soon at
> +  https://www.richtek.com/assets/Products
> +
> +  The standard "regulator-mode" property can only be used for bucks that
> +  changing their mode to suspend to RAM mode. Also, it only takes effect if the
> +  regulator has been enabled for the given suspend state using "regulator-on-in-suspend".
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rtq2208
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    
> +  richtek,mtp-sel:
> +    description: |
> +      Buck and ldo vout selection is based on this value.
> +      There are two independently programmable voltage settings named as mtp-sel0 and
> +      mtp-sel1 for RTQ2208 bucks vout voltage. 0 which means this property isn't present
> +      and 1 which means this property is present corresponds to different adjustable registers.
> +
> +      0 - DVS0 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL0 register to en/disable vout.
> +      1 - DVS1 registers to adjust buck vout and BUCK_[A-H]_EN_NR_MTP_SEL1 register to en/disable vout.

I read it three times and still don't understand. This is bool, not 0/1,
so are these "0" refer to DVS0 or to presence of the property? Maybe
Mark will understand it, I don't get it.

> +

No blank line. Just put type before description.

> +    type: boolean
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^buck_[A-H]$":

No underscores in node names. Lowercase names.

> +        type: object
> +        $ref: regulator.yaml#

Missing unevaluatedProperties: false

> +        description: |
> +          regulator description for buck[A-H].
> +
> +        properties:
> +          regulator-compatible:
> +            pattern: "^BUCK_[A-H]$"

Drop the property.

> +
> +          regulator-allowed-modes:
> +            description: |

Do not need '|' unless you need to preserve formatting.

> +              describe buck permitted modes.

Exactly: describe them

> +
> +      "^ldo[1-2]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          regulator description for ldo[1-2].
> +
> +        properties:
> +          regulator-compatible:
> +            pattern: "^LDO[1-2]$"
> +
> +          richtek,fixed_uV:
> +            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            enum: [ 900000, 1200000, 1800000, 3300000 ]
> +            description: |
> +              the fixed voltage in microvolt which is descided at the factory.
> +
> +      regulator-state-(mem):

That's not a pattern.

> +        type: object
> +        additionalProperties: true

Why?

> +        properties:
> +          regulator-on-in-suspend: false
> +          regulator-mode: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rtq2208@10 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "richtek,rtq2208";
> +        reg = <0x10>;
> +        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +        richtek,mtp-sel;
> +
> +        regulators {
> +         BUCK_A:buck_A {

Drop labels.


Best regards,
Krzysztof

