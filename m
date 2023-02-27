Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617BA6A49DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjB0SfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjB0Sey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:34:54 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5E524E;
        Mon, 27 Feb 2023 10:34:36 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1720600a5f0so8323607fac.11;
        Mon, 27 Feb 2023 10:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n6Yv51jW5LAwlzGIh67sJQM+UVRJdiU8ADnwyoJqp4=;
        b=QdL0Cp4nD+WawZSxMM+oEIAz/zw1MDKPG8bnlcF8p4Yr3/HaAHB7i8nTFIbOPoUkZK
         gFZJthbKVS2EPQFXyBg75yMcMLMLptOoz/kRTB4/otyx9MBHk35WL5bNLIiOCqoe0sNv
         ZYfi90dYcvaJJvlUtD5dPPjRrX3piHO61xK5/o0BSL1GP8wX0XZ3DuezTwNZfIjSfOyt
         +Oj0neG2qpl/uRxboyEdI0R7aEa6DBCmmydjIWepymM96gOlWuEuDOV2/97Y45dCtkJB
         9BIc7SMVFbShWQ3DWu70uKFUscmrkiMqudceLm+gwRDjXGa0JgjJNuhgADPvqF0MlTCB
         yjqA==
X-Gm-Message-State: AO0yUKW+/D4XKmyHE+LWP4xwmcZL12f7lc5jNIotbkIE09TJzSqqrAXv
        9zsaZiULjgdRCT6Jk5q4Ow==
X-Google-Smtp-Source: AK7set/ZtQIEXLigG6HKVUhIDHBY2W/Gvzvr0DTnjglSjgXggcIfBsaT1ydf9BJAYYtr0mOVbmGB4A==
X-Received: by 2002:a05:6870:f283:b0:172:fda1:5773 with SMTP id u3-20020a056870f28300b00172fda15773mr3395641oap.32.1677522875743;
        Mon, 27 Feb 2023 10:34:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef27-20020a0568701a9b00b00152c52608dbsm2545569oab.34.2023.02.27.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:34:35 -0800 (PST)
Received: (nullmailer pid 647312 invoked by uid 1000);
        Mon, 27 Feb 2023 18:34:34 -0000
Date:   Mon, 27 Feb 2023 12:34:34 -0600
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
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <20230227183434.GA642331-robh@kernel.org>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223015952.201841-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 05:59:50PM -0800, Changhuang Liang wrote:
> Starfive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> new file mode 100644
> index 000000000000..a67ca57a6f21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> @@ -0,0 +1,74 @@
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
> +description:
> +  The Starfive SoC uses the MIPI CSI D-PHY based on M31 IP to transfer
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
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: ref
> +      - const: tx

Should be 'rx' given this is the 'rx' block? A description of each clock 
in 'clocks' would be good.

> +
> +  resets:
> +    items:
> +      - description: DPHY_HW reset
> +      - description: DPHY_B09_ALWAYS_ON reset
> +
> +  starfive,aon-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:

- items: ?

Otherwise, multiple 2 cell entries are allowed. Is that intended?

> +        - description: phandle of AON SYSCON
> +        - description: register offset
> +    description: The power of dphy rx is configured by AON SYSCON
> +      in this property.


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
