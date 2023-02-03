Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7175E689908
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBCMtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBCMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:49:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDEA99D7E;
        Fri,  3 Feb 2023 04:49:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lu11so15082973ejb.3;
        Fri, 03 Feb 2023 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdkcuT82p8T97dZNfa/gswkAFeJPKSBJAFohvHO/bRI=;
        b=OZbYZTdTJfVtSkqgYEfViPFeai+pEVmGoVGoVoAd53OMVbmribUmeFron14azDTrhV
         paed7vXkFaEZRTOL48jVJUPMpMPyvPUyfWzb4tql8XrveAxmOf45J2zuoSIOofW22oDi
         Law+DinVYj3+FaDF+vmh2GuhKg/+s3LEiMTZ2a4Uf6s/DjXnLRmmk12+LFcEA51opWBh
         pWzKrHGsUDARmoCOIAHP1WYKQEKUYK+gEzAIAdzH4ndz0pHGXFwr6tlQ6mxa8QxR0Wix
         d1QVFqNqcAaIL+bHg0+qg0fdzj9orFY2Ls8TsfzLedTXer3/j1nt/3SGgHOloR0SdZ4M
         QTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdkcuT82p8T97dZNfa/gswkAFeJPKSBJAFohvHO/bRI=;
        b=Azc0FTWuQ/iJQI08mcYmdnGWsEjqdTcqHFEffwidEhkot5UfIjw4LOo9Gl6wu809Zr
         7JqM7QyDqmf6UNHu2OJqc27fJdhYWkUktrkkRwFGIWICUnYAMVOMyUJg4cSgEkmwvX9N
         zsjeR0OcG+E4HqTsk66wi3sUcep9+zGdNOinCDdXpqahqEblqm+/WdHVZ2aOke/UbhiU
         YRqPM/nZICLmy988YHQFyh3WVwxdLJDjnCUYfXEom3HBOnk6E6F0gViwWMwVoHbSTTvu
         UPf+iNypudOJ1WufyUt1mexUjLTlO1XuCqFSW7pCFdXcEyfFM3vihWRdJzjDsYUp1Q9i
         CsNg==
X-Gm-Message-State: AO0yUKVw3UCt2chhQeLSGCgumaQrBP/+tMtPJmHiqpCOCBTjkOZF39oi
        vP6ZV/BbyLRhhsX92u6YUMHDeh/dkEA=
X-Google-Smtp-Source: AK7set8qjy14lXAC2/t7budDi+fip4yctUNSvjQzk8N+ZVr9irHTIItkLb7+4AHSJa8YbBCVxYPUzw==
X-Received: by 2002:a17:907:7672:b0:88d:f759:15b0 with SMTP id kk18-20020a170907767200b0088df75915b0mr10142059ejc.45.1675428580636;
        Fri, 03 Feb 2023 04:49:40 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id cd11-20020a170906b34b00b008720c458bd4sm1350809ejb.3.2023.02.03.04.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:49:39 -0800 (PST)
Message-ID: <13bceff4-1b40-46bd-6b80-11564a147b8f@gmail.com>
Date:   Fri, 3 Feb 2023 13:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-7-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 6/8] soc: mediatek: Add support for WAY_EN operations
In-Reply-To: <20230105170735.1637416-7-msp@baylibre.com>
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



On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This updates the power domain to support WAY_EN operations. These
> operations enable a path between different units of the chip and are
> labeled as 'way_en' in the register descriptions.
> 
> This operation is required by the mt8365 for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v4:
>      - Redesigned the patch to be better to understand and have less code
>        duplication
>      
>      Changes in v3:
>      - Separated the way_en functions for clarity
>      - Added some checks for infracfg_nao
>      
>      Changes in v2:
>      - some minor style fixes.
>      - Renamed 'wayen' to 'way_en' to clarify the meaning
>      - Updated commit message
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 57 ++++++++++++++++++++-------
>   drivers/soc/mediatek/mtk-pm-domains.h | 16 ++++++--
>   2 files changed, 54 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 999e1f6c86b0..d53309f050ee 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -43,6 +43,7 @@ struct scpsys_domain {
>   	struct clk_bulk_data *clks;
>   	int num_subsys_clks;
>   	struct clk_bulk_data *subsys_clks;
> +	struct regmap *infracfg_nao;
>   	struct regmap *infracfg;
>   	struct regmap *smi;
>   	struct regulator *supply;
> @@ -118,10 +119,13 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   }
>   
>   static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
> -				    struct regmap *regmap)
> +				    struct regmap *regmap,
> +				    struct regmap *sta_regmap)

I had a look at this and I don't like the idea to add another regmap that's used 
based on flag in scpsys_bus_prot_data.

Up to now the assumption was that the different actions to enable/disable bus 
protection were done using one regmap. For this reason the regmap was defined 
once in scpsys_domain. It's not a good design to just pass more and more regmaps 
or other members to the functions. We should try to find a better way to 
structure the data so that it fulfills our needs.

Possible solutions I can think of right now:
a) Pass a struct of two regmaps to _scpsys_bus_protect_[disable,enable]()
We can pass the second regmap only if pd->way_en is set, otherwise it will be 
ignored anyway.
It's less flexible if in the future we need another regmap. We will have two a 
flag to mark we use way_en twice, in struct scpsys_domain and in struct 
scpsys_domain_data. Please see my comment below. It's something else to think about.


b) Add a flag field to scpsys_bus_prot_data to say explicitely if we want to use 
infracfg, smi with/without way_en. Then we can pass all three regmaps in a 
struct, it will be easy to add new regmaps in the future.
Downsides:
1) We will overload even more the _BUS_PROT macros, which get's hard to read and 
understand already. Maybe that can somehow be fixed. An idea would be by adding 
a bit field to scpsys_bus_prot_data.
2) We will need to rework all the scpsys_domain_data structures for all SoCs 
already supported. It's doable, but it's some extra work.

Any other ideas?

>   {
>   	u32 val;
>   	u32 sta_mask = bpd->bus_prot_sta_mask;
> +	/* way_en acknowledges successful clear with the bit being set */
> +	u32 expected_ack = (bpd->way_en ? sta_mask : 0);
>   
>   	if (bpd->bus_prot_reg_update)
>   		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
> @@ -131,13 +135,14 @@ static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
>   	if (bpd->ignore_clr_ack)
>   		return 0;
>   
> -	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> -					val, !(val & sta_mask),
> +	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
> +					val, (val & sta_mask) == expected_ack,
>   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   }
>   
>   static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
> -				  struct regmap *regmap)
> +				  struct regmap *regmap,
> +				  struct regmap *sta_regmap)
>   {
>   	u32 val;
>   	u32 sta_mask = bpd->bus_prot_sta_mask;
> @@ -147,12 +152,13 @@ static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
>   	else
>   		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
>   
> -	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
> +	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
>   					val, (val & sta_mask) == sta_mask,
>   					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   }
>   
> -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> +				      struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
> @@ -160,9 +166,14 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
>   		if (!bpd[i].bus_prot_set_clr_mask)
>   			break;
>   
> -		ret = scpsys_bus_protect_set(&bpd[i], regmap);
> -		if (ret)
> +		if (bpd[i].way_en)
> +			ret = scpsys_bus_protect_clear(&bpd[i], regmap, infracfg_nao);
> +		else
> +			ret = scpsys_bus_protect_set(&bpd[i], regmap, regmap);
> +		if (ret) {
> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>   			return ret;
> +		}
>   	}
>   
>   	return 0;
> @@ -172,15 +183,17 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> +					 pd->infracfg, pd->infracfg_nao);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
>   }
>   
>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> -				       struct regmap *regmap)
> +				       struct regmap *regmap,
> +				       struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
> @@ -188,9 +201,14 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>   		if (!bpd[i].bus_prot_set_clr_mask)
>   			continue;
>   
> -		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
> -		if (ret)
> +		if (bpd[i].way_en)
> +			ret = scpsys_bus_protect_set(&bpd[i], regmap, infracfg_nao);
> +		else
> +			ret = scpsys_bus_protect_clear(&bpd[i], regmap, regmap);
> +		if (ret) {
> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>   			return ret;
> +		}
>   	}
>   
>   	return 0;
> @@ -200,11 +218,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
> +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
> +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
> +			pd->infracfg, pd->infracfg_nao);
>   }
>   
>   static int scpsys_regulator_enable(struct regulator *supply)
> @@ -378,6 +397,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   			return ERR_CAST(pd->smi);
>   	}
>   
> +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
> +	if (IS_ERR(pd->infracfg_nao)) {
> +		if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_WAY_EN))
> +			return ERR_CAST(pd->infracfg_nao);

I don't like the fact that we have a caps to show we have WAY_EN and then we 
have a bool in scpsys_bus_prot_data to flag when we need to use the second 
regmap and the expected_ack mask.
Can't we just make the lookup optional and let it all blow up if DTS is wrong 
because no infracfg-nao was defined while there is at least one domain using way_en?

Regards,
Matthias

> +
> +		pd->infracfg_nao = NULL;
> +	}
> +
>   	num_clks = of_clk_get_parent_count(node);
>   	if (num_clks > 0) {
>   		/* Calculate number of subsys_clks */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 34642a279213..1fa634509db1 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -10,6 +10,7 @@
>   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
>   /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
>   #define MTK_SCPD_ALWAYS_ON		BIT(5)
> +#define MTK_SCPD_HAS_WAY_EN		BIT(6)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
> @@ -41,7 +42,7 @@
>   
>   #define SPM_MAX_BUS_PROT_DATA		6
>   
> -#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _update, _ignore) {	\
> +#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _update, _ignore, _way_en) {	\
>   		.bus_prot_set_clr_mask = (_set_clr_mask),	\
>   		.bus_prot_set = _set,				\
>   		.bus_prot_clr = _clr,				\
> @@ -49,16 +50,20 @@
>   		.bus_prot_sta = _sta,				\
>   		.bus_prot_reg_update = _update,			\
>   		.ignore_clr_ack = _ignore,			\
> +		.way_en = _way_en,				\
>   	}
>   
>   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false, false)
>   
>   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true)
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, false)
>   
>   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _mask, _sta, true, false)
> +		_BUS_PROT(_mask, _set, _clr, _mask, _sta, true, false, false)
> +
> +#define BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
> +		_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta, true, false, true)
>   
>   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>   		BUS_PROT_UPDATE(_mask,				\
> @@ -77,6 +82,8 @@
>    *			 write the whole register.
>    * @ignore_clk_ack: Ignore the result in the status register for clear
>    *		    operations.
> + * @way_en: Enable a way in the SoC. For this type the status bit to acknowledge
> + *	    the change is always 1 on successful change.
>    */
>   struct scpsys_bus_prot_data {
>   	u32 bus_prot_set_clr_mask;
> @@ -86,6 +93,7 @@ struct scpsys_bus_prot_data {
>   	u32 bus_prot_sta;
>   	bool bus_prot_reg_update;
>   	bool ignore_clr_ack;
> +	bool way_en;
>   };
>   
>   /**
