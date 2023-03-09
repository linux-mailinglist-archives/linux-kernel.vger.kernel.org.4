Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD036B20A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCIJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCIJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:52:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CC1EFDA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:52:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso800335wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678355552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2PxWx2l3PO3++xWaxuvqfNeOVyrzZX507vLWShOZE0=;
        b=SdN7RVN4foQwINGrl8iWzw82Jlavh0FQwTNIBtowLeasQJ7pruZQRSUYPcdIaVyXli
         nARnm8wLx8x/QTvsvaAKjE4+2tVtTZXlfT7XSFssKhZIFC8eYzmC+MywEHMGSU8yTU9A
         wZkZ/C3AKU4nY+7ssDsJpcMw/M4FOr7/y4npl00k4uv54LVSMCmiYcYsbQU5kq1pKo0N
         hnb5mDyd3U+NjoGn5847Ma2n0EfJOZY42nxdFEgU47qSiYwxiDGtoNxXfayZozo3uzIz
         aHegfIMJEsKNWG7QYMv2NRKoDzYEiXvSYMAeKPc4wuNALU9Hhwy6R5nfRTeGSJf4tcDJ
         iPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2PxWx2l3PO3++xWaxuvqfNeOVyrzZX507vLWShOZE0=;
        b=pUMWHSHvTW10uTUDP34YFha8vXoVMcNzLjKVH1JJar/53oedB6aFLH3AZaZ0o6cxrt
         AdVj8+A2pkBrtDLYm5PGDqTUD2TIaqqe+hqbZqvs7a6Ozp91E9CL++SVBH7UQV59atiU
         +bSVL5nXElUqzeO4bfJ4cvi3MZ92YpWS+N2qJxUhc/qjL+j70HQ3S2uTEUSzZeKI+PXa
         GtjN73yRV9p/Gz2rS4x05+DLsFdqLkuPxHINIsiX+kYej8PMERsupNu+jLmn9nKvyXTm
         k5t9uj9mFBODOcM/jAiXDbRA3XGAUJf4AAA7Uv6DXLXNmyNk0aNouvU4Qp2n3TDszV/b
         W57w==
X-Gm-Message-State: AO0yUKXi2EPdJqmNiuVX0lHkENxRkjozb6r40dwXDl3tXDp4rLgTvMmh
        kZ8zX2m8F5DZHKIWOq0iapr7dw==
X-Google-Smtp-Source: AK7set8b6ToNgSi3agHmMbKkOWjUSZzz43GXwOxDp9fiN4alCtNYZvBJ7/hj0A39TytNsidxLpR2sA==
X-Received: by 2002:a05:600c:4ecb:b0:3e7:b17f:9af1 with SMTP id g11-20020a05600c4ecb00b003e7b17f9af1mr19561052wmq.22.1678355551910;
        Thu, 09 Mar 2023 01:52:31 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m8-20020a05600c3b0800b003eae73ee4a1sm2362631wms.17.2023.03.09.01.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:52:31 -0800 (PST)
Message-ID: <cab3471d-6d71-2149-d7b5-e9cb3693f328@linaro.org>
Date:   Thu, 9 Mar 2023 09:52:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: convert amlogic-efuse.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v4-1-34e623dbf789@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v4-1-34e623dbf789@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

On 08/03/2023 13:27, Neil Armstrong wrote:
> Convert the  Amlogic Meson GX eFuse bindings to dt-schema.
> 
> Take in account the used variant with amlogic,meson-gx-efuse.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied 1/5 and 2/5

--srini

>   .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   | 57 ++++++++++++++++++++++
>   .../devicetree/bindings/nvmem/amlogic-efuse.txt    | 48 ------------------
>   2 files changed, 57 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
> new file mode 100644
> index 000000000000..e49c2754ff55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/amlogic,meson-gxbb-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson GX eFuse
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: amlogic,meson-gxbb-efuse
> +      - items:
> +          - const: amlogic,meson-gx-efuse
> +          - const: amlogic,meson-gxbb-efuse
> +
> +  clocks:
> +    maxItems: 1
> +
> +  secure-monitor:
> +    description: phandle to the secure-monitor node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - clocks
> +  - secure-monitor
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse: efuse {
> +        compatible = "amlogic,meson-gxbb-efuse";
> +        clocks = <&clk_efuse>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        secure-monitor = <&sm>;
> +
> +        sn: sn@14 {
> +            reg = <0x14 0x10>;
> +        };
> +
> +        eth_mac: mac@34 {
> +            reg = <0x34 0x10>;
> +        };
> +
> +        bid: bid@46 {
> +            reg = <0x46 0x30>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> deleted file mode 100644
> index f7b3ed74db54..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -= Amlogic Meson GX eFuse device tree bindings =
> -
> -Required properties:
> -- compatible: should be "amlogic,meson-gxbb-efuse"
> -- clocks: phandle to the efuse peripheral clock provided by the
> -	  clock controller.
> -- secure-monitor: phandle to the secure-monitor node
> -
> -= Data cells =
> -Are child nodes of eFuse, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> -Example:
> -
> -	efuse: efuse {
> -		compatible = "amlogic,meson-gxbb-efuse";
> -		clocks = <&clkc CLKID_EFUSE>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		secure-monitor = <&sm>;
> -
> -		sn: sn@14 {
> -			reg = <0x14 0x10>;
> -		};
> -
> -		eth_mac: eth_mac@34 {
> -			reg = <0x34 0x10>;
> -		};
> -
> -		bid: bid@46 {
> -			reg = <0x46 0x30>;
> -		};
> -	};
> -
> -	sm: secure-monitor {
> -		compatible = "amlogic,meson-gxbb-sm";
> -	};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -For example:
> -
> -	eth_mac {
> -		...
> -		nvmem-cells = <&eth_mac>;
> -		nvmem-cell-names = "eth_mac";
> -	};
> 
