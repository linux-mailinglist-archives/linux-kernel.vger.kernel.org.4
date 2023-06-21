Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCF737DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjFUIQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFUIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:16:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A339199F;
        Wed, 21 Jun 2023 01:16:21 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B6E066028F5;
        Wed, 21 Jun 2023 09:16:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687335380;
        bh=hYeqJXrNdQrWh8TBQ4/xsv+bJNCog/vVfN3GNj8ENio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JtPlJB2LeAvmKwhtWAAW/du/VDpbabNRfssloQtknn1sATNP3beaBvzSEXD71jVqb
         /qAEon932lWSiY+biADoO/lfuZ0u4cirCekTf6wO0lQ1L1eBvIqmP9F9V/3ZRY5cfP
         h/TzNqgS99Sk4OGV/zflWRemu1hX7zsKvk8DGTXZyKlQp7r1K2rp6MFKPC5gr2pGd/
         8OthAz+C59dELKSQGYCftikpwGXVBLKpP2v8c/gnlTDwaLw3yKO4rNkEgYy5Ap51x4
         NlWOimYu/y4VAqMTe5FhRjk5+R+VQddI98Sj86apnq5+vVCVef5ncvN5Atdwrs7anx
         xRKyClG5D2FMQ==
Message-ID: <8442c6a4-14a7-e3b3-0a82-0797ef3ddd77@collabora.com>
Date:   Wed, 21 Jun 2023 10:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 13/14] drm/mediatek: Sort OVL adaptor components in
 alphabetical order
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
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
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
 <20230621031938.5884-14-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230621031938.5884-14-shawn.sung@mediatek.com>
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

Il 21/06/23 05:19, Hsiao Chien Sung ha scritto:
> - Rename OVL_ADAPTOR_TYPE_RDMA to OVL_ADAPTOR_TYPE_MDP_RDMA
>    to align the naming rule of mtk_ovl_adaptor_comp_id.
> - Sort components' names in alphabetical order
> - Sort device table in alphabetical order
> - Add sentinel to device table
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

I agree, but this commit should come before [12/14] of this series.

Regards,
Angelo

> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 61 ++++++++-----------
>   1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 69ae531294ff..4120d08e4969 100644
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
> @@ -62,21 +62,21 @@ struct mtk_disp_ovl_adaptor {
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
>   	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA0, 0 },
> -	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA1, 1 },
> -	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA2, 2 },
> -	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA3, 3 },
> -	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA4, 4 },
> -	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
> -	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
> -	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
> +	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA0, 0 },
> +	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA1, 1 },
> +	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA2, 2 },
> +	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA3, 3 },
> +	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA4, 4 },
> +	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
> +	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
> +	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
>   	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1 },
>   	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2 },
>   	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3 },
> @@ -94,10 +94,7 @@ static int mtk_ovl_adaptor_enable(struct device *dev, enum mtk_ovl_adaptor_comp_
>   	case OVL_ADAPTOR_TYPE_ETHDR:
>   		ret = mtk_ethdr_clk_enable(dev);
>   		break;
> -	case OVL_ADAPTOR_TYPE_MERGE:
> -		ret = mtk_merge_clk_enable(dev);
> -		break;
> -	case OVL_ADAPTOR_TYPE_RDMA:
> +	case OVL_ADAPTOR_TYPE_MDP_RDMA:
>   		// only LARB users need to do this
>   		ret = pm_runtime_get_sync(dev);
>   		if (ret < 0) {
> @@ -108,6 +105,9 @@ static int mtk_ovl_adaptor_enable(struct device *dev, enum mtk_ovl_adaptor_comp_
>   		if (ret)
>   			pm_runtime_put(dev);
>   		break;
> +	case OVL_ADAPTOR_TYPE_MERGE:
> +		ret = mtk_merge_clk_enable(dev);
> +		break;
>   	default:
>   		dev_err(dev, "Unknown type: %d\n", type);
>   	}
> @@ -128,13 +128,13 @@ static void mtk_ovl_adaptor_disable(struct device *dev, enum mtk_ovl_adaptor_com
>   	case OVL_ADAPTOR_TYPE_ETHDR:
>   		mtk_ethdr_clk_disable(dev);
>   		break;
> -	case OVL_ADAPTOR_TYPE_MERGE:
> -		mtk_merge_clk_disable(dev);
> -		break;
> -	case OVL_ADAPTOR_TYPE_RDMA:
> +	case OVL_ADAPTOR_TYPE_MDP_RDMA:
>   		mtk_mdp_rdma_clk_disable(dev);
>   		pm_runtime_put(dev);
>   		break;
> +	case OVL_ADAPTOR_TYPE_MERGE:
> +		mtk_merge_clk_disable(dev);
> +		break;
>   	default:
>   		dev_err(dev, "Unknown type: %d\n", type);
>   	}
> @@ -353,6 +353,7 @@ void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
>   
>   void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsigned int next)
>   {
> +	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1);
>   	mtk_mmsys_ddp_connect(mmsys_dev, DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2);
> @@ -360,11 +361,11 @@ void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsig
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
> @@ -372,7 +373,6 @@ void mtk_ovl_adaptor_disconnect(struct device *dev, struct device *mmsys_dev, un
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER);
>   	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER);
> -	mtk_mmsys_ddp_disconnect(mmsys_dev, DDP_COMPONENT_ETHDR_MIXER, next);
>   }
>   
>   static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
> @@ -391,17 +391,10 @@ static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
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
> +	{ /* sentinel */ }
>   };
>   
>   static int compare_of(struct device *dev, void *data)


