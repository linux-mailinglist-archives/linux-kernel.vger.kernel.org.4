Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54E6C6070
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCWHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCWHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:11:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4CB21A00
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:11:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so82447342edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679555482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUW3KA9oY945l0WjSYU6yb4//t7RdEnfaQxLmA8naNk=;
        b=Enx3yShv9rOD2nIIE/rTGErqDu2U128+byphOkCKi2XPmw+I5IAIUxG63+IOmwuzn+
         oARiz1450a+c08/zkYU8eppOA+yA3xHbW9Nb5oTrg9IzpQmMgjcHocEgLRxaKC7tDeyX
         NxZKNA9AU7yZVk48s5DwN+mIT5h/Z0Mevuc6nm6D7GKfKFtqR7EJveWWaHsTQW3/KU6v
         aERZlrC/V4bgQVcjhZJM2fencBwIYTOhvMDj6rltaHo41zpW+eApkVR1O8RHqjykqwQ0
         Fxl0rpAvJ8KODKBXUfsmYWhiBSR+fWxMwcNP6BBIN1soqzTRXUOSovP1safcFeuKAGW4
         Nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679555482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUW3KA9oY945l0WjSYU6yb4//t7RdEnfaQxLmA8naNk=;
        b=xDX830603BdJvZGqa6Hzkc3ioFoNuq4aWGgHlNiK+k1ozuZzvC04XSYeIzi0VRBh1O
         FU+u3SX0DExJdJ+nKm6L6d9Pyxe7VZkgablT8HdbaFDHPz+7u0xNf3QLdlkUDbqyrQN5
         IQZkmN96hu2f6lT36WDCzh2Zm4TBZQQhM36Sr1E2zy+flsmHM53vuUpgFzJBG2CrLEID
         7HgKQM7K9CaMMgR4HVgX774X71m3AJPA45NgArfjB/slon4HbbTUL18zB2HqwXudI5V8
         rKjkYI5kceqp58bcv1pbJT7vqldfVS0fdRp/32XyBbZHTNkm23pApIBxef3bn0MdasQK
         7nWg==
X-Gm-Message-State: AO0yUKVDXj+++JugMG/iSZjL1u/1R2FqLtQzaI03CUyd2R74yrI7pVYY
        P/4ttDDSJrv8dggyGDgUBdg/7Q==
X-Google-Smtp-Source: AK7set/Wh2D5M3irdgQqmOgdbjL2IfZlCgF1MyK7gaU1RemY2AYRPNcbyBr72ujeMWSgIXR35zZfGw==
X-Received: by 2002:a17:906:3999:b0:933:3705:a9f0 with SMTP id h25-20020a170906399900b009333705a9f0mr10340527eje.19.1679555482610;
        Thu, 23 Mar 2023 00:11:22 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id so8-20020a170907390800b0093d0867a65csm313823ejc.175.2023.03.23.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:11:21 -0700 (PDT)
Message-ID: <16254095-30e9-90f6-6dc7-22b29dad93e3@linaro.org>
Date:   Thu, 23 Mar 2023 07:11:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmem: mtk-efuse: Support postprocessing for GPU speed
 binning data
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wenst@chromium.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230321143319.333803-1-angelogioacchino.delregno@collabora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230321143319.333803-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2023 14:33, AngeloGioacchino Del Regno wrote:
> On some MediaTek SoCs GPU speed binning data is available for read
> in the SoC's eFuse array but it has a format that is incompatible
> with what the OPP API expects, as we read a number from 0 to 7 but
> opp-supported-hw is expecting a bitmask to enable an OPP entry:
> being what we read limited to 0-7, it's straightforward to simply
> convert the value to BIT(value) as a post-processing action.
> 
> So, introduce post-processing support and enable it by evaluating
> the newly introduced platform data's `uses_post_processing` member,
> currently enabled only for MT8186.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Applied thanks,

--srini
>   drivers/nvmem/mtk-efuse.c | 53 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index a08e0aedd21c..b36cd0dcc8c7 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -10,6 +10,11 @@
>   #include <linux/io.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct mtk_efuse_pdata {
> +	bool uses_post_processing;
> +};
>   
>   struct mtk_efuse_priv {
>   	void __iomem *base;
> @@ -29,6 +34,37 @@ static int mtk_reg_read(void *context,
>   	return 0;
>   }
>   
> +static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
> +				     unsigned int offset, void *data, size_t bytes)
> +{
> +	u8 *val = data;
> +
> +	if (val[0] < 8)
> +		val[0] = BIT(val[0]);
> +
> +	return 0;
> +}
> +
> +static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
> +				      struct nvmem_layout *layout,
> +				      struct nvmem_cell_info *cell)
> +{
> +	size_t sz = strlen(cell->name);
> +
> +	/*
> +	 * On some SoCs, the GPU speedbin is not read as bitmask but as
> +	 * a number with range [0-7] (max 3 bits): post process to use
> +	 * it in OPP tables to describe supported-hw.
> +	 */
> +	if (cell->nbits <= 3 &&
> +	    strncmp(cell->name, "gpu-speedbin", min(sz, strlen("gpu-speedbin"))) == 0)
> +		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
> +}
> +
> +static struct nvmem_layout mtk_efuse_layout = {
> +	.fixup_cell_info = mtk_efuse_fixup_cell_info,
> +};
> +
>   static int mtk_efuse_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -36,6 +72,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	struct nvmem_device *nvmem;
>   	struct nvmem_config econfig = {};
>   	struct mtk_efuse_priv *priv;
> +	const struct mtk_efuse_pdata *pdata;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -45,20 +82,32 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
> +	pdata = device_get_match_data(dev);
>   	econfig.stride = 1;
>   	econfig.word_size = 1;
>   	econfig.reg_read = mtk_reg_read;
>   	econfig.size = resource_size(res);
>   	econfig.priv = priv;
>   	econfig.dev = dev;
> +	if (pdata->uses_post_processing)
> +		econfig.layout = &mtk_efuse_layout;
>   	nvmem = devm_nvmem_register(dev, &econfig);
>   
>   	return PTR_ERR_OR_ZERO(nvmem);
>   }
>   
> +static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
> +	.uses_post_processing = true,
> +};
> +
> +static const struct mtk_efuse_pdata mtk_efuse_pdata = {
> +	.uses_post_processing = false,
> +};
> +
>   static const struct of_device_id mtk_efuse_of_match[] = {
> -	{ .compatible = "mediatek,mt8173-efuse",},
> -	{ .compatible = "mediatek,efuse",},
> +	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
> +	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
> +	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>   	{/* sentinel */},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
