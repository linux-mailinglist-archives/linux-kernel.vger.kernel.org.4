Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B916CA54C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjC0NMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0NMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:12:46 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C83DF;
        Mon, 27 Mar 2023 06:12:46 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so4485882oti.13;
        Mon, 27 Mar 2023 06:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy+LGO1hZYQteOYXAi2MTuV8EwkfENi7/3mKtvfcWcM=;
        b=77P7Uo9xpDiHaQcNIszSm+0rbECSvGQw0dhk4l2BwIxiN49fdWK6iMkuEj8hv9C/Er
         Ba9u0HVI8BuxOp887m3un8nYcYoegIBkKA/YpZJQ4eORcugo2nOzGElNOUfP4cM171+I
         ki9Gjtwhv4j9DMN++1zF4YhxqT3+YWPYdBYRY87OKB1O8OHIr3sZ6IVgKmMaX7ILMHT6
         FDGCarGC+arG652PyYsJpuK4Chjqb5GxEdpkPEMUTKRTXO/tqGt5tVE2mGZjwh02+499
         qwWRiNq5B1bid8b0HD8K0ixFCF0dUpFM5axVuinnM5zyeHgAHCBb5tLb93n+J8Jj5qvH
         ebDA==
X-Gm-Message-State: AO0yUKXt1bwYzSaOcMW+8Ew+ZUoL3it9qibiYv6IOJIYBUsjVzgd2MKD
        38Xuxtm5iMz5kYlX0I5OPh1/FSu0ug==
X-Google-Smtp-Source: AK7set+my+8Ru1KWMv/XxGqRnLq6lS4KUJdHjR1C70GN6oF7hoORRk1bGIe0330UCVf/M435x7q+3A==
X-Received: by 2002:a05:6830:1606:b0:69f:9d13:5692 with SMTP id g6-20020a056830160600b0069f9d135692mr5844838otr.23.1679922765239;
        Mon, 27 Mar 2023 06:12:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b12-20020a9d6b8c000000b0069fa7b738b3sm5419345otq.27.2023.03.27.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:12:44 -0700 (PDT)
Received: (nullmailer pid 3279071 invoked by uid 1000);
        Mon, 27 Mar 2023 13:12:43 -0000
Date:   Mon, 27 Mar 2023 08:12:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3
 glue layer
Message-ID: <20230327131243.GA3238130-robh@kernel.org>
References: <20230323163116.2921999-1-Frank.Li@nxp.com>
 <20230323163116.2921999-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323163116.2921999-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:31:14PM -0400, Frank Li wrote:
> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - Drop all clock-assign
> 
> Change from v2 to v3
> - Drop two fixed frequency clocks, it is system reset value, no need set now.
> If need, futher work/discuss on driver or dts change. It will not block this
> basic enablement work.
> - Drop lable
> - Drop some descriptions
> - Reg as second property.
> 
> Change from v1 to v2.
> - new add binding doc
> 
>  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> new file mode 100644
> index 000000000000..654d8704aa6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> @@ -0,0 +1,104 @@
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
> +      - description: Register set for iMX USB3 Platform Control
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

lpm, bus, aclk, ipg, core (or core_pclk) are sufficient.

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
> +    usb@5b110000 {
> +      compatible = "fsl,imx8qm-usb3";
> +      reg = <0x5b110000 0x10000>;
> +      ranges;
> +      clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
> +               <&usb3_lpcg IMX_LPCG_CLK_0>,
> +               <&usb3_lpcg IMX_LPCG_CLK_7>,
> +               <&usb3_lpcg IMX_LPCG_CLK_4>,
> +               <&usb3_lpcg IMX_LPCG_CLK_5>;
> +      clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
> +                    "usb3_ipg_clk", "usb3_core_pclk";
> +      assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
> +      assigned-clock-rates = <250000000>;
> +      power-domains = <&pd IMX_SC_R_USB_2>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      usb@5b120000 {
> +        compatible = "cdns,usb3";
> +        reg = <0x5b120000 0x10000>,   /* memory area for OTG/DRD registers */
> +              <0x5b130000 0x10000>,   /* memory area for HOST registers */
> +              <0x5b140000 0x10000>;   /* memory area for DEVICE registers */
> +        reg-names = "otg", "xhci", "dev";
> +        interrupt-parent = <&gic>;
> +        interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "host", "peripheral", "otg", "wakeup";
> +        phys = <&usb3_phy>;
> +        phy-names = "cdns3,usb3-phy";
> +      };
> +    };
> -- 
> 2.34.1
> 
