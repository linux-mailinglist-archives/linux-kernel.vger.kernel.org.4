Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A2701937
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjEMScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEMScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:32:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43081FDE
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:32:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso19798864a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684002726; x=1686594726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6owmun2vUtEZB5TOq0wkGp9DGK60/+9Z1ayq9n03Xc=;
        b=hhHHv5WrwPvBhaZFdIPSYJ+Jmoii6SjBu9RgdknR/t3A9a/M7OrKPvapzvZsQZGO2y
         Gy92hotVu5kusAnWhXWRQyMG97KTjoAl/VB6nG5qejmgRTAxWP6LDUhkYsxDsg2D1OoE
         xGg462JkwPlJ0tUXplsWebMSfPDXRO2itFBc7//5hSmhXKVwUBe5RbPRdWDbJmnal4OJ
         PdSrNmefKHCD9C1K+/GQPai9nqJZthC6jjeaO5TQZj4MSSM2rb2oGn/SbiI07L406HJz
         fehwp3yivQ1NCF2rR0GkoPq0M6F+tJR9UoCuOAORXfCcr+WrA/lCEHZ+86tge2DTdh3E
         dg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684002726; x=1686594726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6owmun2vUtEZB5TOq0wkGp9DGK60/+9Z1ayq9n03Xc=;
        b=ORr7FiUmEKnX6E+MnC+tXZi/+2ZsEea8xImvbtLwU7kFw9NU+wmrYmW6swhE4K9ZI9
         HEN5vcRQySU46SuFdUSISBWLwg0JAfjHI0zgkatkmYqbTHdhxVzZCr4Ovt6OMQd1vsGB
         bOKCqdLhhAi967xUGoXuha0bwnCS4pN/u3UT1Pt1cMSSng0HEa8RvYpXUaPot/wZ6e/e
         V4oYS2UOJfXWp5uh1KRSRS/xyAnfTAJbVeKTZP6qhomonoLWj2+mSNuvYP3mga04iqPT
         0BmFEE758zhCMX2XMX250PEf4um14cG7NmS8MGjShRnGDUkMvFC48pOO7LqlSqMhdVUB
         Lg/g==
X-Gm-Message-State: AC+VfDwiYooNjNKEbhEvpK9BrlexWecIacTo6Bs2A7xGyn7nTH03XIBK
        JLtOVU8xKTAnwdd1URfc4d3acw==
X-Google-Smtp-Source: ACHHUZ6/MJmpQfYL6g1FK30ruhqexm9LOEc7dgLzIBfHIjDo/z+aM8STzBTfNpMl4RM6pAkC6SjPjg==
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id nd12-20020a170907628c00b0094f2a134e01mr26298987ejc.74.1684002726245;
        Sat, 13 May 2023 11:32:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id ml17-20020a170906cc1100b009661484e84esm7099003ejb.191.2023.05.13.11.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:32:05 -0700 (PDT)
Message-ID: <fe2f22c7-8c39-faf3-bc65-a7c089200134@linaro.org>
Date:   Sat, 13 May 2023 20:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/13] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 15:11, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI Glue
> on the same Amlogic SoCs.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../display/amlogic,meson-g12a-dw-mipi-dsi.yaml    | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..8169c7e93ff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mipi-dsi.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/amlogic,meson-g12a-dw-mipi-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic specific extensions to the Synopsys Designware MIPI DSI Host Controller
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |
> +  The Amlogic Meson Synopsys Designware Integration is composed of
> +  - A Synopsys DesignWare MIPI DSI Host Controller IP
> +  - A TOP control block controlling the Clocks & Resets of the IP
> +
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-g12a-dw-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

Missing maxItems

> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: pclk
> +      - const: bit_clk
> +      - const: px_clk
> +      - const: meas_clk

Drop _clk suffixes. pclk can stay, it's a bit odd but recently Rob
clarified that suffix with underscore should not be there.

> +
> +  resets:
> +    minItems: 1

maxItems instead

> +
> +  reset-names:
> +    items:
> +      - const: top
> +
> +  phys:
> +    minItems: 1

Ditto

> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input node to receive pixel data.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DSI output node to panel.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dsi@7000 {
> +          compatible = "amlogic,meson-g12a-dw-mipi-dsi";
> +          reg = <0x6000 0x400>;

Your reg does not match unit address. The dt_binding_check should
actually complain about it.

Best regards,
Krzysztof

