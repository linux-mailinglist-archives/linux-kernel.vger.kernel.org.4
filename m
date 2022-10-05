Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B95F4D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJEBxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJEBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:53:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E467CB7;
        Tue,  4 Oct 2022 18:53:40 -0700 (PDT)
X-UUID: 2923a7fd4cf9447da0a843c5e09a98b5-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gy2ytux/w9C0XwgNd3GjCzaa+hUjmK54OfaiP6kcO8Y=;
        b=cO4F98n9Z4Yc82zW8McCfo9Lmx6W0A/emsk8HeQLBOwcJk/UO45fc3nA+TKZSmQm8V2OJgdREtLTNSjx4voEitqoFSfPnXhTZeacuIg+VUkzkljwIx5Vg3L7/GGzvbcg4iYNRobz3kvv0q0dYwCopJoCgW5pWUK8D0usQaSWC+8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c746b624-2acd-484a-802d-e3f5ebf2a706,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:c746b624-2acd-484a-802d-e3f5ebf2a706,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:229286b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:221004194715I64JRJ3D,BulkQuantity:69,Recheck:0,SF:38|28|17|19|48|823
        |824|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:
        nil,COL:0
X-UUID: 2923a7fd4cf9447da0a843c5e09a98b5-20221005
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2115336132; Wed, 05 Oct 2022 09:53:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 5 Oct 2022 09:53:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 5 Oct 2022 09:53:34 +0800
Message-ID: <f6d231ca6e8fbd4e9340e6fff363b29e405efba1.camel@mediatek.com>
Subject: Re: [PATCH v1 2/6] dts: arm64: mt8195: add MMSYS and MUTEX
 configuration for VPPSYS
From:   moudy ho <moudy.ho@mediatek.com>
To:     Allen-KH Cheng =?UTF-8?Q?=28=E7=A8=8B=E5=86=A0=E5=8B=B3=29?= 
        <Allen-KH.Cheng@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "Roy-CW Yeh =?UTF-8?Q?=28=E8=91=89=E4=B8=AD=E7=91=8B=29?=" 
        <Roy-CW.Yeh@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 5 Oct 2022 09:53:34 +0800
In-Reply-To: <c80af435ec4fec9419c47a73c0bda112ef62c76d.camel@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
         <20221004093319.5069-3-moudy.ho@mediatek.com>
         <c80af435ec4fec9419c47a73c0bda112ef62c76d.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-04 at 19:46 +0800, Allen-KH Cheng (程冠勳) wrote:
> Hi Moudy,
> 
> On Tue, 2022-10-04 at 17:33 +0800, Moudy Ho wrote:
> > From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> > 
> > Compatible names of VPPSYS0 and VPPSYS1 should be renamed to
> > "mediatek,mt8195-mmsys" to match the description of the binding
> > file.
> > Also, add two nodes for MT8195 VPPSYS0/1 MUTEX.
> > 
> > Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 22
> > ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..7f54fa7d0185 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1477,11 +1477,20 @@
> >  		};
> >  
> >  		vppsys0: clock-controller@14000000 {
> > -			compatible = "mediatek,mt8195-vppsys0";
> > +			compatible = "mediatek,mt8195-mmsys";
> >  			reg = <0 0x14000000 0 0x1000>;
> > +			mediatek,gce-client-reg = <&gce1
> > SUBSYS_1400XXXX 0 0x1000>;
> >  			#clock-cells = <1>;
> >  		};
> >  
> 
> I run "ARCH=arm64 make dtbs check" and some of the tests failed.
> 
> The node name should be 'syscon' from mediatek/mediatek,mmsys.yaml.
> 
> 
> > +		vpp0-mutex@1400f000 {
> > +			compatible = "mediatek,mt8195-vpp-mutex";
> > +			reg = <0 0x1400f000 0 0x1000>;
> > +			mediatek,gce-client-reg = <&gce1
> > SUBSYS_1400XXXX 0xf000 0x1000>;
> > +			clocks = <&vppsys0 CLK_VPP0_MUTEX>;
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_VPPSYS0>;
> > +		};
> > +
> 
> 'interrupts' is a required property from mediatek/mediatek,mutex.yaml
> 
> 
> >  		smi_sub_common_vpp0_vpp1_2x1: smi@14010000 {
> >  			compatible = "mediatek,mt8195-smi-sub-common";
> >  			reg = <0 0x14010000 0 0x1000>;
> > @@ -1582,11 +1591,20 @@
> >  		};
> >  
> >  		vppsys1: clock-controller@14f00000 {
> > -			compatible = "mediatek,mt8195-vppsys1";
> > +			compatible = "mediatek,mt8195-mmsys";
> >  			reg = <0 0x14f00000 0 0x1000>;
> > +			mediatek,gce-client-reg = <&gce1
> > SUBSYS_14f0XXXX 0 0x1000>;
> 
> Node name: syscon.
> 
> >  			#clock-cells = <1>;
> >  		};
> >  
> > +		vpp1-mutex@14f01000 {
> > +			compatible = "mediatek,mt8195-vpp-mutex";
> > +			reg = <0 0x14f01000 0 0x1000>;
> > +			mediatek,gce-client-reg = <&gce1
> > SUBSYS_14f0XXXX 0x1000 0x1000>;
> > +			clocks = <&vppsys1 CLK_VPP1_DISP_MUTEX>;
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_VPPSYS1>;
> > +		};
> > +
> 
> 'interrupts' is a required property
> 
> Thanks,
> Allen
> 

Hi Allen,

Apologies for the failed test, I'll check again by adding dtsb_check
instead of just dt_binding_check .

Thanks & Regards,
Moudy

> >  		larb5: larb@14f02000 {
> >  			compatible = "mediatek,mt8195-smi-larb";
> >  			reg = <0 0x14f02000 0 0x1000>;
> 
> 
> 

