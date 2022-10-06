Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCF5F5E54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJFBOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJFBN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:13:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE825B046;
        Wed,  5 Oct 2022 18:13:54 -0700 (PDT)
X-UUID: 660974c1e94240988ab2326e0c6f453d-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=i9WWBc8AgT+qWmWIUrtTH/9MaL3rSQ0+cKCWP1pOwcM=;
        b=AhBW68x6WgauEajqKJiEYqaTCIyfHvXSrjPqMpj9LH8TOoi//o1T6NaS6SBjuFAb+lvFN7daNsVCJrQyzstdDBWEsa+NZo7S6c5+kzZmboSrYf/SKBz2QLgee5/X2bhC5Em7BTL/a9Rv5Hv/L0xrB4SZ349YZ4OL0mdRikNNWLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f3cbe9fc-5b41-449a-a862-e60213f87905,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:f3cbe9fc-5b41-449a-a862-e60213f87905,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:f3f8a4b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:221006091349GWKV8DM5,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 660974c1e94240988ab2326e0c6f453d-20221006
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 693899008; Thu, 06 Oct 2022 09:13:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 09:13:46 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 09:13:46 +0800
Message-ID: <ad18266e7c3234506c850cbefd6c222c359faab3.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mediatek: vcodec: Add the platform
 compatible to schema
From:   Irui Wang <irui.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date:   Thu, 6 Oct 2022 09:13:45 +0800
In-Reply-To: <166479591681.1661748.6265395941647267106.robh@kernel.org>
References: <20221001030752.14486-1-irui.wang@mediatek.com>
         <166479591681.1661748.6265395941647267106.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

Thanks for your reviewing.

On Mon, 2022-10-03 at 08:24 -0500, Rob Herring wrote:
> On Sat, 01 Oct 2022 11:07:52 +0800, Irui Wang wrote:
> > There are venc node warnings when running dtbs_check, the clock-
> > names
> > was unexpected, missing properties '#address-cells' and '#size-
> > cells'.
> > Add the corresponding platform compatible to schema.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12
> > +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for
> dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/

Yes, it's not a new warning, the 'clock-names' in mt8192.dtsi was
already unexpected without the patch's schema, we will fix it in the
future patch.

Thanks
Best Regards
> 
> 
> vcodec@17020000: clock-names:0: 'venc_sel' was expected
> 	arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb
> 	arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb
> 	arch/arm64/boot/dts/mediatek/mt8192-evb.dtb
> 

