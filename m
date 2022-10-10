Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901E5F9C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJJKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJJKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:01:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5815FF4;
        Mon, 10 Oct 2022 03:01:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A9jdNf006181;
        Mon, 10 Oct 2022 10:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=npEuDkOu2+XMfWr9vYuT3TuQkVLOJYCgmNc13h/J9ow=;
 b=JBY++6m0PFzwtc7VaqiG0mgApcGT4+lltFVdEc1xzzVTt5scRALFYPotx8quWjg1UKxB
 L9tlKcrpgWZV1ROUh/1GCgYa9qu5Ny7NMSsR9TxMq0S0QN+Y8kn/SL+aNpvUdWpI98Qa
 WREQBNaj7lqvkqCi40g8CYMwyieqJVQJQbRlkDgzhmyNd75J5YHm1jmkfIw39zg0I9KB
 jbxIPiSaMA82PKw9qWlLopVR/fPpF6rTdOP2mncqpZK2HRmhEfFyXiMmL6Wl83KgmNuL
 w5wQsaPb3z9Yhhvpzf6BH4gSwz8xg5dw4GPEUlUQGn55z8nIdHiPHw0dlqgcPcAl9F5q Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31ghbjj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 10:01:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29AA11HL028071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 10:01:01 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 03:00:59 -0700
Message-ID: <029efa02-a983-1c71-d5d5-e3e501c044be@quicinc.com>
Date:   Mon, 10 Oct 2022 18:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: Re: [PATCH v2 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-2-quic_fenglinw@quicinc.com>
 <5b326c52-90e4-6779-8b76-6137309c6f20@linaro.org>
Content-Language: en-US
In-Reply-To: <5b326c52-90e4-6779-8b76-6137309c6f20@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mxsViNjD1XI5kbtWYpCwcnnnPUPytMEw
X-Proofpoint-ORIG-GUID: mxsViNjD1XI5kbtWYpCwcnnnPUPytMEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100060
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 20:23, Krzysztof Kozlowski wrote:
> On 29/09/2022 14:15, Fenglin Wu wrote:
>> Add initial driver to support flash LED module found in Qualcomm
>> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
>> and each channel can be controlled indepedently and support full scale
>> current up to 1.5 A. It also supports connecting two channels together
>> to supply one LED component with full scale current up to 2 A. In that
>> case, the current will be split on each channel symmetrically and the
>> channels will be enabled and disabled at the same time.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   drivers/leds/flash/Kconfig           |  14 +
>>   drivers/leds/flash/Makefile          |   1 +
>>   drivers/leds/flash/leds-qcom-flash.c | 707 +++++++++++++++++++++++++++
>>   3 files changed, 722 insertions(+)
>>   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
>>
>> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
>> index d3eb689b193c..92773fa872dc 100644
>> --- a/drivers/leds/flash/Kconfig
>> +++ b/drivers/leds/flash/Kconfig
>> @@ -61,6 +61,20 @@ config LEDS_MT6360
>>   	  Independent current sources supply for each flash LED support torch
>>   	  and strobe mode.
>>   
>> +config LEDS_QCOM_FLASH
>> +	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
>> +	depends on MFD_SPMI_PMIC
> 
> || COMPILE_TEST
> 
> (and actually test it, e.g. you might need here "select REGMAP")
> 
I will add "COMPILE_TEST" here and compile with with "COMPILE_TEST" enabled.
>> +	depends on LEDS_CLASS && OF
>> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> +	help
>> +	  This option enables support for the flash module found in Qualcomm
>> +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
>> +	  channels and each channel is programmable to support up to 1.5 A full
>> +	  scale current. It also supports connecting two channels' output together
>> +	  to supply one LED component to achieve current up to 2 A. In such case,
>> +	  the total LED current will be split symmetrically on each channel and
>> +	  they will be enabled/disabled at the same time.
>> +
> 
>>   config LEDS_RT4505
>>   	tristate "LED support for RT4505 flashlight controller"
>>   	depends on I2C && OF
>> diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
>> index 0acbddc0b91b..8a60993f1a25 100644
>> --- a/drivers/leds/flash/Makefile
>> +++ b/drivers/leds/flash/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)	+= leds-as3645a.o
>>   obj-$(CONFIG_LEDS_KTD2692)	+= leds-ktd2692.o
>>   obj-$(CONFIG_LEDS_LM3601X)	+= leds-lm3601x.o
>>   obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
>> +obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
>>   obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
>>   obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
>>   obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
>> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
>> new file mode 100644
>> index 000000000000..7b941eb769fe
>> --- /dev/null
>> +++ b/drivers/leds/flash/leds-qcom-flash.c
>> @@ -0,0 +1,707 @@
>> +//SPDX-License-Identifier: GPL-2.0-only
> 
> Missing space after //
Thanks for catching it, will fix it.
> 
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/leds.h>
>> +#include <linux/led-class-flash.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <media/v4l2-flash-led-class.h>
>> +
>> +/* registers definitions */
>> +#define FLASH_TYPE_REG			0x04
>> +#define FLASH_TYPE_VAL			0x18
>> +
>> +#define FLASH_SUBTYPE_REG		0x05
>> +#define FLASH_SUBTYPE_3CH_VAL		0x04
>> +#define FLASH_SUBTYPE_4CH_VAL		0x07
>> +
>> +#define FLASH_MODULE_EN_BIT		BIT(7)
>> +
>> +#define FLASH_TIMER_EN_BIT		BIT(7)
>> +#define FLASH_TIMER_VAL_MASK		GENMASK(6, 0)
>> +#define FLASH_TIMER_STEP_MS		10
>> +
>> +#define FLASH_ITARGET_CURRENT_MASK	GENMASK(6, 0)
>> +
>> +#define FLASH_STROBE_HW_SW_SEL_BIT	BIT(2)
>> +#define SW_STROBE_VAL			0
>> +#define HW_STROBE_VAL			1
>> +#define FLASH_HW_STROBE_TRIGGER_SEL_BIT	BIT(1)
>> +#define STROBE_LEVEL_TRIGGER_VAL	0
>> +#define STROBE_EDGE_TRIGGER_VAL		1
>> +#define FLASH_STROBE_POLARITY_BIT	BIT(0)
>> +#define STROBE_ACTIVE_HIGH_VAL		1
>> +
>> +#define FLASH_IRES_MASK_4CH		BIT(0)
>> +#define FLASH_IRES_MASK_3CH		GENMASK(1, 0)
>> +#define FLASH_IRES_12P5MA_VAL		0
>> +#define FLASH_IRES_5MA_VAL_4CH		1
>> +#define FLASH_IRES_5MA_VAL_3CH		3
>> +
>> +/* constants */
>> +#define FLASH_CURRENT_MAX_UA		1500000
>> +#define TORCH_CURRENT_MAX_UA		500000
>> +#define FLASH_TOTAL_CURRENT_MAX_UA	2000000
>> +#define FLASH_CURRENT_DEFAULT_UA	1000000
>> +#define TORCH_CURRENT_DEFAULT_UA	200000
>> +
>> +#define TORCH_IRES_UA			5000
>> +#define FLASH_IRES_UA			12500
>> +
>> +#define FLASH_TIMEOUT_MAX_US		1280000
>> +#define FLASH_TIMEOUT_STEP_US		10000
>> +
>> +enum hw_type {
>> +	QCOM_MVFLASH_3CH,
>> +	QCOM_MVFLASH_4CH,
>> +};
>> +
>> +enum led_mode {
>> +	FLASH_MODE,
>> +	TORCH_MODE,
>> +};
>> +
>> +enum led_strobe {
>> +	SW_STROBE,
>> +	HW_STROBE,
>> +};
>> +
>> +struct qcom_flash_reg {
>> +	u8 module_en;
>> +	u8 chan_timer;
>> +	u8 itarget;
>> +	u8 iresolution;
>> +	u8 chan_strobe;
>> +	u8 chan_en;
>> +	u8 status1;
>> +	u8 status2;
>> +	u8 status3;
>> +};
>> +
>> +struct qcom_flash_led {
>> +	struct qcom_flash_chip		*chip;
>> +	struct led_classdev_flash	flash;
>> +	struct v4l2_flash		*v4l2_flash;
>> +	u32				max_flash_current_ma;
>> +	u32				max_torch_current_ma;
>> +	u32				max_timeout_ms;
>> +	u32				flash_current_ma;
>> +	u32				flash_timeout_ms;
>> +	u8				*chan_id;
>> +	u8				chan_count;
>> +	bool				enabled;
>> +};
>> +
>> +struct qcom_flash_chip {
>> +	struct qcom_flash_led		*leds;
>> +	const struct qcom_flash_reg	*reg;
>> +	struct device			*dev;
>> +	struct regmap			*regmap;
>> +	struct mutex			lock;
>> +	enum hw_type			hw_type;
>> +	u32				reg_base;
>> +	u8				leds_count;
>> +	u8				max_channels;
>> +	u8				chan_en_bits;
>> +};
>> +
>> +static const struct qcom_flash_reg mvflash_3ch_reg = {
>> +	.chan_timer	= 0x40,
>> +	.itarget	= 0x43,
>> +	.module_en	= 0x46,
>> +	.iresolution	= 0x47,
>> +	.chan_strobe	= 0x49,
>> +	.chan_en	= 0x4c,
>> +	.status1	= 0x08,
>> +	.status2	= 0x09,
>> +	.status3	= 0x0a,
>> +};
>> +
>> +static const struct qcom_flash_reg mvflash_4ch_reg = {
>> +	.chan_timer	= 0x3e,
>> +	.itarget	= 0x42,
>> +	.module_en	= 0x46,
>> +	.iresolution	= 0x49,
>> +	.chan_strobe	= 0x4a,
>> +	.chan_en	= 0x4e,
>> +	.status1	= 0x06,
>> +	.status2	= 0x07,
>> +	.status3	= 0x09,
> 
> Don't reinvent the wheel. Use regmap fields.
> 

Do you mean defining regmap_filed pointer in struct qcom_flash_chip
for all these registers instead of creating the data structure 
qcom_flash_reg to include all the registers? Similar like this

struct qcom_flash_chip {
	....
         struct regmap_field     *chan_timer;
         struct regmap_field     *chan_timer;
         struct regmap_field     *itarget;
         struct regmap_field     *iresolution;
         struct regmap_field     *chan_strobe;
         struct regmap_field     *chan_en;
         struct regmap_field     *status1;
         struct regmap_field     *status2;
         struct regmap_field     *status3;
	....
};

This won't make the code cleaner actually. If this is the preferred way, 
I will update it accordingly.
Thanks


>> +};
>> +
>> +static int __set_flash_module_en(struct qcom_flash_led *led, bool en)
> 
> Drop __ prefix here and in other functions.
> 
> (...)
Done
> 
>> +
>> +static int qcom_flash_led_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_flash_chip *chip = platform_get_drvdata(pdev);
>> +
>> +	while (chip->leds_count--)
>> +		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
>> +
>> +	mutex_destroy(&chip->lock);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_flash_led_match_table[] = {
>> +	{ .compatible = "qcom,spmi-flash-led" },
> 
> Only this one is needed. Remove the rest:
Done
> 
>> +	{ .compatible = "qcom,pm8150c-flash-led" },
>> +	{ .compatible = "qcom,pm8150l-flash-led" },
>> +	{ .compatible = "qcom,pm8350c-flash-led" },
> 
> 
> 
> Best regards,
> Krzysztof
> 
