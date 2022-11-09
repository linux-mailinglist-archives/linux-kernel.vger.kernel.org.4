Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F8623694
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiKIW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKIW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:29:23 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0772A948;
        Wed,  9 Nov 2022 14:29:22 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso347268fac.11;
        Wed, 09 Nov 2022 14:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB7db5XhVLteVue/y4fRr6KOu5yTU0vk8xjG6P+z0hw=;
        b=cIxrnDmIUPSqknAgZ9JEcnJ+1aY3kxPHifNzZo/ClIYRvJ3TjhSMBZ9ZlEkOBzL2na
         E5zkyuRAXr2z0scrOs8PuyvvzSjwsLREfWGcXSGG9l26BWK8afSBBh+WS0zlaGj9qoDl
         6kwCMyipVW4iElYZw3jxsl/62+IiU3hgdpr0huAptPA69qr7SPpD2US8fb18QMaAuun6
         sP3yQP2mjHsuofoZW8PMQ8u8rp61WGAN4A6gSL5j+otgVhxDGy3GBsVwph2k6QGMLL5b
         kR9y3ynmKjRy9gkAhOWYOQKXAZQgb5BTg6oAVKe6z25wiaojXjoi6QMOAtRYxhykHcal
         1jug==
X-Gm-Message-State: ACrzQf2TNQRYroPT7w6EP0BvbXgd9pminFR4mt4yqHYkuJCD9VpRvaU9
        3ieoRsHXhmJWzNleaX8kVQ==
X-Google-Smtp-Source: AMsMyM5XTaVj88TTJ/YSmUbz++qS30jO8NLEsM469GDD8snWToOwoGaV4ijLSqhIbURwc+n/mRCQ+g==
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id z11-20020a05687041cb00b001319656cc30mr47491998oac.51.1668032955859;
        Wed, 09 Nov 2022 14:29:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a0568301e7a00b0066c2e241a4csm5811632otr.20.2022.11.09.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:29:15 -0800 (PST)
Received: (nullmailer pid 2988684 invoked by uid 1000);
        Wed, 09 Nov 2022 22:29:16 -0000
Date:   Wed, 9 Nov 2022 16:29:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Message-ID: <20221109222916.GA2985917-robh@kernel.org>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
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

On Tue, Nov 08, 2022 at 07:43:37PM +0100, Alexandre Mergnat wrote:
> - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> - Add mediatek,mt6357-rtc compatible.
> - Add maintainer
> - Remove the .txt binding file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
>  .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 40 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -----------------
>  3 files changed, 41 insertions(+), 32 deletions(-)
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
> index 000000000000..bb48c0150f95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
> @@ -0,0 +1,40 @@
> + # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6397/MT6366/MT6358/MT6357/MT6323 RTC
> +
> +maintainers:
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description: |
> +  MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
> +  as a type of multi-function device (MFD). The RTC can be configured and set up
> +  with PMIC wrapper bus which is a common resource shared with the other
> +  functions found on the same PMIC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6323-rtc
> +      - mediatek,mt6357-rtc
> +      - mediatek,mt6358-rtc
> +      - mediatek,mt6366-rtc
> +      - mediatek,mt6397-rtc

As this is only a compatible string, just fold this into the MFD schema 
doc.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    pmic {
> +        compatible = "mediatek,mt6397";
> +
> +        rtc {
> +               compatible = "mediatek,mt6397-rtc";
> +        };
> +    };
