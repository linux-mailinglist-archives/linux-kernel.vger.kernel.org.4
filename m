Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3605C604517
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiJSMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiJSMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:19:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F565668;
        Wed, 19 Oct 2022 04:55:22 -0700 (PDT)
X-UUID: 9e2244b9f5e1430cbb49fe1ac3ce02b5-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=F+3N5jdI5Vdo+TGFz2Tt3Kx3wcLZK4tfh0R6kaTzfo4=;
        b=PjTvdmEHWiqw09J54bOAxr1dmCDvPJISe4/WmVzzTmy5hNfTZ22RP0DMYxSQunnyICJEYduLDEr+nrt+ZSLaCD+Vf+fWvG1hG+tfrEH40/aTzC9dII87b5bK3XosHeM9kzlV7tqv8JoNvMYN5T1ltkY+UGPM/C1AffgYpM0dC4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e22817f7-e0fa-4f0c-95dd-0fb874ae3dbf,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.12,REQID:e22817f7-e0fa-4f0c-95dd-0fb874ae3dbf,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:62cd327,CLOUDID:37c34aa3-73e4-48dd-a911-57b5d5484f14,B
        ulkID:2210191807288342RCAR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0
X-UUID: 9e2244b9f5e1430cbb49fe1ac3ce02b5-20221019
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 318839224; Wed, 19 Oct 2022 18:07:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Oct 2022 18:07:26 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Oct 2022 18:07:25 +0800
Message-ID: <d264de2367a777e310b0824fb2e04bfb37d46d3d.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 19 Oct 2022 18:07:25 +0800
In-Reply-To: <20220926093501.26466-1-irui.wang@mediatek.com>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,

Gently ping for this patch, could you help to review this patch?

Thanks
Best Regards

On Mon, 2022-09-26 at 17:35 +0800, Irui Wang wrote:
> The encoder driver support h264 baseline, main, high encoder
> profile, set mask for V4L2_CID_MPEG_VIDEO_H264_PROFILE to skip
> the unsupported profile.
> 
> get supported h264_profile by command: v4l2-ctl -d /dev/videoX -L
> h264_profile 0x00990a6b (menu) : min=0 max=4 default=4 value=4
>         0: Baseline
>         2: Main
>         4: High
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index d810a78dde51..d65800a3b89d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -1397,7 +1397,10 @@ int mtk_vcodec_enc_ctrls_setup(struct
> mtk_vcodec_ctx *ctx)
>  			0, V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE);
>  	v4l2_ctrl_new_std_menu(handler, ops,
> V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>  			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> -			0, V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
> +			~((1 << V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE)
> |
> +			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
> +			  (1 << V4L2_MPEG_VIDEO_H264_PROFILE_HIGH)),
> +			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
>  	v4l2_ctrl_new_std_menu(handler, ops,
> V4L2_CID_MPEG_VIDEO_H264_LEVEL,
>  			       h264_max_level,
>  			       0, V4L2_MPEG_VIDEO_H264_LEVEL_4_0);

