Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26986943D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBMLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:06:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5683C8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:05:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o15so8438813wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbDZOcLqh+VMgiuNCtX047PoGc8j7PM/gvuvb2t7vYk=;
        b=NyH8KyN30mjlmh1sTDa5TBxcOc1l8XauQzNC+tfoxmtNnYrouddF5xggUHW9/4s5Ns
         a8LLjJvNEdfsESCKHoZn6A871Tr30QBAg2VBBOF66NP+Wk7CVmJIkZ7P/sSY9ac/X9r0
         bFiYUrge2ABnWjcOuxiJxvTBnDSDex/b3zC2qf1dcDX8kXYUa0ERdExTSaFnb6FIcwer
         ByrqrGw2Ku5onRUHufKyjl8XqcKBxVXrVZ5EvRCnfWvY/Sq+JM3cQ3EP8VnQ+m5rvjp5
         DagiPN27ZXaqtNilerFTgZ2f/q/U5ma6sGgFCCpTF4mTkLxTSx/gG+cgY9Nst5f4CmIJ
         54mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbDZOcLqh+VMgiuNCtX047PoGc8j7PM/gvuvb2t7vYk=;
        b=2E0IR4ZdTiUPkUnJO4CpsHD9A/sk8t3Rg9SP3dp7Srs8EZh1C22dDwkeRTCU6mFP/V
         50dwDR7Fx2plB25RjtmPQlmwZS1eh9pYGrzsaRo47v0hacnroJQwtkJBwh+4HCgvJ3X/
         m61OeO5fwtEu/xr5O67yYTWKSYHAZqdDNFie2Zs164SFIkKEVekiBIyDaq1AaeMrzrJr
         HVcGRY0YulE6u/uwRiJ/6sOFiR+WPaFjfljhrpNkdiVnExmAq9z3GnZHIz0dDU7JTYGQ
         QL/UEcEIaVf6Ld3zcAOcQKEzoM9CAmo/IDe+rDCbF8lNP7CLj0Rx4ni8Z4+cmnJq53CC
         59yw==
X-Gm-Message-State: AO0yUKWuGn867Ee3GwZ4SUqgdZXpV0hDfOV4s2ltehVTS72T5CE8Jdo4
        DUIaRmaa5mfgRFWbTaYPbUmSmg==
X-Google-Smtp-Source: AK7set8LSk55cs2FZOOdiV621x9kPTKaVcA9dPhuENnAS1ySB7YnwYlPsfzbHocOD+xXf3fHyRTbQQ==
X-Received: by 2002:a05:6000:543:b0:2c5:58b9:d76e with SMTP id b3-20020a056000054300b002c558b9d76emr2175086wrf.40.1676286357524;
        Mon, 13 Feb 2023 03:05:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003daf7721bb3sm17959752wms.12.2023.02.13.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:05:57 -0800 (PST)
Message-ID: <3dfe44a1-2a80-7344-e6a5-31ea59438dec@linaro.org>
Date:   Mon, 13 Feb 2023 12:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] dt-bindings: soc: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-5-c4fe9049def9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-5-c4fe9049def9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:41, Neil Armstrong wrote:
> Convert the Amlogic Always-On Clock Controller bindings to dt-schema.

Subject prefix: clock, not soc

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 -----------
>  .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 120 +++++++++++++++++++++
>  2 files changed, 120 insertions(+), 64 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> deleted file mode 100644
> index c41f0be5d438..000000000000
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -* Amlogic GXBB AO Clock and Reset Unit
> -
> -The Amlogic GXBB AO clock controller generates and supplies clock to various
> -controllers within the Always-On part of the SoC.
> -
> -Required Properties:
> -
> -- compatible: value should be different for each SoC family as :
> -	- GXBB (S905) : "amlogic,meson-gxbb-aoclkc"
> -	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
> -	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
> -	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
> -	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
> -	followed by the common "amlogic,meson-gx-aoclkc"
> -- clocks: list of clock phandle, one for each entry clock-names.
> -- clock-names: should contain the following:
> -  * "xtal"     : the platform xtal
> -  * "mpeg-clk" : the main clock controller mother clock (aka clk81)
> -  * "ext-32k-0"  : external 32kHz reference #0 if any (optional)
> -  * "ext-32k-1"  : external 32kHz reference #1 if any (optional - gx only)
> -  * "ext-32k-2"  : external 32kHz reference #2 if any (optional - gx only)
> -
> -- #clock-cells: should be 1.
> -
> -Each clock is assigned an identifier and client nodes can use this identifier
> -to specify the clock which they consume. All available clocks are defined as
> -preprocessor macros in the dt-bindings/clock/gxbb-aoclkc.h header and can be
> -used in device tree sources.
> -
> -- #reset-cells: should be 1.
> -
> -Each reset is assigned an identifier and client nodes can use this identifier
> -to specify the reset which they consume. All available resets are defined as
> -preprocessor macros in the dt-bindings/reset/gxbb-aoclkc.h header and can be
> -used in device tree sources.
> -
> -Parent node should have the following properties :
> -- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
> -- reg: base address and size of the AO system control register space.
> -
> -Example: AO Clock controller node:
> -
> -ao_sysctrl: sys-ctrl@0 {
> -	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> -	reg =  <0x0 0x0 0x0 0x100>;
> -
> -	clkc_AO: clock-controller {
> -		compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		clocks = <&xtal>, <&clkc CLKID_CLK81>;
> -		clock-names = "xtal", "mpeg-clk";
> -	};
> -
> -Example: UART controller node that consumes the clock and reset generated
> -  by the clock controller:
> -
> -	uart_AO: serial@4c0 {
> -		compatible = "amlogic,meson-uart";
> -		reg = <0x4c0 0x14>;
> -		interrupts = <0 90 1>;
> -		clocks = <&clkc_AO CLKID_AO_UART1>;
> -		resets = <&clkc_AO RESET_AO_UART1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
> new file mode 100644
> index 000000000000..3ac432a112ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,gxbb-aoclkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Always-On Clock Controller
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,meson-gxbb-aoclkc
> +              - amlogic,meson-gxl-aoclkc
> +              - amlogic,meson-gxm-aoclkc
> +              - amlogic,meson-axg-aoclkc
> +          - const: amlogic,meson-gx-aoclkc
> +      - items:

Drop this "items"

> +          - enum:
> +              - amlogic,meson-axg-aoclkc

This does not look correct. Either this is standalone compatible or
followed with a fallback.

> +              - amlogic,meson-g12a-aoclkc
> +
> +  clocks:
> +    minItems: 2

maxItems instead... or you wanted to define constraints? Then you need
min and maxItems.


> +
> +  clock-names:
> +    minItems: 2

ditto

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gxbb-clkc

This won't work. Test it... It's not even documented.

> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 5
> +
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: xtal 
> +            - const: mpeg-clk
> +            - const: ext-32k-0
> +            - const: ext-32k-1
> +            - const: ext-32k-2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-g12a-aoclkc
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 3
> +
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: xtal 
> +            - const: mpeg-clk
> +            - const: ext-32k-0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gxl-clkc

Another set of undocumented compatibles. There is no way this binding is
doing what it is supposed to do.


> +            - amlogic,meson-gxm-clkc
> +            - amlogic,meson-axg-clkc
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: xtal 
> +            - const: mpeg-clk
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysctrl: system-controller@0 {
> +        compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
> +        reg = <0 0x100>;

Drop parent node.

> + 
> +        clkc: clock-controller {
> +            compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +            clocks = <&xtal>, <&clk81>;
> +            clock-names = "xtal", "mpeg-clk";
> +        };
> +    };
> 

Best regards,
Krzysztof

