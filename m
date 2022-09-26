Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A469B5E9A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiIZHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIZHXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:23:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F827B22;
        Mon, 26 Sep 2022 00:23:12 -0700 (PDT)
X-UUID: f424b5f4f30a4eb8b06251011b6e3f5d-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=IqWG+Rd5bDpvf8CcN3vOek+fmkXK/Li6MsYuujgzbAE=;
        b=HEXQ9B4+4SSU5ndOdu+CPN1+JU7Za8penC6q75Vfg7nBrKZYbig9e98l5uHNX3VdnECEX9Z1m30ddxDBA3/UokQIuUL5jbtbTCX6xmbSOhXyzSa2rsdJ1NV20Yihf7QW+/ddvw2MRAW3sNsN1E+CVo6H0aoTuF9bZynsJRGT9TI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:258a6b4a-062a-420e-b115-1e85eb617d77,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:aa9737e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f424b5f4f30a4eb8b06251011b6e3f5d-20220926
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1196096851; Mon, 26 Sep 2022 15:23:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 15:23:06 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Sep 2022 15:23:02 +0800
Message-ID: <63c1962b-26a5-0415-9035-580c2842e67b@mediatek.com>
Date:   Mon, 26 Sep 2022 15:23:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] media: mediatek: venc: Add h264 extended profile support
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
References: <20220915115135.7271-1-allen-kh.cheng@mediatek.com>
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
In-Reply-To: <20220915115135.7271-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello, maintainers

kindly disregard this patch.

The MTK HW encoder does not yet support this. (only sw)

Thanks,
Allen

On 9/15/22 19:51, Allen-KH Cheng wrote:
> Add h264 extended profile support
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Co-developed-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 13c4f860fa69..ac2ef6275d78 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -243,8 +243,7 @@ static unsigned int h264_get_profile(struct venc_h264_inst *inst,
>  		mtk_vcodec_err(inst, "unsupported CONSTRAINED_BASELINE");
>  		return 0;
>  	case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:
> -		mtk_vcodec_err(inst, "unsupported EXTENDED");
> -		return 0;
> +		return 88;
>  	default:
>  		mtk_vcodec_debug(inst, "unsupported profile %d", profile);
>  		return 100;
