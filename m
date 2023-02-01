Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FADD686EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBATIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBATIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:08:01 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52037B404;
        Wed,  1 Feb 2023 11:07:54 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id bj22so7487325oib.11;
        Wed, 01 Feb 2023 11:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi7XcW1y3WLTfCdCo7UYMnqKzLhj4mc2nANuGKh/bpk=;
        b=PPTGDx12EwwUrsIi5s2AdVDdzhOHnZc60TJIJJldCc3T/pAZVdowyv65Lyc4YfblIJ
         XE2ZCVdGe0G9hmQkwc8enpA7yBHIfyGs3EWEnb2bDbc94LyFYLwxpxP+ko7M/1idvPa6
         NQBsTY4bQZqhfVAB1OW5yop6+hs5bPunHsrhltNkepxIuFordiWCMIkPXKVpU0dhlYh3
         +ia4QkawaEtfOIChicnrrZv5sfNNFL+JD0irHwMQ+YyqrmMQY2Ma5i6HoTBP0yRziF4k
         eFb6kTLfK5uJHUQ4MTKJy6ztKyneLoKHnaNawHNmmdWnMfhulp5WyXhgOgPbYTpS6PRl
         Bs6g==
X-Gm-Message-State: AO0yUKUZgmBDJI2ykllsAbZ+BkHrIlTvYp/oVPzxb0gwaFB7t3IiwtcE
        1CYj/nuTGp9WNWvXplIcMA==
X-Google-Smtp-Source: AK7set/vT+/LoUUNaOdQamZD02ISU+wioAtI5xsI356MJZUGhg++3VXcVLiRSjDR4FLtp2sHMTxR7A==
X-Received: by 2002:a05:6808:1816:b0:37a:2bf0:5026 with SMTP id bh22-20020a056808181600b0037a2bf05026mr1465106oib.20.1675278473832;
        Wed, 01 Feb 2023 11:07:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a544688000000b0035c073aa0d8sm4902208oic.18.2023.02.01.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:07:53 -0800 (PST)
Received: (nullmailer pid 4186666 invoked by uid 1000);
        Wed, 01 Feb 2023 19:07:52 -0000
Date:   Wed, 1 Feb 2023 13:07:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de,
        shawnguo@kernel.org, lorenzo.pieralisi@arm.com, peng.fan@nxp.com,
        marex@denx.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v8 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema
Message-ID: <20230201190752.GA4155886-robh@kernel.org>
References: <1675238813-18048-1-git-send-email-hongxing.zhu@nxp.com>
 <1675238813-18048-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675238813-18048-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:06:50PM +0800, Richard Zhu wrote:
> Restruct i.MX PCIe schema, derive the common properties, thus they can
> be shared by both the RC and Endpoint schema.
> 
> Update the description of fsl,imx6q-pcie.yaml, and move the EP mode
> compatible to fsl,imx6q-pcie-ep.yaml.
> 
> Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
> accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   | 121 ++++++++++
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 217 ++++++++++++++++++
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 111 +--------
>  MAINTAINERS                                   |   2 +
>  4 files changed, 347 insertions(+), 104 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> new file mode 100644
> index 000000000000..a2eb56de0294
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 PCIe RC/EP controller
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +description:
> +  Generic Freescale i.MX PCIe Root Port and Endpoint controller
> +  properties.
> +
> +properties:
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: PCIe bridge clock.
> +      - description: PCIe bus clock.
> +      - description: PCIe PHY clock.
> +      - description: Additional required clock entry for imx6sx-pcie,
> +          imx8mq-pcie.
> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +      - enum: [ pcie_phy, pcie_aux ]
> +      - enum: [ pcie_inbound_axi, pcie_aux ]
> +
> +  num-lanes:
> +    const: 1
> +
> +  fsl,imx7d-pcie-phy:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> +      required properties for imx7d-pcie and imx8mq-pcie.
> +
> +  power-domains:
> +    minItems: 1
> +    items:
> +      - description: The phandle pointing to the DISPLAY domain for
> +          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> +          imx8mq-pcie.
> +      - description: The phandle pointing to the PCIE_PHY power domains
> +          for imx6sx-pcie.
> +
> +  power-domain-names:
> +    minItems: 1
> +    items:
> +      - const: pcie
> +      - const: pcie_phy
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 3
> +    description: Phandles to PCIe-related reset lines exposed by SRC
> +      IP block. Additional required by imx7d-pcie and imx8mq-pcie.
> +
> +  reset-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  fsl,tx-deemph-gen1:
> +    description: Gen1 De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2-3p5db:
> +    description: Gen2 (3.5db) De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2-6db:
> +    description: Gen2 (6db) De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 20
> +
> +  fsl,tx-swing-full:
> +    description: Gen2 TX SWING FULL value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 127
> +
> +  fsl,tx-swing-low:
> +    description: TX launch amplitude swing_low value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 127
> +
> +  fsl,max-link-speed:
> +    description: Specify PCI Gen for link capability (optional required).
> +      Note that the IMX6 LVDS clock outputs do not meet gen2 jitter
> +      requirements and thus for gen2 capability a gen2 compliant clock
> +      generator should be used and configured.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  vpcie-supply:
> +    description: Should specify the regulator in charge of PCIe port power.
> +      The regulator will be enabled when initializing the PCIe host and
> +      disabled either as part of the init process or when shutting down
> +      the host (optional required).
> +
> +  vph-supply:
> +    description: Should specify the regulator in charge of VPH one of
> +      the three PCIe PHY powers. This regulator can be supplied by both
> +      1.8v and 3.3v voltage supplies (optional required).
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> new file mode 100644
> index 000000000000..8b2506a85083
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -0,0 +1,217 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 PCIe Endpoint controller
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +description: |+
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP and
> +  thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
> +  The controller instances are dual mode where in they can work either in
> +  Root Port mode or Endpoint mode but one at a time.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mm-pcie-ep
> +      - fsl,imx8mq-pcie-ep
> +      - fsl,imx8mp-pcie-ep
> +
> +  reg:
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: addr_space
> +
> +  interrupts:
> +    items:
> +      - description: builtin eDMA interrupter.
> +
> +  interrupt-names:
> +    items:
> +      - const: dma
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - num-lanes
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +  - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx6sx-pcie-ep
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - {}
> +            - {}
> +            - const: pcie_phy
> +            - const: pcie_inbound_axi
> +        power-domains:
> +          minItems: 2
> +        power-domain-names:
> +          minItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mq-pcie-ep
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - {}
> +            - {}
> +            - const: pcie_phy
> +            - const: pcie_aux
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx6sx-pcie-ep
> +                - fsl,imx8mq-pcie-ep
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6q-pcie-ep
> +              - fsl,imx6qp-pcie-ep
> +              - fsl,imx7d-pcie-ep
> +    then:
> +      properties:
> +        clock-names:
> +          maxItems: 3
> +          contains:
> +            const: pcie_phy
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mm-pcie-ep
> +              - fsl,imx8mp-pcie-ep
> +    then:
> +      properties:
> +        clock-names:
> +          maxItems: 3
> +          contains:
> +            const: pcie_aux
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6q-pcie-ep
> +              - fsl,imx6qp-pcie-ep
> +    then:
> +      properties:
> +        power-domains: false
> +        power-domain-names: false
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - fsl,imx6sx-pcie-ep
> +                - fsl,imx6q-pcie-ep
> +                - fsl,imx6qp-pcie-ep
> +    then:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6q-pcie-ep
> +              - fsl,imx6sx-pcie-ep
> +              - fsl,imx6qp-pcie-ep
> +              - fsl,imx7d-pcie-ep
> +              - fsl,imx8mq-pcie-ep
> +    then:
> +      properties:
> +        resets:
> +          minItems: 3
> +        reset-names:
> +          items:
> +            - const: pciephy
> +            - const: apps
> +            - const: turnoff
> +    else:
> +      properties:
> +        resets:
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: apps
> +            - const: turnoff

All these constraints should be the same regardless of host or endpoint 
mode, so they belong in the common schema. After all, it's the same h/w 
for each SoC.

Rob
