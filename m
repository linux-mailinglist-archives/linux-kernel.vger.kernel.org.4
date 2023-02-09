Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E1690F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBIRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:43:11 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A75ACFE;
        Thu,  9 Feb 2023 09:43:10 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1636eae256cso3606642fac.0;
        Thu, 09 Feb 2023 09:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmWeTxm3eAR69llILe3yLFx61s6S09dltEYFO6LRpqs=;
        b=wzaCVzm1MSB1/SEuFhlCKyOM6sTpL4AMEu+aIJd6+64/abw8FSD6xU/+1t2EQ1zEss
         AZm8yttj3KT6VWFpewWlKc5QNHV9slH8/mx+Bl6Nbjaw+4gKcgaZiAXDXaHg+elE6CQG
         B8CmOgL9Hfk4XrXuHmlI8pGVNVSv8gp7VopwCWHlyS1BCMf5HrikyinAVWXITvRj0OOd
         5y5ioFrn7mr/vJi7+RH/erMsHeUPOJACBTmZ+tulwrZbK+BRT6HIMviFFHZJev0joD5V
         cZsCBXUcJUkAIz7dPy+vu6t//Bxr4bU/tH1OKUwFGDIpmxMeuem9xaSXOMhhn3pRXfYH
         5PtA==
X-Gm-Message-State: AO0yUKUJ9QGIVRkzGipKPRfW6qrYc+J1UiYQIknJ6HJzngwtYGGruNO0
        xl94uqqDxjcNS2md19zWeA==
X-Google-Smtp-Source: AK7set9i8Yc0as8tcS+G5ABFmialaz9E/t1quo/d+glus4OAQlGXNCIBfTxURc1sXvd6sOHL45g/YQ==
X-Received: by 2002:a05:6870:a11d:b0:163:d167:80bc with SMTP id m29-20020a056870a11d00b00163d16780bcmr2886406oae.49.1675964590032;
        Thu, 09 Feb 2023 09:43:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ky15-20020a056871404f00b0014fc049fc0asm900969oab.57.2023.02.09.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:43:09 -0800 (PST)
Received: (nullmailer pid 553172 invoked by uid 1000);
        Thu, 09 Feb 2023 17:43:08 -0000
Date:   Thu, 9 Feb 2023 11:43:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-media@vger.kernel.org,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        youlin.pei@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        chengci.xu@mediatek.com, mingyuan.ma@mediatek.com,
        devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
        iommu@lists.linux.dev, libo.kang@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        yf.wang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, nfraprado@collabora.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Message-ID: <167596458765.553111.2698863120254622830.robh@kernel.org>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
 <20230208053643.28249-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208053643.28249-2-yong.wu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 13:36:34 +0800, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges of the leaf node doesn't work. Remove
> it for vcodec here.
> 
> 1) For mediatek,vcodec-decoder.yaml and mediatek,vcodec-encoder.yaml,
> this property is in the leaf node, it is invalid as the above comment.
> 
> Currently there is only mt8195 VENC node has this property in upstream.
> Indeed, VENC is affected, but it is not a fatal issue. Originally it
> expects its iova range locate at 4GB-8GB. However after that commit, its
> expectation doesn't come true, it will fall back to 0-4GB iova and also
> could work well.
> 
> 2) For mediatek,vcodec-subdev-decoder.yaml, It already uses parent-child
> node, this property works. Instead, MediaTek iommu will control the
> masters' iova ranges by the master's larb/port id internally, then the
> dma-ranges property is unnecessary for the master's node.
> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  3 files changed, 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

