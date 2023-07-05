Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E796D748E79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjGET4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjGET4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:56:39 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F619A3;
        Wed,  5 Jul 2023 12:56:35 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-783544a1c90so354107839f.1;
        Wed, 05 Jul 2023 12:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586995; x=1691178995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPt3Am55EIPQwjaZUFo2OjC5UfPdXakQamq9kZV1DYQ=;
        b=MeFYnf+WDTVRqFcN8/Uj3c+G5CCcYtrcFvPYK04AgS/+tv9NbkcXexNCJmS/A0cI67
         GMg3XpLBszOcac+Yl34alDY9Esefad3jhk9b2Ikc2XXDTZa5zTm/fOw/ZkIt4iHgz11s
         AOSvqizjd+Bow7ial/pfPmv6UqBYmrQczn/kZLr5HmHX6v9qBCVP5K5um4MJRLq3ijnp
         M0GguYqH5BdyUFOdapYyH2idnDFLBteC+rjRmNy/kinO7eVhSe8g1pQBCr/UAm7w5zJe
         ReXhHL4poQsy5/7R9KeLOgi6FUfBxw7zjlWySRTJY3zwlYUquAod+QsMkJ+UvJM1sVY5
         UFPQ==
X-Gm-Message-State: ABy/qLZ8qVIykdVKTDgXnXe7j3/SZYi+zDuPiw3rK+LCx/R9h88Ab79u
        4MzRancln9mJI2HnonozSFv6KW9r8A==
X-Google-Smtp-Source: APBJJlHnNkXGWBvky8XFChw7oHy0bgp6ROaCctZYW1YAOfFB4F4irzCZhnVtBvrPuCl5xHlrMAHEkg==
X-Received: by 2002:a05:6602:2285:b0:786:7f3a:fb06 with SMTP id d5-20020a056602228500b007867f3afb06mr183361iod.3.1688586994825;
        Wed, 05 Jul 2023 12:56:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o4-20020a02c6a4000000b0042b426e353dsm2458216jan.127.2023.07.05.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:56:34 -0700 (PDT)
Received: (nullmailer pid 1737132 invoked by uid 1000);
        Wed, 05 Jul 2023 19:56:31 -0000
Date:   Wed, 5 Jul 2023 13:56:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-aoclkc.txt to dt-schema
Message-ID: <20230705195631.GA1732680-robh@kernel.org>
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
 <20230705-b4-amlogic-bindings-convert-take2-v2-2-22be915ddc3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-b4-amlogic-bindings-convert-take2-v2-2-22be915ddc3b@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:41:52PM +0200, Neil Armstrong wrote:
> Convert the Amlogic Always-On Clock Controller bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 -------------
>  .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 101 +++++++++++++++++++++
>  2 files changed, 101 insertions(+), 64 deletions(-)
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
> index 000000000000..0adcfbcf5c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
> @@ -0,0 +1,101 @@
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
> +      - enum:
> +          - amlogic,meson-axg-aoclkc
> +          - amlogic,meson-g12a-aoclkc
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 5
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 5
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
> +            - amlogic,meson-gxbb-aoclkc
> +
> +    then:
> +      properties:
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: xtal 
> +            - const: mpeg-clk
> +            - const: ext-32k-0
> +            - const: ext-32k-1
> +            - const: ext-32k-2

As the names are always the same, move this to top-level and just set 
the length here (except the constraints are the same as top-level, so 
you can just drop this if/then).

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
> +          maxItems: 3
> +
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: xtal 
> +            - const: mpeg-clk
> +            - const: ext-32k-0

Just 'maxItems: 3'

> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gxl-aoclkc
> +            - amlogic,meson-gxm-aoclkc
> +            - amlogic,meson-axg-aoclkc
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

maxItems: 2

> +
> +additionalProperties: false
> 
> -- 
> 2.34.1
> 
