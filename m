Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1942B5F1566
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiI3WAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiI3WAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:00:15 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665BC6CF4E;
        Fri, 30 Sep 2022 15:00:13 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so3119670oon.10;
        Fri, 30 Sep 2022 15:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LLT3ZYBdhjAVbmPO/uc2xLKM7qGWQtc4/hcvgBHyd9s=;
        b=lXG2RbSv9XLijqIIokFRQR2/4OXodHdVsheKP1uiCTaD+Ziu+WzLlBPGJBEnEYdCAn
         HVGMhAYmHMcshXNFK21PawZn3p6PBPzMUHEcKxuMykf/6h8ksoO8PhuzLhspKz0EzWtR
         1uZlUCusjL/kjhPxLGdTjjq0o3RIZrONvWnQiDgO+xU7R3EEBnIAFr6saWJx8QCykUny
         efxKLDnaD9cG3K+ch/pKfn+B6LHZUrdlTo2g8u1K4c26FVoPoq2dNMLK8XqSRH0a+PFQ
         Y9HkbaVEMpBrt0OFMt0hSs3gwkq+oRqyFWQxaJ3v3ISiFB6zaA9ncPluNx525QWLx7x1
         p9Ew==
X-Gm-Message-State: ACrzQf2py4r+wS0gwO3jfQsGnAkm9k5SalmObE23eti09yUCxo7CnvoH
        9QPBbNGRxhusiug+u1x/9Q==
X-Google-Smtp-Source: AMsMyM6IrejG/870CvnrzUlNmyBET4I5DXOzFKtUrfEAwncNQElS2UqVUUb3+tMW/6JK2TF/26FdJg==
X-Received: by 2002:a9d:ed2:0:b0:657:438a:eefb with SMTP id 76-20020a9d0ed2000000b00657438aeefbmr4289417otj.239.1664575212616;
        Fri, 30 Sep 2022 15:00:12 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g65-20020acab644000000b0035028730c90sm782022oif.1.2022.09.30.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:00:11 -0700 (PDT)
Received: (nullmailer pid 1111251 invoked by uid 1000);
        Fri, 30 Sep 2022 22:00:11 -0000
Date:   Fri, 30 Sep 2022 17:00:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Message-ID: <20220930220011.GA1107972-robh@kernel.org>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
 <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
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

On Fri, Sep 30, 2022 at 07:22:36PM +0800, Allen-KH Cheng wrote:
> In order to make the names of the child nodes more generic, we rename
> "vcodec" to "video-codec" for decoder in patternProperties and example.

They are either generic or they aren't. Until something generic is 
defined, I don't think it's worth the churn to change.


> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..67fde48f991c 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -91,7 +91,7 @@ properties:
>  
>  # Required child node:
>  patternProperties:
> -  '^vcodec-lat@[0-9a-f]+$':
> +  '^video-codec-lat@[0-9a-f]+$':

Just 'video-codec' doesn't work?

>      type: object
>  
>      properties:
> @@ -145,7 +145,7 @@ patternProperties:
>  
>      additionalProperties: false
>  
> -  '^vcodec-core@[0-9a-f]+$':
> +  '^video-codec-core@[0-9a-f]+$':
>      type: object
>  
>      properties:
> @@ -241,7 +241,7 @@ examples:
>              #size-cells = <2>;
>              ranges = <0 0 0 0x16000000 0 0x40000>;
>              reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
> -            vcodec-lat@10000 {
> +            video-codec-lat@10000 {
>                  compatible = "mediatek,mtk-vcodec-lat";
>                  reg = <0 0x10000 0 0x800>;
>                  interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -264,7 +264,7 @@ examples:
>                  power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
>              };
>  
> -            vcodec-core@25000 {
> +            video-codec-core@25000 {
>                  compatible = "mediatek,mtk-vcodec-core";
>                  reg = <0 0x25000 0 0x1000>;
>                  interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
> -- 
> 2.18.0
> 
> 
