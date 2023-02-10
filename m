Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4163469255D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjBJS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjBJS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:29:38 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1456C7C7;
        Fri, 10 Feb 2023 10:29:37 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id bd6so5168860oib.6;
        Fri, 10 Feb 2023 10:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGTEo37sO/PejdrEzawXo41Wh2Us1e4LKILpN2RdcKM=;
        b=Axk5tU1qpwc47CWQIMIgBGDWaZNWxvUtp6LXq0DS4nIA6KVSjnLwI/2RiTAg+CIt/L
         u/bumYgSnZHJXxkQQwKNZlHgVaT+LK/enCy2R+LmVixYuiHS+d47KFplHxySrLDTGDTs
         /+lGGDVgWQilStS0QLTEb3D3ACOYX5WJ7l0A0OyuPe+fwY87ytEBw/2ADBWCRZRaNMwV
         YQber8z02yz/f/WpR1lgIl8BGtJU8ZF/oNDSo8h+y8yuf55hLHcXrS9f6ooGvLo+Usis
         YWDS19tn/HLHrGwtwvHJL/SHyEkeHEaHU05XkOA2wxRJWVZF79jzwHVlwyJzjOKxP2h0
         8fww==
X-Gm-Message-State: AO0yUKVhFcQYf8DkFG5GZZYaCtp9Dr9KiR/peBKww0nmUs/gFy+MG1HW
        BmM7gtegFNz1X2dme0WHvA==
X-Google-Smtp-Source: AK7set/47StQR2IteFFtY5K4A8e4jlFxeqFxgq613Kt0yzg/tmsRzIzQLGKF92qW8nmFbDRMVTy8Vw==
X-Received: by 2002:a05:6808:616:b0:364:862d:29c5 with SMTP id y22-20020a056808061600b00364862d29c5mr7107671oih.26.1676053776722;
        Fri, 10 Feb 2023 10:29:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q2-20020a0568080ec200b0037d6c3fc8aasm616760oiv.45.2023.02.10.10.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:29:36 -0800 (PST)
Received: (nullmailer pid 2916782 invoked by uid 1000);
        Fri, 10 Feb 2023 18:29:35 -0000
Date:   Fri, 10 Feb 2023 12:29:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <20230210182935.GA2914589-robh@kernel.org>
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210061713.6449-3-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:17:11PM -0800, Changhuang Liang wrote:
> Starfive SoC like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> new file mode 100644
> index 000000000000..1c1e5c7cbee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive SoC MIPI D-PHY Rx Controller
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description: |

Don't need '|'

> +  The Starfive SOC has a MIPI CSI D-PHY based on M31 IP use to transfer
> +  the CSI cameras data.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: "starfive,jh7110-dphy-rx"

Drop quotes.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3

Just maxItems is enough.

> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: ref
> +      - const: tx
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2

Need to define what each reset is.

> +
> +  starfive,aon-syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes.

> +    items:
> +      items:
> +        - description: phandle of AON SYSCON
> +        - description: register offset
> +    description: The register of dphy rx driver can be configured
> +      by AON SYSCON in this property.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - starfive,aon-syscon
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    dphy@19820000 {
> +      compatible = "starfive,jh7110-dphy-rx";
> +      reg = <0x19820000 0x10000>;
> +      clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFGCLK_IN>,
> +               <&ispcrg JH7110_ISPCLK_M31DPHY_REFCLK_IN>,
> +               <&ispcrg JH7110_ISPCLK_M31DPHY_TXCLKESC_LAN0>;
> +      clock-names = "cfg", "ref", "tx";
> +      resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
> +               <&ispcrg JH7110_ISPRST_M31DPHY_B09_ALWAYS_ON>;
> +      starfive,aon-syscon = <&aon_syscon 0x00>;
> +      #phy-cells = <0>;
> +    };
> -- 
> 2.25.1
> 
