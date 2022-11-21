Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB36325B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKUOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKUOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:24:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB0C78C0;
        Mon, 21 Nov 2022 06:23:49 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C56C66029A5;
        Mon, 21 Nov 2022 14:23:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669040627;
        bh=qAqjbzpbzCYGde1jIuieXfGh7bGscq+1ycAIsLP/zNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nK9ZpmCXTjn3GTesP6VNlKCUdzpDPq2OVuLGTuvoGh9Rz0e1lUAoU5/fSW2nDIcSr
         iHuFvw5dFgctCnrJ+t69CmCYlkXcevxE571PCb/dn0Ig944ebNZrXCko9kH2HeeDZ2
         2Eit+koI7BosESKUHAfyzS8dpPbTiW+RDT0g4mIu4/dsTte8WX4RAXw4VppzBEcPFY
         +SA7GiqmyhqGtK8iZNgrulWqybgpNBbWtf8bwMDcL9tZpo6PtB62BkI2ehT2ieegxX
         UlufwjLgmVeQCRh5jOjMR/4MMHVEoe09sitpvhOhyEn9P6+4rCGTV/rONU01M8tMaS
         yN+1j0lMOeq0Q==
Date:   Mon, 21 Nov 2022 09:23:40 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Message-ID: <20221121142340.kpdak6lkicag6qtz@notapiano>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
 <20220930112237.14411-3-allen-kh.cheng@mediatek.com>
 <20221118141039.y2ap7dzdp26ih2la@notapiano>
 <5bb52e10002be4ea00ccb97d08235ebb97161756.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb52e10002be4ea00ccb97d08235ebb97161756.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:30:37PM +0000, Allen-KH Cheng (程冠勳) wrote:
> Hi Nícolas,
> 
> On Fri, 2022-11-18 at 09:10 -0500, Nícolas F. R. A. Prado wrote:
> > On Fri, Sep 30, 2022 at 07:22:37PM +0800, Allen-KH Cheng wrote:
> > > Add vcodec lat and core nodes for mt8192 SoC.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60
> > > ++++++++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 6b20376191a7..92a20f87468b 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -1449,6 +1449,66 @@
> > >  			power-domains = <&spm
> > > MT8192_POWER_DOMAIN_ISP2>;
> > >  		};
> > >  
> > > +		vcodec_dec: video-codec@16000000 {
> > > +			compatible = "mediatek,mt8192-vcodec-dec";
> > > +			reg = <0 0x16000000 0 0x1000>;
> > > +			mediatek,scp = <&scp>;
> > > +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> > > +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0
> > > 0xfff00000>;
> > 
> > Hi,
> > 
> > since commit 951d48855d86 ("of: Make of_dma_get_range() work on bus
> > nodes") [1]
> > was merged this no longer works as is. Running the fluster codec
> > tests results
> > in IOMMU faults:
> > 
> > 	[  386.233976] mtk-iommu 1401d000.m4u: fault type=0x280
> > iova=0x1fcdc0000 pa=0x0 master=0x500041c(larb=4 port=7) layer=0 read
> > 	[  386.250666] mtk_vdec_worker(),241:
> > [MTK_V4L2][ERROR]  <===[138], src_buf[0] sz=0x298 pts=0
> > vdec_if_decode() ret=1 res_chg=0===>
> > 
> > The issue is that the DMA configuration supplied by dma-ranges is now
> > looked for
> > in the parent node, so the vcodec_dec node no longer gets the
> > configuration it
> > expected.
> > 
> > That said, given that the node already uses the IOMMU for the address
> > translations (iommus property), there shouldn't even be a dma-ranges
> > property.
> > Indeed simply removing the dma-ranges property from this node fixes
> > the issue
> > and gets the decoder working again.
> > 
> > Thanks,
> > Nícolas
> > 
> > [1] 
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1ad5338a4d57fe1fe6475003acb8c70bf9d1bdf__;!!CTRNKA9wMg0ARbw!xdhhnvXMY5-BjI2BXPHQI-Hw8zgtZ1lvFyFFv7KtNuCDxW17VC7RqAaW9B_uXsQucT1sLk_DUl-c99ijF9dF8QXbJQ$
> >  
> 
> Noted!
> 
> The paret node should be
> 
> vcodec_dec: video-codec@16000000 {
> 	compatible = "mediatek,mt8192-vcodec-dec";
> 	reg = <0 0x16000000 0 0x1000>;
> 	mediatek,scp = <&scp>;
> 	iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> 	#address-cells = <2>;
> 	#size-cells = <2>;
> 	ranges = <0 0 0 0x16000000 0 0x26000>;
> 	
> 	video-codec-lat@10000 {
> ...
> 
> }
> 
> Am I right?

Yes, that's right.

Thanks,
Nícolas
