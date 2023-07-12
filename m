Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B975081A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGLMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:22:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FAC10CB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:22:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so2326168e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164550; x=1691756550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5S3zSEv0yO9SsxtBbGnOkP560bf6i4Hy58Sg3O0KaY=;
        b=O2buq07F58l8H+wLvgYZrR2IsHS2NVscUoEgvXvp0Q1qrzsgzAyxNEJWhu39YdgtNp
         lsdTL5koddHjai4I5RV7fmv0QFo5lv0vTNfMFMBhqJtkMdlajohSRt+ThcOV9QcJvJXj
         yVJm1Vwn13j5HX12GOHY1z6Leoe0xh0j3/IqwR0aIIjetc3Jqr+5iaUAjQDT7AR2tUwY
         zzOTYl0xrHE+7xYeFJrQdmjZFQP3DhyY7aVoeGmmhalT1aoo/tVMuX/n6zO6zR53lrHm
         IP+EbwiGBkWPDaDJ55HYckiDycqYBnXcuBCo6sUzDJYcDRiBcr3/2k4zvNQu1q7V33FI
         iElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164550; x=1691756550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5S3zSEv0yO9SsxtBbGnOkP560bf6i4Hy58Sg3O0KaY=;
        b=RlilksT8O3XDt//rKu2B6bI7QmjOK/bEQNiFPW2Hxm2DbUr5jb/m1iAuLCWDEMZzBi
         8EnXezyz1VJRuSoY0i/0MUrQQrIU/na+xMo26vlNcNFHr+NZggr8F+ZrOuEFqgT+73af
         TvwWngbY+qR4cnCje/wqKMnptYULs9yQTckuObITSKZAsdGAdtR9De7qdG7wBszRgfF0
         rH3gm/hX+qL7JnjOvW34AyFuy3NK3H8CC/pER9PcQXJxfoD4zHysZWNeUa66KqE07CNN
         U9sorjrBV7E8+ALSe6x08IdNGHv9DLZ5wsV/15LBBXBOAROI8F2ZlaAXHrwmkDQJWw38
         52Yw==
X-Gm-Message-State: ABy/qLZS3QlYzZkQex3WGdqMPgY9bXi7L9uPorssHUzDLAszb1/vNiXr
        R+uY8370rvu9va+k2TBELuC6zw==
X-Google-Smtp-Source: APBJJlGkOen3dIIxSEXeFzxeFbsqQh9z/9qhEqpAB3/vx8qovpT7q1OT3ojECQEj1hCvFTiw/FdCwQ==
X-Received: by 2002:a05:6512:3149:b0:4fb:8de9:ac13 with SMTP id s9-20020a056512314900b004fb8de9ac13mr13710640lfi.23.1689164550426;
        Wed, 12 Jul 2023 05:22:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s14-20020ac25fae000000b004fba759bf44sm685436lfe.277.2023.07.12.05.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:22:30 -0700 (PDT)
Message-ID: <44043ff6-e109-fa66-58c8-08cc25b9a4ad@linaro.org>
Date:   Wed, 12 Jul 2023 15:22:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-2-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712113539.4029941-2-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 14:35, Praveenkumar I wrote:
> SoCs without RPM have to enable sensors and calibrate from the kernel.
> Though TSENS IP supports 16 sensors, not all are used. So used hw_id
> to enable the relevant sensors.
> 
> Added new calibration function for V2 as the tsens.c calib function
> only supports V1.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> [v2]:
> 	Added separate init function for tsens v2 which calls init_common
> 	and initialize the remaining fields. Reformatted calibrate function
> 	and used hw_ids for sensors to enable.
> 
>   drivers/thermal/qcom/tsens-v2.c | 144 ++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.c    |   2 +-
>   drivers/thermal/qcom/tsens.h    |   3 +
>   3 files changed, 148 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 29a61d2d6ca3..ba74d971fe95 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -6,11 +6,23 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/regmap.h>
> +#include <linux/nvmem-consumer.h>
>   #include "tsens.h"
>   
>   /* ----- SROT ------ */
>   #define SROT_HW_VER_OFF	0x0000
>   #define SROT_CTRL_OFF		0x0004
> +#define SROT_MEASURE_PERIOD	0x0008
> +#define SROT_Sn_CONVERSION	0x0060
> +#define V2_SHIFT_DEFAULT	0x0003
> +#define V2_SLOPE_DEFAULT	0x0cd0
> +#define V2_CZERO_DEFAULT	0x016a
> +#define ONE_PT_SLOPE		0x0cd0
> +#define TWO_PT_SHIFTED_GAIN	921600
> +#define ONE_PT_CZERO_CONST	94
> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
> +#define CONVERSION_SLOPE_SHIFT	10
> +#define CONVERSION_SHIFT_SHIFT	23
>   
>   /* ----- TM ------ */
>   #define TM_INT_EN_OFF			0x0004
> @@ -59,6 +71,11 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>   	/* CTRL_OFF */
>   	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>   	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> +
> +	/* MAIN_MEASURE_PERIOD */
> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>   
>   	/* ----- TM ------ */
>   	/* INTERRUPT ENABLE */
> @@ -104,6 +121,133 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>   };
>   
> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
> +{
> +	u32 slope, czero, val;
> +	char name[15];
> +	int ret;
> +
> +	/* Read offset value */
> +	ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Based on calib mode, program SHIFT, SLOPE and CZERO */
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
> +
> +		czero = (base0 + sensor->offset - ((base1 - base0) / 3));
> +
> +		val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
> +		      (slope << CONVERSION_SLOPE_SHIFT) | czero;
> +
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
> +
> +		val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
> +		      (ONE_PT_SLOPE << CONVERSION_SLOPE_SHIFT) | czero;
> +
> +		break;
> +	default:
> +		dev_dbg(dev, "calibrationless mode\n");
> +
> +		val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
> +		      (V2_SLOPE_DEFAULT << CONVERSION_SLOPE_SHIFT) | V2_CZERO_DEFAULT;
> +	}
> +
> +	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
> +
> +	return 0;
> +}
> +
> +static int tsens_v2_calibration(struct tsens_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	u32 mode, base0, base1;
> +	int i, ret;
> +
> +	if (priv->num_sensors > MAX_SENSORS)
> +		return -EINVAL;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> +	if (ret == -ENOENT)
> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Calibrate each sensor */
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
> +						mode, base0, base1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init init_tsens_v2(struct tsens_priv *priv)
> +{
> +	int i, ret;
> +	u32 val = 0;
> +	struct device *dev = priv->dev;
> +
> +	ret = init_common(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (priv->feat->ver_major != VER_2_X_NO_RPM)
> +		return 0;

No need to, you can rename the function to init_tsens_v2_no_rpm(h?) and 
use it just for non-rpm platforms.

> +
> +	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
> +							 priv->fields[CODE_OR_TEMP]);
> +	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
> +		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
> +
> +	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
> +								priv->fields[MAIN_MEASURE_PERIOD]);
> +	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
> +		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
> +
> +	/* Update measure period to 2ms */
> +	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
> +
> +	/* Enable available sensors */
> +	for (i = 0; i < priv->num_sensors; i++)
> +		val |= 1 << priv->sensor[i].hw_id;
> +
> +	regmap_field_write(priv->rf[SENSOR_EN], val);
> +
> +	/* Real temperature format */
> +	regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
> +
> +	/* Enable TSENS */
> +	regmap_field_write(priv->rf[TSENS_EN], 0x1);
> +
> +	return 0;
> +}
> +
>   static const struct tsens_ops ops_generic_v2 = {
>   	.init		= init_common,
>   	.get_temp	= get_temp_tsens_valid,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 98c356acfe98..5d2ad3b155ec 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>   	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>   	if (ret)
>   		goto err_put_device;
> -	if (!enabled) {
> +	if (!enabled && !VER_2_X_NO_RPM) {

You probably meant something else here. `!const' is going to evaluate to 
false.

>   		dev_err(dev, "%s: device not enabled\n", __func__);
>   		ret = -ENODEV;
>   		goto err_put_device;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2805de1c6827..b2e8f0f2b466 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -35,6 +35,7 @@ enum tsens_ver {
>   	VER_0_1,
>   	VER_1_X,
>   	VER_2_X,
> +	VER_2_X_NO_RPM,
>   };
>   
>   enum tsens_irq_type {
> @@ -168,6 +169,8 @@ enum regfield_ids {
>   	TSENS_SW_RST,
>   	SENSOR_EN,
>   	CODE_OR_TEMP,
> +	/* MEASURE_PERIOD */
> +	MAIN_MEASURE_PERIOD,
>   
>   	/* ----- TM ------ */
>   	/* TRDY */

-- 
With best wishes
Dmitry

