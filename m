Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF6642F83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiLERzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLERz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:55:29 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0941AD;
        Mon,  5 Dec 2022 09:54:32 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id l127so13917887oia.8;
        Mon, 05 Dec 2022 09:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjD5jvfs1Q2x/cdcxaQ+cfzZKHiqKwOk2YSAqbwKlVo=;
        b=X12WQ97Y1cgdbJd+Eq81q+PZMhgnH2VWJ7k8nas1LVX7HtErvLPJmbZnbKfPvHgyaZ
         /P7eBRWTHI3zClC0vfSSSEy4rs1C7JoMTBE0Uc9Na9kipWBZzjkBJoyrI5UuXtaQfPU+
         JppG1awGmtr8B9T4xceJPpgsv4x520zIxWfsV37RPEYj3xowGnK3++CSXr9CtnZY/MiI
         Q7l1kTfKzpkSxjIEnGb8PvNQMKOabTE/B2vIs4aAJpMp6bKB80pONIn/uh1BSsRxUamT
         Nz47oUWRALat8n1bVZfbJvMSZRMtcio5ttxtBUX8U70OJ8rrniJ1kVNpXazpsF6umkJl
         +kXQ==
X-Gm-Message-State: ANoB5pmwX1kNReqCmNg6lXSW/lWmTeTutk9gS98uenkkZ6hc4iTWkbX+
        WfQBByfpzj5RXGOIkpyHUQ==
X-Google-Smtp-Source: AA0mqf7MQR4VlM3j15dfYZl5T10+IaF4xou+7DEW3p2t0/AF/R9GuAMvPe+A/m3AS1CZqrt91T0rvQ==
X-Received: by 2002:a05:6808:1246:b0:354:4b35:2809 with SMTP id o6-20020a056808124600b003544b352809mr40266726oiv.256.1670262871784;
        Mon, 05 Dec 2022 09:54:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a056870a40600b0012d939eb0bfsm9448668oal.34.2022.12.05.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:54:31 -0800 (PST)
Received: (nullmailer pid 2143933 invoked by uid 1000);
        Mon, 05 Dec 2022 17:54:30 -0000
Date:   Mon, 5 Dec 2022 11:54:30 -0600
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
Subject: Re: [PATCH v4,1/3] media: dt-bindings: media: mediatek: vcodec:
 adapt to the 'clock-names' of different platforms
Message-ID: <20221205175430.GA2136513-robh@kernel.org>
References: <20221202034450.3808-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202034450.3808-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:44:48AM +0800, Yunfei Dong wrote:
> mt8195 and mt8192 have different clock numbers, separate 'clock-names'
> according to compatible name.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> compared with v3:
> - rewrite clock-names according to different platforms.
> 
> Reference series:
> [1]: v5 of this series is presend by Allen-KH Cheng.
>      message-id: 20221128143832.25584-4-allen-kh.cheng@mediatek.com
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index 7c5b4a91c59b..a08b2c814f40 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -110,15 +110,12 @@ patternProperties:
>            Refer to bindings/iommu/mediatek,iommu.yaml.
>  
>        clocks:
> +        minItems: 1

Why 1? Looks like it should be 4 or 5 clocks.

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
>  
>        assigned-clocks:
>          maxItems: 1
> @@ -159,6 +156,38 @@ then:
>    required:
>      - interrupts
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-vcodec-dec
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: sel
> +            - const: soc-vdec
> +            - const: soc-lat
> +            - const: vdec
> +            - const: top
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-vcodec-dec
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: sel
> +            - const: vdec
> +            - const: lat
> +            - const: top
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.18.0
> 
> 
