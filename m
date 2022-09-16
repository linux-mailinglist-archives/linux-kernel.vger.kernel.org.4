Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF425BAF14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIPORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIPORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:17:07 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED08BB088A;
        Fri, 16 Sep 2022 07:17:05 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id n124so6318565oih.7;
        Fri, 16 Sep 2022 07:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JhuxjeOKraKJboj/02rtWKx4yslOS5BQGZXJOnVgpXo=;
        b=oeMj1L5YkNTlDij/7kPtWyN8U1Qk/hHBbmWHknJNyVBELlvQ/jTiKxZHbbmcaZqArR
         6+211NKcNXLJR6tTPv1UQbzfoKkfzRxmhGMorXDgjSa/OFBSFgkm5TrZQhLY8OVzMoUJ
         2LUuH/cJIgdCVYZ4K4azRWfHQlRds/ziJOXniqiARs/W5MKtIZBNjWGkmR+khM/U1eya
         /qzfM0NwLM3+G3gfxecWX+5ffkJMW/kyiqGQx6Vb5cSpGjgCO1Cw97FjjjFq+e5576u8
         3PClU0UWeHxwgX2oE+xqsYPMDeo5y3QU2rzZeQZBSNcxeQjwxwptYgPQfs9ST3xb16BF
         TJcw==
X-Gm-Message-State: ACgBeo1ZKB4wKVcpb4FZdAN0h//02TaQxwV8Txj0x8KjSRdvbd2H4fP0
        yW9sYUb7RIPx8ATJxbwCcMESIFyREw==
X-Google-Smtp-Source: AA6agR7Q8MmZmdK7ErfIGsi5C1xJ6G2P8DSYtwbCZC3/T+KyYBpTI0WovQyEPnoyNNFIubnFZbFvMg==
X-Received: by 2002:a05:6808:1717:b0:334:9342:63f1 with SMTP id bc23-20020a056808171700b00334934263f1mr7048788oib.77.1663337825116;
        Fri, 16 Sep 2022 07:17:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w128-20020acaad86000000b0034564365bf2sm9023012oie.17.2022.09.16.07.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:17:04 -0700 (PDT)
Received: (nullmailer pid 300358 invoked by uid 1000);
        Fri, 16 Sep 2022 14:17:03 -0000
Date:   Fri, 16 Sep 2022 09:17:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: Convert mtk-gce to DT schema
Message-ID: <20220916141703.GA271453-robh@kernel.org>
References: <20220916080742.26851-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916080742.26851-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:07:41AM +0200, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce mailbox binding to DT schema format.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> A previous attempt for this was made at [1], but it was changing
> the way of getting clocks (by name for all).
> Keeping clock-names not required for the multi-gce case makes this
> binding simpler, hence I chose to abandon the change at [1] and go
> for this one instead.
> 
> Any Reviewed-by or Acked-by tag was dropped, as this conversion was
> completely redone from scratch and differs from [1] for the
> aforementioned reasons.
> 
> [1]: https://lore.kernel.org/all/20220524151512.247435-1-angelogioacchino.delregno@collabora.com/
> 
>  .../mailbox/mediatek,gce-mailbox.yaml         | 104 ++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 --------------
>  2 files changed, 104 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> new file mode 100644
> index 000000000000..ac6ca7fc5302
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Global Command Engine Mailbox
> +
> +maintainers:
> +  - Houlong Wei <houlong.wei@mediatek.com>
> +
> +description: |

Don't need '|' if not formatting to preserve.

> +  The Global Command Engine (GCE) is used to help read/write registers with
> +  critical time limitation, such as updating display configuration during the
> +  vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6779-gce
> +      - mediatek,mt8173-gce
> +      - mediatek,mt8183-gce
> +      - mediatek,mt8186-gce
> +      - mediatek,mt8192-gce
> +      - mediatek,mt8195-gce
> +
> +  "#mbox-cells":
> +    const: 2
> +    description:
> +      The first cell describes the Thread ID of the GCE,
> +      the second cell describes the priority of the GCE thread
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Global Command Engine clock
> +
> +  clock-names:
> +    items:
> +      - const: gce
> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          const: mediatek,mt8195-gce
> +then:
> +  required:
> +    - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # Example for a device client and for a MediaTek mutex client
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/gce/mt8173-gce.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    gce: mailbox@12120000 {
> +        compatible = "mediatek,mt8173-gce";
> +        reg = <0x10816000 0x1000>;
> +        interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> +        #mbox-cells = <2>;
> +        clocks = <&infracfg CLK_INFRA_GCE>;
> +        clock-names = "gce";
> +    };
> +
> +    syscon@14000000 {
> +        compatible = "mediatek,mt8173-mmsys", "syscon";
> +        reg = <0x14000000 0x1000>;
> +        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;

Provider binding examples don't normally show clients in examples (and 
vice-versa). Presumably we already have this in the 
"mediatek,mt8173-mmsys" binding.

> +    };
> +
> +    mutex@14020000 {
> +        compatible = "mediatek,mt8173-disp-mutex";
> +        reg = <0x14020000 0x1000>;
> +        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
> +        power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +        clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +        mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0 0x1000>;
> +        mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
> +                              <CMDQ_EVENT_MUTEX1_STREAM_EOF>;

ditto.

