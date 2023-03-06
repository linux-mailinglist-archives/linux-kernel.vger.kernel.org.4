Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6596ABF53
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCFMRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCFMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:17:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2464C23848
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:17:45 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k14so12432050lfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678105063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tywIYiajyKhDMX8BsRmE7+yi5EgYdyBZsJxSf1fD38Q=;
        b=FoV99iSFQr/kxSYFV6axZ0M13+gY6YSkcyvlixPqzJhCMfs3Q8sdwry5NsM9PMvgVl
         gqI6QmUamoyYOOuNTgLlyYwcT5gT13fA0wWFH8fur6TXdyyT87zm8cIEnrC2Yruec7qH
         odbKCoXzeYMN3tXpv/MOWdSGHt33S6cPsjeqm++1FTVR7EH0w8Jjf8TrFNFMayz0+AgR
         CM6Erw8xGs65EyJ7a3InhkBXLIEtYuTTX527oAL2Mh2H4xHGadZGeQPNBvk358ExhYDB
         PvtZfrTESXIy/9K11DvYXV9FVPfoj0UhTK0PA8PDDeBlUZ3QHlje33IV1XZPi0Fk5+Wo
         t9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678105063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tywIYiajyKhDMX8BsRmE7+yi5EgYdyBZsJxSf1fD38Q=;
        b=8Ghu79xXUKjLDqp5cthE8d1znJIukJWQxGHjn9v94m5nNvF4hCPhIGiZ8CQ8UozYM3
         lDKekPMQQ4kKM4oOKUe1FAYkp5PUOe/+YiRNZ5Dhf0VM8E5e3+gI0kHhMgTUklhNxTZC
         97V+ZrRv0XrEFnp07r/X31dGYCyw0kEIHl1uPvjOnE1sHYCl5//Fqr/YfnWATbnx6qpP
         fJbzFxTeZ31sJc2b6MES6PaMPHVlHVF0MVieHYRx91crWmI3Ijvuk/SgiAWv2+VFsLN8
         20zL7HDoI6SFq5NP1uYmHhqPhrvGZrVYXDpWa+FT4MY0yOD+MZXw4FaBsF2O3sfKiUEn
         eW3A==
X-Gm-Message-State: AO0yUKUjm16ReWNdpaD6FLrkB5eZgbJ9LBm8ufUxtGN9q6rYVUftR9v3
        KnpZbqM1PG20vMUV8K26LrOvUw==
X-Google-Smtp-Source: AK7set+Mc6ICGgSVxZJldLLv1O01fUifq7XAygCN1fYZBFbXYI/3Fx5M3QE2F7qX6OWS4FRNYekl7A==
X-Received: by 2002:ac2:5633:0:b0:4dd:9f86:859d with SMTP id b19-20020ac25633000000b004dd9f86859dmr2559754lff.13.1678105063286;
        Mon, 06 Mar 2023 04:17:43 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id n14-20020a19550e000000b004db1b99055dsm1636127lfe.229.2023.03.06.04.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 04:17:42 -0800 (PST)
Message-ID: <8ab61b63-3d5f-0ea1-3624-5e167832e357@linaro.org>
Date:   Mon, 6 Mar 2023 13:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] soc: qcom: icc-bwmon: Handle global registers
 correctly
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
 <20230304-topic-ddr_bwmon-v1-2-e563837dc7d1@linaro.org>
 <a85c9c5d-b57d-9212-0e24-1991b5b580b3@linaro.org>
 <56b5e7ff-2dbe-74da-c325-5e5cf546b1ff@linaro.org>
 <2b086263-6b42-b882-6d38-1c4dbc361773@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2b086263-6b42-b882-6d38-1c4dbc361773@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.03.2023 13:09, Krzysztof Kozlowski wrote:
> On 06/03/2023 11:06, Konrad Dybcio wrote:
>>
>>
>> On 5.03.2023 16:06, Krzysztof Kozlowski wrote:
>>> On 04/03/2023 16:39, Konrad Dybcio wrote:
>>>> The BWMON hardware has two sets of registers: one for the monitor itself
>>>> and one called "global". It has what seems to be some kind of a head
>>>> switch and an interrupt control register. It's usually 0x200 in size.
>>>>
>>>> On fairly recent SoCs (with the starting point seemingly being moving
>>>> the OSM programming to the firmware) these two register sets are
>>>> contiguous and overlapping, like this (on sm8450):
>>>>
>>>> /* notice how base.start == global_base.start+0x100 */
>>>> reg = <0x90b6400 0x300>, <0x90b6300 0x200>;
>>>> reg-names = "base", "global_base";
>>>>
>>>> Which led to some confusion and the assumption that since the
>>>> "interesting" global registers begin right after global_base+0x100,
>>>> there's no need to map two separate regions and one can simply subtract
>>>> 0x100 from the offsets.
>>>>
>>>> This is however not the case for anything older than SDM845, as the
>>>> global region can appear in seemingly random spots on the register map.
>>>>
>>>> Add support for it to let bwmon function on older SoCs like MSM8998 and
>>>> allow operation with just one set of registers for newer platforms.
>>>>
>>>> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
>>>
>>> You did not describe any bug to be fixed. Adding support for different
>>> devices with different memory layour is a feature, not bugfix. If this
>>> is a bugfix, please share what exactly is broken on sdm845?
>> The driver was completely broken for MSM8998, even though it
>> had a compatible specifically for that SoC.
> 
> That's still nothing to fix - msm8998 was added here only for
> compatibility reasons for bindings. It wasn't ever tested on MSM8998 and
> also probably never written in a way that it should work for MSM8998.
Don't you think making something like

compatible = "qcom,msm8998-bwmon"

not actually compatible with MSM8998 is a bit wrong?

 It
> could work, but that was not the intention. The driver is supposed to
> work on sdm845 and according to your description - there is nothing
> wrong with that.
> 
>>
>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/soc/qcom/icc-bwmon.c | 136 +++++++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 118 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>>>> index d07be3700db6..9ef632d80ee3 100644
>>>> --- a/drivers/soc/qcom/icc-bwmon.c
>>>> +++ b/drivers/soc/qcom/icc-bwmon.c
>>>> @@ -34,14 +34,27 @@
>>>>  /* Internal sampling clock frequency */
>>>>  #define HW_TIMER_HZ				19200000
>>>>  
>>>> -#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x008
>>>> -#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x00c
>>>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x108
>>>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x10c
>>>>  /*
>>>>   * All values here and further are matching regmap fields, so without absolute
>>>>   * register offsets.
>>>>   */
>>>>  #define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
>>>>  
>>>> +/*
>>>> + * Starting with SDM845, the BWMON4 register space has changed a bit:
>>>> + * the global registers were jammed into the beginning of the monitor region.
>>>> + * To keep the proper offsets, one would have to map <GLOBAL_BASE 0x200> and
>>>> + * <GLOBAL_BASE+0x100 0x300>, which is straight up wrong.
>>>> + * To facilitate for that, while allowing the older, arguably more proper
>>>> + * implementations to work, offset the global registers by -0x100 to avoid
>>>> + * having to map half of the global registers twice.
>>>> + */
>>>> +#define BWMON_V4_845_OFFSET			0x100
>>>
>>> MSM8998? It's a bit confusing to keep calling it 845 while it is for
>>> MSM8998 variant... or it's not anymore for MSM8998?
>> No, it's for 845 and up.
> 
> If it is for 845 and up, why then it is used for msm8998 in
> msm8998_bwmon_reg_noread_ranges?
Ouch, it should have never gotten there. msm8998_bwmon_global_reg_fields
uses the correct one.

> 
>>
>>>
>>>
>>>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR_845		(BWMON_V4_GLOBAL_IRQ_CLEAR - BWMON_V4_845_OFFSET)
>>>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE_845		(BWMON_V4_GLOBAL_IRQ_ENABLE - BWMON_V4_845_OFFSET)
>>>> +
>>>>  #define BWMON_V4_IRQ_STATUS			0x100
>>>>  #define BWMON_V4_IRQ_CLEAR			0x108
>>>>  
>>>> @@ -118,8 +131,10 @@
>>>>  #define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
>>>>  
>>>>  enum bwmon_fields {
>>>> -	F_GLOBAL_IRQ_CLEAR,
>>>> -	F_GLOBAL_IRQ_ENABLE,
>>>> +	/* Fields used only on >=SDM845 with BWMON_HAS_GLOBAL_IRQ */
>>>> +	F_GLB_IRQ_CLEAR,
>>>> +	F_GLB_IRQ_ENABLE,
>>>
>>> I am not sure what's the benefit of this rename.
>> I need to somehow differentiate the members of enum bwmon_fields
>> and enum bwmon_global_fields, keeping the "_GLOBAL" in global_fields
>> seems to make the most sense, imo.
> 
> This complicates and makes code difficult to read. The entire driver was
> designed for single address space to make everything a bit simpler and
> easier to read, so any changes should not reduce this. Maybe just use
> the same defines?
I suppose that could work with some shuffling..

Or name the other fields MSM8998?
> 
>>
>>>
>>>> +
>>>>  	F_IRQ_STATUS,
>>>>  	F_IRQ_CLEAR,
>>>>  	F_IRQ_ENABLE,
>>>> @@ -145,6 +160,13 @@ enum bwmon_fields {
>>>>  	F_NUM_FIELDS
>>>>  };
>>>>  
>>>> +enum bwmon_global_fields {
>>>> +	F_GLOBAL_IRQ_CLEAR,
>>>> +	F_GLOBAL_IRQ_ENABLE,
>>>> +
>>>> +	F_NUM_GLOBAL_FIELDS
>>>> +};
>>>> +
>>>>  struct icc_bwmon_data {
>>>>  	unsigned int sample_ms;
>>>>  	unsigned int count_unit_kb; /* kbytes */
>>>> @@ -157,6 +179,9 @@ struct icc_bwmon_data {
>>>>  
>>>>  	const struct regmap_config *regmap_cfg;
>>>>  	const struct reg_field *regmap_fields;
>>>> +
>>>> +	const struct regmap_config *global_regmap_cfg;
>>>> +	const struct reg_field *global_regmap_fields;
>>>>  };
>>>>  
>>>>  struct icc_bwmon {
>>>> @@ -166,6 +191,7 @@ struct icc_bwmon {
>>>>  
>>>>  	struct regmap *regmap;
>>>>  	struct regmap_field *regs[F_NUM_FIELDS];
>>>> +	struct regmap_field *global_regs[F_NUM_FIELDS];
>>>>  
>>>>  	unsigned int max_bw_kbps;
>>>>  	unsigned int min_bw_kbps;
>>>> @@ -175,8 +201,8 @@ struct icc_bwmon {
>>>>  
>>>>  /* BWMON v4 */
>>>>  static const struct reg_field msm8998_bwmon_reg_fields[] = {
>>>> -	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
>>>> -	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
>>>> +	[F_GLB_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0, 0),
>>>> +	[F_GLB_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE_845, 0, 0),
>>>>  	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
>>>>  	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
>>>>  	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
>>>> @@ -202,7 +228,7 @@ static const struct reg_field msm8998_bwmon_reg_fields[] = {
>>>>  };
>>>>  
>>>>  static const struct regmap_range msm8998_bwmon_reg_noread_ranges[] = {
>>>> -	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
>>>> +	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR_845, BWMON_V4_GLOBAL_IRQ_CLEAR_845),
>>>>  	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
>>>>  	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
>>>>  };
>>>> @@ -222,16 +248,34 @@ static const struct regmap_access_table msm8998_bwmon_reg_volatile_table = {
>>>>  	.n_yes_ranges	= ARRAY_SIZE(msm8998_bwmon_reg_volatile_ranges),
>>>>  };
>>>>  
>>>> +static const struct reg_field msm8998_bwmon_global_reg_fields[] = {
>>>> +	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
>>>> +	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
>>>> +};
>>>> +
>>>> +static const struct regmap_range msm8998_bwmon_global_reg_noread_ranges[] = {
>>>> +	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
>>>> +};
>>>> +
>>>> +static const struct regmap_access_table msm8998_bwmon_global_reg_read_table = {
>>>> +	.no_ranges	= msm8998_bwmon_global_reg_noread_ranges,
>>>> +	.n_no_ranges	= ARRAY_SIZE(msm8998_bwmon_global_reg_noread_ranges),
>>>> +};
>>>> +
>>>>  /*
>>>>   * Fill the cache for non-readable registers only as rest does not really
>>>>   * matter and can be read from the device.
>>>>   */
>>>>  static const struct reg_default msm8998_bwmon_reg_defaults[] = {
>>>> -	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
>>>> +	{ BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0x0 },
>>>>  	{ BWMON_V4_IRQ_CLEAR, 0x0 },
>>>>  	{ BWMON_V4_CLEAR, 0x0 },
>>>>  };
>>>>  
>>>> +static const struct reg_default msm8998_bwmon_global_reg_defaults[] = {
>>>> +	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
>>>> +};
>>>> +
>>>>  static const struct regmap_config msm8998_bwmon_regmap_cfg = {
>>>>  	.reg_bits		= 32,
>>>>  	.reg_stride		= 4,
>>>> @@ -252,10 +296,27 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
>>>>  	.cache_type		= REGCACHE_RBTREE,
>>>>  };
>>>>  
>>>> +static const struct regmap_config msm8998_bwmon_global_regmap_cfg = {
>>>> +	.reg_bits		= 32,
>>>> +	.reg_stride		= 4,
>>>> +	.val_bits		= 32,
>>>> +	/*
>>>> +	 * No concurrent access expected - driver has one interrupt handler,
>>>> +	 * regmap is not shared, no driver or user-space API.
>>>> +	 */
>>>> +	.disable_locking	= true,
>>>> +	.rd_table		= &msm8998_bwmon_global_reg_read_table,
>>>> +	.reg_defaults		= msm8998_bwmon_global_reg_defaults,
>>>> +	.num_reg_defaults	= ARRAY_SIZE(msm8998_bwmon_global_reg_defaults),
>>>> +	/*
>>>> +	 * Cache is necessary for using regmap fields with non-readable
>>>> +	 * registers.
>>>> +	 */
>>>> +	.cache_type		= REGCACHE_RBTREE,
>>>> +};
>>>> +
>>>>  /* BWMON v5 */
>>>>  static const struct reg_field sdm845_llcc_bwmon_reg_fields[] = {
>>>> -	[F_GLOBAL_IRQ_CLEAR]	= {},
>>>> -	[F_GLOBAL_IRQ_ENABLE]	= {},
>>>>  	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V5_IRQ_STATUS, 0, 3),
>>>>  	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V5_IRQ_CLEAR, 0, 3),
>>>>  	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V5_IRQ_ENABLE, 0, 3),
>>>> @@ -369,16 +430,21 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
>>>>  	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
>>>>  	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
>>>>  		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
>>>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>>>> -		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
>>>> +	if (bwmon->global_regs[0])
>>>> +		regmap_field_force_write(bwmon->global_regs[F_GLOBAL_IRQ_CLEAR],
>>>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>>> +	else
>>>> +		regmap_field_force_write(bwmon->regs[F_GLB_IRQ_CLEAR],
>>>>  					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>>>  }
>>>>  
>>>>  static void bwmon_disable(struct icc_bwmon *bwmon)
>>>>  {
>>>>  	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
>>>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>>>> -		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
>>>> +	if (bwmon->global_regs[0])
>>>> +		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE], 0x0);
>>>> +	else
>>>> +		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE], 0x0);
>>>>  	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
>>>>  
>>>>  	/*
>>>> @@ -391,9 +457,13 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
>>>>  static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
>>>>  {
>>>>  	/* Enable interrupts */
>>>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>>>> -		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
>>>> -				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>>> +	if (bwmon->global_regs[0])
>>>> +		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE],
>>>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>>> +	else
>>>> +		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE],
>>>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>>
>>> Probably this would be more readable if regmap_field_write() is called
>>> only once and you parametrize the first argument (field) from the
>>> 'struct bwmon'.
>> Sounds good
>>
>>>
>>>> +
>>>>  	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
>>>>  
>>>>  	/* Enable bwmon */
>>>> @@ -556,7 +626,9 @@ static int bwmon_init_regmap(struct platform_device *pdev,
>>>>  	struct device *dev = &pdev->dev;
>>>>  	void __iomem *base;
>>>>  	struct regmap *map;
>>>> +	int ret;
>>>>  
>>>> +	/* Map the monitor base */
>>>>  	base = devm_platform_ioremap_resource(pdev, 0);
>>>>  	if (IS_ERR(base))
>>>>  		return dev_err_probe(dev, PTR_ERR(base),
>>>> @@ -567,12 +639,38 @@ static int bwmon_init_regmap(struct platform_device *pdev,
>>>>  		return dev_err_probe(dev, PTR_ERR(map),
>>>>  				     "failed to initialize regmap\n");
>>>>  
>>>> +	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_global_reg_fields) != F_NUM_GLOBAL_FIELDS);
>>>>  	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
>>>>  	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
>>>>  
>>>> -	return devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
>>>> +	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
>>>>  					   bwmon->data->regmap_fields,
>>>>  					   F_NUM_FIELDS);
>>>
>>> What exactly happens now on msm8998 (or updated sdm845 from your binding
>>> example) for the "global" fields in this region? The regmap references
>>> non-existing fields for the "monitor" region, doesn't it?
>> That's correct, the regmap references 3 non-existstent (or at least
>> not-what-we-think-they-are registers (ending with _845) for
>> targets with two separate regions (such as MSM8998), but they're
>> unaccessed if the "global" region has been mapped sucessfully
>> [see `if (bwmon->global_regs[0])`].
>>
>>>
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
>>>> +		/* Map the global base, if separate */
>>>> +		base = devm_platform_ioremap_resource(pdev, 1);
>>>
>>> Wouldn't this now print errors for sdm845, thus introduce dmesg regression?
>> I explicitly stated this in the cover letter and asked for opinions.
>>
> 
> Sorry, long time ago I stopped reading cover letters, maybe except it's
> top few sentences. Just too many of them and too much of text usually
> useless. Commits should describe everything as they go to the Git and
> they should justify their own existence.
> 
> Anyway, above dmesg error regression is a no. The devices turn out not
> to be compatible with each other so just adjust the bindings and match
> each driver by proper compatible string.
So what am I supposed to do here? Add "qcom,msm8998-actual-msm8998-bwmon"?

Otherwise, changing msm8998 data would break 845-8550, unless I added all
of them to a separate match table. Or I can add some boilerplate C code
that would not throw a warning, or perhaps try and introduce
devm_platform_ioremap_resource_optional..

I guess the last option sounds the best.

Konrad
> 
> Best regards,
> Krzysztof
> 
