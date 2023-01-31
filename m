Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60C682E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjAaNhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjAaNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:37:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED650875;
        Tue, 31 Jan 2023 05:37:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4454082wmp.3;
        Tue, 31 Jan 2023 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gN8Wq5E0N3HaFBsHRV9eya7b4jMZgDEegEG0/7rxU6Y=;
        b=M6fdQdSxkncaF2gGsMGmgwiRTx17JrkmhphINg4jzKeXIuUUE1NClOZlA7lVuWJSjN
         v+SEeYL251vyLO2jJDt2liXop052ZSYklXuUYxSCDnEm/j+QWu6ecEzDtxaiXYvozVhP
         GrYlTT9qUcHjJ7SKnGBvyPkvBFAga/Z5tWgD2xAENUFPlL6H5ne63PQ0IGYZeJDuKweG
         +oMFYUHPIQ4bwSSfJ09zxZIqEREqJa8kfxaX17h+xwP5tBxPCocx6ANCbJdzFgk7oVwR
         /QrcBX1MqLYpJSm45IIwP74qjZeF319LZw2WmJ5KRm1Xe+JtbsIVJ5PCSJ50n3+Z9KmN
         zO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gN8Wq5E0N3HaFBsHRV9eya7b4jMZgDEegEG0/7rxU6Y=;
        b=MESju2UZ8LVS4b/NugiwCfbs0s+WMH4O3MGA91D9pEIm+nbOLU+ksJw1tnJ6452EgA
         FQYuvEtyEEyImGClg9xsAWxp/8oOJeYFirl4umTMX66eF0SlFVq6sh8w46Djgb8rllFh
         T6riT5HkgotfL8HwPnAxnW0WDboL3aFt79ZOs3jIESsng8VrDl4mAkDUCuS9wzs4M0GN
         5x98vaY9c+tzj3UnqMvC6wihnC3Icgfkh9kil4RgwoZGCZXl0gWEEH0FraPxBu2P+sI0
         3lSKibi7dtNAEtCaljjppJ8gyydrtnjzLkll4fYwN6feXvzPoGTBFMTfl8p2iw9Bfer3
         PtYw==
X-Gm-Message-State: AO0yUKXQkOuSFJIZu+Y1DHw6b84IoFzU/I4oTAG9yl0AAQpqXJDytggW
        kd8Kboz1j2CPT5QXji7Hc8o=
X-Google-Smtp-Source: AK7set++xleaE8Iw4YlNEsa+QphiRF4k9n4Zuxxob7UJsMazROSSd23CO1qgR/pRIHH2ikmmllOqcA==
X-Received: by 2002:a05:600c:314f:b0:3dc:4aa6:a8a9 with SMTP id h15-20020a05600c314f00b003dc4aa6a8a9mr3641957wmo.7.1675172256417;
        Tue, 31 Jan 2023 05:37:36 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc1d668866sm19247111wma.10.2023.01.31.05.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:37:35 -0800 (PST)
Message-ID: <2995be5e-88e9-f00d-7bce-2f7c9eb5724d@gmail.com>
Date:   Tue, 31 Jan 2023 14:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 12/14] soc: mediatek: mtk-svs: use svs get efuse common
 function
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-13-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-13-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 08:45, Roger Lu wrote:
> SVS might need to read both svs efuse and thermal efuse on the probe flow.
> Therefore, add a common efuse read function to remove the superfluous
> codes.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Looks good to me, could you please rebase.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/soc/mediatek/mtk-svs.c | 69 ++++++++++++----------------------
>   1 file changed, 24 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index bd23d1111d7b..a7f0a6f02d52 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1758,26 +1758,28 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
>   	return 0;
>   }
>   
> -static int svs_thermal_efuse_get_data(struct svs_platform *svsp)
> +static int svs_get_efuse_data(struct svs_platform *svsp,
> +			      const char *nvmem_cell_name,
> +			      u32 **svsp_efuse, size_t *svsp_efuse_max)
>   {
>   	struct nvmem_cell *cell;
>   
> -	/* Thermal efuse parsing */
> -	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> +	cell = nvmem_cell_get(svsp->dev, nvmem_cell_name);
>   	if (IS_ERR_OR_NULL(cell)) {
> -		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n", PTR_ERR(cell));
> +		dev_err(svsp->dev, "no \"%s\"? %ld\n",
> +			nvmem_cell_name, PTR_ERR(cell));
>   		return PTR_ERR(cell);
>   	}
>   
> -	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
> -	if (IS_ERR(svsp->tefuse)) {
> -		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
> -			PTR_ERR(svsp->tefuse));
> +	*svsp_efuse = nvmem_cell_read(cell, svsp_efuse_max);
> +	if (IS_ERR(*svsp_efuse)) {
> +		dev_err(svsp->dev, "cannot read \"%s\" efuse: %ld\n",
> +			nvmem_cell_name, PTR_ERR(*svsp_efuse));
>   		nvmem_cell_put(cell);
> -		return PTR_ERR(svsp->tefuse);
> +		return PTR_ERR(*svsp_efuse);
>   	}
>   
> -	svsp->tefuse_max /= sizeof(u32);
> +	*svsp_efuse_max /= sizeof(u32);
>   	nvmem_cell_put(cell);
>   
>   	return 0;
> @@ -1825,7 +1827,8 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
>   		svsb->vmax += svsb->dvt_fixed;
>   	}
>   
> -	ret = svs_thermal_efuse_get_data(svsp);
> +	ret = svs_get_efuse_data(svsp, "t-calibration-data",
> +				 &svsp->tefuse, &svsp->tefuse_max);
>   	if (ret)
>   		return false;
>   
> @@ -1930,7 +1933,8 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   		}
>   	}
>   
> -	ret = svs_thermal_efuse_get_data(svsp);
> +	ret = svs_get_efuse_data(svsp, "t-calibration-data",
> +				 &svsp->tefuse, &svsp->tefuse_max);
>   	if (ret)
>   		return false;
>   
> @@ -2039,32 +2043,6 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   	return true;
>   }
>   
> -static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
> -{
> -	struct nvmem_cell *cell;
> -
> -	/* Get svs efuse by nvmem */
> -	cell = nvmem_cell_get(svsp->dev, "svs-calibration-data");
> -	if (IS_ERR(cell)) {
> -		dev_err(svsp->dev, "no \"svs-calibration-data\"? %ld\n",
> -			PTR_ERR(cell));
> -		return false;
> -	}
> -
> -	svsp->efuse = nvmem_cell_read(cell, &svsp->efuse_max);
> -	if (IS_ERR(svsp->efuse)) {
> -		dev_err(svsp->dev, "cannot read svs efuse: %ld\n",
> -			PTR_ERR(svsp->efuse));
> -		nvmem_cell_put(cell);
> -		return false;
> -	}
> -
> -	svsp->efuse_max /= sizeof(u32);
> -	nvmem_cell_put(cell);
> -
> -	return true;
> -}
> -
>   static struct device *svs_get_subsys_device(struct svs_platform *svsp,
>   					    const char *node_name)
>   {
> @@ -2404,8 +2382,9 @@ static int svs_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	if (!svs_is_efuse_data_correct(svsp)) {
> -		dev_notice(svsp->dev, "efuse data isn't correct\n");
> +	ret = svs_get_efuse_data(svsp, "svs-calibration-data",
> +				 &svsp->efuse, &svsp->efuse_max);
> +	if (ret) {
>   		ret = -EPERM;
>   		goto svs_probe_free_efuse;
>   	}
> @@ -2413,13 +2392,13 @@ static int svs_probe(struct platform_device *pdev)
>   	if (!svsp_data->efuse_parsing(svsp)) {
>   		dev_err(svsp->dev, "efuse data parsing failed\n");
>   		ret = -EPERM;
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	ret = svs_bank_resource_setup(svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "svs bank resource setup fail: %d\n", ret);
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	svsp->main_clk = devm_clk_get(svsp->dev, "main");
> @@ -2427,12 +2406,12 @@ static int svs_probe(struct platform_device *pdev)
>   		dev_err(svsp->dev, "failed to get clock: %ld\n",
>   			PTR_ERR(svsp->main_clk));
>   		ret = PTR_ERR(svsp->main_clk);
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	ret = svs_clk_enable(svsp);
>   	if (ret)
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   
>   	svsp->base = of_iomap(svsp->dev->of_node, 0);
>   	if (IS_ERR_OR_NULL(svsp->base)) {
> @@ -2477,7 +2456,7 @@ static int svs_probe(struct platform_device *pdev)
>   svs_probe_clk_disable:
>   	svs_clk_disable(svsp);
>   
> -svs_probe_free_resource:
> +svs_probe_free_tefuse:
>   	if (!IS_ERR_OR_NULL(svsp->tefuse))
>   		kfree(svsp->tefuse);
>   
