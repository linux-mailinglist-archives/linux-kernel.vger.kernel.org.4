Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBF702B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbjEOL0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjEOL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:26:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AA13A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:25:50 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66CEA66031D7;
        Mon, 15 May 2023 12:25:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684149948;
        bh=43lCd7DbxPZwcO9IH4LOmzSa65a75ebXHssNM18hOQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k4DEO22w8ZvsvFzka7v6ra0zcazgo/zVZe4iMYMmSdXueGxDOFJsIj7B+1++9dAPK
         xXx1eUQ5zC1IlS6nE6SahE/HhAAlyCeB/1yA09chWxLvX3EYg70bbJwsEUqKh/pjT1
         1pHpOF9qwKAJjcF4MMdH1XBOilOHa2Yyh7fJBJlbJYFcUAmb+X06Uhscao17hGeUUq
         kXQcLrNhw1BBuX0FCCl77lUBdn7gs2CRZIw6BuuNN7xwWUR06SRxmgfhMAozsdWvX9
         sh8F5QTR+WqxbejUievIY8xgySJuRKT2KklLhrk7a7/NMpe3H3byJWetIzWRGnWg8Q
         RFm3RiC6E1LWQ==
Message-ID: <7c784932-951a-65c0-c48f-bfa4c098b2e1@collabora.com>
Date:   Mon, 15 May 2023 13:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] ASoC: SOF: mediatek: add mt8188 audio support
To:     Trevor Wu <trevor.wu@mediatek.com>,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
Cc:     yc.hung@mediatek.com, tinghan.shen@mediatek.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230515052540.9037-1-trevor.wu@mediatek.com>
 <20230515052540.9037-2-trevor.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515052540.9037-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 07:25, Trevor Wu ha scritto:
> Add mt8188 dai driver and specify of_machine to support mt8188 audio.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>   sound/soc/sof/mediatek/mt8186/mt8186.c | 61 +++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
> index 419913c8474d..3a9c81418c1f 100644
> --- a/sound/soc/sof/mediatek/mt8186/mt8186.c
> +++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
> @@ -594,7 +594,65 @@ static const struct sof_dev_desc sof_of_mt8186_desc = {
>   	.ops = &sof_mt8186_ops,
>   };
>   
> +/*
> + * DL2, DL3, UL4, UL5 are registered as SOF FE, so creating the corresponding
> + * SOF BE to complete the pipeline.
> + */
> +static struct snd_soc_dai_driver mt8188_dai[] = {
> +{
> +	.name = "SOF_DL2",
> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +	},
> +},
> +{
> +	.name = "SOF_DL3",
> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +	},
> +},
> +{
> +	.name = "SOF_UL4",
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +	},
> +},
> +{
> +	.name = "SOF_UL5",
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +	},
> +},
> +};
> +
> +/* mt8188 ops */
> +static struct snd_sof_dsp_ops sof_mt8188_ops;
> +
> +static int sof_mt8188_ops_init(struct snd_sof_dev *sdev)
> +{
> +	/* common defaults */
> +	memcpy(&sof_mt8188_ops, &sof_mt8186_ops, sizeof(struct snd_sof_dsp_ops));

Never use sizeof(type), always use destination var size! Anyway, there's more.

I don't think we need to perform this memcpy: we'll never see an instance of
both mt8186 and mt8188 drivers on the same machine, so you can safely just use
sof_mt8186_ops for mt8188...

> +
> +	sof_mt8188_ops.drv = mt8188_dai;

...which obviously means that this becomes

	sof_mt8186_ops.drv = mt8188_dai;

and....

> +	sof_mt8186_ops.num_drv = ARRAY_SIZE(mt8188_dai);
> +
> +	return 0;
> +}
> +
> +static struct snd_sof_of_mach sof_mt8188_machs[] = {
> +	{
> +		.compatible = "mediatek,mt8188",
> +		.sof_tplg_filename = "sof-mt8188.tplg",
> +	},
> +	{}
> +};
> +
>   static const struct sof_dev_desc sof_of_mt8188_desc = {
> +	.of_machines = sof_mt8188_machs,
>   	.ipc_supported_mask	= BIT(SOF_IPC),
>   	.ipc_default		= SOF_IPC,
>   	.default_fw_path = {
> @@ -607,7 +665,8 @@ static const struct sof_dev_desc sof_of_mt8188_desc = {
>   		[SOF_IPC] = "sof-mt8188.ri",
>   	},
>   	.nocodec_tplg_filename = "sof-mt8188-nocodec.tplg",
> -	.ops = &sof_mt8186_ops,
> +	.ops = &sof_mt8188_ops,

...this keeps being sof_mt8186_ops as well.

> +	.ops_init = sof_mt8188_ops_init,
>   };
>   
>   static const struct of_device_id sof_of_mt8186_ids[] = {

Regards,
Angelo

