Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B62702C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbjEOMZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:25:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0521BC;
        Mon, 15 May 2023 05:25:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 830EB66031DA;
        Mon, 15 May 2023 13:25:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684153537;
        bh=Rl/jN3uyJpuesLYqs5+0/hmh5nAfzeWPHpb4ipmQ1nU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kap+61MDpii8Ol4UUwUo3Es7XYvHv0eY8dkzOCI9GNudoOfzvnO0AvU7ohyHgS29d
         3OHVSbifF1xrxx2Yg/gxUB0ovoCTqJ+eVAqsKvRIn7c2oqfaXewWH/gx63v9H86q2q
         MEUkcpmstAk8tiDYtQlsPG3UGXKBzNgZ1FeS8B905iGklIVCZmrHsItqkxIyjiaaZn
         slTD+ZY3rdZUqWHnw4ZUwhY7QIRPcpw3681xVe9KmV54uIvx3EmR/Iz8spk+NXSz8P
         3FRX9MsaUH0Z05TLp/9GpnoaiBKWnQlxNhA9UkAwZaDqaNtWmuAv6FH57HPB8EIPfy
         Q+7xbpmw+5RiQ==
Message-ID: <f96c6809-d7d4-4030-5805-ca79f87715ce@collabora.com>
Date:   Mon, 15 May 2023 14:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515090551.1251389-2-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 11:05, Julien Stephan ha scritto:
> From: Florian Sylvestre <fsylvestre@baylibre.com>
> 
> This adds the bindings, for the MIPI CD-PHY module v 0.5 embedded in
> some Mediatek soc, such as the mt8365
> 
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   .../phy/mediatek,phy-mipi-csi-0-5.yaml        | 62 +++++++++++++++++++
>   MAINTAINERS                                   |  6 ++
>   2 files changed, 68 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> new file mode 100644
> index 000000000000..5aa8c0b41cdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,phy-mipi-csi-0-5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> +
> +maintainers:
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description:
> +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> +  receivers. The number of PHYs depends on the SoC model.
> +  Depending on the soc model, each PHYs can support CDPHY or DPHY only
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,phy-mipi-csi-0-5

mediatek,mtXXXX-csi-rx sounds great, doesn't it?

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  mediatek,is_cdphy:

No underscores please: mediatek,is-cdphy

> +    description:
> +      Specify if the current phy support CDPHY configuration

Description fits in one line.

     description: Specify if the current phy support CDPHY configuration

> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#phy-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      mipi_rx_csi0: mipi_rx_csi0@11c10000 {

csi0_rx: phy@11c10000

> +        compatible = "mediatek,phy-mipi-csi-0-5";
> +        reg = <0 0x11C10000 0 0x2000>;
> +        status = "okay";
> +        mediatek,is_cdphy;
> +        #phy-cells = <0>;
> +      };
> +
> +      mipi_rx_csi1: mipi-rx-csi1@11c12000 {

csi1_rx: phy@11c20000

> +        compatible = "mediatek,phy-mipi-csi-0-5";
> +        reg = <0 0x11C12000 0 0x2000>;
> +        status = "disabled";
> +        #phy-cells = <0>;
> +      };
> +    };
> +...

Regards,
Angelo

