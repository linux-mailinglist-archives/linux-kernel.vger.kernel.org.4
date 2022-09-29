Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56CF5EEB52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiI2Bzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiI2BzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:55:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DE61B21;
        Wed, 28 Sep 2022 18:55:04 -0700 (PDT)
X-UUID: 4266164f268f4afabd20f67373882c42-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KLeXZkzgR5Ay7eOUvGeW+A2UOiV7iAhJfQA6fiC/fas=;
        b=SHqr0Cunqo5xnMTy2hauXSokoFUcURgPaoM913LTUazCm4o97CKrIJLs3234Cul2LSmmJ/gEA5I7WKKbQA3LlwcufLD31RAv+LAo/QcNTGsHUzbkbAMkwYs59K8SdTIn5BqKcgITpoD3m7TfNWuo3nXw/spYZdWgqpqebgLVVvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8a6505e5-d9de-4399-84a9-3df7d0a4b147,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:35d85e07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4266164f268f4afabd20f67373882c42-20220929
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1924392031; Thu, 29 Sep 2022 09:55:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 09:54:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 09:54:57 +0800
Message-ID: <7d8fb7ea78ae2a850d26bba7b08f621b8494df5e.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Allen-KH Cheng =?UTF-8?Q?=28=E7=A8=8B=E5=86=A0=E5=8B=B3=29?= 
        <Allen-KH.Cheng@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        Irui Wang =?UTF-8?Q?=28=E7=8E=8B=E7=91=9E=29?= 
        <Irui.Wang@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Longfei Wang =?UTF-8?Q?=28=E7=8E=8B=E9=BE=99=E9=A3=9E=29?= 
        <Longfei.Wang@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maoguang Meng =?UTF-8?Q?=28=E5=AD=9F=E6=AF=9B=E5=B9=BF=29?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 29 Sep 2022 09:54:56 +0800
In-Reply-To: <e8bb661ec83129a1c660e876cb4fe9aaad41adfd.camel@mediatek.com>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
         <e8bb661ec83129a1c660e876cb4fe9aaad41adfd.camel@mediatek.com>
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

Hi Irui,

Reviewed-by: Yunfei Dong <yunfei.dong@mediatek.com>

Thanks
Yunfei Dong

On Wed, 2022-09-28 at 21:38 +0800, Allen-KH Cheng (程冠勳) wrote:
> Hi Irui,
> 
> Tested-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> 
> Tested for CTS cases on the mt8186 corsola board.
> 
> Thanks,
> Allen
> 
> On Mon, 2022-09-26 at 17:35 +0800, Irui Wang wrote:
> > The encoder driver support h264 baseline, main, high encoder
> > profile, set mask for V4L2_CID_MPEG_VIDEO_H264_PROFILE to skip
> > the unsupported profile.
> > 
> > get supported h264_profile by command: v4l2-ctl -d /dev/videoX -L
> > h264_profile 0x00990a6b (menu) : min=0 max=4 default=4 value=4
> >         0: Baseline
> >         2: Main
> >         4: High
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > index d810a78dde51..d65800a3b89d 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> > @@ -1397,7 +1397,10 @@ int mtk_vcodec_enc_ctrls_setup(struct
> > mtk_vcodec_ctx *ctx)
> >  			0, V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE);
> >  	v4l2_ctrl_new_std_menu(handler, ops,
> > V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> >  			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> > -			0, V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
> > +			~((1 << V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE)
> > > 
> > 
> > +			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
> > +			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_HIGH)),
> > +			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
> >  	v4l2_ctrl_new_std_menu(handler, ops,
> > V4L2_CID_MPEG_VIDEO_H264_LEVEL,
> >  			       h264_max_level,
> >  			       0, V4L2_MPEG_VIDEO_H264_LEVEL_4_0);

