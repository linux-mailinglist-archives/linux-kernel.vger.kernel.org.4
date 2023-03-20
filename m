Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F36C182D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjCTPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjCTPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:20:50 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B153252F;
        Mon, 20 Mar 2023 08:15:02 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1755e639b65so13392582fac.3;
        Mon, 20 Mar 2023 08:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5qZtnUm8Mm8wUqRNJAyXi0PBNEXChBjw1lMTidfAtY=;
        b=0zBFv+UbmYeXISDI+yLKhqu2ajEdxI/TeYfdVRTG9BGc5Nho4LSvsK/yJFd6lho5Tt
         SuC1Z5jGIQJesh8bXEyA+QTM8ZMKHWODRzpCDP0lCTkAWzQgVrMZO00a74JmgKGdSaDd
         YMrNvYv13fStlNDKtb/IoChYE+XRpRkxD/2KQR6jSpJs0wR9OuhW6quUT0JZQFjfR15e
         hQa37SEQQOUjYPhJ7A7w1SZTiH5f8WIMhkcjoxC7IlqGOy1RtD2VsmZl0OJCon5Nhvb/
         9Cvu0hwkPuuvx+k1bjVr5Cclw0NCW58SHXHzxRTzpkTdI8u/Cgwho0+r2STj/qlb4IXC
         WT5Q==
X-Gm-Message-State: AO0yUKXSWXdXya/8bP4096DPiW0ZsPBlfF6/QoBbMIeVcmzVwTCRQH1Z
        qjZNzk2atMXuPLhoGbxBvg==
X-Google-Smtp-Source: AK7set8tshMz5XRnkeEqcwB6jzvA8gX4UtDFqALHdeGzcBeOSXLMjWOv6RYPiHw3JpEfoIrBWRqlyQ==
X-Received: by 2002:a05:6871:6ab:b0:17a:a7af:6cf3 with SMTP id l43-20020a05687106ab00b0017aa7af6cf3mr5400139oao.56.1679325278373;
        Mon, 20 Mar 2023 08:14:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eo17-20020a056870ec9100b0017aa2cd117asm3395883oab.13.2023.03.20.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:14:38 -0700 (PDT)
Received: (nullmailer pid 1712355 invoked by uid 1000);
        Mon, 20 Mar 2023 15:14:37 -0000
Date:   Mon, 20 Mar 2023 10:14:37 -0500
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
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <20230320151437.GA1709620-robh@kernel.org>
References: <20230315100421.133428-1-changhuang.liang@starfivetech.com>
 <20230315100421.133428-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315100421.133428-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 03:04:19AM -0700, Changhuang Liang wrote:
> StarFive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> new file mode 100644
> index 000000000000..b72ac44bc29d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive SoC MIPI D-PHY Rx Controller
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description:
> +  The StarFive SoC uses the MIPI CSI D-PHY based on M31 IP to transfer
> +  CSI camera data.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-dphy-rx
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: config clock
> +      - description: reference clock
> +      - description: escape mode transmit clock
> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: ref
> +      - const: tx
> +
> +  resets:
> +    items:
> +      - description: DPHY_HW reset
> +      - description: DPHY_B09_ALWAYS_ON reset
> +
> +  starfive,aon-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle of AON SYSCON
> +          - description: register offset
> +    description: The power of dphy rx is configured by AON SYSCON
> +      in this property.

Sounds like AON SYSCON should be a power-domains provider. Custom 
phandle links are for things which don't fit standard bindings.

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
> +    phy@19820000 {
> +      compatible = "starfive,jh7110-dphy-rx";
> +      reg = <0x19820000 0x10000>;
> +      clocks = <&ispcrg 3>,
> +               <&ispcrg 4>,
> +               <&ispcrg 5>;
> +      clock-names = "cfg", "ref", "tx";
> +      resets = <&ispcrg 2>,
> +               <&ispcrg 3>;
> +      starfive,aon-syscon = <&aon_syscon 0x00>;
> +      #phy-cells = <0>;
> +    };
> -- 
> 2.25.1
> 
