Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C497687DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBBMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjBBMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:47:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84658DAC2;
        Thu,  2 Feb 2023 04:47:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so1572017wrb.11;
        Thu, 02 Feb 2023 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0BrED6HiZlYLEkAtDG9DbtiZG4uzHzIJXFHLE8rceI=;
        b=XqlhWz7lsb3tcDfLY60BFq3pSD6FZci45LC7s17bbOLKfqq7Rd+os4HlSW7khhk4yA
         jUsjsHDsOP4owxQtHsRVd4GE9dfOI68Z9kLwdVkqn0q8BHWf+1TIJ1tIWTpInRUPMFLV
         dtLGkUJc4kUVO7xWN/Ej2eZ7jEfEh/1QpHvSMl7gpAKgHKY0qJKm7mJjUFEundCrPzwk
         1Mnsjqm34/zmyTxM1kdvlE5w1954IsMwF4YOFNnbbN4v37iHklTv8X5UKRLPaaEJ1ak5
         jgUc9MhTGwrl6YFpGIgBGRCztYJJlS38BK48UvLYegL/kouyqfp0RBP3npDHSz+4S8oy
         b3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0BrED6HiZlYLEkAtDG9DbtiZG4uzHzIJXFHLE8rceI=;
        b=VVvlidUx6vr5fcns06QL9rG63YKAP3RE2gGGcwgD60v2dJV2eX1gj3Y66NUTY1NA+K
         DJiw4IRK44OKtYAhYtaZehFNGeP8pgdcBSk2C2A4cxEKSmUz4gSdkgqzk41PrQbxSgre
         d+ELDv0wo1lCCbvqpSddJvK96UH5Mh6ozJLb+NYU0WVEcSAv+Ae5GdY0cjh83BsYWcN9
         /AgcJnkHdkZHcsUAkEQq0u4CMV9CmZFYMym1K6KTUFsQJAW6XPZNNB13mWT22oByBsH5
         HyTqEqbW75Advbg/egB1ajfULs1VrtpJxqSsAe95ZTZ/5hmokukdVH7KY5Pvf3th6ysA
         WSUg==
X-Gm-Message-State: AO0yUKVinccFDOCcs9eU4lo3wJKS7nYHse+EwpMvp+O/ve2di+Ok3aYa
        rKCyzCZ0slHiJvdDXxtQoBIVMsR+I5PP9w==
X-Google-Smtp-Source: AK7set8M/e7bCmXUmyvdGLd3KGUnk49hegzN9IjldxwFiSSTyQruNH77mmxylrX8iDTx++ADsy4ASw==
X-Received: by 2002:adf:a202:0:b0:2be:f21:6af6 with SMTP id p2-20020adfa202000000b002be0f216af6mr5420375wra.23.1675341983772;
        Thu, 02 Feb 2023 04:46:23 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe2c3000000b002bc7fcf08ddsm19583769wrj.103.2023.02.02.04.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:46:23 -0800 (PST)
Message-ID: <793fb7d0-1497-4051-d8cb-aaac7f0d07fd@gmail.com>
Date:   Thu, 2 Feb 2023 13:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/3] soc: mediatek: mtk-svs: use svs get efuse common
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
References: <20230202124104.16504-1-roger.lu@mediatek.com>
 <20230202124104.16504-2-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230202124104.16504-2-roger.lu@mediatek.com>
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



On 02/02/2023 13:41, Roger Lu wrote:
> SVS might need to read both svs efuse and thermal efuse on the probe flow.
> Therefore, add a common efuse read function to remove the superfluous
> codes.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Queued for the next merge window.

Thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 71 ++++++++++++----------------------
>   1 file changed, 25 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index f26eb2f637d5..c9899f5df60a 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1729,26 +1729,28 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
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
> @@ -1796,7 +1798,8 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
>   		svsb->vmax += svsb->dvt_fixed;
>   	}
>   
> -	ret = svs_thermal_efuse_get_data(svsp);
> +	ret = svs_get_efuse_data(svsp, "t-calibration-data",
> +				 &svsp->tefuse, &svsp->tefuse_max);
>   	if (ret)
>   		return false;
>   
> @@ -1901,7 +1904,8 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
>   		}
>   	}
>   
> -	ret = svs_thermal_efuse_get_data(svsp);
> +	ret = svs_get_efuse_data(svsp, "t-calibration-data",
> +				 &svsp->tefuse, &svsp->tefuse_max);
>   	if (ret)
>   		return false;
>   
> @@ -2003,32 +2007,6 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
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
> @@ -2364,8 +2342,9 @@ static int svs_probe(struct platform_device *pdev)
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
> @@ -2373,19 +2352,19 @@ static int svs_probe(struct platform_device *pdev)
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
>   	svsp_irq = platform_get_irq(pdev, 0);
>   	if (svsp_irq < 0) {
>   		ret = svsp_irq;
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	svsp->main_clk = devm_clk_get(svsp->dev, "main");
> @@ -2393,13 +2372,13 @@ static int svs_probe(struct platform_device *pdev)
>   		dev_err(svsp->dev, "failed to get clock: %ld\n",
>   			PTR_ERR(svsp->main_clk));
>   		ret = PTR_ERR(svsp->main_clk);
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	ret = clk_prepare_enable(svsp->main_clk);
>   	if (ret) {
>   		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
> -		goto svs_probe_free_resource;
> +		goto svs_probe_free_tefuse;
>   	}
>   
>   	svsp->base = of_iomap(svsp->dev->of_node, 0);
> @@ -2439,7 +2418,7 @@ static int svs_probe(struct platform_device *pdev)
>   svs_probe_clk_disable:
>   	clk_disable_unprepare(svsp->main_clk);
>   
> -svs_probe_free_resource:
> +svs_probe_free_tefuse:
>   	if (!IS_ERR_OR_NULL(svsp->tefuse))
>   		kfree(svsp->tefuse);
>   
