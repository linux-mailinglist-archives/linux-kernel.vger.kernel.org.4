Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3162DEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiKQOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiKQOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:47:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C745A30E;
        Thu, 17 Nov 2022 06:47:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id io19so1805187plb.8;
        Thu, 17 Nov 2022 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7fjcrisrTLTQWnD3xTnmWyvbRntTI2EcVSlLmLMNKM=;
        b=ZaN6TDSWMNNRIrAcruvBmsn8jfSeBf93EQGduEfe8lLTRxY7dJFWXW2XBtBQjKx+Pk
         HkhUKSh9wbJfBii5jTebJuisSOz9YHaHKXwJLo9eju0OfqO4UXlAbSieCc1cERLIO5od
         Ga3sgB9DO5P1l6p4+6Zc+gaKxZ+ZED16vVSFFskIYZ/UJEefbTm+z4JClU8SFAF+2h98
         yI987NPK3X+lOprujL1ZnHDx8k80802D/yvEIcDSGYzygnFi8+DjWTJlnTBW/vBufwd9
         j89BLXbda5OLECf3FiixjTm4JUEyJI/B20le3f5j3nTKn4zWcvogiZbC/N0uGekGM11n
         ieNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7fjcrisrTLTQWnD3xTnmWyvbRntTI2EcVSlLmLMNKM=;
        b=dJfXCABJqrZDi+W5zdTmz0/aZ6ii7fVJcsmZ6PSDbz5U7ssHoXnobKXOJ4ZqccGrnB
         bj+J/ofjBFcwG4hUkxjYUO8qH9aqBohSNQttMPvBADkRSdtlHa/pFrDqKdoH9v4QCrZ3
         MD+b7C6DpPbRIERDcZtNjvCyi8ltg/zHYGgTDle6vAv6ovwXYMYpBBzylQlPKUM8Ba5R
         hO1HBnuw6BXAQTHBREzMQI5M5YYfAVDSrxmjFWsMtW8sZWY4IM4F1QLBUgyZ+snkLmpV
         i1M4a57g6QXFkThJb6yz+50VmST8JHTYLm/LnDqPy/VMXCZbVlZx0B6+QECwRU+iwsWw
         ko4w==
X-Gm-Message-State: ANoB5pkQbwK3QOuzgjXU0eOhr7DT6VGTGh+Wp1Y1AJQW52CL/Dupc1MM
        jdIRleUs2vyXM31ePd1RSAKfyq/7sDk=
X-Google-Smtp-Source: AA0mqf5PkV5TziPEHmnHOlJU5IKxVXP6ruq+QroSj6IM0eexjG/njocduN2xe9vgkp8BUGY9sL/V9A==
X-Received: by 2002:a17:903:32cb:b0:16e:e703:2186 with SMTP id i11-20020a17090332cb00b0016ee7032186mr3092763plr.90.1668696431221;
        Thu, 17 Nov 2022 06:47:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 72-20020a62184b000000b0056bb0357f5bsm1185442pfy.192.2022.11.17.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:47:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Nov 2022 06:47:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] [WAR] hwmon: (ina3221) Apply software WAR to offset
 shunt voltage
Message-ID: <20221117144709.GD664755@roeck-us.net>
References: <20221117083226.20027-1-nmalwade@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117083226.20027-1-nmalwade@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:32:26PM +0800, Ninad Malwade wrote:
> This is used as a software WAR to offset shunt voltage reading

What is a software WAR ? Or a WAR in the first place ?
What is the relevance of the "[WAR]" tag in the subject ?

None of the definitions at https://acronyms.thefreedictionary.com/WAR
seem to apply. I am sure it means something for you, and it seems to be
important enough to use the term repeatedly, but please do not assume
that others know what it means.

> from INA3221 to increase its accuracy. This patch implements a
> previous downstream feature by reading the offset information
> from DT and apply it to current readings.
> 

Where is the devicetree documentation ?

> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  drivers/hwmon/ina3221.c | 141 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e06186986444..726c8b99b8cd 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -94,13 +94,39 @@ enum ina3221_channels {
>  	INA3221_NUM_CHANNELS
>  };
>  
> +/**
> + * struct shuntv_offset_range - [WAR] shunt voltage offset sub-range

Still no explanation what WAR actually stands for.

> + * @start: range start (uV)
> + * @end: range end (uV)
> + * @offset: offset for the current sub-range
> + */
> +struct shuntv_offset_range {
> +	s32 start;
> +	s32 end;
> +	s32 offset;
> +};
> +
> +/**
> + * struct shuntv_offset - [WAR] shunt voltage offset information
> + * @offset: general offset
> + * @range: pointer to a sub-range of shunt voltage offset (uV)
> + * @num_range: number of sub-ranges of shunt voltage offset
> + */
> +struct shuntv_offset {
> +	s32 offset;
> +	struct shuntv_offset_range *range;
> +	s32 num_range;
> +};
> +
>  /**
>   * struct ina3221_input - channel input source specific information
> + * @shuntv_offset: [WAR] shunt voltage offset information
>   * @label: label of channel input source
>   * @shunt_resistor: shunt resistor value of channel input source
>   * @disconnected: connection status of channel input source
>   */
>  struct ina3221_input {
> +	struct shuntv_offset *shuntv_offset;
>  	const char *label;
>  	int shunt_resistor;
>  	bool disconnected;
> @@ -329,7 +355,7 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	struct ina3221_input *input = ina->inputs;
>  	u8 reg = ina3221_curr_reg[attr][channel];
> -	int resistance_uo, voltage_nv;
> +	int resistance_uo, voltage_uv;
>  	int regval, ret;
>  
>  	if (channel > INA3221_CHANNEL3)
> @@ -362,10 +388,34 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  		if (ret)
>  			return ret;
>  
> -		/* Scale of shunt voltage: LSB is 40uV (40000nV) */
> -		voltage_nv = regval * 40000;
> +		/* Scale of shunt voltage: LSB is 40uV */
> +		voltage_uv = regval * 40;
> +
> +		/* Apply software WAR to offset shunt voltage for accuracy */
> +		if (input->shuntv_offset) {
> +			struct shuntv_offset_range *range =
> +						input->shuntv_offset->range;
> +			int num_range = input->shuntv_offset->num_range;
> +			int offset = input->shuntv_offset->offset;
> +
> +			while (num_range--) {
> +				if (voltage_uv >= range->start &&
> +				    voltage_uv <= range->end) {
> +					/* Use range offset instead */
> +					offset = range->offset;
> +					break;
> +				}
> +				range++;
> +			}
> +
> +			if (voltage_uv < 0)
> +				voltage_uv += offset;
> +			else
> +				voltage_uv -= offset;
> +		}
> +
>  		/* Return current in mA */
> -		*val = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
> +		*val = DIV_ROUND_CLOSEST(voltage_uv * 1000, resistance_uo);
>  		return 0;
>  	case hwmon_curr_crit_alarm:
>  	case hwmon_curr_max_alarm:
> @@ -758,6 +808,84 @@ static const struct regmap_config ina3221_regmap_config = {
>  	.volatile_table = &ina3221_volatile_table,
>  };
>  
> +static struct shuntv_offset *
> +ina3221_probe_shuntv_offset_from_dt(struct device *dev,
> +				    struct device_node *child)
> +{
> +	struct device_node *np, *range_np;
> +	struct shuntv_offset *shuntv_offset;
> +	struct shuntv_offset_range *range;
> +	s32 start, end, offset;
> +	const __be32 *prop;
> +	int ret, num_range;
> +
> +	prop = of_get_property(child, "shunt-volt-offset-uv", NULL);
> +	/* Silently return for devices with no need of an offset WAR */
> +	if (!prop)
> +		return NULL;
> +
> +	np = of_find_node_by_phandle(be32_to_cpup(prop));
> +	if (!np) {
> +		dev_err(dev, "corrupted phandle for shunt-volt-offset-uv\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ret = of_property_read_s32(np, "offset", &offset);
> +	if (ret) {
> +		dev_err(dev, "failed to read general shuntv offset\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	shuntv_offset = devm_kzalloc(dev, sizeof(*shuntv_offset), GFP_KERNEL);
> +	if (!shuntv_offset)
> +		return ERR_PTR(-ENOMEM);
> +
> +	shuntv_offset->offset = offset;
> +
> +	num_range = of_get_child_count(np);
> +
> +	/* Return upon no sub-range found */
> +	if (!num_range)
> +		return shuntv_offset;
> +
> +	range = devm_kzalloc(dev, sizeof(*range) * num_range, GFP_KERNEL);
> +	if (!range)
> +		return ERR_PTR(-ENOMEM);
> +
> +	shuntv_offset->range = range;
> +	shuntv_offset->num_range = num_range;
> +
> +	for_each_child_of_node(np, range_np) {
> +		ret = of_property_read_s32(range_np, "start", &start);
> +		if (ret) {
> +			dev_warn(dev, "missing start in range node\n");
> +			range++;
> +			continue;
> +		}
> +
> +		ret = of_property_read_s32(range_np, "end", &end);
> +		if (ret) {
> +			dev_warn(dev, "missing end in range node\n");
> +			range++;
> +			continue;
> +		}
> +
> +		ret = of_property_read_s32(range_np, "offset", &offset);
> +		if (ret) {
> +			dev_warn(dev, "missing offset in range node\n");
> +			range++;
> +			continue;
> +		}

Not sure if that would be an acceptable devicetree binding. The bindings
will need to be submitted, reviewed, and accepted by a devicetree maintainer.

> +
> +		range->start = start;
> +		range->end = end;
> +		range->offset = offset;
> +		range++;
> +	}
> +
> +	return shuntv_offset;
> +}
> +
>  static int ina3221_probe_child_from_dt(struct device *dev,
>  				       struct device_node *child,
>  				       struct ina3221_data *ina)
> @@ -796,6 +924,11 @@ static int ina3221_probe_child_from_dt(struct device *dev,
>  		input->shunt_resistor = val;
>  	}
>  
> +	/* Apply software WAR to offset shunt voltage for accuracy */
> +	input->shuntv_offset = ina3221_probe_shuntv_offset_from_dt(dev, child);
> +	if (IS_ERR(input->shuntv_offset))
> +		return PTR_ERR(input->shuntv_offset);
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
