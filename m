Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0125B7961
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIMSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiIMSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:23:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0437D780;
        Tue, 13 Sep 2022 10:40:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r66-20020a1c4445000000b003b494ffc00bso1417434wma.0;
        Tue, 13 Sep 2022 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=RdcHjCsaDefRyRHPR0Hf32H56umlXY/a3I9R1lAvmqE=;
        b=HdqvJv4L3oxVYNAKEvHjg8zsMVYeFw5KPG/P4O6yLBF1ihpgWdDfe3xhnPIc9kbr1J
         gX1ZBxQ4uB2CM9EQkOM6sMsjHau2MaLuVfa0VhGE5326tzQCWOTt0SAcY5Iby//SWwXP
         7ebcXFuTj5or574nUaTD9kckuhjMH3lAjo7KQ3/wGNKSDPA5jmKvK3u9cj/YneZKrUNX
         88pcMcyieas6UIPrvaN0yKNSYpLOVd3fP2puugbjt/QlZmULwgJTYJ636qVxTKb7ALEJ
         s6VpK6Mme+p/iZjJFiYkhQPCIffIboA2OtpdCZ/E5THq7Cr/HLkTS0eWdy/5wLw2fmF3
         qpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RdcHjCsaDefRyRHPR0Hf32H56umlXY/a3I9R1lAvmqE=;
        b=JgKHmpm2WyT/fQIjvThGVgyRtNxmQynbhDu64SWi8x6y0B9mq/PkfWV4xn5H8LG2x0
         OPUP+0HH3TVAlLIqSZPFmb/8B0HcXQdRSqYM2CWgkmvdG2Jjv77F/qC5m50ZNnnmoGsZ
         OZ92tcMoQzWy0wEAGV3ma3Id8tWhzmVK1VtSB07nDoIfQubl8l1/BIHDHo1/xwccCA7M
         uxLD8BFzraShwUFplsADX8xIjzzOoOyvsTXE4a32bvj5ZS4q6t35O9GnvmYTgovvzJPa
         06aVnrnKp2MY1Ft7GY30n0sliAhmqkYmkdN6yl/1o974sSvxlohWryY09hqkwbR9xAig
         S9nQ==
X-Gm-Message-State: ACgBeo3+2JuQ256PcEO4B4grr+8LYBNlsDAkRUcFB5HDNKsRj7GpQ+KH
        h2GCghEwrMDHutxMj9LrwpQ=
X-Google-Smtp-Source: AA6agR7R7b+h2yDACiO3/VXG6La/kBP6aq0KZamqGaIhlOdXIIIbpnrzg7LRG5xnMiuJJS7zZhj79A==
X-Received: by 2002:a05:600c:3583:b0:3a7:eeaf:62d3 with SMTP id p3-20020a05600c358300b003a7eeaf62d3mr310690wmq.170.1663090830375;
        Tue, 13 Sep 2022 10:40:30 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id id11-20020a05600ca18b00b003b332a7b898sm13909084wmb.45.2022.09.13.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:40:29 -0700 (PDT)
Message-ID: <ef8215be-1b68-09b7-ca93-f32a0acd9d5c@gmail.com>
Date:   Tue, 13 Sep 2022 19:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
 <20220822144303.3438467-3-msp@baylibre.com>
 <36dde9aa-b6ea-7194-c1bc-94d52c02649b@gmail.com>
 <20220906094947.ghfy2tj4bj4kaule@blmsp>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/4] soc: mediatek: Add support of WAY_EN operations
In-Reply-To: <20220906094947.ghfy2tj4bj4kaule@blmsp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2022 11:49, Markus Schneider-Pargmann wrote:
> Hi Matthias,
> 
> On Mon, Aug 22, 2022 at 06:17:58PM +0200, Matthias Brugger wrote:
>>
>>
>> On 22/08/2022 16:43, Markus Schneider-Pargmann wrote:
>>> From: Alexandre Bailon <abailon@baylibre.com>
>>>
>>> This updates the power domain to support WAY_EN operations. These
>>> operations enable a path between different units of the chip and are
>>> labeled as 'way_en' in the register descriptions.

If you can come up with a more verbose description of WAY_EN functionality it 
would be appreciated, although I know it's not always easy to get that 
information. 10 years in it will help to understand better what this is about.

>>>
>>> This operation is required by the mt8365 for the MM power domain.
>>>
>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>>
>>> Notes:
>>>       Changes in v3:
>>>       - Separated the way_en functions for clarity
>>>       - Added some checks for infracfg_nao
>>>       Changes in v2:
>>>       - some minor style fixes.
>>>       - Renamed 'wayen' to 'way_en' to clarify the meaning
>>>       - Updated commit message
>>>
>>>    drivers/soc/mediatek/mtk-pm-domains.c | 162 +++++++++++++++++++++-----
>>>    drivers/soc/mediatek/mtk-pm-domains.h |  28 +++--
>>>    2 files changed, 149 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>>> index 9734f1091c69..c2cbe0de6aa1 100644
>>> --- a/drivers/soc/mediatek/mtk-pm-domains.c
>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>>> @@ -43,6 +43,7 @@ struct scpsys_domain {
>>>    	struct clk_bulk_data *clks;
>>>    	int num_subsys_clks;
>>>    	struct clk_bulk_data *subsys_clks;
>>> +	struct regmap *infracfg_nao;
>>>    	struct regmap *infracfg;
>>>    	struct regmap *smi;
>>>    	struct regulator *supply;
>>> @@ -117,26 +118,61 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>>>    					MTK_POLL_TIMEOUT);
>>>    }
>>> -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
>>> +static int __scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
>>> +				       struct regmap *regmap)
>>> +{
>>> +	u32 val;
>>> +	u32 mask = bpd->bus_prot_mask;
>>> +	u32 sta_mask = bpd->bus_prot_sta_mask;
>>> +
>>> +	if (bpd->bus_prot_reg_update)
>>> +		regmap_set_bits(regmap, bpd->bus_prot_set, mask);
>>> +	else
>>> +		regmap_write(regmap, bpd->bus_prot_set, mask);
>>> +
>>> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta, val,
>>> +					(val & sta_mask) == sta_mask,
>>> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> +}
>>> +
>>> +static int scpsys_bus_way_disable(const struct scpsys_bus_prot_data *bpd,
>>> +				  struct regmap *regmap,
>>> +				  struct regmap *ack_regmap)
>>> +{
>>> +	u32 val;
>>> +	u32 mask = bpd->bus_prot_mask;
>>> +	u32 sta_mask = bpd->bus_prot_sta_mask;
>>> +
>>> +	if (bpd->bus_prot_reg_update)
>>> +		regmap_clear_bits(regmap, bpd->bus_prot_set, mask);
>>> +	else
>>> +		regmap_write(regmap, bpd->bus_prot_set, mask);

BUS_PROT_WAY_EN sets bus_prot_reg_update to true, what do we need the else 
branch for?

>>> +
>>> +	if (bpd->ignore_clr_ack)
>>> +		return 0;

Same here, ignore_clr_ack is always false.

Actually it seems to me that __scpsys_bus_protect_enable and 
scpsys_bus_way_disable is nearly the same (other regmap, regmap_clear_bits 
instead of set_bits). Can't we put the check of way_en in e.g. the old 
_scpsys_bus_protect_enable to get rid of all the code duplication?

>>> +
>>> +	return regmap_read_poll_timeout(ack_regmap, bpd->bus_prot_sta, val,
>>> +					(val & sta_mask) == sta_mask,
>>> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> +}
>>> +
>>> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
>>> +				      struct regmap *regmap, struct regmap *infracfg_nao)
>>>    {
>>>    	int i, ret;
>>>    	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
>>> -		u32 val, mask = bpd[i].bus_prot_mask;
>>> -
>>> -		if (!mask)
>>> +		if (!bpd[i].bus_prot_mask)
>>>    			break;
>>> -		if (bpd[i].bus_prot_reg_update)
>>> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
>>> +		if (bpd[i].way_en)
>>> +			ret = scpsys_bus_way_disable(&bpd[i], regmap, infracfg_nao);
>>>    		else
>>> -			regmap_write(regmap, bpd[i].bus_prot_set, mask);
>>> -
>>> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>> -					       val, (val & mask) == mask,
>>> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> -		if (ret)
>>> +			ret = __scpsys_bus_protect_enable(&bpd[i], regmap);
>>> +		if (ret) {
>>> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>>>    			return ret;
>>> +		}
>>>    	}
>>>    	return 0;
>>> @@ -146,37 +182,71 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>>>    {
>>>    	int ret;
>>> -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
>>> +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
>>> +					 pd->infracfg, pd->infracfg_nao);
>>>    	if (ret)
>>>    		return ret;
>>> -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
>>> +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
>>> +}
>>> +
>>> +static int __scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>>> +					struct regmap *regmap)
>>> +{
>>> +	u32 val;
>>> +	u32 mask = bpd->bus_prot_mask;
>>> +	u32 sta_mask = bpd->bus_prot_sta_mask;
>>> +
>>> +	if (bpd->bus_prot_reg_update)
>>> +		regmap_clear_bits(regmap, bpd->bus_prot_clr, mask);
>>> +	else
>>> +		regmap_write(regmap, bpd->bus_prot_clr, mask);
>>> +
>>> +	if (bpd->ignore_clr_ack)
>>> +		return 0;
>>> +
>>> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta, val,
>>> +					!(val & sta_mask), MTK_POLL_DELAY_US,
>>> +					MTK_POLL_TIMEOUT);
>>> +}
>>> +
>>> +static int scpsys_bus_way_enable(const struct scpsys_bus_prot_data *bpd,
>>> +				 struct regmap *regmap,
>>> +				 struct regmap *ack_regmap)
>>> +{
>>> +	u32 val;
>>> +	u32 mask = bpd->bus_prot_mask;
>>> +	u32 sta_mask = bpd->bus_prot_sta_mask;
>>> +
>>> +	if (bpd->bus_prot_reg_update)
>>> +		regmap_set_bits(regmap, bpd->bus_prot_clr, mask);
>>> +	else
>>> +		regmap_write(regmap, bpd->bus_prot_clr, mask);

same as disable case.

>>> +
>>> +	return regmap_read_poll_timeout(ack_regmap, bpd->bus_prot_sta, val,
>>> +					(val & sta_mask) == sta_mask,
>>> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>>    }
>>>    static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
>>> -				       struct regmap *regmap)
>>> +				       struct regmap *regmap,
>>> +				       struct regmap *infracfg_nao)
>>>    {
>>>    	int i, ret;
>>>    	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
>>> -		u32 val, mask = bpd[i].bus_prot_mask;
>>> -
>>> -		if (!mask)
>>> +		if (!bpd[i].bus_prot_mask)
>>>    			continue;
>>> -		if (bpd[i].bus_prot_reg_update)
>>> -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
>>> +		if (bpd[i].way_en)
>>> +			ret = scpsys_bus_way_enable(&bpd[i], regmap,
>>> +						    infracfg_nao);
>>>    		else
>>> -			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>>> -
>>> -		if (bpd[i].ignore_clr_ack)
>>> -			continue;
>>> -
>>> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
>>> -					       val, !(val & mask),
>>> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>> -		if (ret)
>>> +			ret = __scpsys_bus_protect_disable(&bpd[i], regmap);
>>> +		if (ret) {
>>> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>>>    			return ret;
>>> +		}
>>>    	}
>>>    	return 0;
>>> @@ -186,11 +256,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>>>    {
>>>    	int ret;
>>> -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
>>> +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
>>>    	if (ret)
>>>    		return ret;
>>> -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
>>> +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
>>> +			pd->infracfg, pd->infracfg_nao);
>>>    }
>>>    static int scpsys_regulator_enable(struct regulator *supply)
>>> @@ -294,6 +365,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>>>    	return 0;
>>>    }
>>> +static bool scpsys_bp_infracfg_has_way_en(const struct scpsys_bus_prot_data *bpd)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
>>> +		if (!bpd[i].bus_prot_mask)
>>> +			break;
>>
>> So MT8365_POWER_DOMAIN_MM will return false as the first member of
>> bp_infracfg is BUS_PROT_WR(...)
> 
> I am not sure I understand what you mean. Why should it break out of the
> loop if the first member is a BUS_PROT_WR()? BUS_PROT_WR() sets a mask
> as well which is checked here exactly the same way as is done in
> _scpsys_bus_protect_enable() even before this patch.

Right, my error, please see comment further down about the new macros.

> 
> This is only a loop condition. Actually I can move it into the loop
> header as well. Either you define SPM_MAX_BUS_PROT_DATA fields or you
> have to exit if you find a field that is empty, basically the mask not
> being set.
> 
>>
>> Apart from that, why don't you use a CAPS to acheive the same?
>>

Just in case you missed that. I'd pretty much prefer to add a caps to 
scpsys_domain_data signaling that the power domain uses WAY_EN.

>>> +
>>> +		if (bpd[i].way_en)
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static struct
>>>    generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
>>>    {
>>> @@ -364,6 +450,20 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>>>    			return ERR_CAST(pd->smi);
>>>    	}
>>> +	if (scpsys_bp_infracfg_has_way_en(pd->data->bp_smi)) {
>>> +		dev_err(scpsys->dev, "bp_smi does not support WAY_EN\n");
>>
>> Do we really need to check the correctness of the driver data at runtime?
> 
> bp_smi is called without a infracfg_nao regmap. If we don't check it
> here, we need to make a check during bus protection operations. Last
> time I got a review to not do it during in the bus protection path.
> 

Maybe I'm missing something here but bpi_smi is defined in the 
scpsys_domain_data. Why do we need to check at runtime if the SoC specific data 
hardcoded in the dirver is correct? What am I missing here?

Apart do I understand correctly that the second call to 
_scpsys_bus_protect_enable() in scpsys_bus_protect_enable() will never use 
way_en? My understanding that this also holds for the disable path. Can't we 
remodel the code that in this case we don't loop over scpsys_bus_prot_data and 
check for way_en?

>>
>>> +		return ERR_PTR(-EINVAL);
>>> +	}
>>> +
>>> +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(
>>> +		node, "mediatek,infracfg_nao");
>>
>> Not in the binding description.
> 
> Thanks, I will fix that for the next version.
> 
>>
>>> +	if (IS_ERR(pd->infracfg_nao)) {
>>> +		if (scpsys_bp_infracfg_has_way_en(pd->data->bp_infracfg))
>>> +			return ERR_CAST(pd->infracfg_nao);
>>> +
>>> +		pd->infracfg_nao = NULL;
>>> +	}
>>> +
>>>    	num_clks = of_clk_get_parent_count(node);
>>>    	if (num_clks > 0) {
>>>    		/* Calculate number of subsys_clks */
>>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
>>> index 7d3c0c36316c..974c68a1d89c 100644
>>> --- a/drivers/soc/mediatek/mtk-pm-domains.h
>>> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
>>> @@ -41,23 +41,29 @@
>>>    #define SPM_MAX_BUS_PROT_DATA		6
>>> -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
>>> -		.bus_prot_mask = (_mask),			\
>>> -		.bus_prot_set = _set,				\
>>> -		.bus_prot_clr = _clr,				\
>>> -		.bus_prot_sta = _sta,				\
>>> -		.bus_prot_reg_update = _update,			\
>>> -		.ignore_clr_ack = _ignore,			\
>>> +#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _way_en) {	\

_sta_mask is second parameter but not second member of the struct. That makes 
reading the driver unnecessary complicated.

>>> +		.bus_prot_mask = (_mask),				\
>>> +		.bus_prot_set = _set,					\
>>> +		.bus_prot_clr = _clr,					\
>>> +		.bus_prot_sta = _sta,					\
>>> +		.bus_prot_sta_mask = _sta_mask,				\
>>> +		.bus_prot_reg_update = _update,				\
>>> +		.ignore_clr_ack = _ignore,				\
>>> +		.way_en = _way_en,					\
>>>    	}
>>>    #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
>>> -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
>>> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, false, false)
>>>    #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
>>> -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
>>> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, true, false)
>>>    #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
>>> -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
>>> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, true, false, false)
>>> +
>>> +#define BUS_PROT_WAY_EN(_en_mask, _sta_mask, _set, _sta)	\
>>> +		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, \
>>> +			  true)
>>>    #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>>>    		BUS_PROT_UPDATE(_mask,				\
>>> @@ -70,8 +76,10 @@ struct scpsys_bus_prot_data {
>>>    	u32 bus_prot_set;
>>>    	u32 bus_prot_clr;
>>>    	u32 bus_prot_sta;
>>> +	u32 bus_prot_sta_mask;
>>
>> I'm not very happy with the naming. In the end we need an extra mask for bus
>> protection using WAY_EN. But right now I can't come up with a good name.
> 
> I think the naming is good as it is a specific mask for the status
> register. bus_prot_mask is now basically only responsible for set and
> clr. Maybe renaming bus_prot_mask to bus_prot_set_clr_mask is better?

Yes makes sense. Please add this as an extra patch for easier review.

Regards,
Matthias

> 
> Thanks,
> Markus
> 
>>
>> Regards,
>> Matthias
>>
>>>    	bool bus_prot_reg_update;
>>>    	bool ignore_clr_ack;
>>> +	bool way_en;
>>>    };
>>>    /**
