Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2B63FC5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLAX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAX5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:57:37 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CCF1B;
        Thu,  1 Dec 2022 15:57:34 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id t62so3740202oib.12;
        Thu, 01 Dec 2022 15:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGjAfESow6+4+ffZdaTFVv+WtGA9rt5Tc3vc+VeK/lU=;
        b=GGRr7q4bVAOSgCTGCLNAosdmXxCuUV9a5f5IDQeknZ/AQqlR1k3nmGbcYdouay4Dly
         EUg+jWw/v2IGrSusv8eR0FmFbkzjwesWO5EfSlueO+gRf2+tMVsfPVokF1Wc5DtluUf9
         0R6CgkJn09ONHYsN0ErRLlGQp17VYX58H3zdesdhO2NAWePRhmgz4jVywFp5CvLc6nZF
         2KQbV+eZViTBKda5YfdXHbbV6/YlaPVUQc1hxJBme3xqmeYrI0gowA21tQPBkF+1jG8h
         ReuxGfk9JIn3FABL6Vm3TGhIZY5L/xWbeLnM21bvApt8hFNwBk1CU+lxRrBrS9nJWIpU
         +znA==
X-Gm-Message-State: ANoB5pnBym9PJjAxZS9UeozcAYFSJEaKflFSfCKYHClCQn99RIwV8kDG
        oFckvSEkDCfeqhi742gnoQ==
X-Google-Smtp-Source: AA0mqf4x71P/cAMC4DADS7DjF+bxxae/KaWzMASeyQYj1p6he19Sq612XtNSF3yVmq/PoVjNDHksOQ==
X-Received: by 2002:aca:4285:0:b0:354:893b:7004 with SMTP id p127-20020aca4285000000b00354893b7004mr35969032oia.50.1669939050467;
        Thu, 01 Dec 2022 15:57:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y204-20020aca32d5000000b00359b83e3df1sm2407880oiy.9.2022.12.01.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:57:29 -0800 (PST)
Received: (nullmailer pid 1719312 invoked by uid 1000);
        Thu, 01 Dec 2022 23:57:29 -0000
Date:   Thu, 1 Dec 2022 17:57:29 -0600
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
Subject: Re: [PATCH v3,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Message-ID: <20221201235729.GA1718283-robh@kernel.org>
References: <20221201121525.30777-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201121525.30777-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 08:15:22PM +0800, Yunfei Dong wrote:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> 
> mt8195 and mt8192 have different clock numbers, can't write 'clocks' and
> 'clock-names' with const value.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> Reference series:
> [1]: v5 of this series is presend by Allen-KH Cheng.
>      message-id: 20221128143832.25584-4-allen-kh.cheng@mediatek.com
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml   | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index 7c5b4a91c59b..09781ef02193 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -110,15 +110,12 @@ patternProperties:
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

Names need to be defined. This is a step backwards.

Rob

>  
>        assigned-clocks:
>          maxItems: 1
> -- 
> 2.18.0
> 
> 
