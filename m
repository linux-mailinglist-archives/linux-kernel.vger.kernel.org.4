Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1563E6C35C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCUPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjCUPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:34:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427875071A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:34:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i13so3955222lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679412852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRrvL17SGhgIzWulyapIo6dSLR96fnq7Sq3PVNcOcKk=;
        b=Ox92bRYPFTze4TB/gn8Hvx5EU3GDwTiaHvn2PbiYI0hSO3cTSvyfcxlijXZqQdYRdP
         cKmuRON8+1hswhOV0fIhzafiI/7TGrMHHTqp46YbpMl+qiZ0URXaN7GItCMHaei/sG0X
         6Z86OA76BsRdbE96CwE2qZcB6eOSVJqIOJzVAO9DFEvUhdPBLI0I0O9jd3WcMZcwgUQh
         FW/meuEwJmK0kFYYlkq1LB8xfdZCiu4HetSLRQY9DGfkGGdG2KCNapIgxzhVwgkZMNcO
         uNMy84a7GWXgK1823jX9yAt0dyYuDJYV6wzVrSIwjUaQOOitIByGCCXsVlxBgwD+U1Yr
         qDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRrvL17SGhgIzWulyapIo6dSLR96fnq7Sq3PVNcOcKk=;
        b=TfUcNTpraKcCw2V2QeF0p+pcD0wXeY5FVUg8QyP6y92YRPE60nyaSSzkTSSrZfKT2V
         R3e2AUK69vzOjQUYlx8a37JMompSqPNPCdIcVwDbhCWnn9e17QJ+guZ9K/8MxYWezv0L
         bKO02Lhzqw8+m5ALdedG/zNFUydryGKxCOu5qaUNPvTSCzmaEA9WBc2Q2C6GHOJkMCCZ
         gEp4QJ98tVsQes5MQxJqXT93jFStOf1x7tHIPj3xHlvpU+4Vrxn/elAjOJ3gPLZxGKva
         6UAl0xOT2naLFU7Uw+VS5BtyEo39tkIwoMZ6qKF5+hk017IyDF5f0k8BfQGaWnym5oZ6
         d77w==
X-Gm-Message-State: AO0yUKXu6hRnGKesmXeX+xJucVwM9yZTcye8XVruTrtJcJkdnLZ6egol
        JWrayFaXpulu5FDnWJyh1olGrQ==
X-Google-Smtp-Source: AK7set9oVFEsxONO8OJd9uARDwJtOBpIRSk1V/I82RWfm8mCD31ZLqZGG4tn7csj9Q/V1D1vi7WaZQ==
X-Received: by 2002:ac2:4462:0:b0:4db:4530:2b2d with SMTP id y2-20020ac24462000000b004db45302b2dmr976279lfl.49.1679412852463;
        Tue, 21 Mar 2023 08:34:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f10-20020ac24e4a000000b004db3e330dcesm2207807lfr.178.2023.03.21.08.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:34:11 -0700 (PDT)
Message-ID: <0f42a631-7932-5b81-4bc0-a07af7eab367@linaro.org>
Date:   Tue, 21 Mar 2023 17:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH v3 3/3] thermal: qcom-spmi-temp-alarm: add support
 for LITE PMIC peripherals
Content-Language: en-GB
To:     David Collins <quic_collinsd@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1674602698.git.quic_collinsd@quicinc.com>
 <5fe697a29958813ce3c07104eb6f9d7a95b176ac.1674602698.git.quic_collinsd@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5fe697a29958813ce3c07104eb6f9d7a95b176ac.1674602698.git.quic_collinsd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 01:46, David Collins wrote:
> Add support for TEMP_ALARM LITE PMIC peripherals.  This subtype
> utilizes a pair of registers to configure a warning interrupt
> threshold temperature and an automatic hardware shutdown
> threshold temperature.

This adds additional DT requirements to the lite temp-alarm trip points. 
Please consider adding a separate DT compatible string and describing 
these details in DT bindings. And the commit message _must_ also 
describe them.

> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> ---
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 217 +++++++++++++++++++-
>   1 file changed, 208 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 1fe8ff7a274e..dbf13dec7acd 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> @@ -24,21 +25,28 @@
>   #define QPNP_TM_REG_TYPE		0x04
>   #define QPNP_TM_REG_SUBTYPE		0x05
>   #define QPNP_TM_REG_STATUS		0x08
> +#define QPNP_TM_REG_IRQ_STATUS		0x10
>   #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
>   #define QPNP_TM_REG_ALARM_CTRL		0x46
>   /* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
>   #define QPNP_TM_REG_TEMP_DAC_STG1	0x47
>   #define QPNP_TM_REG_TEMP_DAC_STG2	0x48
>   #define QPNP_TM_REG_TEMP_DAC_STG3	0x49
> +#define QPNP_TM_REG_LITE_TEMP_CFG1	0x50
> +#define QPNP_TM_REG_LITE_TEMP_CFG2	0x51
>   
>   #define QPNP_TM_TYPE			0x09
>   #define QPNP_TM_SUBTYPE_GEN1		0x08
>   #define QPNP_TM_SUBTYPE_GEN2		0x09
> +#define QPNP_TM_SUBTYPE_LITE		0xC0
>   
>   #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
>   #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
>   #define STATUS_GEN2_STATE_SHIFT		4
>   
> +/* IRQ status only needed for TEMP_ALARM_LITE */
> +#define IRQ_STATUS_MASK			BIT(0)
> +
>   #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
>   #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
>   
> @@ -46,6 +54,8 @@
>   
>   #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
>   
> +#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
> +
>   #define THRESH_COUNT			4
>   #define STAGE_COUNT			3
>   
> @@ -90,6 +100,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
>   	119375, 159375, 159375
>   };
>   
> +/*
> + * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
> + * configured threshold temperatures.
> + */
> +
> +static const long temp_map_lite_warning[THRESH_COUNT] = {
> +	115000, 125000, 135000, 145000
> +};
> +
> +static const long temp_map_lite_shutdown[THRESH_COUNT] = {
> +	135000, 145000, 160000, 175000
> +};
> +
>   /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
>   #define DEFAULT_TEMP			37000
>   
> @@ -146,7 +169,7 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
>    */
>   static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
>   {
> -	if (chip->has_temp_dac) {
> +	if (chip->has_temp_dac || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
>   		if (stage == 0 || stage > STAGE_COUNT)
>   			return 0;
>   
> @@ -164,19 +187,26 @@ static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
>    * qpnp_tm_get_temp_stage() - return over-temperature stage
>    * @chip:		Pointer to the qpnp_tm chip
>    *
> - * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
> + * Return: stage (GEN1), state (GEN2), or alarm interrupt state (LITE) on
> + *	   success; or errno on failure.
>    */
>   static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
>   {
>   	int ret;
> +	u16 addr = QPNP_TM_REG_STATUS;
>   	u8 reg = 0;
>   
> -	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +		addr = QPNP_TM_REG_IRQ_STATUS;
> +
> +	ret = qpnp_tm_read(chip, addr, &reg);
>   	if (ret < 0)
>   		return ret;
>   
>   	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
>   		ret = reg & STATUS_GEN1_STAGE_MASK;
> +	else if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +		ret = reg & IRQ_STATUS_MASK;
>   	else
>   		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
>   
> @@ -199,7 +229,8 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>   		return ret;
>   	stage = ret;
>   
> -	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +	    || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
>   		stage_new = stage;
>   		stage_old = chip->stage;
>   	} else {
> @@ -282,6 +313,78 @@ static int qpnp_tm_set_temp_dac_thresh(struct qpnp_tm_chip *chip, int trip,
>   	return 0;
>   }
>   
> +static int qpnp_tm_set_temp_lite_thresh(struct qpnp_tm_chip *chip, int trip,
> +				       int temp)
> +{
> +	int ret, temp_cfg, i;
> +	const long *temp_map;
> +	u16 addr;
> +	u8 reg, thresh;
> +
> +	if (trip < 0 || trip >= STAGE_COUNT) {
> +		dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
> +		return -EINVAL;
> +	}
> +
> +	switch (trip) {
> +	case 0:
> +		temp_map = temp_map_lite_warning;
> +		addr = QPNP_TM_REG_LITE_TEMP_CFG1;
> +		break;
> +	case 1:
> +		/*
> +		 * The second trip point is purely in software to facilitate
> +		 * a controlled shutdown after the warning threshold is crossed
> +		 * but before the automatic hardware shutdown threshold is
> +		 * crossed.
> +		 */
> +		return 0;
> +	case 2:
> +		temp_map = temp_map_lite_shutdown;
> +		addr = QPNP_TM_REG_LITE_TEMP_CFG2;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
> +		dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
> +		return -EINVAL;
> +	}
> +
> +	thresh = 0;
> +	temp_cfg = temp_map[thresh];
> +	for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
> +		if (temp >= temp_map[i]) {
> +			thresh = i;
> +			temp_cfg = temp_map[i];
> +			break;
> +		}
> +	}
> +
> +	if (temp_cfg == chip->temp_dac_map[trip])
> +		return 0;
> +
> +	ret = qpnp_tm_read(chip, addr, &reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
> +	reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
> +
> +	ret = qpnp_tm_write(chip, addr, reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	chip->temp_dac_map[trip] = temp_cfg;
> +
> +	return 0;
> +}
> +
>   static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>   					     int temp)
>   {
> @@ -388,6 +491,24 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_temp_dac_ops = {
>   	.set_trip_temp = qpnp_tm_set_temp_dac_trip_temp,
>   };
>   
> +static int qpnp_tm_set_temp_lite_trip_temp(struct thermal_zone_device *tz,
> +					   int trip, int temp)
> +{
> +	struct qpnp_tm_chip *chip = tz->devdata;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = qpnp_tm_set_temp_lite_thresh(chip, trip, temp);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops qpnp_tm_sensor_temp_lite_ops = {
> +	.get_temp = qpnp_tm_get_temp,
> +	.set_trip_temp = qpnp_tm_set_temp_lite_trip_temp,
> +};
> +
>   static irqreturn_t qpnp_tm_isr(int irq, void *data)
>   {
>   	struct qpnp_tm_chip *chip = data;
> @@ -474,6 +595,71 @@ static int qpnp_tm_temp_dac_init(struct qpnp_tm_chip *chip)
>   	return 0;
>   }
>   
> +/* Configure TEMP_LITE registers based on DT thermal_zone trips */
> +static int qpnp_tm_temp_lite_update_trip_temps(struct qpnp_tm_chip *chip)
> +{
> +	const struct thermal_trip *trips;
> +	int ret, ntrips, i;
> +
> +	ntrips = of_thermal_get_ntrips(chip->tz_dev);
> +	/* Keep hardware defaults if no DT trips are defined. */
> +	if (ntrips <= 0)
> +		return 0;
> +
> +	trips = of_thermal_get_trip_points(chip->tz_dev);
> +	if (!trips)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ntrips; i++) {
> +		if (of_thermal_is_trip_valid(chip->tz_dev, i)) {
> +			ret = qpnp_tm_set_temp_lite_thresh(chip, i,
> +							  trips[i].temperature);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	/* Verify that trips are strictly increasing. */
> +	if (chip->temp_dac_map[2] <= chip->temp_dac_map[0]) {
> +		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
> +			chip->temp_dac_map[2], chip->temp_dac_map[0]);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Read the hardware default TEMP_LITE stage threshold temperatures */
> +static int qpnp_tm_temp_lite_init(struct qpnp_tm_chip *chip)
> +{
> +	int ret, thresh;
> +	u8 reg = 0;
> +
> +	/*
> +	 * Store the warning trip temp in temp_dac_map[0] and the shutdown trip
> +	 * temp in temp_dac_map[2].  The second trip point is purely in software
> +	 * to facilitate a controlled shutdown after the warning threshold is
> +	 * crossed but before the automatic hardware shutdown threshold is
> +	 * crossed.  Thus, there is no register to read for the second trip
> +	 * point.
> +	 */
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
> +	chip->temp_dac_map[0] = temp_map_lite_warning[thresh];
> +
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
> +	chip->temp_dac_map[2] = temp_map_lite_shutdown[thresh];
> +
> +	return 0;
> +}
> +
>   /*
>    * This function initializes the internal temp value based on only the
>    * current thermal stage and threshold. Setup threshold control and
> @@ -500,13 +686,18 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>   		goto out;
>   	chip->stage = ret;
>   
> -	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
> -		? chip->stage : alarm_state_map[chip->stage];
> +	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +		 || chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +			? chip->stage : alarm_state_map[chip->stage];
>   
>   	if (stage)
>   		chip->temp = qpnp_tm_decode_temp(chip, stage);
>   
> -	if (chip->has_temp_dac) {
> +	if (chip->subtype == QPNP_TM_SUBTYPE_LITE) {
> +		ret = qpnp_tm_temp_lite_update_trip_temps(chip);
> +		if (ret < 0)
> +			goto out;
> +	} else if (chip->has_temp_dac) {
>   		ret = qpnp_tm_temp_dac_update_trip_temps(chip);
>   		if (ret < 0)
>   			goto out;
> @@ -598,7 +789,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   	chip->dig_revision = (dig_major << 8) | dig_minor;
>   
>   	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
> -				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
> +				     && subtype != QPNP_TM_SUBTYPE_GEN2
> +				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
>   		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
>   			type, subtype);
>   		return -ENODEV;
> @@ -610,7 +802,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   		chip->has_temp_dac = true;
>   	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
>   		chip->temp_map = &temp_map_gen2_v1;
> -	else
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN1)
>   		chip->temp_map = &temp_map_gen1;
>   
>   	if (chip->has_temp_dac) {
> @@ -620,6 +812,13 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   			return ret;
>   	}
>   
> +	if (chip->subtype == QPNP_TM_SUBTYPE_LITE) {
> +		ops = &qpnp_tm_sensor_temp_lite_ops;
> +		ret = qpnp_tm_temp_lite_init(chip);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	/*
>   	 * Register the sensor before initializing the hardware to be able to
>   	 * read the trip points. get_temp() returns the default temperature

-- 
With best wishes
Dmitry

