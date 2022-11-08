Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A9621B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiKHSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiKHSLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:11:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294859FEC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:11:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g12so22228603wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNbuvhNf/Wvi9KDrdhQiQ7CIoY1oS0/eXau3bWTCZqo=;
        b=aAo97Lk7t8HYJYAQH+EepvDRsg9bR5P+VV7s+6T1YBRXmvxQRjh7gy++zo+Y+ZXRdx
         YR9BZg+ULLNQeeJVYoaatkdckzPUcE0/ceV66dSZsMwNKONY/6kM/jP3VLVs24YYnzPx
         p4duRRADFem32dEbRqMt4nQCyjzjIAzAiYZniLuqT1966rGL6dHzHveRqJVBNucWCO+5
         nm0uG8+s+TzJddl9DjklHuDeY46/wHBJuthagt1wwW/d2SqF0kCQApgZAzJI44U2hE6Z
         5JMz72qjeEnloIK8AFnGf9m2mIsTGytswmW5LtfKpffbnH+Bog4GUbSx/LQk97AMnILo
         s1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNbuvhNf/Wvi9KDrdhQiQ7CIoY1oS0/eXau3bWTCZqo=;
        b=Umhq/++5CAy/e4YNfCRVMcgADzLpqGc0RCa4ZIcV+o3i8fF+U6k6vNdy1AfHUaUQlu
         rCAd+8lSRxe2rasFLpWPo28cF2wHYWLq/2d8nlhDN1hH3LWQNoaJc+NWOCsCkm10pdZa
         WZgCzeY5svUSPPQPNJYzNTF86d+mi7l7kNqIzv6CYhku+turEv+tpQk3ZCNFmMLcg+b7
         nIEnSz/QUcQj3uYls8IGCjMN06ebP2YXdWY2OeUYDd08HAvclmbhMZEaZ++bQwTAa/oj
         QQ1x9WwCjqFz0JXHwjKVU+CZByn8r99EzV3kyn2yoigUSy1Hcz6gH3BY0Th96hyh0rPP
         YO5w==
X-Gm-Message-State: ACrzQf0SwexRFpJbWJfTI6Ea5H8WnXZL7dxYurYd8yKwN8QC12TNcxDr
        kQNiBysrXAByFZJ38wcmZFA=
X-Google-Smtp-Source: AMsMyM6ErS/0hA9t6B9+8Qsgjup9o1jMSAt9VpHujCwfERrvF9rKCdB4Y0IaSRtElie7ycelM0GySg==
X-Received: by 2002:a5d:5270:0:b0:236:60c6:6e80 with SMTP id l16-20020a5d5270000000b0023660c66e80mr35179041wrc.140.1667931105355;
        Tue, 08 Nov 2022 10:11:45 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b003cf87623c16sm17256080wmb.4.2022.11.08.10.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:11:44 -0800 (PST)
Message-ID: <03fdf45d-be93-206a-8c9c-17d31010162f@gmail.com>
Date:   Tue, 8 Nov 2022 19:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v13,1/3] soc: mediatek: Add all settings to
 mtk_mmsys_ddp_dpi_fmt_config func
Content-Language: en-US
To:     xinlei.lee@mediatek.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nfraprado@collabora.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1666577099-3859-1-git-send-email-xinlei.lee@mediatek.com>
 <1666577099-3859-2-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1666577099-3859-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinlei,

Can you please fix the threading of this patches. I can see that this 1/3 but 
I'm not able to find 3/3 in the series. The first two look good, the third, I 
don't know.

Regards,
Matthias

On 24/10/2022 04:04, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> The difference between MT8186 and other ICs is that when modifying the
> output format, we need to modify the mmsys_base+0x400 register to take
> effect. So when setting the dpi output format, we need to call
> mtk_mmsys_ddp_dpi_fmt_config to set it to MT8186 synchronously.
>    
> Commit a071e52f75d1 ("soc: mediatek: Add mmsys func to adapt to dpi
> output for MT8186") lacked some of the possible output formats and also
> had a wrong bitmask.
> 
> Add the missing output formats and fix the bitmask.
>    
> While at it, also update mtk_mmsys_ddp_dpi_fmt_config() to use generic
> formats, so that it is slightly easier to extend for other platforms.
>    
> Fixes: a071e52f75d1 ("soc: mediatek: Add mmsys func to adapt to dpi output for MT8186")
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mt8186-mmsys.h    |  8 +++++---
>   drivers/soc/mediatek/mtk-mmsys.c       | 27 ++++++++++++++++++++------
>   include/linux/soc/mediatek/mtk-mmsys.h |  7 +++++++
>   3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
> index 09b1ccbc0093..279d4138525b 100644
> --- a/drivers/soc/mediatek/mt8186-mmsys.h
> +++ b/drivers/soc/mediatek/mt8186-mmsys.h
> @@ -5,9 +5,11 @@
>   
>   /* Values for DPI configuration in MMSYS address space */
>   #define MT8186_MMSYS_DPI_OUTPUT_FORMAT		0x400
> -#define DPI_FORMAT_MASK					0x1
> -#define DPI_RGB888_DDR_CON				BIT(0)
> -#define DPI_RGB565_SDR_CON				BIT(1)
> +#define MT8186_DPI_FORMAT_MASK				GENMASK(1, 0)
> +#define MT8186_DPI_RGB888_SDR_CON			0
> +#define MT8186_DPI_RGB888_DDR_CON			1
> +#define MT8186_DPI_RGB565_SDR_CON			2
> +#define MT8186_DPI_RGB565_DDR_CON			3
>   
>   #define MT8186_MMSYS_OVL_CON			0xF04
>   #define MT8186_MMSYS_OVL0_CON_MASK			0x3
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 2e20b24da363..16cd924d8973 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -238,12 +238,27 @@ static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask,
>   
>   void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
>   {
> -	if (val)
> -		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> -				      DPI_RGB888_DDR_CON, DPI_FORMAT_MASK);
> -	else
> -		mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> -				      DPI_RGB565_SDR_CON, DPI_FORMAT_MASK);
> +	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
> +
> +	switch (val) {
> +	case MTK_DPI_RGB888_SDR_CON:
> +		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> +				      MT8186_DPI_FORMAT_MASK, MT8186_DPI_RGB888_SDR_CON);
> +		break;
> +	case MTK_DPI_RGB565_SDR_CON:
> +		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> +				      MT8186_DPI_FORMAT_MASK, MT8186_DPI_RGB565_SDR_CON);
> +		break;
> +	case MTK_DPI_RGB565_DDR_CON:
> +		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> +				      MT8186_DPI_FORMAT_MASK, MT8186_DPI_RGB565_DDR_CON);
> +		break;
> +	case MTK_DPI_RGB888_DDR_CON:
> +	default:
> +		mtk_mmsys_update_bits(mmsys, MT8186_MMSYS_DPI_OUTPUT_FORMAT,
> +				      MT8186_DPI_FORMAT_MASK, MT8186_DPI_RGB888_DDR_CON);
> +		break;
> +	}
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
>   
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index d2b02bb43768..b85f66db33e1 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -9,6 +9,13 @@
>   enum mtk_ddp_comp_id;
>   struct device;
>   
> +enum mtk_dpi_out_format_con {
> +	MTK_DPI_RGB888_SDR_CON,
> +	MTK_DPI_RGB888_DDR_CON,
> +	MTK_DPI_RGB565_SDR_CON,
> +	MTK_DPI_RGB565_DDR_CON
> +};
> +
>   enum mtk_ddp_comp_id {
>   	DDP_COMPONENT_AAL0,
>   	DDP_COMPONENT_AAL1,
