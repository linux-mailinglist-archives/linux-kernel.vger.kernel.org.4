Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF71653EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiLVLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiLVLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:09:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96062B861;
        Thu, 22 Dec 2022 03:09:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A354F6602C5F;
        Thu, 22 Dec 2022 11:09:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671707378;
        bh=9AUHReu8S/xX7R3+pH3TTsXI6e8ZAG2uSiP5k+96Fzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AXeZPwjilwQjk5/eDQ0HLfrUo6f0gL/fVzzlGfEL/oKzAx0m0pg6vXy8Fgi97eEhq
         0jOmqbpJNk0LF/AJTCoK/IUzlAL48XErbsfd5z5LiFPSsdarfb353dIdJHrUByqzTs
         Z7kIcsC0yqBmUGWS/W7eTjlNv0B5Arbul58aFatvsOv1PLg1Rmux+gwYPspf7/Jv1j
         mnAjv3r28UFJs+KMQdmXpairBPWsmtXXjVN5ZiE/hx1pso07w7mItLVIcvwMN36cMb
         zUNRQXbzi+nFlBf2XgXiCNZ7LxwA4y14OyOaLv8uBYzCMCozTgt8Qn41k1cAD7JKYd
         +RzRbZdL7PSOg==
Message-ID: <31b2946b-d4f2-5e5b-a107-45b3454c601b@collabora.com>
Date:   Thu, 22 Dec 2022 12:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 2/3] ASoC: SOF: mediatek: Support mt8188 platform
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <error27@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221222072150.10627-1-tinghan.shen@mediatek.com>
 <20221222072150.10627-3-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221222072150.10627-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/12/22 08:21, Tinghan Shen ha scritto:
> Add support of SOF on MediaTek MT8188 SoC.
> MT8188 ADSP integrates with a single core Cadence HiFi-5 DSP.
> The IPC communication between AP and DSP is based on shared DRAM and
> mailbox interrupt.
> 
> The change in the mt8186.h is compatible on both mt8186 and
> mt8188. The register controls booting the DSP core with the
> default address or the user specified address. Both mt8186
> and mt8188 should boot with the user specified boot in the driver.
> The usage of the register is the same on both SoC, but the
> control bit is different on mt8186 and mt8188, which is bit 1 on mt8186
> and bit 0 on mt8188. Configure the redundant bit has noside effect
> on both SoCs.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>   sound/soc/sof/mediatek/mt8186/mt8186.c | 17 +++++++++++++++++
>   sound/soc/sof/mediatek/mt8186/mt8186.h |  3 ++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
> index 79da25725987..af0dfc2fc4cc 100644
> --- a/sound/soc/sof/mediatek/mt8186/mt8186.c
> +++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
> @@ -625,8 +625,25 @@ static const struct sof_dev_desc sof_of_mt8186_desc = {
>   	.ops = &sof_mt8186_ops,
>   };
>   
> +static const struct sof_dev_desc sof_of_mt8188_desc = {
> +	.ipc_supported_mask	= BIT(SOF_IPC),
> +	.ipc_default		= SOF_IPC,
> +	.default_fw_path = {
> +		[SOF_IPC] = "mediatek/sof",
> +	},
> +	.default_tplg_path = {
> +		[SOF_IPC] = "mediatek/sof-tplg",
> +	},
> +	.default_fw_filename = {
> +		[SOF_IPC] = "sof-mt8188.ri",
> +	},
> +	.nocodec_tplg_filename = "sof-mt8188-nocodec.tplg",
> +	.ops = &sof_mt8186_ops,
> +};
> +
>   static const struct of_device_id sof_of_mt8186_ids[] = {
>   	{ .compatible = "mediatek,mt8186-dsp", .data = &sof_of_mt8186_desc},
> +	{ .compatible = "mediatek,mt8188-dsp", .data = &sof_of_mt8188_desc},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, sof_of_mt8186_ids);
> diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.h b/sound/soc/sof/mediatek/mt8186/mt8186.h
> index 98b2965e5ba6..886d687449e3 100644
> --- a/sound/soc/sof/mediatek/mt8186/mt8186.h
> +++ b/sound/soc/sof/mediatek/mt8186/mt8186.h
> @@ -52,7 +52,8 @@ struct snd_sof_dev;
>   #define ADSP_PRID			0x0
>   #define ADSP_ALTVEC_C0			0x04
>   #define ADSP_ALTVECSEL			0x0C
> -#define ADSP_ALTVECSEL_C0		BIT(1)
> +/* BIT(1) for mt8186. BIT(0) for mt8188 */

We can be clearer here:

#define MT8188_ADSP_ALTVECSEL_C0	BIT(0)
#define MT8186_ADSP_ALTVECSEL_C0	BIT(1)

/*
  * On MT8188, BIT(1) is not evaluated and on MT8186 BIT(0) is not evaluated:
  * We can simplify the driver by safely setting both bits regardless of the SoC.
  */
#define ADSP_ALTVECSEL_C0		(MT8188_ADSP_ALTVECSEL_C0 |
					 MT8186_ADSP_ALTVECSEL_C0)

...so that we don't have to check the commit history to understand what's going
on here, and it becomes clear that ALTVECSEL is not both bits, but one of them.

Cheers,
Angelo

