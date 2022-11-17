Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1B62E020
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiKQPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiKQPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:39:50 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CBEEBD;
        Thu, 17 Nov 2022 07:39:49 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so1258140otl.10;
        Thu, 17 Nov 2022 07:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVhbvRUqZQu6uk1nSlOpC0Wl3O1+Ha3Mzov9EJw71XE=;
        b=qZkEGPzBU9nepJmT/trzMGKP66HWNxqpAT29SXCU4qP+k+rf1wQrg3Tu8ttQxffvKQ
         TtmC1pRWCj72U6ptzNGgf/Bgd9JAuPRTWZq33UO0G8kgQ+bOaZPyqx3LqwipDrnBA/8c
         99xonw/WuJ8zK3a8QRPuI0oh3q7hVEO09FMby9SXazlHRBUQtgl21pl3Rdh1RcMTomDO
         e1OFC+alOhpZLDI4/hlxipGlTvz1rVRVbq/j4dKmsJB6BErHvd5ttNGhDHkDMDpVU6bi
         AtkBsSo7oJxOkU+XveZVeRbZJZeH0w1YOpmc03jHrSA6pMbG70WHSHZO851EWFtOPisV
         kJkQ==
X-Gm-Message-State: ANoB5pktJJtd8uZLlo7Sky+8ymTZRfHKA34dbPtAR3WSGv4pFH1FDtXM
        OjBRT5tdE2TWwnUEXGG5aQ==
X-Google-Smtp-Source: AA0mqf4f8AEtQBCEXoach04sei0JgrD/an2wLNFUiFJXCBqskIg7Lnw9MEjrMzhIfDsicIRmbX4Fng==
X-Received: by 2002:a05:6830:1d66:b0:66c:5b70:2396 with SMTP id l6-20020a0568301d6600b0066c5b702396mr1626581oti.357.1668699589169;
        Thu, 17 Nov 2022 07:39:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 44-20020a9d04af000000b0066101e9dccdsm450844otm.45.2022.11.17.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:39:48 -0800 (PST)
Received: (nullmailer pid 2918390 invoked by uid 1000);
        Thu, 17 Nov 2022 15:39:50 -0000
Date:   Thu, 17 Nov 2022 09:39:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Message-ID: <20221117153950.GA2913522-robh@kernel.org>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-2-8210d955dd3d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v5-2-8210d955dd3d@baylibre.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:32:56PM +0100, Alexandre Mergnat wrote:
> - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> - Add maintainer
> - Remove the .txt binding file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
>  .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 43 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 ----------------
>  3 files changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0088442efca1..79aaf21af8e9 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -33,7 +33,7 @@ Optional subnodes:
>  		- compatible: "mediatek,mt6331-rtc"
>  		- compatible: "mediatek,mt6358-rtc"
>  		- compatible: "mediatek,mt6397-rtc"
> -	For details, see ../rtc/rtc-mt6397.txt
> +	For details, see ../rtc/mediatek,mt6397-rtc.yaml
>  - regulators
>  	Required properties:
>  		- compatible: "mediatek,mt6323-regulator"
> diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
> new file mode 100644
> index 000000000000..f5a323597f1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
> @@ -0,0 +1,43 @@
> + # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6397/MT6366/MT6358/MT6323 RTC
> +
> +maintainers:
> +  - Tianping Fang <tianping.fang@mediatek.com>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
> +  as a type of multi-function device (MFD). The RTC can be configured and set up
> +  with PMIC wrapper bus which is a common resource shared with the other
> +  functions found on the same PMIC.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6323-rtc
> +      - mediatek,mt6358-rtc
> +      - mediatek,mt6366-rtc
> +      - mediatek,mt6397-rtc
> +
> +  start-year: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    pmic {
> +        rtc {
> +            compatible = "mediatek,mt6397-rtc";
> +        };
> +    };

Please drop the example here. Just one complete example in the MFD 
schema.
