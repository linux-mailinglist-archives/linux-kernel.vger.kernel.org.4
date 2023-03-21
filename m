Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D146C269D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCUA6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:57:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3430299
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:57:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bi9so17149540lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679360275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QQdv0je5amo1Cq/oKaE0BYeIx+5NHEzCllldmhnRkA=;
        b=Sv5/kJ7JjO/+KR/2+5I2oRGcDtHD1zZyIh6guCTdrRzJ+t2sK/7lOsblXgxhnrT4Wg
         QE+EBDpSgpWZvTtBAJlJwRJNS1i01GGk5tMUnPJdXT2HlCEWD/H7qHI8kunxFbtSNAVG
         dU9xeWyu/UMMxBH45ZPk8R3it1MnWXgplHfTAuiIq3lYNxej5yIHlBBrj6cLckLUPX8+
         lNyhYUgE6md03W6TjCy0U9o0+W8ZCEQBYdiflHiwrn/Wjjzw5eufP/+DqYpMtKVP6aTJ
         WJJjgMI1mCYn874Eecyqomc/pJnPoS/bsW0Eh3Y5fE+eUkmuXyahv9Pb63gJTCq80d4J
         j6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679360275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QQdv0je5amo1Cq/oKaE0BYeIx+5NHEzCllldmhnRkA=;
        b=bnz7XPv6gsIY49otaUbDasal1DpfTzBqXxUARtDpnHAxfIiKe1Wkfu27cwLCHfOSQg
         kln7ng5xC6Vcr2Xi5WeBg7hxMG+co7b+E6kJzi52qcTz+ryEXp1/DUInbnz+GZtoXF1s
         SKBNI6UBLrdAfEcvzk1381zu1Rv6gbb6C0F++TaUt0zlv4kz2fS5gILgf4k0ZHngUSQp
         NaYCD/re4xY5/s52dUmWf8yF8mM+DuYzefF1HdVY/aReR0cVMMmbYOQm+xkjjvDoT35W
         Md/AUUUlIjxcy43zruzLvdgq8fwGTxO+ybe+EWUiAM6t7VKpwNt8pfclKItjJfMJgcVp
         U6xg==
X-Gm-Message-State: AO0yUKXhtGLY4AtsW9Q95V7kIVEJl1y+5noNr38JPb/jWsy3kzlpfOiO
        G1ip46TuRLM0U2Qk5qZYWBvV3w==
X-Google-Smtp-Source: AK7set+/moO/EhNXfUSGHTpDEIfpltuj+gV8kcRXMkwAT/Z6crxiXVSmrm6xJkRykoS8kJXuWTjAiQ==
X-Received: by 2002:a19:a410:0:b0:4de:f972:6aa with SMTP id q16-20020a19a410000000b004def97206aamr294802lfc.4.1679360275333;
        Mon, 20 Mar 2023 17:57:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f1-20020ac251a1000000b004e95f1c9e7dsm1919893lfk.78.2023.03.20.17.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 17:57:54 -0700 (PDT)
Message-ID: <b396c5ed-5453-8755-c2f0-8fbd79fad2ba@linaro.org>
Date:   Tue, 21 Mar 2023 02:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH v3 1/3] thermal: qcom-spmi-temp-alarm: enable stage
 2 shutdown when required
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
 <57466b092dd16ed2a25e5a472dfd0b856a5cca00.1674602698.git.quic_collinsd@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <57466b092dd16ed2a25e5a472dfd0b856a5cca00.1674602698.git.quic_collinsd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 01:46, David Collins wrote:
> Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> stage 2 automatic PMIC partial shutdown to be enabled in order to
> avoid repeated faults in the event of reaching over-temperature
> stage 3.  Modify the stage 2 shutdown control logic to ensure that
> stage 2 shutdown is enabled on all affected PMICs.  Read the
> digital major and minor revision registers to identify these
> PMICs.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> ---
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index ad84978109e6..e2e52703ac4d 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/bitops.h>
> @@ -18,6 +19,7 @@
>   #include "../thermal_core.h"
>   #include "../thermal_hwmon.h"
>   
> +#define QPNP_TM_REG_DIG_MINOR		0x00
>   #define QPNP_TM_REG_DIG_MAJOR		0x01
>   #define QPNP_TM_REG_TYPE		0x04
>   #define QPNP_TM_REG_SUBTYPE		0x05
> @@ -73,6 +75,7 @@ struct qpnp_tm_chip {
>   	struct device			*dev;
>   	struct thermal_zone_device	*tz_dev;
>   	unsigned int			subtype;
> +	unsigned int			dig_revision;
>   	long				temp;
>   	unsigned int			thresh;
>   	unsigned int			stage;
> @@ -224,6 +227,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>   	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
>   	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
>   	bool disable_s2_shutdown = false;
> +	bool require_s2_shutdown = false;
>   	u8 reg;
>   
>   	WARN_ON(!mutex_is_locked(&chip->lock));
> @@ -256,9 +260,25 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>   				 temp, stage2_threshold_max, stage2_threshold_max);
>   	}
>   
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
> +		/*
> +		 * Check if stage 2 automatic partial shutdown must remain
> +		 * enabled to avoid potential repeated faults upon reaching
> +		 * over-temperature stage 3.
> +		 */
> +		switch (chip->dig_revision) {
> +		case 0x0001:
> +		case 0x0002:
> +		case 0x0100:
> +		case 0x0101:
> +			require_s2_shutdown = true;
> +			break;
> +		}
> +	}

Please move this switch to _probe and set chip->require_s2_shutdown instead.

> +
>   skip:
>   	reg |= chip->thresh;
> -	if (disable_s2_shutdown)
> +	if (disable_s2_shutdown && !require_s2_shutdown)
>   		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
>   
>   	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> @@ -373,7 +393,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   {
>   	struct qpnp_tm_chip *chip;
>   	struct device_node *node;
> -	u8 type, subtype, dig_major;
> +	u8 type, subtype, dig_major, dig_minor;
>   	u32 res;
>   	int ret, irq;
>   
> @@ -429,6 +449,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read dig_minor\n");
> +		return ret;
> +	}
> +
> +	chip->dig_revision = (dig_major << 8) | dig_minor;
> +
>   	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
>   				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
>   		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",

-- 
With best wishes
Dmitry

