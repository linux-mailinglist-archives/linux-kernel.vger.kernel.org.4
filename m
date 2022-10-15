Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CE5FF834
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJODZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJODZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:25:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5798F43E4A;
        Fri, 14 Oct 2022 20:25:28 -0700 (PDT)
X-UUID: b8006f60a9b14c6f84927f96d07ad544-20221015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DWjBZCkykQbBc1ryP13P2V1hr38xsz+ryzAbDiTxDkw=;
        b=gWajdWnJGrqJzQ6YV77ZpyNOzAWE43yaTRMwh7Kh4p5CsjPZyDWFqZmjmrmf2qwWQk3R+x1utJ58NOwgwTijRccrQ0X/D3+MSPh4U/yJkf/54Qu4SH7cyAr1cytPGKBz/OUu822vmqx4Jlzf2EOM29S1GX26dLb0k/xGYpESXxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:94740b9f-d071-4607-b69f-10a70dccd607,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:2f72d5a3-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b8006f60a9b14c6f84927f96d07ad544-20221015
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 745707071; Sat, 15 Oct 2022 11:25:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 15 Oct 2022 11:25:22 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 15 Oct 2022 11:25:21 +0800
Message-ID: <5bd2c5d63cde6fdf8e92d6aa385687b1369922ad.camel@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
From:   Yong Wu <yong.wu@mediatek.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-mediatek@lists.infradead.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux.dev>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 15 Oct 2022 11:25:21 +0800
In-Reply-To: <20221001-iommu-support-v4-1-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
         <20221001-iommu-support-v4-1-f1e13438dfd2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 10:45 +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
>  .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90
> ++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b5098..4b8cf3ce6963 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -81,6 +81,7 @@ properties:
>            - mediatek,mt8195-iommu-vdo        # generation two
>            - mediatek,mt8195-iommu-vpp        # generation two
>            - mediatek,mt8195-iommu-infra      # generation two
> +          - mediatek,mt8365-m4u  # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -130,6 +131,7 @@ properties:
>        dt-binding/memory/mt8186-memory-port.h for mt8186,
>        dt-binding/memory/mt8192-larb-port.h for mt8192.
>        dt-binding/memory/mt8195-memory-port.h for mt8195.
> +      dt-binding/memory/mt8365-larb-port.h for mt8365.

"mediatek," is needed here.

After this:
Reviewed-by: Yong Wu <yong.wu@mediatek.com>


