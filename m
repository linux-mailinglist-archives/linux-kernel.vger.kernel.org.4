Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339F6A3E98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjB0Jvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB0Jve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:51:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641D1A4AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:51:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso3220670wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8f3b/AJc3LzeqUlp8tx5FLQrQ6kJ53BQotZpGY6oUTw=;
        b=Qyh6sTLng8kVOeauxk+iSgPEdYtGRn7CObtiOZX3pO4BqJQjdcBrwtgNeMaPzK9vfz
         L2w8jgdo0LuzMBL7BMkHbW9ISkn4SsPrrV+T5vuXGPPsBOu+Na5nV5OyxWHerbhLdQed
         Wmu8/q9qOjXPHyqI7dPNxYaWddz0Es71cuWt/l4J+q19BziFJnv54WjRwHafrsChoPio
         uMjbmH1sGN3aySzL8373Psj5iEuYmyAowSviURAVCfSb24dUHxolLqvgTJbG5XDiTnIY
         jzf7rzO+bqtI0opwBAjz5BUImbr8OOzK/MCmkOSy0BtKwHyVgG69dmCo4NZFG6PJJ91h
         wV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f3b/AJc3LzeqUlp8tx5FLQrQ6kJ53BQotZpGY6oUTw=;
        b=p5bVzx8JB9GF9PiMCLhBb0MTFKe3s/Zxv7NnHHVXOyQOUVk8TaxjUkcovRj4G2DA/E
         uu43XS8DRY5+oIfZgb28/XksSUkhH+ceIE45Hjmy1wEu3FflktgyjhZd5f4GmEI/uB0z
         cFTxc2b/hd6tsNyQGn+OsYdNNJotM75Gj6pCBXzB/qP4VwqGsy2Tee7HrkRKXVfvJHl5
         KJMYe8VHt2VXDpmX0JrWnnvAqkNntAZmiUoHF2xV+NaGB0B6bfHfJZbwf7Jerw2c1RGq
         cni5ctQRt5/pqDaTm2xdgb6E0XXcsBBgfVk49woFBHL/IgsVd5m3hLMEoT0AFt/I8XSW
         pobg==
X-Gm-Message-State: AO0yUKWwaKQlbVTvpvMVUV3j0P5Z+CXSPti7yECCBHjr3kMK7R0UMQjT
        PUXWK43dc4Mk4STrzMFgIPv3kg==
X-Google-Smtp-Source: AK7set+lB+9CX8kYjq8Nr0Uf6aXdBzUA9xHVP07iGtqDdOTBYqVZWoH9UYy+Kye0ri8cnTePQ6oTwg==
X-Received: by 2002:a05:600c:998:b0:3e2:20c7:6544 with SMTP id w24-20020a05600c099800b003e220c76544mr18413319wmp.19.1677491489869;
        Mon, 27 Feb 2023 01:51:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db06224953sm8696244wmb.41.2023.02.27.01.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:51:29 -0800 (PST)
Message-ID: <ef93fea2-e4db-7c28-b911-13b046352214@linaro.org>
Date:   Mon, 27 Feb 2023 10:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v5] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc@epcas5p2.samsung.com>
 <20230227084736.89361-1-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227084736.89361-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 09:47, Aakarsh Jain wrote:
> Convert s5p-mfc bindings to DT schema format using json-schema.
> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> changes since v4:
> Removed items from oneOf section
> dropped black line
> defined the iommus names items as
> items:
> -const left
> -const right
> 
> changes since v3:
> fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check for ARMv7
> Since, obsolete properties are not part of dt-node so we are not including these properties in dt-schema.
> 
> changes since v2:
> changed Commit message from Adds to Convert
> Removed text "This file has moved to samsung,s5p-mfc.yaml" from s5p-mfc.txt
> fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check
> 
> changes since v1:
> fixed dt-schema warnings and errors while running make dtbs_check and make dt_binding_check
> Removed description.
> Listed items.
> Added allOf:if:then for restricting two items to specific compatible
> 
> This patch is independent from the previous MFC v12 patch series for HW3 support.
> 
>  .../devicetree/bindings/media/s5p-mfc.txt     |  78 ---------
>  .../bindings/media/samsung,s5p-mfc.yaml       | 148 ++++++++++++++++++
>  2 files changed, 148 insertions(+), 78 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index 8eb90c043d5d..e69de29bb2d1 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -1,78 +0,0 @@
> -* Samsung Multi Format Codec (MFC)
> -
> -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> -supports high resolution decoding and encoding functionalities.
> -The MFC device driver is a v4l2 driver which can encode/decode
> -video raw/elementary streams and has support for all popular
> -video codecs.
> -
> -Required properties:
> -  - compatible : value should be either one among the following
> -	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
> -	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
> -	(c) "samsung,exynos3250-mfc", "samsung,mfc-v7" for MFC v7
> -	     present in Exynos3250 SoC
> -	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> -	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> -	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> -	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -	  mapped region.
> -
> -  - interrupts : MFC interrupt number to the CPU.
> -  - clocks : from common clock binding: handle to mfc clock.
> -  - clock-names : from common clock binding: must contain "mfc",
> -		  corresponding to entry in the clocks property.
> -
> -Optional properties:
> -  - power-domains : power-domain property defined with a phandle
> -			   to respective power domain.
> -  - memory-region : from reserved memory binding: phandles to two reserved
> -	memory regions, first is for "left" mfc memory bus interfaces,
> -	second if for the "right" mfc memory bus, used when no SYSMMU
> -	support is available; used only by MFC v5 present in Exynos4 SoCs
> -
> -Obsolete properties:
> -  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-region
> -	property instead
> -
> -
> -Example:
> -SoC specific DT entry:
> -
> -mfc: codec@13400000 {
> -	compatible = "samsung,mfc-v5";
> -	reg = <0x13400000 0x10000>;
> -	interrupts = <0 94 0>;
> -	power-domains = <&pd_mfc>;
> -	clocks = <&clock 273>;
> -	clock-names = "mfc";
> -};
> -
> -Reserved memory specific DT entry for given board (see reserved memory binding
> -for more information):
> -
> -reserved-memory {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -
> -	mfc_left: region@51000000 {
> -		compatible = "shared-dma-pool";
> -		no-map;
> -		reg = <0x51000000 0x800000>;
> -	};
> -
> -	mfc_right: region@43000000 {
> -		compatible = "shared-dma-pool";
> -		no-map;
> -		reg = <0x43000000 0x800000>;
> -	};
> -};
> -
> -Board specific DT entry:
> -
> -codec@13400000 {
> -	memory-region = <&mfc_left>, <&mfc_right>;
> -};
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index 000000000000..b4a289619db0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Multi Format Codec (MFC)
> +
> +maintainers:
> +  - Marek Szyprowski <m.szyprowski@samsung.com>
> +  - Aakarsh Jain <aakarsh.jain@samsung.com>
> +
> +description:
> +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> +  supports high resolution decoding and encoding functionalities.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - samsung,mfc-v5              # Exynos4
> +          - samsung,mfc-v6              # Exynos5
> +      - items:
> +          - enum:
> +              - samsung,exynos3250-mfc  # Exynos3250
> +          - const: samsung,mfc-v7       # Fall back for Exynos3250
> +      - enum:
> +          - samsung,mfc-v7              # Exynos5420
> +          - samsung,mfc-v8              # Exynos5800
> +          - samsung,exynos5433-mfc      # Exynos5433
> +          - samsung,mfc-v10             # Exynos7880

Why this and first enum are separate?  I didn't notice it before...
Usually we have only one enum for one-compatible variants. Also, sort
them by compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 2
> +
> +  iommu-names:
> +    items:
> +      - const: left
> +      - const: right
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  memory-region:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v5
> +              - samsung,exynos3250-mfc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: mfc
> +            - const: sclk_mfc
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v6
> +              - samsung,mfc-v8
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: mfc
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos5433-mfc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: aclk
> +            - const: aclk_xiu

What happened to iommus? You were requiring two items, but you dropped
that requirement. Is it on purpose?

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v7
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos4.h>
> +    #include <dt-bindings/clock/exynos-audss-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    codec@13400000 {
> +          compatible = "samsung,mfc-v5";

You sill have here odd indentation. Use 4 spaces for DTS example.

> +          reg = <0x13400000 0x10000>;
> +          interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +          power-domains = <&pd_mfc>;
> +          clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
> +          clock-names = "mfc", "sclk_mfc";
> +          iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> +          iommu-names = "left", "right";
> +    };

Best regards,
Krzysztof

