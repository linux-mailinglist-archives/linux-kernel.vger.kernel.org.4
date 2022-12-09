Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F066F6489E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLIVGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:06:34 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848AB07B1;
        Fri,  9 Dec 2022 13:06:33 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so3535207otl.7;
        Fri, 09 Dec 2022 13:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmeJVrEJOjzTJixKXt3JyIusK0h5xUR00VNwUCvfUhM=;
        b=in5Ti+bpwtDtnSlVg5n63R1kuj0+rSLeHw2aDxJ1WabJVpYbm94IkLevgVMk2ayy2R
         OAmzgiAwlfinE4qg8SUzN0+IN4ev6PIIe3UXmP5zfonvz5lWZvmbz52u+C5OPLR4GvGc
         tFjuqB5HQSMm/n/yDzKhCRld21o+NiZXRuARqzOIStVqVT8d95LnI4NpBCock9fLv0Uk
         lHqBEbTb7cSlmeH449Lvw6M8mLzYm39TjjnU3DNw9fRoy9O/xINI/8obp9mJnr8yl+qJ
         dFcjsi48EHCcsLAdaBq0yxSouLUE+EXVs0psjJYB2qDarOBp4iJGU6okyis76UJROR9p
         6hdw==
X-Gm-Message-State: ANoB5plrOPMoKbJVB5n5RA3jzWDN6ZCp3XhOPYVuhj/oK01QnlVjBbFb
        gsxin96P6kD2XvZQlAB/aQ==
X-Google-Smtp-Source: AA0mqf5Ut9mbB94upyJcs+ECN8fe9gRzFe+x8ECeZ4iIL60Pmjvjjlfpjl6w5CtAWja/OCpHFulnKQ==
X-Received: by 2002:a05:6830:6287:b0:661:e43e:aa28 with SMTP id ce7-20020a056830628700b00661e43eaa28mr4674464otb.10.1670619992715;
        Fri, 09 Dec 2022 13:06:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d725a000000b00661b019accbsm1013724otk.3.2022.12.09.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:06:32 -0800 (PST)
Received: (nullmailer pid 3847139 invoked by uid 1000);
        Fri, 09 Dec 2022 21:06:31 -0000
Date:   Fri, 9 Dec 2022 15:06:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 01/12] dt-binding: mediatek: add bindings for MediaTek
 8195 MDP3 components
Message-ID: <20221209210631.GA3840519-robh@kernel.org>
References: <20221207084412.14075-1-moudy.ho@mediatek.com>
 <20221207084412.14075-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207084412.14075-2-moudy.ho@mediatek.com>
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

On Wed, Dec 07, 2022 at 04:44:01PM +0800, Moudy Ho wrote:
> This patch adds support for MT8195 MDP3 RDMA, and introduce more
> MDP3 components present in MT8195.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-aal.yaml     | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-color.yaml   | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-fg.yaml      | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-hdr.yaml     | 63 +++++++++++++++
>  .../bindings/media/mediatek,mdp3-merge.yaml   | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-ovl.yaml     | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-pad.yaml     | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rdma.yaml    |  5 +-
>  .../bindings/media/mediatek,mdp3-split.yaml   | 76 +++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-stitch.yaml  | 64 ++++++++++++++++
>  .../bindings/media/mediatek,mdp3-tcc.yaml     | 63 +++++++++++++++
>  .../bindings/media/mediatek,mdp3-tdshp.yaml   | 64 ++++++++++++++++
>  12 files changed, 717 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
> new file mode 100644
> index 000000000000..5b59e0802357
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-aal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Media Data Path 3 AAL Device Tree Bindings

Drop ' Device Tree Bindings' from titles.

> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Moudy Ho <moudy.ho@mediatek.com>
> +
> +description: |

Don't need '|'

> +  One of Media Data Path 3 (MDP3) components is responsible for backlight
> +  power saving and sunlight visibility improving.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-mdp3-aal
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.

How many 4 cell entries? This allows any number. If 1, then you need 
'maxItems: 1' with the outer 'items'.

> +
> +  clocks:
> +    minItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - clocks
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/gce/mt8195-gce.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    mdp3-aal0@14005000 {
> +      compatible = "mediatek,mt8195-mdp3-aal";
> +      reg = <0x14005000 0x1000>;
> +      mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
> +      clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
> +      power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;

Indent by 4 spaces here.

> +    };

Same comments for the rest...

