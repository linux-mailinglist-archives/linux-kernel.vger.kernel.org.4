Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F076A7CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCBIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCBIhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:37:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB761BACA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:37:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so64408199edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677746244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6talumXK2uMHhQXk9Ozx4A/KVBVKmEQwXmevjpT/aWQ=;
        b=daXv/RAD3pTBtQuSn3rWRwSy2KenXxp9z1jQ753estabbztN1I4TuHoAZeEZaYVuY8
         C/9+5nrsyx2tw+2MkshxUyuubpVpEZzNkHI9ezwjtKgQHOhtsAvjXqJa+3ajNufVQ5xP
         cGbLW2GUJS4kf0OduNznN1E6g0Qv+/rss/qUfGhINTLhecshxv8WUAvIM9bGRowlZZry
         gLRLxA3iiT+eLRKOv5q3p05llSF3pdeGK+z2wzNfTVAAHqDnS3ZMSBlERzB4PD4VPXj5
         BjN/3LCIu68KCa3JPsvaB6XTobrWVCAoz50/HMcemERK6AXzPt8ngZvq0cMgT1Itk8CK
         lrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6talumXK2uMHhQXk9Ozx4A/KVBVKmEQwXmevjpT/aWQ=;
        b=Fgc9MCkE7PsWZc696ObC6djRZEjRo/s5RDhCIE1b5sQJXhmA6qaLGdHvCkcSd/h8j1
         tmIiNYRpW6BevDnQF9VvJZVOn8k9AxCcaUYKgo9lsdfO3BpnGa3ye/io4N7K6lBDHJI0
         6LRxKZhJNbIrFa4+Ksi4lFJ0vAyzxRAg/1ugFfsSwKY0D1TkkqFPcmTLorIYTSAUi5PV
         KajlTDCb5X9yIrfxole5rK1TUpQtkCPZpdjvIcZQbWbd7TUQCO6m39ZoCGdN+dh6s6ZD
         lIQV/sJSAvrDqP6rrbHQhrDtFiffweV9hnzC/08OjugNc2Lq7K861DzN6ZtqKL1nVo0Z
         bEGw==
X-Gm-Message-State: AO0yUKUVgbW2AfQb+MMbyLwHZNQ3Uar4zdEd15LhwuD6HkWfW0a1/RKT
        953ijS78hwG5piDcR47W8FynPA==
X-Google-Smtp-Source: AK7set97fBpL6H42gYlUxVUXNAa5KOqEFcoLVnbLCsNCoalgkJr0oOLpkdMBPHkzwy+SNaRvquhCww==
X-Received: by 2002:a17:906:784f:b0:8b2:8876:2a11 with SMTP id p15-20020a170906784f00b008b288762a11mr9150260ejm.28.1677746244373;
        Thu, 02 Mar 2023 00:37:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k1-20020a170906680100b008b17de9d1f2sm6928653ejr.15.2023.03.02.00.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:37:23 -0800 (PST)
Message-ID: <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
Date:   Thu, 2 Mar 2023 09:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
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
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
 <20230301035144.8645-1-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301035144.8645-1-aakarsh.jain@samsung.com>
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

On 01/03/2023 04:51, Aakarsh Jain wrote:
> Convert s5p-mfc bindings to DT schema format using json-schema.
> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> changes since v5:
> kept compatible strings under enum
> sorted compatible strings
> added iommu maxItems:2
> Added indentation with 4 spaces in dts example
> 
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
>  .../bindings/media/samsung,s5p-mfc.yaml       | 151 ++++++++++++++++++
>  2 files changed, 151 insertions(+), 78 deletions(-)
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
> index 000000000000..da48d0493cdd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -0,0 +1,151 @@
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
> +          - samsung,exynos5433-mfc        # Exynos5433
> +          - samsung,mfc-v5                # Exynos4
> +          - samsung,mfc-v6                # Exynos5
> +          - samsung,mfc-v7                # Exynos5420
> +          - samsung,mfc-v8                # Exynos5800
> +          - samsung,mfc-v10               # Exynos7880
> +      - items:
> +          - enum:
> +              - samsung,exynos3250-mfc    # Exynos3250
> +          - const: samsung,mfc-v7         # Fall back for Exynos3250
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

That's confusing now... The iommu-names above says it requires two
iommus, but your iommus property says one item is enough. You need here
minItems: 1... but then why one IOMMU (for such variants) is always
"left"? Probably then the meaning of first IOMMU changes, right? If
that's correct, then I propose to leave it as minItems:1/maxItems:2
without defining the items here and...

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

iommus:
  maxItems: 1
iommu-names: false

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
> +        iommus:
> +          maxItems: 2

... and here:
iommu-names:
  items:
    - const: left
    - const: right

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
> +        iommus:
> +          maxItems: 2

the same here

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

iommus:
  maxItems: 1
iommu-names: false


Best regards,
Krzysztof

