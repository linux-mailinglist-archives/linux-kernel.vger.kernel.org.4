Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9E6DAABC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjDGJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7372BC;
        Fri,  7 Apr 2023 02:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB3360F1B;
        Fri,  7 Apr 2023 09:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D83C433EF;
        Fri,  7 Apr 2023 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680858988;
        bh=GzznED6tySsGDwb5au4VoNSJsg0rXZvn+Uxk9Vxo2kU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=KWOJ/imF23ImDcT3NALRq2ogyUAq2NfiEPKOqIgypHGLoX3M9n81SkRvTPzgEV5sW
         g9XAB6PLfYQIoi5sBynmsX7GH/Zp8ZWOQ1s0V2bjSO4rsq2ou/cxBBm1RrUdz0k3V2
         WqC0BezqIJI0dMDX8yeqWuoCKtoVs3pLghYyCrrWgdAYzVwpMPJQwe53saAICmHxq3
         Q4Q/FuiWn2DIVx1T+A0hanF6c/IzEnVx+tlQpIecu6FVG7f1Cr9etwpZnEdGZt9pu0
         HngDF0bFYIExmCOpaSKah141DT8pYH7GMpYECE0q61YY0AnUfd3TBhakdPSNeSXqgR
         yixqrKXyej9uQ==
Message-ID: <083041fc-d8e9-d5c5-adc1-d6095db22fd7@kernel.org>
Date:   Fri, 7 Apr 2023 11:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: input: cirrus,cs40l26: Add bindings
Content-Language: en-US
To:     Fred Treven <fred.treven@cirrus.com>, ben.bright@cirrus.com,
        james.ogletree@cirrus.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzystztof.kozlowski+dt@linaro.org,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Add devicetree bindings for CS40L26 driver>
 <1680819613-29256-1-git-send-email-fred.treven@cirrus.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1680819613-29256-1-git-send-email-fred.treven@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 00:20, Fred Treven wrote:
> Add devicetree bindings for CS40L26 driver.

I appreciate the try to write my name manually, but there is no need to
struggle. :) You will just make a mistake.

Just copy-paste or use scripts/get_maintainers.pl.
You can automate everything with something like:
https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91

> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---
>  .../devicetree/bindings/input/cs40l26.yaml         | 92 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cs40l26.yaml

Filename matching compatible, so you need vendor-prefix.

> 
> diff --git a/Documentation/devicetree/bindings/input/cs40l26.yaml b/Documentation/devicetree/bindings/input/cs40l26.yaml
> new file mode 100644
> index 000000000000..1036a374baa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cs40l26.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cs40l26.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS40L26 Boosted Haptic Amplifier
> +
> +maintainers:
> +  - Fred Treven <fred.treven@cirrus.com>
> +
> +description:
> +  CS40L26 is a Boosted Haptic Driver with Integrated DSP and Waveform Memory
> +  with Advanced Closed Loop Algorithms and LRA protection
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs40l26a
> +      - cirrus,cs40l26b
> +      - cirrus,cs40l27a
> +      - cirrus,cs40l27b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Property describing the interrupt line the devices /ALERT pin is connected to.
> +      The device only has one interrupt source.

Drop description - it is almost useless. You could just mention ALERT pin.

> +
> +  VA-supply:
> +    description: Regulator for VA analog voltage
> +
> +  VP-supply:
> +    description: Regulator for VP peak voltage
> +
> +  cirrus,bst-ipk-microamp:
> +    description:
> +      Maximum amount of current that can be drawn by the device's boost
> +      converter in uA. Accepted values are between 1600000 uA and 4800000 uA in
> +      50000 uA increments.
> +    minimum: 1600000
> +    maximum: 4800000
> +    default: 4500000

Isn't this property of regulator? Why do you need it here?

> +
> +  cirrus,bst-ctl-microvolt:
> +    description:
> +      Maximum target voltage to which the class H algorithm may increase the
> +      VBST supply, expressed in uV. Valid values range from 2550000 to 11000000
> +      (inclusive) in steps of 50000. If this value is specified as zero or VP
> +      rises above this value, VBST is bypassed to VP. If this value is omitted,
> +      the maximum target voltage remains at 11 V.

Don't repeat constraints in free form text - drop last sentence.

> +    minimum: 2550000
> +    maximum: 11000000
> +    default: 11000000
> +
> +  cirrus,bst-exploratory-mode-disable:
> +    description:
> +      Disable boost exploratory mode if this boolean is present in the
> +      devicetree. 

Don't explain how DT works. Explain how hardware works instead.

> Boost exploratory mode allows the device to overshoot
> +      the set peak current limit. This has potential to damage the boost
> +      inductor. Disabling this mode will prevent this from happening; it will
> +      also prevent the device from detecting boost inductor short errors.
> +      (Default) Enabled

Why this is suitable for DT? Why would anyone need to disable it per board?

> +    type: boolean
> +
> +

Just one blank line.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      cs40l26: cs40l26@58 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "cirrus,cs40l26a";
> +        reg = <0x58>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <57 8>;

If 8 is interrupt flag, use appropriate define.

> +        reset-gpios = <&gpio0 54 0>;

Same for GPIO flag.

> +        VA-supply = <&dummy_vreg>;
> +        VP-supply = <&dummy_vreg>;
> +        cirrus,bst-ctl-microvolt = <2600000>; // Max boost voltage = 2.6V
> +        cirrus,bst-ipk-microamp = <1650000>; // Max boost current = 1.65A
> +        cirrus,bst-exploratory-mode-disabled; // Disable exploratory mode

The comments are not useful - they copy the property. Instead you could
explain WHY. Or just drop the comments.

>  

Best regards,
Krzysztof

