Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06F765C019
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbjACMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:45:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F1DFD9;
        Tue,  3 Jan 2023 04:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672749924; x=1704285924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lwU98dyaymbW2/sk3kp9r5ZvEL697tsRK3f7uEUqPpM=;
  b=YwlayVUaEb28gRft5ju20ZozxHl9T83ehtmmrOnJIhKBAf/C36oi/Ndx
   za/tzr2/vZ2/jDL4Ka25PXxI37w4EYYPy51LVaTvPpncqFqQ6zmcCO9FO
   eSZ3hgDkx1W+j/jSP+ocZrvYbb+woYnH11dfLmQF9ugVSCxxIwRkJNd4h
   /XxFvoMoXXFagDx2A1RjwrZAjJhBD4hlU0wt3r7vxdotX7F/m5miaxHxy
   1qktd1D6h4yagwsVIca9Ae6Ojv64cOAHFVfJrz5KG+Y+lLjdi5OJXz+nz
   dHK3lMSQvCvv49Hap/nG7gcOJifY+mAEv64XSF2nOC6tcavnIVI11AAJn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="383948134"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="383948134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 04:45:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="685386050"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685386050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 04:45:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pCgfO-003t61-15;
        Tue, 03 Jan 2023 14:45:18 +0200
Date:   Tue, 3 Jan 2023 14:45:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, matthias.bgg@gmail.com,
        chiaen_wu@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v15 RESEND 1/2] leds: rgb: mt6370: Add MediaTek MT6370
 current sink type LED Indicator support
Message-ID: <Y7QjXbTvI0N0i2WX@smile.fi.intel.com>
References: <cover.1672728620.git.chiaen_wu@richtek.com>
 <edc096c82d4aa7336e03315a22d2a59d467daf8f.1672728620.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc096c82d4aa7336e03315a22d2a59d467daf8f.1672728620.git.chiaen_wu@richtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 03:00:07PM +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> driver. It can control four channels current-sink RGB LEDs with 3 modes:
> constant current, PWM, and breath mode.

...

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + *
> + * Authors:
> + *   ChiYuan Huang <cy_huang@richtek.com>
> + *   Alice Chen <alice_chen@richtek.com>

> + *

Redundant blank line.

> + */

...

> +#include <asm-generic/unaligned.h>

asm/unaligned should work, no?

...

> +struct mt6370_pdata {
> +	const unsigned int *tfreq;
> +	unsigned int tfreq_len;

> +	u8 pwm_duty;

You may save a few bytes by moving this to the end of the structure.

> +	u16 reg_rgb1_tr;
> +	s16 reg_rgb_chrind_tr;
> +};

...

> +struct mt6370_priv {
> +	/* Per LED access lock */
> +	struct mutex lock;

> +	struct device *dev;
> +	struct regmap *regmap;

Isn't one can be derived from the other?

> +	struct regmap_field *fields[F_MAX_FIELDS];
> +	const struct reg_field *reg_fields;
> +	const struct linear_range *ranges;
> +	struct reg_cfg *reg_cfgs;
> +	const struct mt6370_pdata *pdata;
> +	unsigned int leds_count;
> +	unsigned int leds_active;
> +	struct mt6370_led leds[];
> +};

...

> +static int mt6370_isnk_brightness_set(struct led_classdev *lcdev,
> +				      enum led_brightness level)
> +{
> +	struct mt6370_led *led = container_of(lcdev, struct mt6370_led, isink);
> +	struct mt6370_priv *priv = led->priv;
> +	unsigned int enable;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = regmap_field_read(priv->fields[F_RGB_EN], &enable);
> +	if (ret)
> +		goto out_unlock;

> +	if (level == 0) {
> +		enable &= ~MT6370_CHEN_BIT(led->index);
> +
> +		ret = mt6370_set_led_mode(priv, led->index,
> +					  MT6370_LED_REG_MODE);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret = regmap_field_write(priv->fields[F_RGB_EN], enable);
> +	} else {
> +		enable |= MT6370_CHEN_BIT(led->index);
> +
> +		ret = mt6370_set_led_brightness(priv, led->index, level);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret = regmap_field_write(priv->fields[F_RGB_EN], enable);
> +	}

Hmm... Wouldn't be below the equivalent?

	if (level == 0) {
		enable &= ~MT6370_CHEN_BIT(led->index);

		ret = mt6370_set_led_mode(priv, led->index,
					  MT6370_LED_REG_MODE);
		if (ret)
			goto out_unlock;
	} else {
		enable |= MT6370_CHEN_BIT(led->index);

		ret = mt6370_set_led_brightness(priv, led->index, level);
		if (ret)
			goto out_unlock;

	}

	ret = regmap_field_write(priv->fields[F_RGB_EN], enable);

(Of course even if (ret) goto... is duplicated, but probably better to leave it
 as is now)

> +out_unlock:
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}

...

> +		fwnode_for_each_child_node(init_data->fwnode, child) {
> +			u32 reg, color;
> +
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
> +			if (ret || reg > MT6370_LED_ISNK3 ||
> +			    priv->leds_active & BIT(reg))

I don't see where you drop a reference count.

> +				return -EINVAL;
> +
> +			ret = fwnode_property_read_u32(child, "color", &color);
> +			if (ret)

Ditto.

> +				return dev_err_probe(dev, ret,
> +						     "LED %d, no color specified\n",
> +						     led->index);
> +
> +			priv->leds_active |= BIT(reg);
> +			sub_led[num_color].color_index = color;
> +			sub_led[num_color].channel = reg;
> +			sub_led[num_color].intensity = 0;
> +			num_color++;
> +		}

...

> +	count = device_get_child_node_count(dev);
> +	if (!count || count > MT6370_MAX_LEDS)

Is the second really critical? Can it be just a warning and clamping of the
counter to the upper limit?

> +		return dev_err_probe(dev, -EINVAL,
> +				     "No child node or node count over max LED number %zu\n",
> +				      count);

...

> +	device_for_each_child_node(dev, child) {
> +		struct mt6370_led *led = priv->leds + i++;
> +		struct led_init_data init_data = { .fwnode = child };
> +		u32 reg, color;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)

What about reference count?

> +			return dev_err_probe(dev, ret, "Failed to parse reg property\n");
> +
> +		if (reg >= MT6370_MAX_LEDS)

Ditto.

> +			return dev_err_probe(dev, -EINVAL, "Error reg property number\n");
> +
> +		ret = fwnode_property_read_u32(child, "color", &color);
> +		if (ret)

Ditto.

> +			return dev_err_probe(dev, ret, "Failed to parse color property\n");
> +
> +		if (color == LED_COLOR_ID_RGB || color == LED_COLOR_ID_MULTI)
> +			reg = MT6370_VIRTUAL_MULTICOLOR;
> +
> +		if (priv->leds_active & BIT(reg))

Ditto.

> +			return dev_err_probe(dev, -EINVAL, "Duplicate reg property\n");
> +
> +		priv->leds_active |= BIT(reg);
> +
> +		led->index = reg;
> +		led->priv = priv;
> +
> +		ret = mt6370_init_led_properties(led, &init_data);
> +		if (ret)

Ditto.

> +			return ret;
> +
> +		ret = mt6370_led_register(&pdev->dev, led, &init_data);
> +		if (ret)

Ditto.

> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


