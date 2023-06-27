Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2391973FA83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjF0KwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjF0KwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:52:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7970A19B6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:52:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a01so24731535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687863138; x=1690455138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jzgUmPtDckjPjLRU4tkkXjGSRq5oebZ+7T9Ga97pVo=;
        b=gVu12ykoJNZslQJiM2LybmO7MRbFsLBty/USTfmKdXu+iTFqXWKzFlwtyKat9TX90P
         2oLcIpIawyiQxYl6pnNYmkec5YXDhbtUxp/5uWAR+fpVrts+7mqHxUIcfx4bnqFU0kIJ
         JRX7m2rRqsjk8GS/4ocQFaiF9bs3x4OfQw/Cj5KF/qnsh6JhvQXx1WS0oGAMSb51nH+j
         B7+w8lN+EcVhL6BTqM63v96t+QRnjj/x9YgstfO+nkMtNjPj0I5mRK5OGFc6pCJ1ta6P
         iBqjAq6qA3vxGSm6bcUxqFrFMnouOVds9as6hRlhfVNEz0D8l5D28VRDFpyz6sBmzDeo
         DjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863138; x=1690455138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jzgUmPtDckjPjLRU4tkkXjGSRq5oebZ+7T9Ga97pVo=;
        b=QXfbfoIHpa6PwpFYwT1UVRoYHP1sHXAzWKdpvM427aO4fbseDlbeyyS5TgyAh1rHgp
         fWI+dWHTxZcry2p1NL2bIyZImvJw/E0vOMmkY1QwAUZtpPw3tNHX1MZcDkgq8mmQDBJ3
         VkxcOu84w91dF0pnXeMuLgD0WX86Dl4fwE6cJQGo8BWVtnrpQTiHnXu1rbLRU+xnXvWA
         i9RDjON7dwRLiakowwYi7eGX+qbV4hHkJpVp7kM4QZqZ1FuK+W8GekYaTANymGSvFwCL
         VnkLoXhr0xc6dYXM6QOxGUkdA48BJ710YsnpFURlsMpzNa7LwXhAn3TdeA8RIf/TDcLM
         LRoQ==
X-Gm-Message-State: AC+VfDzJTN9kSSQ75flhhXTtM73IB9W39JMwviRQUZJ6RclJaLbIMVfp
        kKuLIQN/bJS8H6XmLij62nj6NQ==
X-Google-Smtp-Source: ACHHUZ42VB0Lj8ecyzzTIJF+6Xp/NIkQGAMP+F1CfLNLPIZZXeecubxiIVi466NtERyswg/gM0CxVQ==
X-Received: by 2002:adf:ed88:0:b0:313:ebb0:ca5d with SMTP id c8-20020adfed88000000b00313ebb0ca5dmr7316592wro.44.1687863137816;
        Tue, 27 Jun 2023 03:52:17 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm10132827wrb.109.2023.06.27.03.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:52:17 -0700 (PDT)
Message-ID: <e21bb941-dd4d-4a50-6a72-e8cfeaea3e60@baylibre.com>
Date:   Tue, 27 Jun 2023 12:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 12/14] drm/mediatek: Sort OVL adaptor components in
 alphabetical order
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
 <20230627063946.14935-13-shawn.sung@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627063946.14935-13-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2023 08:39, Hsiao Chien Sung wrote:
> - Rename OVL_ADAPTOR_TYPE_RDMA to OVL_ADAPTOR_TYPE_MDP_RDMA
>    to align the naming rule of mtk_ovl_adaptor_comp_id.
> - Sort components' names in alphabetical order
> - Sort device table in alphabetical order
> - Add sentinel to device table
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 61 ++++++++-----------
>   1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index c0a38f5217ee..38f389471f66 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -26,13 +26,14 @@
>   #define MTK_OVL_ADAPTOR_LAYER_NUM 4
>   
>   enum mtk_ovl_adaptor_comp_type {
> -	OVL_ADAPTOR_TYPE_RDMA = 0,
> -	OVL_ADAPTOR_TYPE_MERGE,
>   	OVL_ADAPTOR_TYPE_ETHDR,
> +	OVL_ADAPTOR_TYPE_MDP_RDMA,
> +	OVL_ADAPTOR_TYPE_MERGE,
>   	OVL_ADAPTOR_TYPE_NUM,
>   };
>   
>   enum mtk_ovl_adaptor_comp_id {
> +	OVL_ADAPTOR_ETHDR0,
>   	OVL_ADAPTOR_MDP_RDMA0,
>   	OVL_ADAPTOR_MDP_RDMA1,
>   	OVL_ADAPTOR_MDP_RDMA2,
> @@ -45,7 +46,6 @@ enum mtk_ovl_adaptor_comp_id {
>   	OVL_ADAPTOR_MERGE1,
>   	OVL_ADAPTOR_MERGE2,
>   	OVL_ADAPTOR_MERGE3,
> -	OVL_ADAPTOR_ETHDR0,
>   	OVL_ADAPTOR_ID_MAX
>   };
>   
> @@ -61,25 +61,25 @@ struct mtk_disp_ovl_adaptor {
>   };
>   
>   static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
> -	[OVL_ADAPTOR_TYPE_RDMA]		= "vdo1-rdma",
> -	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
>   	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
> +	[OVL_ADAPTOR_TYPE_MDP_RDMA]	= "vdo1-rdma",
> +	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
>   };
>   
>   static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
> -	[OVL_ADAPTOR_MDP_RDMA0]	= { OVL_ADAPTOR_TYPE_RDMA, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA1]	= { OVL_ADAPTOR_TYPE_RDMA, 1 },
> -	[OVL_ADAPTOR_MDP_RDMA2]	= { OVL_ADAPTOR_TYPE_RDMA, 2 },
> -	[OVL_ADAPTOR_MDP_RDMA3]	= { OVL_ADAPTOR_TYPE_RDMA, 3 },
> -	[OVL_ADAPTOR_MDP_RDMA4]	= { OVL_ADAPTOR_TYPE_RDMA, 4 },
> -	[OVL_ADAPTOR_MDP_RDMA5]	= { OVL_ADAPTOR_TYPE_RDMA, 5 },
> -	[OVL_ADAPTOR_MDP_RDMA6]	= { OVL_ADAPTOR_TYPE_RDMA, 6 },
> -	[OVL_ADAPTOR_MDP_RDMA7]	= { OVL_ADAPTOR_TYPE_RDMA, 7 },
> +	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
> +	[OVL_ADAPTOR_MDP_RDMA0]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 0 },
> +	[OVL_ADAPTOR_MDP_RDMA1]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 1 },
> +	[OVL_ADAPTOR_MDP_RDMA2]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 2 },
> +	[OVL_ADAPTOR_MDP_RDMA3]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 3 },
> +	[OVL_ADAPTOR_MDP_RDMA4]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 4 },
> +	[OVL_ADAPTOR_MDP_RDMA5]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 5 },
> +	[OVL_ADAPTOR_MDP_RDMA6]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 6 },
> +	[OVL_ADAPTOR_MDP_RDMA7]	= { OVL_ADAPTOR_TYPE_MDP_RDMA, 7 },
>   	[OVL_ADAPTOR_MERGE0]	= { OVL_ADAPTOR_TYPE_MERGE, 1 },
>   	[OVL_ADAPTOR_MERGE1]	= { OVL_ADAPTOR_TYPE_MERGE, 2 },
>   	[OVL_ADAPTOR_MERGE2]	= { OVL_ADAPTOR_TYPE_MERGE, 3 },
>   	[OVL_ADAPTOR_MERGE3]	= { OVL_ADAPTOR_TYPE_MERGE, 4 },
> -	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
>   };
>   
>   void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
> @@ -89,10 +89,10 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
>   	struct mtk_plane_pending_state *pending = &state->pending;
>   	struct mtk_mdp_rdma_cfg rdma_config = {0};
> +	struct device *ethdr;
> +	struct device *merge;
>   	struct device *rdma_l;
>   	struct device *rdma_r;
> -	struct device *merge;
> -	struct device *ethdr;
>   	const struct drm_format_info *fmt_info = drm_format_info(pending->format);
>   	bool use_dual_pipe = false;
>   	unsigned int align_width;
> @@ -105,16 +105,16 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   		&pending->addr, (pending->pitch / fmt_info->cpp[0]),
>   		pending->x, pending->y, pending->width, pending->height);
>   
> +	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];
> +	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
>   	rdma_l = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx];
>   	rdma_r = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx + 1];
> -	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
> -	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];
>   
>   	if (!pending->enable) {
> +		mtk_ethdr_layer_config(ethdr, idx, state, cmdq_pkt);
>   		mtk_merge_stop_cmdq(merge, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_l, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_r, cmdq_pkt);
> -		mtk_ethdr_layer_config(ethdr, idx, state, cmdq_pkt);
>   		return;
>   	}
>   
> @@ -313,6 +313,7 @@ size_t mtk_ovl_adaptor_get_num_formats(struct device *dev)
>   
>   void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
>   {
> +	mtk_mutex_add_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> @@ -325,11 +326,11 @@ void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE2);
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE3);
>   	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE4);
> -	mtk_mutex_add_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
>   }
>   
>   void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
>   {
> +	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> @@ -342,11 +343,11 @@ void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE2);
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE3);
>   	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE4);
> -	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
>   }
>   
>   void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsigned int next)
>   {
> +	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2);
> @@ -354,11 +355,11 @@ void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsig
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER);
> -	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   }
>   
>   void mtk_ovl_adaptor_disconnect(struct device *dev, struct device *mmsys_dev, unsigned int next)
>   {
> +	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2);
> @@ -366,7 +367,6 @@ void mtk_ovl_adaptor_disconnect(struct device *dev, struct device *mmsys_dev, un
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER);
> -	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   }
>   
>   static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
> @@ -385,17 +385,10 @@ static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
>   }
>   
>   static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] = {
> -	{
> -		.compatible = "mediatek,mt8195-vdo1-rdma",
> -		.data = (void *)OVL_ADAPTOR_TYPE_RDMA,
> -	}, {
> -		.compatible = "mediatek,mt8195-disp-merge",
> -		.data = (void *)OVL_ADAPTOR_TYPE_MERGE,
> -	}, {
> -		.compatible = "mediatek,mt8195-disp-ethdr",
> -		.data = (void *)OVL_ADAPTOR_TYPE_ETHDR,
> -	},
> -	{},
> +	{ .compatible = "mediatek,mt8195-disp-ethdr", .data = (void *)OVL_ADAPTOR_TYPE_ETHDR },
> +	{ .compatible = "mediatek,mt8195-disp-merge", .data = (void *)OVL_ADAPTOR_TYPE_MERGE },
> +	{ .compatible = "mediatek,mt8195-vdo1-rdma", .data = (void *)OVL_ADAPTOR_TYPE_MDP_RDMA },

The lines is > 80 columns.

https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

Actually, there are other lines in this file greater than 80, but IMHO, 
it isn't a reason to continue to do that.

After that, everything looks fine for me.

> +	{ /* sentinel */ }
>   };
>   
>   static int compare_of(struct device *dev, void *data)

-- 
Regards,
Alexandre
