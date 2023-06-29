Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0A741D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjF2AtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjF2AtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:49:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA31BD1;
        Wed, 28 Jun 2023 17:49:03 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0f28k019868;
        Thu, 29 Jun 2023 00:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W5fp75G0iHsqRCVJ/GEMsW47DwwGAHPrqIBlWc8o+Rw=;
 b=G4LN6SEFk9P7ibKMdyTemW7qJL2jYECx99V5Lo/x3pKSr9HibnWrcs6kkc9YVrieqGYQ
 HhrJrwqrW1foRHObJ8iuiiRFMeRdka4guaiM3FrvYGulMqXa64Jeor2E2lB+wHK5E8cu
 N1Vmo64itwZ9sql5AQGm5/vSSxTSP+Q1Q6EzMqMFMSIop97YEJHViGnP3AHIj2X/dHhf
 aMfXe7ZSwjfo1RWXRzk2m5CLqStyyJsMRh5BtfQNnSnU5DOozbnNTunHN4HiurkLd+XT
 UdZKHexqQASAqlHfQ26ruQecIve6DTFRor67y7vZIlu7Ml8w7GPRIAK7Esr5xnICloL+ Jg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgbfstjr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 00:48:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T0moJ6002374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 00:48:50 GMT
Received: from [10.110.20.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 17:48:49 -0700
Message-ID: <16668207-b25c-f485-3d4c-94666bc8fb0f@quicinc.com>
Date:   Wed, 28 Jun 2023 17:48:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-4-quic_amelende@quicinc.com>
 <42126265-75b6-83be-c3aa-ee2a16cb26dd@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <42126265-75b6-83be-c3aa-ee2a16cb26dd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: naV8397F5Kad01DmHtl8VjW17Qnm2GaM
X-Proofpoint-ORIG-GUID: naV8397F5Kad01DmHtl8VjW17Qnm2GaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290005
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 2:55 AM, Krzysztof Kozlowski wrote:
> On 21/06/2023 20:59, Anjelique Melendez wrote:
>> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
>> driver supports configuring software PBS trigger events through PBS RAM
>> on Qualcomm Technologies, Inc (QTI) PMICs.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/soc/qcom/Kconfig          |   9 +
>>  drivers/soc/qcom/Makefile         |   1 +
>>  drivers/soc/qcom/qcom-pbs.c       | 343 ++++++++++++++++++++++++++++++
>>  include/linux/soc/qcom/qcom-pbs.h |  36 ++++
>>  4 files changed, 389 insertions(+)
>>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a491718f8064..226b668f4690 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -260,6 +260,15 @@ config QCOM_APR
>>  	  used by audio driver to configure QDSP6
>>  	  ASM, ADM and AFE modules.
>>  
>> +config QCOM_PBS
>> +	tristate "PBS trigger support for Qualcomm PMIC"
>> +	depends on SPMI
>> +	help
>> +	  This driver supports configuring software programmable boot sequencer (PBS)
>> +	  trigger event through PBS RAM on Qualcomm Technologies, Inc. PMICs.
>> +	  This module provides the APIs to the client drivers that wants to send the
>> +	  PBS trigger event to the PBS RAM.
>> +
>>  config QCOM_ICC_BWMON
>>  	tristate "QCOM Interconnect Bandwidth Monitor driver"
>>  	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 0f43a88b4894..4e154af3877a 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -31,5 +31,6 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>  obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>> +obj-$(CONFIG_QCOM_PBS) += qcom-pbs.o
>>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
>> diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
>> new file mode 100644
>> index 000000000000..4a2bb7ff8031
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom-pbs.c
>> @@ -0,0 +1,343 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt)	"PBS: %s: " fmt, __func__
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spmi.h>
>> +#include <linux/soc/qcom/qcom-pbs.h>
>> +
>> +#define PBS_CLIENT_TRIG_CTL		0x42
>> +#define PBS_CLIENT_SW_TRIG_BIT		BIT(7)
>> +#define PBS_CLIENT_SCRATCH1		0x50
>> +#define PBS_CLIENT_SCRATCH2		0x51
>> +
>> +static LIST_HEAD(pbs_dev_list);
>> +static DEFINE_MUTEX(pbs_list_lock);
> 
> No file-scope variables. Drop both. You don't even need it.
Ack
> 
>> +
>> +struct pbs_dev {
>> +	struct device		*dev;
>> +	struct device_node	*dev_node;
>> +	struct regmap		*regmap;
>> +	struct mutex		lock;
>> +	struct list_head	link;
>> +
>> +	u32			base;
>> +};
>> +
>> +static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
>> +{
>> +	int ret;
>> +
>> +	address += pbs->base;
>> +	ret = regmap_bulk_read(pbs->regmap, address, val, 1);
>> +	if (ret)
>> +		pr_err("Failed to read address=%#x sid=%#x ret=%d\n",
> 
> dev_err
Ack
> 
>> +			address, to_spmi_device(pbs->dev->parent)->usid, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_pbs_write(struct pbs_dev *pbs, u16 address, u8 val)
>> +{
>> +	int ret;
>> +
>> +	address += pbs->base;
>> +	ret = regmap_bulk_write(pbs->regmap, address, &val, 1);
>> +	if (ret < 0)
>> +		pr_err("Failed to write address=%#x sid=%#x ret=%d\n",
>> +			  address, to_spmi_device(pbs->dev->parent)->usid, ret);
>> +	else
>> +		pr_debug("Wrote %#x to addr %#x\n", val, address);
> 
> No, there is regmap debug for this. Drop such debug statements from the
> driver.
Ack
> 
> Actually the error print is also wrong, IMO> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_pbs_masked_write(struct pbs_dev *pbs, u16 address, u8 mask, u8 val)
>> +{
>> +	int ret;
>> +
>> +	address += pbs->base;
>> +	ret = regmap_update_bits(pbs->regmap, address, mask, val);
>> +	if (ret < 0)
>> +		pr_err("Failed to write address=%#x ret=%d\n", address, ret);
>> +	else
>> +		pr_debug("Wrote %#x to addr %#x\n", val, address);
> 
> Drop
Ack
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
>> +{
>> +	u16 retries = 2000, delay = 1000;
>> +	int ret;
>> +	u8 val;
>> +
>> +	while (retries--) {
>> +		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (val == 0xFF) {
>> +			/* PBS error - clear SCRATCH2 register */
>> +			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			pr_err("NACK from PBS for bit %u\n", bit_pos);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (val & BIT(bit_pos)) {
>> +			pr_debug("PBS sequence for bit %u executed!\n", bit_pos);
> 
> dev_dbg
Ack
> 
>> +			break;
>> +		}
>> +
>> +		usleep_range(delay, delay + 100);
>> +	}
>> +
>> +	if (!retries) {
>> +		pr_err("Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
> 
> dev_err
Ack
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_pbs_trigger_single_event() - Trigger PBS sequence without using bitmap.
>> + * @pbs: Pointer to PBS device
>> + *
>> + * This function is used to trigger the PBS that is hooked on the
>> + * SW_TRIGGER directly in PBS client.
>> + *
>> + * Return: 0 on success, < 0 on failure
>> + */
>> +int qcom_pbs_trigger_single_event(struct pbs_dev *pbs)
>> +{
>> +	int ret = 0;
>> +
>> +	if (IS_ERR_OR_NULL(pbs))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pbs->lock);
>> +	ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_TRIG_CTL, PBS_CLIENT_SW_TRIG_BIT,
>> +				PBS_CLIENT_SW_TRIG_BIT);
>> +	if (ret < 0)
>> +		pr_err("Failed to write register %x ret=%d\n", PBS_CLIENT_TRIG_CTL, ret);
> 
> dev_* everywhere
Ack
> 
>> +	mutex_unlock(&pbs->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(qcom_pbs_trigger_single_event);
>> +
> 
> ...
qcom_pbs_trigger_single_event() is used in our downstream haptics driver,
will remove for now and add it back when haptics driver get upstreamed
> 
>> +/**
>> + * get_pbs_client_device() - Get the PBS device used by client
>> + * @dev: Client device
>> + *
>> + * This function is used to get the PBS device that is being
>> + * used by the client.
>> + *
>> + * Returns: pbs_dev on success, ERR_PTR on failure
>> + */
>> +struct pbs_dev *get_pbs_client_device(struct device *dev)
>> +{
>> +	struct device_node *pbs_dev_node;
>> +	struct pbs_dev *pbs;
>> +
>> +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs-client", 0);
>> +	if (!pbs_dev_node) {
>> +		pr_err("Missing qcom,pbs-client property\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	mutex_lock(&pbs_list_lock);
>> +	list_for_each_entry(pbs, &pbs_dev_list, link) {
> 
> It does not make sense. You have the reference to the device, so you
> have the pbs (via container_of). Don't add some
> global-list-lookup-functions.
> 
> Look for example at Abel Vesa's ICE patchset.
> 
>> +		if (pbs_dev_node == pbs->dev_node) {
>> +			of_node_put(pbs_dev_node);
>> +			mutex_unlock(&pbs_list_lock);
>> +			return pbs;
>> +		}
>> +	}
>> +	mutex_unlock(&pbs_list_lock);
> 
> Where is device_link handling?
Thank you for pointing me to Abel's ICE patchset! Will be updating patch to
use container_of as well as having device_link_add().
> 
>> +
>> +	pr_debug("Unable to find PBS dev_node\n");
>> +	of_node_put(pbs_dev_node);
>> +	return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +EXPORT_SYMBOL(get_pbs_client_device);
>> +
>> +static int qcom_pbs_probe(struct platform_device *pdev)
>> +{
>> +	struct pbs_dev *pbs;
>> +	u32 val;
>> +	int ret;
>> +
>> +	pbs = devm_kzalloc(&pdev->dev, sizeof(*pbs), GFP_KERNEL);
>> +	if (!pbs)
>> +		return -ENOMEM;
>> +
>> +	pbs->dev = &pdev->dev;
>> +	pbs->dev_node = pdev->dev.of_node;
> 
> Why do you need to store it?
Ack - removing storing dev_node
> 
>> +	pbs->regmap = dev_get_regmap(pbs->dev->parent, NULL);
>> +	if (!pbs->regmap) {
>> +		dev_err(pbs->dev, "Couldn't get parent's regmap\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = device_property_read_u32(pbs->dev, "reg", &val);
>> +	if (ret < 0) {
>> +		dev_err(pbs->dev, "Couldn't find reg, ret = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pbs->base = val;
>> +	mutex_init(&pbs->lock);
>> +
>> +	platform_set_drvdata(pdev, pbs);
>> +
>> +	mutex_lock(&pbs_list_lock);
>> +	list_add(&pbs->link, &pbs_dev_list);
>> +	mutex_unlock(&pbs_list_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_pbs_remove(struct platform_device *pdev)
>> +{
>> +	struct pbs_dev *pbs = platform_get_drvdata(pdev);
>> +
>> +	mutex_lock(&pbs_list_lock);
>> +	list_del(&pbs->link);
>> +	mutex_unlock(&pbs_list_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_pbs_match_table[] = {
>> +	{ .compatible = "qcom,pbs" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_pbs_match_table);
>> +
>> +static struct platform_driver qcom_pbs_driver = {
>> +	.driver = {
>> +		.name		= "qcom-pbs",
>> +		.of_match_table	= qcom_pbs_match_table,
>> +	},
>> +	.probe = qcom_pbs_probe,
>> +	.remove = qcom_pbs_remove,
>> +};
>> +module_platform_driver(qcom_pbs_driver)
>> +
>> +MODULE_DESCRIPTION("QCOM PBS DRIVER");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:qcom-pbs");
> 
> Drop alias. Not needed. If you need it, you have missing ID table.
Ack
> 
>> diff --git a/include/linux/soc/qcom/qcom-pbs.h b/include/linux/soc/qcom/qcom-pbs.h
>> new file mode 100644
>> index 000000000000..4b065951686a
>> --- /dev/null
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Anjelque
