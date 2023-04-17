Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2374F6E43A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDQJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDQJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:26:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF801FE5;
        Mon, 17 Apr 2023 02:26:33 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F0B76600013;
        Mon, 17 Apr 2023 10:26:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681723592;
        bh=wrJ4ynBY1xVL3ge4ZihlSbCn5HYxZm48w8kZO/CHf+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aon1cpdXhDBwX7d5ZvMHQBNmf4nWFCvOaIxNEnw392rCQ8N+QAUUappXpnjNH/spS
         c+2/Qtt1hFum+eIiX7R/R6B4AXnd2sNM1XytdBijLYZJwb3ZU3Iy2cJyVOxqZYMiXe
         DqSHOPzoamHthEhVteDANAotRsWQaYLYcYy1kPFhrwk+Brznct9PLZywJ1fxqk56Fa
         luZ7b6V4Mzih+0yvJdtrM2yR4IAW99mM1Xohue5d/pPWb8yK5a+han9oNPGMY5+NWF
         j1+OUulcc1SE89UbxURoCD/UclEnepBQ69132uNsy+s0FZUx57UT41z4nmI/rcEuRY
         K5SU1TR5I9AWQ==
Message-ID: <26ac9fbc-cc7a-7f25-0db5-30ede1068501@collabora.com>
Date:   Mon, 17 Apr 2023 11:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/6] media: mediatek: vcodec: add the definition of
 decoder status
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
 <20230417054816.17097-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417054816.17097-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 07:48, Yunfei Dong ha scritto:
> Adding the status used to separate different decoder period for
> core hardware.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> index a5d44bc97c16..19508be08566 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> @@ -21,6 +21,13 @@ struct mtk_vcodec_ctx;
>   struct mtk_vcodec_dev;
>   typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
>   
> +/* current context isn't work */
> +#define CONTEXT_LIST_EMPTY           (0)
> +/* queued to the core work list */
> +#define CONTEXT_LIST_QUEUED          (1)
> +/* context decode done */
> +#define CONTEXT_LIST_DEC_DONE        (2)

I would prefer an enumeration instead; you can keep the documentation for those
status signals with kerneldoc on the new enum.

/**
  * enum core_ctx_status - Context decode status for core hardware
  * @CONTEXT_LIST_EMPTY:    No buffer queued on Core HW (must always be 0)
  * @CONTEXT_LIST_QUEUED:   Buffer queued to the core work list
  * @CONTEXT_LIST_DEC_DONE: Context decode done
  */
enum core_ctx_status {
	CONTEXT_LIST_EMPTY = 0,
	CONTEXT_LIST_QUEUED,
	CONTEXT_LIST_DEC_DONE,
}

Moreover, since this is a rather simple addition, please squash this commit with
patch [3/6] where you actually also introduce the actual usage of the new enum.

Cheers,
Angelo
