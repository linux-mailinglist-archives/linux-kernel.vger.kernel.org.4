Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C204681E15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjA3W3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjA3W3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:29:36 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096552ED52;
        Mon, 30 Jan 2023 14:29:34 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id d188so11373532oia.3;
        Mon, 30 Jan 2023 14:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LRTaCsYupaKAIxJ4u3XR2A11yw5IpehNtdsJbn/NTo=;
        b=3w7GfnvySgqKZMcooOq/ud2Zmz4hvCLwsdfBedydrGcgai+B2ZwxFbURXA5+1Kz7Sv
         lD7LssyaPGt6Z1Oaw0e7GpjOVdVe+yxGtQNG5y53Eqq86tBADojVYTOP2GWXy79CaYPm
         8WfL+56mVXUC0E2BDgcYhg+EWtUwQ7Kbga8HndBRq1RGrAFi2yODtFdRUOYsqo2O6iaB
         7pV3ZxwPJ82uCTN26jakFlxgwGfFnpsmv51cYp/t1ZxaC3KBR6Nsg3WO5/PJrhaGKDvv
         9hqF+Uw2fiEXVLSJQDrEKAca091DUGcp+cwnxh0/njOp8VQnOqapNaMdK/DQESKv+eAk
         GzLg==
X-Gm-Message-State: AFqh2kqCVknPDhdtbQZSE+tfx1hcaHu0VKWYmpkhxbkQB6TacAfJKuUi
        jGX2jc3syvINOANn9esSRQ==
X-Google-Smtp-Source: AMrXdXtsZN18JtBDPLJvQi4F9AvmMcMq/hDOjEtb7fzc6IuLtWh0PJy6kGEcLqiUe29fbQATyakg+w==
X-Received: by 2002:a05:6808:4247:b0:36e:b7bf:e3d7 with SMTP id dp7-20020a056808424700b0036eb7bfe3d7mr18464727oib.52.1675117773208;
        Mon, 30 Jan 2023 14:29:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g131-20020acab689000000b0036e9160f57csm5170753oif.20.2023.01.30.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:29:32 -0800 (PST)
Received: (nullmailer pid 3642109 invoked by uid 1000);
        Mon, 30 Jan 2023 22:29:32 -0000
Date:   Mon, 30 Jan 2023 16:29:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de,
        shawnguo@kernel.org, lorenzo.pieralisi@arm.com, peng.fan@nxp.com,
        marex@denx.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v7 2/5] dt-bindings: imx6q-pcie: Add schema for i.MX8M
 PCIe Endpoint modes
Message-ID: <20230130222932.GA3634639-robh@kernel.org>
References: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
 <1675049539-14976-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675049539-14976-3-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:32:16AM +0800, Richard Zhu wrote:
> Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
> accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 317 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> new file mode 100644
> index 000000000000..7c594ae53067
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -0,0 +1,317 @@
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
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: PCIe bridge clock.
> +      - description: PCIe bus clock.
> +      - description: PCIe PHY clock.
> +      - description: Additional required clock entry for imx6sx-pcie-ep,
> +          imx8mq-pcie-ep.
> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +      - enum: [ pcie_phy, pcie_aux ]
> +      - enum: [ pcie_inbound_axi, pcie_aux ]

Are the clocks in endpoint mode suddenly different? I can't tell, but 
will assume so since they added here.

> +
> +  num-lanes:
> +    const: 1

You shouldn't need this if it can only be 1 value.

> +
> +  fsl,imx7d-pcie-phy:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> +      required properties for imx7d-pcie-ep and imx8mq-pcie-ep.
> +
> +  power-domains:
> +    minItems: 1
> +    items:
> +      - description: The phandle pointing to the DISPLAY domain for
> +          imx6sx-pcie-ep, to PCIE_PHY power domain for imx7d-pcie-ep and
> +          imx8mq-pcie-ep.
> +      - description: The phandle pointing to the PCIE_PHY power domains
> +          for imx6sx-pcie-ep.
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
> +      IP block. Additional required by imx7d-pcie-ep and imx8mq-pcie-ep.
> +
> +  reset-names:
> +    minItems: 2
> +    maxItems: 3

Same question for resets.

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

Now we'd duplicated defining the type for all these properties...

This needs to be restructured into a schema of all the common properties 
and then the host and endpoint schema can reference it. IOW, like how 
other schemas have been done.

Rob
