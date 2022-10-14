Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926A5FE719
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJNCoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:44:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BC199881;
        Thu, 13 Oct 2022 19:44:02 -0700 (PDT)
X-UUID: b007fd38c9cf4a86bd3823f177881081-20221014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3ZSRu1BKoFGBPwJxlPjZlBplZCmEr25chXpohl79YHY=;
        b=QKzz681/xETVcUO6INd0YbeG/2dgCaBBvT7OwcY2DhXHi7GzbQS8l521cc6C47AvJ4g97hqyVEER/ZuXpmZ+//R9KD0WJirj7cuE3WTUiQX6iwJ4dfQs0lAc+U3nZT8pKlmd5oJ3BatqSSyqRueVfmHgtXZP3Lt9lkrsIdFEHAA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9829d6c1-1a7a-4d40-91a6-e7f8b270bb4f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.11,REQID:9829d6c1-1a7a-4d40-91a6-e7f8b270bb4f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:39a5ff1,CLOUDID:dcd03dff-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221014104359Q88IPLS4,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: b007fd38c9cf4a86bd3823f177881081-20221014
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2051037660; Fri, 14 Oct 2022 10:43:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 14 Oct 2022 10:43:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 14 Oct 2022 10:43:55 +0800
Message-ID: <3b7fc7414f282ca044c24dae280f9bc9533a5b7b.camel@mediatek.com>
Subject: Re: [PATCH 6/8] arm64: dts: mt2712-evb: Fix usb vbus regulators
 unit names
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sam.shih@mediatek.com>, <hanks.chen@mediatek.com>,
        <weiyi.lu@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <andrew-sh.cheng@mediatek.com>, <viresh.kumar@linaro.org>,
        <fparent@baylibre.com>, <mars.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Oct 2022 10:43:55 +0800
In-Reply-To: <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
         <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-13 at 17:22 +0200, AngeloGioacchino Del Regno wrote:
> Update the names to regulator-usb-p{0-3}-vbus to fix
> unit_address_vs_reg
> warnings for those.
> 
> Fixes: 1724f4cc5133 ("arm64: dts: Add USB3 related nodes for MT2712")
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> index 638908773706..d31a194124c9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> @@ -50,7 +50,7 @@ extcon_usb1: extcon_iddig1 {
>  		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
>  	};
>  
> -	usb_p0_vbus: regulator@2 {
> +	usb_p0_vbus: regulator-usb-p0-vbus {
Can we modify dt-binding of fixed regulator instead of changing the
node name,
since all nodes using fixed regulator may need be changed.

>  		compatible = "regulator-fixed";
>  		regulator-name = "p0_vbus";
>  		regulator-min-microvolt = <5000000>;
> @@ -59,7 +59,7 @@ usb_p0_vbus: regulator@2 {
>  		enable-active-high;
>  	};
>  
> -	usb_p1_vbus: regulator@3 {
> +	usb_p1_vbus: regulator-usb-p1-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "p1_vbus";
>  		regulator-min-microvolt = <5000000>;
> @@ -68,7 +68,7 @@ usb_p1_vbus: regulator@3 {
>  		enable-active-high;
>  	};
>  
> -	usb_p2_vbus: regulator@4 {
> +	usb_p2_vbus: regulator-usb-p2-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "p2_vbus";
>  		regulator-min-microvolt = <5000000>;
> @@ -77,7 +77,7 @@ usb_p2_vbus: regulator@4 {
>  		enable-active-high;
>  	};
>  
> -	usb_p3_vbus: regulator@5 {
> +	usb_p3_vbus: regulator-usb-p3-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "p3_vbus";
>  		regulator-min-microvolt = <5000000>;

