Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D569746C86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGDI6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGDI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:58:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CF186;
        Tue,  4 Jul 2023 01:58:39 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 606946606ED1;
        Tue,  4 Jul 2023 09:58:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688461118;
        bh=SjGu7YG2MyYo3NcWANYQRJtPw6x21qgJpQDVq9sIg40=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=diAkKC0mRWuRsit2iQeQ1D7RhtTmGuMxonq0MZHRcsLjqWkMY1hJsxU6qJ9VhNSok
         ptnc7NjHpaZqq+JTZkG5HjlsxOUzg1Ta4Xr7ESYfQmosDTrV8RKiyIHgQpQMsV7VXd
         Fge0rqRoi8cbmWe6AaPJn0qExzySMJAEaBrHtmN8+Jf2VFE0j3rz/TjLi5SCMy5NV6
         qE28q0WmNiFcm8zXJa0UleCiSqxtCTlFLsNSgLp2fvWWfvx+0Tq3n+kMcntt8roYr7
         BRR31fFWm81RnKdxJZPIzCd8iD8k3WXGPxceqdjEevrlyqwZfv43+1rsGPdahIfPQL
         pPxEOpecAHPSQ==
Message-ID: <255bb946-2198-93e7-7f38-7b8e00f7677f@collabora.com>
Date:   Tue, 4 Jul 2023 10:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/7] ASoC: mediatek: mt7986: support etdm in platform
 driver
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-4-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230626023501.11120-4-maso.huang@mediatek.com>
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

Il 26/06/23 04:34, Maso Huang ha scritto:
> Add mt7986 etdm dai driver support.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/mt7986/mt7986-dai-etdm.c | 421 ++++++++++++++++++++
>   1 file changed, 421 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> 
> diff --git a/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> new file mode 100644
> index 000000000000..672deb59ea46
> --- /dev/null
> +++ b/sound/soc/mediatek/mt7986/mt7986-dai-etdm.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek ALSA SoC Audio DAI eTDM Control
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Vic Wu <vic.wu@mediatek.com>
> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <sound/pcm_params.h>
> +#include "mt7986-afe-clk.h"
> +#include "mt7986-afe-common.h"
> +#include "mt7986-reg.h"
> +
> +enum {
> +	HOPPING_CLK = 0,
> +	APLL_CLK = 1,
> +};
> +
> +enum {
> +	MTK_DAI_ETDM_FORMAT_I2S = 0,
> +	MTK_DAI_ETDM_FORMAT_DSPA = 4,
> +	MTK_DAI_ETDM_FORMAT_DSPB = 5,
> +};
> +
> +enum {
> +	ETDM_IN5 = 2,
> +	ETDM_OUT5 = 10,
> +};
> +
> +enum {
> +	MTK_ETDM_RATE_8K = 0,
> +	MTK_ETDM_RATE_12K = 1,
> +	MTK_ETDM_RATE_16K = 2,
> +	MTK_ETDM_RATE_24K = 3,
> +	MTK_ETDM_RATE_32K = 4,
> +	MTK_ETDM_RATE_48K = 5,
> +	MTK_ETDM_RATE_96K = 7,
> +	MTK_ETDM_RATE_192K = 9,
> +	MTK_ETDM_RATE_11K = 16,
> +	MTK_ETDM_RATE_22K = 17,
> +	MTK_ETDM_RATE_44K = 18,
> +	MTK_ETDM_RATE_88K = 19,
> +	MTK_ETDM_RATE_176K = 20,
> +};
> +
> +struct mtk_dai_etdm_priv {
> +	bool bck_inv;
> +	bool lrck_inv;
> +	bool slave_mode;
> +	unsigned int format;
> +};
> +
> +static unsigned int mt7986_etdm_rate_transform(struct device *dev,
> +					unsigned int rate)

Please either fix indentation or just do it in one line, 86 columns are ok.

> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_ETDM_RATE_8K;
> +	case 11025:
> +		return MTK_ETDM_RATE_11K;
> +	case 12000:
> +		return MTK_ETDM_RATE_12K;
> +	case 16000:
> +		return MTK_ETDM_RATE_16K;
> +	case 22050:
> +		return MTK_ETDM_RATE_22K;
> +	case 24000:
> +		return MTK_ETDM_RATE_24K;
> +	case 32000:
> +		return MTK_ETDM_RATE_32K;
> +	case 44100:
> +		return MTK_ETDM_RATE_44K;
> +	case 48000:
> +		return MTK_ETDM_RATE_48K;
> +	case 88200:
> +		return MTK_ETDM_RATE_88K;
> +	case 96000:
> +		return MTK_ETDM_RATE_96K;
> +	case 176400:
> +		return MTK_ETDM_RATE_176K;
> +	case 192000:
> +		return MTK_ETDM_RATE_192K;
> +	default:
> +		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",

s/use/using/g

> +			 __func__, rate, MTK_ETDM_RATE_48K);
> +		return MTK_ETDM_RATE_48K;
> +	}
> +}
> +
> +static int get_etdm_wlen(unsigned int bitwidth)
> +{
> +	return bitwidth <= 16 ? 16 : 32;
> +}
> +
> +/* dai component */
> +/* interconnection */
> +
> +static const struct snd_kcontrol_new o124_mix[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("I032_Switch", AFE_CONN124_1, 0, 1, 0),
> +};
> +
> +static const struct snd_kcontrol_new o125_mix[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("I033_Switch", AFE_CONN125_1, 1, 1, 0),
> +};
> +
> +static const struct snd_soc_dapm_widget mtk_dai_etdm_widgets[] = {
> +
> +	/* DL */
> +	SND_SOC_DAPM_MIXER("I150", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("I151", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	/* UL */
> +	SND_SOC_DAPM_MIXER("O124", SND_SOC_NOPM, 0, 0,
> +			   o124_mix, ARRAY_SIZE(o124_mix)),

Fits in one line.

> +	SND_SOC_DAPM_MIXER("O125", SND_SOC_NOPM, 0, 0,
> +			   o125_mix, ARRAY_SIZE(o125_mix)),

This one too.

> +};
> +
> +static const struct snd_soc_dapm_route mtk_dai_etdm_routes[] = {
> +	{"I150", NULL, "ETDM Capture"},
> +	{"I151", NULL, "ETDM Capture"},
> +	{"ETDM Playback", NULL, "O124"},
> +	{"ETDM Playback", NULL, "O125"},
> +	{"O124", "I032_Switch", "I032"},
> +	{"O125", "I033_Switch", "I033"},
> +};
> +
> +/* dai ops */
> +static int mtk_dai_etdm_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +
> +	mt7986_afe_enable_clock(afe);
> +
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_OUT5_PDN_MASK,
> +			   0);
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON2, CLK_IN5_PDN_MASK,
> +			   0);

Both do fit in one line (and others in this file).

After fixing that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
