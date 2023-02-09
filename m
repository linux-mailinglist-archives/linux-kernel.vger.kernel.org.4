Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A5690F73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBIRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:45:55 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C35ACFB;
        Thu,  9 Feb 2023 09:45:54 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id s17so2272398ois.10;
        Thu, 09 Feb 2023 09:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DrSTVU0MouuPAPgDnH3bvO6W0mBoIKC+iPYe6f7yQ8=;
        b=NvYDTBDPFa+6x9dhLyqEGqjSMWeuiIG/34HvcJwFBCJ/L/Hj49cz8bs3XJhBrUqI9s
         fCic/siVexNp1kG9kdSx7CAD5fde313O1vj67erhWVXGJH/oLOHf1SaC5l1AOyW2Zseq
         r51T7trudUBB/f5lu/TAzi2dTF8oiwNf93iS199UECKyo+ksIpW/UJNv5RHZxAvOtp9f
         fMbElOL3OldJOWUVyedlvZYnbreRyFDJs789SGjcIaag7j93de1BXw8kqwktzle1bKED
         9DBIxYOH+xYAmP+xf9Mrvn6UH9MXzq4ZJonSXZwe+uQqwoK2yvgsAiLKDDSORxE6hCeP
         +3OA==
X-Gm-Message-State: AO0yUKXqlptBurg3XLppvjaIU5HwKRRqBoEfL1B2br5clXe7JXHsr0/c
        48mfUe9Wm/dv0RCy4OsqNg==
X-Google-Smtp-Source: AK7set9jyx6LMJhbcKNlh1fXP27jxIMoQEJ+KUbwmEZRPY53UW1ny3huB384noPvethCecih31RSAw==
X-Received: by 2002:a05:6808:279a:b0:37b:3177:65c with SMTP id es26-20020a056808279a00b0037b3177065cmr5747500oib.28.1675964753686;
        Thu, 09 Feb 2023 09:45:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a0568301dae00b0068d56f93d73sm973117oti.26.2023.02.09.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:45:53 -0800 (PST)
Received: (nullmailer pid 556291 invoked by uid 1000);
        Thu, 09 Feb 2023 17:45:52 -0000
Date:   Thu, 9 Feb 2023 11:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     anan.sun@mediatek.com, Xia Jiang <xia.jiang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, yf.wang@mediatek.com,
        chengci.xu@mediatek.com, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Yunfei Dong <yunfei.dong@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
        Joerg Roedel <joro@8bytes.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        libo.kang@mediatek.com,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        youlin.pei@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        nfraprado@collabora.com, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Bin Liu <bin.liu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/10] dt-bindings: media: mediatek,jpeg: Remove
 dma-ranges property
Message-ID: <167596475165.556224.15663986433586946843.robh@kernel.org>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
 <20230208053643.28249-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208053643.28249-3-yong.wu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 13:36:35 +0800, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges of the leaf node doesn't work. Remove
> it for jpeg here.
> 
> Currently there is only mt8195 jpeg node has this property in upstream,
> and it already uses parent-child node, this property did work. But instead,
> MediaTek iommu will control the masters' iova ranges by the master's
> larb/port id internally, then this property is unnecessary.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Bin Liu <bin.liu@mediatek.com>
> Cc: kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> Cc: Xia Jiang <xia.jiang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml   | 5 -----
>  3 files changed, 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

