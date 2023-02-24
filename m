Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26C6A19A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBXKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjBXKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:09:43 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D10172A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:08:23 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id s1so4390980vsk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLgAm+20NHdcq3TTMKIQSFC8qlmxumh/Xz94/sWg1sg=;
        b=TqCzL9tTwUn2D8BgnS/XinTdipALTG+K4pHG117dB2icMNDC9IdP54M4WXROap6tix
         ZYIoJjvpocY5eufWjfnHvTbh6ZI4sBOPFS3xT3Mg9n9Z8wuNkDv/dAsUp2HNF+yMZqjO
         WrJDRa9clAKnn56oMSnovkTkOQsgEr9s3AQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLgAm+20NHdcq3TTMKIQSFC8qlmxumh/Xz94/sWg1sg=;
        b=XlvEfHUVv8B/248nuJZVvoj5k3NSsaU3DhoFMZx1hoannC3gqJN+kRFlD3GYWgbN+4
         QEaGSMROFDXSbohA1WPiU3+qJRv3CJsDBkruAGbiIBOQ83l2BXbPz+tWd0PWB+VkQOfU
         Pb+cKwymCe5aSR/292C9wL+Kmv//GbX7eM0PINduSw7+BFAt0kJ5/HAduIdxTNVn1Ju4
         XYA5qXBjqyoEJDuF0aGGAwsLDmsuGanC2TiYxXUyRjVwSZGz4BznnwzaP9dcmbgWO5VU
         MERZ6RY4wrhZWF7v2NqROVodlkDXJzWNQ6WKfNP9U2rzqmlpA4ZWYiWFEn9m1JVv+E7I
         rQfg==
X-Gm-Message-State: AO0yUKVwFOFJMKqxz4XzxCVO9lAf/QXBjHd3Xb2/pH/xDxCTNiSRhrpi
        fCqeP1ziBv92JjPfDpfpqd8qcXG44vufUp1Nvokv2g==
X-Google-Smtp-Source: AK7set9+CsoqKt5EF2uez7Y+7kBPrW2rCoZh1NWDNAuNiIsn/Yo/mXxmNcqE0NmxlOQD8opEMKzbfzkayObs+QwkzPg=
X-Received: by 2002:ab0:53d5:0:b0:68a:5c52:7f2b with SMTP id
 l21-20020ab053d5000000b0068a5c527f2bmr4377179uaa.1.1677233302208; Fri, 24 Feb
 2023 02:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com> <20230223133440.80941-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223133440.80941-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 18:08:11 +0800
Message-ID: <CAGXv+5GJgAz4yvb-zvFwxRD2PGtkpV7gD-Lst9KDAaZDzLyDEg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] dt-bindings: gpu: mali-bifrost: Add compatible
 for MT8195 SoC
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The MediaTek MT8195 SoC has a Mali G57 MC5 (Valhall-JM) and has the
> same number of power domains and requirements as MT8192 in terms of
> bindings.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 65fe139ceb83..4d9ab4702582 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -25,6 +25,11 @@ properties:
>                - rockchip,px30-mali
>                - rockchip,rk3568-mali
>            - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-mali

This could be squashed into "- const: mediatek,mt8195-mali" like the
following lines?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +          - const: mediatek,mt8192-mali
> +          - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
>        - items:
>            - enum:
>                - mediatek,mt8192-mali
> --
> 2.39.2
>
