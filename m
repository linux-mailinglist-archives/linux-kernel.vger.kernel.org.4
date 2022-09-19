Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D85BCA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiISLKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiISLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:10:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353901274A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:10:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y14so2954021ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=leo8if+OXZNXConjLSxBiC1xHNu7f4uf6YaQSrfQ6dM=;
        b=kQBGYCFbFe6wxHvIBprzXylP266QJBmQBKTPtFJF6xfpA7dNNVp2NVu5LXeuwpBvgy
         l5k/JAFZ98MY6FDpsUW3e5dZHM2ZWh4Yxb1qv8CppcHqsdGvNbVWkAEySYEj3/Zi+u9Y
         5XyDB/TsBmM2hzMmOqfOF6qACe0zp6rRXoUxq8fbsNlzYX2prPs8sYRyqpmR+Mx4j1/g
         V/eQldgqKxJyu+AO9amS94pi6tJ0qPAMJToYQE2irKNrklCZdtPrpQETappTE0nn+thr
         JqPLKwaI8MN72Q+CHA+HsjmeQhFC8aXi5cgTHTropui/k6VFjCggFjtH9v4X0sJzrCas
         wCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=leo8if+OXZNXConjLSxBiC1xHNu7f4uf6YaQSrfQ6dM=;
        b=oMjMnzifkql/lP5y8gr4kFRu17BjLIuv/M7BrehuRoY9Runsd2cWwdvpBTAeX1HJw6
         fZT75Ur66Pmi/RPlpthU9YjArnZKpKiYegGISNcfnOSDYJWmFBmwhZ8zASwOQEQ4brvd
         wR783PMxalqsRgilSCUXdydpeUKoTHcS0wLgCXgGxMz3nI3mB8e+NX6j0H9b8S3eBefx
         ae7ZHF0yVBx1TWWXCVx7i/y8RptY6LIQ3vqKH0eoKunyMOeqDAFfV5DrT44aySnzqngO
         /p1n5qKC92/7wsEjhkn8DrsN9VjsDYmHbPK0yb88wpKRKLjZKsKC+e4McL06v1n8GSnI
         CKpA==
X-Gm-Message-State: ACrzQf1n+pgFc/7+uVtoB7z03lq7c2rPlTozkKQLl40MLyltO7A7l4d1
        RaZQMONnKMGvdrxrgNnpL2dVGw==
X-Google-Smtp-Source: AMsMyM5pnZQbHW1dGGT8W+qa05FG5zVzym9N5KK1TyZUexybR53b4r/JPum/Pl510FYRuhjxCbODGw==
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr5518902ljt.352.1663585808514;
        Mon, 19 Sep 2022 04:10:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id du4-20020a056512298400b00499b0f5bc0fsm332116lfb.36.2022.09.19.04.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:10:08 -0700 (PDT)
Message-ID: <018b6df6-2337-3b6d-1936-b61ce250c1c9@linaro.org>
Date:   Mon, 19 Sep 2022 13:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-bindings: mailbox: Convert mtk-gce to DT schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220919081333.15678-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919081333.15678-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 10:13, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce mailbox binding to DT schema format.
> 

Mention any deviations from conversion in the commit msg.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v3:
>  - Removed '|' from description
>  - Removed mbox client examples
>  - Squashed patch dt-bindings: arm: mediatek:
>    mmsys: Reference to mediatek,gce-mailbox.yaml
> 
> Changes in v2:
>  - Changed mtk-gce.txt references to new yaml file
> 
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
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml |  3 +-
>  .../mailbox/mediatek,gce-mailbox.yaml         | 80 ++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   | 82 -------------------
>  3 files changed, 82 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..85e6f4f621fc 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -52,7 +52,8 @@ properties:
>      description:
>        Using mailbox to communicate with GCE, it should have this
>        property and list of phandle, mailbox specifiers. See
> -      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
> +      Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +      for details.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>  
>    mediatek,gce-client-reg:
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> new file mode 100644
> index 000000000000..fff8fd2e984a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -0,0 +1,80 @@
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
> +description:
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

Put it in allOf block

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

I think comment is no longer relevant.

> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gce: mailbox@12120000 {
> +        compatible = "mediatek,mt8173-gce";
> +        reg = <0x10816000 0x1000>;

Didn't you have warnings here?

> +        interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> +        #mbox-cells = <2>;
> +        clocks = <&infracfg CLK_INFRA_GCE>;
> +        clock-names = "gce";
> +    };

Best regards,
Krzysztof
