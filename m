Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED05F55AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJENja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJENi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:38:57 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C797B7B9;
        Wed,  5 Oct 2022 06:38:50 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-131dda37dddso18925933fac.0;
        Wed, 05 Oct 2022 06:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by0ERkaps8lQ29dDrpojcZoFWWZyPIbwRx4Gps7MS3k=;
        b=c2P46/oqyi2Hrq23SR4qaok3ykenY/joxr8goQKN6S3jCAWtGgs4ygLN3uxJvehCNs
         iG94mfAsYOOaJjifs9rBT0GEMjt3gRg+qT+3kVilnBPfhvy9eawP9AA1pKAPZA1+hWBq
         ernNJIb3ibsTLPTHLAOFDmZWIiSdvUWZNZi1Ae5qpXorAFRJUlQeeLDfJOOmXX/qYbm/
         FoyUSVqwj/DXSABYUgEhLs9YpqmPyHGwAYj7kVHle61AZmxwUzmExmKo6cihIuvGtjy8
         YetRwzD5yxUdarMU+9T8zKwd4crsr58iO8nGHRev8SEb5s+/rCCfmiD1JA0G9G8S8a/V
         o4VA==
X-Gm-Message-State: ACrzQf3hZZcvg2X9gSzvxrscZ4d/l2IB6P8uOfB86xwDIDc+ew4+jeB4
        gqL/pRMhUhOqcvXAWQhj4g==
X-Google-Smtp-Source: AMsMyM4xHEPNqUNnGDrNw5cPpfWdbzhoD7LTo0G+9iEO7jAgDG3oNsnG3K3/tFnv512rIA7OgNN45g==
X-Received: by 2002:a05:6870:160f:b0:131:e2c3:8fe3 with SMTP id b15-20020a056870160f00b00131e2c38fe3mr2598787oae.54.1664977130056;
        Wed, 05 Oct 2022 06:38:50 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id d18-20020a4aa592000000b00435a59fba01sm3407370oom.47.2022.10.05.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:38:49 -0700 (PDT)
Received: (nullmailer pid 3284182 invoked by uid 1000);
        Wed, 05 Oct 2022 13:38:48 -0000
Date:   Wed, 5 Oct 2022 08:38:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Message-ID: <20221005133848.GA3278938-robh@kernel.org>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
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

On Wed, Oct 05, 2022 at 01:35:15PM +0200, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek watchdog bindings to schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>  2 files changed, 80 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> new file mode 100644
> index 000000000000..f43b5af92d40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/mediatek,mtk-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoCs Watchdog timer
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description:
> +  The watchdog supports a pre-timeout interrupt that fires
> +  timeout-sec/2 before the expiry.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2712-wdt
> +              - mediatek,mt6589-wdt
> +              - mediatek,mt7986-wdt
> +              - mediatek,mt8183-wdt
> +              - mediatek,mt8186-wdt
> +              - mediatek,mt8192-wdt
> +              - mediatek,mt8195-wdt

The original binding only had 4 without a fallback. It's fine to add or 
change, but note the changes in the commit msg. Are all of these really 
each unique and not the same?


> +      - items:
> +          - enum:
> +              - mediatek,mt2701-wdt
> +              - mediatek,mt6582-wdt
> +              - mediatek,mt6797-wdt
> +              - mediatek,mt7622-wdt
> +              - mediatek,mt7623-wdt
> +              - mediatek,mt7629-wdt
> +              - mediatek,mt8516-wdt
> +          - const: mediatek,mt6589-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Watchdog pre-timeout (bark) interrupt
> +
> +  mediatek,disable-extrst:
> +    description: Disable sending output reset signal
> +    type: boolean
> +
> +  timeout-sec: true

Drop this and use 'unevaluatedProperties'.

> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        watchdog: watchdog@10007000 {
> +            compatible = "mediatek,mt8183-wdt";
> +            reg = <0 0x10007000 0 0x100>;
> +            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> +            mediatek,disable-extrst;
> +            timeout-sec = <10>;
> +            #reset-cells = <1>;
> +        };
> +    };
