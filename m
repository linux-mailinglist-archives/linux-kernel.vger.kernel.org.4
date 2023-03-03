Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E16A92AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCCIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCCIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:35:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA615165
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:34:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d30so7302933eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677832490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDoB5UWMvvhNqF0wgTmnzNlgB1BlgJyJ3cSmjAuYaOI=;
        b=yK6n2n20iufKpSsuEliT1MWEFiyS4gR75wIU7EYtqqQ6NbJ5y7lsIeP587ADjvoQlr
         YOWmPUEJ8EpXrNsbGAUBQ42Jh+k2JR+dDzmX/enB7j1L0YYmZVuqFiu2jTrCI9dgEn+b
         EFB3qrcHu+4iZ2yci9sgJ7GFbf96kAv/JBvI1O4e1SeMgu95QM8l7LWNddRNX5wUwh5U
         rlEuIYxrFZQOd1demti85V7JshcjkNrk6+I8xsGiAIQp+gInFiLloTdEbiJvV3hPoQUW
         adSXoFNmrjbLEmOtgmcP3tZMHP9TwT0+spth3ZjfUE/7hPWQmzLBs2A3iOeuDvafAdAS
         QKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDoB5UWMvvhNqF0wgTmnzNlgB1BlgJyJ3cSmjAuYaOI=;
        b=uPXlLpUDWPw63cjHhtz8ZQNWLAAzJpPJuvB7oldrETgE7ibBqa9qpE/wliJAuUMqe9
         12DnucUvYfkRf2QGmX03eXTUSN8ShQ3Ugr/c8b6s82SVCFnRRCrzVqDTYLUCZeXEG3/C
         2QIuOPobJX/uwB5PrGshbCTv30IzLy7RXedYyu3+7VnYk9hsTTyKt5NyuWytts3Hk5Nr
         WXnaVAaO9EromO0HtZQ8v7QtWj/uqAKMIgJ+ZS8SxMdvZheagsNDF4lsYS1R6Qcq4Mi+
         pw1JLsxFfICG5jIR6aD+gs5EReJbyW/uAm6HTBAly98g32f3udRJxxjbPWZBYc+MRhaB
         +MJQ==
X-Gm-Message-State: AO0yUKW46XJCujbv+t8xdH7slHdaWkqpRPd0qMeXzu04Lp315bPKB+Sa
        rgj+CI7qbYPPyaJrtxy4z7VOJQ==
X-Google-Smtp-Source: AK7set/VwnOv5s/WNv9aTbwy3eFyQZ1UobEdURnclq1E2VoZ9yPlgcAmzt3vyf8Dn28U350ydppQuA==
X-Received: by 2002:a17:906:a042:b0:8b1:7b54:a013 with SMTP id bg2-20020a170906a04200b008b17b54a013mr844962ejb.57.1677832489858;
        Fri, 03 Mar 2023 00:34:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k12-20020a50ce4c000000b004c0459c20f9sm856380edj.66.2023.03.03.00.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:34:49 -0800 (PST)
Message-ID: <10e4ac1e-5c4d-4d6d-53e6-fbc1142940f9@linaro.org>
Date:   Fri, 3 Mar 2023 09:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 01/11] media: dt-bindings: starfive,jh7110-camss: add
 binding document
Content-Language: en-US
To:     "jack.zhu" <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-2-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302091921.43309-2-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:19, jack.zhu wrote:
> Add DT binding document for Starfive Camera subsystem driver
> 
> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> new file mode 100644
> index 000000000000..9a34944ca0ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: Starfive SoC CAMSS ISP
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description: |

No need for '|'

> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC.It
> +  consists of a VIN controller(Video In Controller, a top-level control until)
> +  and a ISP.

"an ISP", I think

> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-camss
> +
> +  reg:
> +    minItems: 2

Drop minItems, no need.

> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: syscon
> +      - const: isp
> +
> +  clocks:
> +    minItems: 7

Drop mintems

> +    maxItems: 7
> +
> +  clock-names:
> +    items:
> +      - const: clk_apb_func
> +      - const: clk_wrapper_clk_c
> +      - const: clk_dvp_inv
> +      - const: clk_axiwr
> +      - const: clk_mipi_rx0_pxl
> +      - const: clk_ispcore_2x
> +      - const: clk_isp_axi

Drop "clk" prefix

> +
> +  resets:
> +    minItems: 6

Drop

> +    maxItems: 6
> +
> +  reset-names:
> +    items:
> +      - const: rst_wrapper_p

Drop rst prefix

> +      - const: rst_wrapper_c
> +      - const: rst_axird
> +      - const: rst_axiwr
> +      - const: rst_isp_top_n
> +      - const: rst_isp_top_axi
> +
> +  power-domains:
> +    items:
> +      - description: JH7110 PD ISP - ISP Power Domain Switch Controller.

Drop redundant pieces, e.g. "PD ISP"

> +
> +  interrupts:
> +    minItems: 4

Drop

> +    maxItems: 4
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@1:

And what about port@0?

> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint@1:

Hm, do you have more than one endpoint in this port? Why unit address?

> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    stfcamss: camss@19840000 {

isp@

> +        compatible = "starfive,jh7110-camss";
> +        reg = <0x19840000 0x10000>,
> +            <0x19870000 0x30000>;

All this looks misaligned
> +        reg-names = "syscon", "isp";
> +        clocks = <&ispcrg 0>,
> +            <&ispcrg 13>,

Looks even worse...

> +            <&ispcrg 2>,
> +            <&ispcrg 12>,
> +            <&ispcrg 1>,
> +            <&syscrg 51>,
> +            <&syscrg 52>;
> +        clock-names = "clk_apb_func",
> +            "clk_wrapper_clk_c",
> +            "clk_dvp_inv",
> +            "clk_axiwr",
> +            "clk_mipi_rx0_pxl",
> +            "clk_ispcore_2x",
> +            "clk_isp_axi";
> +        resets = <&ispcrg 0>,
> +            <&ispcrg 1>,
> +            <&ispcrg 10>,
> +            <&ispcrg 11>,
> +            <&syscrg 41>,
> +            <&syscrg 42>;
> +        reset-names = "rst_wrapper_p",
> +            "rst_wrapper_c",
> +            "rst_axird",
> +            "rst_axiwr",
> +            "rst_isp_top_n",
> +            "rst_isp_top_axi";
> +        power-domains = <&pwrc 5>;
> +        interrupts = <92>, <87>, <88>, <90>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@1 {
> +                reg = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                vin_from_csi2rx: endpoint@1 {
> +                    reg = <1>;
> +                    remote-endpoint = <&csi2rx_to_vin>;
> +                };
> +            };
> +        };
> +    };

Best regards,
Krzysztof

