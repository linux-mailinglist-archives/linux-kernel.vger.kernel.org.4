Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05565682DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjAaNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjAaNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:30:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78574DBF3;
        Tue, 31 Jan 2023 05:30:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7773768wms.4;
        Tue, 31 Jan 2023 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlJgCog2Hv8jB8412B4wI1AwEbA0UN9A/8RVLd437gg=;
        b=lmUEaSQsWaxheHAZrGoD6GfSUA+RbAdbdhfinS5hw+aurNtAA90Wnh8auikxHeq4Ls
         577MVNxMeg6DkKPS8Q894c48ZFihssvGG9cYaTB1ESrwBZCT4chLPszsO1ACGTR6Pl2j
         VqrbKRa/S6u4ensww/+oBfYBFB2cMnxV3v3M6IJHdkLc1DAvarp1W8dE6/5Haxg4LINk
         u4G1giaLslAjO9tVaezL2rzywjOay10Zg87QogUX3INl+qeWlzncVOzivNcs/VZiIAVK
         PVqBo+U5bNT5DxvfV9BRO7UyXU9FwqsEe7hPGaoEtVN9hidmPezh6PJ5xDPmFPa1V4uT
         FIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlJgCog2Hv8jB8412B4wI1AwEbA0UN9A/8RVLd437gg=;
        b=mpHZUNH73rFVF2KTuLnqY8nYfh+WkZD+ov5VNYIZrGRpE9/C3YbFNaF0WoGZYPZQcH
         YHrvjy5mAJhJCJ3E0b3c8xOyx4V/ejrc7LWmixkWycQO4JrJ6vY28L//af0YhO7Y2kaS
         wLY+9apJ5cZY0RjGEUr5DDBUxPyaptCGdygSYiLPxhh02q1Hzke/o20avsSHvyx0TKRf
         jhxQFnMNIqQuSMKCc3HrMTzA4U9kZq8C/pbwnbZtV3By/eOciar2dyJKcWovOytKGdmd
         Ts0DiYPtHn3dDZow/Kr4Ed/z5W/3W3jfMuvcoa3nmox3VAm6+pkViFiJmIeGNxYDRfq2
         s5Vg==
X-Gm-Message-State: AO0yUKUlYrml9RJINdwi73v+wUSyR9+PF7MnXIxIgvMszf7HuWheFWJi
        fW93NTAdyMjE0/CCutmN17I=
X-Google-Smtp-Source: AK7set8/csf6Jb47rd2+WT8vJqeSqRgiZXGTv0gl7wmEt9eROuj0FoQXqNwIKgx+X51hhlnfWyt1hw==
X-Received: by 2002:a1c:f014:0:b0:3dc:4318:d00d with SMTP id a20-20020a1cf014000000b003dc4318d00dmr14993723wmb.11.1675171846445;
        Tue, 31 Jan 2023 05:30:46 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c2ca600b003dd1bd66e0dsm2807447wmc.3.2023.01.31.05.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:30:45 -0800 (PST)
Message-ID: <bcb229bf-4243-05aa-93db-98af1c779880@gmail.com>
Date:   Tue, 31 Jan 2023 14:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 11/14] soc: mediatek: mtk-svs: delete superfluous
 platform data entries
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
 <20230111074528.29354-12-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-12-roger.lu@mediatek.com>
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
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The platform name and efuse parsing function pointer are only used while
> probing the device. Use them from the svs_platform_data struct instead.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 9d9210c22289..bd23d1111d7b 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -313,14 +313,12 @@ static const u32 svs_regs_v2[] = {
>   
>   /**
>    * struct svs_platform - svs platform control
> - * @name: svs platform name
>    * @base: svs platform register base
>    * @dev: svs platform device
>    * @main_clk: main clock for svs bank
>    * @pbank: svs bank pointer needing to be protected by spin_lock section
>    * @banks: svs banks that svs platform supports
>    * @rst: svs platform reset control
> - * @efuse_parsing: svs platform efuse parsing function pointer
>    * @efuse_max: total number of svs efuse
>    * @tefuse_max: total number of thermal efuse
>    * @regs: svs platform registers map
> @@ -330,14 +328,12 @@ static const u32 svs_regs_v2[] = {
>    * @clk_cnt: clock count shows the clk enable/disable times by svs driver
>    */
>   struct svs_platform {
> -	char *name;
>   	void __iomem *base;
>   	struct device *dev;
>   	struct clk *main_clk;
>   	struct svs_bank *pbank;
>   	struct svs_bank *banks;
>   	struct reset_control *rst;
> -	bool (*efuse_parsing)(struct svs_platform *svsp);
>   	size_t efuse_max;
>   	size_t tefuse_max;
>   	const u32 *regs;
> @@ -2066,7 +2062,7 @@ static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
>   	svsp->efuse_max /= sizeof(u32);
>   	nvmem_cell_put(cell);
>   
> -	return svsp->efuse_parsing(svsp);
> +	return true;
>   }
>   
>   static struct device *svs_get_subsys_device(struct svs_platform *svsp,
> @@ -2400,9 +2396,7 @@ static int svs_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	svsp->dev = &pdev->dev;
> -	svsp->name = svsp_data->name;
>   	svsp->banks = svsp_data->banks;
> -	svsp->efuse_parsing = svsp_data->efuse_parsing;
>   	svsp->regs = svsp_data->regs;
>   	svsp->bank_max = svsp_data->bank_max;
>   
> @@ -2413,6 +2407,12 @@ static int svs_probe(struct platform_device *pdev)
>   	if (!svs_is_efuse_data_correct(svsp)) {
>   		dev_notice(svsp->dev, "efuse data isn't correct\n");
>   		ret = -EPERM;
> +		goto svs_probe_free_efuse;
> +	}
> +
> +	if (!svsp_data->efuse_parsing(svsp)) {
> +		dev_err(svsp->dev, "efuse data parsing failed\n");
> +		ret = -EPERM;
>   		goto svs_probe_free_resource;
>   	}
>   
> @@ -2448,7 +2448,7 @@ static int svs_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> -					IRQF_ONESHOT, svsp->name, svsp);
> +					IRQF_ONESHOT, svsp_data->name, svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
>   			svsp_irq, ret);
> @@ -2478,11 +2478,13 @@ static int svs_probe(struct platform_device *pdev)
>   	svs_clk_disable(svsp);
>   
>   svs_probe_free_resource:
> -	if (!IS_ERR_OR_NULL(svsp->efuse))
> -		kfree(svsp->efuse);
>   	if (!IS_ERR_OR_NULL(svsp->tefuse))
>   		kfree(svsp->tefuse);
>   
> +svs_probe_free_efuse:
> +	if (!IS_ERR_OR_NULL(svsp->efuse))
> +		kfree(svsp->efuse);
> +
>   	return ret;
>   }
>   
