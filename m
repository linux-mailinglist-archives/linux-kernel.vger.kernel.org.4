Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AA72CF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbjFLT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbjFLT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:27:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43319AE;
        Mon, 12 Jun 2023 12:27:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f624daccd1so5370864e87.0;
        Mon, 12 Jun 2023 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686598024; x=1689190024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejV5kgx3hh37txIAYRNNYKvIriYQUHYrwXp8KRCJYl4=;
        b=LYER8swJIMWaeDGZ2hkjyJOD6ND8uFats/yvoPB7ibeB5ZjEBi5yxPSWnmn7dYoDy5
         9YzgYvQa/lmsZH27yWeAyaJHL6o6p/ATfvr/+QI/CvmWSa0LtzaDCFdVtcS4b8hLNmLs
         KC1DfDe23MY7B+edf2XG9ZSoVcT2hvmexqOIaXRiHdbRDzNhXeL6UNUXz/ihVnXM5RJ8
         zYolz5pt7aznawgMX4deagz9rt3FU3as8j2na+PvHllzryco963N80M+XQGuh4zcfZPT
         SYFEq99/wEqAgeId8wN2JeF5sOvL748sDNHQvBq/0c9PsxccdxokurM8rc6/hRKxbakb
         zRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686598024; x=1689190024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejV5kgx3hh37txIAYRNNYKvIriYQUHYrwXp8KRCJYl4=;
        b=ltYqQDLZkOYtAt3PFa+pAjU8H61BsjF8SR89h8+BQG1UJSMTQCP7zG+lKgWFLkOhM9
         QlWctmBzl/Wt5TFu5YFQeSXayrT+E2RsrLZb7c5toO7UrwWIuI4zAZ3DEMpHmJX9W6SJ
         0gmC1lWigJ0wnQSx9afWEWb3MWpW1qSmrnzMQCqa02cEu3KbCR1ZCGhqevU4HwGtprrn
         OjOMArDHZoBe2ERrMffVKSldwj6YoXRPMOqEU+gtpdR+q2WBIIwnl0aN+v9d9T5BDDSZ
         YOq9w3WLlE0lo4PQA14365C/VvPMPyeW+YN9vLiXB11aXdeAZNfNqIzRLqNLRI3S8mxa
         rx7g==
X-Gm-Message-State: AC+VfDyVEp8cY4c6FiaweA2SINu0G+rf+PMZuYFMdQ/HK7NT+MIQOTbG
        FhcE+cbMSzxJc8IOLaeTTpU=
X-Google-Smtp-Source: ACHHUZ6A6MkVpb+0rEzh/Ln9SlF8OV11QAdT0mkQWx0k205rKa35tH+XEtW7A0DwjsG6evJQCknNXw==
X-Received: by 2002:a05:6512:60f:b0:4f6:133e:a0ec with SMTP id b15-20020a056512060f00b004f6133ea0ecmr5130780lfe.25.1686598023507;
        Mon, 12 Jun 2023 12:27:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id n17-20020a195511000000b004f252a753e1sm1553756lfe.22.2023.06.12.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:27:02 -0700 (PDT)
Date:   Mon, 12 Jun 2023 22:27:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Message-ID: <20230612192700.nd5t4ekt6my5dqqo@mobilestation>
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
 <20230612171337.74576-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612171337.74576-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:13:34PM +0200, Sebastian Reichel wrote:
> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> allowed clocks without bloating the generic binding, the description
> of Rockchip's AHCI controllers has been moved to its own file.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks. The patch now looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../bindings/ata/rockchip,dwc-ahci.yaml       | 124 ++++++++++++++++++
>  .../bindings/ata/snps,dwc-ahci.yaml           |  13 +-
>  2 files changed, 133 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> new file mode 100644
> index 000000000000..b5e5767d8698
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DWC AHCI SATA controller for Rockchip devices
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  This document defines device tree bindings for the Synopsys DWC
> +  implementation of the AHCI SATA controller found in Rockchip
> +  devices.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +      - const: snps,dwc-ahci
> +
> +  ports-implemented:
> +    const: 1
> +
> +  sata-port@0:
> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> +
> +    properties:
> +      reg:
> +        const: 0
> +
> +    unevaluatedProperties: false
> +
> +patternProperties:
> +  "^sata-port@[1-9a-e]$": false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ports-implemented
> +
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-dwc-ahci
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 5
> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob
> +            - const: ref
> +            - const: asic
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3568-dwc-ahci
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/ata/ahci.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    sata@fe210000 {
> +      compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
> +      reg = <0xfe210000 0x1000>;
> +      clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
> +               <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
> +               <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
> +      clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
> +      interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
> +      ports-implemented = <0x1>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sata-port@0 {
> +        reg = <0>;
> +        hba-port-cap = <HBA_PORT_FBSCP>;
> +        phys = <&combphy0_ps PHY_TYPE_SATA>;
> +        phy-names = "sata-phy";
> +        snps,rx-ts-max = <32>;
> +        snps,tx-ts-max = <32>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> index 5afa4b57ce20..4c848fcb5a5d 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -13,6 +13,15 @@ description:
>    This document defines device tree bindings for the generic Synopsys DWC
>    implementation of the AHCI SATA controller.
>  
> +select:
> +  properties:
> +    compatible:
> +      enum:
> +        - snps,dwc-ahci
> +        - snps,spear-ahci
> +  required:
> +    - compatible
> +
>  allOf:
>    - $ref: snps,dwc-ahci-common.yaml#
>  
> @@ -23,10 +32,6 @@ properties:
>          const: snps,dwc-ahci
>        - description: SPEAr1340 AHCI SATA device
>          const: snps,spear-ahci
> -      - description: Rockhip RK3568 AHCI controller
> -        items:
> -          - const: rockchip,rk3568-dwc-ahci
> -          - const: snps,dwc-ahci
>  
>  patternProperties:
>    "^sata-port@[0-9a-e]$":
> -- 
> 2.39.2
> 
