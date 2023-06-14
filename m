Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800EE72F69F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjFNHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243462AbjFNHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:44:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2451BD3;
        Wed, 14 Jun 2023 00:44:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A57A6606F43;
        Wed, 14 Jun 2023 08:44:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686728691;
        bh=IQQBbiRpKNYCSh4CThtAS7GakfWY7aS2VsNaYaGf9yE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DdlVCU+RnH0pFhtNq1PVxWsgRROSlW+DGCkSuDrOyDjZoKriV1x/gsK74Qqoqjkz2
         uXPmw3aECNtgQ1nHphrB1SVhRdib/9RPm8BkOZ1ZqHF2PalFwgLZxkgt9ZyNrDGZiv
         ZrvsEYWKHEDFKbvwc6w6fIQtQRWUsAi5QrXQLX06W0ydxRywQPFymLTi0LyP2utttf
         dDKQ2fiLZVAvCeVKEB/KxxN6Cll7wsEFaK+nWUuQUmZS2WBdYSwy+G/t/KZp/wjATE
         cuSYIJEcEz5HDjWwt8H2+wgFxN+ch17H1AW96KES1efg/hWmrxKsAGIkOoQAil+Vwx
         NkmP1qiFZ7t3Q==
Message-ID: <2ad87d4a-3068-61c1-2192-bcd80dfa46d0@collabora.com>
Date:   Wed, 14 Jun 2023 09:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/7] ASoC: mediatek: mt79xx: add common header
Content-Language: en-US
To:     Maso Hunag <maso.huang@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-2-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612105250.15441-2-maso.huang@mediatek.com>
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

Il 12/06/23 12:52, Maso Hunag ha scritto:
> From: Maso Huang <maso.huang@mediatek.com>
> 
> Add header files for register definition and structure.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/mt79xx/mt79xx-afe-common.h |  49 +++++
>   sound/soc/mediatek/mt79xx/mt79xx-reg.h        | 206 ++++++++++++++++++

Please, s/mt79xx/mt7981/g. Wildcards are not permitted.

>   2 files changed, 255 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
>   create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-reg.h
> 
> diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h b/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
> new file mode 100644
> index 000000000000..13c9e51d7b38
> --- /dev/null
> +++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * mt79xx-afe-common.h  --  MediaTek 79xx audio driver definitions
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Vic Wu <vic.wu@mediatek.com>
> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#ifndef _MT_79XX_AFE_COMMON_H_
> +#define _MT_79XX_AFE_COMMON_H_
> +
> +#include <sound/soc.h>
> +#include <linux/list.h>
> +#include <linux/regmap.h>
> +#include "../common/mtk-base-afe.h"
> +
> +enum {
> +	MT79XX_MEMIF_DL1,
> +	MT79XX_MEMIF_VUL12,
> +	MT79XX_MEMIF_NUM,
> +	MT79XX_DAI_ETDM = MT79XX_MEMIF_NUM,
> +	MT79XX_DAI_NUM,
> +};

Same for the enumeration entries, and the definitions and the function names.
Please change everything to `mt7981` (strategy is to use the name of the oldest
SoC: if the oldest is not 7981, change accordingly).

> +
> +enum {
> +	MT79XX_IRQ_0,
> +	MT79XX_IRQ_1,
> +	MT79XX_IRQ_2,
> +	MT79XX_IRQ_NUM,
> +};
> +
> +struct clk;
> +
> +struct mt79xx_afe_private {
> +	struct clk **clk;
> +
> +	int pm_runtime_bypass_reg_ctl;
> +
> +	/* dai */
> +	void *dai_priv[MT79XX_DAI_NUM];
> +};
> +
> +unsigned int mt79xx_afe_rate_transform(struct device *dev,
> +				       unsigned int rate);
> +
> +/* dai register */
> +int mt79xx_dai_etdm_register(struct mtk_base_afe *afe);
> +#endif
> diff --git a/sound/soc/mediatek/mt79xx/mt79xx-reg.h b/sound/soc/mediatek/mt79xx/mt79xx-reg.h
> new file mode 100644
> index 000000000000..28c0aeba9bdf
> --- /dev/null
> +++ b/sound/soc/mediatek/mt79xx/mt79xx-reg.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * mt79xx-reg.h  --  MediaTek 79xx audio driver reg definition
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Vic Wu <vic.wu@mediatek.com>
> + *         Maso Huang <maso.huang@mediatek.com>
> + */
> +
> +#ifndef _MT79XX_REG_H_
> +#define _MT79XX_REG_H_

_MT7981_REG_H_

Everything else looks ok.

Thanks,
Angelo

