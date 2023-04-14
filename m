Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D56E2B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDNVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDNVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:08:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F949F3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:08:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a356c7419so451923666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681506486; x=1684098486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hy2SHbI2lqj5Bp3ZPYgjYD8oE60t27/oFxktc6fpZbI=;
        b=dnqGaZ8B9oXTFuifP0wk6iUbtXyERtqOhliVUYa5wckjCSPJkNC9U7XX4kcmSa7bc5
         Ccr/MSJ9XbtMhceJhyIl3ieDrCrfSVMIOHZaxKP1/ya4meZ3ldxfEfasRAijK3GQgMww
         Sh+pmn/4PCxJEmzb4m2FGQBoD7YkXB3hJvTFNuhC7lpPCLbj5oRcvCTjwY1deu21I6gJ
         xV1zyH9+3s7JyH/QUyh6ibo3T7DsJaP6eBaOd47pIyTuUu6T50DutzxTZULtgC0mNH/+
         zOKWAt/ATU39PPNai3+mUflQ3/xvHWBVa+qo8SjSjkucT83P4Ng2YF3HJ2dWncoyGbNn
         4fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506486; x=1684098486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy2SHbI2lqj5Bp3ZPYgjYD8oE60t27/oFxktc6fpZbI=;
        b=SYfbN5KNEEh2kJ+WQujFtbYLFD7cKJ9DzdYAd916YQkMlTu/gyhxEM+IKq2JqVXmWm
         ILM0FFye1ntRXdc69hZi3wCDkDXULPKuKtUVevvFCz93+nfpP8fEA5chyWGw78DK9SmO
         FWg+mkukyjuo6YVsTROsrlho09/EfEIaH/qdgPV7xDOvktCCc8N6ezcrKTxVOAKsfL9X
         DpG8ut37Ma5apCLG1pBRYyOhhoBo83pczeRyBVqKJPCNd33hzk0nGH17qkaQuIlEjTUp
         GG4YlenmAksZaOFh3Q/gLZo52yJslwKf36zTJJVFrUYW5yvwF6c8Q+6YVnBo9uf7jVyn
         xlag==
X-Gm-Message-State: AAQBX9dD02fVTBqwaZEhodtUqknXa/1cQVjsXayTCYr4mz4x+E5fWs+w
        ezGJcM+Y8YE+Fqx0Tgz2jlSowg==
X-Google-Smtp-Source: AKy350Yi3LtwsUpEg00id3W9FUSjh+9nXNEH8GoJJSgGVr18nTCmXKwr4Rn8T7Bv28uuxo6Bpyucag==
X-Received: by 2002:a05:6402:215:b0:506:905b:816d with SMTP id t21-20020a056402021500b00506905b816dmr80507edv.6.1681506485749;
        Fri, 14 Apr 2023 14:08:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id o4-20020a509b04000000b00504d04c939fsm2605223edi.59.2023.04.14.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 14:08:03 -0700 (PDT)
Message-ID: <c1f32d73-a311-6d70-0be6-12bdb50a052f@linaro.org>
Date:   Fri, 14 Apr 2023 23:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414181302.986271-1-mmyangfl@gmail.com>
 <20230414181302.986271-2-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414181302.986271-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 20:12, David Yang wrote:
> Add DT bindings documentation for reg-clock-controller, collection of
> basic clocks common to many platforms.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> new file mode 100644
> index 000000000000..a6a7e0b05821
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> @@ -0,0 +1,245 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple straight-forward register-based clocks
> +
> +maintainers:
> +  - David Yang <mmyangfl@gmail.com>
> +
> +description: |
> +  Basic clocks common to many platforms.
> +
> +  If your clocks don't fit into these catagories, simply create your clock

typo: categories

> +  controller. This driver normally work well with other controllers as long as
> +  they operate on different registers.
> +
> +  See linux/clk-provider.h for details about properties for each type of clock.

Describe here what is this device, what such simple clock controller
represents.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - reg-clock-controller
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'

required goes after patternProperties.

> +
> +patternProperties:
> +  ".*gate-clock@.*":

"gate-clock@" should be equivalent. However this should be just "clock".

> +    type: object
> +
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Clock which can gate its output.
> +
> +    properties:
> +      compatible:
> +        const: gate-clock
> +
> +      reg:
> +        maxItems: 1
> +
> +      '#clock-cells':
> +        const: 0
> +
> +      clocks:
> +        maxItems: 1
> +        description:
> +          Parent clock.
> +
> +      clock-output-name:

names

Don't create your own properties.

> +        maxItems: 1
> +
> +      bit-index:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Bit index which controls the output.

I suggest to use same property as nvme, so bits.

> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#clock-cells'
> +      - bit-index
> +
> +    additionalProperties: false
> +
> +  ".*divider-clock@.*":
> +    type: object
> +
> +    description: |
> +      Clock with an adjustable divider affecting its output frequency.
> +
> +    properties:
> +      compatible:
> +        const: divider-clock
> +
> +      reg:
> +        maxItems: 1
> +
> +      '#clock-cells':
> +        const: 0
> +
> +      clocks:
> +        description:
> +          Parent clocks.
> +
> +      clock-output-name:
> +        maxItems: 1
> +
> +      shift:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Shift to the divider bit field.
> +
> +      width:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Width of the divider bit field.
> +
> +      dividers:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          Array of value/divider pairs.

Then it looks like matrix.

> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#clock-cells'
> +      - shift
> +      - width
> +
> +    additionalProperties: false
> +
> +  ".*mux-clock@.*":
> +    type: object
> +
> +    description: |
> +      Clock with multiple selectable parents.
> +
> +    properties:
> +      compatible:
> +        const: mux-clock
> +
> +      reg:
> +        maxItems: 1
> +
> +      '#clock-cells':
> +        const: 0
> +
> +      clocks:
> +        minItems: 1
> +        description:
> +          Parent clock.
> +
> +      clock-output-name:
> +        maxItems: 1
> +
> +      shift:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Shift to multiplexer bit field.
> +
> +      mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Mask of mutliplexer bit field.
> +
> +      table:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          Array of register values corresponding to the parent index.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#clock-cells'
> +      - shift
> +      - mask
> +
> +    additionalProperties: false
> +
> +  ".*fractional-divider-clock@.*":
> +    type: object
> +
> +    description: |
> +      Clock with adjustable fractional divider affecting its output frequency.
> +
> +    properties:
> +      compatible:
> +        const: fractional_divider-clock
> +
> +      reg:
> +        maxItems: 1
> +
> +      '#clock-cells':
> +        const: 0
> +
> +      clocks:
> +        maxItems: 1
> +        description:
> +          Parent clock.
> +
> +      clock-output-name:
> +        maxItems: 1
> +
> +      numerator-shift:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Shift to the numerator bit field.
> +
> +      numerator-width:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Width of the numerator bit field.
> +
> +      denominator-shift:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Shift to the denominator bit field.
> +
> +      denominator-width:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Width of the denominator bit field.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#clock-cells'
> +      - numerator-shift
> +      - numerator-width
> +      - denominator-shift
> +      - denominator-width
> +
> +    additionalProperties: false
> +
> +additionalProperties: true

No, come on. This must be false.

> +
> +examples:
> +  - |
> +    clks: reg-clk-ctrl@ffff0000 {

Names should be generic, so clock-controller

Drop the label.

> +      compatible = "reg-clock-controller";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0xffff0000 0x1000>;
> +
> +      my_clk: gate-clock@cc-3 {

Drop label.

That's a new unit address to me. Did I miss a change in DT spec?

> +        compatible = "gate-clock";
> +        #clock-cells = <0>;
> +        reg = <0xcc 4>;

reg is after compatible.

> +        bit-index = <3>;
> +        clock-output-name = "my-clk";

Plus, test your patches. This fails testing...

> +      };
> +    };

Best regards,
Krzysztof

