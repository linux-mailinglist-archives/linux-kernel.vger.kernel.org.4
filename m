Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91382606FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJUGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJUGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:15:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952135B107;
        Thu, 20 Oct 2022 23:15:12 -0700 (PDT)
X-UUID: 77a61b48e71f48e2ab7ad39378d2f05d-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ExRKeO+TK0hJ0ZPupJS/yMOY5pv1f1TbfMj7UR2BrL0=;
        b=YdprMySo6ZdI9cBJd5yH06FPis4ElBPvUVWhJ3uDVFnoU6NMnKq3I/LQhwgPUZlFlizqH6vDB27ytg5X3fOdtl7VSWDCWLUgf3L2WSYnh5CRaR+RPY6rbTYO4OohndrGcqY1/BtDS8WoMWcyxh4T81uSWKIuLVKKh8gBgnA2Jf8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:5d1a073c-e50e-4bdb-bc51-d6bd9e086b01,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.12,REQID:5d1a073c-e50e-4bdb-bc51-d6bd9e086b01,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:62cd327,CLOUDID:4e29a86c-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:221021095633ASB2EHFK,BulkQuantity:7,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 77a61b48e71f48e2ab7ad39378d2f05d-20221021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1255428266; Fri, 21 Oct 2022 14:15:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 14:14:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 21 Oct 2022 14:14:58 +0800
Message-ID: <a24326d0a454082ab532025ae52462757d4d6bab.camel@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: mediatek: tphy: add compatible
 for tphy-v4
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Fri, 21 Oct 2022 14:14:58 +0800
In-Reply-To: <07c5d962515c4f675f076bb91d69eaf651b187c6.1666193782.git.daniel@makrotopia.org>
References: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
         <07c5d962515c4f675f076bb91d69eaf651b187c6.1666193782.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-19 at 16:38 +0100, Daniel Golle wrote:
> V4 can be found in MT7986 and MT7981 SoCs, it supports PCIe with two
> lanes.
NAK.

mt7981/mt7986 shall use "mediatek,generic-tphy-v2" instead.

Thanks a lot

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 5613cc5106e32f..851e3dda7b638b 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -89,6 +89,11 @@ properties:
>                - mediatek,mt8188-tphy
>                - mediatek,mt8195-tphy
>            - const: mediatek,generic-tphy-v3
> +      - items:
> +          - enum:
> +              - mediatek,mt7981-tphy
> +              - mediatek,mt7986-tphy
> +          - const: mediatek,generic-tphy-v4
>        - const: mediatek,mt2701-u3phy
>          deprecated: true
>        - const: mediatek,mt2712-u3phy
> @@ -99,7 +104,7 @@ properties:
>      description:
>        Register shared by multiple ports, exclude port's private
> register.
>        It is needed for T-PHY V1, such as mt2701 and mt8173, but not
> for
> -      T-PHY V2/V3, such as mt2712.
> +      T-PHY V2/V3/V4, such as mt2712.
>      maxItems: 1
>  
>    "#address-cells":

