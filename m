Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFF5BA39B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIPAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIPAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:54:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA37B4BF;
        Thu, 15 Sep 2022 17:54:38 -0700 (PDT)
X-UUID: fef0eb492a384a77b5197c090c416907-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SyP+UC+nz0mfWD//PcLXFkLh7sU/Z2M1jPcJubN4g1g=;
        b=qsTQyn8fjrX0MNCVO8dcJ0oQQA6TvRY/0oPIkkZ51IzNFBNs37y/+TceN0DgoRoevkrHFSRS5QRlyF77Tcc+CzwQe3tgYAVwNE0KctqBLH6wCHAZGBcT1srD7uKiHRcpac5gYslkoXj364LuVVniHP2sYfQaOO/JK09WpQnWwtM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b7285645-0e43-47fb-ae1c-53b19381c961,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:b7285645-0e43-47fb-ae1c-53b19381c961,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:4edc91f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220916085434J14R123L,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fef0eb492a384a77b5197c090c416907-20220916
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 876420423; Fri, 16 Sep 2022 08:54:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 08:54:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Sep 2022 08:54:31 +0800
Message-ID: <90201cd6f3385350a980f5fb98cb5f26c8aa5757.camel@mediatek.com>
Subject: Re: [PATCH 4/5] arm64: dts: change compatible of vdosys0 and
 vdosys1 for mt8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Singo Chang" <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 16 Sep 2022 08:54:31 +0800
In-Reply-To: <1fd48fa0-66eb-5af9-6168-d1df602216a5@gmail.com>
References: <20220914182331.20515-1-jason-jh.lin@mediatek.com>
         <20220914182331.20515-5-jason-jh.lin@mediatek.com>
         <1fd48fa0-66eb-5af9-6168-d1df602216a5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Hi Matthias,

Thanks for the review.

On Thu, 2022-09-15 at 18:15 +0200, Matthias Brugger wrote:
> 
> On 14/09/2022 20:23, Jason-JH.Lin wrote:
> > For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> > pipelines binding to 1 mmsys with the same power domain, the same
> > clock driver and the same mediatek-drm driver.
> > 
> > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
> > to
> > 2 different power domains, different clock drivers and different
> > mediatek-drm drivers.
> > 
> > Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> > CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
> > Quality)
> > and they makes VDOSYS0 supports PQ function while they are not
> > including in VDOSYS1.
> > 
> > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> > component). It makes VDOSYS1 supports the HDR function while it's
> > not
> > including in VDOSYS0.
> > 
> > To summarize0:
> > Only VDOSYS0 can support PQ adjustment.
> > Only VDOSYS1 can support HDR adjustment.
> > 
> > Therefore, we need to separate these two different mmsys hardwares
> > to
> > 2 different compatibles for MT8195.
> > 
> > Fixes: b852ee68fd72 ("arm64: dts: mt8195: Add display node for
> > vdosys0")
> 
> No fixes tag needed, there is no runtime bug.
> 
> Regards,
> Matthias
> 
OK, I'll remove this.

But I think this dts change should be sent after the vdosys1 series are
accepted.
So I'll drop this dts patch at the next version.

Regards,
Jason-JH.Lin

> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..6ec6d59a16ec 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1966,7 +1966,7 @@
> >   		};
> >   
> >   		vdosys0: syscon@1c01a000 {
> > -			compatible = "mediatek,mt8195-mmsys", "syscon";
> > +			compatible = "mediatek,mt8195-vdosys0",
> > "syscon";
> >   			reg = <0 0x1c01a000 0 0x1000>;
> >   			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
> >   			#clock-cells = <1>;
> > @@ -2101,7 +2101,7 @@
> >   		};
> >   
> >   		vdosys1: syscon@1c100000 {
> > -			compatible = "mediatek,mt8195-mmsys", "syscon";
> > +			compatible = "mediatek,mt8195-vdosys1",
> > "syscon";
> >   			reg = <0 0x1c100000 0 0x1000>;
> >   			#clock-cells = <1>;
> >   		};
> 
> 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

