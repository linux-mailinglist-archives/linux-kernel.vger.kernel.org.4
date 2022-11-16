Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5162C65D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiKPR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiKPR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:29:53 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208AA32BA9;
        Wed, 16 Nov 2022 09:29:52 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso2597673ooo.4;
        Wed, 16 Nov 2022 09:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiZRwJ+mJX0JujaVc55ipnODAd5lXgBHhurRBqfzsSI=;
        b=Ms/WI9NodAlZpc9LmcOBz5PPrLXeodij50uPU0jWoVElbLMTMCINKayCWcsuopM8/T
         f1EdfWGWNTVGksb2mVluYgAeOduRHX08YrNnR/nxbHfqGn0AXfb7AMXfHR4+ZUyJZ8YD
         LF5iqKG3Ww4PU24Eie7d473YySRyrahhFu2Tu/hGFwGssYqUkbJXqbzd7SFG95/PzeNl
         WaXXk8rkxhUvtvxVZCID2dLBxKxfHrIpfTq5TQVmvW7FNJfz7Ljgu+LPnIYlL86FwZCR
         mN9R3sq2VX1PDK2onjjaIozdLjwxOX0C7gZ1K1eDnU7SR+/59SdVHgNS/xhQLjK6JNKr
         nurA==
X-Gm-Message-State: ANoB5pmupij2vTa7+WFsXwAHDQzhEIFOI/5ELhwhJDODqs2bKg2yzn/Z
        42Jruu9XeHoQeQPH/Wjy3Q==
X-Google-Smtp-Source: AA0mqf7cJeNBtZVp0MmQORg/6QiAJfJWHo09p0aiOG4XwqyXKGRbJY+74MdCHUSoYXUWALOVHDxhQw==
X-Received: by 2002:a4a:c298:0:b0:49e:a604:b053 with SMTP id b24-20020a4ac298000000b0049ea604b053mr10169038ooq.85.1668619790882;
        Wed, 16 Nov 2022 09:29:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a4ade49000000b0049eedb106e2sm6289417oot.15.2022.11.16.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:29:50 -0800 (PST)
Received: (nullmailer pid 554417 invoked by uid 1000);
        Wed, 16 Nov 2022 17:29:52 -0000
Date:   Wed, 16 Nov 2022 11:29:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Message-ID: <20221116172952.GA461876-robh@kernel.org>
References: <20221110102834.8946-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110102834.8946-1-yunfei.dong@mediatek.com>
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

On Thu, Nov 10, 2022 at 06:28:32PM +0800, Yunfei Dong wrote:
> mt8195 and mt8192 have different clock numbers, can't write 'clocks' and
> 'clock-names' with const value.

Not a compatible change. Explain why that is okay if it is.

> 
> Move 'assigned-clocks' and 'assigned-clock-parents' to parent node.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 119 +++++++++++-------
>  1 file changed, 72 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..794012853834 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -89,23 +89,33 @@ properties:
>  
>    ranges: true
>  
> +  clocks:
> +    minItems: 1
> +    maxItems: 5
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 5

Why do both the parent and child have clocks?

> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1

You can just drop assigned-clock properties. They are allowed in any 
node with 'clocks'.

> +
>  # Required child node:
>  patternProperties:
> -  '^vcodec-lat@[0-9a-f]+$':
> +  '^vcodec-lat-soc@[0-9a-f]+$':
>      type: object
>  
>      properties:
>        compatible:
>          enum:
> -          - mediatek,mtk-vcodec-lat
>            - mediatek,mtk-vcodec-lat-soc
>  
>        reg:
>          maxItems: 1
>  
> -      interrupts:
> -        maxItems: 1
> -

Dropping interrupts? Not explained in the commit msg (why?).

>        iommus:
>          minItems: 1
>          maxItems: 32
> @@ -114,22 +124,55 @@ patternProperties:
>            Refer to bindings/iommu/mediatek,iommu.yaml.
>  
>        clocks:
> +        minItems: 1
>          maxItems: 5
>  
>        clock-names:
> -        items:
> -          - const: sel
> -          - const: soc-vdec
> -          - const: soc-lat
> -          - const: vdec
> -          - const: top
> +        minItems: 1
> +        maxItems: 5

We had names defined and now we don't. That's a step backwards.

>  
> -      assigned-clocks:
> +      power-domains:

Adding power-domains?

Rob
