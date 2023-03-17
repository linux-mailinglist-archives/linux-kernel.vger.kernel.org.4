Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031106BE4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCQJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCQJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:09:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110ACEC7C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:09:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so17667396ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bwh85sD/XE4ZPG7n6FYMfigvAZYyWZkG5V3jgNeiqVM=;
        b=GFTPf1vCyaFRN6hLZgI1MlNKMq6zQ2OHzOcjPhbUtzZnBVMeKtakMREJMCpzYDKIhr
         J6xfgdW3sdgohQHzg+8SDyxZ/iJ1AG4r/8+UDt60iXgVPtI9L0sQQx6SUKxJpxezCu5n
         3jA4MEE2Dw9Jpcnm+8UJVcYusqbG6sA/+XGrqWa7whbbLfN7K58+93kMB4sI2ed+VPbl
         GZdhpMML212wvby4/1dNcMfOHr0NNkhC5dNUkyS5ZkTbP8PHYwWArDXHhkQ0bRLoBAxc
         cCVHZV1W8tESmnCm+DsJ5f/ccZPxuOqSF7TK5paq0DnOIz4zQsE2oe3YMVDUfyp/y7UD
         3Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwh85sD/XE4ZPG7n6FYMfigvAZYyWZkG5V3jgNeiqVM=;
        b=IoKERwGieLGsyeDP8DLs+77oZL212+nAmlmo9VDz/aZW0TdeWM/57wQqregFyDhebJ
         yzW134D5ZPu2rpiKavoJbOpYXq0EU3Cqtea98RwaIe4IXpKLX9n6n48wr3s1yz5g+HJ8
         fJ2GkG2mMBmOd6lqrNIspI4ww3tGiYyP4+83U0wDXIOGwrgxwv86+OoCr4cEuWgZk/X+
         DpdtrItas+uCuOLtUYZq+Vii8St9NnK8S4YuKyU5Us3t2f7PqKdAChGt87tFgL07iF+I
         9qEohiBhGWUq/vkuc/ixj1AwQMw5U0U8aItffUGajL08BTBQzWJcDT9RWJuQmWYwtsg1
         m7PA==
X-Gm-Message-State: AO0yUKVy5eGg8P0traNxbGShS7SqRN+dd3vYdf9wcqKQmCzNlqC13QZV
        1p2k2aTohYoXIzHvWS0ppQrNxg==
X-Google-Smtp-Source: AK7set+jbzzcgm/NqZwsPW4WXCK9O9EUDXRK3QLEtf2yNwHhKetE4b6qIjmPC0UTyg2eeknKx/lx5A==
X-Received: by 2002:a17:906:1316:b0:8e4:96c4:94a with SMTP id w22-20020a170906131600b008e496c4094amr12506906ejb.56.1679044159545;
        Fri, 17 Mar 2023 02:09:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id g20-20020a1709061e1400b00930f5ecbd8fsm723418ejj.219.2023.03.17.02.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:09:19 -0700 (PDT)
Message-ID: <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
Date:   Fri, 17 Mar 2023 10:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3
 glue bindings
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316212712.2426542-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 22:27, Frank Li wrote:
> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> 

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> new file mode 100644
> index 000000000000..fc24df1e4483
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP iMX8QM Soc USB Controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qm-usb3
> +
> +  reg:
> +    items:
> +      - description: Address and length of the register set for iMX USB3 Platform Control

Drop "Address and length of the"... or actually just maxItems: 1,
because the description is a bit obvious.

> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +  clocks:
> +    description:
> +      A list of phandle and clock-specifier pairs for the clocks
> +      listed in clock-names.

Drop description.

> +    items:
> +      - description: Standby clock. Used during ultra low power states.
> +      - description: USB bus clock for usb3 controller.
> +      - description: AXI clock for AXI interface.
> +      - description: ipg clock for register access.
> +      - description: Core clock for usb3 controller.
> +
> +  clock-names:
> +    items:
> +      - const: usb3_lpm_clk
> +      - const: usb3_bus_clk
> +      - const: usb3_aclk
> +      - const: usb3_ipg_clk
> +      - const: usb3_core_pclk
> +
> +  assigned-clocks:
> +    items:
> +      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PER.
> +      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MISC.
> +      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MST_BUS.
> +
> +  assigned-clock-rates:
> +    items:
> +      - description: Must be 125 Mhz.
> +      - description: Must be 12 Mhz.
> +      - description: Must be 250 Mhz.

I would argue that both properties above are not needed. If your
hardware requires fixed frequencies, clock provider can fix them, can't it?

> +
> +  power-domains:
> +    maxItems: 1
> +
> +# Required child node:
> +
> +patternProperties:
> +  "^usb@[0-9a-f]+$":
> +    $ref: cdns,usb3.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    usbotg3: usb@5b110000 {

Drop label, unused

> +      compatible = "fsl,imx8qm-usb3";
> +      ranges;
> +      reg = <0x5b110000 0x10000>;

reg is second property

> +      clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
> +               <&usb3_lpcg IMX_LPCG_CLK_0>,
> +               <&usb3_lpcg IMX_LPCG_CLK_7>,
> +               <&usb3_lpcg IMX_LPCG_CLK_4>,
> +               <&usb3_lpcg IMX_LPCG_CLK_5>;
> +      clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
> +                    "usb3_ipg_clk", "usb3_core_pclk";
> +      assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
> +                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
> +                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
> +      assigned-clock-rates = <125000000>, <12000000>, <250000000>;
> +      power-domains = <&pd IMX_SC_R_USB_2>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      status = "disabled";

Drop status

> +
> +      usbotg3_cdns3: usb@5b120000 {

Drop label

> +          compatible = "cdns,usb3";
> +          interrupt-parent = <&gic>;
> +          interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
> +          interrupt-names = "host", "peripheral", "otg", "wakeup";
> +          reg = <0x5b120000 0x10000>,   /* memory area for OTG/DRD registers */
> +                <0x5b130000 0x10000>,   /* memory area for HOST registers */
> +                <0x5b140000 0x10000>;   /* memory area for DEVICE registers */
> +          reg-names = "otg", "xhci", "dev";

reg is second property, reg-names third.

> +          phys = <&usb3_phy>;
> +          phy-names = "cdns3,usb3-phy";
> +      };
> +    };

Best regards,
Krzysztof

