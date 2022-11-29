Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECD63C1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiK2OA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiK2OAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:00:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB0429B2;
        Tue, 29 Nov 2022 06:00:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACAF61FDEC;
        Tue, 29 Nov 2022 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669730452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpKLT89bAqIFw7A8vMPMGL+OzHZcolGvYqS8fV4b+J4=;
        b=Hb0yxkfQ7isRJHgS2FEn9/Yb3GKtqRiVg3rnfSQyAOWWARn1N9zCOJlV+cmpWzycmIxig0
        ZgRLvEKG/xTlBEroL9hX7r5/5JsNB1TNYmfEw34k8aa60Ke8XFQrWNBdhHpG5mLUuAcNF1
        e4DqfsxulmgtzWAWCeaHD75J9ZQPFUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669730452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpKLT89bAqIFw7A8vMPMGL+OzHZcolGvYqS8fV4b+J4=;
        b=3zKSd089fZWXd7pXvDLVQm810JBo3TM1kCmyCqZ9tQYE6tKq5RLAKRqYjgmi7fVYLJhGzg
        wC2igzMNZVs4LrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91DDD13428;
        Tue, 29 Nov 2022 14:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id huEtI5QQhmOOQgAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 29 Nov 2022 14:00:52 +0000
Message-ID: <6d328461-d705-9e82-ccf3-dec8885f17fe@suse.de>
Date:   Tue, 29 Nov 2022 15:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Content-Language: en-US
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
In-Reply-To: <20221128054820.1771-2-clin@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

Am 28.11.22 um 06:48 schrieb Chester Lin:
> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> 
> Changes in v2:
> - Remove the "nxp,pins" property since it has been moved into the driver.
> - Add descriptions for reg entries.
> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".

Thanks.

> - Fix schema issues and revise the example.
> - Fix the copyright format suggested by NXP.
> 
>   .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
>   1 file changed, 125 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> new file mode 100644
> index 000000000000..2fc25a9362af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Any reason the code is GPL-2.0-or-later but the schema is GPL-2.0-only?

> +# Copyright 2022 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nxp,s32cc-siul2-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32 Common Chassis SIUL2 iomux controller
> +
> +maintainers:
> +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> +  - Chester Lin <clin@suse.com>
> +
> +description: |
> +  Core driver for the pin controller found on S32 Common Chassis SoC.

SoC family

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,s32g2-siul2-pinctrl
> +
> +  reg:
> +    description:
> +      A list of MSCR/IMCR register regions to be reserved.
> +      - MSCR (Multiplexed Signal Configuration Register)
> +        An MSCR register can configure the associated pin as either a GPIO pin
> +        or a function output pin depends on the selected signal source.
> +      - IMCR (Input Multiplexed Signal Configuration Register)
> +        An IMCR register can configure the associated pin as function input
> +        pin depends on the selected signal source.

Does this multi-paragraph text not need "description: |" like above?

> +    minItems: 5
> +    items:
> +      - description: MSCR registers group 0 managed by the SIUL2 controller 0
> +      - description: MSCR registers group 1 managed by the SIUL2 controller 1
> +      - description: MSCR registers group 2 managed by the SIUL2 controller 1
> +      - description: IMCR registers group 0 managed by the SIUL2 controller 0
> +      - description: IMCR registers group 1 managed by the SIUL2 controller 1
> +      - description: IMCR registers group 2 managed by the SIUL2 controller 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      '-grp[0-9]$':
> +        type: object
> +        allOf:
> +          - $ref: pinmux-node.yaml#
> +          - $ref: pincfg-node.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Pinctrl node's client devices specify pin muxes using subnodes,
> +          which in turn use the standard properties.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    /* Pins functions (SSS field) */
> +    #define FUNC0  0
> +    #define FUNC1  1
> +    #define FUNC2  2
> +    #define FUNC3  3
> +    #define FUNC4  4
> +    #define FUNC5  5
> +    #define FUNC6  6
> +    #define FUNC7  7
> +
> +    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
> +
> +    #define S32CC_SLEW_208MHZ  0
> +    #define S32CC_SLEW_166MHZ  4
> +    #define S32CC_SLEW_150MHZ  5
> +    #define S32CC_SLEW_133MHZ  6
> +    #define S32CC_SLEW_83MHZ   7

I notice that neither this patch nor the following one introduces a 
dt-bindings header for these macros? Is the plan to only have them in 
TF-A sources? Thinking of DT overlays for SoMs, for example.

Regards,
Andreas

> +
> +    pinctrl@4009c240 {
> +        compatible = "nxp,s32g2-siul2-pinctrl";
> +
> +        /*
> +         * There are two SIUL2 controllers in S32G2:
> +         *
> +         *   siul2_0 @ 0x4009c000
> +         *   siul2_1 @ 0x44010000
> +         *
> +         * Every SIUL2 controller has multiple register types, and here
> +         * only MSCR and IMCR registers need to be revealed for kernel
> +         * to configure pinmux. Please note that some indexes are reserved,
> +         * such as MSCR102-MSCR111 in the following reg property.
> +         */
> +
> +              /* MSCR0-MSCR101 registers on siul2_0 */
> +        reg = <0x4009c240 0x198>,
> +              /* MSCR112-MSCR122 registers on siul2_1 */
> +              <0x44010400 0x2c>,
> +              /* MSCR144-MSCR190 registers on siul2_1 */
> +              <0x44010480 0xbc>,
> +              /* IMCR0-IMCR83 registers on siul2_0 */
> +              <0x4009ca40 0x150>,
> +              /* IMCR119-IMCR397 registers on siul2_1 */
> +              <0x44010c1c 0x45c>,
> +              /* IMCR430-IMCR495 registers on siul2_1 */
> +              <0x440110f8 0x108>;
> +
> +        llce-can0-pins {
> +            llce-can0-grp0 {
> +                pinmux = <S32CC_PINMUX(43, FUNC0)>;
> +                input-enable;
> +                slew-rate = <S32CC_SLEW_208MHZ>;
> +            };
> +
> +            llce-can0-grp1 {
> +                pinmux = <S32CC_PINMUX(44, FUNC2)>;
> +                output-enable;
> +                slew-rate = <S32CC_SLEW_208MHZ>;
> +            };
> +        };
> +    };
> +...

-- 
SUSE Software Solutions Germany GmbH
Frankenstraße 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nürnberg)
