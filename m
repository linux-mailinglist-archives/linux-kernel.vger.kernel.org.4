Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4556ABACB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCFKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCFKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:06:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7723C63
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:06:42 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a32so8995453ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678097201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSHdaKculyGdk9TWc/g0WOgJhrthVQ0b0D1tfsFsnV8=;
        b=J1qvRfJnFDYp+T8WLdeNzkJjOAJ+LhMZXMKPi5kcFjG8wNhotY8j+zR9PyctsX1L7n
         oLuGcPjjZLQInf+oBercrVWKsZBH4vI8w9X0DLVClFQqTx/mEm3DxoFtGUHOFeeuJwl5
         uQ2AqIJGoEfRPvB9G8ng6l3aUcQCYnTo5JxTefh9FU2+kHaWnbbro50C+NHwa+AMmU3Q
         9gEYd+FbSyhUQfY8ca5dngpkeTLRnC9qFkT5nM8jYIAlbNp9FYcVwFTsykqKsC3vIE0Z
         7lBOOAGo7gs7bvqkAIlViqKcF03bdrMkudG8a4iSTJcGmW4K7LQyPTXgn8KLZSl2hSt/
         eIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSHdaKculyGdk9TWc/g0WOgJhrthVQ0b0D1tfsFsnV8=;
        b=KTF+/l+XbObb63Y3mfkB2WBy75UASNjVmQ6V7QxDMm1DV5qHW8aXcUjw56wzsO7HVC
         Ig8jhlTuFroEJbW4IIqYrUn7tY+Dh8lrwad36VRMGoKBp2pKc+9a7plj2KUed/Ey1NbG
         uy2nc24cK6S+qj3NksA4iTiIGZmbX99QQjsZX7Be9U8HQawLxkpV34/VM/J3P6/X6Q4u
         CPntnMfAAnZUqb4fRrUtOELquGuAFo9zPm+0JckqFTTMpmrN6nIMvaHyiPZCVQzmealX
         8OIRQeGQrn7Zzl7A8b7niFRR0WE1aw1iZ43Pu6NyPX/bnBJnKgS2RwjsPQXIknXle0vV
         125w==
X-Gm-Message-State: AO0yUKXMhJMzZNUxS9x1dPWM+HlqhjXgQHZHjoNtlwTcr7kSOhIzAnZo
        e0jgZmOAIbwZOy8Wse5DrbJcuw==
X-Google-Smtp-Source: AK7set+XgTlwmo0mNTH8nMtktBeSIi+a+1Z0kW5x39YYCqZw5ywrOk00IvzFKJLjE9Y/MLMYL3DwFg==
X-Received: by 2002:a2e:97cc:0:b0:293:153c:dc9f with SMTP id m12-20020a2e97cc000000b00293153cdc9fmr2672145ljj.2.1678097201138;
        Mon, 06 Mar 2023 02:06:41 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e8708000000b00295d62f0a0fsm1621055lji.122.2023.03.06.02.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:06:40 -0800 (PST)
Message-ID: <56b5e7ff-2dbe-74da-c325-5e5cf546b1ff@linaro.org>
Date:   Mon, 6 Mar 2023 11:06:39 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a85c9c5d-b57d-9212-0e24-1991b5b580b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 16:06, Krzysztof Kozlowski wrote:
> On 04/03/2023 16:39, Konrad Dybcio wrote:
>> The BWMON hardware has two sets of registers: one for the monitor itself
>> and one called "global". It has what seems to be some kind of a head
>> switch and an interrupt control register. It's usually 0x200 in size.
>>
>> On fairly recent SoCs (with the starting point seemingly being moving
>> the OSM programming to the firmware) these two register sets are
>> contiguous and overlapping, like this (on sm8450):
>>
>> /* notice how base.start == global_base.start+0x100 */
>> reg = <0x90b6400 0x300>, <0x90b6300 0x200>;
>> reg-names = "base", "global_base";
>>
>> Which led to some confusion and the assumption that since the
>> "interesting" global registers begin right after global_base+0x100,
>> there's no need to map two separate regions and one can simply subtract
>> 0x100 from the offsets.
>>
>> This is however not the case for anything older than SDM845, as the
>> global region can appear in seemingly random spots on the register map.
>>
>> Add support for it to let bwmon function on older SoCs like MSM8998 and
>> allow operation with just one set of registers for newer platforms.
>>
>> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> 
> You did not describe any bug to be fixed. Adding support for different
> devices with different memory layour is a feature, not bugfix. If this
> is a bugfix, please share what exactly is broken on sdm845?
The driver was completely broken for MSM8998, even though it
had a compatible specifically for that SoC.

> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/soc/qcom/icc-bwmon.c | 136 +++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 118 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index d07be3700db6..9ef632d80ee3 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -34,14 +34,27 @@
>>  /* Internal sampling clock frequency */
>>  #define HW_TIMER_HZ				19200000
>>  
>> -#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x008
>> -#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x00c
>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x108
>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x10c
>>  /*
>>   * All values here and further are matching regmap fields, so without absolute
>>   * register offsets.
>>   */
>>  #define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
>>  
>> +/*
>> + * Starting with SDM845, the BWMON4 register space has changed a bit:
>> + * the global registers were jammed into the beginning of the monitor region.
>> + * To keep the proper offsets, one would have to map <GLOBAL_BASE 0x200> and
>> + * <GLOBAL_BASE+0x100 0x300>, which is straight up wrong.
>> + * To facilitate for that, while allowing the older, arguably more proper
>> + * implementations to work, offset the global registers by -0x100 to avoid
>> + * having to map half of the global registers twice.
>> + */
>> +#define BWMON_V4_845_OFFSET			0x100
> 
> MSM8998? It's a bit confusing to keep calling it 845 while it is for
> MSM8998 variant... or it's not anymore for MSM8998?
No, it's for 845 and up.

> 
> 
>> +#define BWMON_V4_GLOBAL_IRQ_CLEAR_845		(BWMON_V4_GLOBAL_IRQ_CLEAR - BWMON_V4_845_OFFSET)
>> +#define BWMON_V4_GLOBAL_IRQ_ENABLE_845		(BWMON_V4_GLOBAL_IRQ_ENABLE - BWMON_V4_845_OFFSET)
>> +
>>  #define BWMON_V4_IRQ_STATUS			0x100
>>  #define BWMON_V4_IRQ_CLEAR			0x108
>>  
>> @@ -118,8 +131,10 @@
>>  #define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
>>  
>>  enum bwmon_fields {
>> -	F_GLOBAL_IRQ_CLEAR,
>> -	F_GLOBAL_IRQ_ENABLE,
>> +	/* Fields used only on >=SDM845 with BWMON_HAS_GLOBAL_IRQ */
>> +	F_GLB_IRQ_CLEAR,
>> +	F_GLB_IRQ_ENABLE,
> 
> I am not sure what's the benefit of this rename.
I need to somehow differentiate the members of enum bwmon_fields
and enum bwmon_global_fields, keeping the "_GLOBAL" in global_fields
seems to make the most sense, imo.

> 
>> +
>>  	F_IRQ_STATUS,
>>  	F_IRQ_CLEAR,
>>  	F_IRQ_ENABLE,
>> @@ -145,6 +160,13 @@ enum bwmon_fields {
>>  	F_NUM_FIELDS
>>  };
>>  
>> +enum bwmon_global_fields {
>> +	F_GLOBAL_IRQ_CLEAR,
>> +	F_GLOBAL_IRQ_ENABLE,
>> +
>> +	F_NUM_GLOBAL_FIELDS
>> +};
>> +
>>  struct icc_bwmon_data {
>>  	unsigned int sample_ms;
>>  	unsigned int count_unit_kb; /* kbytes */
>> @@ -157,6 +179,9 @@ struct icc_bwmon_data {
>>  
>>  	const struct regmap_config *regmap_cfg;
>>  	const struct reg_field *regmap_fields;
>> +
>> +	const struct regmap_config *global_regmap_cfg;
>> +	const struct reg_field *global_regmap_fields;
>>  };
>>  
>>  struct icc_bwmon {
>> @@ -166,6 +191,7 @@ struct icc_bwmon {
>>  
>>  	struct regmap *regmap;
>>  	struct regmap_field *regs[F_NUM_FIELDS];
>> +	struct regmap_field *global_regs[F_NUM_FIELDS];
>>  
>>  	unsigned int max_bw_kbps;
>>  	unsigned int min_bw_kbps;
>> @@ -175,8 +201,8 @@ struct icc_bwmon {
>>  
>>  /* BWMON v4 */
>>  static const struct reg_field msm8998_bwmon_reg_fields[] = {
>> -	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
>> -	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
>> +	[F_GLB_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0, 0),
>> +	[F_GLB_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE_845, 0, 0),
>>  	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
>>  	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
>>  	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
>> @@ -202,7 +228,7 @@ static const struct reg_field msm8998_bwmon_reg_fields[] = {
>>  };
>>  
>>  static const struct regmap_range msm8998_bwmon_reg_noread_ranges[] = {
>> -	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
>> +	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR_845, BWMON_V4_GLOBAL_IRQ_CLEAR_845),
>>  	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
>>  	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
>>  };
>> @@ -222,16 +248,34 @@ static const struct regmap_access_table msm8998_bwmon_reg_volatile_table = {
>>  	.n_yes_ranges	= ARRAY_SIZE(msm8998_bwmon_reg_volatile_ranges),
>>  };
>>  
>> +static const struct reg_field msm8998_bwmon_global_reg_fields[] = {
>> +	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
>> +	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
>> +};
>> +
>> +static const struct regmap_range msm8998_bwmon_global_reg_noread_ranges[] = {
>> +	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
>> +};
>> +
>> +static const struct regmap_access_table msm8998_bwmon_global_reg_read_table = {
>> +	.no_ranges	= msm8998_bwmon_global_reg_noread_ranges,
>> +	.n_no_ranges	= ARRAY_SIZE(msm8998_bwmon_global_reg_noread_ranges),
>> +};
>> +
>>  /*
>>   * Fill the cache for non-readable registers only as rest does not really
>>   * matter and can be read from the device.
>>   */
>>  static const struct reg_default msm8998_bwmon_reg_defaults[] = {
>> -	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
>> +	{ BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0x0 },
>>  	{ BWMON_V4_IRQ_CLEAR, 0x0 },
>>  	{ BWMON_V4_CLEAR, 0x0 },
>>  };
>>  
>> +static const struct reg_default msm8998_bwmon_global_reg_defaults[] = {
>> +	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
>> +};
>> +
>>  static const struct regmap_config msm8998_bwmon_regmap_cfg = {
>>  	.reg_bits		= 32,
>>  	.reg_stride		= 4,
>> @@ -252,10 +296,27 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
>>  	.cache_type		= REGCACHE_RBTREE,
>>  };
>>  
>> +static const struct regmap_config msm8998_bwmon_global_regmap_cfg = {
>> +	.reg_bits		= 32,
>> +	.reg_stride		= 4,
>> +	.val_bits		= 32,
>> +	/*
>> +	 * No concurrent access expected - driver has one interrupt handler,
>> +	 * regmap is not shared, no driver or user-space API.
>> +	 */
>> +	.disable_locking	= true,
>> +	.rd_table		= &msm8998_bwmon_global_reg_read_table,
>> +	.reg_defaults		= msm8998_bwmon_global_reg_defaults,
>> +	.num_reg_defaults	= ARRAY_SIZE(msm8998_bwmon_global_reg_defaults),
>> +	/*
>> +	 * Cache is necessary for using regmap fields with non-readable
>> +	 * registers.
>> +	 */
>> +	.cache_type		= REGCACHE_RBTREE,
>> +};
>> +
>>  /* BWMON v5 */
>>  static const struct reg_field sdm845_llcc_bwmon_reg_fields[] = {
>> -	[F_GLOBAL_IRQ_CLEAR]	= {},
>> -	[F_GLOBAL_IRQ_ENABLE]	= {},
>>  	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V5_IRQ_STATUS, 0, 3),
>>  	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V5_IRQ_CLEAR, 0, 3),
>>  	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V5_IRQ_ENABLE, 0, 3),
>> @@ -369,16 +430,21 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
>>  	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
>>  	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
>>  		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>> -		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
>> +	if (bwmon->global_regs[0])
>> +		regmap_field_force_write(bwmon->global_regs[F_GLOBAL_IRQ_CLEAR],
>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>> +	else
>> +		regmap_field_force_write(bwmon->regs[F_GLB_IRQ_CLEAR],
>>  					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>>  }
>>  
>>  static void bwmon_disable(struct icc_bwmon *bwmon)
>>  {
>>  	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>> -		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
>> +	if (bwmon->global_regs[0])
>> +		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE], 0x0);
>> +	else
>> +		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE], 0x0);
>>  	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
>>  
>>  	/*
>> @@ -391,9 +457,13 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
>>  static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
>>  {
>>  	/* Enable interrupts */
>> -	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
>> -		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
>> -				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>> +	if (bwmon->global_regs[0])
>> +		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE],
>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
>> +	else
>> +		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE],
>> +					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
> 
> Probably this would be more readable if regmap_field_write() is called
> only once and you parametrize the first argument (field) from the
> 'struct bwmon'.
Sounds good

> 
>> +
>>  	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
>>  
>>  	/* Enable bwmon */
>> @@ -556,7 +626,9 @@ static int bwmon_init_regmap(struct platform_device *pdev,
>>  	struct device *dev = &pdev->dev;
>>  	void __iomem *base;
>>  	struct regmap *map;
>> +	int ret;
>>  
>> +	/* Map the monitor base */
>>  	base = devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(base))
>>  		return dev_err_probe(dev, PTR_ERR(base),
>> @@ -567,12 +639,38 @@ static int bwmon_init_regmap(struct platform_device *pdev,
>>  		return dev_err_probe(dev, PTR_ERR(map),
>>  				     "failed to initialize regmap\n");
>>  
>> +	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_global_reg_fields) != F_NUM_GLOBAL_FIELDS);
>>  	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
>>  	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
>>  
>> -	return devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
>> +	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
>>  					   bwmon->data->regmap_fields,
>>  					   F_NUM_FIELDS);
> 
> What exactly happens now on msm8998 (or updated sdm845 from your binding
> example) for the "global" fields in this region? The regmap references
> non-existing fields for the "monitor" region, doesn't it?
That's correct, the regmap references 3 non-existstent (or at least
not-what-we-think-they-are registers (ending with _845) for
targets with two separate regions (such as MSM8998), but they're
unaccessed if the "global" region has been mapped sucessfully
[see `if (bwmon->global_regs[0])`].

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
>> +		/* Map the global base, if separate */
>> +		base = devm_platform_ioremap_resource(pdev, 1);
> 
> Wouldn't this now print errors for sdm845, thus introduce dmesg regression?
I explicitly stated this in the cover letter and asked for opinions.

Konrad
> 
>> +
>> +		/* If it's not, bail out early and assume the 845 register scheme */
>> +		if (IS_ERR(base) && PTR_ERR(base) == -EINVAL)
>> +			goto exit;
>> +		else if (IS_ERR(base))
>> +			return dev_err_probe(dev, PTR_ERR(base),
>> +					     "failed to map bwmon global registers\n");
>> +
>> +		map = devm_regmap_init_mmio(dev, base, bwmon->data->global_regmap_cfg);
>> +		if (IS_ERR(map))
>> +			return dev_err_probe(dev, PTR_ERR(map),
>> +					     "failed to initialize global regmap\n");
>> +
>> +		ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->global_regs,
>> +						   bwmon->data->global_regmap_fields,
>> +						
>>
> 
> Best regards,
> Krzysztof
> 
