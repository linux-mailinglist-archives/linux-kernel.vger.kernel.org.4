Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0C73F784
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjF0Ihn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjF0IhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:37:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0630F8;
        Tue, 27 Jun 2023 01:36:08 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R7uLnO004161;
        Tue, 27 Jun 2023 08:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=scRnmZdC3LxLJQfNHangg3IyZBFzbHCuY7++fQr/ZVY=;
 b=Y4hB2h7P3J3g78yB3sSFu9MzsD2KsoZJlDb4I1eYDTz4vNoxRk9tvWF9u9t608DKUpUV
 cXD5QomPvudB5IK9zeDoJQXqUIYzMQR3QjPNM4D2iuwivMFXyj9leoIcp79wRokAItvs
 IEuWN/pZCPn319+IwrIehgqHIhAYQI5r3MaK+Kh6jyhk/548mVpGT/PcbYElIM57Hfpf
 X+DX1LTpQ6DNvIN3qx9FbYsBrqG21iaQr1yHyQ775vlwgqQpy4XK63VhKELtVm1qYPCz
 CDIW3OMb//5IN52pqwMAkhUzYnmBBicvst0L+jA9t9R/pRAs0hwmJTEBNBismfx4Nm67 aw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfc0da0r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 08:35:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35R8ZKFZ029935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 08:35:21 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 01:34:54 -0700
Message-ID: <bf9d701e-a9ec-9f1d-efe9-e37f9b18fc1a@quicinc.com>
Date:   Tue, 27 Jun 2023 14:04:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support.
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-4-quic_kbajaj@quicinc.com>
 <ea4c49cd-17d1-6921-a447-5debaebb0cfd@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <ea4c49cd-17d1-6921-a447-5debaebb0cfd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pie6Hivk_wywL97nGjLGr3U0_l8W4grK
X-Proofpoint-ORIG-GUID: pie6Hivk_wywL97nGjLGr3U0_l8W4grK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270081
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 8:23 PM, Konrad Dybcio wrote:
> On 23.06.2023 16:18, Komal Bajaj wrote:
>> For some of the Qualcomm SoC's, it is possible that
>> some of the fuse regions or entire qfprom region is
>> protected from non-secure access. In such situations,
>> linux will have to use secure calls to read the region.
>> With that motivation, add secure qfprom driver. Ensuring
>> the address to read is word aligned since our secure I/O
>> only supports word size I/O.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/nvmem/Kconfig      |  12 ++++
>>   drivers/nvmem/Makefile     |   2 +
>>   drivers/nvmem/sec-qfprom.c | 116 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 130 insertions(+)
>>   create mode 100644 drivers/nvmem/sec-qfprom.c
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index b291b27048c7..2b0dd73d899e 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -216,6 +216,18 @@ config NVMEM_QCOM_QFPROM
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called nvmem_qfprom.
>>   
>> +config NVMEM_QCOM_SEC_QFPROM
>> +        tristate "QCOM SECURE QFPROM Support"
>> +        depends on ARCH_QCOM || COMPILE_TEST
>> +        depends on HAS_IOMEM
>> +        select QCOM_SCM
> You also need OF

Noted.

>
>> +        help
>> +          Say y here to enable secure QFPROM support. The secure QFPROM provides access
>> +          functions for QFPROM data to rest of the drivers via nvmem interface.
>> +
>> +          This driver can also be built as a module. If so, the module will be called
>> +          nvmem_sec_qfprom.
>> +
>>   config NVMEM_RAVE_SP_EEPROM
>>   	tristate "Rave SP EEPROM Support"
>>   	depends on RAVE_SP_CORE
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index f82431ec8aef..4b4bf5880488 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
>>   nvmem-nintendo-otp-y			:= nintendo-otp.o
>>   obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
>>   nvmem_qfprom-y				:= qfprom.o
>> +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)     += nvmem_sec_qfprom.o
>> +nvmem_sec_qfprom-y                          := sec-qfprom.o
>>   obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>>   nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
>>   obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
>> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
>> new file mode 100644
>> index 000000000000..47b2c71593dd
>> --- /dev/null
>> +++ b/drivers/nvmem/sec-qfprom.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/property.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +
>> +/**
>> + * struct sec_sec_qfprom_priv - structure holding secure qfprom attributes
>> + *
>> + * @qfpseccorrected: iomapped memory space for secure qfprom corrected address space.
>> + * @dev: qfprom device structure.
>> + */
>> +struct sec_qfprom_priv {
>> +	phys_addr_t qfpseccorrected;
>> +	struct device *dev;
>> +};
>> +
>> +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
>> +{
>> +	struct sec_qfprom_priv *priv = context;
>> +	u8 *val = _val;
>> +	u8 *tmp;
>> +	u32 read_val;
>> +	unsigned int i;
> Please sort this to look like a reverse-Christmas-tree

Okay, will sort it in that way.

>
>
>> +
>> +	for (i = 0; i < bytes; i++, reg++) {
>> +		if (i == 0 || reg % 4 == 0) {
>> +			if (qcom_scm_io_readl(priv->qfpseccorrected + (reg & ~3), &read_val)) {
>> +				dev_err(priv->dev, "Couldn't access fuse register\n");
>> +				return -EINVAL;
>> +			}
>> +			tmp = (u8 *)&read_val;
>> +		}
> I don't understand this read-4-times dance.. qcom_scm_io_readl() reads
> u32, so this should be as simple as:
>
> val[i + 0] = FIELD_GET(GENMASK(7, 0), reg);
> val[i + 1] = ..
> val[i + 2] = ..
> val[i + 3] = ..

Won't it get too complex, I type-casted 32-bit read_val into u8 pointer, 
so that I can
easily use it for the byte-level access of read_val's value.

Doing the way that you mentioned would be something like below -
val[i] = FIELD_GET(GENMASK((reg&3)*8+7, (reg&3)*8), read_val);

Thanks
Komal
>
>> +
>> +		val[i] = tmp[reg & 3];
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void sec_qfprom_runtime_disable(void *data)
>> +{
>> +	pm_runtime_disable(data);
>> +}
>> +
>> +static int sec_qfprom_probe(struct platform_device *pdev)
>> +{
>> +	struct nvmem_config econfig = {
>> +		.name = "sec-qfprom",
>> +		.stride = 1,
>> +		.word_size = 1,
>> +		.id = NVMEM_DEVID_AUTO,
>> +		.reg_read = sec_qfprom_reg_read,
>> +	};
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	struct nvmem_device *nvmem;
>> +	struct sec_qfprom_priv *priv;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	priv->qfpseccorrected = res->start;
>> +	if (!priv->qfpseccorrected)
>> +		return -ENOMEM;
> While it works all the same, I think checking if(!res) would be more
> logical
>
> Also, ENOMEM seems weird here.. Perhaps EINVAL?
>
>> +
>> +	econfig.size = resource_size(res);
>> +	econfig.dev = dev;
>> +	econfig.priv = priv;
>> +
>> +	priv->dev = dev;
>> +
>> +	pm_runtime_enable(dev);
>> +	ret = devm_add_action_or_reset(dev, sec_qfprom_runtime_disable, dev);
>> +	if (ret)
>> +		return ret;
> Wouldn't devm_pm_runtime_enable() take care of this? Or do we need
> for this block to be always-powered?
>
>> +
>> +	nvmem = devm_nvmem_register(dev, &econfig);
>> +
>> +	return PTR_ERR_OR_ZERO(nvmem);
>> +}
>> +
>> +static const struct of_device_id sec_qfprom_of_match[] = {
>> +	{ .compatible = "qcom,sec-qfprom",},
> The comma inside is unnecessary, replacing it with a space would also
> make the whitespacing match
>
>> +	{/* sentinel */},
>> +};
>> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
>> +
>> +static struct platform_driver qfprom_driver = {
>> +	.probe = sec_qfprom_probe,
>> +	.driver = {
>> +		.name = "qcom,sec_qfprom",
> Commas in driver names are rather.. rare? Let's make it qcom_
>
>> +		.of_match_table = sec_qfprom_of_match,
>> +	},
>> +};
>> +module_platform_driver(qfprom_driver);
>> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
>> +MODULE_LICENSE("GPL v2");
> Please run scripts/checkpatch.pl on your patches before sending.
>
> Konrad

