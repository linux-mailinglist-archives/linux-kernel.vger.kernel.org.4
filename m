Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C349747093
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGDMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGDMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:13:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E3170E;
        Tue,  4 Jul 2023 05:13:09 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 740D26606FA2;
        Tue,  4 Jul 2023 13:13:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688472781;
        bh=tOFsOkcAsXmj1UCEfgpXX2h+aSRe7EftJRLlt/+7qCM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AqsedoFSQYO55RmHLaK9GtLwH9m86sxbuLzsekqXEx0ge9WgPfnMXfvn3zOoHefXy
         B92+hXz0eD3Nc5h88FO6XmqWsGEQgkt2ChG62SxbKtH0vcy2Zwcwn4Uv5YS1oNpsQ0
         35jnahbhJZ2lBQeYl3NxI75CKGQOcImnkCv+NEoKI0jtXxdoFY8/IylnO1LXmvh4s7
         Zi5ZJMbTjPG5hK6+B40SJ0LsuTRWsHLMQZ96XD5g0IsHO0yZJ/++/zsjkCqOIAZtQh
         hzSV+ZElglbGPBg8JhAduKjAF55bGZnmhRVeFJcz2jIoqmKxPjbYG7Gm6QpJbDW3Dw
         6rzUjawzzDF0w==
Message-ID: <c3b46f84-9257-0996-9be9-4db78f311395@collabora.com>
Date:   Tue, 4 Jul 2023 14:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5,03/11] media: mediatek: vcodec: Removing struct
 'mtk_vcodec_ctx/dev' for shared interface
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230704111327.7140-1-yunfei.dong@mediatek.com>
 <20230704111327.7140-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230704111327.7140-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/07/23 13:13, Yunfei Dong ha scritto:
> The shared struct 'mtk_vcodec_ctx/dev' will be changed to 'mtk_vcodec_enc_ctx/dev'
> and 'mtk_vcodec_dec_ctx/dev' in order to separate encoder and decoder. Removing
> common struct 'mtk_vcodec_ctx/dev' for shared interface which encoder and decoder
> used at the same time. Then encoder and decoder can call the same interface
> independently.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_intr.c         | 30 ++++++++++++-------
>   .../mediatek/vcodec/mtk_vcodec_intr.h         |  3 +-
>   .../mediatek/vcodec/mtk_vcodec_util.c         | 19 +++++-------
>   .../mediatek/vcodec/mtk_vcodec_util.h         |  9 ++----
>   .../mediatek/vcodec/vdec/vdec_vp8_if.c        | 16 +++++-----
>   .../mediatek/vcodec/venc/venc_h264_if.c       |  2 +-
>   .../mediatek/vcodec/venc/venc_vp8_if.c        |  2 +-
>   7 files changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> index 552b4c93d972..daa44f635727 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> @@ -11,32 +11,40 @@
>   #include "mtk_vcodec_intr.h"
>   #include "mtk_vcodec_util.h"
>   
> -int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx *ctx,
> -				 int command, unsigned int timeout_ms,
> +int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
>   				 unsigned int hw_id)
>   {
> +	struct mtk_vcodec_ctx *ctx = priv;
>   	long timeout_jiff, ret;
> -	int status = 0;
> +	int status = 0, ctx_id, ctx_type;

Only one nitpick here, but nothing critical: please order variables by name.

	int ctx_id, ctx_type, status = 0;

after which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


