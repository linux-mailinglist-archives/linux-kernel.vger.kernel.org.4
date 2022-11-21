Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A494963217E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiKUMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKUMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:00:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98C4E42A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:00:00 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k19so14264108lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAe96EUQJW/t2YfQOYFjoHjjiIW4hHrPPaKyPCc7BE4=;
        b=UVduBhk3PJQZkKzEskUrpKs00z1z4r/O7LnJCkT22HInQOeMTGaNIiUeqIGHvlHNel
         8VqMPfMXtV6tMv9ea7G6sbKvzE3Fm/DlG1E+g8NcPhYe8kgMQ604qRLIDomYKgkO4nJm
         nNM0oOsRVkJDTr9ybiWyVEr8r6WawaItHr7qHt8Sbx4Ok3kdRHr2SR9GXJjMcjqAyue3
         iOGkflLwOC1bOY41x6zbbYbq9oqoBTN30Z/aCEk3crJLxYULIxr+CRUxsV3WKHgXoVok
         yHMtfO5pYc15hhPs6wnzHYeNYaUln8nxRvBy6UGnsaaprdi+rLUUBCYXS1isltaJirK1
         YmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAe96EUQJW/t2YfQOYFjoHjjiIW4hHrPPaKyPCc7BE4=;
        b=uGug/xO6iezNT2emj/ZW2V66Ry6e77LoXPuGjTVZ3sHyS1UElzeDSMQOR4MWCV4okO
         CuU5w2SiAByEMQl8sTCzt2MXaiDGIXs4aO9a/1QnVxOvivbtHfLj6F0H8N1AO331oCHI
         RZP0vrSU9UXIdn4+rrlnTxK2gaPYkH/7BNsch2QJcWWTeob4Wvprv55UxaEVbpgK66LD
         0fzOCApuWpXOJOVVnVa6cdEyAPIqG2VeE+T0Kbk5bgHk4zhab/Ct5W6MAqf4W6NF/EFm
         6G/N2B4TZuhfVuGvEZn21Wu7dFw0WRzweuzq3u0qG2qmgNpKYk5diOkHqLBPvvlLgh/K
         W9fw==
X-Gm-Message-State: ANoB5pmNL5PpvreTngmiSNFALmuSDRJH9XeFv3qVlKTxqUfImZa6RTkG
        uXnVstSOEeDFcf6ocexESo78lw==
X-Google-Smtp-Source: AA0mqf6lo8pDgZCEf5cpGQ6TpOYX19afdgtwbFTqg3DuazhEzItnWlNNkGFC2exRFsAu0oB9C2ARJA==
X-Received: by 2002:a05:651c:160f:b0:278:d847:1a8b with SMTP id f15-20020a05651c160f00b00278d8471a8bmr5107958ljq.17.1669031999150;
        Mon, 21 Nov 2022 03:59:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p3-20020ac24ec3000000b00492e3a8366esm2005053lfr.9.2022.11.21.03.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:59:58 -0800 (PST)
Message-ID: <856449f3-6341-78d8-28db-3d4b8a0a25ad@linaro.org>
Date:   Mon, 21 Nov 2022 12:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] dt-bindings: phy: Add PCIe PHY bindings for FSD
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20221121105210.68596-1-shradha.t@samsung.com>
 <CGME20221121104719epcas5p2f87febfba74a4ca6807b3095acf507d0@epcas5p2.samsung.com>
 <20221121105210.68596-2-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105210.68596-2-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 21/11/2022 11:52, Shradha Todi wrote:
> Document the PCIe PHY device tree bindings for Tesla
> FSD SoC

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../bindings/phy/phy-tesla-pcie.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml b/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml
> new file mode 100644
> index 000000000000..8fa9a050af7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml

Filename based on compatible.

> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-tesla-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tesla FSD SoC PCIe PHY
> +
> +maintainers:
> +  - Shradha Todi <shradha.t@samsung.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0

Put compatible as first.

> +
> +  compatible:
> +    enum:
> +      - tesla,fsd-pcie-phy
> +
> +  reg:
> +    minItems: 2

Drop minItems

> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 2
> +    maxItems: 2

Drop both.

> +    items:
> +      enum: [phy, pcs]

Instead list items one after another.

> +    description: |
> +      phy is the register access to PMA layer
> +      pcs is the register access to PCS layer

These go to describing items in 'reg:'

> +
> +  phy-mode:
> +    description: |
> +      Defines the bifurcation mode of the PHY

enum, probably type as well... phy-mode is usually a string. Is it here?

> +
> +  tesla,pmureg-phandle:

Drop phandle, so tesla,pmu-syscon

> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Drop quotes

> +    description: phandle for PMU system controller interface used to
> +                 control PMU register bits for PCIe PHY
> +
> +  tesla,pcie-sysreg:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Drop quotes

> +    description: phandle for system control registers, used to
> +                 control phy signals at system level
> +
> +required:
> +  - "#phy-cells"
> +  - compatible

compatible first.

> +  - reg
> +  - reg-names
> +  - phy-mode
> +  - tesla,pmureg-phandle
> +  - tesla,pcie-sysreg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie_phy0: pcie-phy@15080000 {
> +        compatible = "tesla,fsd-pcie-phy";
> +        #phy-cells = <0>;
> +        reg = <0x0 0x15080000 0x0 0x2000>, <0x0 0x150A0000 0x0 0x1000>;
> +        reg-names = "phy", "pcs";
> +        tesla,pmureg-phandle = <&pmu_system_controller>;
> +        tesla,pcie-sysreg = <&sysreg_fsys0>;
> +        phy-mode = <0>;
> +        status = "disabled";

Drop status

> +      };
> +    };
> +...

Best regards,
Krzysztof

